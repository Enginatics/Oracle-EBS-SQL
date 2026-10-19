---
layout: default
last_modified_at: 2026-10-19
title: 'PA Event Upload | Oracle EBS SQL Report'
description: 'PA Event Upload =================== This upload can be used to create new Project Billing and Revenue Events against the Projects belonging to the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Event, mtl_parameters, mtl_system_items_vl, pa_proj_elements'
permalink: /PA%20Event%20Upload/
report_name: 'PA Event Upload'
report_web_name: pa-event-upload
---

# PA Event Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-event-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload).

## Overview
PA Event Upload
===================
This upload can be used to create new Project Billing and Revenue Events against the Projects belonging to the Operating Units accessible to the current responsibility.

If the Operating Unit parameter is specified, then the upload will be restricted to Projects within the specified Operating Unit only.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Product Source, Operating Unit, Default Event Date, Validate DFF Attributes

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [pa_proj_elements](https://www.enginatics.com/library/?pg=1&find=pa_proj_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [pa_events](https://www.enginatics.com/library/?pg=1&find=pa_events&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [pa_projects](https://www.enginatics.com/library/?pg=1&find=pa_projects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [pa_all_organizations](https://www.enginatics.com/library/?pg=1&find=pa_all_organizations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [pa_event_types](https://www.enginatics.com/library/?pg=1&find=pa_event_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [pa_agreements](https://www.enginatics.com/library/?pg=1&find=pa_agreements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [pa_customers_v](https://www.enginatics.com/library/?pg=1&find=pa_customers_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [pa_conversion_types_v](https://www.enginatics.com/library/?pg=1&find=pa_conversion_types_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Event%20Upload/PA%20Event%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/pa-event-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload) |
| Blitz Report™ XML Import | [PA_Event_Upload.xml](https://www.enginatics.com/xml/pa-event-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload) |
| SQL Source | [PA Event Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Event%20Upload/PA%20Event%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-event-upload/](https://www.enginatics.com/reports/pa-event-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload) |

## Case Study & Technical Analysis: PA Event Upload

### Executive Summary
This upload creates new Project Billing and Revenue Events against the projects of the operating units that the current responsibility can access. Project accountants and billing teams use it to load milestone, billing and revenue events in bulk, so that the events carry the billing amounts, currencies, exchange rates, holds and references that drive project billing and revenue recognition. The download shows existing events, and the file is worked in Excel through Blitz Report™.

### Business Challenge
*   **Event volume:** Contract billing and revenue events are generated per milestone or per deliverable, and keying them one by one is slow for large projects.
*   **Multi-currency billing:** An event carries amounts in the transaction, project and functional currencies, each with its own rate type and rate date, which must be entered consistently.
*   **Holds and references:** Events can be held from billing or revenue, and they carry references that link them to the source system.
*   **Scope control:** A user must only load events against projects in the operating units they are responsible for.

### The Solution
*   Downloads existing events for the selected product source, showing the project, task, agreement, customer, event type, dates, amounts and rates of each event.
*   Creates new events against projects in the accessible operating units, with the event type, completion date, billing and revenue amounts and the currency and rate details.
*   Carries the billing and revenue holds, the bill group, the event references and the descriptive flexfield values of each event.
*   Restricts the projects offered to the operating units chosen in the parameters, and to the units the responsibility can access.

### Technical Architecture (High Level)
#### Primary Tables
*   `PA_EVENTS`: the billing and revenue events, with the event number, type, completion date, amounts, rates, holds, quantities and references.
*   `PA_PROJECTS`, `PA_TASKS` and `PA_PROJ_ELEMENTS`: the project, task, and the deliverable and action names of each event.
*   `PA_EVENT_TYPES`: the event type and its classification.
*   `PA_AGREEMENTS` and `PA_CUSTOMERS_V`: the agreement and the customer on the event's project.
*   `PA_CONVERSION_TYPES_V`: the rate types for the functional, project and funding rates.
*   `PA_ALL_ORGANIZATIONS`, `HR_ALL_ORGANIZATION_UNITS_VL` and `MTL_PARAMETERS`: the operating unit and the expenditure organization of the event.
*   `MTL_SYSTEM_ITEMS_VL`: the inventory item and its organization, when the event is for an inventory item.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the operating units accessible to the user.

#### Logical Relationships
1.  Each event is joined to its project, and the project's operating unit is checked against the accessible operating units.
2.  The event's task is outer-joined, because an event can be recorded at project level.
3.  The expenditure organization of the event is matched to an expenditure organization in the operating unit, and its name is taken from the organization view.
4.  The agreement and customer are outer-joined, so events without an agreement are still listed.
5.  The projected, project and funding rate types are outer-joined to the conversion types to give readable names.
6.  Deliverable and action names are read from the project element table with the object type of each.

### Parameters & Filtering
*   **Product Source:** selects the source system of the events, such as the Oracle Projects product code of the events.
*   **Operating Unit:** restricts the projects to one operating unit, and otherwise all accessible units are included.
*   **Default Event Date:** the date parameter offered to the upload for new events.
*   **Validate DFF Attributes:** controls whether the event descriptive flexfield values are validated on upload.

### Performance & Optimization
*   The accessible operating units are read once from `MO_GLOB_ORG_ACCESS_TMP`, so each event is tested against a short list.
*   The reference lookups for event types, agreements, customers and conversion types are outer joins to views, one match per event.
*   The deliverable and action names are scalar subqueries on the project element table, evaluated once per event.
*   Filtering by product source and operating unit narrows the event set before the reference lookups are applied.

### FAQ
**Q: Which projects can receive events in this upload?**
A: Only projects in the operating units that the current responsibility can access, and, when the Operating Unit parameter is entered, only projects in that unit.

**Q: Can an event be created without a task?**
A: Yes, the task join is an outer join, so an event can be recorded against the project alone.

**Q: Which currencies and rates does an event carry?**
A: An event carries the transaction currency and bill and revenue amounts, and the functional, project and funding currency rates with their rate types and rate dates.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-event-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
