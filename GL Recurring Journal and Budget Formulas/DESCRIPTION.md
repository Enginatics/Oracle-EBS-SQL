# Case Study & Technical Analysis: GL Recurring Journal and Budget Formulas

## Executive Summary
GL Recurring Journal and Budget Formulas lists the recurring journal and budget definitions of Oracle General Ledger, with their batches, journal entries, lines and the formula steps behind each line. Every account is split into one column per Accounting Flexfield segment, so the company, department, account, sub-account and other segments can be sorted and filtered in Excel. General Ledger administrators and month-end close teams use it to review what each recurring entry posts and which balances it reads.

## Business Challenge
*   **Review Before Close:** Recurring journals post automatically each period, so the team needs to confirm the accounts and formulas before the close begins.
*   **Segment Analysis:** Reviewers want to see all intercompany or intracompany batches for one company or department, which is hard when the account is one concatenated string.
*   **Formula Transparency:** A line can use several formula steps that read balances from different accounts, and the relationship between steps must be visible.
*   **Access Control:** Recurring batches can be secured, so the listing must respect the same definition access rules as the standard report.

## The Solution
*   **Segment Columns:** Each Accounting Flexfield segment of the line account and of the formula account is returned as its own column, so filtering by a single segment is direct.
*   **Step Level Detail:** Each row is one formula step, showing the operator, the amount, the amount type, the relative period, the balance type and the currency type.
*   **Security Respect:** The batch rows are filtered with the same data security check the standard report applies to recurring journals.
*   **Scoped Selection:** Ledger, batch, journal entry and category parameters, together with per-segment ranges, focus the listing on the required accounts.

## Technical Architecture (High Level)
### Primary Tables
*   `GL_RECURRING_BATCHES`: the batch definitions, including the batch type, the budget flag, the allocation flag and the period calendar.
*   `GL_RECURRING_HEADERS`: the journal entries within a batch, with their category, currency, conversion type and dates.
*   `GL_RECURRING_LINES`: the lines of each journal entry, with the line account and the entered debit or credit.
*   `GL_RECURRING_LINE_CALC_RULES`: the formula steps of each line, with the operator, amount, period and assigned account.
*   `GL_CODE_COMBINATIONS_KFV`: the account combinations, used for both the line account and the formula account.
*   `GL_LEDGERS`: the ledger name for each batch.
*   `GL_JE_CATEGORIES_VL`: the user name of the journal category.
*   `GL_DAILY_CONVERSION_TYPES`: the user name of the conversion type.

### Logical Relationships
1.  `GL_RECURRING_BATCHES` is joined to `GL_LEDGERS` on the ledger identifier.
2.  Batches are joined to `GL_RECURRING_HEADERS` on the recurring batch identifier.
3.  Headers are joined to `GL_RECURRING_LINES` on the recurring header identifier.
4.  Lines are outer joined to `GL_RECURRING_LINE_CALC_RULES` on header and line number, so each line returns one row per formula step.
5.  Each line's account is joined to `GL_CODE_COMBINATIONS_KFV`, and each step's assigned account is looked up in a correlated subquery against the same view.
6.  Category and conversion type names are resolved through correlated subqueries against their definition views.

## Parameters & Filtering
*   **Ledger, Calendar and Batch Name:** Select the ledger and the batch, the main drivers of the extract.
*   **Journal Entry Name and Category:** Narrow the output to one journal entry or journal category.
*   **Balance Type and Batch Type:** Separate budget batches from accounting batches.
*   **MassAllocation Batch and Enabled:** Limit the output to allocation batches or to enabled entries.
*   **Account like:** Matches the concatenated line account.
*   **GL_SEGMENT1 to GL_SEGMENT10 with From and To:** Each pair restricts the line account to a range of values for one segment, and each segment has its own value filter.

## Performance & Optimization
*   **Batch and Ledger Drive:** The ledger and batch parameters restrict the batch rows first, so the join to headers, lines and rules is limited to the selected batches.
*   **Outer Join to Rules:** Formula steps are joined as an outer join, so lines without formula steps are still returned.
*   **Security Check Per Batch:** The data security function is evaluated once per batch row, which keeps the check proportionate to the number of batches.
*   **Segment Derivation:** Segment values are taken from the code combination view with the flexfield column expansion, so no extra lookup table is joined.

## FAQ
**Q: How do I see every recurring entry that posts to a particular department?**
A: Enter the department value in the matching GL_SEGMENT parameter, or use the From and To range for that segment. Each row shows the line account segment by segment.

**Q: What is the difference between the line account and the formula account?**
A: The line account is the account the generated journal posts to. The formula account is the account a formula step reads a balance from.

**Q: Does this report replace the standard recurring formula listing?**
A: It covers the same definitions, with segments in separate columns and one row per formula step. The description notes that it replaces the standard Other Recurring Formula Listing.
