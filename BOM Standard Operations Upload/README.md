---
layout: default
title: 'BOM Standard Operations Upload | Oracle EBS SQL Report'
description: 'Report: BOM Standard Operations Upload This upload can be used to create and/or update BOM Standard Operations. Standard operations are reusable operation…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, BOM, Standard, Operations, mtl_item_locations_kfv, mtl_parameters, bom_standard_operations'
permalink: /BOM%20Standard%20Operations%20Upload/
---

# BOM Standard Operations Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/bom-standard-operations-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Upload Mode, Organization Code, Manufacturing Mode, Operation Type, Operation Code, Operation Code like, Department, Contains Resource

## Oracle EBS Tables Used
[mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [bom_standard_operations](https://www.enginatics.com/library/?pg=1&find=bom_standard_operations), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines), [bom_std_op_resources](https://www.enginatics.com/library/?pg=1&find=bom_std_op_resources), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_activities_val_v](https://www.enginatics.com/library/?pg=1&find=cst_activities_val_v), [bom_std_sub_op_resources](https://www.enginatics.com/library/?pg=1&find=bom_std_sub_op_resources)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[AR Transactions and Lines](/AR%20Transactions%20and%20Lines/ "AR Transactions and Lines Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [INV Stock Locator Upload](/INV%20Stock%20Locator%20Upload/ "INV Stock Locator Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/bom-standard-operations-upload/) |
| Blitz Report™ XML Import | [BOM_Standard_Operations_Upload.xml](https://www.enginatics.com/xml/bom-standard-operations-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/bom-standard-operations-upload/](https://www.enginatics.com/reports/bom-standard-operations-upload/) |



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
