---
layout: default
last_modified_at: 2026-10-19
title: 'CAC Shipping Networks Missing Interco OU Relationships | Oracle EBS SQL Report'
description: 'Report to show the missing inventory intercompany operating unit relationships. This report has no parameters. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Shipping, Networks, Missing, mtl_interorg_parameters, org_organization_definitions, mtl_parameters'
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
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [mtl_intercompany_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_intercompany_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [hr_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships), [qp_list_headers_tl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-shipping-networks-missing-interco-ou-relationships)

## Related Reports
[CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC Inventory Out-of-Balance](/CAC%20Inventory%20Out-of-Balance/ "CAC Inventory Out-of-Balance Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [CAC Intransit Value (Real-Time)](/CAC%20Intransit%20Value%20%28Real-Time%29/ "CAC Intransit Value (Real-Time) Oracle EBS SQL Report"), [CAC Shipping Network (Inter-Org) Accounts Setup](/CAC%20Shipping%20Network%20%28Inter-Org%29%20Accounts%20Setup/ "CAC Shipping Network (Inter-Org) Accounts Setup Oracle EBS SQL Report"), [CAC Intercompany SO Shipping Transaction vs. Invoice Price](/CAC%20Intercompany%20SO%20Shipping%20Transaction%20vs-%20Invoice%20Price/ "CAC Intercompany SO Shipping Transaction vs. Invoice Price Oracle EBS SQL Report")

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
