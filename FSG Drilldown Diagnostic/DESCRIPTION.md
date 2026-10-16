# Case Study & Technical Analysis: FSG Drilldown Diagnostic

## Executive Summary
The FSG Drilldown Diagnostic is a troubleshooting report for the General Ledger financial statement generator (FSG). When a row in an FSG report cannot be drilled down to its journals, the report shows, for one account and period, every check that the drilldown depends on. It is written for General Ledger functional consultants and finance systems administrators who must find out why a balance does not open to its journal lines. The report returns eight categories of evidence: GL balances, the balances matching the drilldown filter, posted and unposted journal totals, period status, account properties, flexfield security and the previous period baseline. It sits in the General Ledger module.

## Business Challenge
*   **Broken drilldown links:** A financial statement row shows an amount that cannot be traced to journals, which undermines confidence in the report and delays close.
*   **Multiple possible causes:** A drilldown can fail because of the balance records, the journal status, the period state, the account properties or the user's security, so each cause needs checking.
*   **Security-restricted accounts:** Flexfield value security can hide journals from a user, and the failure looks identical to missing data.

## The Solution
*   **Balance evidence:** The report lists all balance rows for the account and period, and separately the rows that satisfy the drilldown filter, so the difference between them is visible.
*   **Journal evidence:** Posted and unposted journal lines are counted and totalled for the account and period, so the team can tell whether journals exist and whether they are posted.
*   **Period and account checks:** The period status, the account's summary, enabled and posting flags, and its active dates are returned in the same output.
*   **Security check:** Each account is tested against the flexfield security function, and the result states whether the user has access and whether security applies.

## Technical Architecture (High Level)
### Primary Tables
*   `GL_CODE_COMBINATIONS_KFV`: the account combinations, filtered by chart of accounts and the segment parameters.
*   `GL_LEDGERS`: the ledger and its chart of accounts, period set and accounting period type.
*   `GL_BALANCES`: the balances by account, period, currency and translation flag, used in four of the eight checks.
*   `GL_JE_HEADERS` and `GL_JE_LINES`: the journal headers and lines, filtered by status, used for the posted and unposted totals.
*   `GL_PERIOD_STATUSES` and `GL_PERIODS`: the status and dates of the accounting period.

### Logical Relationships
1. `GL_LEDGERS` is resolved from the ledger name, and its chart of accounts identifier restricts the account combinations.
2. `GL_BALANCES` joins to the account combinations on the code combination identifier and to the ledger on the ledger identifier.
3. `GL_JE_HEADERS` joins to `GL_JE_LINES` on the journal header identifier, and the lines join to the account combinations on the code combination identifier.
4. `GL_PERIOD_STATUSES` joins to the ledger and period name, and `GL_PERIODS` joins on the period set and period type for the dates.
5. The previous period is found by a subquery that compares period year and period number for the same period set and type.
6. Each check is a separate branch of a `union all`, and the branches are sorted by check type and account.

## Parameters & Filtering
*   **Ledger:** The ledger whose chart of accounts is searched.
*   **Period:** The accounting period tested for balances, journals and status.
*   **GL_SEGMENT1 to GL_SEGMENT9:** Each segment value narrows the account combinations to the one that is not drilling down, so the diagnostic runs against a single account.

## Performance & Optimization
*   **Filtered account set:** The account combinations are restricted by chart of accounts and optional segment values in a common table expression, which is reused by every check.
*   **Filter-first balance check:** The drilldown filter check uses the same conditions the FSG drilldown applies, including the null translation and template flags, the non-summary flag and the non-zero test.
*   **Journal aggregation:** Journal lines are counted and summed per check, so the output is one row per check rather than every journal line.

## FAQ
**Q: Why does a financial statement row not drill down to journals in General Ledger?**
A: Run FSG Drilldown Diagnostic for the ledger, period and account, and compare the balance rows with the drilldown filter rows to see which condition removes the balance.

**Q: How do I tell whether a missing drilldown is caused by security?**
A: Check the Security Access check, which reports the validate access result and whether flexfield value security applies to the user.

**Q: Why are journals counted separately from balances?**
A: Balances are stored summary records, while the journal checks count posted and unposted lines directly, so the team can see whether journals exist that the balance does not yet reflect.
