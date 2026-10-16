# Case Study & Technical Analysis: Blitz Report Category Assignment Upload

## Executive Summary
This upload maintains the Blitz Report category assignments, which are the categories that reports and uploads are grouped under in the Blitz Report library. Administrators of a Blitz Report installation use it to place many reports into categories at once, to create new categories and to remove reports from categories, rather than assigning them one by one in the user interface. The file is worked in Excel through Blitz Report™ and uploaded back to the same framework.

## Business Challenge
*   **Library organization:** A growing set of reports and uploads is hard to navigate unless each one sits in a sensible category.
*   **Bulk maintenance:** Re-categorizing dozens of reports one at a time is slow and easy to get inconsistent.
*   **New categories:** Introducing a category should not require a separate setup step for every installed language.
*   **Controlled removal:** A report should be removable from one category without losing the category itself, even when it becomes empty.

## The Solution
*   Downloads the existing report list, filtered by name, category or type, as blank rows to which categories are assigned, or as existing assignments that can be changed.
*   Creates a missing category automatically in all installed languages and assigns the report to it, when a Category name is entered on a row.
*   Removes a report from a category when its Delete column is set to Yes, and keeps the category itself even when it is then empty.
*   Offers an empty template through Create Empty File, for entering new report and category rows from scratch.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_REPORTS_V`: the Blitz Report definitions, supplying the report name and type.
*   `XXEN_REPORT_CATEGORY_ASSIGNS_V`: the existing report-to-category assignments, with the category name and the creator and creation date of each assignment.

### Logical Relationships
1.  Each report in `XXEN_REPORTS_V` is listed unless its type is S, which excludes that class of report from the library.
2.  The assignments are joined to the reports with an outer join on the report identifier, so reports without any category still appear.
3.  The assignments subquery is empty when the upload mode is Create, so the download is a clean list of reports for new assignments.
4.  When Create Empty File is Yes, the report list is suppressed and only the empty template is returned.
5.  Rows carry the blank action, status, message and delete columns that the upload framework uses to record the outcome of each change.

## Parameters & Filtering
*   **Upload Mode:** Create returns reports without their existing assignments; Create, Update also returns the current assignments for change or deletion.
*   **Create Empty File:** when set to Yes, returns an empty file rather than the report list.
*   **Report Name starts with:** limits the reports listed to names with the given prefix.
*   **Report Category:** limits the listing to one category.
*   **Report Type:** limits the listing to one type of report.

## Performance & Optimization
*   The assignment view is filtered by upload mode inside an inline view, so the assignment rows are not read at all in Create mode.
*   The outer join on report identifier keeps the report list complete at the cost of one lookup per report, which is small because the library is a single catalog.
*   The type exclusion is applied on the report view before the join, so excluded reports never reach the assignment lookup.
*   Because the upload works on the two Blitz Report views only, its run time depends on the size of the report library and not on the Oracle EBS data.

## FAQ
**Q: How do I remove a report from a category without deleting the category?**
A: Download the assignments in Create, Update mode, set the Delete column to Yes on the row for that report and category, and upload the file; the category is kept even if it becomes empty.

**Q: Does the upload create a new category?**
A: Yes, entering a category name that does not exist creates it automatically in all installed languages and assigns the report to it.

**Q: Which reports can be listed?**
A: The download lists the reports in the Blitz Report library except those of type S, and can be narrowed by name prefix, category or report type.
