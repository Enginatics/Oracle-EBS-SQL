# Executive Summary
The **FND Responsibility Access** report is the "Swiss Army Knife" of security reporting. It answers the question: "Who can do what?" by linking Users -> Responsibilities -> Menus -> Functions -> Forms.

# Business Challenge
*   **SoD Analysis:** Identifying users who have access to conflicting functions (e.g., "Create Vendor" and "Pay Vendor").
*   **Access Review:** Finding all users who can access a specific sensitive form (e.g., "Bank Accounts").
*   **Deep Dive:** Tracing the full path from a User to a specific Function, including sub-menus.

# The Solution
This Blitz Report performs a deep traversal:
*   **User Access:** Lists users and their responsibilities.
*   **Menu Explosion:** Explodes the menu tree to find every function accessible to that responsibility.
*   **Context:** Shows the Operating Units and Ledgers accessible to that user/responsibility combination.

# Technical Architecture
The report joins `FND_USER`, `FND_RESPONSIBILITY`, `FND_MENUS`, and `FND_FORM_FUNCTIONS`. It uses recursive logic (or flattened tables) to traverse the menu hierarchy.

# Parameters & Filtering
*   **User Name:** Analyze a specific user.
*   **Function Name:** Find everyone who can access this function.
*   **Form Name:** Find everyone who can open this form.
*   **Access to Operating Unit:** Find everyone who can transact in a specific OU.

# Performance & Optimization
*   **Heavy Report:** Because it explodes the menu tree for every responsibility, this report can generate millions of rows if run without filters. **Always** filter by User, Responsibility, or Function.

# FAQ
*   **Q: Does it handle Menu Exclusions?**
    *   A: The description notes that it may not fully account for menu exclusions in all versions, so verify critical findings manually.
