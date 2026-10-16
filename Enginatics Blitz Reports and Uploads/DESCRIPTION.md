# Case Study & Technical Analysis: Enginatics Blitz Reports and Uploads

## Executive Summary
The Enginatics Blitz Reports and Uploads report is the catalog of the standard Enginatics reports and uploads for Oracle E-Business Suite. It lists every library entry whose category includes Enginatics, with its application, report name, type and description, and links each name to its library page on enginatics.com. Consultants, finance users and DBAs use it to find the right template for an Oracle EBS task, and to see which example files are published for it. The catalog itself runs in Excel via Blitz Report, so the list can be filtered, sorted and kept alongside working files.

## Business Challenge
*   **Finding the right template:** The library holds reports and uploads across many EBS modules, and a user needs a quick way to locate the one that matches a task.
*   **Version fit:** Templates are used with different EBS releases, so the catalog must show the release context for the entry being chosen.
*   **Report versus upload:** Reporting templates and upload templates serve different purposes, and users need to separate them before downloading.
*   **Example files:** Users often want to see a sample output before running a template against production data.

## The Solution
*   **Application derivation:** The application name is derived from the leading word of the report name, so each entry is grouped with its EBS module.
*   **Hyperlinked names:** Where a web report exists, the report name links to its library page, and the example file name links to its example page.
*   **Type classification:** Each entry is shown as a report or as its stored type, such as an upload, so the two kinds can be sorted apart.
*   **Release-aware columns:** The EBS Version parameter controls the release-specific columns, which are inserted into the select list through a substitution.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_REPORTS_V`: the local view of the report and upload definitions, with name, type, category and description.
*   `XXEN_REPORTS` (database link `demo`): the underlying report registry, keyed by a global identifier.
*   `XXEN_WEB_REPORTS_V` (database link `demo`): the published web report view, with the web report name and example file name.

### Logical Relationships
1. `XXEN_REPORTS_V` is filtered to rows whose category contains Enginatics.
2. `XXEN_REPORTS` is outer joined on the global identifier (guid) of each library entry.
3. `XXEN_WEB_REPORTS_V` is outer joined on report_id, so entries without a published web page still appear with their plain name.
4. The application name is derived from the report name, and the output is ordered by type and report name.

## Parameters & Filtering
*   **EBS Version:** Selects the release-specific column set that is substituted into the select list through the `&release_columns` placeholder.
*   **Type:** Limits the catalog to one entry type. The type shown for each row is the stored type, or Report when none is set.

## Performance & Optimization
*   The category filter on `XXEN_REPORTS_V` is applied first, so only Enginatics entries are joined to the remote tables.
*   The two remote views are outer joined rather than inner joined, which keeps every catalog entry even when no web page exists for it.
*   The application name is computed from a substring of the report name, which avoids a join to an application table.
*   The query returns a small, static catalog, so the remote joins do not involve large data volumes.

## FAQ
**Q: Where can I see all Enginatics Oracle EBS reports and uploads?**
A: The catalog lists them with a link to each library entry at enginatics.com, under the Enginatics category of the library.

**Q: How do I find an example output for a template?**
A: Where an example file is published, the Example File column is a hyperlink to its example page.

**Q: How do I separate upload templates from reports in the catalog?**
A: Sort or filter by the Type column, which shows each entry's stored type, with Report used where no type is set.
