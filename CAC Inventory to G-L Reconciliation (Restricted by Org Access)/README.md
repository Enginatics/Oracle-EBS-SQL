---
layout: default
title: 'CAC Inventory to G/L Reconciliation (Restricted by Org Access) | Oracle EBS SQL Report'
description: 'For Discrete Costing, this report compares the General Ledger inventory balances with the perpetual inventory values (based on the stored month-end…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, Inventory, G/L, Reconciliation, mtl_secondary_inventories, mtl_parameters, pjm_org_parameters'
permalink: /CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/
---

# CAC Inventory to G/L Reconciliation (Restricted by Org Access) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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


## Report Parameters
Period Name (Closed), Ledger, Minimum Value Difference

## Oracle EBS Tables Used
[mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [pjm_org_parameters](https://www.enginatics.com/library/?pg=1&find=pjm_org_parameters), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters), [rcv_parameters](https://www.enginatics.com/library/?pg=1&find=rcv_parameters), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts), [cst_cg_wip_acct_classes](https://www.enginatics.com/library/?pg=1&find=cst_cg_wip_acct_classes), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_balances](https://www.enginatics.com/library/?pg=1&find=gl_balances), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines), [y](https://www.enginatics.com/library/?pg=1&find=y), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory to G L Reconciliation (Restricted by Org Access) 07-Jul-2022 144051.xlsx](https://www.enginatics.com/example/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/) |
| Blitz Report™ XML Import | [CAC_Inventory_to_G_L_Reconciliation_Restricted_by_Org_Access.xml](https://www.enginatics.com/xml/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/](https://www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
