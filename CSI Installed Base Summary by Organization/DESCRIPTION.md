# Executive Summary
The **CSI Installed Base Summary by Organization** report provides a statistical overview of the Installed Base, aggregated by organization and hierarchy. It counts the number of item instances based on their usage (e.g., "Sold To," "Ship To") and their relationship within the system (Parent/Child). This high-level view is useful for operational reporting and validating data migration or synchronization processes.

# Business Challenge
Managing millions of installed base records requires high-level metrics to ensure data health.
*   **Volume Analysis**: "How many active instances do we have in the US vs. Europe?"
*   **Data Integrity**: "Do we have instances that are owned by an inactive organization?"
*   **Hierarchy Validation**: Ensuring that the parent-child relationships (e.g., System -> Component) are being maintained.

# Solution
This report aggregates instance counts by various organizational dimensions.

**Key Features:**
*   **Hierarchy Analysis**: Counts instances by their parent/child relationship type.
*   **Usage Breakdown**: Segments the base by "Instance Usage" (e.g., External, Internal, In-Transit).
*   **Organizational Context**: Shows the "Sold From" and "Owner" operating units.

# Architecture
The report aggregates data from `CSI_ITEM_INSTANCES` and `CSI_II_RELATIONSHIPS`.

**Key Tables:**
*   `CSI_ITEM_INSTANCES`: The core instance data.
*   `CSI_II_RELATIONSHIPS`: Defines the structure (parent/child) between instances.
*   `CSI_I_ORG_ASSIGNMENTS`: Links instances to specific organizations.
*   `HR_ALL_ORGANIZATION_UNITS`: Organization details.

# Impact
*   **Operational Monitoring**: Tracks the growth of the installed base over time.
*   **Data Quality**: Helps identify "orphan" records or instances with invalid organizational assignments.
*   **Strategic Planning**: Provides the volume data needed to plan for storage or service capacity.
