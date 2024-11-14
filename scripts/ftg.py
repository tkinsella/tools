"""
=============================================================================
File:           ftg.py
Purpose:        Generates a visual tree structure of a directory and its
                contents, similar to the Unix 'tree' command.

How to run:     python ftg.py [path] [--exclude dir1 dir2 ...]
                Example: python ftg.py /var/www/project

Dependencies:   Python 3.6+
                - os
                - argparse
                - pathlib

Author:         Tom Kinsella
Email:          tkinsella@sisng.io
Organization:   Personal Project

Creation Date:  2024-11-13
Last Updated:   2024-11-13
Version:        1.0.0

Change History:
    1.0.0 (2024-11-13) - Initial release
        - Basic directory tree generation
        - Support for exclusion lists
        - Permission handling

MIT License
                Copyright (c) 2024 Tom Kinsella
                See LICENSE file for full license text

Notes:
    - Requires appropriate permissions to access directories
    - Use sudo for system directories
=============================================================================
"""
import os
import argparse
import stat
from pathlib import Path
from typing import List

def has_directory_access(path):
   # Check if we have read and execute permissions for the directory.
    try:
        return os.access(path, os.R_OK | os.X_OK)
    except Exception:
        return False

def generate_tree(
    directory: str,
    prefix: str = "",
    is_last: bool = True,
    exclude_dirs: List[str] = [".git", "node_modules", "__pycache__"],
    is_root: bool = False
) -> None:  # Recursively generate and print a tree structure for the given directory.
    if not has_directory_access(directory):
        print(f"{prefix}{'└── ' if is_last else '├── '}[Permission Denied] {os.path.basename(directory)}/")
        return

    try:
        # Get all entries in the directory
        entries = []
        with os.scandir(directory) as scanner:
            for entry in scanner:
                if entry.name not in exclude_dirs:
                    entries.append(entry)
        
        # Separate and sort directories and files
        directories = sorted([e for e in entries if e.is_dir()], key=lambda x: x.name.lower())
        files = sorted([e for e in entries if e.is_file()], key=lambda x: x.name.lower())
        
        # Print current directory if it's not the root
        if not is_root:
            print(f"{prefix}{'└── ' if is_last else '├── '}{os.path.basename(directory)}/")
            
        # Calculate new prefix for children
        new_prefix = prefix
        if not is_root:
            new_prefix = prefix + ("    " if is_last else "│   ")
        
        # Process directories
        for i, entry in enumerate(directories):
            is_last_dir = (i == len(directories) - 1) and not files
            generate_tree(entry.path, new_prefix, is_last_dir, exclude_dirs, False)
        
        # Process files
        for i, entry in enumerate(files):
            is_last_file = i == len(files) - 1
            print(f"{new_prefix}{'└── ' if is_last_file else '├── '}{entry.name}")
            
    except PermissionError:
        print(f"{prefix}{'└── ' if is_last else '├── '}[Permission Denied] {os.path.basename(directory)}/")
    except Exception as e:
        print(f"{prefix}{'└── ' if is_last else '├── '}[Error: {str(e)}] {os.path.basename(directory)}/")

def main():
    parser = argparse.ArgumentParser(
        description="Generate a tree structure of a directory path"
    )
    parser.add_argument(
        "path",
        nargs="?",
        default=".",
        help="Directory path to generate tree for (default: current directory)"
    )
    parser.add_argument(
        "--exclude",
        nargs="*",
        default=[".git", "node_modules", "__pycache__"],
        help="Directories to exclude (default: .git node_modules __pycache__)"
    )
    
    args = parser.parse_args()
    path = os.path.abspath(args.path)
    
    if not os.path.exists(path):
        print(f"Error: Path '{path}' does not exist")
        return
    
    if not os.path.isdir(path):
        print(f"Error: Path '{path}' is not a directory")
        return
    
    # Print the root directory name
    print(path)
    
    # Start generating the tree with empty prefix for root
    generate_tree(path, "", True, args.exclude, True)

if __name__ == "__main__":
    main()
