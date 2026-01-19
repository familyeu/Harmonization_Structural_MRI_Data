#!/bin/bash

# Output filename
OUTPUT_FILE="hippocampal_subfields.csv"

# 1. GENERATE HEADER
# Find the latest valid file (v21 if using FS 7.1.1, v22 if using FS 7.4.1) to extract the region names from
SAMPLE_FILE=$(find . -maxdepth 3 -name "hipposubfields.lh.T1.v*.stats" | sort -r | head -n 1)

if [ -z "$SAMPLE_FILE" ]; then
    echo "Error: No hippocampal stats files found in subdirectories."
    exit 1
fi

# Extract names, add prefixes, and format as CSV header
# We filter out lines starting with '#'
# We take the 5th column (names)
LH_HEADER=$(grep -v "^#" "$SAMPLE_FILE" | awk '{print "LH_" $5}' | paste -sd ",")
RH_HEADER=$(grep -v "^#" "$SAMPLE_FILE" | awk '{print "RH_" $5}' | paste -sd ",")

# Create the "NA" string for missing subjects (Count regions * 2 for both hemispheres)
NA_STRING=$(yes "NA" | head -n $(($(grep -c -v "^#" "$SAMPLE_FILE") * 2)) | paste -sd ",")

# Write the header row: SubjectID followed by LH columns and RH columns
echo "SubjectID,${LH_HEADER},${RH_HEADER}" > "$OUTPUT_FILE"

# 2. PROCESS PARTICIPANTS
for dir in */ ; do
    SUBJ_ID=$(basename "$dir")
    
    # Define paths to the specific stats files
    LH_FILE=$(find "${dir}stats" -maxdepth 1 -name "hipposubfields.lh.T1.v*.stats" | sort -r | head -n 1)
    RH_FILE=$(find "${dir}stats" -maxdepth 1 -name "hipposubfields.rh.T1.v*.stats" | sort -r | head -n 1)

    # Check if both files exist for this participant
    if [[ -n "$LH_FILE" && -n "$RH_FILE" ]]; then
        
        # Extract the 4th column (Volumes) for Left Hemisphere
        LH_DATA=$(grep -v "^#" "$LH_FILE" | awk '{print $4}' | paste -sd ",")

        # Extract the 4th column (Volumes) for Right Hemisphere
        RH_DATA=$(grep -v "^#" "$RH_FILE" | awk '{print $4}' | paste -sd ",")

        # Append to CSV
        echo "${SUBJ_ID},${LH_DATA},${RH_DATA}" >> "$OUTPUT_FILE"
        echo "Processed: $SUBJ_ID"
    else
        echo "${SUBJ_ID},${NA_STRING}" >> "$OUTPUT_FILE"
        echo "Stats files missing: $SUBJ_ID"
    fi
done

echo "-----------------------------------"
echo "Done! Data saved to $OUTPUT_FILE"
