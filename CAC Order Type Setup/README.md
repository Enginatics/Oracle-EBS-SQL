---
layout: default
title: 'CAC Order Type Setup | Oracle EBS SQL Report'
description: 'Report to display the sales order transaction types with the corresponding receivables (A/R) transaction types. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Order, Type, Setup, oe_transaction_types_tl, oe_transaction_types_all, gl_code_combinations'
permalink: /CAC%20Order%20Type%20Setup/
---

# CAC Order Type Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-order-type-setup/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to display the sales order transaction types with the corresponding receivables (A/R) transaction types.

/* +=============================================================================+
-- |  Copyright 2016 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_oe_transaction_types.sql
-- |
-- |  Parameters:
-- |  p_operating_unit       -- Operating Unit you wish to report, leave blank for all
-- |                            operating units (optional) 
-- |  p_ledger               -- general ledger you wish to report, leave blank for all
-- |                            ledgers (optional)
-- |  Description:
-- |  Report to display the sales order transaction types with the corresponding
-- |  receivables (A/R) transaction types. 
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     15 Nov 2016 Douglas Volz   Initial Coding
-- |  1.1     09 Jan 2017 Douglas Volz   Added description and Receivables Txn Type
-- |  1.2     11 Jan 2017 Douglas Volz   Added Order Category, Order Type (DFF),
-- |                                     and Disti Plus Pricing (DFF), and add a
-- |                                     new section for Order Types with no COGS
-- |                                     account.
-- |  1.3     14 Mar 2017 Douglas Volz   Changed apps.ra_cust_trx_types to 
-- |                                     apps.ra_cust_trx_types_all, added A/R
-- |                                     revenue account
-- |  1.4     23 Aug 2017 Douglas Volz   Add user-defined field (descriptive flex-
-- |                                     field) for the COGS ICP account, a contra-
-- |                                     account which is used to record the ICP
-- |                                     portion of the COGS entry.
-- |  1.5     13 Mar 2019 Douglas Volz   Added Operating Unit Parameter.
-- |  1.6     22 May 2019 Douglas Volz   Added missing ORG_ID join
-- |  1.7     14 Apr 2020 Douglas Volz   Added creation date to report
-- |  1.8     16 Apr 2020 Douglas Volz   Moved sales ccid joins to outer query
-- |                                     and added Ledger parameter.
-- |  1.9     28 Apr 2020 Douglas Volz   Changed to multi-language views for the
-- |                                     inventory orgs and operating units.
-- +=============================================================================+*/

## Report Parameters
Operating Unit, Ledger

## Oracle EBS Tables Used
[oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl), [oe_transaction_types_all](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_all), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Order Type Setup 07-Jul-2022 172953.xlsx](https://www.enginatics.com/example/cac-order-type-setup/) |
| Blitz Report™ XML Import | [CAC_Order_Type_Setup.xml](https://www.enginatics.com/xml/cac-order-type-setup/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-order-type-setup/](https://www.enginatics.com/reports/cac-order-type-setup/) |

## Case Study & Technical Analysis: CAC Order Type Setup

### Executive Summary
The **CAC Order Type Setup** report is a configuration audit tool for Oracle Order Management (OM). It documents the setup of Sales Order Transaction Types and their critical links to Accounts Receivable (AR) and the General Ledger (GL). This setup dictates the financial orchestration of the "Order-to-Cash" cycle.

### Business Challenge
*   **Revenue Recognition**: If an Order Type is mapped to the wrong AR Transaction Type, revenue might be recognized immediately instead of being deferred (or vice versa).
*   **COGS Account**: The "Cost of Goods Sold" account is often derived from the Order Type. Errors here lead to incorrect margin analysis by product line.
*   **Invoicing Failures**: "Why didn't this order generate an invoice?" Often, the Order Type is not properly linked to an AR Transaction Type.

### Solution
This report provides a clear map of the configuration.
*   **Mapping**: Shows `Order Type` -> `Line Type` -> `AR Transaction Type`.
*   **Accounting**: Displays the COGS Account and the Revenue Account associated with the types.
*   **Workflow**: Identifies the fulfillment flow (e.g., "Order Flow - Generic").

### Technical Architecture
*   **Tables**: `oe_transaction_types_tl` (OM Types), `ra_cust_trx_types_all` (AR Types), `gl_code_combinations`.
*   **Hierarchy**: Order Management uses a hierarchy where Line Type settings can override Header Type settings. This report typically focuses on the Line Type as it drives the accounting.

### Parameters
*   **Operating Unit**: (Optional) Filter by OU.
*   **Ledger**: (Optional) Filter by Ledger.

### Performance
*   **Fast**: Configuration tables are small.

### FAQ
**Q: What is a "Line Type"?**
A: A Sales Order has a Header (Customer info) and Lines (Item info). The Line Type controls the workflow for the specific item (e.g., "Standard Line", "Return Line", "Bill Only Line").

**Q: Why is the COGS account important here?**
A: In Oracle EBS, the COGS Account Generator often uses the Order Type as a segment source. If this is wrong, your margins are wrong.


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
