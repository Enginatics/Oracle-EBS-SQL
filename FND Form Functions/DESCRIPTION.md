# Executive Summary
The **FND Form Functions** report documents the registered functions in Oracle EBS. A "Function" is the basic unit of application logic (a form, a web page, or a sub-function) that can be assigned to a menu.

# Business Challenge
*   **Security Analysis:** Identifying which functions invoke a specific Form or HTML page.
*   **Menu Construction:** Finding the correct function name to add to a new custom menu.
*   **Web vs. Form:** Distinguishing between OAF (HTML) functions and Oracle Forms functions.

# The Solution
This Blitz Report lists the function details:
*   **Function Name:** The internal developer name.
*   **User Function Name:** The friendly name seen in menus.
*   **Type:** Form, Subfunction, JSP, etc.
*   **Form/HTML Call:** The actual code or form executable being invoked.

# Technical Architecture
The report queries `FND_FORM_FUNCTIONS_VL` and joins to `FND_FORM_VL` to show the linked form (if applicable).

# Parameters & Filtering
*   **Function Name:** Search by internal name.
*   **HTML Call contains:** Useful for finding all functions that point to a specific JSP page or OAF region.

# Performance & Optimization
*   **Fast Execution:** Runs quickly against the metadata tables.

# FAQ
*   **Q: What is a "Subfunction"?**
    *   A: It is a function that doesn't open a screen but grants permission to a specific button or logic within a screen (Function Security).
