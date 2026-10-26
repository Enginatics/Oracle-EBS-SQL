---
layout: default
last_modified_at: 2026-10-26
title: 'BOM Common Bill of Materials Upload | Oracle EBS SQL Report'
description: 'BOM Common Bill of Materials Upload ============================================ The upload can be used to create Common BOM from the BOMS defined in the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, BOM, Common, Bill, Materials, bom_bill_of_materials, bom_inventory_components, mtl_parameters'
permalink: /BOM%20Common%20Bill%20of%20Materials%20Upload/
report_name: 'BOM Common Bill of Materials Upload'
report_web_name: bom-common-bill-of-materials-upload
---

# BOM Common Bill of Materials Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/bom-common-bill-of-materials-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload).

## Overview
BOM Common Bill of Materials Upload
============================================
The upload can be used to create Common BOM from the BOMS defined in the specified source organization in one or more target organizations as determined by the Scope Parameter:

All - All Organizations 
BOMs will made Common to all other Organizations that share the same Master Organization as the Source Organization and to which the current responsibility has access to.
 
Hierarchy – Organization Hierarchy
BOMs will made Common to all Organizations the current responsibility has access to and which are below the Source Organization in the specified Hierarchy.

Organization – Specific Organizations
BOMs will be made Common to the specified Target Organizations. The Target Organizations must share the same Master Organization as the Source Organization.

Unlike the Oracle standard Create Common BOM process which requires all sub-component BOMS and substitute component BOMs to be made common individually, this upload process will iterate through the sub-assemblies and substitute assemblies and make them common in the Target Organization if they have not already been defined.

A prerequisite however, as with the BOM Bill of Materials Upload (Amazon), is that all the items are already assigned in the Target Organization.

If any component Items are not defined in the Target Organization, these will be identified in the upload Excel.

Usage
=====
- Specify the Source Organization in which the BOMS are defined
- Specify the Scope to determine the Target Organizations
- Use the Report Parameters to select the BOMS to be made common
- The generated Excel will contain one row per BOM and Target Organization combination

- The generated Excel Identifies if the BOM Item is defined in the Target Organization, if it already exists as a BOM in the Target Organization, if it is a Common BOM in the target organization already, and if the BOM has any component items which are not defined in the Target Organization. These will prevent the BOM upload process from attempting to make the BOM common in the target organization.

- In the generated Excel, set the ‘Create Common Bom’ column to Yes against the BOM/Target Organization combinations to be made Common.
- Save and upload the Excel to process the selections made back into Oracle
- After upload, a new Excel is generated showing the success/error status of the creation of the Common BOMS in each target organization.

Templates
=========
Common BOM Upload Template
In this template, the user must review and manually select the BOM/Target Organization combinations to be made Common. Setting the ‘Create Common Bom’ flag against a BOM/Target Organization combination will trigger the row for update and processing during upload.

Automatic Common BOM Upload Template
In this template, the excel is generated with the ‘Create Common Bom’ flag set against all BOM/Target Organization combinations and the rows already flagged for update and processing. In this template the user can opt out of creating a common BOM for specific BOM/Target Organization combinations by either de-selecting (clearing) the ‘Create Common Bom’ flag column or by deleting the row from the spreadsheet.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Source Organization Code, Common BOM Scope, Target Hierarchy, Target Organization, Enable Attributes Update, Assembly, Alternate BOM, Show Sub-Assemblies, Show Missing BOMS only, Auto Populate Upload Columns, Implemented Only, Display, Effective Date

## Oracle EBS Tables Used
[bom_bill_of_materials](https://www.enginatics.com/library/?pg=1&find=bom_bill_of_materials&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload), [bom_inventory_components](https://www.enginatics.com/library/?pg=1&find=bom_inventory_components&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload), [mtl_system_items_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload), [bom_substitute_components](https://www.enginatics.com/library/?pg=1&find=bom_substitute_components&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload)

## Related Reports
[BOM Bill of Material Structure](/BOM%20Bill%20of%20Material%20Structure/ "BOM Bill of Material Structure Oracle EBS SQL Report"), [BOM Bill of Materials Upload](/BOM%20Bill%20of%20Materials%20Upload/ "BOM Bill of Materials Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [WIP Job Upload](/WIP%20Job%20Upload/ "WIP Job Upload Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/BOM%20Common%20Bill%20of%20Materials%20Upload/BOM%20Common%20Bill%20of%20Materials%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/bom-common-bill-of-materials-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload) |
| Blitz Report™ XML Import | [BOM_Common_Bill_of_Materials_Upload.xml](https://www.enginatics.com/xml/bom-common-bill-of-materials-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload) |
| SQL Source | [BOM Common Bill of Materials Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/BOM%20Common%20Bill%20of%20Materials%20Upload/BOM%20Common%20Bill%20of%20Materials%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/bom-common-bill-of-materials-upload/](https://www.enginatics.com/reports/bom-common-bill-of-materials-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload) |

## BOM Common Bill of Materials Upload

### Description
The upload can be used to create Common BOM from the BOMS defined in the specified source organization in one or more target organizations as determined by the Scope Parameter:

All - All Organizations 
BOMs will made Common to all other Organizations that share the same Master Organization as the Source Organization and to which the current responsibility has access to.
 
Hierarchy – Organization Hierarchy
BOMs will made Common to all Organizations the current responsibility has access to and which are below the Source Organization in the specified Hierarchy.

Organization – Specific Organizations
BOMs will be made Common to the specified Target Organizations. The Target Organizations must share the same Master Organization as the Source Organization.

Unlike the Oracle standard Create Common BOM process which requires all sub-component BOMS and substitute component BOMs to be made common individually, this upload process will iterate through the sub-assemblies and substitute assemblies and make them common in the Target Organization if they have not already been defined.

A prerequisite however, as with the BOM Bill of Materials Upload (Amazon), is that all the items are already assigned in the Target Organization.

If any component Items are not defined in the Target Organization, these will be identified in the upload Excel.

Usage
=====
- Specify the Source Organization in which the BOMS are defined
- Specify the Scope to determine the Target Organizations
- Use the Report Parameters to select the BOMS to be made common
- The generated Excel will contain one row per BOM and Target Organization combination

- The generated Excel Identifies if the BOM Item is defined in the Target Organization, if it already exists as a BOM in the Target Organization, if it is a Common BOM in the target organization already, and if the BOM has any component items which are not defined in the Target Organization. These will prevent the BOM upload process from attempting to make the BOM common in the target organization.

- In the generated Excel, set the ‘Create Common Bom’ column to Yes against the BOM/Target Organization combinations to be made Common.
- Save and upload the Excel to process the selections made back into Oracle
- After upload, a new Excel is generated showing the success/error status of the creation of the Common BOMS in each target organization.

Templates
=========
Common BOM Upload Template
In this template, the user must review and manually select the BOM/Target Organization combinations to be made Common. Setting the ‘Create Common Bom’ flag against a BOM/Target Organization combination will trigger the row for update and processing during upload.

Automatic Common BOM Upload Template
In this template, the excel is generated with the ‘Create Common Bom’ flag set against all BOM/Target Organization combinations and the rows already flagged for update and processing. In this template the user can opt out of creating a common BOM for specific BOM/Target Organization combinations by either de-selecting (clearing) the ‘Create Common Bom’ flag column or by deleting the row from the spreadsheet. 

### Parameters
Source Organization Code, Common BOM Scope, Target Hierarchy, Target Organization, Enable Attributes Update, Assembly, Alternate BOM, Show Sub-Assemblies, Show Missing BOMS only, Auto Populate Upload Columns, Implemented Only, Display, Effective Date

### Used tables
bom_bill_of_materials, bom_inventory_components, mtl_parameters, mtl_system_items_kfv, mtl_system_items_vl, bom_tree, bom_substitute_components, bom, org_access_view, bom_subst

### Categories
Enginatics, Upload

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-common-bill-of-materials-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
