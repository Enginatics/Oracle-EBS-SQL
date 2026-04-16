---
layout: default
title: 'INV Safety Stocks | Oracle EBS SQL Report'
description: 'Master data report for inventory safety stock with inventory org code, item, effective date, UOM,safety stock quantity, safety stock method, forecast …'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Safety, Stocks, hr_all_organization_units_vl, mtl_parameters, mtl_safety_stocks'
permalink: /INV%20Safety%20Stocks/
---

# INV Safety Stocks – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-safety-stocks/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report for inventory safety stock with inventory org code, item, effective date, UOM,safety stock quantity, safety stock method, forecast , safety stock percent, service level and creation information.

## Report Parameters
Item, Organization Code

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_safety_stocks](https://www.enginatics.com/library/?pg=1&find=mtl_safety_stocks), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pjm_seiban_numbers](https://www.enginatics.com/library/?pg=1&find=pjm_seiban_numbers), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [WIP Entities](/WIP%20Entities/ "WIP Entities Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Safety Stocks 18-Jan-2018 222727.xlsx](https://www.enginatics.com/example/inv-safety-stocks/) |
| Blitz Report™ XML Import | [INV_Safety_Stocks.xml](https://www.enginatics.com/xml/inv-safety-stocks/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-safety-stocks/](https://www.enginatics.com/reports/inv-safety-stocks/) |

## INV Safety Stocks - Case Study & Technical Analysis

### Executive Summary
The **INV Safety Stocks** report is a master data report that lists the currently defined safety stock levels for items in an organization. It is the "System of Record" view, showing what the planning engine (MRP/ASCP) sees as the required buffer.

### Business Challenge
Planners need to verify that the system is using the correct safety stock figures.
-   **Verification:** "I uploaded the new safety stocks, but did they take effect?"
-   **Method Visibility:** "Is this item using a fixed quantity (e.g., 100 units) or a dynamic calculation (e.g., 5 days of supply)?"
-   **Audit:** "Why did MRP suggest we buy so much? Oh, the safety stock was set to 10,000 by mistake."

### Solution
The **INV Safety Stocks** report dumps the contents of the safety stock table. It shows the method, quantity, and effectivity dates for each item.

**Key Features:**
-   **Method Display:** Shows if the safety stock is User Defined (MRP Planned) or Non-MRP Planned.
-   **Time Phasing:** Shows the effective date range for the safety stock entry.
-   **Project Details:** Includes Project and Task references for project-specific safety stock.

### Technical Architecture
The report is a direct query of the safety stock definition table.

#### Key Tables and Views
-   **`MTL_SAFETY_STOCKS`**: The primary table.
-   **`MTL_SYSTEM_ITEMS_VL`**: Item details.
-   **`MTL_PARAMETERS`**: Organization details.

#### Core Logic
1.  **Retrieval:** Selects all records from `MTL_SAFETY_STOCKS` for the given organization.
2.  **Decoding:** Translates the `SAFETY_STOCK_CODE` into readable text (e.g., 1 = User Defined, 2 = MRP Calculated).
3.  **Formatting:** Presents the data in a list format suitable for review.

### Business Impact
-   **Data Quality:** Helps identify outliers (e.g., negative safety stocks or impossibly high numbers).
-   **Planning Accuracy:** Ensures that the inputs to the planning engine are correct.
-   **Transparency:** Provides visibility into one of the key drivers of inventory investment.


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
