---
layout: default
title: 'CST Period Close Subinventory Value Summary | Oracle EBS SQL Report'
description: 'Summary report that lists selected ledgers and operating units with corresponding sub inventory code and Inventory value.With Ledger export capability.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CST, Period, Close, Subinventory, gl_ledgers, org_organization_definitions, mtl_secondary_inventories'
permalink: /CST%20Period%20Close%20Subinventory%20Value%20Summary/
---

# CST Period Close Subinventory Value Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-period-close-subinventory-value-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary report that lists selected ledgers and operating units with corresponding sub inventory code and Inventory value.With Ledger export capability.

## Report Parameters
Ledger, Organization Code, Period

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [cst_period_summary_v](https://www.enginatics.com/library/?pg=1&find=cst_period_summary_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory to G/L Reconciliation (Restricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Restricted by Org Access) Oracle EBS SQL Report"), [CAC Inventory Out-of-Balance](/CAC%20Inventory%20Out-of-Balance/ "CAC Inventory Out-of-Balance Oracle EBS SQL Report"), [CST Period Close Subinventory Value](/CST%20Period%20Close%20Subinventory%20Value/ "CST Period Close Subinventory Value Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Period Close Subinventory Value Summary 06-Jul-2019 173524.xlsx](https://www.enginatics.com/example/cst-period-close-subinventory-value-summary/) |
| Blitz Report™ XML Import | [CST_Period_Close_Subinventory_Value_Summary.xml](https://www.enginatics.com/xml/cst-period-close-subinventory-value-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-period-close-subinventory-value-summary/](https://www.enginatics.com/reports/cst-period-close-subinventory-value-summary/) |

## Executive Summary
The **CST Period Close Subinventory Value Summary** is a high-level version of the period close report, designed for multi-org or multi-ledger analysis. It aggregates the period-end inventory values by Subinventory, Organization, and Ledger. This report is ideal for corporate controllers who need to review inventory positions across the entire enterprise at month-end.

## Business Challenge
*   **Consolidated Reporting**: Running separate detailed reports for 50 different warehouses is impractical for executive review.
*   **Ledger Visibility**: Need to see inventory values grouped by the Primary Ledger they belong to.
*   **Trend Monitoring**: Quickly identifying which organizations or subinventories have spiking inventory levels.

## Solution
This report provides a summarized view of period-end inventory values.

**Key Features:**
*   **Ledger Export**: Explicitly supports export by Ledger, facilitating financial consolidation.
*   **Multi-Org**: Can report on multiple organizations in a single run.
*   **Summary Level**: Focuses on the total value per subinventory, rather than item-level detail.

## Architecture
The report uses the `CST_PERIOD_SUMMARY_V` view, which aggregates data from the underlying period close tables.

**Key Tables:**
*   `CST_PERIOD_SUMMARY_V`: The view providing the summarized data.
*   `GL_LEDGERS`: Ledger definitions.
*   `ORG_ORGANIZATION_DEFINITIONS`: Organization hierarchy.

## Impact
*   **Executive Insight**: Provides a "Dashboard" style view of inventory assets across the company.
*   **Financial Consolidation**: Simplifies the process of aggregating inventory values for corporate financial statements.
*   **Exception Management**: Highlights organizations with unusual inventory balances at period end.


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
