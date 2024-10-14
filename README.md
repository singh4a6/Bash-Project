# Bash-Project

The permissions_manager.sh script is a file permissions management tool that allows users to easily change the ownership and access permissions of files and directories. This script is designed to simplify the process of managing file permissions, especially for users who need to modify multiple files or directories at once. With intuitive command-line options, users can efficiently change ownership, modify file permissions, and enable a verbose mode for detailed output.

#Features:
Change Ownership: Modify the ownership of files and directories by specifying a user and an optional group.
Change Permissions: Update access permissions of files and directories using either symbolic (e.g., u+rwx) or numeric (e.g., 755) formats.
Verbose Mode: View detailed information about the actions being performed.
Error Handling: Provides clear feedback if the file, user, group, or permissions are invalid or the action fails.

Why This Script is Useful
Managing file permissions in Unix-based systems (like Linux) is a crucial task for system administrators, developers, and users who need to control access to files and directories. Correctly setting ownership and permissions ensures that files are accessible only to authorized users, protecting sensitive data and system integrity.

This script simplifies the potentially complex task of managing file permissions by:

Allowing batch operations: Users can change ownership or permissions for multiple files and directories in one command.
Supporting both symbolic and numeric permission changes: This provides flexibility depending on the user's familiarity with Unix permission systems.
Automating verbose feedback: Verbose mode lets users see what changes are being applied, providing transparency and helping debug any issues.
Providing error handling: The script validates user input (like ownership format and permission values) to prevent errors and unexpected behavior.

Basic Usage:
./permissions_manager.sh [options] [file/directory...]

Options:
-h: Show help information for using the script.
-o USER[:GROUP]: Change the ownership of the specified files/directories to the given user (and optionally group).
-p PERMISSIONS: Change the permissions of the specified files/directories. Supports numeric (e.g., 755) and symbolic (e.g., u+rwx) formats.
-v: Enable verbose mode to display detailed information about the changes being made.
