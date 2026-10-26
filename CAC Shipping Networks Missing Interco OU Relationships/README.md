---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Shipping Networks Missing Interco OU Relationships | Oracle EBS SQL Report'
description: 'Report to show the missing inventory intercompany operating unit relationships. This report has no parameters. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Shipping, Networks, Missing, mtl_interorg_parameters, mtl_parameters, hr_organization_information'
permalink: /CAC%20Shipping%20Networks%20Missing%20Interco%20OU%20Relationships/
report_name: 'CAC Shipping Networks Missing Interco OU Relationships'
report_web_name: cac-shipping-networks-missing-interco-ou-relationships
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Shipping Networks Missing Interco OU Relationships – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-shipping-networks-missing-interco-ou-relationships/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show the missing inventory intercompany operating unit relationships.  This report has no parameters.

/* +=============================================================================+
-- |  Copyright 2009 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_missing_interco_setups_for_shipping_networks_v1.sql
-- |
-- |  Parameters:
-- |  None
-- | 
-- |  Description:
-- |  Report to show the missing inventory intercompany operating unit relationships.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     16 Oct 2018 Douglas Volz   Initial Coding
-- |  1.1     11 Apr 2019 Douglas Volz   Revert to Release 12
-- |  1.2     29 Apr 2020 Douglas Volz   Changed to multi-language views for the 
-- |                                     inventory orgs and operating units.
-- |  1.3     23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [mtl_intercompany_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_intercompany_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships)

## Related Reports
[CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Intransit Value (Real-Time)](/CAC%20Intransit%20Value%20%28Real-Time%29/ "CAC Intransit Value (Real-Time) Oracle EBS SQL Report"), [CAC Shipping Network (Inter-Org) Accounts Setup](/CAC%20Shipping%20Network%20%28Inter-Org%29%20Accounts%20Setup/ "CAC Shipping Network (Inter-Org) Accounts Setup Oracle EBS SQL Report"), [CAC Inventory Accounts Setup](/CAC%20Inventory%20Accounts%20Setup/ "CAC Inventory Accounts Setup Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Shipping%20Networks%20Missing%20Interco%20OU%20Relationships/CAC%20Shipping%20Networks%20Missing%20Interco%20OU%20Relationships.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Shipping Networks Missing Interco OU Relationships 08-Jul-2022 200126.xlsx](https://www.enginatics.com/example/cac-shipping-networks-missing-interco-ou-relationships/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships) |
| Blitz Report™ XML Import | [CAC_Shipping_Networks_Missing_Interco_OU_Relationships.xml](https://www.enginatics.com/xml/cac-shipping-networks-missing-interco-ou-relationships/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships) |
| SQL Source | [CAC Shipping Networks Missing Interco OU Relationships.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Shipping%20Networks%20Missing%20Interco%20OU%20Relationships/CAC%20Shipping%20Networks%20Missing%20Interco%20OU%20Relationships.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-shipping-networks-missing-interco-ou-relationships/](https://www.enginatics.com/reports/cac-shipping-networks-missing-interco-ou-relationships/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships) |

## Case Study & Technical Analysis: CAC Shipping Networks Missing Interco OU Relationships

### Executive Summary
The **CAC Shipping Networks Missing Interco OU Relationships** report is a specific configuration validator. In Oracle EBS, defining a "Shipping Network" (physical path) between two organizations is not enough for financial transactions. You must also define the "Intercompany Relations" (financial path) between their respective Operating Units. This report finds the gaps.

### Business Challenge
*   **Transaction Failures**: You can ship the goods (physical), but the financial transaction will fail or get stuck in the interface because the system doesn't know which AR/AP accounts to use.
*   **New Org Setup**: When rolling out a new warehouse, it's easy to forget the inter-company setup, especially if the warehouse belongs to an existing Operating Unit.

### Solution
This report compares two setups.
*   **Source 1**: `mtl_interorg_parameters` (The Shipping Network).
*   **Source 2**: `mtl_intercompany_parameters` (The Financial Relationship).
*   **Logic**: If a Shipping Network exists between Org A (OU 1) and Org B (OU 2), but no Intercompany Relationship exists between OU 1 and OU 2, it flags the error.

### Technical Architecture
*   **Tables**: `mtl_interorg_parameters`, `mtl_intercompany_parameters`, `hr_organization_information`.
*   **Logic**: Uses a `MINUS` or `NOT EXISTS` logic to find the missing links.

### Parameters
*   None. It scans the entire system.

### Performance
*   **Fast**: Configuration tables are small.

### FAQ
**Q: Do I need this for Intracompany (same OU) transfers?**
A: No, transfers within the same Operating Unit do not require Intercompany Relations. This report filters for cross-OU networks.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
