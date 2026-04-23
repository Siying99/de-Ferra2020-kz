#!/bin/bash

echo "=== Batch Table Compilation with Full Terminal Output ==="
echo "Following prompts/always-show-terminal-output.md requirements"
echo "Timestamp: $(date)"
echo

# List of table files (excluding template)
tables=(
    "deFerra2020_tab1_calibration"
)

# Function to get file size safely
get_file_size() {
    local file="$1"
    if [[ -f "$file" ]]; then
        if command -v stat >/dev/null 2>&1; then
            stat -f%z "$file" 2>/dev/null | awk '{
                if ($1 < 1024) print $1 "B"
                else if ($1 < 1048576) printf "%.1fK\n", $1/1024
                else if ($1 < 1073741824) printf "%.1fM\n", $1/1048576
                else printf "%.1fG\n", $1/1073741824
            }' || echo "Unknown"
        else
            du -h "$file" 2>/dev/null | cut -f1 || echo "Unknown"
        fi
    else
        echo "N/A"
    fi
}

success_count=0
total_tables=${#tables[@]}
current_table=1

for table in "${tables[@]}"; do
    echo "================================================================"
    echo "📋 Processing: ${table}.tex (${current_table}/${total_tables})"
    echo "================================================================"
    
    if grep -q "@ifpackageloaded{tex4ht}" "${table}.tex" 2>/dev/null; then
        echo "✓ tex4ht compatibility fix already present"
    else
        echo "⚠️  tex4ht compatibility fix missing"
    fi
    
    echo
    echo "→ PDF compilation:"
    echo "Command: pdflatex -interaction=nonstopmode ${table}.tex"
    
    if pdflatex -interaction=nonstopmode "${table}.tex"; then
        pdf_size=$(get_file_size "${table}.pdf")
        echo "✅ PDF: ${pdf_size}"
    else
        echo "❌ PDF compilation failed"
        echo "Continuing with next table..."
        ((current_table++))
        continue
    fi
    
    echo
    echo "→ HTML compilation:"
    echo "Command: make4ht -u -d . ${table}.tex"
    
    if make4ht -u -d . "${table}.tex"; then
        html_size=$(get_file_size "${table}.html")
        echo "✅ HTML: ${html_size}"
        ((success_count++))
    else
        echo "❌ HTML compilation failed"
    fi
    
    ((current_table++))
    echo
done

echo "================================================================"
echo "🎯 BATCH COMPILATION SUMMARY"
echo "================================================================"
echo "Successfully compiled: ${success_count}/${total_tables} tables"
echo "Timestamp: $(date)"
echo

echo "📊 Generated files:"
for table in "${tables[@]}"; do
    pdf_exists=false
    html_exists=false
    
    if [[ -f "${table}.pdf" ]]; then
        pdf_exists=true
        pdf_size=$(get_file_size "${table}.pdf")
    fi
    
    if [[ -f "${table}.html" ]]; then
        html_exists=true
        html_size=$(get_file_size "${table}.html")
    fi
    
    if [[ "$pdf_exists" == true && "$html_exists" == true ]]; then
        echo "  ✅ ${table}: PDF(${pdf_size}) + HTML(${html_size})"
    elif [[ "$pdf_exists" == true ]]; then
        echo "  ⚠️  ${table}: PDF(${pdf_size}) only"
    else
        echo "  ❌ ${table}: Failed"
    fi
done

echo
echo "=== Batch compilation complete ==="
