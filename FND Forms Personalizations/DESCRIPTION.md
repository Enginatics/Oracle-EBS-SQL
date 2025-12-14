# Executive Summary
The **FND Forms Personalizations** report is the definitive audit tool for all custom logic applied to Oracle Forms via the "Personalization" framework. It replaces the need to manually open every form to check for customizations.

# Business Challenge
*   **Upgrade Assessment:** Identifying all personalizations that need to be tested or re-implemented during an upgrade.
*   **Troubleshooting:** Checking if a "bug" is actually caused by a custom personalization rule.
*   **Logic Review:** Documenting business rules implemented via personalization (e.g., making a field mandatory).

# The Solution
This Blitz Report extracts the full personalization logic:
*   **Rule:** The Trigger Event (e.g., `WHEN-NEW-FORM-INSTANCE`) and Condition.
*   **Actions:** The specific actions taken (e.g., Property Property, Message, Builtin).
*   **Scope:** Whether the rule applies to the Site, Responsibility, or User level.

# Technical Architecture
The report joins `FND_FORM_CUSTOM_RULES`, `FND_FORM_CUSTOM_ACTIONS`, and `FND_FORM_CUSTOM_SCOPES`. It provides a flattened view of the Rule -> Action hierarchy.

# Parameters & Filtering
*   **Form Name:** Filter for personalizations on a specific screen.
*   **Description:** Search for keywords in the rule description.
*   **Show Context:** Toggle to see the scope (Site/Resp/User).

# Performance & Optimization
*   **Complex Logic:** The report handles the one-to-many relationship between Rules and Actions.

# FAQ
*   **Q: Does this show CUSTOM.pll changes?**
    *   A: No, this only shows changes made in the "Forms Personalization" window stored in the database. `CUSTOM.pll` is a file-based customization.
