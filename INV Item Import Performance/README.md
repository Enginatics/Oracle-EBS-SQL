---
layout: default
title: 'INV Item Import Performance | Oracle EBS SQL Report'
description: 'Analytical report by item to predict performance of inventory item load background processes. If the number of items processed per second is decreasing…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Item, Import, Performance, mtl_system_items_b, fnd_concurrent_requests, fnd_concurrent_programs_tl'
permalink: /INV%20Item%20Import%20Performance/
---

# INV Item Import Performance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-import-performance/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Analytical report by item to predict performance of inventory item load background processes. If the number of items processed per second is decreasing with increasing total items processed, then the interface SQLs are most likely using a wrong nonselective index and should be corrected.

## Report Parameters
Past Days, Min Total Item Count

## Oracle EBS Tables Used
[mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b), [fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests), [fnd_concurrent_programs_tl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_tl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [FND Concurrent Managers](/FND%20Concurrent%20Managers/ "FND Concurrent Managers Oracle EBS SQL Report"), [FND Concurrent Request Conflicts](/FND%20Concurrent%20Request%20Conflicts/ "FND Concurrent Request Conflicts Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Item Import Performance 28-Jul-2020 181611.xlsx](https://www.enginatics.com/example/inv-item-import-performance/) |
| Blitz Report™ XML Import | [INV_Item_Import_Performance.xml](https://www.enginatics.com/xml/inv-item-import-performance/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-import-performance/](https://www.enginatics.com/reports/inv-item-import-performance/) |

## INV Item Import Performance - Case Study & Technical Analysis

### Executive Summary
The **INV Item Import Performance** report is a technical diagnostic tool used by DBAs and Developers. It analyzes the throughput of the Item Import Interface (`INCOIN`) to identify performance degradation. If the "Items Processed Per Second" metric drops as the volume increases, it typically indicates a missing index or a non-selective index on the interface tables.

### Business Use Cases
*   **Performance Tuning**: Used during data migration or large catalog updates to ensure the system can handle the load.
*   **SLA Monitoring**: Verifies that the nightly item feed from the PLM system is completing within the batch window.
*   **Root Cause Analysis**: Helps pinpoint why the "Item Import" concurrent request is taking 5 hours instead of 5 minutes.

### Technical Analysis

#### Core Tables
*   `MTL_SYSTEM_ITEMS_INTERFACE`: The interface table (implied source of the metrics).
*   `FND_CONCURRENT_REQUESTS`: Used to track the start/end time and status of the import jobs.
*   `MTL_SYSTEM_ITEMS_B`: The target table.

#### Key Joins & Logic
*   **Throughput Calculation**: `Items Per Second` = `Total Items Processed` / (`Request End Time` - `Request Start Time`).
*   **Trend Analysis**: The report looks for a negative correlation between volume and speed.

#### Key Parameters
*   **Past Days**: How far back to analyze the concurrent request history.
*   **Min Total Item Count**: Filter out small test batches to focus on bulk loads.


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
