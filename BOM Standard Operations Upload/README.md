---
layout: default
last_modified_at: 2026-10-16
title: 'BOM Standard Operations Upload | Oracle EBS SQL Report'
description: 'Report: BOM Standard Operations Upload This upload can be used to create and/or update BOM Standard Operations. Standard operations are reusable operation…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, BOM, Standard, Operations, mtl_item_locations_kfv, mtl_parameters, bom_standard_operations'
permalink: /BOM%20Standard%20Operations%20Upload/
report_name: 'BOM Standard Operations Upload'
report_web_name: bom-standard-operations-upload
---

# BOM Standard Operations Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/bom-standard-operations-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload).

## Overview
Report: BOM Standard Operations Upload

This upload can be used to create and/or update BOM Standard Operations.

Standard operations are reusable operation templates that routings can reference. The upload covers:
- Standard operation header (code, type, line, department, attributes, EAM and OSFM extensions)
- Primary resource assignments to the standard operation
- Substitute (alternate) resource assignments
- Descriptive flexfield attributes on the header and primary resources

Each Excel row represents one resource of a standard operation. Header columns repeat across resource rows of the same standard operation. To upload a standard operation with no resources, leave the Resource Code blank. To upload a substitute resource, set Substitute Resource to Yes and supply Substitute Group + Replacement Group.

Standard operations are one of four types: discrete Standard (not tied to a production line), or Flow Event, Flow Process or Flow Line (each tied to a line). Many columns apply, default or are editable differently by operation type - for example Value Added and Critical to Quality can only be set to No on Flow Events, Count Point, Auto-charge and Backflush can only be set to No on discrete Standard operations, and Display Sequence applies only to Flow Process and Flow Line operations. Each affected column carries a cell comment describing its behaviour, and the supplied templates already show only the columns relevant to each type.

Five templates are provided, one per operation type and scenario - pick the one matching the operation you are creating. Each shows only the columns relevant to that type, and the flow templates pre-set the Operation Type:

- Discrete Standard Operation: a standard operation not tied to a production line.
- Discrete Standard Operation - Shop Floor Management: the same, for OSFM/WSM-enabled organizations, additionally showing the Shop Floor Management fields (Operation Yield Enabled, Yield, Lowest Acceptable Yield, the Queue/Run/To Move Mandatory flags, Track Multiple Resource Usage Dates and the Show flags).
- Flow Standard Events: a Flow Event operation tied to a production line.
- Flow Standard Line Operations: a Flow Line operation tied to a production line.
- Flow Standard Processes: a Flow Process operation tied to a production line.

The download parameters control which operations are returned: Organization Code (defaults to your current manufacturing organization), Manufacturing Mode (Flow or Standard), Operation Type, Operation Code, Operation Code like (pattern search), Department and Contains Resource. Contains Resource returns each matching operation in full - all of its resource and substitute rows - so a resource is shown in the context of its whole operation rather than as an isolated line.

Deletion is supported at two levels via the Delete Std Op and Delete Resource columns. Header delete cascades to resources, substitute resources, and OSFM child rows (bonus codes, scrap codes, responsibility exclusions). Header delete is blocked if the standard operation is referenced by an active routing operation or by a setup transition.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Manufacturing Mode, Operation Type, Operation Code, Operation Code like, Department, Contains Resource

## Oracle EBS Tables Used
[mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload), [bom_standard_operations](https://www.enginatics.com/library/?pg=1&find=bom_standard_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload), [bom_std_op_resources](https://www.enginatics.com/library/?pg=1&find=bom_std_op_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload), [cst_activities_val_v](https://www.enginatics.com/library/?pg=1&find=cst_activities_val_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload), [bom_std_sub_op_resources](https://www.enginatics.com/library/?pg=1&find=bom_std_sub_op_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload)

## Related Reports
[BOM Routing Upload](/BOM%20Routing%20Upload/ "BOM Routing Upload Oracle EBS SQL Report"), [BOM Routings](/BOM%20Routings/ "BOM Routings Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [WIP Job Upload](/WIP%20Job%20Upload/ "WIP Job Upload Oracle EBS SQL Report"), [CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/BOM%20Standard%20Operations%20Upload/BOM%20Standard%20Operations%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/bom-standard-operations-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload) |
| Blitz Report™ XML Import | [BOM_Standard_Operations_Upload.xml](https://www.enginatics.com/xml/bom-standard-operations-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload) |
| SQL Source | [BOM Standard Operations Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/BOM%20Standard%20Operations%20Upload/BOM%20Standard%20Operations%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/bom-standard-operations-upload/](https://www.enginatics.com/reports/bom-standard-operations-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload) |

## Case Study & Technical Analysis: BOM Standard Operations Upload

### Executive Summary
This upload creates and updates Oracle Bills of Material standard operations, the reusable operation templates that routings reference. It covers the operation header, its primary resource assignments and substitute resources, and the descriptive flexfield values on the header and primary resources. Manufacturing engineers and process engineers use it to maintain operation libraries across many organizations, especially when a new production line or a shop floor management set-up needs many operations at once. The template runs in Excel through Blitz Report.

### Business Challenge
*   **Large operation libraries:** Standard operations are maintained one at a time in the Standard Operations form, which slows down the setup of a new plant or line.
*   **Type-dependent rules:** Discrete, flow event, flow process and flow line operations accept different columns, and an error in one of them blocks the whole routing.
*   **Resource consistency:** Each operation needs its primary and substitute resources, departments and activities to agree with the resource setup.
*   **Safe deletion:** Operations referenced by a routing or a setup transition cannot be removed without first checking those references.

### The Solution
*   **One row per resource:** The header columns repeat across the resource rows of one standard operation, and an operation with no resource is uploaded by leaving Resource Code blank.
*   **Type-specific templates:** Five templates cover the four operation types and the shop floor management variant, and each shows only the columns that apply to its type.
*   **Substitute resources:** Setting Substitute Resource to Yes with a Substitute Group and Replacement Group records an alternate resource.
*   **Two-level deletion:** Delete Std Op removes the operation with its resources, substitutes and shop floor management child rows, provided no active routing operation or setup transition uses it. Delete Resource removes a single resource.
*   **Contextual download:** Contains Resource returns each matching operation with all of its resource and substitute rows, so each resource appears within its whole operation.

### Technical Architecture (High Level)
#### Primary Tables
*   `BOM_STANDARD_OPERATIONS`: the operation header, including type, line, department, yield, count point, auto-charge and backflush settings.
*   `BOM_STD_OP_RESOURCES`: the primary resource assignments of a standard operation.
*   `BOM_STD_SUB_OP_RESOURCES`: the substitute resource assignments and their substitute and replacement groups.
*   `BOM_RESOURCES`: the resource code and description for each assignment.
*   `BOM_DEPARTMENTS`: the department that owns the operation.
*   `WIP_LINES`: the production line for flow operations.
*   `CST_ACTIVITIES_VAL_V`: the activity attached to a resource assignment.
*   `MTL_PARAMETERS` and `MTL_ITEM_LOCATIONS_KFV`: the organization and the default locator.

#### Logical Relationships
1. `MTL_PARAMETERS` is matched to `BOM_STANDARD_OPERATIONS` on organization id, and the organization code is the download filter.
2. `BOM_STANDARD_OPERATIONS` joins to `BOM_DEPARTMENTS` on department id and to `WIP_LINES` on line id as an outer join, since discrete operations have no line.
3. `BOM_STANDARD_OPERATIONS` joins to `BOM_STD_SUB_OP_RESOURCES` on the standard operation id, which carries the resource and substitute group assignments.
4. Each assignment joins to `BOM_RESOURCES` on resource id and to `CST_ACTIVITIES_VAL_V` on activity id, as an outer join for resources with no activity.
5. The default locator is resolved from the locator id to `MTL_ITEM_LOCATIONS_KFV` within the same organization.

### Parameters & Filtering
*   **Upload Mode:** selects Create or Create, Update for the download.
*   **Organization Code:** sets the organization. It defaults to the current manufacturing organization.
*   **Manufacturing Mode:** restricts the operations to Flow or Standard.
*   **Operation Type:** restricts the operations to one of the four types.
*   **Operation Code and Operation Code like:** select one operation or a pattern.
*   **Department:** restricts the operations to one department.
*   **Contains Resource:** returns each matching operation in full, with all its resource rows.

### Performance & Optimization
*   The organization parameter is the first filter, so every join runs inside one manufacturing organization.
*   Activity and line joins are outer joins, which keeps resources without an activity and discrete operations without a line in the result.
*   Flexfield values are rendered through `xxen_util.display_flexfield_value` with the operations flexfield identifier, so the download reads the segment labels rather than raw columns.

### FAQ
**Q: How do I upload a standard operation that has no resources?**
A: Enter the header columns and leave Resource Code blank on that row.

**Q: Why can a standard operation not be deleted?**
A: Header deletion is blocked when an active routing operation or a setup transition references the standard operation.

**Q: Which template should I use for a flow line operation?**
A: Use Flow Standard Line Operations, which is a Flow Line operation tied to a production line.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-standard-operations-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
