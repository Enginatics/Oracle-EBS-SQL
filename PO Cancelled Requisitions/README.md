---
layout: default
title: 'PO Cancelled Requisitions | Oracle EBS SQL Report'
description: 'Application: Purchasing Source: Cancelled Requisition Report (XML) Short Name: POXRQCRQXML DB package: POPOXRQCRQXMLPPKG'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Cancelled, Requisitions, po_requisition_headers_all, fnd_user, per_all_people_f'
permalink: /PO%20Cancelled%20Requisitions/
---

# PO Cancelled Requisitions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-cancelled-requisitions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Purchasing
Source: Cancelled Requisition Report (XML)
Short Name: POXRQCRQ_XML
DB package: PO_POXRQCRQ_XMLP_PKG

## Report Parameters
Show Requisition Lines, Operating Unit, Preparer From, Preparer To, Requestor From, Requestor To, Cancelled Date From, Cancelled Date To, Creation Date From, Creation Date To

## Oracle EBS Tables Used
[po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [po_action_history](https://www.enginatics.com/library/?pg=1&find=po_action_history), [po_document_types_all_tl](https://www.enginatics.com/library/?pg=1&find=po_document_types_all_tl), [po_document_types_all_b](https://www.enginatics.com/library/?pg=1&find=po_document_types_all_b), [po_system_parameters_all](https://www.enginatics.com/library/?pg=1&find=po_system_parameters_all), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [financials_system_params_all](https://www.enginatics.com/library/?pg=1&find=financials_system_params_all), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [PO Cancelled Purchase Orders](/PO%20Cancelled%20Purchase%20Orders/ "PO Cancelled Purchase Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PO Cancelled Requisitions 03-Mar-2023 001840.xlsx](https://www.enginatics.com/example/po-cancelled-requisitions/) |
| Blitz Report™ XML Import | [PO_Cancelled_Requisitions.xml](https://www.enginatics.com/xml/po-cancelled-requisitions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/po-cancelled-requisitions/](https://www.enginatics.com/reports/po-cancelled-requisitions/) |

## Case Study & Technical Analysis: PO Cancelled Requisitions Report

### Executive Summary

The PO Cancelled Requisitions report is a crucial procurement analysis tool within Oracle Purchasing, providing a detailed view of all purchase requisitions (PRs) that have been cancelled. It offers insights into who initiated the cancellation, when it occurred, and the impact on purchasing plans. This report is indispensable for procurement managers, departmental requestors, and financial analysts to understand the reasons for requisition cancellations, identify trends, and take corrective actions to improve the efficiency and accuracy of the procure-to-pay process.

### Business Challenge

Cancelled purchase requisitions represent wasted effort in the procure-to-pay cycle and can indicate underlying issues in planning or demand. Organizations often struggle with:

-   **Lack of Visibility into Cancellations:** Without a dedicated report, it's difficult to track which requisitions are being cancelled, by whom, and for what reasons, making it hard to identify recurring problems.
-   **Impact on Planning and Budgeting:** Cancelled PRs can disrupt planning efforts if the demand is still valid, or lead to inaccurate budget utilization tracking if the cancellation is not properly analyzed.
-   **Process Inefficiencies:** A high volume of cancellations might indicate issues upstream (e.g., incorrect demand forecasts, wrong item selection by requestors) or in the approval process, leading to unnecessary administrative work.
-   **Compliance and Audit Trail:** For audit purposes, it's important to have a clear record of all cancelled requisitions, including who initiated the cancellation and the date it was performed.

### The Solution

This report offers a streamlined and analytical solution for monitoring and understanding cancelled purchase requisitions, turning raw data into actionable insights for procurement optimization.

-   **Comprehensive Cancellation Details:** It provides a detailed list of all cancelled requisitions, including header and line-level information, the preparer, requestor, and key dates such as creation and cancellation dates.
-   **Root Cause Analysis:** By consolidating cancellation data, the report helps procurement teams investigate the underlying reasons for cancellations (though the reason code itself might need to be explicitly configured and captured in Oracle's `po_action_history` table for full benefit).
-   **Improved Procurement Planning:** Understanding cancellation trends allows for better demand forecasting and procurement planning, reducing waste and improving efficiency.
-   **Enhanced Accountability:** Parameters for `Preparer` and `Requestor` enable managers to identify patterns in cancellations related to specific individuals or departments, fostering accountability and targeted training.

### Technical Architecture (High Level)

The report queries core Oracle Purchasing tables to retrieve details about cancelled requisitions. Originally a BI Publisher report, its Blitz Report implementation offers improved performance.

-   **Primary Tables Involved:**
    -   `po_requisition_headers_all` (for requisition header information).
    -   `po_requisition_lines_all` (for detailed requisition line items).
    -   `po_action_history` (a crucial table for tracking workflow actions, including cancellations, on purchasing documents).
    -   `fnd_user` and `per_all_people_f` (to get names of preparers and requestors).
    -   `mtl_system_items_vl` and `mtl_categories_kfv` (for item and category details).
-   **Logical Relationships:** The report links `po_requisition_headers_all` to `po_requisition_lines_all` to retrieve all requisition details. It then queries `po_action_history` to identify requisitions that have a cancellation action recorded against them, and joins to HR tables to get the user-friendly names of the preparers and requestors.

### Parameters & Filtering

The report offers flexible parameters for targeted analysis of cancelled requisitions:

-   **Show Requisition Lines:** A crucial parameter that allows users to choose between a header-level summary or a detailed line-item view of cancelled requisitions.
-   **Organizational Context:** `Operating Unit` filters the report to a specific business unit.
-   **Personnel Filters:** `Preparer From/To` and `Requestor From/To` allow for filtering by specific individuals or ranges of employees who created or requested the requisitions.
-   **Date Ranges:** `Cancelled Date From/To` and `Creation Date From/To` are essential for analyzing cancellation trends over specific periods.

### Performance & Optimization

As a transactional report, it is optimized by its ability to filter on key dates and leverage underlying table structures.

-   **Date-Driven Filtering:** The `Cancelled Date` and `Creation Date` parameters are critical for performance, allowing the database to efficiently narrow down the large volume of requisition data to the relevant timeframe using existing indexes.
-   **Leveraging Action History:** By directly querying `po_action_history`, the report efficiently identifies cancelled documents without requiring complex status derivations.
-   **Efficient Joins:** Queries leverage standard Oracle indexes on `requisition_header_id`, `requisition_line_id`, and `agent_id` for efficient joins across purchasing and HR tables.

### FAQ

**1. What is the difference between cancelling a requisition line and cancelling a requisition header?**
   Cancelling a requisition *line* means that only that specific item or service request is no longer needed. The rest of the requisition (other lines) can still proceed. Cancelling a requisition *header* means the entire requisition, including all its lines, is no longer valid or required.

**2. Does this report show the financial impact of cancelled requisitions?**
   While the report provides the original amounts of the cancelled lines, it primarily focuses on the operational aspect of cancellation. To understand the precise financial impact (e.g., impact on budget or commitment tracking), further analysis would be needed, potentially involving custom calculations on the exported data.

**3. Can I use this report to see if a cancelled requisition was ever converted into a Purchase Order?**
   This report specifically focuses on *cancelled requisitions*. If a requisition was converted into a PO *before* being cancelled, that PO would appear in a different set of reports (e.g., `PO Cancelled Purchase Orders`). The act of cancellation typically prevents further processing of the requisition itself.


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
