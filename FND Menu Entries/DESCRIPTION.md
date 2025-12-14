# Executive Summary
The **FND Menu Entries** report documents the menu hierarchy in Oracle EBS. It shows which functions and sub-menus are attached to a parent menu, effectively mapping out the navigation structure.

# Business Challenge
*   **Security Audit:** Verifying which functions are accessible from a specific Responsibility's menu.
*   **Navigation Design:** Documenting the current menu structure before redesigning the user navigation.
*   **Troubleshooting:** Finding where a specific function (e.g., "Enter Journals") is located in the menu tree.

# The Solution
This Blitz Report explodes the menu structure:
*   **Menu:** The parent menu name.
*   **Entry:** The prompt (label) seen by the user.
*   **Function/Submenu:** The actual function or child menu attached to that entry.
*   **Grant:** Shows if the function is "Grant" only (not visible, but authorized).

# Technical Architecture
The report queries `FND_MENUS_VL` and `FND_MENU_ENTRIES_VL`. It can recursively traverse the tree if needed, but typically shows direct assignments.

# Parameters & Filtering
*   **User Menu Name:** Filter by the top-level menu (e.g., "GL_SUPERUSER").
*   **Function Name:** Find all menus that contain a specific function.
*   **Prompt:** Search by the user-visible label.

# Performance & Optimization
*   **Recursion:** Menu structures can be deep. The report is optimized to show direct relationships.

# FAQ
*   **Q: Does this show Exclusions?**
    *   A: No, this shows the *definition* of the menu. To see what a user can actually access (net of exclusions), use the "FND Responsibility Access" report.
