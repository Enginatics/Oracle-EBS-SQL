---
layout: default
title: 'GL Ledger Sets | Oracle EBS SQL Report'
description: 'Master data report showing GL ledger sets and included ledgers. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Ledger, Sets, gl_ledgers, gl_ledger_sets_v, gl_ledger_set_norm_assign_v'
permalink: /GL%20Ledger%20Sets/
---

# GL Ledger Sets – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-ledger-sets/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report showing GL ledger sets and included ledgers.

## Report Parameters
Ledger Set, Chart of Accounts

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_ledger_sets_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_sets_v), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[GL Data Access Sets](/GL%20Data%20Access%20Sets/ "GL Data Access Sets Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [CAC New Items](/CAC%20New%20Items/ "CAC New Items Oracle EBS SQL Report"), [CAC Item vs. Component Include in Rollup Controls](/CAC%20Item%20vs-%20Component%20Include%20in%20Rollup%20Controls/ "CAC Item vs. Component Include in Rollup Controls Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Material Overhead Setup](/CAC%20Material%20Overhead%20Setup/ "CAC Material Overhead Setup Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Ledger Sets 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/gl-ledger-sets/) |
| Blitz Report™ XML Import | [GL_Ledger_Sets.xml](https://www.enginatics.com/xml/gl-ledger-sets/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-ledger-sets/](https://www.enginatics.com/reports/gl-ledger-sets/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
