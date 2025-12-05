# AD Applied Patches - Case Study

## Executive Summary
The **AD Applied Patches** report is a critical tool for Database Administrators (DBAs) and System Administrators to track the history of software updates within the Oracle E-Business Suite environment. It provides a detailed audit trail of all patches applied, including specific bug fixes, file versions, and execution timings. This visibility is essential for maintaining system stability, verifying compliance with security standards, and troubleshooting issues that may arise after patching cycles.

## Business Challenge
Managing the patching lifecycle in a complex ERP environment is fraught with challenges:
*   **Audit Compliance:** Auditors frequently request evidence of specific security patches or bug fixes.
*   **Troubleshooting:** When new issues emerge, the first question is often, "What changed recently?" Without a clear patch history, correlating system behavior with recent updates is difficult.
*   **Environment Synchronization:** Ensuring that development, test, and production environments are on the same patch level requires precise tracking of applied patches.
*   **Verification:** Confirming that a patch was applied successfully and that all prerequisite bugs were resolved.

## Solution
The **AD Applied Patches** report solves these challenges by querying the internal AD (Application DBA) tables to present a comprehensive view of the patching history.

**Key Features:**
*   **Patch Run Details:** Shows when a patch was applied, how long it took, and the status of the application.
*   **Bug Fix Verification:** Lists individual bugs resolved by each patch, allowing for granular verification of specific fixes.
*   **File Version Tracking:** Identifies the specific versions of files deployed, which is crucial for deep technical analysis.
*   **Action History:** Displays the specific actions executed during the patch run (e.g., SQL scripts run, libraries relinked).

## Technical Architecture
The report leverages the Oracle Applications DBA (AD) schema, which stores all patching metadata.

**Key Tables:**
*   `AD_APPLIED_PATCHES`: Stores the header information for each patch applied.
*   `AD_PATCH_DRIVERS`: Contains details about the patch driver files.
*   `AD_PATCH_RUNS`: Records the execution details of each patch session.
*   `AD_BUGS`: Links patches to the specific bugs they resolve.
*   `AD_FILES` & `AD_FILE_VERSIONS`: Tracks the version history of every file in the system.

## Frequently Asked Questions
**Q: Can this report show patches applied to a specific node in a multi-node cluster?**
A: Yes, the underlying tables track patch runs by server/node, allowing you to verify consistency across a cluster.

**Q: Does it include patches applied in "pre-install" mode?**
A: The report captures all patch runs recorded by the `adpatch` or `adop` utilities, including different modes if they are logged to the database.

**Q: How can I check if a specific security vulnerability (CVE) is patched?**
A: You can search for the specific Oracle Bug number associated with the CVE in the "Bug Number" parameter to see if the corresponding fix has been applied.
