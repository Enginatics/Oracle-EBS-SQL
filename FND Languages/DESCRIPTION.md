# Executive Summary
The **FND Languages** report lists the languages defined in the Oracle EBS installation.

# Business Challenge
*   **Global Rollout:** Verifying which languages are installed and active (Base vs. Installed).
*   **NLS Support:** Checking the NLS Language and Territory codes for system configuration.

# The Solution
This Blitz Report lists the language details:
*   **Language Code:** The short code (e.g., "US", "D").
*   **Description:** The full name (e.g., "American English", "German").
*   **Status:** Whether the language is "Installed" or just defined.

# Technical Architecture
The report queries `FND_LANGUAGES_VL`.

# Parameters & Filtering
*   **Show installed only:** Toggle to hide the dozens of languages that are defined but not installed on your server.

# Performance & Optimization
*   **Simple List:** Runs instantly.

# FAQ
*   **Q: Can I install a new language from here?**
    *   A: No, installing a language requires running the "License Manager" and applying the NLS translation patches.
