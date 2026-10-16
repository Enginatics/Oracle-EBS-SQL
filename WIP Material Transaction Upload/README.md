---
layout: default
last_modified_at: 2026-10-16
title: 'WIP Material Transaction Upload | Oracle EBS SQL Report'
description: 'Issues components to, and returns components from, WIP work orders. The download returns one row per component requirement of the selected work orders…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, WIP, Material, Transaction, mtl_units_of_measure_vl, org_organization_definitions, wip_entities'
permalink: /WIP%20Material%20Transaction%20Upload/
report_name: 'WIP Material Transaction Upload'
report_web_name: wip-material-transaction-upload
---

# WIP Material Transaction Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wip-material-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload).

## Overview
Issues components to, and returns components from, WIP work orders.

The download returns one row per component requirement of the selected work orders, with the operation, department, supply subinventory and locator already filled in, and the required, issued and still open quantities shown. Enter a Transaction Type and a Quantity on the rows you want to transact and leave the rest blank.

Quantity is always entered as a positive number; the Transaction Type decides the direction.

Discrete jobs, lot based jobs and maintenance work orders are supported. Repetitive schedules are not.

Rows are staged in the inventory transaction interface and processed by the inventory transaction manager, so the resulting transactions are identical to those the WIP Material Transactions form creates and relieve the work order requirement in the same way.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Job, Job Status, Assembly, Component, Department, Date Required From, Date Required To, Open Requirements Only

## Oracle EBS Tables Used
[mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload)

## Related Reports
[WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [CRP Resource Plan](/CRP%20Resource%20Plan/ "CRP Resource Plan Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [WIP Job Upload](/WIP%20Job%20Upload/ "WIP Job Upload Oracle EBS SQL Report"), [WIP Value Summary](/WIP%20Value%20Summary/ "WIP Value Summary Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Material%20Transaction%20Upload/WIP%20Material%20Transaction%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/wip-material-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload) |
| Blitz Report™ XML Import | [WIP_Material_Transaction_Upload.xml](https://www.enginatics.com/xml/wip-material-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload) |
| SQL Source | [WIP Material Transaction Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Material%20Transaction%20Upload/WIP%20Material%20Transaction%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wip-material-transaction-upload/](https://www.enginatics.com/reports/wip-material-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload) |

## Case Study & Technical Analysis: WIP Material Transaction Upload

### Executive Summary
This upload issues components to, and returns components from, Oracle Work in Process (WIP) jobs. The download returns one row for each component requirement of the selected jobs, with the operation, department, supply subinventory and locator filled in and the required, issued and open quantities shown. Shop floor supervisors and material controllers use it to issue many components to jobs at once, and to return unused material, in one spreadsheet. It is an R12 upload that runs in Excel through Blitz Report™.

### Business Challenge
*   **Batch material issue:** A job can need many components across several operations, and issuing them line by line in the WIP Material Transactions form is slow.
*   **Open requirements:** Planners need to see, for each component, how much of the requirement has already been issued and how much is still open.
*   **Correct stock source:** Each component must come from its supply subinventory and locator, which are often fixed for the requirement.
*   **Returns:** Material issued in excess must be returned to inventory against the same job, with the same accounting as the original issue.

### The Solution
*   Lists the component requirements of the selected discrete, lot-based and maintenance jobs, with the operation sequence, department, supply subinventory and locator already filled in.
*   Shows the date required, required quantity, quantity issued and open quantity of each requirement, so that the quantity left to issue is visible.
*   Lets the user enter a Transaction Type and a positive quantity on the rows to transact, and leaves the direction to the Transaction Type.
*   Stages the transactions in the inventory transaction interface, so they are processed by the inventory transaction manager in the same way as transactions entered in the WIP Material Transactions form.

### Technical Architecture (High Level)
#### Primary Tables
*   `WIP_ENTITIES`: the jobs, with the job name and entity type.
*   `WIP_DISCRETE_JOBS`: the discrete job header, with the job status type and the assembly item.
*   `WIP_REQUIREMENT_OPERATIONS`: the component requirements of each job, with operation, department, supply type, date required, required and issued quantities, supply subinventory and supply locator.
*   `MTL_SYSTEM_ITEMS_VL`: the component item, and the assembly item through a second alias.
*   `MTL_UNITS_OF_MEASURE_VL`: the primary unit of measure of the component.
*   `BOM_DEPARTMENTS`: the department of each requirement.
*   `MTL_ITEM_LOCATIONS_KFV`: the supply locator of each requirement.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code of each job.

#### Logical Relationships
1.  Each job in `WIP_ENTITIES` is joined to its organization and restricted to entity types 1, 5 and 6, which are the discrete, lot-based and maintenance job types.
2.  Each job is joined to its discrete job header on the entity and organization.
3.  Each requirement in `WIP_REQUIREMENT_OPERATIONS` is joined to its job and excludes repetitive schedule requirements, which the report does not support.
4.  The component is joined to its item in `MTL_SYSTEM_ITEMS_VL`, and the assembly is joined through the job's primary item.
5.  The department and the supply locator are outer-joined, so requirements without them are still listed.
6.  Open quantity is the required quantity less the quantity already issued, and each row is numbered as the upload row.

### Parameters & Filtering
*   **Upload Mode:** selects the upload mode of the file, which determines whether the requirements are downloaded for transacting.
*   **Organization Code:** limits the jobs to one inventory organization.
*   **Job** and **Job Status:** select jobs by name and by their status.
*   **Assembly** and **Component:** select jobs by their assembly and requirements by their component.
*   **Department:** restricts the requirements to one department.
*   **Date Required From** and **To:** bound the requirements by date required.
*   **Open Requirements Only:** restricts the output to requirements that still have an open quantity.

### Performance & Optimization
*   The requirement table is joined to the job table on the entity and organization, so the job filters limit the requirement rows that are read.
*   Repetitive schedule requirements are excluded at the requirement join, so the report reads only discrete and maintenance requirements.
*   Department and locator lookups are outer joins on identifiers, so the cost is one keyed lookup per requirement.
*   Each row carries a row number as its upload key, so the rows can be matched back to the requirement after the file is edited.

### FAQ
**Q: How is the direction of a transaction chosen?**
A: The Transaction Type decides the direction, and the Quantity is always entered as a positive number.

**Q: Which jobs can be transacted with this upload?**
A: Discrete jobs, lot-based jobs and maintenance work orders are supported, but repetitive schedules are not.

**Q: Are these transactions the same as those from the WIP Material Transactions form?**
A: Yes, the rows are staged in the inventory transaction interface and processed by the inventory transaction manager, so the resulting transactions and their effect on the requirement are the same as those of the form.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-material-transaction-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
