---
layout: default
title: 'OPM Formula Upload | Oracle EBS SQL Report'
description: 'OPM Formula Upload ================== Create or update Oracle Process Manufacturing (OPM / GMD) Formulas via the public API GMDFORMULAPUB /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, OPM, Formula, fnd_user, gmd_status_vl, fm_form_mst_vl'
permalink: /OPM%20Formula%20Upload/
---

# OPM Formula Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-formula-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Upload Mode, Organization Code, Formula

## Oracle EBS Tables Used
[fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [gmd_status_vl](https://www.enginatics.com/library/?pg=1&find=gmd_status_vl), [fm_form_mst_vl](https://www.enginatics.com/library/?pg=1&find=fm_form_mst_vl), [fm_matl_dtl](https://www.enginatics.com/library/?pg=1&find=fm_matl_dtl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/opm-formula-upload/) |
| Blitz Report™ XML Import | [OPM_Formula_Upload.xml](https://www.enginatics.com/xml/opm-formula-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/opm-formula-upload/](https://www.enginatics.com/reports/opm-formula-upload/) |



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
