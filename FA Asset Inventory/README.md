---
layout: default
title: 'FA Asset Inventory | Oracle EBS SQL Report'
description: 'Imported Oracle standard asset inventory report Source: Asset Inventory Report (XML) Short Name: FAS410XML DB package: FAFAS410XMLPPKG'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Asset, Inventory, fa_system_controls, fa_deprn_detail, per_people_f'
permalink: /FA%20Asset%20Inventory/
---

# FA Asset Inventory – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-inventory/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard asset inventory report
Source: Asset Inventory Report (XML)
Short Name: FAS410_XML
DB package: FA_FAS410_XMLP_PKG

## Report Parameters
Book, From Cost Center, To Cost Center, From Date Placed in Service, To Date Placed in Service

## Oracle EBS Tables Used
[fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls), [fa_deprn_detail](https://www.enginatics.com/library/?pg=1&find=fa_deprn_detail), [per_people_f](https://www.enginatics.com/library/?pg=1&find=per_people_f), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [fa_locations](https://www.enginatics.com/library/?pg=1&find=fa_locations), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fa_books](https://www.enginatics.com/library/?pg=1&find=fa_books), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [fa_adjustments](https://www.enginatics.com/library/?pg=1&find=fa_adjustments), [fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Asset Inventory 30-Sep-2020 221751.xlsx](https://www.enginatics.com/example/fa-asset-inventory/) |
| Blitz Report™ XML Import | [FA_Asset_Inventory.xml](https://www.enginatics.com/xml/fa-asset-inventory/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-asset-inventory/](https://www.enginatics.com/reports/fa-asset-inventory/) |

## Executive Summary
The **FA Asset Inventory** report is a direct import of the standard Oracle "Asset Inventory Report" (FAS410_XML). It generates a comprehensive list of assets for physical inventory verification, ensuring that the system records match the physical reality of asset holdings.

## Business Challenge
*   **Physical Verification:** The need to periodically verify the existence and condition of fixed assets.
*   **Ghost Assets:** Identifying assets that are recorded in the system but no longer exist physically.
*   **Location Tracking:** Ensuring assets are located where the system says they are.

## The Solution
This Blitz Report provides the standard Oracle functionality with the added benefit of direct Excel output:
*   **Standard Compliance:** Uses the certified Oracle logic (`FA_FAS410_XMLP_PKG`) for inventory reporting.
*   **Location & Custodian:** Displays key physical attributes like Location, Employee, and Tag Number.
*   **Cost Center Analysis:** Allows grouping by cost center for departmental sign-offs.

## Technical Architecture
This report is based on the Oracle standard XML Publisher report `FAS410_XML`. It utilizes standard views and tables such as `FA_ADDITIONS`, `FA_BOOKS`, `FA_LOCATIONS`, and `FA_DISTRIBUTION_HISTORY`. It calculates current cost and net book value as of the run date.

## Parameters & Filtering
*   **Book:** The depreciation book (Required).
*   **From/To Cost Center:** Range of cost centers to limit the inventory list.
*   **From/To Date Placed in Service:** Filter assets based on their capitalization date.

## Performance & Optimization
*   **Cost Center Batching:** For large organizations, run the report by ranges of Cost Centers to distribute the verification workload.
*   **Active Assets:** The report typically filters for active assets; ensure retired assets are not expected unless specified.

## FAQ
*   **Q: Is this different from the standard Oracle PDF report?**
    *   A: The data source is the same, but Blitz Report renders it directly into Excel, making it easier to filter, sort, and use as a checklist.
*   **Q: Can I see retired assets?**
    *   A: This report is primarily for existing inventory. Use "FA Asset Retirements" for retired assets.


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
