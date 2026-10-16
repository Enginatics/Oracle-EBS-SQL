# Case Study & Technical Analysis: PA Invoice Review

## Executive Summary
The PA Invoice Review report lists Oracle Projects draft invoices with their line details. For each draft invoice it shows the invoice amount, the approval, release and transfer status, the bill-to customer, the GL date and the project period, and for each line the amount, description, task and event. Project billing and revenue teams use it to review draft invoices before they are released to receivables, to check the approval state of each invoice, and to confirm which lines make up a billing cycle. The report runs in Excel via Blitz Report.

## Business Challenge
*   **Pre-release review:** Draft invoices must be checked for amount, customer and dates before they are released, and a line-by-line review in the forms is slow.
*   **Approval tracking:** Invoices move through approval, release and transfer, and billing teams need to see which stage each invoice has reached.
*   **Customer and task alignment:** Each invoice line carries a task and event, and reviewers must confirm that the billed work matches the bill-to customer.
*   **Period and GL date control:** The GL date and the Projects period decide where the revenue is recognized, so they must be visible at review.

## The Solution
*   **Invoice-level totals:** The invoice amount is the sum of its draft invoice line amounts for the same project and invoice number.
*   **Status flags:** Approved, Released and Transferred are shown as Yes or No, with their dates beside them.
*   **Line detail:** Each line shows its line number, amount, description, task number and event number.
*   **Audit columns:** The creator, creation date, last updater and last update date are returned for each draft invoice.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_DRAFT_INVOICES_ALL`: the draft invoice header, with invoice number, dates, currency, bill-to customer, status dates and GL date.
*   `PA_DRAFT_INVOICE_ITEMS`: the draft invoice lines, with line number, amount, text, task and event.
*   `PA_PROJECTS_ALL`: the project number, name and organization.
*   `PA_TASKS`: the task number for each invoice line.
*   `HZ_CUST_ACCOUNTS`: the bill-to customer account and its number.
*   `HZ_PARTIES`: the customer party name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating unit access list for the session.

### Logical Relationships
1. `PA_DRAFT_INVOICES_ALL` is joined to `PA_DRAFT_INVOICE_ITEMS` on project and draft invoice number.
2. `PA_DRAFT_INVOICES_ALL` is joined to `PA_PROJECTS_ALL` on project identifier, and the project's organization is joined to `HR_ALL_ORGANIZATION_UNITS_VL`.
3. `PA_DRAFT_INVOICES_ALL` is outer joined to `HZ_CUST_ACCOUNTS` on the bill-to customer identifier, and to `HZ_PARTIES` on party identifier.
4. Each invoice line is outer joined to `PA_TASKS` on task identifier to return the task number.
5. The invoice amount is a scalar subquery that sums the line amounts of the same project and invoice.

## Parameters & Filtering
*   **Operating Unit:** Restricts the output to one operating unit within the accessible set.
*   **Project:** Restricts the draft invoices to one project.
*   **Invoice Date From and To:** Restrict the draft invoices by their invoice date.
*   **Released:** Restricts the draft invoices by release status.

The SQL text does not reference these parameters through bind variables. The rows are determined by the operating unit access list and the joins described above.

## Performance & Optimization
*   The organization restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, unioned with the current organization for release 11, which keeps the read to the permitted operating units.
*   The invoice amount is a correlated scalar subquery on `PA_DRAFT_INVOICE_ITEMS`, which runs once for each line returned.
*   Customer and task lookups are outer joins on keyed columns, so they do not multiply the rows.
*   The query uses no aggregation at the outer level and no analytic functions.

## FAQ
**Q: How do I see whether a draft invoice has been released to receivables?**
A: The Released column shows Yes when a released date exists, with the released date beside it.

**Q: Why does the invoice amount repeat on every line?**
A: The invoice amount is the total of all lines for the same project and draft invoice number, so it is repeated on each line of that invoice.

**Q: Which customer is shown for a draft invoice?**
A: It is the bill-to customer on the draft invoice header, shown by its party name and account number.
