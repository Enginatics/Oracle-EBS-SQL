---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Receiving Activity Summary | Oracle EBS SQL Report'
description: 'Especially for companies who do not use separate inspection receipt processes, this report nets the initial purchase order receipt into receiving against…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, Receiving, Activity, Summary, gl_code_combinations_kfv, fnd_common_lookups, wip_entities'
permalink: /CAC%20Receiving%20Activity%20Summary/
report_name: 'CAC Receiving Activity Summary'
report_web_name: cac-receiving-activity-summary
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Receiving Activity Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-receiving-activity-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Especially for companies who do not use separate inspection receipt processes, this report nets the initial purchase order receipt into receiving against the delivery into stock and WIP outside processing (OSP), for the entered transaction date range.  By comparing the Purchasing Receipt transactions with the Purchasing Delivery transactions (for the purchasing receipts, material deliveries and WIP OSP deliveries).  Enter the date range you wish to compare, typically a monthly date range.  Differences may be due to the initial receipt occurring in the prior month, not running Create Accounting in the current month (as this report uses the Subledger Accounting rules to report your Receiving Valuation Activity), the goods never delivered into stock or OSP or perhaps the delivery into stock or into WIP OSP was not processed by Create Accounting.

Parameters:
==========
Transaction Date From:  enter the starting transaction date (mandatory).  Defaults to the current period starting date.
Transaction Date To:  enter the ending transaction date (mandatory).  Defaults to the current period ending date.
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).  Defaults to your session's organization code.
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2010 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_rcv_activity_rept.sql
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0      6 Jan 2010 Douglas Volz   Initial Coding
-- |  1.1     05 Apr 2010 Douglas Volz   Added PO number, PO Distribution id to query
-- |  1.2     25 Oct 2017 Douglas Volz   Now use the receiving parameter Receiving ccid
-- |                                     and added transaction source.
-- |  1.3     13 Mar 2018 Douglas Volz   Added Ledger parameter
-- |  1.4     08 Jul 2022 Douglas Volz   Multi-language tables for item master.
-- |  1.5     24 Jun 2024 Douglas Volz   Remove tabs, reinstall parameters and inventory org access controls.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [rcv_receiving_sub_ledger](https://www.enginatics.com/library/?pg=1&find=rcv_receiving_sub_ledger&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [xla_distribution_links](https://www.enginatics.com/library/?pg=1&find=xla_distribution_links&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [rcv_parameters](https://www.enginatics.com/library/?pg=1&find=rcv_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [wip_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=wip_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [wip_transactions](https://www.enginatics.com/library/?pg=1&find=wip_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary)

## Related Reports
[CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Receiving Account Summary](/CAC%20Receiving%20Account%20Summary/ "CAC Receiving Account Summary Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Receiving%20Activity%20Summary/CAC%20Receiving%20Activity%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Receiving Activity Summary 26-Jun-2023 170719.xlsx](https://www.enginatics.com/example/cac-receiving-activity-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary) |
| Blitz Report™ XML Import | [CAC_Receiving_Activity_Summary.xml](https://www.enginatics.com/xml/cac-receiving-activity-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary) |
| SQL Source | [CAC Receiving Activity Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Receiving%20Activity%20Summary/CAC%20Receiving%20Activity%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-receiving-activity-summary/](https://www.enginatics.com/reports/cac-receiving-activity-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary) |

## Case Study & Technical Analysis: CAC Receiving Activity Summary

### Executive Summary
The **CAC Receiving Activity Summary** report analyzes the operational flow within the Receiving Dock. It compares "Receipts" (Goods arriving) against "Deliveries" (Goods moving to Stock or WIP). The net difference represents goods sitting in "Receiving Inspection"—physically on the dock but not yet available for use.

### Business Challenge
*   **Bottlenecks**: "We received the raw materials 3 days ago, why can't production use them?" (Answer: They haven't been Delivered/Inspected).
*   **Period-End Cutoff**: Goods received at 11 PM on the last day of the month might not get delivered until the 1st of the next month. This creates a valid balance in the Receiving Inspection account.
*   **Orphaned Receipts**: Items that were received but forgotten and never delivered.

### Solution
This report performs a "Netting" logic.
*   **Inflow**: Sum of `RECEIVE` transactions.
*   **Outflow**: Sum of `DELIVER` and `RETURN TO VENDOR` transactions.
*   **Balance**: `Receive - Deliver - Return` = Remaining in Receiving.

### Technical Architecture
*   **Tables**: `rcv_transactions`, `rcv_shipment_lines`.
*   **Logic**: It matches transactions by `shipment_line_id` to ensure the flow is traced correctly for the specific shipment.

### Parameters
*   **Transaction Date From/To**: (Mandatory) The period to analyze.

### Performance
*   **Fast**: Queries the operational `rcv_transactions` table which is indexed by date.

### FAQ
**Q: Does this match the GL?**
A: It should. The "Remaining in Receiving" value should equal the balance of the Receiving Inspection account for that period.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-activity-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
