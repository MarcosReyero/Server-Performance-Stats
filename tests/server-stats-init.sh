#!/bin/bash

# Get the OS type
OS_TYPE=$(uname)

# Check the OS and run the appropriate script
if [[ "$OS_TYPE" == "Linux" ]]; then
    echo "Running Linux version..."
    bash server-stats-linux.sh  # Call the Linux-specific script
elif [[ "$OS_TYPE" == "Darwin" ]]; then
    echo "Running macOS version..."
    bash server-stats-mac.sh  # Call the macOS-specific script
elif [[ "$OS_TYPE" == "CYGWIN" ]] || [[ "$OS_TYPE" == "MINGW" ]]; then
    echo "Running Windows version..."
    bash server-stats-win.sh  # Call the Windows-specific script (to be created)
else
    echo "Unsupported OS: $OS_TYPE"
fi
