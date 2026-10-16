# Case Study & Technical Analysis: INV Item Upload 11i

## Executive Summary
The INV Item Upload 11i creates and updates Inventory Items in Oracle Inventory from an Excel spreadsheet. Each row describes one item in one organization, covering main attributes, inventory controls, costing, purchasing, planning, order management, service and the item's descriptive flexfield values, with optional manufacturer part numbers and category assignments. Item masters, supply chain planners and implementation teams use it to set up new items, copy items from a template or an existing item, and maintain attributes in bulk across master and child organizations. The report runs in Excel via Blitz Report, and changes are loaded through the Item Import process.

## Business Challenge
*   **Item master setup at scale:** Creating items one at a time in the Master Items form is slow when a product launch or an acquisition adds hundreds of items.
*   **Attribute consistency:** Items need the same attribute values across many organizations, and inconsistent setup causes planning, costing and shipping errors.
*   **Category assignments:** Items must be assigned to several category sets, and each category set has its own rules for which organizations may use it.

## The Solution
*   **Multiple creation routes:** Items can be entered manually, created from a master row with child organization assignments, copied from a template, or copied from an existing item in the same organization.
*   **Update from download or paste:** Existing items are downloaded with the report parameters, or details can be pasted into an empty upload file.
*   **Category and manufacturer rows:** Additional category set assignments and manufacturer part numbers are entered as extra rows, and a category can be deleted by setting the Delete Category column.
*   **Null handling control:** When a create action updates an existing item, Null Means Clear or Null Means No Change determines how blank values are treated.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_SYSTEM_ITEMS_VL`: the item attributes for each organization, including all the item flags, codes and values the upload covers.
*   `MTL_PARAMETERS`: the organization codes, and the master organization of each organization.
*   `MTL_ITEM_CATEGORIES`, `MTL_CATEGORY_SETS_VL`, `MTL_CATEGORIES_KFV`: item category assignments, their category sets and category values.
*   `MTL_MFG_PART_NUMBERS`, `MTL_MANUFACTURERS`: manufacturer part numbers and manufacturer names.
*   `MTL_ITEM_STATUS`, `MTL_MATERIAL_STATUSES`, `MTL_UNITS_OF_MEASURE_TL`, `MTL_UOM_CONVERSIONS`: status, lot and serial status, and unit of measure descriptions.
*   `MTL_ITEM_CATALOG_GROUPS_B_KFV`, `MTL_ITEM_LOCATIONS_KFV`, `MTL_ATP_RULES`, `MTL_PICKING_RULES`: catalog group, locator, ATP and picking rule names.
*   `GL_CODE_COMBINATIONS_KFV`, `FA_CATEGORIES_B_KFV`, `RCV_ROUTING_HEADERS`, `PO_UN_NUMBERS`, `PO_HAZARD_CLASSES`: accounts, asset category, receiving routing and hazard references.
*   `PER_PEOPLE_X`, `RA_RULES`, `RA_TERMS_VL`, `OKS_COVERAGE_TEMPLTS_V`: buyer, accounting and invoicing rule, payment term and coverage template names.
*   `ORG_ACCESS_VIEW`: the organizations accessible to the current responsibility.

### Logical Relationships
1. `MTL_SYSTEM_ITEMS_VL` is joined to `MTL_PARAMETERS` to obtain the master organization of each item's organization.
2. `MTL_ITEM_CATEGORIES` is joined to the category set and category tables, and is included only when the template includes category columns.
3. `MTL_MFG_PART_NUMBERS` is joined on the master organization or the item, depending on whether the template includes manufacturer part numbers.
4. Many attribute values are resolved through `XXEN_UTIL.MEANING` lookups on the item's codes, and the remaining names through single-row scalar subqueries on their master tables.

## Parameters & Filtering
*   **Upload Mode:** Create creates new items only, Update changes existing items only, and Create, Update does both; an update download is included only when the mode contains the update action.
*   **Create Empty File:** When Yes, the update download is suppressed and an empty upload file is opened. Create mode always opens an empty file.
*   **Update on Create Null Handling:** Null Means Clear removes values from the matching columns, and Null Means No Change leaves them unchanged.
*   **Number of Item Import Workers:** Sets the number of parallel Item Import requests.
*   **Organization Code, Category Set, Category:** Restrict the downloaded items to an organization, category set or category value.
*   **Item, Item Like, Item Description, Item Type, Item Status:** Restrict the items by identifier, pattern, description, type or status.

## Performance & Optimization
*   The download is suppressed entirely when the create empty file flag is set or the mode excludes updates, so no item rows are read in those cases.
*   Category and manufacturer part joins are included only when the template requires them, using template flags substituted into the SQL.
*   Organizations are restricted by an `IN` subquery on `ORG_ACCESS_VIEW`, limiting the item scan to the responsibility's organizations.

## FAQ
**Q: How do I assign an item to a second category set?**
A: Repeat the Organization Code and Item Number on a separate row, and enter the new Category Set and Item Category on that row before uploading.

**Q: Why are master-controlled attributes of child items not taken from my spreadsheet?**
A: The Import API defaults them from the master organization for new child items, and copies them for existing ones.

**Q: How do I delete an item category assignment?**
A: Download the item, then set the Delete Category column to Yes on the row for the category set and category to remove; mandatory category sets cannot be deleted.
