---
layout: default
last_modified_at: 2026-10-16
title: 'OPM Routing Upload | Oracle EBS SQL Report'
description: 'OPM Routing Upload ================== Create or update Oracle Process Manufacturing (OPM / GMD) Routings via the public API GMDROUTINGSPUB /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, OPM, Routing, gmd_status_vl, fnd_user, gmd_routings_vl'
permalink: /OPM%20Routing%20Upload/
report_name: 'OPM Routing Upload'
report_web_name: opm-routing-upload
---

# OPM Routing Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-routing-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload).

## Overview
OPM Routing Upload
==================
Create or update Oracle Process Manufacturing (OPM / GMD) Routings via the public API GMD_ROUTINGS_PUB / GMD_ROUTING_STEPS_PUB.

Row model
=========
One spreadsheet row per routing STEP. The header columns (Organization Code, Routing, Routing Version, Description, Class, UOM, dates, owner, header attributes) repeat on every step of the same routing. Each step carries its Step No, Operation (No + Version), Step Quantity, Release Type, and step attributes. Rows of the same routing (Organization Code + Routing + Routing Version) must be contiguous. Every routing must have at least one step.

Step dependencies (optional)
============================
To make a step depend on a predecessor step, fill Depends On Step No (and optionally Standard / Minimum / Maximum Delay, Transfer Percent, Rework Code, Chargeable) on that step's row. For a step with more than one predecessor, add extra rows that repeat the Step No, leave Operation blank, and give a different Depends On Step No. Dependency Type is always Finish-to-Start.

Operations must already exist
=============================
Operations are referenced, not created - the Operation (No + Version) must already exist in the routing's organization, effective for the routing's dates.

Upload modes
============
Create - empty template for new routings.
Create, Update - downloads existing routings in the chosen organization for review/edit and allows adding new ones.

Update limitations (public API)
===============================
On update, the OPM public API only allows changing a routing's Status, Routing Class, Routing UOM, Fixed Process Loss UOM, Owner and Organization at the header level; Description, Quantity, Process Loss, effective dates and the step-dependency flags are set at create time only. Steps can be added and their quantity / release type / yield updated.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Routing

## Oracle EBS Tables Used
[gmd_status_vl](https://www.enginatics.com/library/?pg=1&find=gmd_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload), [gmd_routings_vl](https://www.enginatics.com/library/?pg=1&find=gmd_routings_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload), [fm_rout_dtl](https://www.enginatics.com/library/?pg=1&find=fm_rout_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload), [gmd_operations_vl](https://www.enginatics.com/library/?pg=1&find=gmd_operations_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload)

## Related Reports
[OPM Recipe Upload](/OPM%20Recipe%20Upload/ "OPM Recipe Upload Oracle EBS SQL Report"), [OPM Recipe Details](/OPM%20Recipe%20Details/ "OPM Recipe Details Oracle EBS SQL Report"), [OPM Formula Upload](/OPM%20Formula%20Upload/ "OPM Formula Upload Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Routing%20Upload/OPM%20Routing%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/opm-routing-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload) |
| Blitz Report™ XML Import | [OPM_Routing_Upload.xml](https://www.enginatics.com/xml/opm-routing-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload) |
| SQL Source | [OPM Routing Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Routing%20Upload/OPM%20Routing%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/opm-routing-upload/](https://www.enginatics.com/reports/opm-routing-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload) |

## Case Study & Technical Analysis: OPM Routing Upload

### Executive Summary
This upload creates and updates Oracle Process Manufacturing (OPM) routings, the step sequences that describe how a product is made, through the public routing and routing step APIs. Process engineers and manufacturing master-data teams use it to build many routings in one spreadsheet, with each step, its operation, quantities, release types and step dependencies, rather than entering them routing by routing. It is an R12 upload that runs in Excel through Blitz Report™.

### Business Challenge
*   **Routing volume:** A process manufacturer can maintain many routings, each with several steps, and building them through the forms is slow and repetitive.
*   **Consistent step structure:** Each step must reference an operation that already exists and is effective for the routing's dates, which is easy to get wrong when keyed by hand.
*   **Step dependencies:** Steps that must wait for predecessor steps need the dependency and its delay and transfer settings recorded correctly.
*   **Controlled change:** Once a routing is in use, only some of its header fields can be changed through the public API, and the team must know which.

### The Solution
*   Writes one spreadsheet row for each routing step, with the routing header columns repeated on every step of the same routing.
*   Creates the routing header and its steps through the routing and routing step public APIs, and updates the header fields and steps that the API permits.
*   Builds step dependencies from extra rows that repeat the step number and give a different predecessor, with the delay, transfer percentage, rework code and chargeable settings.
*   Downloads existing routings of an organization for review and editing when the Create, Update mode is used.

### Technical Architecture (High Level)
#### Primary Tables
*   `GMD_ROUTINGS_VL`: the routing headers, with the routing number, version, description, class, unit of measure, quantity, process loss, effective dates, status, owner and the header flexfield.
*   `FM_ROUT_DTL`: the routing steps, with the step number, operation, step quantity, release type, minimum transfer quantity, operation yield and the step flexfield.
*   `GMD_OPERATIONS_VL`: the operations that each step references by operation number and version.
*   `GMD_STATUS_VL`: the routing status descriptions.
*   `FND_USER`: the owner of the routing.
*   `MTL_PARAMETERS`: the organization code of the owning organization.
*   `ORG_ACCESS_VIEW`: the organizations the current responsibility can access.

#### Logical Relationships
1.  Each routing header in `GMD_ROUTINGS_VL` is joined to its steps in `FM_ROUT_DTL` on the routing identifier.
2.  Each step is joined to its operation in `GMD_OPERATIONS_VL` on the operation identifier, so the operation number and version are read from the operation.
3.  The owning organization is joined to `MTL_PARAMETERS` for the organization code.
4.  Only routings that are not marked for deletion and that belong to an organization the responsibility can access are kept.
5.  Header and step flexfield values are displayed under the routing header and routing step flexfield contexts.
6.  Each row is numbered by routing, version and step number, and the rows of one routing must be contiguous in the file.

### Parameters & Filtering
*   **Upload Mode:** selects Create, which gives an empty template, or Create, Update, which downloads existing routings for the chosen organization.
*   **Organization Code:** the owning organization of the routings to download or create.
*   **Routing:** limits the download to one routing number.

### Performance & Optimization
*   The routing-to-step join is an equality join on routing identifier, so the cost follows the number of steps in the selected routings.
*   The organization access restriction uses `ORG_ACCESS_VIEW` once for the session, which limits the routings before the step join.
*   The flexfield values for headers and steps are displayed per row, so routings with many populated flexfield segments take longer to download.
*   Rows of the same routing must be contiguous in the file, so the upload processes each routing's header and steps as one group.

### FAQ
**Q: Which routing fields can be changed on update?**
A: Through the public API, only the Status, Routing Class, Routing UOM, Fixed Process Loss UOM, Owner and Organization can be changed at header level, and steps can be added with their quantity, release type and yield updated.

**Q: How is a step made to depend on two predecessor steps?**
A: Repeat the step number on an extra row, leave Operation blank and enter a different Depends On Step No; each row adds one predecessor, and the dependency type is always Finish-to-Start.

**Q: Can the upload create an operation that does not exist?**
A: No, operations are referenced rather than created, so each Operation number and version must already exist in the routing's organization and be effective for the routing's dates.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-routing-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
