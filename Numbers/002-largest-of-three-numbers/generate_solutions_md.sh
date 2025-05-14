#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -euo pipefail

# Check if a folder name is provided as an argument
if [ $# -lt 1 ]; then
    echo "Usage: $0 <folder-name>"
    exit 1
fi

FOLDER="$1"

# Verify that the folder exists and is a directory
if [ ! -d "$FOLDER" ]; then
    echo "❌ Error: Folder '$FOLDER' does not exist or is not a directory."
    exit 1
fi

# Change to the specified directory
cd "$FOLDER" || { echo "❌ Failed to change directory to '$FOLDER'"; exit 1; }

# Output Markdown file
output_file="solutions.md"
> "$output_file"  # Clear the file if it exists

# Include the problem description
if [[ -f "01_problem.txt" ]]; then
    echo "# Problem Description" >> "$output_file"
    echo "" >> "$output_file"
    cat "01_problem.txt" >> "$output_file"
    echo "" >> "$output_file"
    echo "---" >> "$output_file"
    echo "" >> "$output_file"
else
    echo "Warning: '01_problem.txt' not found."
fi

# Function to determine the language based on file extension
get_language() {
    case "$1" in
        *.c) echo "c" ;;
        *.cpp) echo "cpp" ;;
        *.py) echo "python" ;;
        *.sh) echo "bash" ;;
        *.exp) echo "expect" ;;
        *) echo "" ;;
    esac
}

# Function to generate a descriptive title based on the file extension
get_title() {
    case "$1" in
        *.c) echo "Solution in C" ;;
        *.cpp) echo "Solution in C++" ;;
        *.py) echo "Solution in Python" ;;
        *.sh) echo "Solution in Bash" ;;
        *.exp) echo "Solution in Expect" ;;
        *) echo "Solution" ;;
    esac
}

# List of fixed files
files=("solution.c" "solution.cpp" "solution.py" "solution.sh" "solution.exp")

# Iterate over each file
for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
        language=$(get_language "$file")
        title=$(get_title "$file")
        echo "## $title" >> "$output_file"
        echo "" >> "$output_file"
        echo '```'"$language" >> "$output_file"
        cat "$file" >> "$output_file"
        echo '```' >> "$output_file"
        echo "" >> "$output_file"
    else
        echo "Warning: '$file' is not a valid file."
    fi
done

echo "✅ solutions.md has been generated successfully in '$FOLDER'."
