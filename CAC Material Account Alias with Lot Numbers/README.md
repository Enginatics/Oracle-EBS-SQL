---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Material Account Alias with Lot Numbers | Oracle EBS SQL Report'
description: 'Report to display the material account alias transactions by lot number. Specify Yes for Show Lot Number to split out the transaction quantities and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, Material, Account, Alias, mtl_transaction_reasons, mtl_parameters, hr_organization_information'
permalink: /CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/
report_name: 'CAC Material Account Alias with Lot Numbers'
report_web_name: cac-material-account-alias-with-lot-numbers
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Material Account Alias with Lot Numbers – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-material-account-alias-with-lot-numbers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to display the material account alias transactions by lot number.  Specify Yes for Show Lot Number to split out the transaction quantities and amounts by transaction lot number.  And if processed by Create Accounting, the Create Accounting column shows "Yes".

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show Lot Number:  enter Yes to see transactions by lot number, enter No to exclude lot information (mandatory).
Account Alias:  enter the account alias to report (optional).
Category Set 1, 2, 3:  any item category you wish (optional).
Item Number:  enter the item numbers you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2009-2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- |  1.1     11 Nov 2009 Douglas Volz   Added Org Code and transaction ID
-- |  1.2     12 Nov 2009 Douglas Volz   Added item and description
-- |  1.3     06 Jan 2010 Douglas Volz   Made dates a parameter
-- |  1.4     12 Jan 2010 Douglas Volz   Added quantity and unit cost columns
-- |  1.5     12 Jan 2010 Douglas Volz   Added account alias information
-- |  1.6     20 Jun 2010 Douglas Volz   Added created by information and fixed sort
-- |  1.7     27 Jun 2010 Douglas Volz   Fixed column label for user name, added Ledger parameter
-- |  1.8     16 Jul 2010 Douglas Volz   Added primary unit of measure (UOM), reason
-- |                                     code and transaction reference (comments) and added lot number
-- |  1.9     06 Feb 2012 Douglas Volz   Rewrite SQL report to solve cross-joining problem
-- |                                     with having multiple lot numbers per material transaction and multiple material overheads
-- |  1.10    22 Jun 2015 Douglas Volz   Added back comments to this code, removed client-specific SLA rules
-- |  1.11    17 May 2017 Douglas Volz   Added category sets
-- |  1.12    25 Mar 2025 Douglas Volz   Cleaned up code for Blitz Report and added Create Accounting Y/N column.
-- |  1.13    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Show Lot Number, Inventory Account Alias, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [mtl_generic_dispositions](https://www.enginatics.com/library/?pg=1&find=mtl_generic_dispositions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [mtl_transaction_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_lot_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [xla_distribution_links](https://www.enginatics.com/library/?pg=1&find=xla_distribution_links&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers)

## Related Reports
[INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cac-material-account-alias-with-lot-numbers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers) |
| Blitz Report™ XML Import | [CAC_Material_Account_Alias_with_Lot_Numbers.xml](https://www.enginatics.com/xml/cac-material-account-alias-with-lot-numbers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers) |
| SQL Source | [CAC Material Account Alias with Lot Numbers.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-material-account-alias-with-lot-numbers/](https://www.enginatics.com/reports/cac-material-account-alias-with-lot-numbers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers) |

## Case Study & Technical Analysis: CAC Material Account Alias with Lot Numbers

### Executive Summary
The **CAC Material Account Alias with Lot Numbers** report is a compliance and traceability tool. It focuses on "Account Alias" transactions—manual inventory adjustments where the user selects a GL account alias (e.g., "Scrap", "R&D Issue", "Inventory Adjustment"). Crucially, this report includes **Lot Number** details, which are often missing from standard GL reports.

### Business Challenge
*   **Traceability**: If a specific lot of chemicals is scrapped, Quality Assurance needs to know *exactly* which lot it was to update their records. Standard GL reports only show the dollar amount.
*   **Audit**: "Miscellaneous Issue" is a high-risk transaction type. Auditors scrutinize these to ensure inventory isn't being stolen or written off without cause.
*   **Cost Control**: Tracking which departments (via Account Alias) are consuming the most material for non-production purposes.

### Solution
This report provides a detailed audit trail.
*   **Lot Visibility**: Splits transactions by Lot Number, showing the specific quantity and cost for each lot.
*   **Alias Context**: Groups by the Account Alias name (e.g., "Engineering Sample") rather than just the cryptic GL account number.
*   **Financial Impact**: Shows the Unit Cost and Total Value of the adjustment.

### Technical Architecture
The report joins the transaction history to the lot transaction table:
*   **Tables**: `mtl_material_transactions` (MMT) and `mtl_transaction_lot_numbers` (MTLN).
*   **Join Logic**: `MMT.transaction_id = MTLN.transaction_id`.
*   **Alias Resolution**: Joins to `mtl_generic_dispositions` to get the user-friendly Alias Name.

### Parameters
*   **Transaction Date From/To**: (Mandatory) Audit period.
*   **Show Lot Number**: (Mandatory) "Yes" triggers the join to the lot table.
*   **Account Alias**: (Optional) Filter for a specific type of adjustment.

### Performance
*   **Volume**: MMT is the largest table in Oracle EBS. Running this for a wide date range without filters can be slow.
*   **Lot Explosion**: If "Show Lot Number" is Yes, a single transaction for 10 lots will become 10 rows, increasing the output size.

### FAQ
**Q: What if the item is not lot controlled?**
A: The report will still show the transaction, but the Lot Number column will be blank (or the row will not split, depending on the join type).

**Q: Does this show "Account Alias Receipts" too?**
A: Yes, it shows both Issues (negative qty) and Receipts (positive qty) performed via the Account Alias screen.

**Q: Can I see who performed the transaction?**
A: Yes, the report typically includes the "Created By" user, which is essential for auditing manual adjustments.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-material-account-alias-with-lot-numbers)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
