---
layout: default
last_modified_at: 2026-10-26
title: 'INV Subinventories | Oracle EBS SQL Report'
description: 'Profile subinventory report with subinventory name, description, status, default cost group, type, restriction attributes, and general ledger account…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Subinventories, mtl_parameters, hr_all_organization_units_vl, mtl_secondary_inventories_fk_v'
permalink: /INV%20Subinventories/
report_name: 'INV Subinventories'
report_web_name: inv-subinventories
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Subinventories – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-subinventories/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Profile subinventory report with subinventory name, description, status, default cost group, type, restriction attributes, and general ledger account linkages. For BR100.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories), [mtl_secondary_inventories_fk_v](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories_fk_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories)

## Related Reports
[INV Aging](/INV%20Aging/ "INV Aging Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Subinventories/INV%20Subinventories.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Subinventories 18-Jan-2018 222405.xlsx](https://www.enginatics.com/example/inv-subinventories/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories) |
| Blitz Report™ XML Import | [INV_Subinventories.xml](https://www.enginatics.com/xml/inv-subinventories/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories) |
| SQL Source | [INV Subinventories.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Subinventories/INV%20Subinventories.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-subinventories/](https://www.enginatics.com/reports/inv-subinventories/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories) |

## INV Subinventories - Case Study & Technical Analysis

### Executive Summary
The **INV Subinventories** report is a configuration audit document. It lists all the subinventories (storage areas) defined within an organization, along with their control parameters. This report is crucial for validating the physical layout of the warehouse against the system configuration.

### Business Challenge
Subinventories are the primary "zones" of a warehouse (e.g., "Raw Materials", "Finished Goods", "Returns"). Incorrect setup leads to:
-   **Accounting Errors:** If the "Expense" subinventory is linked to an Asset account, the balance sheet will be wrong.
-   **Process Failures:** If a subinventory is not "Quantity Tracked", stock will disappear from the books as soon as it is received.
-   **Planning Issues:** If the "Nettable" flag is off, MRP will ignore the stock in that area, leading to unnecessary purchasing.

### Solution
The **INV Subinventories** report provides a detailed view of each subinventory's configuration. It serves as the "BR100" (Setup Document) for the warehouse structure.

**Key Features:**
-   **Control Flags:** Shows Quantity Tracked, Asset Inventory, Nettable, and Include in ATP flags.
-   **Account Mapping:** Displays the Material and Expense accounts linked to the subinventory.
-   **Locators:** Indicates if the subinventory requires Locator control (Prespecified, Dynamic, or None).

### Technical Architecture
The report queries the secondary inventory definition table.

#### Key Tables and Views
-   **`MTL_SECONDARY_INVENTORIES`**: The master table for subinventory definitions.
-   **`MTL_PARAMETERS`**: Organization context.
-   **`GL_CODE_COMBINATIONS`**: Account details.

#### Core Logic
1.  **Retrieval:** Selects all records from `MTL_SECONDARY_INVENTORIES` for the organization.
2.  **Decoding:** Translates flags (1/2) into Yes/No.
3.  **Context:** Joins to the GL to show the account segments (e.g., 01-000-1210-0000).

### Business Impact
-   **Setup Validation:** Ensures that the system configuration matches the business design.
-   **Financial Integrity:** Verifies that inventory value is flowing to the correct GL accounts.
-   **Operational Control:** Confirms that restricted areas (like "Quarantine") are properly flagged to prevent accidental usage.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventories)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
