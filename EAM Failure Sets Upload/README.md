---
layout: default
last_modified_at: 2026-10-16
title: 'EAM Failure Sets Upload | Oracle EBS SQL Report'
description: 'EAM Failure Sets Upload ======================= Creates and updates Oracle EAM (Enterprise Asset Management) Failure Sets, along with their Asset-Group…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, EAM, Failure, Sets, eam_failure_sets, eam_failure_set_associations, mtl_system_items_b_kfv'
permalink: /EAM%20Failure%20Sets%20Upload/
report_name: 'EAM Failure Sets Upload'
report_web_name: eam-failure-sets-upload
---

# EAM Failure Sets Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-failure-sets-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Set Name

## Oracle EBS Tables Used
[eam_failure_sets](https://www.enginatics.com/library/?pg=1&find=eam_failure_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload), [eam_failure_set_associations](https://www.enginatics.com/library/?pg=1&find=eam_failure_set_associations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload), [eam_failure_combinations](https://www.enginatics.com/library/?pg=1&find=eam_failure_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload)

## Related Reports
[EAM Assets](/EAM%20Assets/ "EAM Assets Oracle EBS SQL Report"), [EAM Work Orders 11i](/EAM%20Work%20Orders%2011i/ "EAM Work Orders 11i Oracle EBS SQL Report"), [EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [EAM PM Schedule Upload](/EAM%20PM%20Schedule%20Upload/ "EAM PM Schedule Upload Oracle EBS SQL Report"), [EAM PM Schedule Upload 11i](/EAM%20PM%20Schedule%20Upload%2011i/ "EAM PM Schedule Upload 11i Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20Failure%20Sets%20Upload/EAM%20Failure%20Sets%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/eam-failure-sets-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload) |
| Blitz Report™ XML Import | [EAM_Failure_Sets_Upload.xml](https://www.enginatics.com/xml/eam-failure-sets-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload) |
| SQL Source | [EAM Failure Sets Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20Failure%20Sets%20Upload/EAM%20Failure%20Sets%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/eam-failure-sets-upload/](https://www.enginatics.com/reports/eam-failure-sets-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload) |

## Case Study & Technical Analysis: EAM Failure Sets Upload

### Executive Summary
This upload creates and updates Oracle Enterprise Asset Management failure sets. A failure set groups the failure, cause and resolution codes that maintenance planners can record against the asset groups and rebuildable items it is associated with. The upload maintains three kinds of rows: the set header, the item associations and the failure, cause and resolution combinations. Maintenance engineers and reliability analysts use it to set up failure coding for a plant in one workbook rather than through the Failure Sets form item by item. The template runs in Excel through Blitz Report.

### Business Challenge
*   **Consistent failure coding:** Work orders are only useful for reliability analysis when the same failure, cause and resolution codes are used for the same equipment.
*   **Large setup effort:** Each failure set needs many item associations and combinations, which is slow to maintain one at a time.
*   **Validation of codes and items:** Combinations must use codes that already exist, and associated items must be eligible asset groups or rebuildable items.
*   **Retiring obsolete coding:** Sets and their children must be ended without losing history.

### The Solution
*   **Three row types:** SET rows define the header, ASSOCIATION rows link the set to an asset group or rebuildable item, and COMBINATION rows add a failure, cause and resolution triple.
*   **Header created from child rows:** On Create, the first ASSOCIATION or COMBINATION row for a new Set Name creates the missing header.
*   **Item eligibility:** An association item must have an EAM item type of 1 or 3 and must exist in the master item organization.
*   **Ending rather than deleting:** A SET row cannot be deleted, so it is end-dated instead. ASSOCIATION and COMBINATION rows can be deleted by setting Delete to Yes.
*   **Reactivation:** Blanking the effective end date of an ended record on update reactivates it.

### Technical Architecture (High Level)
#### Primary Tables
*   `EAM_FAILURE_SETS`: the failure set header, with set name, description and effective end date.
*   `EAM_FAILURE_SET_ASSOCIATIONS`: the links between a set and an inventory item, with the failure code required flag and effective end date.
*   `EAM_FAILURE_COMBINATIONS`: the failure, cause and resolution code triples of a set, with their effective end dates.
*   `MTL_SYSTEM_ITEMS_B_KFV`: the associated inventory item and its concatenated segments.
*   `MTL_PARAMETERS`: the master organization test that restricts associations to the master item organization.

#### Logical Relationships
1. `EAM_FAILURE_SETS` is the parent of both child sets, joined on set id.
2. `EAM_FAILURE_SET_ASSOCIATIONS` joins to `MTL_SYSTEM_ITEMS_B_KFV` on inventory item id, and the item's organization must equal the master organization in `MTL_PARAMETERS`.
3. `EAM_FAILURE_COMBINATIONS` carries the failure, cause and resolution codes directly on each row.
4. The three row types are combined with UNION ALL, so every row shares the set name and the row type column.

### Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download the sets, associations and combinations.
*   **Set Name:** restricts the download to one failure set.

### Performance & Optimization
*   The query returns three UNION ALL blocks, each a direct join from the set table, so no block depends on another's result.
*   The master organization test on `MTL_PARAMETERS` limits the item join to one organization, which avoids repeated item rows across organizations.
*   The Set Name parameter reduces the set scan to a single set when a plant maintains one set at a time.

### FAQ
**Q: Why can I not delete a failure set?**
A: The Oracle API does not provide a delete for failure sets. Set Set Effective End Date instead to end the set.

**Q: Which items can I associate with a failure set?**
A: Items with an EAM item type of asset group or rebuildable, which exist in the master item organization.

**Q: Do I need the failure codes to exist before I upload combinations?**
A: Yes. The individual codes must already exist in the EAM failure code setup, which the EAM Failure Codes Upload maintains.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-sets-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
