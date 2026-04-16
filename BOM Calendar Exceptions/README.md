---
layout: default
title: 'BOM Calendar Exceptions | Oracle EBS SQL Report'
description: 'Master data report showing bill of material exceptions dates, exception types and organization code.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, BOM, Calendar, Exceptions, hr_all_organization_units_vl, mtl_parameters, bom_calendar_exceptions'
permalink: /BOM%20Calendar%20Exceptions/
---

# BOM Calendar Exceptions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/bom-calendar-exceptions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report showing bill of material exceptions dates, exception types and organization code.

## Report Parameters
Organization Code, Calendar, Future only

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [bom_calendar_exceptions](https://www.enginatics.com/library/?pg=1&find=bom_calendar_exceptions), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CRP Resource Plan](/CRP%20Resource%20Plan/ "CRP Resource Plan Oracle EBS SQL Report"), [INV Organization Parameters](/INV%20Organization%20Parameters/ "INV Organization Parameters Oracle EBS SQL Report"), [PO Approved Supplier List Upload](/PO%20Approved%20Supplier%20List%20Upload/ "PO Approved Supplier List Upload Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [BOM Calendar Exceptions 20-Jan-2019 120149.xlsx](https://www.enginatics.com/example/bom-calendar-exceptions/) |
| Blitz Report™ XML Import | [BOM_Calendar_Exceptions.xml](https://www.enginatics.com/xml/bom-calendar-exceptions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/bom-calendar-exceptions/](https://www.enginatics.com/reports/bom-calendar-exceptions/) |

## BOM Calendar Exceptions Report

### Executive Summary
The BOM Calendar Exceptions report provides a detailed listing of all exception dates defined in the Bill of Materials (BOM) calendar. This report is a critical tool for production planners and supply chain managers, offering a clear view of all non-working days, such as holidays and weekends, that are defined in the manufacturing calendar. By providing a comprehensive view of calendar exceptions, the report helps to ensure that production schedules are accurate and that material requirements are planned correctly.

### Business Challenge
The manufacturing calendar is a critical component of the production planning process. However, managing calendar exceptions can be a complex and challenging task. Without a clear and comprehensive report, organizations may face:
- **Inaccurate Production Schedules:** If calendar exceptions are not properly accounted for, production schedules may be inaccurate, leading to delays and disruptions in the manufacturing process.
- **Incorrect Material Planning:** Inaccurate production schedules can lead to incorrect material planning, which can result in material shortages or excess inventory.
- **Lack of Visibility:** Difficulty in getting a clear and up-to-date view of all calendar exceptions, which can make it difficult to plan for and manage production disruptions.
- **Manual Processes:** The process of manually reviewing and managing calendar exceptions can be time-consuming and prone to errors.

### The Solution
The BOM Calendar Exceptions report provides a clear and detailed view of all calendar exceptions, helping organizations to:
- **Improve Production Planning:** By providing a clear and accurate view of all non-working days, the report helps to ensure that production schedules are accurate and that material requirements are planned correctly.
- **Reduce Production Disruptions:** By providing a proactive view of upcoming calendar exceptions, the report helps to minimize the impact of holidays and other non-working days on the production schedule.
- **Enhance Visibility:** The report provides a centralized and easy-to-read view of all calendar exceptions, making it easier to plan for and manage production disruptions.
- **Increase Efficiency:** The report automates the process of reviewing and managing calendar exceptions, which can save a significant amount of time and effort.

### Technical Architecture (High Level)
The report is based on a query of the `bom_calendar_exceptions` table. This table stores all of the exception dates that are defined in the BOM calendar. The report also uses the `hr_all_organization_units_vl` and `mtl_parameters` tables to retrieve information about the organization and the calendar that are associated with the exceptions.

### Parameters & Filtering
The report includes three parameters that allow you to filter the output by organization, calendar, and date.

- **Organization Code:** This parameter allows you to filter the report by a specific organization.
- **Calendar:** This parameter allows you to select a specific calendar to view.
- **Future only:** This parameter allows you to filter the report to show only future-dated exceptions.

### Performance & Optimization
The BOM Calendar Exceptions report is designed to be efficient and fast. It uses direct table access to retrieve the data, which is much faster than relying on intermediate views or APIs. The report is also designed to minimize the use of complex joins and subqueries, which helps to ensure that it runs quickly and efficiently.

### FAQ
**Q: What is a calendar exception?**
A: A calendar exception is a non-working day that is defined in the manufacturing calendar. Examples of calendar exceptions include holidays, weekends, and plant shutdowns.

**Q: Why is it important to have a clear understanding of the calendar exceptions?**
A: A clear understanding of the calendar exceptions is essential for ensuring the accuracy of your production schedules and material plans. It can also help you to minimize the impact of production disruptions and improve the overall efficiency of your manufacturing operations.

**Q: Can I use this report to see the calendar exceptions for a specific organization?**
A: Yes, you can use the "Organization Code" parameter to filter the report and view the calendar exceptions for a specific organization.

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
