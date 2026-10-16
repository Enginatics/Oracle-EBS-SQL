# Executive Summary
The **FND Descriptive Flexfield** report is the comprehensive documentation tool for all DFF configurations in the system. It details every context, segment, and validation rule associated with a flexfield.

# Business Challenge
*   **Configuration Audit:** Documenting all custom fields added to screens for compliance or upgrade planning.
*   **Troubleshooting:** Debugging why a specific field is mandatory or has a specific list of values.
*   **Knowledge Transfer:** Explaining the custom data model to new developers or business analysts.

# The Solution
This Blitz Report extracts the full DFF definition:
*   **Contexts:** Lists the "Global Data Elements" and any context-sensitive structures.
*   **Segments:** Details each segment (Attribute1, Attribute2, etc.), its prompt, and display size.
*   **Validation:** Shows the Value Set attached to each segment and the underlying validation logic (SQL or independent values).

# Technical Architecture
The report joins `FND_DESCRIPTIVE_FLEXS`, `FND_DESCR_FLEX_CONTEXTS`, and `FND_DESCR_FLEX_COL_USAGE`. It provides a hierarchical view of the flexfield structure.

# Parameters & Filtering
*   **Title:** Search by the user-friendly name of the DFF (e.g., "Order Headers").
*   **Table Name:** Search by the underlying table (e.g., `OE_ORDER_HEADERS_ALL`).
*   **Show LOV Query:** Option to display the SQL query used by Table-validated value sets.

# Performance & Optimization
*   **Complex Validations:** If "Show LOV Query" is enabled, the report may take slightly longer to render large SQL blocks.

# FAQ
*   **Q: Can I see Key Flexfields here?**
    *   A: No, this is for Descriptive Flexfields. Use "FND Key Flexfields" for the accounting flexfield, item category, etc.
