# Case Study & Technical Analysis: MRP Master Schedule Upload

## Executive Summary
MRP Master Schedule Upload creates and changes the entries of Oracle Master Demand Schedules and Master Production Schedules, the planned quantities by item and date that drive material requirements planning. Each row stages one schedule entry for an existing schedule designator, and the staged entries are loaded into the master schedule asynchronously by the MRP Planning Manager. Demand planners, production planners and supply chain analysts use it to load forecast quantities, revise planned production, and enter schedule changes for many items in one spreadsheet rather than one date at a time.

## Business Challenge
*   **Forecast Loading:** Demand forecasts for a planning horizon must be entered for many items and dates, which is slow in the schedule form.
*   **Frequent Revisions:** Planners revise schedule quantities often as orders and forecasts change, so the revision cycle needs a repeatable spreadsheet process.
*   **Schedule Consistency:** Entries must reference a valid schedule designator, item and organization, or the planning run rejects them.
*   **Traceability:** Revised entries must be matched to the entries they replace, so the history of a schedule stays clear.

## The Solution
*   **New and Existing Entries:** Create mode opens an empty sheet for new entries, while Create and Update downloads the existing entries of the selected designators.
*   **Matching On Transaction Identifier:** Existing entries are matched through a hidden transaction identifier, so a revised quantity updates the right entry.
*   **Staged Load:** Each row is written to the MRP schedule interface with a pending status, to be loaded by the planning manager process.
*   **Attributes:** Schedule comments and the fifteen user attribute columns are carried with each entry.

## Technical Architecture (High Level)
### Primary Tables
*   `MRP_SCHEDULE_DESIGNATORS`: the master demand and master production schedule definitions, with their type and description.
*   `MRP_SCHEDULE_DATES`: the schedule entries, with the item, date, quantity, end date, comments and attributes.
*   `MTL_SYSTEM_ITEMS_VL`: the items, with their concatenated segments, primary unit of measure and planner code.
*   `MTL_PARAMETERS`: the organizations that own the schedules.

### Logical Relationships
1.  Each schedule designator in `MRP_SCHEDULE_DESIGNATORS` is joined to its organization in `MTL_PARAMETERS`.
2.  Schedule entries in `MRP_SCHEDULE_DATES` are joined to their designator on organization and schedule designator.
3.  Entries are restricted to schedule level 2, the item level of the schedule.
4.  Each entry is joined to `MTL_SYSTEM_ITEMS_VL` on organization and inventory item identifier to return the item, unit of measure and planner.
5.  The transaction identifier of each entry is returned as the key used when a row is matched on upload.

## Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update, which controls whether existing entries are downloaded.
*   **Default Workday Control:** Sets the workday control value applied to new entries.
*   **Organization Code:** Restricts the schedules to one organization.
*   **Schedule Type:** Restricts the designators to master demand or master production schedules.
*   **Schedule Name:** Restricts the output to one schedule designator.
*   **Planner and Item:** Restrict the entries to items with one planner code or to one item.
*   **Schedule Date From and Schedule Date To:** Limit the entries to a date window.

## Performance & Optimization
*   **Designator Driven Extract:** The organization and designator relationship restricts the entries to the selected schedules before the item join.
*   **Item Level Restriction:** Only item level entries are read, which keeps the extract to the rows a planner maintains.
*   **Create Mode Suppression:** In Create mode the existing entries are not read, so the template is empty and the extract is minimal.
*   **Asynchronous Load:** The upload writes to an interface rather than to the master schedule directly, so the heavy loading work is done by the planning process.

## FAQ
**Q: Does the upload change the master schedule immediately?**
A: No. Each row is staged in the MRP schedule interface with a pending process status, and the MRP Planning Manager loads it into the master schedule.

**Q: How are changes to existing schedule entries matched?**
A: They are matched on the hidden transaction identifier of each downloaded entry, so the template must be the one downloaded for the schedule.

**Q: What are the prerequisites for the upload?**
A: The schedule designators, either master demand or master production schedules, must be defined before entries are uploaded.
