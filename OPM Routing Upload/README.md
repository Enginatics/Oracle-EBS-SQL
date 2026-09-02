---
layout: default
title: 'OPM Routing Upload | Oracle EBS SQL Report'
description: 'OPM Routing Upload ================== Create or update Oracle Process Manufacturing (OPM / GMD) Routings via the public API GMDROUTINGSPUB /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, OPM, Routing, gmd_status_vl, fnd_user, gmd_routings_vl'
permalink: /OPM%20Routing%20Upload/
---

# OPM Routing Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-routing-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
OPM Routing Upload
==================
Create or update Oracle Process Manufacturing (OPM / GMD) Routings via the public API GMD_ROUTINGS_PUB / GMD_ROUTING_STEPS_PUB.

Row model
=========
One spreadsheet row per routing STEP. The header columns (Organization Code, Routing, Routing Version, Description, Class, UOM, dates, owner, header attributes) repeat on every step of the same routing. Each step carries its Step No, Operation (No + Version), Step Quantity, Release Type, and step attributes. Rows of the same routing (Organization Code + Routing + Routing Version) must be contiguous. Every routing must have at least one step.

Step dependencies (optional)
============================
To make a step depend on a predecessor step, fill Depends On Step No (and optionally Standard / Minimum / Maximum Delay, Transfer Percent, Rework Code, Chargeable) on that step's row. For a step with more than one predecessor, add extra rows that repeat the Step No, leave Operation blank, and give a different Depends On Step No. Dependency Type is always Finish-to-Start.

Operations must already exist
=============================
Operations are referenced, not created - the Operation (No + Version) must already exist in the routing's organization, effective for the routing's dates.

Upload modes
============
Create - empty template for new routings.
Create, Update - downloads existing routings in the chosen organization for review/edit and allows adding new ones.

Update limitations (public API)
===============================
On update, the OPM public API only allows changing a routing's Status, Routing Class, Routing UOM, Fixed Process Loss UOM, Owner and Organization at the header level; Description, Quantity, Process Loss, effective dates and the step-dependency flags are set at create time only. Steps can be added and their quantity / release type / yield updated.

## Report Parameters
Upload Mode, Organization Code, Routing

## Oracle EBS Tables Used
[gmd_status_vl](https://www.enginatics.com/library/?pg=1&find=gmd_status_vl), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [gmd_routings_vl](https://www.enginatics.com/library/?pg=1&find=gmd_routings_vl), [fm_rout_dtl](https://www.enginatics.com/library/?pg=1&find=fm_rout_dtl), [gmd_operations_vl](https://www.enginatics.com/library/?pg=1&find=gmd_operations_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/opm-routing-upload/) |
| Blitz Report™ XML Import | [OPM_Routing_Upload.xml](https://www.enginatics.com/xml/opm-routing-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/opm-routing-upload/](https://www.enginatics.com/reports/opm-routing-upload/) |



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
