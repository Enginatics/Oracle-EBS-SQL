---
layout: default
title: 'EAM Failure Sets Upload | Oracle EBS SQL Report'
description: 'EAM Failure Sets Upload ======================= Creates and updates Oracle EAM (Enterprise Asset Management) Failure Sets, along with their Asset-Group…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, EAM, Failure, Sets, eam_failure_sets, eam_failure_set_associations, mtl_system_items_b_kfv'
permalink: /EAM%20Failure%20Sets%20Upload/
---

# EAM Failure Sets Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-failure-sets-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
EAM Failure Sets Upload
=======================
Creates and updates Oracle EAM (Enterprise Asset Management) Failure Sets, along with their Asset-Group Item Associations and Failure/Cause/Resolution Combinations.

One Set Name can own many child rows (Associations and Combinations). A SET row defines the header explicitly. For Create rows, the upload also creates the missing failure set header automatically from the first ASSOCIATION or COMBINATION row for that Set Name.

Row Type
--------
- SET: Creates or updates the failure set header (set_name, description, effective_end_date).
- ASSOCIATION: Links the set to an asset-group / rebuildable item. The item must have EAM_ITEM_TYPE in (1,3) and exist in the master item organization. On Create, this row can also create the failure set header if it does not exist yet.
- COMBINATION: Adds a valid Failure / Cause / Resolution code triple to the set. The individual codes must already exist in EAM Failure Codes setup (use the EAM Failure Codes Upload). On Create, this row can also create the failure set header if it does not exist yet.

Upload Mode
===========
- Create: opens an empty template. Enter a SET row per new failure set, or enter the first ASSOCIATION / COMBINATION row directly; the upload will create the missing header before processing the child row.
- Create, Update: downloads existing sets / associations / combinations for review or update.

Delete
======
- SET rows cannot be deleted directly (Oracle API does not ship Delete_FailureSet). End-date the set instead by setting Set Effective End Date.
- ASSOCIATION and COMBINATION rows can be deleted by setting Delete to Yes.

Dates
=====
Blanking Effective End Date on an update reactivates the ended record.

## Report Parameters
Upload Mode, Set Name

## Oracle EBS Tables Used
[eam_failure_sets](https://www.enginatics.com/library/?pg=1&find=eam_failure_sets), [eam_failure_set_associations](https://www.enginatics.com/library/?pg=1&find=eam_failure_set_associations), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [eam_failure_combinations](https://www.enginatics.com/library/?pg=1&find=eam_failure_combinations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[EAM Assets](/EAM%20Assets/ "EAM Assets Oracle EBS SQL Report"), [EAM PM Schedule Upload](/EAM%20PM%20Schedule%20Upload/ "EAM PM Schedule Upload Oracle EBS SQL Report"), [EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/eam-failure-sets-upload/) |
| Blitz Report™ XML Import | [EAM_Failure_Sets_Upload.xml](https://www.enginatics.com/xml/eam-failure-sets-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/eam-failure-sets-upload/](https://www.enginatics.com/reports/eam-failure-sets-upload/) |



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
