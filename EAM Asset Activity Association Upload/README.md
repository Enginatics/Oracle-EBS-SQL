---
layout: default
last_modified_at: 2026-10-16
title: 'EAM Asset Activity Association Upload | Oracle EBS SQL Report'
description: 'EAM Asset Activity Association Upload ===================================== - Create new associations between an Activity item and an Asset Group…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, EAM, Asset, Activity, Association, mtl_eam_asset_activities, mtl_parameters, mtl_system_items_b_kfv'
permalink: /EAM%20Asset%20Activity%20Association%20Upload/
report_name: 'EAM Asset Activity Association Upload'
report_web_name: eam-asset-activity-association-upload
---

# EAM Asset Activity Association Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-asset-activity-association-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload).

## Overview
EAM Asset Activity Association Upload
=====================================
- Create new associations between an Activity item and an Asset Group, specific Asset Number (serial instance), or Rebuildable item.
- Update existing association attributes (dates, priority, owning department, WIP class, DFF, etc.).
- Deletion is not supported by the public API in v1.

Prerequisites
=============
- The Activity item (eam_item_type=2) must already exist in the maintenance organization. Use the INV Item Upload to create Activity items.
- For Asset Group associations, the Asset Group (eam_item_type=1) and its serialised instance (csi_item_instances) must exist.
- For Rebuildable (serial) associations, the Rebuildable item (eam_item_type=3) and instance must exist.
- For Rebuildable (non-serial) associations, only the Rebuildable item is required.

Natural business key for create/update detection:
(Asset Activity + Maintenance Object Type + Maintenance Object Id)
which maps to (Activity + Asset Group or Asset Number).

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Maintenance Organization, Activity

## Oracle EBS Tables Used
[mtl_eam_asset_activities](https://www.enginatics.com/library/?pg=1&find=mtl_eam_asset_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload)

## Related Reports
[EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [EAM Weekly Schedule](/EAM%20Weekly%20Schedule/ "EAM Weekly Schedule Oracle EBS SQL Report"), [EAM Assets](/EAM%20Assets/ "EAM Assets Oracle EBS SQL Report"), [EAM PM Schedule Upload](/EAM%20PM%20Schedule%20Upload/ "EAM PM Schedule Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [BOM Routing Upload](/BOM%20Routing%20Upload/ "BOM Routing Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20Asset%20Activity%20Association%20Upload/EAM%20Asset%20Activity%20Association%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/eam-asset-activity-association-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload) |
| Blitz Report™ XML Import | [EAM_Asset_Activity_Association_Upload.xml](https://www.enginatics.com/xml/eam-asset-activity-association-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload) |
| SQL Source | [EAM Asset Activity Association Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20Asset%20Activity%20Association%20Upload/EAM%20Asset%20Activity%20Association%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/eam-asset-activity-association-upload/](https://www.enginatics.com/reports/eam-asset-activity-association-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload) |

## Case Study & Technical Analysis: EAM Asset Activity Association Upload

### Executive Summary
The EAM Asset Activity Association Upload report maintains the links between maintenance activities and the assets they apply to in Oracle Enterprise Asset Management. An activity is linked to an asset group, a specific asset number, or a rebuildable item, and each link carries its own dates, priority, cause, type, shutdown type, owning department and WIP accounting class. Maintenance planners and EAM administrators use the Excel upload to create new associations, update existing ones in bulk, and review current settings, in place of maintaining each association record by record in the application.

### Business Challenge
*   **Large maintenance libraries:** Plants with many assets and recurring activities need many activity associations, which are slow to create one by one.
*   **Consistent planning attributes:** Priority, cause, type, shutdown type, source and tagging requirement must be set consistently across assets of the same class.
*   **Ownership and accounting:** Each association names an owning department and a WIP accounting class, and these determine who executes the work and how it is costed.
*   **Start and end control:** Activities that apply only for a period need active from and to dates maintained in bulk.

### The Solution
*   **Create and update in one file:** The upload creates associations that do not exist and updates existing ones, using the activity, maintenance object type and maintenance object as the business key.
*   **Full attribute coverage:** Dates, priority, cause, activity type, shutdown type, activity source, owning department, WIP class, tagging flag and the descriptive flexfield attributes can all be set in the file.
*   **Readable codes:** Coded attributes are displayed with their meanings, so the file can be reviewed without looking up lookup codes.
*   **Prerequisite checks:** The description lists the items and instances that must already exist, so a failed row can be traced to a missing setup object.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_EAM_ASSET_ACTIVITIES`: the activity association, with its object type, object ID, dates, codes, department, class and flexfield attributes.
*   `MTL_PARAMETERS`: the maintenance organization, which supplies the organization code.
*   `MTL_SYSTEM_ITEMS_B_KFV`: the activity item and the asset group or rebuildable item, joined twice under different aliases.
*   `CSI_ITEM_INSTANCES`: the serialised instance of an asset, found from the instance ID when the object type is an asset number.
*   `BOM_DEPARTMENTS`: the owning department.

#### Logical Relationships
1.  `MTL_EAM_ASSET_ACTIVITIES` is joined to `MTL_PARAMETERS` on organization ID, which supplies the maintenance organization code.
2.  The activity item is joined on the asset activity item ID and the organization, so each row shows the activity name.
3.  The asset group or rebuildable item is outer joined on the inventory item ID and organization, so activity associations with an asset number still appear.
4.  `CSI_ITEM_INSTANCES` is outer joined only when the maintenance object type is 3, using the maintenance object ID as the instance ID.
5.  The owning department is outer joined to `BOM_DEPARTMENTS`, and template activities are excluded through the template flag.

### Parameters & Filtering
*   **Upload Mode:** Selects the update behaviour. The query returns rows only when the mode includes update.
*   **Maintenance Organization:** Limits the associations to one maintenance organization.
*   **Activity:** Limits the rows to one activity item.

### Performance & Optimization
*   **Organization-driven filter:** The join to `MTL_PARAMETERS` and the maintenance organization parameter keep the scan within one maintenance organization.
*   **Template activities excluded:** The template flag test removes template rows, so only live associations are returned.
*   **Conditional instance join:** `CSI_ITEM_INSTANCES` is reached only through a decode that returns the instance ID for object type 3, so other rows are not matched to instances.
*   **Outer joins for optional objects:** Asset groups, instances and departments are outer joined, so associations without those values are retained.

### FAQ
**Q: Can I delete an asset activity association with this upload?**
A: The description states that deletion is not supported by the public API in this version, so existing associations are created or updated only.
**Q: What must exist before I upload an association?**
A: The activity item must already exist in the maintenance organization, and the asset group, asset instance or rebuildable item must exist in the item and instance setup. The description recommends the INV Item Upload for creating activity items.
**Q: How does the upload decide whether to create or update a row?**
A: It uses the activity, the maintenance object type and the maintenance object ID as the natural key, which maps to the activity and either the asset group or the asset number.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-activity-association-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
