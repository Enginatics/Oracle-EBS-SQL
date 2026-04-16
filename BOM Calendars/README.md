---
layout: default
title: 'BOM Calendars | Oracle EBS SQL Report'
description: 'Bill of material calendars and calendar dates – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, BOM, Calendars, bom_calendars, bom_calendar_dates, mtl_parameters'
permalink: /BOM%20Calendars/
---

# BOM Calendars – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/bom-calendars/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Bill of material calendars and calendar dates

## Report Parameters
Calendar, Show Organizations, Organization Code, Show Dates, Future only

## Oracle EBS Tables Used
[bom_calendars](https://www.enginatics.com/library/?pg=1&find=bom_calendars), [bom_calendar_dates](https://www.enginatics.com/library/?pg=1&find=bom_calendar_dates), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [BOM Calendar Exceptions](/BOM%20Calendar%20Exceptions/ "BOM Calendar Exceptions Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [INV Organization Parameters](/INV%20Organization%20Parameters/ "INV Organization Parameters Oracle EBS SQL Report"), [PA Project Upload](/PA%20Project%20Upload/ "PA Project Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [BOM Calendars 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/bom-calendars/) |
| Blitz Report™ XML Import | [BOM_Calendars.xml](https://www.enginatics.com/xml/bom-calendars/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/bom-calendars/](https://www.enginatics.com/reports/bom-calendars/) |

## Case Study & Technical Analysis: BOM Calendars Report

### Executive Summary
The **BOM Calendars** report provides a comprehensive operational view of the manufacturing and planning calendars defined within Oracle E-Business Suite. These calendars are the backbone of supply chain planning, determining working days, shifts, and exceptions for manufacturing resources. This report offers a streamlined way to audit, validate, and visualize calendar configurations across the enterprise, ensuring that production schedules align with actual working capacity.

### Business Challenge
In complex manufacturing environments, maintaining accurate calendars is critical but often overlooked.
*   **Scheduling Errors:** Incorrect calendar definitions (e.g., missing holidays or incorrect shift patterns) can lead to unrealistic production schedules and missed delivery dates.
*   **Visibility Gaps:** Standard Oracle forms make it difficult to compare calendars across multiple organizations or to see a holistic view of working vs. non-working days over a long horizon.
*   **Planning Failures:** MRP and ASCP engines rely heavily on these calendars. Discrepancies between the system calendar and the physical plant reality result in planning exceptions and material shortages.

### The Solution
The **BOM Calendars** report solves these challenges by extracting calendar definitions and their associated dates directly from the database into a flexible Excel format.
*   **Operational View:** Users can quickly list all calendars, their start/end dates, and their assignment to specific inventory organizations.
*   **Detailed Audit:** The report allows for expanding the view to individual calendar dates, making it easy to spot-check holidays, weekends, and exception days.
*   **Cross-Organization Comparison:** By enabling organization details, planners can verify that all relevant plants are using the correct master calendar.

### Technical Architecture (High Level)
This report is built on a robust SQL query that joins calendar header information with detailed date records and organization assignments.

#### Primary Tables
*   `BOM_CALENDARS`: Stores the header information for calendars (Code, Description, Start/End Dates).
*   `BOM_CALENDAR_DATES`: Contains the individual dates for each calendar, indicating working or non-working status.
*   `MTL_PARAMETERS`: Links calendars to Inventory Organizations.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: Provides human-readable organization names.

#### Logical Relationships
*   The core logic starts with `BOM_CALENDARS`.
*   It performs an **Outer Join** to `BOM_CALENDAR_DATES` to optionally retrieve the specific dates associated with each calendar.
*   It also performs an **Outer Join** to `MTL_PARAMETERS` (and subsequently `HR_ALL_ORGANIZATION_UNITS_VL`) to identify which organizations are utilizing a specific calendar code.
*   The query uses dynamic columns (controlled by parameters) to toggle the display of detailed date rows and organization mappings, ensuring the output is not cluttered when high-level summaries are needed.

### Parameters & Filtering
The report includes several parameters to tailor the output to specific needs:
*   **Calendar:** Allows filtering for a specific calendar code (e.g., 'MFG-01').
*   **Show Organizations:** A 'Yes/No' toggle. When set to 'Yes', the report lists every organization assigned to the calendar.
*   **Organization Code:** Filters the results to show calendars associated with a specific inventory organization.
*   **Show Dates:** A 'Yes/No' toggle. When set to 'Yes', the report expands to show every individual date record (working/non-working) for the selected range.
*   **Future only:** Restricts the output to dates from the current day forward, useful for planning future capacity.

### Performance & Optimization
*   **Efficient Joins:** The report uses standard Oracle joins on indexed columns (`CALENDAR_CODE`, `ORGANIZATION_ID`), ensuring fast execution even with large datasets.
*   **Dynamic Granularity:** By making the "Dates" and "Organizations" joins optional via parameters, the report avoids retrieving millions of rows of date details when only a header-level list is required.
*   **Direct Extraction:** Data is pulled directly from the base tables, bypassing the overhead of XML parsing often found in standard Oracle reports.

### FAQ
**Q: Why don't I see any dates in the output?**
A: Ensure the "Show Dates" parameter is set to 'Yes'. By default, the report may only show the calendar header information to keep the output concise.

**Q: How can I see which organizations are using a specific calendar?**
A: Set the "Show Organizations" parameter to 'Yes'. This will add columns for Organization Code and Name to the output.

**Q: Can I use this report to find expired calendars?**
A: Yes, the report includes `Calendar End Date`. You can filter the Excel output to find calendars that have already ended or are expiring soon.


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
