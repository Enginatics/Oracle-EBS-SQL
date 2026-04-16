---
layout: default
title: 'CAC Receiving Activity Summary | Oracle EBS SQL Report'
description: 'Especially for companies who do not use separate inspection receipt processes, this report nets the initial purchase order receipt into receiving against…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, Receiving, Activity, Summary, gl_code_combinations_kfv, fnd_common_lookups, wip_entities'
permalink: /CAC%20Receiving%20Activity%20Summary/
---

# CAC Receiving Activity Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-receiving-activity-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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


## Report Parameters
Transaction Date From, Transaction Date To, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [rcv_receiving_sub_ledger](https://www.enginatics.com/library/?pg=1&find=rcv_receiving_sub_ledger), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [xla_distribution_links](https://www.enginatics.com/library/?pg=1&find=xla_distribution_links), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [rcv_parameters](https://www.enginatics.com/library/?pg=1&find=rcv_parameters), [wip_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=wip_transaction_accounts), [wip_transactions](https://www.enginatics.com/library/?pg=1&find=wip_transactions), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Receiving Activity Summary 26-Jun-2023 170719.xlsx](https://www.enginatics.com/example/cac-receiving-activity-summary/) |
| Blitz Report™ XML Import | [CAC_Receiving_Activity_Summary.xml](https://www.enginatics.com/xml/cac-receiving-activity-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-receiving-activity-summary/](https://www.enginatics.com/reports/cac-receiving-activity-summary/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
