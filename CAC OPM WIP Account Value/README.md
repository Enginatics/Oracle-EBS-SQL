---
layout: default
last_modified_at: 2026-10-16
title: 'CAC OPM WIP Account Value | Oracle EBS SQL Report'
description: 'Report to show WIP values for process manufacturing (OPM), in summary by inventory organization and batch, with batch status, name and other details. The…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, OPM, WIP, Account, mtl_material_transactions, mtl_system_items_vl, mtl_units_of_measure_vl'
permalink: /CAC%20OPM%20WIP%20Account%20Value/
report_name: 'CAC OPM WIP Account Value'
report_web_name: cac-opm-wip-account-value
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC OPM WIP Account Value – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-opm-wip-account-value/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show WIP values for process manufacturing (OPM), in summary by inventory organization and batch, with batch status, name and other details.  The valuation accounts come from the cumulative WIP Valuation accounting entries, as processed by Create Accounting.

Parameters:
===========
Period Name:  the inventory accounting period you wish to report (mandatory).
Include Lab Batches:  enter Yes to include laboratory batches.  Enter No to exclude them.  Defaults to No (mandatory).
Show Batch Details:  enter Yes to display the formula, routing and recipe numbers and versions.  Defaults to No (mandatory).
Show Transaction Details: enter Yes to show the Event Class, Transaction Type, Transaction ID and Transaction Date.  Defaults to No (mandatory). 
Batch Number:  enter a specific batch number to report (optional).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  The second item category set to report, typically the Inventory Category Set (optional).
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional).
Ledger:  specific ledger (optional).

/* +=============================================================================+
-- |  Copyright 2014 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     22-Oct-2014 Douglas Volz   Initial version.
-- |  1.1     06-Jul-2024 Douglas Volz   Cumulative changes plus format for Blitz Report.
-- |  1.2     31-Jul-2024 Douglas Volz   Fix to get current and prior month's transactions
-- |  1.3     06-Aug-2024 Douglas Volz   Add Batch and Txn Detail parameters.
-- |  1.4     08-Aug-2024 Douglas Volz   Add Product and Byproduct completion quantity columns.
-- |                                     and inventory access control security.
-- |  1.5     17-Aug-2024 Douglas Volz   Fix for reporting batches closed after the reported period.
-- |                                     Add Batch Number parameter.  Display the Ledger short name.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period Name, Include Lab Batches, Show Batch Details, Show Transaction Details, Batch Number, Category Set 1, Category Set 2, Category Set 3, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [xla_lookups](https://www.enginatics.com/library/?pg=1&find=xla_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [gem_lookups](https://www.enginatics.com/library/?pg=1&find=gem_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [gme_batch_header](https://www.enginatics.com/library/?pg=1&find=gme_batch_header&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [gmf_xla_extract_headers](https://www.enginatics.com/library/?pg=1&find=gmf_xla_extract_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [gme_resource_txns](https://www.enginatics.com/library/?pg=1&find=gme_resource_txns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [gmf_fiscal_policies](https://www.enginatics.com/library/?pg=1&find=gmf_fiscal_policies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Receiving Account Summary](/CAC%20Receiving%20Account%20Summary/ "CAC Receiving Account Summary Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20OPM%20WIP%20Account%20Value/CAC%20OPM%20WIP%20Account%20Value.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cac-opm-wip-account-value/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value) |
| Blitz Report™ XML Import | [CAC_OPM_WIP_Account_Value.xml](https://www.enginatics.com/xml/cac-opm-wip-account-value/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value) |
| SQL Source | [CAC OPM WIP Account Value.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20OPM%20WIP%20Account%20Value/CAC%20OPM%20WIP%20Account%20Value.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-opm-wip-account-value/](https://www.enginatics.com/reports/cac-opm-wip-account-value/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value) |

## Case Study & Technical Analysis: CAC OPM WIP Account Value

### Executive Summary
The **CAC OPM WIP Account Value** report provides the Work in Process (WIP) valuation for OPM Batches. Unlike Discrete WIP (which is a snapshot of the job balance), OPM WIP is often derived from the cumulative accounting entries generated by the Subledger Accounting (SLA) engine. This report summarizes those entries to provide a batch-level WIP balance.

### Business Challenge
*   **WIP Visibility**: In OPM, "WIP" is a fluid concept. Materials are issued, products are yielded, and the difference sits in WIP until the batch closes.
*   **Reconciliation**: Reconciling the WIP GL account to the specific batches is notoriously difficult in OPM.
*   **Month-End**: Finance needs to know the value of open batches to validate the balance sheet.

### Solution
This report queries the SLA data.
*   **Source**: `xla_ae_lines` (The accounting entries).
*   **Aggregation**: Sums Debits and Credits by Batch ID.
*   **Status**: Shows whether the batch is Open, Closed, or Cancelled.

### Technical Architecture
*   **Tables**: `gme_batch_header`, `xla_ae_headers`, `xla_ae_lines`.
*   **Logic**: It looks for accounting entries associated with the "Production" event class in OPM.
*   **Prerequisite**: "Create Accounting" must be run for the period to populate the data.

### Parameters
*   **Period Name**: (Mandatory) Accounting Period.
*   **Include Lab Batches**: (Optional) To include R&D batches.
*   **Show Transaction Details**: (Optional) To see the individual entries vs. the batch summary.

### Performance
*   **Heavy**: Querying XLA tables is resource-intensive. The report aggregates millions of rows.

### FAQ
**Q: Why is the WIP value negative?**
A: In OPM, if you yield the product *before* you issue the ingredients (backflushing timing issues), the WIP balance can temporarily go negative.

**Q: Does it match the GL?**
A: Yes, because it queries the *exact same table* (XLA) that posts to the GL.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-wip-account-value)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
