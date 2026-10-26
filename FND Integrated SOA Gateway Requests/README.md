---
layout: default
last_modified_at: 2026-10-26
title: 'FND Integrated SOA Gateway Requests | Oracle EBS SQL Report'
description: 'Integrated SOA Gateway (ISG) web service requests as logged for the SOA Monitor, one row per request, with execution time, status, HTTP and fault details…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Integrated, SOA, Gateway, fnd_soa_request, fnd_irep_all_interfaces, fnd_responsibility_vl'
permalink: /FND%20Integrated%20SOA%20Gateway%20Requests/
report_name: 'FND Integrated SOA Gateway Requests'
report_web_name: fnd-integrated-soa-gateway-requests
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Integrated SOA Gateway Requests – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-integrated-soa-gateway-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Integrated SOA Gateway (ISG) web service requests as logged for the SOA Monitor, one row per request, with execution time, status, HTTP and fault details.

Execution seconds is the time between the gateway receiving the request and sending the response, rounded to whole seconds. Time a request spends queued before it reaches the gateway (client, load balancer, web tier) is not included: compare the client's send time with Request Received to measure it.

Show Requests in Process counts, for each request, the requests in process when it was received, itself included, to show how many calls the gateway handled in parallel. Use the template Throughput per Minute to see request volume and average execution time per minute.

Show Payload adds the request and response bodies, which ISG stores only for services with auditing enabled.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Received within x Days, Received From, Received To, Interface, Operation, Status, User Name, Execution Seconds From, Show Requests in Process, Show Payload

## Oracle EBS Tables Used
[fnd_soa_request](https://www.enginatics.com/library/?pg=1&find=fnd_soa_request&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests), [fnd_irep_all_interfaces](https://www.enginatics.com/library/?pg=1&find=fnd_irep_all_interfaces&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests)

## Related Reports
[INV Kanban Cards](/INV%20Kanban%20Cards/ "INV Kanban Cards Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [WSH Shipping/Delivery Transactions](/WSH%20Shipping-Delivery%20Transactions/ "WSH Shipping/Delivery Transactions Oracle EBS SQL Report"), [INV Lot Upload](/INV%20Lot%20Upload/ "INV Lot Upload Oracle EBS SQL Report"), [CST Item Standard Cost Upload](/CST%20Item%20Standard%20Cost%20Upload/ "CST Item Standard Cost Upload Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Integrated%20SOA%20Gateway%20Requests/FND%20Integrated%20SOA%20Gateway%20Requests.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Integrated SOA Gateway Requests 22-Oct-2026 184245.xlsx](https://www.enginatics.com/example/fnd-integrated-soa-gateway-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests) |
| Blitz Report™ XML Import | [FND_Integrated_SOA_Gateway_Requests.xml](https://www.enginatics.com/xml/fnd-integrated-soa-gateway-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests) |
| SQL Source | [FND Integrated SOA Gateway Requests.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Integrated%20SOA%20Gateway%20Requests/FND%20Integrated%20SOA%20Gateway%20Requests.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-integrated-soa-gateway-requests/](https://www.enginatics.com/reports/fnd-integrated-soa-gateway-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-integrated-soa-gateway-requests)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
