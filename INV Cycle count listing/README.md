---
layout: default
title: 'INV Cycle count listing | Oracle EBS SQL Report'
description: 'Imported Oracle standard cycle count listing report Source: Cycle count listing (XML) Short Name: INVARCLIXML DB package: INVINVARCLIXMLPPKG'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Cycle, count, listing, mtl_item_locations_kfv, mtl_onhand_quantities_detail, mtl_serial_numbers'
permalink: /INV%20Cycle%20count%20listing/
---

# INV Cycle count listing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-cycle-count-listing/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard cycle count listing report
Source: Cycle count listing (XML)
Short Name: INVARCLI_XML
DB package: INV_INVARCLI_XMLP_PKG

## Report Parameters
Organization Code, Cycle Count Name, Due Date From, Due Date To, Include Recounts Only, Subinventory, Items to include

## Oracle EBS Tables Used
[mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail), [mtl_serial_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_serial_numbers), [mtl_cc_serial_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_cc_serial_numbers), [mtl_abc_classes](https://www.enginatics.com/library/?pg=1&find=mtl_abc_classes), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [mtl_cycle_count_items](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_items), [mtl_cycle_count_entries](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_entries), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [wms_license_plate_numbers](https://www.enginatics.com/library/?pg=1&find=wms_license_plate_numbers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Cycle count entries and adjustments](/INV%20Cycle%20count%20entries%20and%20adjustments/ "INV Cycle count entries and adjustments Oracle EBS SQL Report"), [INV Cycle counts pending approval](/INV%20Cycle%20counts%20pending%20approval/ "INV Cycle counts pending approval Oracle EBS SQL Report"), [INV Cycle count open requests listing](/INV%20Cycle%20count%20open%20requests%20listing/ "INV Cycle count open requests listing Oracle EBS SQL Report"), [INV Cycle count hit/miss analysis](/INV%20Cycle%20count%20hit-miss%20analysis/ "INV Cycle count hit/miss analysis Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Transaction Register](/INV%20Transaction%20Register/ "INV Transaction Register Oracle EBS SQL Report"), [INV Lot Transaction Register](/INV%20Lot%20Transaction%20Register/ "INV Lot Transaction Register Oracle EBS SQL Report"), [INV Print Cycle Count Entries Open Interface data](/INV%20Print%20Cycle%20Count%20Entries%20Open%20Interface%20data/ "INV Print Cycle Count Entries Open Interface data Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/inv-cycle-count-listing/) |
| Blitz Report™ XML Import | [INV_Cycle_count_listing.xml](https://www.enginatics.com/xml/inv-cycle-count-listing/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-cycle-count-listing/](https://www.enginatics.com/reports/inv-cycle-count-listing/) |

## INV Cycle Count Listing - Case Study

### Executive Summary
The **INV Cycle Count Listing** report is a fundamental tool for Inventory Management and Warehouse Operations. It generates the official list of items scheduled for cycle counting, serving as the primary document for warehouse staff to perform physical counts. By providing a structured and accurate counting schedule, this report ensures inventory accuracy, supports compliance with audit requirements, and minimizes operational disruptions caused by stock discrepancies.

### Business Challenge
Maintaining accurate inventory levels is a constant battle for supply chain organizations:
*   **Stock Discrepancies:** "System" quantity vs. "Physical" quantity mismatches lead to missed sales or excess carrying costs.
*   **Audit Compliance:** External auditors require a systematic and documented process for verifying inventory assets.
*   **Operational Inefficiency:** Without a targeted list, warehouse staff might count random items or miss high-value items that require frequent verification (ABC analysis).
*   **Blind Counting:** Providing the system quantity to counters can lead to bias; a proper listing often needs to support "blind" counting.

### The Solution
The **INV Cycle Count Listing** provides the "Operational View" necessary to execute the cycle count process effectively.

**Key Features:**
*   **Scheduled Generation:** Based on the cycle count scheduler, ensuring that items are counted at their required frequency (e.g., A-items monthly, C-items yearly).
*   **Location Precision:** Lists items by Subinventory and Locator, guiding warehouse staff through an efficient counting path.
*   **Serial & Lot Detail:** Includes support for serial-controlled and lot-controlled items, ensuring granular accuracy.
*   **Flexibility:** Can be generated for specific subinventories or date ranges to match workforce availability.

### Technical Architecture
The report extracts data from the Inventory Cycle Counting module, linking schedule requests to item definitions.

**Primary Tables:**
*   `MTL_CYCLE_COUNT_HEADERS`: Defines the cycle count name, frequency, and parameters.
*   `MTL_CYCLE_COUNT_ENTRIES`: The core table containing the specific count requests generated by the scheduler. It links the item to the count header.
*   `MTL_SYSTEM_ITEMS_VL`: Provides item descriptions and attributes.
*   `MTL_ITEM_LOCATIONS_KFV`: Resolves locator IDs into human-readable locator codes (e.g., Row-Rack-Bin).
*   `MTL_CC_SERIAL_NUMBERS`: Handles specific serial number details for serialized counts.

**Logical Relationships:**
The report joins **Cycle Count Entries** to **System Items** and **Item Locations** to provide a readable list. It filters based on the **Cycle Count Header** to ensure only the relevant count batch is displayed.

### Parameters & Filtering
Users can refine the output to suit specific operational needs:
*   **Organization Code:** The specific warehouse or inventory organization being counted.
*   **Cycle Count Name:** The specific cycle count definition (e.g., "Main Warehouse Daily").
*   **Start/End Date:** Defines the window of scheduled counts to include.
*   **Subinventory:** Allows generating lists for specific zones or areas within the warehouse.
*   **Include Recounts Only:** Filters the list to show only items that failed tolerance checks and require a second count.

### Performance & Optimization
*   **Indexed Retrieval:** The query leverages indexes on `CYCLE_COUNT_HEADER_ID` and `ORGANIZATION_ID` to quickly retrieve pending entries.
*   **Efficient Joins:** Joins to `MTL_SYSTEM_ITEMS` and `MTL_ITEM_LOCATIONS` are optimized to handle high volumes of SKU data without performance degradation.

### Frequently Asked Questions
**Q: Does this report show the system on-hand quantity?**
A: This depends on the report configuration and the specific template used. For "blind" counts, the system quantity is typically suppressed to ensure an unbiased physical count.

**Q: Can this report handle serial number counting?**
A: Yes, the underlying architecture (`MTL_CC_SERIAL_NUMBERS`) supports listing individual serial numbers for verification.

**Q: Why are some items missing from the list?**
A: Items only appear if they have been successfully scheduled by the "Generate Cycle Count Requests" program. If an item is not due for counting based on its frequency or if it has zero on-hand (depending on setup), it may not appear.


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
