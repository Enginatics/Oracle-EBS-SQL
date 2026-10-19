---
layout: default
last_modified_at: 2026-10-19
title: 'OPM Formula Upload | Oracle EBS SQL Report'
description: 'OPM Formula Upload ================== Create or update Oracle Process Manufacturing (OPM / GMD) Formulas via the public API GMDFORMULAPUB /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, OPM, Formula, fnd_user, gmd_status_vl, fm_form_mst_vl'
permalink: /OPM%20Formula%20Upload/
report_name: 'OPM Formula Upload'
report_web_name: opm-formula-upload
---

# OPM Formula Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-formula-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload).

## Overview
OPM Formula Upload
==================
Create or update Oracle Process Manufacturing (OPM / GMD) Formulas via the public API GMD_FORMULA_PUB / GMD_FORMULA_DETAIL_PUB.

Row model
=========
One spreadsheet row per formula LINE. The header columns (Organization Code, Formula, Formula Version, Description, Class, Owner, Header Scale Type, Status, header attributes) repeat on every line of the same formula. Each line carries its Line Type (Ingredient / Product / By-Product) plus its item, quantity, UOM, scale, and line attributes. Rows of the same formula (Organization Code + Formula + Formula Version) must be contiguous.

Every formula must have at least one Ingredient AND at least one Product (OPM requirement) - a header-only formula is rejected.

Upload modes
============
Create - empty template for new formulas.
Create, Update - downloads existing formulas in the chosen organization for review/edit and allows adding new ones. Existing formulas are matched on Organization Code + Formula + Formula Version.

Notes
=====
- Items must be recipe-enabled in the owner organization. Detail UOM must be convertible from the item's primary UOM.
- New formulas are created in status New (100); status changes are a workflow operation and are not driven by this upload.
- On update, header description/class/owner and line quantities/attributes are updated; new lines are added. The owner organization and version are the key and cannot be changed.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Formula

## Oracle EBS Tables Used
[fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload), [gmd_status_vl](https://www.enginatics.com/library/?pg=1&find=gmd_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload), [fm_form_mst_vl](https://www.enginatics.com/library/?pg=1&find=fm_form_mst_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload), [fm_matl_dtl](https://www.enginatics.com/library/?pg=1&find=fm_matl_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload)

## Related Reports
[OPM Recipe Upload](/OPM%20Recipe%20Upload/ "OPM Recipe Upload Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report"), [OPM Formula Details](/OPM%20Formula%20Details/ "OPM Formula Details Oracle EBS SQL Report"), [OPM Formula Where-Used](/OPM%20Formula%20Where-Used/ "OPM Formula Where-Used Oracle EBS SQL Report"), [OPM Recipe Details](/OPM%20Recipe%20Details/ "OPM Recipe Details Oracle EBS SQL Report"), [OPM Routing Upload](/OPM%20Routing%20Upload/ "OPM Routing Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Formula%20Upload/OPM%20Formula%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/opm-formula-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload) |
| Blitz Report™ XML Import | [OPM_Formula_Upload.xml](https://www.enginatics.com/xml/opm-formula-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload) |
| SQL Source | [OPM Formula Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Formula%20Upload/OPM%20Formula%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/opm-formula-upload/](https://www.enginatics.com/reports/opm-formula-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload) |

## Case Study & Technical Analysis: OPM Formula Upload

### Executive Summary
This upload creates and updates process manufacturing formulas in Oracle Process Manufacturing (OPM), the recipes that define the ingredients, products and by-products of a process. It downloads the formulas of an organization, one spreadsheet row per formula line, and lets a formulation or product development team add formulas, change quantities and attributes, and add lines. Changes are applied through the public GMDFORMULAPUB and GMDFORMULADETAILPUB APIs, so the OPM rules are enforced on every row. It is used when new formulas are loaded from a development system, when many formula quantities are revised, or when formulas are copied between organizations. Blitz Report™ provides the spreadsheet in which the formulas are reviewed and edited.

### Business Challenge
*   **Formulas are multi-line:** A formula is a header with several ingredient, product and by-product lines, which is awkward to maintain one screen at a time.
*   **OPM validation rules:** A formula must have at least one ingredient and at least one product, and items must be recipe-enabled, so bad rows must be found before the upload.
*   **Versions and keys:** Formulas are identified by organization, formula number and version, and the key must stay stable through an update.
*   **Status control:** Formula status changes are workflow operations, so the upload must not change status directly.

### The Solution
*   Downloads each formula line with its header fields, including organization code, formula number and version, description, class, owner, scale type, status and header attributes.
*   Shows each line's type as ingredient, product or by-product, with its item, revision, quantity, detail unit of measure, scale type, release type, scrap factor, phantom type, rework type and yield and cost flags.
*   Assigns an upload row number in formula order, so the rows of one formula stay together for the upload.
*   Shows the header and line flexfield attributes of each formula and line, so they can be edited in the same file.
*   Supports creating new formulas with an empty template, and updating existing formulas in the chosen organization while adding new lines to them.

### Technical Architecture (High Level)
#### Primary Tables
*   `FM_FORM_MST_VL`: the formula header, with formula number, version, description, class, owner, scale type, status and attributes.
*   `FM_MATL_DTL`: the formula lines, with the line type, item, quantity, unit of measure, scale and attributes.
*   `MTL_SYSTEM_ITEMS_VL`: the item and its description.
*   `MTL_PARAMETERS`: the owner organization of the formula.
*   `GMD_STATUS_VL`: the formula status meaning.
*   `FND_USER`: the formula owner's user name.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

#### Logical Relationships
1. `FM_FORM_MST_VL` is joined to `FM_MATL_DTL` on the formula identifier, so each line carries its header.
2. The owner organization of the formula is joined to `MTL_PARAMETERS`.
3. Each line's item is joined to `MTL_SYSTEM_ITEMS_VL` on inventory item and organization.
4. The owner user and formula status are looked up from `FND_USER` and `GMD_STATUS_VL`.
5. Deleted formulas and inactive formulas are excluded, and the owner organization is limited to the organizations the responsibility can access.
6. An outer query orders the lines within each formula as ingredients, then products, then by-products, and by line number.

### Parameters & Filtering
*   **Upload Mode:** selects create with an empty template, or create and update, which downloads existing formulas.
*   **Organization Code:** selects the owner organization of the formulas.
*   **Formula:** limits the download to one formula number.

### Performance & Optimization
*   The organization restriction is applied through `ORG_ACCESS_VIEW`, so only formulas the user can access are read.
*   Deleted and inactive formulas are excluded in the header filter, so their lines are not read.
*   The flexfield values are resolved by the flexfield functions for each row, using the attribute category of the header and the line.
*   The download is ordered by formula and line type, which keeps rows of one formula contiguous, as the upload requires.

### FAQ
**Q: Why does an upload row fail for a formula with no product?**
A: OPM requires at least one ingredient and one product on every formula. A header-only formula is rejected by the API.

**Q: Can I change the status of a formula through this upload?**
A: No. New formulas are created in status New, and status changes are workflow operations that this upload does not drive.

**Q: Which fields identify an existing formula on update?**
A: The organization code, formula number and version. These cannot be changed on update.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-formula-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
