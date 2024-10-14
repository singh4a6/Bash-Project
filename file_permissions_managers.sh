#!/bin/bash

# Function to display help
show_help() {
    echo "Usage: $0 [options] [file/directory...]"
    echo
    echo "Options:"
    echo "  -h                    Show this help message."
    echo "  -o USER[:GROUP]       Change ownership to the specified USER (and optionally GROUP)."
    echo "  -p PERMISSIONS        Change file/directory permissions (e.g., 755 or u+rwx)."
    echo "  -v                    Verbose mode. Displays detailed actions."
    echo
    echo "Example usage:"
    echo "  $0 -o user1:group1 -p 755 file.txt"
    echo "  $0 -p u+x directory/"
}

# Function to handle invalid arguments
invalid_argument() {
    echo "Error: Invalid argument '$1'"
    echo "Use -h for help."
    exit 1
}

# Check if no arguments are provided
if [ "$#" -eq 0 ]; then
    echo "Error: No arguments provided."
    show_help
    exit 1
fi

# Parse options
OWNERSHIP=""
PERMISSIONS=""
VERBOSE=false

while getopts ":ho:p:v" opt; do
    case $opt in
        h)
            show_help
            exit 0
            ;;
        o)
            OWNERSHIP=$OPTARG
            if ! [[ $OWNERSHIP =~ ^[a-zA-Z0-9]+(:[a-zA-Z0-9]+)?$ ]]; then
                echo "Error: Invalid ownership format. Use USER or USER:GROUP."
                exit 1
            fi
            ;;
        p)
            PERMISSIONS=$OPTARG
            if ! [[ $PERMISSIONS =~ ^[ugoa]*[+-=][rwx]+$ || $PERMISSIONS =~ ^[0-7]{3}$ ]]; then
                echo "Error: Invalid permissions format. Use symbolic (e.g., u+x) or numeric (e.g., 755)."
                exit 1
            fi
            ;;
        v)
            VERBOSE=true
            ;;
        \?)
            invalid_argument "-$OPTARG"
            ;;
    esac
done

# Shift to remaining arguments (files/directories)
shift $((OPTIND -1))

# Ensure at least one file or directory is provided
if [ "$#" -eq 0 ]; then
    echo "Error: No file or directory specified."
    show_help
    exit 1
fi

# Iterate over each file/directory provided
for TARGET in "$@"; do

    # Check if the file/directory exists
    if [ ! -e "$TARGET" ]; then
        echo "Error: File or directory '$TARGET' does not exist."
        exit 1
    fi

    # Change ownership if -o option is provided
    if [ ! -z "$OWNERSHIP" ]; then
        if [ "$VERBOSE" = true ]; then
            echo "Changing ownership of '$TARGET' to '$OWNERSHIP'..."
        fi
        chown $OWNERSHIP "$TARGET"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to change ownership of '$TARGET'."
            exit 1
        fi
    fi

    # Change permissions if -p option is provided
    if [ ! -z "$PERMISSIONS" ]; then
        if [ "$VERBOSE" = true ]; then
            echo "Changing permissions of '$TARGET' to '$PERMISSIONS'..."
        fi
        chmod $PERMISSIONS "$TARGET"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to change permissions of '$TARGET'."
            exit 1
        fi
    fi

    # Success message
    if [ "$VERBOSE" = true ]; then
        echo "Successfully updated permissions/ownership for '$TARGET'."
    fi
done
