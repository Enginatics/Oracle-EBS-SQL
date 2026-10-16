# Case Study & Technical Analysis: Blitz Report Columns

## Executive Summary
Blitz Report Columns is a metadata report for the Blitz Report™ library itself. It lists every SQL column of the Blitz Reports held in an Oracle EBS instance, with the column position, the translated column header, the underlying column alias and the Oracle data type. It is written for Blitz Report administrators, report developers and EBS technical consultants who maintain or review a library of Excel-based reports and need to find which report exposes a given field, or which reports share a column header. The report supports the governance task of documenting and auditing report content before reports are shared, changed or retired.

## Business Challenge
*   **Report Discovery:** A large library of reports makes it hard to locate the report that returns a particular field, such as a specific flexfield or status code.
*   **Inconsistent Headers:** Reports built by different developers may label the same underlying column with different headers, which confuses users comparing outputs.
*   **Change Impact:** Before altering a shared SQL pattern, the team needs to know every report that exposes the affected column.
*   **Documentation Gaps:** Column-level documentation for report libraries is rarely maintained by hand, so a generated listing is the only reliable inventory.

## The Solution
*   **Parsing On The Fly:** The report reads the stored SQL of each Blitz Report and derives its column list at run time rather than relying on a manually kept document.
*   **Report Context:** Each row is joined to its report name, its category and a type value that shows whether the item is a report or another Blitz object type.
*   **Header Translation:** The column header is resolved through the Blitz Report column translation function, so the header shown matches what end users see in Excel.
*   **Scoped Filtering:** Category, Report Type, Report Name, a name pattern and a column header search narrow the result to the reports under review.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_REPORTS_V`: the view of Blitz Reports that supplies the report name, the report type and the report identifier used for the join.
*   `XXEN_REPORT_SQL_COLUMNS`: the table holding one row per column of each report's SQL, with the column number, the column name and the data type.

### Logical Relationships
1.  `XXEN_REPORT_SQL_COLUMNS` is joined to `XXEN_REPORTS_V` on the report identifier, so every column row carries its report name and type.
2.  The category of each report is derived from the report identifier through the Blitz Report API category function.
3.  The column header is produced from the stored column name through the column translation function, while the lower case column name is returned alongside it.
4.  Rows are ordered by report name and then by column number, so each report's columns appear in their SQL sequence.

## Parameters & Filtering
*   **Category:** Restricts the output to reports in the selected Blitz Report category.
*   **Report Type:** Limits the result to one type value. Reports with no type are shown as Report.
*   **Report Name:** Selects one specific report by its exact name.
*   **Report Name like:** Applies a pattern match to the report name, useful for a family of related reports.
*   **Column Header contains:** Filters on the translated column header, so a search for a field label returns every report that displays it.

## Performance & Optimization
*   **Parsing Cost:** The report parses SQL text for each report in scope. Running it with no filters processes every enabled report and can take several minutes, so scoping by Category or Report Name is the recommended approach.
*   **Predicate Placement:** Filters are applied to the report view, so the parse is limited to reports that pass the selection before the column rows are returned.
*   **Simple Structure:** The statement is a single join with an order by and no aggregation, so the cost is dominated by the number of reports and columns rather than by query complexity.

## FAQ
**Q: How do I find every Blitz Report that shows a particular column header?**
A: Enter the header text in the Column Header contains parameter. The report returns each matching column with its report name and column number.

**Q: Why does the report take several minutes to run?**
A: With no parameters it parses the SQL of every enabled report. Set Category or Report Name to reduce the number of reports that are parsed.

**Q: Does the output show the data type of each column?**
A: Yes. Each row includes the data type of the column as stored in the report's SQL column definition.
