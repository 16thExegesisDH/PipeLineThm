#!/bin/bash

#arguments: 
# Check if a file is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file="$1"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found."
    exit 1
fi

# Output file
output_file="${input_file%.tex}.update.tex"

# Replace occurrences of word splits (e.g., "wo- man" to "woman")
sed -E 's/([A-Za-z])- +/\1/g' "$input_file" > "$output_file"

echo "Processing complete. Output written to $output_file"

#script 1 : need to be improve with more rules as a final optimization of the text. For example uniformize the subtitles 
