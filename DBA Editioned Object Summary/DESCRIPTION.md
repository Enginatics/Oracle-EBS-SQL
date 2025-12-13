# Executive Summary
The **DBA Editioned Object Summary** report is essential for managing Oracle E-Business Suite 12.2+ environments, which use Edition-Based Redefinition (EBR) for online patching. It provides a summary of how many objects exist in each "Edition". This is critical for monitoring the cleanup process (`adop phase=cleanup`) and managing the growth of the database.

# Business Challenge
*   **Storage Growth**: "Why is the database growing so fast? Are we keeping too many old patch editions?"
*   **Patching Health**: "Did the cleanup phase of the last patch cycle actually remove the obsolete objects?"
*   **Performance**: "Are we suffering from dictionary performance issues due to having 500 old editions?"

# Solution
This report summarizes the count of editioned objects (Views, PL/SQL, Synonyms) per edition.

**Key Features:**
*   **Edition Name**: The name of the patch edition (e.g., `V_20230101_1200`).
*   **Object Count**: Number of actual objects vs. "stub" objects.
*   **Active Status**: Identifies the current Run and Patch editions.

# Architecture
The report queries `OBJ$`, `USER$`, and `DBA_USERS`.

**Key Tables:**
*   `OBJ$`: The core object table (includes the `EDITION_NAME` column).
*   `DBA_OBJECTS_AE`: The view showing all editioned objects.

# Impact
*   **Space Reclamation**: Identifies when it's safe (and necessary) to run a full cleanup to reclaim space.
*   **System Hygiene**: Ensures the database doesn't become cluttered with thousands of obsolete object versions.
*   **Patching Success**: Verifies that the Online Patching cycle is completing all its housekeeping tasks.
