# !/bin/bash

set -euo pipefail

# Function to generate GitHub link for a given file path
gengitlink() {
    local file_path="$1"

    # Convert relative path to absolute path
    local abs_path
    abs_path=$(realpath "$file_path")

    # Get the Git repository root
    local git_root
    git_root=$(git -C "$(dirname "$abs_path")" rev-parse --show-toplevel 2>/dev/null)
    if [ -z "$git_root" ]; then
        echo "Error: Not a Git repository."
        return 1
    fi

    # Get the relative path of the file within the repository
    local relative_path
    relative_path=$(realpath --relative-to="$git_root" "$abs_path")

    # Get the remote repository URL
    local remote_url
    remote_url=$(git -C "$git_root" remote get-url origin | sed 's/\.git$//')

    # Get the current branch name
    local branch
    branch=$(git -C "$git_root" rev-parse --abbrev-ref HEAD)

    # Construct the standard URL
    local git_url="$remote_url/blob/$branch/$relative_path"

    # Construct the raw URL for images
    local raw_url="$remote_url/raw/$branch/$relative_path"

    # Determine the Markdown format based on file type
    local filename
    filename=$(basename "$file_path")
    local file_extension="${filename##*.}"

    if [[ "$file_extension" =~ ^(png|jpg|jpeg|gif|svg|bmp|webp)$ ]]; then
        echo "![${filename} git link](${raw_url})"
    else
        echo "[${filename} git link](${git_url})"
    fi
}

main() {
    local number=""
    local name=""
    local question=""

    read -rp "Enter Number To Begin with in Folder Name: " number
    read -rp "Enter Problem Name to use as a Folder Name: " name
    read -rp "Enter question: " question

    number=$(printf "%03d" "$number")

    # Replace spaces with hyphens in the folder name
    local folder_name="${number}-${name// /-}"

    # Create the directory
    if mkdir -p "$folder_name"; then
        echo "✅ Created directory: $folder_name"
    else
        echo "❌ Failed to create directory: $folder_name"
        exit 1
    fi

    # Write the question to 01_problem.txt
    if echo "$question" > "$folder_name/01_problem.txt"; then
        echo "✅ Created file: $folder_name/01_problem.txt"
    else
        echo "❌ Failed to create file: $folder_name/01_problem.txt"
        exit 1
    fi

    # List of files to create
    local files=("solution.c" "solution.cpp" "solution.py" "solution.sh" "solution.exp" "solutions.md" "README.md")

    # Create each file and report status
    for file in "${files[@]}"; do
        if touch "$folder_name/$file"; then
            echo "✅ Created file: $folder_name/$file"
        else
            echo "❌ Failed to create file: $folder_name/$file"
            exit 1
        fi
    done

    # Copy generate_solutions_md.sh into the folder
    if cp "generate_solutions_md.sh" "$folder_name/"; then
        echo "✅ Copied generate_solutions_md.sh to $folder_name/"
    else
        echo "❌ Failed to copy generate_solutions_md.sh to $folder_name/"
        exit 1
    fi

    # Generate README.md with GitHub links
    {
        echo "# ${name}"
        echo
        echo "## Problem Statement"
        echo
        echo "$question"
        echo
        echo "## Solutions"
        echo
        for file in "${files[@]}"; do
            if [[ "$file" != "README.md" ]]; then
                local file_path="$folder_name/$file"
                local link
                link=$(gengitlink "$file_path")
                echo "- $link"
            fi
        done
    } > "$folder_name/README.md"

    echo "✅ Generated README.md with GitHub links."
}

main
