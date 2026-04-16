---
layout: default
title: 'CAC Material Account Alias with Lot Numbers | Oracle EBS SQL Report'
description: 'Report to display the material account alias transactions by lot number. Specify Yes for Show Lot Number to split out the transaction quantities and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Material, Account, Alias, mtl_transaction_reasons, mtl_transaction_types, mtl_system_items_vl'
permalink: /CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/
---

# CAC Material Account Alias with Lot Numbers – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-material-account-alias-with-lot-numbers/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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
-- +=============================================================================+*/


## Report Parameters
Transaction Date From, Transaction Date To, Show Lot Number, Inventory Account Alias, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_transaction_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_lot_numbers), [mtl_generic_dispositions](https://www.enginatics.com/library/?pg=1&find=mtl_generic_dispositions), [inv_organizations](https://www.enginatics.com/library/?pg=1&find=inv_organizations), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts), [xla_distribution_links](https://www.enginatics.com/library/?pg=1&find=xla_distribution_links), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC WIP Account Detail](/CAC%20WIP%20Account%20Detail/ "CAC WIP Account Detail Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-material-account-alias-with-lot-numbers/) |
| Blitz Report™ XML Import | [CAC_Material_Account_Alias_with_Lot_Numbers.xml](https://www.enginatics.com/xml/cac-material-account-alias-with-lot-numbers/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-material-account-alias-with-lot-numbers/](https://www.enginatics.com/reports/cac-material-account-alias-with-lot-numbers/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
