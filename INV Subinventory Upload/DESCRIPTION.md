# Case Study & Technical Analysis: INV Subinventory Upload

## Executive Summary
This upload creates and updates Oracle Inventory subinventories across the inventory organizations a user can access. A subinventory carries its status, type, planning and availability flags, locator control, picking and source rules, lead times, and the seven GL accounts that drive costing, together with the cost group that links them. Inventory administrators and implementation teams use it to set up storage locations in bulk for a new warehouse or plant, and to change their status or accounts without opening the Subinventories form one at a time. The template runs in Excel through Blitz Report.

## Business Challenge
*   **Warehouse set-up at scale:** A new plant or warehouse needs many subinventories with consistent flags, locators and accounts.
*   **Cost group and account linkage:** The accounts and the default cost group are tightly connected, and changing one can silently change the other.
*   **Controlled status changes:** Material status changes may need electronic signature, so they must be made through a controlled route.
*   **No deletion path:** Subinventories cannot be deleted, so retirement must be managed through an inactive date.

## The Solution
*   **Three account modes:** The upload follows the organization's configuration. With WMS not enabled and Standard costing, the accounts drive the cost group. With WMS enabled, the cost group drives the accounts. In other cases the cost group is fixed and the accounts follow it.
*   **Cost group resolution:** When the accounts match an existing cost group, that group is used. Otherwise a new cost group is created, and the action taken is reported in the success message.
*   **Account lists of values:** All account choices are limited to enabled detail accounts in the organization's chart of accounts.
*   **Retirement by date:** A subinventory is inactivated by setting its Inactive On date to a past date.
*   **Full attribute set:** Type, ATP and reservation flags, locator control, picking order, source organization and lead times are returned for each subinventory.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_SECONDARY_INVENTORIES`: the subinventory record, with its flags, type, locator control, dates and account references.
*   `MTL_PARAMETERS`: the owning inventory organization and the source organization.
*   `MTL_MATERIAL_STATUSES_VL`: the subinventory material status and the default locator status.
*   `CST_COST_GROUPS`: the default cost group.
*   `GL_CODE_COMBINATIONS_KFV`: the seven accounts, for material, outside processing, material overhead, overhead, resource, expense and encumbrance.
*   `ENG_ECN_APPROVAL_LISTS`: the notification list.
*   `HR_LOCATIONS`: the subinventory location.
*   `MTL_CYCLE_COUNT_HEADERS`: the opportunistic cycle count header.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

### Logical Relationships
1. `MTL_SECONDARY_INVENTORIES` joins to `MTL_PARAMETERS` on organization id, and the organization is limited through the access view.
2. The status, cost group, notification list, location and cycle count header are outer joins on their identifiers.
3. Each of the seven accounts joins to `GL_CODE_COMBINATIONS_KFV` on its code combination id, as a separate outer join.
4. The source organization joins to `MTL_PARAMETERS` a second time, so the source organization code is returned alongside the subinventory.
5. Subinventories named AX_INTRANS are excluded from the result.

## Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing subinventories.
*   **Organization Code:** restricts the subinventories to one organization.
*   **Subinventory:** restricts the download to one subinventory name.
*   **Status:** restricts the subinventories to one material status.
*   **Default Cost Group:** restricts the subinventories to one cost group.
*   **Type, Include in ATP, Allow Reservation, Nettable and Quantity Tracked:** restrict the subinventories to one value of each flag.
*   **Asset Subinventory and Locator Control:** restrict the subinventories to one asset setting or locator control.

## Performance & Optimization
*   The organization filter uses the access view, so the main scan covers only the organizations the responsibility can use.
*   The seven account joins are outer joins on code combination id, which keeps subinventories with no account for a given type in the download.
*   Flag values are decoded with lookup meanings in the query, so the workbook shows Yes and No rather than codes.

## FAQ
**Q: Why does changing the cost group also change the accounts?**
A: In a WMS organization the cost group drives the accounts. Changing it on an existing subinventory switches all seven accounts to those assigned to the new cost group.

**Q: How do I delete a subinventory?**
A: The upload has no delete option. Set Inactive On to a past date to inactivate the subinventory.

**Q: Why can I not change the material status in the upload?**
A: When electronic records and signatures are enabled, status changes must be made in the Subinventories form to keep the signature audit trail.
