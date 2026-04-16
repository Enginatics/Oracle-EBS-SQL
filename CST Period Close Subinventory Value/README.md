---
layout: default
title: 'CST Period Close Subinventory Value | Oracle EBS SQL Report'
description: 'Summary report that lists selected operating units with corresponding sub inventory code and Inventory value on a historic basis.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CST, Period, Close, Subinventory, gl_ledgers, org_organization_definitions, org_acct_periods'
permalink: /CST%20Period%20Close%20Subinventory%20Value/
---

# CST Period Close Subinventory Value – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-period-close-subinventory-value/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary report that lists selected operating units with corresponding sub inventory code and Inventory value on a historic basis.

## Report Parameters
Ledger, Organization Code, Period, Category Set 1, Category Set 2, Show Last PO Price

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [oap](https://www.enginatics.com/library/?pg=1&find=oap), [cst_period_close_summary](https://www.enginatics.com/library/?pg=1&find=cst_period_close_summary), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_default_category_sets](https://www.enginatics.com/library/?pg=1&find=mtl_default_category_sets), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Out-of-Balance](/CAC%20Inventory%20Out-of-Balance/ "CAC Inventory Out-of-Balance Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory to G/L Reconciliation (Restricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Restricted by Org Access) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Period Close Subinventory Value 27-Jul-2018 095956.xlsx](https://www.enginatics.com/example/cst-period-close-subinventory-value/) |
| Blitz Report™ XML Import | [CST_Period_Close_Subinventory_Value.xml](https://www.enginatics.com/xml/cst-period-close-subinventory-value/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-period-close-subinventory-value/](https://www.enginatics.com/reports/cst-period-close-subinventory-value/) |

## Executive Summary
The **CST Period Close Subinventory Value** report provides a historical snapshot of inventory value at the subinventory level, specifically aligned with the accounting period close. Unlike real-time on-hand reports, this report is designed to match the General Ledger balance for a closed period. It is a critical tool for the month-end reconciliation process.

## Business Challenge
*   **GL Reconciliation**: The GL Inventory account balance is a single number. To validate it, Finance needs a detailed breakdown that sums up to exactly that number for the *closed* period.
*   **Backdated Transactions**: Real-time reports change constantly. This report captures the value as it stood at the period end, respecting the accounting date of transactions.
*   **Subinventory Analysis**: Understanding which storage locations held the value at month-end.

## Solution
This report lists the inventory value by subinventory for a specific closed period.

**Key Features:**
*   **Period-Based**: Parameters are driven by the Accounting Period (e.g., "Jan-24"), ensuring alignment with the GL.
*   **Historical Accuracy**: Uses the period-end snapshot data.
*   **Category Grouping**: Can group items by category for high-level analysis.

## Architecture
The report queries the `CST_PERIOD_CLOSE_SUMMARY` table, which is populated by the Period Close process.

**Key Tables:**
*   `CST_PERIOD_CLOSE_SUMMARY`: Stores the summarized value of inventory at period close.
*   `ORG_ACCT_PERIODS`: Defines the accounting periods.
*   `MTL_SECONDARY_INVENTORIES`: Subinventory definitions.

## Impact
*   **Audit Compliance**: Provides the "Sub-Ledger" detail required to support the General Ledger inventory balance.
*   **Reconciliation Speed**: Drastically reduces the time spent investigating differences between the GL and the perpetual inventory records.
*   **Trend Analysis**: Allows for month-over-month comparison of inventory levels by location.


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
