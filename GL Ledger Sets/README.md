---
layout: default
last_modified_at: 2026-10-16
title: 'GL Ledger Sets | Oracle EBS SQL Report'
description: 'Master data report showing GL ledger sets and included ledgers. – Oracle EBS General Ledger SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, General Ledger, Enginatics, R12 only, Ledger, Sets, gl_ledgers, gl_ledger_sets_v, gl_ledger_set_norm_assign_v'
permalink: /GL%20Ledger%20Sets/
report_name: 'GL Ledger Sets'
report_web_name: gl-ledger-sets
module: 'General Ledger'
module_url: /modules/general-ledger/
---

# GL Ledger Sets – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-ledger-sets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets).
**Oracle EBS module:** [General Ledger](/modules/general-ledger/ "Oracle EBS General Ledger reports") · [all General Ledger reports](/modules/general-ledger/)  

## Overview
Master data report showing GL ledger sets and included ledgers.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger Set, Chart of Accounts

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets), [gl_ledger_sets_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_sets_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets)

## Related Reports
[CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [GL Data Access Sets](/GL%20Data%20Access%20Sets/ "GL Data Access Sets Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Standard Cost Update Submissions](/CAC%20Standard%20Cost%20Update%20Submissions/ "CAC Standard Cost Update Submissions Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Ledger%20Sets/GL%20Ledger%20Sets.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Ledger Sets 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/gl-ledger-sets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets) |
| Blitz Report™ XML Import | [GL_Ledger_Sets.xml](https://www.enginatics.com/xml/gl-ledger-sets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets) |
| SQL Source | [GL Ledger Sets.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Ledger%20Sets/GL%20Ledger%20Sets.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-ledger-sets/](https://www.enginatics.com/reports/gl-ledger-sets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets) |

## GL Ledger Sets - Case Study & Technical Analysis

### Executive Summary
The **GL Ledger Sets** report is a configuration analysis tool that documents the setup of Ledger Sets within the Oracle General Ledger. Ledger Sets allow organizations to group multiple ledgers (e.g., by region, country, or line of business) to perform collective processing such as opening/closing periods, running reports, or performing revaluation. This report helps visualize these groupings and verify that the correct ledgers are included in each set.

### Business Use Cases
*   **Configuration Verification**: Ensures that a "Global" or "Regional" ledger set actually contains all the intended ledgers (e.g., verifying that the newly created "France" ledger was added to the "EMEA" ledger set).
*   **Period Close Management**: Assists in troubleshooting why a period might not be closed for a specific entity by confirming its membership in the Ledger Set used for the "Close Period" program.
*   **Reporting Hierarchy**: Validates the structures used for consolidated reporting, ensuring that data aggregation at the Ledger Set level will be accurate.
*   **Access Control**: Since Data Access Sets can be assigned to Ledger Sets, this report helps map out the scope of access granted to users.

### Technical Analysis

#### Core Tables
*   `GL_LEDGER_SETS_V`: A view that lists the defined Ledger Sets.
*   `GL_LEDGER_SET_NORM_ASSIGN_V`: Contains the normative assignments, defining which ledgers (or other ledger sets) belong to a parent ledger set.
*   `GL_LEDGERS`: Stores the details of the individual ledgers.

#### Key Joins & Logic
*   **Set Membership**: The query joins `GL_LEDGER_SETS_V` (the parent) to `GL_LEDGER_SET_NORM_ASSIGN_V` (the mapping) and then to `GL_LEDGERS` (the child) to list the members.
*   **Chart of Accounts Validation**: Typically, all ledgers in a set must share the same Chart of Accounts and Calendar. The report likely includes columns to validate this consistency.
*   **Recursive Logic**: Ledger Sets can potentially contain other Ledger Sets. The report logic (or the underlying view) handles the flattening of this hierarchy to show the ultimate list of ledgers.

#### Key Parameters
*   **Ledger Set**: The specific set to analyze.
*   **Chart of Accounts**: Filter to show sets belonging to a specific COA structure.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-ledger-sets)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
