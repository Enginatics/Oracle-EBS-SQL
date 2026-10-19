---
layout: default
last_modified_at: 2026-10-19
title: 'CS Service Requests | Oracle EBS SQL Report'
description: 'Service requests with customer, product, owner, status and response and resolution times, one row per request. Response and resolution hours are measured…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Service, Enginatics, Requests, hr_all_organization_units_vl, cs_incident_severities_vl, cs_incident_urgencies_vl'
permalink: /CS%20Service%20Requests/
report_name: 'CS Service Requests'
report_web_name: cs-service-requests
module: 'Service'
module_url: /modules/service/
---

# CS Service Requests – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cs-service-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests).
**Oracle EBS module:** [Service](/modules/service/ "Oracle EBS Service reports") · [all Service reports](/modules/service/)  

## Overview
Service requests with customer, product, owner, status and response and resolution times, one row per request.

Response and resolution hours are measured from the reported date to the responded and resolved dates. A request is overdue when it was responded to or resolved after its respond by or resolve by date. Without a responded or resolved date, its close date is used, or the current date while it is open.

Detail Level adds the request's tasks or notes, one row per task or note; private notes are listed only for the user who entered them.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Reported Date From, Reported Date To, Request Number, Request Type, Status, Open Only, Severity, Customer Name, Owner Group, Owner, Item, Serial Number, Detail Level

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [cs_incident_severities_vl](https://www.enginatics.com/library/?pg=1&find=cs_incident_severities_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [cs_incident_urgencies_vl](https://www.enginatics.com/library/?pg=1&find=cs_incident_urgencies_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [hz_relationships](https://www.enginatics.com/library/?pg=1&find=hz_relationships&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [jtf_rs_groups_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_groups_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [cs_incidents_b_sec](https://www.enginatics.com/library/?pg=1&find=cs_incidents_b_sec&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [cs_incidents_all_tl](https://www.enginatics.com/library/?pg=1&find=cs_incidents_all_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [cs_incident_types_vl](https://www.enginatics.com/library/?pg=1&find=cs_incident_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [cs_incident_statuses_vl](https://www.enginatics.com/library/?pg=1&find=cs_incident_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests), [cs_hz_sr_contact_points](https://www.enginatics.com/library/?pg=1&find=cs_hz_sr_contact_points&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests)

## Related Reports
[ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [ONT Orders](/ONT%20Orders/ "ONT Orders Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CS%20Service%20Requests/CS%20Service%20Requests.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CS Service Requests 15-Oct-2026 022656.xlsx](https://www.enginatics.com/example/cs-service-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests) |
| Blitz Report™ XML Import | [CS_Service_Requests.xml](https://www.enginatics.com/xml/cs-service-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests) |
| SQL Source | [CS Service Requests.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CS%20Service%20Requests/CS%20Service%20Requests.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cs-service-requests/](https://www.enginatics.com/reports/cs-service-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests) |

## Case Study & Technical Analysis: CS Service Requests

### Executive Summary
This report lists Oracle Service Requests with their customer, product, owner, status, severity and response and resolution timings, one row per request. It supports service managers and customer support leads who track whether requests are answered and resolved within the agreed obligation dates. Each request is flagged as overdue when its response or resolution fell after the respond-by or resolve-by date. A detail level adds the tasks or notes of each request. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Service level compliance:** Support organizations must show how many requests were answered and resolved by their obligation dates.
*   **Aging of open work:** Open requests need a clear count of days open and a view of which owner or group holds them.
*   **Product and customer context:** Escalations need the customer, the installed product, the serial number and the contract number on one line.
*   **Investigation of delays:** Managers need the tasks or notes of a late request to explain the delay.

### The Solution
*   **Timing measures:** Response and resolution hours are calculated from the reported date to the responded and resolved dates.
*   **Overdue flags:** Response overdue and resolution overdue are set when the responded or resolved date, or the close date, or the current date for an open request, is later than the obligation date.
*   **Days open:** Days open is measured from the reported date to the close date, or to the current date while the request is open.
*   **Ownership and contacts:** The owner, owner group, channel and primary contact are returned with each request.
*   **Detail level:** The tasks or notes of each request are added as separate rows, and private notes are shown only to the user who entered them.

### Technical Architecture (High Level)
#### Primary Tables
*   `CS_INCIDENTS_B_SEC`: the service request header, with incident number, dates, obligation dates, owner and product.
*   `CS_INCIDENTS_ALL_TL`: the request summary and resolution summary, in the session language.
*   `CS_INCIDENT_TYPES_VL`, `CS_INCIDENT_STATUSES_VL` and `CS_INCIDENT_SEVERITIES_VL`: the request type, status and severity names.
*   `HZ_PARTIES` and `HZ_CUST_ACCOUNTS`: the customer party and account number.
*   `CS_HZ_SR_CONTACT_POINTS`: the primary contact of each request.
*   `CSI_ITEM_INSTANCES`: the installed product instance and its instance number.
*   `MTL_SYSTEM_ITEMS_VL`: the item and its description.
*   `JTF_RS_RESOURCE_EXTNS_VL` and `JTF_RS_GROUPS_VL`: the owner resource and owner group.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit.

#### Logical Relationships
1. `CS_INCIDENTS_B_SEC` joins to `CS_INCIDENTS_ALL_TL` on incident id, restricted to the session language.
2. `CS_INCIDENTS_B_SEC` joins to the request type and status views on their identifiers, and to `HZ_PARTIES` on the customer id as an outer join.
3. The primary contact is taken from the contact point rows flagged as primary, joined on incident id, and resolved to an employee, a relationship person or a party name.
4. The item is joined on inventory item id and inventory organization id as an outer join.
5. The owner and owner group are looked up on the owner id and owner group id from the resource views.

### Parameters & Filtering
*   **Operating Unit:** restricts the requests to one operating unit.
*   **Reported Date From / Reported Date To:** bound the requests by the date they were reported.
*   **Request Number, Request Type, Status, Severity:** select one request or narrow the list by classification.
*   **Open Only:** limits the report to requests that are not yet closed.
*   **Customer Name, Owner Group, Owner, Item and Serial Number:** narrow the requests to a customer, team, person, product or unit.
*   **Detail Level:** adds the tasks or notes of each request, one row per task or note.

### Performance & Optimization
*   The date window on reported date is applied first, so the main request scan is limited to the chosen period.
*   Most descriptive values are scalar subqueries keyed on a single id, which keeps the main query a single pass over the request header.
*   The language filter on the translated summary table prevents duplicate rows from other installed languages.

### FAQ
**Q: How is an overdue service request identified?**
A: A request is overdue when its responded or resolved date, or the close date, is later than its respond-by or resolve-by date. An open request uses the current date.

**Q: How do I see the tasks and notes of a service request?**
A: Set Detail Level to include the detail. Each task or note appears on its own row, and private notes are visible only to the user who entered them.

**Q: Why are response hours blank for some requests?**
A: Response hours need a responded date. Requests without one show no response hours.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cs-service-requests)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
