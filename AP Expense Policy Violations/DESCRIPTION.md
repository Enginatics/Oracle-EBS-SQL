# Case Study & Technical Analysis: AP Expense Policy Violations

## Executive Summary
The AP Expense Policy Violations report lists every policy violation recorded against an iExpense expense report, one row per violation, together with the expense line that triggered it. It is written for Payables managers, expense audit teams and finance controllers who must review whether employees have exceeded the allowable amounts set by their expense policy. Each row shows the violation type, the allowable amount, the exceeded amount and the expense line details, so the reviewer can decide whether to approve, reject or challenge the claim. The report sits in the Payables module and is built on the Oracle iExpense policy enforcement tables.

## Business Challenge
*   **Policy compliance visibility:** Violations are generated when an expense line breaks a policy limit, and without a consolidated view auditors must open reports one at a time to see the pattern.
*   **Quantifying overspend:** Reviewers need the amount by which each limit was exceeded, not only the fact of a violation, to prioritise follow-up.
*   **Audit trail for approvers:** The approver of an expense report needs to see the violation type, the category and the justification entered against each line.

## The Solution
*   **Violation-level detail:** The report joins expense report lines to `AP_POL_VIOLATIONS_ALL` on the report header and distribution line number, so each violation appears on its own row with its allowable and exceeded amounts.
*   **Functional currency comparison:** The functional allowable amount is returned as well as the transaction amount, which allows violations in different currencies to be compared on one basis.
*   **Readable codes:** Expense status, source, violation type and audit type are translated through standard lookup meanings, so the output reads in business terms.

## Technical Architecture (High Level)
### Primary Tables
*   `AP_EXPENSE_REPORT_HEADERS_ALL`: expense report header, including status, total, employee link and current approver.
*   `AP_EXPENSE_REPORT_LINES_ALL`: expense report lines, including category, dates, amounts and receipt details.
*   `AP_EXPENSE_REPORT_PARAMS_ALL`: the expense type parameters that supply the prompt shown for each line.
*   `AP_POL_VIOLATIONS_ALL`: the policy violations raised against each expense line.
*   `AP_INVOICES_ALL`: used to detect cancelled expense reports through the cancelled date.
*   `PER_PEOPLE_X`: employee and approver names and numbers.
*   `GL_LEDGERS`: the ledger, linked through the set of books identifier.
*   `HR_OPERATING_UNITS`: the operating unit of the report.
*   `GL_CODE_COMBINATIONS_KFV`: the expense account for each line.

### Logical Relationships
1. `AP_EXPENSE_REPORT_HEADERS_ALL` links to `GL_LEDGERS` through the set of books identifier and to `HR_OPERATING_UNITS` through the organisation identifier.
2. Report headers join to their employee in `PER_PEOPLE_X` through the employee identifier, using an outer join so reports without a resolved employee still appear.
3. Header lines join to `AP_EXPENSE_REPORT_LINES_ALL` on the report header identifier.
4. Lines join to `AP_POL_VIOLATIONS_ALL` on report header and distribution line number, which produces one row per violation.
5. Lines join to `AP_EXPENSE_REPORT_PARAMS_ALL` and `GL_CODE_COMBINATIONS_KFV` through outer joins.
6. The header joins to `AP_INVOICES_ALL` through the voucher number, to check whether the report has been cancelled.

## Parameters & Filtering
*   **Ledger and Operating Unit:** Restrict the output to one ledger or operating unit, matching the header's set of books and organisation.
*   **Employee:** Limits the rows to violations raised on expense reports belonging to one employee.
*   **Expense Status:** Filters on the translated report status, which is derived from the cancelled date and the header status code.
*   **Violation Type:** Restricts the output to one class of policy violation, so that a single limit can be audited.
*   **Expense Date From and Expense Date To:** Bound the expense line dates in the report.
*   **Expense Category:** Restricts the rows to one expense category from the line record.

## Performance & Optimization
*   **Driving join on violations:** The report is driven by the violation and line tables, so filters on violation type or date reduce the rows before the employee and account lookups are applied.
*   **Scalar subqueries for approver:** The current approver is resolved through a correlated subquery on `PER_PEOPLE_X`, which runs per report row rather than as a separate join.
*   **Sorting by submission date:** The output is ordered by the submission date and then report number and line, which keeps the most recent claims first.

## FAQ
**Q: Which expense policy violations are flagged in Oracle iExpense?**
A: The report lists each row in `AP_POL_VIOLATIONS_ALL` with its translated violation type, allowable amount and exceeded amount.

**Q: How can I see which employee and line caused an expense policy violation?**
A: Each row carries the employee name and number, the expense report number, the line number, the expense category and the item description.

**Q: Can I restrict the report to one expense period?**
A: Yes, the Expense Date From and Expense Date To parameters bound the expense line dates.
