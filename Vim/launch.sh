#!/bin/bash

# Directory where your layout images are stored
IMAGE_DIR="$HOME/.scripts/TTR-Scripts/TTR-Popup/Vim/"

# Check if the image directory exists
if [ ! -d "$IMAGE_DIR" ]; then
    echo "Error: Image directory does not exist: $IMAGE_DIR"
    exit 1
fi

# Function to create layout options with images
create_layout_options() {
    # Find image files, sort them, then process
    find "$IMAGE_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" \) | sort -V | while read -r img; do
        # Get the filename without extension
        layout_name=$(basename "$img" | sed 's/\.[^.]*$//')
        echo -en "${layout_name}\x00icon\x1f${img}\n"
    done
}

# Use rofi to display layout options with images
selected=$(create_layout_options | rofi -dmenu -i -p "Select Layout" \
    -theme-str 'window {width: 1250px; height: 1050px;}' \
    -theme-str 'listview {columns: 1; lines: 1;}' \
    -theme-str 'element {orientation: vertical;}' \
    -theme-str 'element-icon {size: 850px;}' \
    -show-icons)

# Handle the selection
if [ -n "$selected" ]; then
    echo "Selected layout: $selected"
    # Add your logic here to handle the selected layout
else
    echo "No layout selected"
fi
