# Executive Summary
The **FND Messages** report lists the standard and custom messages defined in the Message Dictionary. These are the text strings used for error messages, warnings, and labels in Forms and OAF pages.

# Business Challenge
*   **Customization Review:** Finding all custom messages (e.g., starting with `XX%`) created for custom validations.
*   **Translation:** Extracting message text to send to a translation agency.
*   **Error Analysis:** Searching for the text of a cryptic error message to find its internal name and owning application.

# The Solution
This Blitz Report lists the message details:
*   **Message Name:** The internal code (e.g., `APP-FND-01234`).
*   **Message Text:** The user-facing text, including token placeholders (e.g., `Value &VALUE is invalid`).
*   **Application:** The owning module.

# Technical Architecture
The report queries `FND_NEW_MESSAGES`.

# Parameters & Filtering
*   **Message Text contains:** Search for a specific phrase (e.g., "insufficient funds").
*   **Message Name like:** Filter by code pattern.

# Performance & Optimization
*   **Fast Execution:** Runs quickly against the message table.

# FAQ
*   **Q: Can I change standard Oracle messages?**
    *   A: It is technically possible but highly discouraged as patches will overwrite them. You should use "Custom Messages" or "Forms Personalization" to override text.
