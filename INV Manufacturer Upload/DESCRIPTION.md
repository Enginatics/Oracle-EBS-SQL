# Case Study & Technical Analysis: INV Manufacturer Upload

## Executive Summary
This upload maintains the manufacturers master in Oracle Inventory. It downloads the manufacturers of the instance with their description, their descriptive flexfield values and the number of manufacturer part numbers each one has, and lets an item master or purchasing administrator create, update and delete manufacturers in a spreadsheet. Manufacturers are linked to items through manufacturer part numbers, which the Oracle item and purchasing processes use to identify the make and model of a supplied item. The upload is used when a catalogue of manufacturers is loaded for a new implementation, when many manufacturer names are standardized, or when obsolete manufacturers are retired. Blitz Report™ provides the spreadsheet layout for these changes.

## Business Challenge
*   **Standard manufacturer names:** Items often come from the same manufacturers under slightly different names, and a clean list is needed for reporting and sourcing.
*   **Bulk loading during implementation:** A new Inventory setup needs a large list of manufacturers, which is slow to enter one at a time.
*   **Protecting linked data:** A manufacturer that is already linked to part numbers must be recognized before it is changed or removed.
*   **Consistent attributes:** Descriptive flexfield values on manufacturers must be entered in the same way across the list.

## The Solution
*   Downloads every manufacturer from `MTL_MANUFACTURERS`, with its name and description.
*   Counts the manufacturer part numbers linked to each manufacturer in `MTL_MFG_PART_NUMBERS`, so a manufacturer in use can be identified before a delete.
*   Shows the descriptive flexfield context and the fifteen attribute segments of each manufacturer, with the segment labels and values resolved for the flexfield.
*   Provides a Delete Manufacturer column, so the manufacturers to remove can be marked in the same file used to update the others.
*   Keeps the manufacturer identifier on each row, so an updated row can be matched to the existing record.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_MANUFACTURERS`: the manufacturer master, with the manufacturer name, description, identifier and the flexfield attribute columns.
*   `MTL_MFG_PART_NUMBERS`: the manufacturer part numbers, each linked to one manufacturer identifier.

### Logical Relationships
1. The manufacturer master is read on its own, and each row is filtered by the upload mode.
2. The count of part numbers is a correlated subquery, joined on the manufacturer identifier of the master row.
3. The flexfield context and value columns are resolved by the flexfield functions for the Inventory flexfield of manufacturers, which uses the attribute category of each row.

## Parameters & Filtering
*   **Upload Mode:** selects a download for review and editing, which is available only when the mode includes Update.
*   **Manufacturer:** selects one manufacturer by name.
*   **Manufacturer From** and **Manufacturer To:** select a range of manufacturer names.

## Performance & Optimization
*   The report reads one master table, so its cost is dominated by the number of manufacturers, which is normally small.
*   The part number count is a correlated subquery that counts rows in `MTL_MFG_PART_NUMBERS` by manufacturer identifier, so the count is available without a separate upload step.
*   The flexfield translations are applied only to the columns of the attribute segments, and each one uses the row's own attribute category.
*   Because the list is small, the name range parameters are the most useful way to limit the download when the instance holds a large catalogue.

## FAQ
**Q: How do I rename a manufacturer that has part numbers?**
A: Download the manufacturer, change the Manufacturer name, and upload with Create, Update. The manufacturer identifier on the row keeps it matched to the existing record.

**Q: How can I see whether a manufacturer is used before deleting it?**
A: The manufacturer part number count column shows how many manufacturer part numbers reference the manufacturer.

**Q: Can I create new manufacturers from this report?**
A: Yes. Use the Create mode to download an empty template, enter the manufacturer names and descriptions, and upload.
