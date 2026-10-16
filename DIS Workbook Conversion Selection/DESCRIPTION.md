# Case Study & Technical Analysis: DIS Workbook Conversion Selection

## Executive Summary
The DIS Workbook Conversion Selection report supports the migration of Oracle Discoverer workbooks to Blitz Report. It lists the Discoverer workbook XML files that have been uploaded into Blitz Report and enriches each with the information needed to decide which workbooks to convert: the latest run date, run count and distinct users from the end user layer's usage statistics, the last update and creation dates of the workbook, its owner, description and sheet count. It is written for the project teams and reporting administrators who are replacing Discoverer in an Oracle EBS environment.
## Business Challenge
*   **Too many workbooks to convert:** Discoverer environments often hold a large number of workbooks, and not all are still in use, so converting everything wastes effort.
*   **Evidence-based selection:** The team needs usage evidence, such as the last run date and number of users, to decide which workbooks justify conversion.
*   **Ownership and currency:** The owner and last update date of each workbook help the team to contact the right people and to spot abandoned work.

## The Solution
*   **Usage enrichment:** The workbook list is joined to the end user layer's query statistics, so each workbook shows its last run date, run count and distinct users.
*   **Workbook metadata:** Owner, description, creation and update dates are taken from the end user layer document where it exists, falling back to the values in the uploaded XML.
*   **Selection stored on the file:** Setting Convert Workbook to Yes stores the selection on the staged workbook XML for the import program to act on.
*   **Optional immediate import:** With Submit Import set to Yes, the upload submits the import, waits for it to complete and reports the Blitz reports and templates created for each workbook.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_DISCOVERER_WORKBOOK_XMLS`: the uploaded Discoverer workbook XML files, with their identifiers, end user layer and upload dates.
*   `XXEN_DISCOVERER_SHEETS`: the worksheets in each uploaded workbook, used to match Blitz reports to sheets.
*   `XXEN_REPORTS_V`: the Blitz reports, with their names, descriptions and creation dates, used to find the reports created from each workbook.
*   The end user layer tables `EUL5_DOCUMENTS` and `EUL5_QPP_STATS`, referenced through the `&eul` schema prefix: the document definitions and the query usage statistics.

### Logical Relationships
1. The uploaded workbook XML records are joined to `EUL5_DOCUMENTS` on the document identifier, as an outer join, so workbooks missing from the end user layer are listed.
2. The workbook name, with its `.dis` suffix removed and the text converted to upper case, is matched to the usage statistics in `EUL5_QPP_STATS`.
3. Worksheets are matched to Blitz reports through an object identifier key stored in the report description, which links each sheet to the report created from it.
4. Each workbook's converted reports are aggregated into one row, with the names concatenated and the earliest creation and latest update dates.
5. The three result sets are joined on the workbook identifier and the upper-cased workbook name.

## Parameters & Filtering
*   **Upload Mode:** Selects whether the selection is being recorded for conversion.
*   **End User Layer:** Identifies the Discoverer end user layer whose documents and statistics are used.
*   **Workbook and Workbook Id:** Restrict the list to one workbook by name or by identifier.
*   **Submit Import:** When Yes, the upload submits the Blitz Report Discoverer Import program after storing the selection.

## Performance & Optimization
*   **Stats aggregated first:** The usage statistics are grouped by normalised workbook name before the join, so each workbook joins to one statistics row.
*   **Inline views without merge:** The sheet selection and report mapping are placed in `no_merge` inline views, which keeps the matching logic evaluated once.
*   **Distinct sheets:** Sheets are selected with `distinct` before the object key is computed, so duplicate sheet rows do not multiply the report matches.
*   **Import is separate:** The conversion itself runs in the concurrent program, so the report's cost is limited to the listing and to the optional wait for the import.

## FAQ
**Q: How do I decide which Discoverer workbooks to convert to Blitz Report?**
A: Review the run count, last run date and distinct users for each workbook, set Convert Workbook to Yes for those to keep, and upload the file.

**Q: Why does a workbook show no run count or last run date?**
A: The usage statistics are informational only, and a workbook without any usage history is still listed with an empty run count and last run date.

**Q: Where can I find the migration process for Discoverer workbooks?**
A: The report description links to the Enginatics blog post on Discoverer replacement with Blitz Report.
