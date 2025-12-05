# BOM Bill of Material Structure - Case Study & Technical Analysis

## Executive Summary
The **BOM Bill of Material Structure** report is the blueprint of manufacturing and engineering within Oracle EBS. It provides a hierarchical representation of product structures, detailing every component, sub-assembly, and raw material required to build a finished good. This report is indispensable for production planning, cost estimation, and maintaining accurate product definitions.

## Business Challenge
Manufacturing and Engineering teams often struggle with:
*   **Complexity:** Visualizing multi-level BOMs (indented bills) to understand deep dependencies.
*   **Accuracy:** Ensuring that the "As-Built" or "As-Planned" structure matches the engineering documentation.
*   **Change Management:** Tracking component changes across different BOM versions and effectivity dates.
*   **Costing Errors:** Incorrect BOM structures leading to wrong standard costs and inventory valuation issues.

## Solution
This report offers a flexible, multi-level explosion of the Bill of Materials. It empowers users to:
*   **Visualize Hierarchy:** See the full indented structure of an assembly, level by level.
*   **Manage Effectivity:** Filter components based on "Effectivity Date" to see what is valid for a specific production run.
*   **Handle Alternates:** View primary and alternate BOMs to support different manufacturing processes.
*   **Audit Components:** Verify component quantities, yield factors, and supply types (Push, Pull, Phantom).

## Technical Architecture
The report utilizes the Oracle BOM explosion logic to traverse the parent-child relationships defined in the database.

### Key Tables & Views
| Table Name | Description |
| :--- | :--- |
| `BOM_BILL_OF_MATERIALS` | Stores the header information for a BOM (Assembly Item, Organization). |
| `BOM_INVENTORY_COMPONENTS` | Stores the components (children) for each bill, including quantity and effectivity. |
| `MTL_SYSTEM_ITEMS_B` | Defines the items (Assemblies and Components) and their attributes. |
| `BOM_EXPLOSION_TEMP` | A temporary table often used by system reports to store the results of the BOM explosion processor. |
| `BOM_STRUCTURES_B` | (R12) The underlying table for BOM headers, replacing some legacy views. |

### Core Logic
1.  **BOM Explosion:** The report logic mimics the "BOM Explosion" process, starting from the top-level Assembly and recursively finding components.
2.  **Effectivity Filtering:** It applies `Effectivity Date` and `Disable Date` filters to ensure only currently active components are listed (unless "All" is requested).
3.  **Organization Context:** BOMs are organization-specific. The query ensures data is pulled for the correct manufacturing organization.
4.  **Item Details:** It joins to `MTL_SYSTEM_ITEMS` to retrieve descriptions, item statuses, and units of measure.

## FAQ
**Q: Can this report show "Phantom" assemblies?**
A: Yes, the report displays the supply type of components, allowing you to identify Phantoms, Assembly Pull, or Operation Pull items.

**Q: Does it support "Alternate" BOMs?**
A: Yes, the `Alternate Selection` parameter allows you to choose specific alternates or view the primary BOM.

**Q: How many levels deep can it go?**
A: The `Levels to Explode` parameter allows you to control the depth, from a single level to a full multi-level explosion.

**Q: Does it show component substitutes?**
A: Yes, there is a parameter `Show Substitute Components` to include valid substitutes defined for the BOM components.
