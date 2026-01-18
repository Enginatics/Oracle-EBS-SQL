
# Case Study & Technical Analysis: EAM Assets

## Executive Summary
The **EAM Assets** report is the master registry for the Enterprise Asset Management module. It provides a comprehensive view of the physical assets being maintained, linking the operational view (Maintenance) with the financial view (Fixed Assets) and the logistical view (Inventory).
This report is essential for:
1.  **Asset Registry Audits:** Verifying that all physical equipment is correctly registered in the system with the right attributes.
2.  **Location Tracking:** Identifying exactly where assets are located, whether in a subinventory, a specific area, or at a vendor site.
3.  **Hierarchy Analysis:** Understanding the parent-child relationships between assets (e.g., a Motor belonging to a Pump belonging to a Processing Line).

## Business Challenge
Managing a large asset fleet involves coordinating data across multiple domains.
*   **The "Ghost Asset" Problem:** Assets might exist on the floor but not in the system, or vice versa.
*   **Data Disconnects:** The Maintenance team knows the asset as "Pump-101", while Finance knows it as "FA-55432". Without a report linking `CSI_ITEM_INSTANCES` to `FA_ADDITIONS`, these two worlds remain separate.
*   **Location Complexity:** Assets move. They go to repair depots (Vendor Sites), move between buildings (HZ Locations), or sit in inventory. A simple "Location" field isn't enough; the system uses a complex polymorphic location logic.

## The Solution
This report flattens the complex EAM data model into a single, readable row per asset.
*   **Unified Identity:** It displays the Asset Number (Instance Number), the Asset Group (Inventory Item), and the Fixed Asset Number side-by-side.
*   **Polymorphic Location Logic:** It intelligently decodes the `LOCATION_TYPE_CODE`.
    *   If the asset is at a street address (`HZ_LOCATIONS`), it formats the address fields.
    *   If it's an internal HR location, it pulls from `HR_LOCATIONS_ALL`.
    *   If it's at a vendor, it resolves the Vendor Site address.
*   **Operational Context:** It includes the "Owning Department" (who pays for the maintenance) and the "Accounting Class" (how costs are categorized), which are critical for work order generation.

## Technical Architecture (High Level)
The query is built around `CSI_ITEM_INSTANCES` (the Install Base), which is the repository for EAM assets in R12.
*   **Core Join:** `CSI_ITEM_INSTANCES` (cii) joins to `MTL_SYSTEM_ITEMS_VL` (msiv) to get the Asset Group definition.
*   **Hierarchy Logic:** It joins to `MTL_OBJECT_GENEALOGY` (via subquery or direct join logic depending on the version) to find the `Parent_Asset_Number`.
*   **Fixed Asset Link:** It joins to `CSI_I_ASSETS` and `FA_ADDITIONS_B` to bridge the gap to the Fixed Assets module.
*   **Maintenance Defaults:** It joins to `EAM_ORG_MAINT_DEFAULTS` to fetch the Department and Area, which are specific EAM attributes not found on the standard item instance.

## Parameters & Filtering
*   **Organization Code:** The maintenance organization.
*   **Asset Group/Number:** Specific assets to target.
*   **Department:** Filter by the owning department (e.g., "Show me all assets owned by Facilities").

## Performance & Optimization
*   **Inline Views:** The query uses an inline view for `CSI_ITEM_INSTANCES` to pre-filter by organization security (`ORG_ACCESS_VIEW`) and resolve the polymorphic `Location_ID` before joining to the heavy address tables.
*   **Date Filtering:** It strictly filters for active assets (`sysdate between active_start_date and active_end_date`) to avoid reporting retired or scrapped equipment.

## FAQ
**Q: Why is the "Fixed Asset Number" blank?**
A: Not all EAM assets are capitalized Fixed Assets (e.g., small tools). Also, the link might not have been established in the "Asset Numbers" form.

**Q: What is the difference between "Asset Group" and "Asset Number"?**
A: The "Asset Group" is the *type* of asset (e.g., "Ford F-150 Truck"). The "Asset Number" is the specific instance (e.g., "Truck #44, License Plate XYZ"). In Oracle, the Group is an Inventory Item, and the Number is a Serial Number/Instance.

**Q: Why do I see "HZ_LOCATIONS" in the raw data?**
A: This is the internal code for the Trading Community Architecture (TCA) location model, used for external addresses. The report decodes this into a readable address string.
