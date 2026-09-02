---
layout: default
title: 'EAM Asset Activity Association Upload | Oracle EBS SQL Report'
description: 'EAM Asset Activity Association Upload ===================================== - Create new associations between an Activity item and an Asset Group…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, EAM, Asset, Activity, Association, mtl_eam_asset_activities, mtl_parameters, mtl_system_items_b_kfv'
permalink: /EAM%20Asset%20Activity%20Association%20Upload/
---

# EAM Asset Activity Association Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-asset-activity-association-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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


## Report Parameters
Upload Mode, Maintenance Organization, Activity

## Oracle EBS Tables Used
[mtl_eam_asset_activities](https://www.enginatics.com/library/?pg=1&find=mtl_eam_asset_activities), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [EAM Weekly Schedule](/EAM%20Weekly%20Schedule/ "EAM Weekly Schedule Oracle EBS SQL Report"), [EAM Assets](/EAM%20Assets/ "EAM Assets Oracle EBS SQL Report"), [EAM PM Schedule Upload](/EAM%20PM%20Schedule%20Upload/ "EAM PM Schedule Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [BOM Routing Upload](/BOM%20Routing%20Upload/ "BOM Routing Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/eam-asset-activity-association-upload/) |
| Blitz Report™ XML Import | [EAM_Asset_Activity_Association_Upload.xml](https://www.enginatics.com/xml/eam-asset-activity-association-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/eam-asset-activity-association-upload/](https://www.enginatics.com/reports/eam-asset-activity-association-upload/) |



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
