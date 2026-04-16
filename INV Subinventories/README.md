---
layout: default
title: 'INV Subinventories | Oracle EBS SQL Report'
description: 'Profile subinventory report with subinventory name, description, status, default cost group, type, restriction attributes, and general ledger account…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Subinventories, mtl_parameters, hr_all_organization_units_vl, mtl_secondary_inventories_fk_v'
permalink: /INV%20Subinventories/
---

# INV Subinventories – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-subinventories/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Profile subinventory report with subinventory name, description, status, default cost group, type, restriction attributes, and general ledger account linkages. For BR100.

## Report Parameters
Organization Code

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_secondary_inventories_fk_v](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories_fk_v), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Onhand Lot Value (Real-Time)](/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/ "CAC Onhand Lot Value (Real-Time) Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Subinventories 18-Jan-2018 222405.xlsx](https://www.enginatics.com/example/inv-subinventories/) |
| Blitz Report™ XML Import | [INV_Subinventories.xml](https://www.enginatics.com/xml/inv-subinventories/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-subinventories/](https://www.enginatics.com/reports/inv-subinventories/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
