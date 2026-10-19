---
layout: default
last_modified_at: 2026-10-19
title: 'INV Physical Inventory Adjustments | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Physical inventory adjustments report Application: Inventory Source: Physical inventory adjustments report (XML)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Physical, Adjustments, dual, q_main, q_serial'
permalink: /INV%20Physical%20Inventory%20Adjustments/
report_name: 'INV Physical Inventory Adjustments'
report_web_name: inv-physical-inventory-adjustments
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Physical Inventory Adjustments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-physical-inventory-adjustments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Imported from BI Publisher
Description: Physical inventory adjustments report
Application: Inventory
Source: Physical inventory adjustments report (XML)
Short Name: INVARPAR_XML
DB package: INV_INVARPAR_XMLP_PKG

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Physical Inventory, Include Rejected Items, Adjustment Value Sort Option, Show Detail Serial Numbers

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments), [q_main](https://www.enginatics.com/library/?pg=1&find=q_main&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments), [q_serial](https://www.enginatics.com/library/?pg=1&find=q_serial&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments)

## Related Reports
[AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [INV Lot Transaction Register](/INV%20Lot%20Transaction%20Register/ "INV Lot Transaction Register Oracle EBS SQL Report"), [FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [AR Customer Statement](/AR%20Customer%20Statement/ "AR Customer Statement Oracle EBS SQL Report"), [OPM Reconcilation](/OPM%20Reconcilation/ "OPM Reconcilation Oracle EBS SQL Report"), [CE General Ledger Reconciliation](/CE%20General%20Ledger%20Reconciliation/ "CE General Ledger Reconciliation Oracle EBS SQL Report"), [PN GL Reconciliation](/PN%20GL%20Reconciliation/ "PN GL Reconciliation Oracle EBS SQL Report"), [WIP Value](/WIP%20Value/ "WIP Value Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Physical%20Inventory%20Adjustments/INV%20Physical%20Inventory%20Adjustments.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Physical Inventory Adjustments 03-May-2024 081549.xlsx](https://www.enginatics.com/example/inv-physical-inventory-adjustments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments) |
| Blitz Report™ XML Import | [INV_Physical_Inventory_Adjustments.xml](https://www.enginatics.com/xml/inv-physical-inventory-adjustments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments) |
| SQL Source | [INV Physical Inventory Adjustments.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Physical%20Inventory%20Adjustments/INV%20Physical%20Inventory%20Adjustments.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-physical-inventory-adjustments/](https://www.enginatics.com/reports/inv-physical-inventory-adjustments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments) |

## INV Physical Inventory Adjustments - Case Study & Technical Analysis

### Executive Summary
The **INV Physical Inventory Adjustments** report is the financial audit trail for the physical inventory process. Once the counting is done and the variances are approved, this report details the actual adjustments made to the inventory balances. It serves as the primary document for the finance team to reconcile the Inventory GL account.

### Business Challenge
When a physical inventory is finalized, the system automatically posts adjustments to correct the on-hand balances. Finance needs to know:
-   **Total Value:** "What is the net value of the inventory write-off?"
-   **Approvals:** "Were these large adjustments approved by the correct manager?"
-   **GL Impact:** "Which GL accounts were hit by these adjustments?"

### Solution
The **INV Physical Inventory Adjustments** report lists every adjustment transaction generated by the physical inventory. It groups them by adjustment account to facilitate GL reconciliation.

**Key Features:**
-   **Detailed Listing:** Shows Item, Subinventory, Locator, Lot, Serial, and Quantity Adjusted.
-   **Financial Values:** Displays the Unit Cost and Total Value of the adjustment.
-   **Approver Tracking:** (If configured) Shows who approved the adjustment.

### Technical Architecture
The report queries the adjustment history tables. These records are created when the "Post Physical Inventory Adjustments" program is run.

#### Key Tables and Views
-   **`MTL_PHYSICAL_ADJUSTMENTS`**: The core table storing the adjustment transactions.
-   **`MTL_PHYSICAL_INVENTORIES`**: The parent physical inventory record.
-   **`MTL_SYSTEM_ITEMS_VL`**: Item details.

#### Core Logic
1.  **Selection:** Retrieves records from `MTL_PHYSICAL_ADJUSTMENTS` for the given Physical Inventory name.
2.  **Sorting:** Can be sorted by value to highlight the most significant adjustments first.
3.  **Filtering:** Options to include or exclude rejected adjustments.

### Business Impact
-   **Financial Reconciliation:** The "Source of Truth" for explaining the "Physical Inventory Adjustment" line on the P&L.
-   **Loss Prevention:** Helps identify high-value losses that may indicate theft or process failure.
-   **Audit Trail:** Provides a permanent record of why inventory balances were changed.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-adjustments)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
