---
layout: default
last_modified_at: 2026-10-19
title: 'CAC Inventory to G/L Reconciliation (Unrestricted by Org Access) | Oracle EBS SQL Report'
description: 'Report to compare the General Ledger inventory balances with the perpetual inventory values (based on the stored month-end inventory balances, generated…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Inventory, G/L, Reconciliation, mtl_secondary_inventories, mtl_parameters, mtl_interorg_parameters'
permalink: /CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Unrestricted%20by%20Org%20Access%29/
report_name: 'CAC Inventory to G/L Reconciliation (Unrestricted by Org Access)'
report_web_name: cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Inventory to G/L Reconciliation (Unrestricted by Org Access) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to compare the General Ledger inventory balances with the perpetual inventory values (based on the stored month-end inventory balances, generated when the inventory accounting period is closed).

/* +=============================================================================+
-- |  Copyright 2010-20 Douglas Volz Consulting, Inc.                            |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  XXX_INV_RECON_REPT.sql
-- |
-- |  Parameters:
-- |  P_PERIOD_NAME      -- Enter the Period Name you wish to reconcile balances for
-- |                        (mandatory)
-- |  P_LEDGER           -- general ledger you wish to report, for all ledgers enter
-- |                        a NULL or % symbol (optional parameter)
-- |
-- |  Description:
-- |  Report to reconcile G/L and the Inventory and WIP Perpetual
-- |  by Ledger and full account, for a desired accounting period.
-- |
-- |  ============================================================================
-- |  Does not consider cost groups and assumes the elemental cost accounts by
-- |  subinventory are the same as the material account.
-- |  This script also uses a custom lookup code called XXX_CST_GLINV_RECON_ACCOUNTS
-- |  as a means to determine the valid inventory account numbers
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
-- +=============================================================================+*/

XXX_INV_RECON_REPT_V5-20-Jul-2016.sql

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period Name (Closed), Ledger, Minimum Value Difference

## Oracle EBS Tables Used
[mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [rcv_parameters](https://www.enginatics.com/library/?pg=1&find=rcv_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [cst_cg_wip_acct_classes](https://www.enginatics.com/library/?pg=1&find=cst_cg_wip_acct_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [gl_balances](https://www.enginatics.com/library/?pg=1&find=gl_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [cst_period_close_summary](https://www.enginatics.com/library/?pg=1&find=cst_period_close_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [wip_period_balances](https://www.enginatics.com/library/?pg=1&find=wip_period_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access)

## Related Reports
[CAC Inventory to G/L Reconciliation (Restricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Restricted by Org Access) Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC WIP Account Summary](/CAC%20WIP%20Account%20Summary/ "CAC WIP Account Summary Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Unrestricted%20by%20Org%20Access%29/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Unrestricted%20by%20Org%20Access%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory to G L Reconciliation (Unrestricted by Org Access) 07-Jun-2020 015839.xlsx](https://www.enginatics.com/example/cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access) |
| Blitz Report™ XML Import | [CAC_Inventory_to_G_L_Reconciliation_Unrestricted_by_Org_Access.xml](https://www.enginatics.com/xml/cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access) |
| SQL Source | [CAC Inventory to G-L Reconciliation (Unrestricted by Org Access).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Unrestricted%20by%20Org%20Access%29/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Unrestricted%20by%20Org%20Access%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access/](https://www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access) |

## Case Study & Technical Analysis: CAC Inventory to G/L Reconciliation (Unrestricted by Org Access)

### Executive Summary
The **CAC Inventory to G/L Reconciliation (Unrestricted by Org Access)** report is the "Super User" version of the reconciliation tool. It provides a global view of the alignment between the General Ledger and the Inventory Subledger across all organizations and ledgers. This report is typically used by Corporate Controllers or Shared Service Centers to validate the month-end close for the entire enterprise.

### Business Challenge
Corporate Finance needs a holistic view of inventory health.
*   **Global Close**: Verifying that 50 different ledgers are all reconciled requires a tool that cuts across individual org security restrictions.
*   **Intercompany Imbalances**: Often, issues in one org (e.g., an intransit shipment) cause imbalances in another. A restricted view hides this relationship.
*   **Efficiency**: Running 50 separate reports for 50 orgs is inefficient.

### Solution
This report bypasses standard org security to provide a consolidated view.
*   **Global Scope**: Can be run for "All Ledgers" or a specific Ledger Set.
*   **Full Reconciliation**: Matches GL Balances to the sum of On-hand, Intransit, WIP, and Receiving.
*   **Account Discovery**: Automatically identifies the valuation accounts based on the Costing Method and Org Parameters, reducing setup time.

### Technical Architecture
Identical to the "Restricted" version but without the security predicates:
*   **Data Sources**: `gl_balances`, `cst_period_close_summary`, `wip_period_balances`, `rcv_receiving_sub_ledger`.
*   **Logic**: Aggregates subledger data by GL Account and compares it to the GL Balance for that same account.

### Parameters
*   **Period Name**: (Mandatory) The period to reconcile.
*   **Ledger**: (Optional) Leave blank for all.

### Performance
*   **High Volume**: Running this for "All Ledgers" in a massive environment can be slow. It is best to run it by Ledger or Ledger Set.

### FAQ
**Q: Who should use this report?**
A: Corporate Controllers, System Administrators, or Central Finance users. Plant-level users should use the Restricted version.

**Q: Does it show manual journal entries?**
A: Yes, manual JEs to the inventory account will appear in the GL balance but not the subledger, causing a variance. This is a common finding.

**Q: Can I see the variance by Item?**
A: No, this is an Account-level reconciliation. For Item-level detail, use the "Inventory Out-of-Balance" report.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
