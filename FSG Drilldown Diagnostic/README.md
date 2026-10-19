---
layout: default
last_modified_at: 2026-10-19
title: 'FSG Drilldown Diagnostic | Oracle EBS SQL Report'
description: 'Troubleshooting report for FSG journal drilldown issues. Checks glbalances, posted/unposted journals, period status, account properties, and flex value…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FSG, Drilldown, Diagnostic, gl_code_combinations_kfv, gl_ledgers, gl_balances'
permalink: /FSG%20Drilldown%20Diagnostic/
report_name: 'FSG Drilldown Diagnostic'
report_web_name: fsg-drilldown-diagnostic
---

# FSG Drilldown Diagnostic – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fsg-drilldown-diagnostic/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic).

## Overview
Troubleshooting report for FSG journal drilldown issues. Checks gl_balances, posted/unposted journals, period status, account properties, and flex value security for a given account and period. Use the GL segment parameters to filter to the specific account combination that is not drilling down.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Period, GL_SEGMENT1, GL_SEGMENT2, GL_SEGMENT3, GL_SEGMENT4, GL_SEGMENT5, GL_SEGMENT6, GL_SEGMENT7, GL_SEGMENT8, GL_SEGMENT9

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic), [gl_balances](https://www.enginatics.com/library/?pg=1&find=gl_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic), [gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=gl_period_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic)

## Related Reports
[AP Accounted Invoice Aging](/AP%20Accounted%20Invoice%20Aging/ "AP Accounted Invoice Aging Oracle EBS SQL Report"), [GL Balance Drilldown](/GL%20Balance%20Drilldown/ "GL Balance Drilldown Oracle EBS SQL Report"), [GL Journals](/GL%20Journals/ "GL Journals Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Code Combinations](/GL%20Code%20Combinations/ "GL Code Combinations Oracle EBS SQL Report"), [CAC Inventory to G/L Reconciliation (Restricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Restricted by Org Access) Oracle EBS SQL Report"), [CAC Inventory to G/L Reconciliation (Unrestricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Unrestricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Unrestricted by Org Access) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FSG%20Drilldown%20Diagnostic/FSG%20Drilldown%20Diagnostic.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fsg-drilldown-diagnostic/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic) |
| Blitz Report™ XML Import | [FSG_Drilldown_Diagnostic.xml](https://www.enginatics.com/xml/fsg-drilldown-diagnostic/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic) |
| SQL Source | [FSG Drilldown Diagnostic.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FSG%20Drilldown%20Diagnostic/FSG%20Drilldown%20Diagnostic.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fsg-drilldown-diagnostic/](https://www.enginatics.com/reports/fsg-drilldown-diagnostic/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic) |

## Case Study & Technical Analysis: FSG Drilldown Diagnostic

### Executive Summary
The FSG Drilldown Diagnostic is a troubleshooting report for the General Ledger financial statement generator (FSG). When a row in an FSG report cannot be drilled down to its journals, the report shows, for one account and period, every check that the drilldown depends on. It is written for General Ledger functional consultants and finance systems administrators who must find out why a balance does not open to its journal lines. The report returns eight categories of evidence: GL balances, the balances matching the drilldown filter, posted and unposted journal totals, period status, account properties, flexfield security and the previous period baseline. It sits in the General Ledger module.

### Business Challenge
*   **Broken drilldown links:** A financial statement row shows an amount that cannot be traced to journals, which undermines confidence in the report and delays close.
*   **Multiple possible causes:** A drilldown can fail because of the balance records, the journal status, the period state, the account properties or the user's security, so each cause needs checking.
*   **Security-restricted accounts:** Flexfield value security can hide journals from a user, and the failure looks identical to missing data.

### The Solution
*   **Balance evidence:** The report lists all balance rows for the account and period, and separately the rows that satisfy the drilldown filter, so the difference between them is visible.
*   **Journal evidence:** Posted and unposted journal lines are counted and totalled for the account and period, so the team can tell whether journals exist and whether they are posted.
*   **Period and account checks:** The period status, the account's summary, enabled and posting flags, and its active dates are returned in the same output.
*   **Security check:** Each account is tested against the flexfield security function, and the result states whether the user has access and whether security applies.

### Technical Architecture (High Level)
#### Primary Tables
*   `GL_CODE_COMBINATIONS_KFV`: the account combinations, filtered by chart of accounts and the segment parameters.
*   `GL_LEDGERS`: the ledger and its chart of accounts, period set and accounting period type.
*   `GL_BALANCES`: the balances by account, period, currency and translation flag, used in four of the eight checks.
*   `GL_JE_HEADERS` and `GL_JE_LINES`: the journal headers and lines, filtered by status, used for the posted and unposted totals.
*   `GL_PERIOD_STATUSES` and `GL_PERIODS`: the status and dates of the accounting period.

#### Logical Relationships
1. `GL_LEDGERS` is resolved from the ledger name, and its chart of accounts identifier restricts the account combinations.
2. `GL_BALANCES` joins to the account combinations on the code combination identifier and to the ledger on the ledger identifier.
3. `GL_JE_HEADERS` joins to `GL_JE_LINES` on the journal header identifier, and the lines join to the account combinations on the code combination identifier.
4. `GL_PERIOD_STATUSES` joins to the ledger and period name, and `GL_PERIODS` joins on the period set and period type for the dates.
5. The previous period is found by a subquery that compares period year and period number for the same period set and type.
6. Each check is a separate branch of a `union all`, and the branches are sorted by check type and account.

### Parameters & Filtering
*   **Ledger:** The ledger whose chart of accounts is searched.
*   **Period:** The accounting period tested for balances, journals and status.
*   **GL_SEGMENT1 to GL_SEGMENT9:** Each segment value narrows the account combinations to the one that is not drilling down, so the diagnostic runs against a single account.

### Performance & Optimization
*   **Filtered account set:** The account combinations are restricted by chart of accounts and optional segment values in a common table expression, which is reused by every check.
*   **Filter-first balance check:** The drilldown filter check uses the same conditions the FSG drilldown applies, including the null translation and template flags, the non-summary flag and the non-zero test.
*   **Journal aggregation:** Journal lines are counted and summed per check, so the output is one row per check rather than every journal line.

### FAQ
**Q: Why does a financial statement row not drill down to journals in General Ledger?**
A: Run FSG Drilldown Diagnostic for the ledger, period and account, and compare the balance rows with the drilldown filter rows to see which condition removes the balance.

**Q: How do I tell whether a missing drilldown is caused by security?**
A: Check the Security Access check, which reports the validate access result and whether flexfield value security applies to the user.

**Q: Why are journals counted separately from balances?**
A: Balances are stored summary records, while the journal checks count posted and unposted lines directly, so the team can see whether journals exist that the balance does not yet reflect.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fsg-drilldown-diagnostic)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
