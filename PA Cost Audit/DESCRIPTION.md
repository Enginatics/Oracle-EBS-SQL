# Case Study & Technical Analysis: PA Cost Audit

## Executive Summary
The PA Cost Audit report lists Oracle Projects cost distribution lines that have been transferred, or are awaiting transfer, to the General Ledger. For each line it shows the debit and credit accounts, the amount, the transfer status, the GL date and the PA period, together with the expenditure item, expenditure and the person who incurred the cost. Project accountants and controllers use it to audit project costs in the ledger and to reconcile project cost totals with GL postings at period close. It is an audit and reconciliation view of the cost side of Projects accounting.

## Business Challenge
*   **Project-to-GL reconciliation:** Project cost totals must agree with the amounts posted to the general ledger, and differences need to be traced to specific distribution lines.
*   **Transfer status control:** Cost lines can be transferred, rejected or still pending, and each state needs a different follow-up.
*   **Accounting audit trail:** Auditors ask which debit and credit accounts a project cost was charged to, and which employee incurred it.
*   **Period alignment:** Project periods and GL dates do not always match, so costs must be reviewed by both.

## The Solution
*   **Distribution-level view:** Each row is one raw cost distribution line, with its debit and credit accounts, amount and line number.
*   **Transfer status and dates:** The transfer status is shown with its meaning, along with the date it was transferred.
*   **Expenditure context:** The expenditure item, its date, quantity, expenditure type and system linkage category explain what the cost is.
*   **Ownership and organization:** Project, task, operating unit and the incurring employee are shown beside the amounts.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_COST_DISTRIBUTION_LINES_ALL`: the cost distribution lines, with debit and credit accounts, amount, GL date, transfer status and PA period.
*   `PA_EXPENDITURE_ITEMS_ALL`: the expenditure items that the distribution lines belong to.
*   `PA_EXPENDITURES_ALL`: the expenditure header, which holds the person who incurred the cost.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the project and task of the expenditure item.
*   `GL_CODE_COMBINATIONS_KFV`: the debit and credit accounts, joined twice under different aliases.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of the project.
*   `PER_PEOPLE_X`: the employee name and number.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the operating units the user can access, with a release check.

### Logical Relationships
1.  `PA_COST_DISTRIBUTION_LINES_ALL` is restricted to the raw cost line type and joined to `PA_EXPENDITURE_ITEMS_ALL` on the expenditure item ID.
2.  The expenditure item is joined to `PA_EXPENDITURES_ALL` on the expenditure ID, and to `PA_PROJECTS_ALL` and `PA_TASKS` on project and task.
3.  The debit and credit combination IDs of each line are outer joined to `GL_CODE_COMBINATIONS_KFV`, once for each account.
4.  The project's operating unit is joined to `HR_ALL_ORGANIZATION_UNITS_VL`, and the incurring person is outer joined to `PER_PEOPLE_X`.
5.  The result is ordered by operating unit, project number, task number, expenditure item date and distribution line number.

## Parameters & Filtering
*   **Operating Unit:** Limits the output to one operating unit, within the organizations the user can access.
*   **Project:** Limits the output to one project.
*   **GL Date From and GL Date To:** Restrict the lines to a range of GL dates.
*   **Period Name:** Restricts the lines to one Projects accounting period.

## Performance & Optimization
*   **Raw cost lines only:** The query restricts distribution lines to the raw cost line type, so other line types are not returned.
*   **Access-restricted operating units:** The operating unit filter uses the access temporary table and a release check, so the user sees only operating units they are granted.
*   **Outer joins for accounts and people:** Accounts and the incurring person are outer joined, so lines without those values remain in the audit list.
*   **Account lookups by alias:** The same accounts table is joined twice for debit and credit, which avoids a second query for each side.

## FAQ
**Q: How do I see which project costs have not yet been transferred to the GL?**
A: Use the transfer status column in the output. Lines still awaiting transfer carry their pending status, and the GL Date and Period Name parameters narrow the range.
**Q: Which accounts are shown for each cost line?**
A: Each line shows its debit account and its credit account, read from the distribution line's debit and credit code combinations.
**Q: Who incurred a cost shown in this report?**
A: The incurring employee's name and number are shown from the expenditure header, where the person is recorded.
