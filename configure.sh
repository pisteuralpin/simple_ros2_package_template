#!/usr/bin/env bash
set -euo pipefail

folders=( "launch" "src" "meshes" "models" "rviz" "urdf" )

# Ask if the folders is needed, else remove it
for folder in "${folders[@]}"; do
    while :; do
        read -rp "Do you need the folder '${folder}'? (y/n): " answer
        case "$answer" in
            [Yy]* )
                echo "Keeping folder '${folder}'."
                break
                ;;
            [Nn]* )
                echo "Removing folder '${folder}'."
                rm -rf "$folder"
                break
                ;;
            * )
                echo "Please answer yes (y) or no (n)."
                ;;
        esac
    done
done

placeholders=( "<?package_name?>" "<?package_version?>" "<?author_name?>" "<?author_email?>" "<?package_license?>" "<?package_description?>" )
questions=( "Package Name" "Package Version" "Author Name" "Author Email" "Package License" "Package Description" )

declare -A replacements

# For each placeholder, ask the user for input and store it
for i in "${!placeholders[@]}"; do
    prompt="${questions[i]}"
    while :; do
        read -rp "Enter value for ${prompt}: " value
        if [[ -n "$value" ]]; then
            replacements["${placeholders[i]}"]="$value"
            break
        fi
        echo "Error: Value for ${prompt} cannot be empty."
    done
done

# Ensure find is available
if ! command -v find >/dev/null 2>&1; then
    echo "find is not available on this machine."
    exit 1
fi

# Collect files in a portable way (works with older bash)
files=()
while IFS= read -r -d '' file; do
    files+=("$file")
done < <(find . -type f ! -path './.git/*' ! -name 'configure.sh' -print0)

# Check if any files were found
if [ ${#files[@]} -eq 0 ]; then
    echo "No matching files found."
    exit 0
fi

# Perform substitution
updated_count=0
for f in "${files[@]}"; do
    # Skip unreadable or unwritable files
    if [ ! -r "$f" ] || [ ! -w "$f" ]; then
        continue
    fi

    changed=false
    for placeholder in "${placeholders[@]}"; do
        replacement="${replacements[$placeholder]:-}"

        # Only attempt replacement if the file contains the placeholder
        if grep -Fq "$placeholder" "$f"; then
            # Escape delimiter and ampersand for sed
            placeholder_esc=$(printf '%s' "$placeholder" | sed -e 's/[\/&]/\\&/g')
            replacement_esc=$(printf '%s' "$replacement" | sed -e 's/[\/&]/\\&/g')

            if sed --version >/dev/null 2>&1; then
                sed -i "s/${placeholder_esc}/${replacement_esc}/g" "$f"
            else
                sed -i '' -e "s/${placeholder_esc}/${replacement_esc}/g" "$f"
            fi
            changed=true
        fi
    done

    if [ "$changed" = true ]; then
        updated_count=$((updated_count+1))
    fi
done

echo "Substitution performed in ${updated_count} file(s)."

echo "Configuration complete. You can now remove 'configure.sh' if desired. Don't forget to change  the license file if you don't use GNU-3.0."