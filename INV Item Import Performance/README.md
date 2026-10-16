---
layout: default
last_modified_at: 2026-10-16
title: 'INV Item Import Performance | Oracle EBS SQL Report'
description: 'Analytical report by item to predict performance of inventory item load background processes. If the number of items processed per second is decreasing…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Item, Import, Performance, mtl_system_items_b, fnd_concurrent_requests, fnd_concurrent_programs_tl'
permalink: /INV%20Item%20Import%20Performance/
report_name: 'INV Item Import Performance'
report_web_name: inv-item-import-performance
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Item Import Performance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-import-performance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Analytical report by item to predict performance of inventory item load background processes. If the number of items processed per second is decreasing with increasing total items processed, then the interface SQLs are most likely using a wrong nonselective index and should be corrected.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Past Days, Min Total Item Count

## Oracle EBS Tables Used
[mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance), [fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance), [fnd_concurrent_programs_tl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance)

## Related Reports
[FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [Blitz Report Custom Reports Converter](/Blitz%20Report%20Custom%20Reports%20Converter/ "Blitz Report Custom Reports Converter Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Import%20Performance/INV%20Item%20Import%20Performance.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Item Import Performance 28-Jul-2020 181611.xlsx](https://www.enginatics.com/example/inv-item-import-performance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance) |
| Blitz Report™ XML Import | [INV_Item_Import_Performance.xml](https://www.enginatics.com/xml/inv-item-import-performance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance) |
| SQL Source | [INV Item Import Performance.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Import%20Performance/INV%20Item%20Import%20Performance.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-item-import-performance/](https://www.enginatics.com/reports/inv-item-import-performance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-import-performance)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
