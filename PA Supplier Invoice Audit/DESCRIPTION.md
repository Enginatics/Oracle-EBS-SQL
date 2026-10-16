# Case Study & Technical Analysis: PA Supplier Invoice Audit

## Executive Summary
The PA Supplier Invoice Audit report shows supplier invoices that have been charged to Oracle Projects, with the vendor, the invoice, the project and task, the cost distribution and the general ledger transfer details. It is written for project accounting teams, internal auditors and project controllers who must verify that supplier costs have been charged to the right project and task and transferred to the general ledger. Each row is a cost distribution line of type R, which is the Payables-originated cost, so the report traces a supplier invoice from Payables into project costing and on to the GL account. It sits in the Projects module and is restricted to R12.

## Business Challenge
*   **Supplier cost on projects:** Supplier invoices charged to projects must be validated, because a wrong task or project distorts project profitability and billing.
*   **Tracing to the GL:** Auditors need to see whether each project cost has been transferred to the general ledger and on which date.
*   **Transfer failures:** Cost distributions that have not transferred are a control weakness, and their status must be visible.
*   **Audit evidence:** Expenditure audits require the invoice number, vendor, date and amount alongside the project coding.

## The Solution
*   **Invoice-to-project trace:** Each row links an Accounts Payable invoice to its project expenditure item, project, task and expenditure, so the path from supplier to project is shown.
*   **Distribution-level detail:** The report returns the distribution line number, the accounting period, the GL date and transfer date, and the transfer status.
*   **Cost amounts:** Raw cost and burdened cost are shown for each distribution, with the expenditure item quantity.
*   **GL account visibility:** The debit account of the cost distribution is shown as a concatenated GL account.
*   **Audit trail:** The creator and creation date of each distribution are returned.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_COST_DISTRIBUTION_LINES_ALL`: the cost distribution lines, with the amounts, GL date, transfer date and transfer status.
*   `PA_EXPENDITURE_ITEMS_ALL`: the expenditure items, with the expenditure type, quantity, date and document header link.
*   `PA_EXPENDITURES_ALL`: the expenditure batch that holds the items.
*   `PA_PROJECTS_ALL`: the projects.
*   `PA_TASKS`: the project tasks.
*   `AP_INVOICES_ALL`: the Payables invoice that is the source of the cost.
*   `AP_SUPPLIERS`: the vendor name and number.
*   `GL_CODE_COMBINATIONS_KFV`: the debit account of the distribution.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the organisations accessible to the current user.

### Logical Relationships
1. `PA_COST_DISTRIBUTION_LINES_ALL` joins to `PA_EXPENDITURE_ITEMS_ALL` on the expenditure item identifier.
2. Expenditure items join to `PA_EXPENDITURES_ALL`, `PA_PROJECTS_ALL` and `PA_TASKS` on their identifiers.
3. Expenditure items join to `AP_INVOICES_ALL` as an outer join on the document header identifier, which is the invoice identifier for supplier items.
4. The invoice joins to `AP_SUPPLIERS` as an outer join on the vendor identifier.
5. The distribution joins to `GL_CODE_COMBINATIONS_KFV` as an outer join on the debit code combination.
6. The project's operating unit is joined through `HR_ALL_ORGANIZATION_UNITS_VL`.
7. Only distribution lines of type R, and expenditure items with the VI system linkage function, are returned.

## Parameters & Filtering
*   **Operating Unit:** The description lists it as a parameter. The SQL restricts the output to organisations in the access table, so the operating unit is applied within that set.
*   **Project:** Restricts the rows to one project.
*   **Vendor:** Restricts the rows to one supplier.
*   **GL Date From and GL Date To:** Bound the GL date of the cost distribution lines.

The SQL text in the library does not reference these parameters by name, so the filters are applied by the report framework and not by predicates shown in the query.

## Performance & Optimization
*   **Fixed linkage filters:** The query restricts distribution lines to type R and expenditure items to the VI linkage function before the joins, which reduces the set to supplier invoice costs.
*   **Organisation access filter:** Projects are limited to the operating units in the access table, which keeps the scan to permitted organisations.
*   **Outer joins for transfers:** Invoice, supplier and account joins are outer, so distributions that have not transferred or are not linked to an invoice are still listed for audit.

## FAQ
**Q: How do I see which supplier invoices were charged to a project in Oracle Projects?**
A: Run PA Supplier Invoice Audit and filter by project number. Each row shows the invoice number, vendor, task and cost.

**Q: How can I check whether a supplier cost has transferred to the general ledger?**
A: Read the transfer status, transfer date and GL date columns for the distribution line.

**Q: Which cost amounts does the report show?**
A: It shows the raw cost and burdened cost of each cost distribution line, along with the expenditure item quantity.
