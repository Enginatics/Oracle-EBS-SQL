---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Inventory to G/L Reconciliation (Restricted by Org Access) | Oracle EBS SQL Report'
description: 'For Discrete Costing, this report compares the General Ledger inventory balances with the perpetual inventory values (based on the stored month-end…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, Inventory, G/L, Reconciliation, mtl_secondary_inventories, mtl_parameters, pjm_org_parameters'
permalink: /CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/
report_name: 'CAC Inventory to G/L Reconciliation (Restricted by Org Access)'
report_web_name: cac-inventory-to-g-l-reconciliation-restricted-by-org-access
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Inventory to G/L Reconciliation (Restricted by Org Access) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
For Discrete Costing, this report compares the General Ledger inventory balances with the perpetual inventory values (based on the stored month-end inventory and WIP balances, generated when the inventory accounting period is closed, plus a calculated month-end receiving value).  Inventory balances includes Receiving, Onhand Inventory (Stock), Intransit and Work in Process (WIP).  This report automatically discovers your valuation accounts based on your setups, such as the Cost Method (Standard, Average, FIFO or LIFO Costing), and also if using Project Manufacturing (PJM - Cost Group Accounting) or Warehouse Management (WMS - Cost Group Accounting) or even if using Category Accounts.  But note as maintenance work orders are normally charged to expense accounts, maintenance (EAM) work orders are not included in this report.  Also note this report does not break out the perpetual account values by cost element; it assumes the elemental cost accounts by subinventory or cost group are the same as the material account, as the stored month-end perpetual inventory balances are only stored by organization, accounting period and item, but not by cost element.

/* +=============================================================================+
-- |  Copyright 2010-23 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  XXX_INV_RECON_REPT.sql
-- |
-- |  Parameters:
-- |  P_PERIOD_NAME      -- Enter the Period Name you wish to reconcile balances for (mandatory)
-- |  P_LEDGER           -- general ledger you wish to report, for all ledgers left this parameter blank
-- |  ============================================================================
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     24 Sep 2004 Douglas Volz   Initial Coding based on earlier work with
-- |                                     the following scripts and designs:
-- |                                        XXX_GL_RECON.sql,
-- |                                        XXX_PERPETUAL_INV_RECON_SUM.sql,
-- |                                        XXX_PERPETUAL_RCV_RECON_SUM.sql,
-- |                                        XXX_PERPETUAL_WIP_RECON_SUM.sql,
-- |                                        MD050 Inventory Reconciliation
-- |  1.1     28 Jun 2010 Douglas Volz   Updated design and code for Release 12,
-- |                                     changed GL_SETS_OF_BOOKS to GL_LEDGERS
-- |  1.2     14 Nov 2010 Douglas Volz   Modified for Cost SIG Presentation
-- |  1.3     11 Mar 2014 Douglas Volz   Changed the COA segments to be generic and removed
-- |                                     the second product line join to gl_code_combinations
-- |  1.4     07 Apr 2014 Douglas Volz   Added join condition to avoid secondary ledgers and
-- |                                     added an explicit to_char on the accounts
-- |                                     ml.lookup_code to avoid an "invalid number" SQL error.
-- |  1.5     20 Jul 2016 Douglas Volz   Added condition to avoid summary journals
-- |  1.6     18 May 2020 Douglas Volz   Avoid disabled inventory organizations.
-- |  1.7     07 Dec 2020 Douglas Volz/Andy Haack   Only report inventory organization ledgers.  Initial Blitz version.
-- |  1.8     22 Feb 2023 Douglas Volz   Add in Receiving Value, fixes for Category Accounting.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period Name (Closed), Ledger, Minimum Value Difference

## Oracle EBS Tables Used
[mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [pjm_org_parameters](https://www.enginatics.com/library/?pg=1&find=pjm_org_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [rcv_parameters](https://www.enginatics.com/library/?pg=1&find=rcv_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [cst_cg_wip_acct_classes](https://www.enginatics.com/library/?pg=1&find=cst_cg_wip_acct_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [gl_balances](https://www.enginatics.com/library/?pg=1&find=gl_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [cst_period_close_summary](https://www.enginatics.com/library/?pg=1&find=cst_period_close_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [wip_period_balances](https://www.enginatics.com/library/?pg=1&find=wip_period_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [rcv_accounting_events](https://www.enginatics.com/library/?pg=1&find=rcv_accounting_events&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [mtl_supply](https://www.enginatics.com/library/?pg=1&find=mtl_supply&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [rcv_receiving_sub_ledger](https://www.enginatics.com/library/?pg=1&find=rcv_receiving_sub_ledger&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [wip_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=wip_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [wip_transactions](https://www.enginatics.com/library/?pg=1&find=wip_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [wip_cost_txn_interface](https://www.enginatics.com/library/?pg=1&find=wip_cost_txn_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access)

## Related Reports
[CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory to G L Reconciliation (Restricted by Org Access) 07-Jul-2022 144051.xlsx](https://www.enginatics.com/example/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access) |
| Blitz Report™ XML Import | [CAC_Inventory_to_G_L_Reconciliation_Restricted_by_Org_Access.xml](https://www.enginatics.com/xml/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access) |
| SQL Source | [CAC Inventory to G-L Reconciliation (Restricted by Org Access).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/](https://www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access) |

## Case Study & Technical Analysis: CAC Inventory to G/L Reconciliation (Restricted by Org Access)

### Executive Summary
The **CAC Inventory to G/L Reconciliation (Restricted by Org Access)** report is a compliance tool that compares the General Ledger balance to the Perpetual Inventory Subledger value. It is designed for users who have restricted access (e.g., Plant Controllers) and need to reconcile only the organizations they are responsible for. It ensures that the financial statements accurately reflect the physical inventory assets.

### Business Challenge
Reconciliation is the primary control for Inventory accounting.
*   **Subledger Drift**: Inventory is a high-volume module. A single glitch in thousands of transactions can cause the GL to drift from the subledger.
*   **Security**: In large companies, a Plant Controller in Germany should not see the GL balances for the US operations. Standard reports often lack this granular security.
*   **Complexity**: Reconciling involves summing up On-hand, Intransit, WIP, and Receiving inspection values. Doing this manually is prone to error.

### Solution
This report automates the comparison within the user's security context.
*   **GL Balance**: Queries `gl_balances` for the inventory control accounts.
*   **Subledger Value**: Aggregates the period-end snapshot values for On-hand, Intransit, WIP, and Receiving.
*   **Variance Calculation**: Reports the difference. Ideally, it should be zero.

### Technical Architecture
The report combines data from multiple sources:
*   **GL**: `gl_balances` (Actuals).
*   **Inventory**: `cst_period_close_summary` (or `mtl_period_summary`).
*   **WIP**: `wip_period_balances`.
*   **Receiving**: `rcv_receiving_sub_ledger` (or calculated from transactions).
*   **Security**: Applies standard Oracle Org Access security policies to filter the output.

### Parameters
*   **Period Name**: (Mandatory) The closed period to reconcile.
*   **Ledger**: (Optional) The set of books.

### Performance
*   **Summary Level**: It queries summary tables, so it is generally fast.
*   **Drill Down**: If a variance is found, users would switch to the "Inventory Out-of-Balance" report to find the specific item causing it.

### FAQ
**Q: Why is Receiving included?**
A: "Receiving Inspection" is an inventory asset account. Goods received but not yet delivered to stock are an asset that must be reconciled.

**Q: Does it handle Project Manufacturing?**
A: Yes, the logic includes PJM Cost Group accounting if enabled.

**Q: What if I don't have access to the GL?**
A: Then this report will likely return no data for the GL side, or error out. It requires both Inventory and GL access.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-restricted-by-org-access)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
