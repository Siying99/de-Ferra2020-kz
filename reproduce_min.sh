#!/bin/bash
# reproduce_min.sh - Minimal reproduction for REMARK compliance
#
# This script builds the paper PDF as the minimal reproducible artefact of
# this REMARK. It does NOT run the HAFiscal-template computational branches,
# which are not part of the de Ferra 2020 reproduction.
#
# For the full menu of options, see: ./reproduce.sh --help

set -e

echo "================================================================="
echo "de-Ferra2020-kz Minimal Reproduction"
echo "================================================================="
echo ""
echo "Paper:   Household Heterogeneity and the Transmission of Foreign Shocks"
echo "Authors: Sergio de Ferra, Kurt Mitman, Federica Romei"
echo "Journal: Journal of International Economics, 124, 103303 (2020)"
echo "DOI:     10.1016/j.jinteco.2020.103303"
echo ""
echo "REMARK author: Siying Li (Johns Hopkins University)"
echo ""
echo "This runs the minimal reproducible artefact of the REMARK: compiling"
echo "deFerra2020.pdf from deFerra2020.tex. Expected runtime: under 1 minute"
echo "on a 2024 MacBook Pro M3 (16 GB RAM)."
echo ""
echo "See ./reproduce.sh --help for all reproduction options."
echo ""
echo "================================================================="
echo ""

if [[ ! -f "reproduce.sh" ]]; then
    echo "Error: reproduce.sh not found. Please run from repository root."
    exit 1
fi

if [[ ! -x "reproduce.sh" ]]; then
    chmod +x reproduce.sh
fi

echo "Running: ./reproduce.sh --docs main"
echo ""
./reproduce.sh --docs main

echo ""
echo "================================================================="
echo "Minimal reproduction complete"
echo "================================================================="
echo ""
echo "Primary artefact: deFerra2020.pdf"
echo ""
echo "Next steps:"
echo "  - View logs:              cat reproduce/logs/latest.log"
echo "  - Full docs compile:      ./reproduce.sh --docs all"
echo "  - Environment check:      ./reproduce.sh --envt"
echo ""
