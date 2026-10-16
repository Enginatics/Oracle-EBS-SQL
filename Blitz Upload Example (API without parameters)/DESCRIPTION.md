# Case Study & Technical Analysis: Blitz Upload Example (API without parameters)

## Executive Summary
The Blitz Upload Example (API without parameters) is a template for building Blitz Report uploads that load data from Excel into Oracle E-Business Suite through an API that takes no parameters. It shows the minimum structure of an upload: the four standard control columns, which the upload framework uses to report the action, status, message and modified columns of each row, followed by the data columns of the example table. Developers copy it with Tools > Copy Report to create a new upload, and then change the columns and the API. The report itself reads a small example table, so it is a working reference rather than a business report.

## Business Challenge
*   **Starting point:** A developer building a new upload needs a correct template with the control columns in place, since an upload without them cannot return row-level results to Excel.
*   **API design:** An API that is called without parameters receives all the uploaded records at once, and the developer must know how to read them.
*   **Validation feedback:** The user needs a status and a message against each row, so that errors can be corrected in the spreadsheet and uploaded again.
*   **Consistency:** Every upload in the Enginatics library follows the same column conventions, so that users find the same layout in each one.

## The Solution
*   Provides the four control columns, Action, Status, Message and Modified Columns, as null values in the query, to be filled by the upload framework.
*   Returns the example record fields, id, name and date of birth, from the example table, so the developer sees how data columns follow the control columns.
*   Describes in the description that the API is called once by the upload framework, and that the uploaded records are read in the API from the Data View of the upload.
*   Uses the Name parameter as a placeholder, so the template also shows how a report parameter is declared.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_UPLOAD_EXAMPLE`: the example table that holds the sample records shown by the template.

### Logical Relationships
1.  The query selects from `XXEN_UPLOAD_EXAMPLE` under an always-true condition, `1=1`, so the template returns every row of the example table.
2.  The four leading NULL columns, action, status, message and modified columns, are placeholders that the upload framework uses to write the result of each row.
3.  Uploaded rows are stored in a data view named after the upload, and the API reads them by selecting from that view where the status column equals the valid status value of the framework.

## Parameters & Filtering
*   **Name:** the example parameter. It is declared in the report definition to show how a parameter is presented to the user; the query text does not filter on it.

## Performance & Optimization
*   The template contains no joins, aggregate functions or subqueries, so it returns each row of the example table once.
*   The query selects only the four control columns and three data columns, which keeps the template small enough to copy and adapt.
*   Developers adding joins to reference data should filter the main table on its primary key first, as the template does not show a join pattern to copy.

## FAQ
**Q: How do I create a new Blitz Report upload from this example?**
A: Copy the report with Tools > Copy Report, then change the query and the columns to the table your upload writes to. Keep the four leading control columns, because the upload framework uses them.

**Q: How does the API read the uploaded records when it has no parameters?**
A: The framework calls the API once. The API selects the uploaded rows from the data view named after the upload, and filters them on the valid status value.

**Q: What are the action, status, message and modified columns for?**
A: They are the control columns of an upload. The framework fills them with the outcome of each row, so that errors and results are shown against the row in Excel.
