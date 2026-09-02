---
layout: default
title: 'FND Responsibility Upload | Oracle EBS SQL Report'
description: 'Create and update Oracle E-Business Suite responsibilities, and maintain their menu/function exclusions, replicating the System Administrator…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, FND, Responsibility, fnd_responsibility, fnd_responsibility_tl, fnd_application_vl'
permalink: /FND%20Responsibility%20Upload/
---

# FND Responsibility Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-responsibility-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Create and update Oracle E-Business Suite responsibilities, and maintain their menu/function exclusions, replicating the System Administrator Responsibilities form (FNDSCRSP).

Each row is one of two entity types, chosen in the Row Type column:

- Responsibility: creates or updates the responsibility definition (Name, Application, Key, Description, Effective Dates, Available From, Data Group, Menu, Request Group, Web Host/Agent Name). Responsibilities are identified by Application + Responsibility Key. A responsibility is created when that combination does not yet exist, otherwise it is updated. The Responsibility Key is the stable identifier and is not editable once created - to rename a responsibility change its Name, not its Key.

- Menu/Function Exclusion: adds (or, with Exclude = Yes, removes) a menu or function exclusion for the responsibility identified by Application + Responsibility Key. Exclusion Type selects Function or Menu; Exclusion Name selects the item to exclude. When adding a new responsibility and its exclusions in the same upload, place the Responsibility row before its exclusion rows.

Upload Modes:
- Create opens an empty template.
- Create, Update downloads existing responsibilities (and their exclusions) matching the Application / Responsibility filters for review and update.

Responsibilities are not deleted by this upload; set an Effective Date To to disable one, matching Oracle best practice.

## Report Parameters
Upload Mode, Application, Responsibility Name

## Oracle EBS Tables Used
[fnd_responsibility](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility), [fnd_responsibility_tl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_tl), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_data_groups_standard_view](https://www.enginatics.com/library/?pg=1&find=fnd_data_groups_standard_view), [fnd_menus_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_vl), [fnd_request_groups](https://www.enginatics.com/library/?pg=1&find=fnd_request_groups), [fnd_resp_functions](https://www.enginatics.com/library/?pg=1&find=fnd_resp_functions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Out-of-Balance](/CAC%20Inventory%20Out-of-Balance/ "CAC Inventory Out-of-Balance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/fnd-responsibility-upload/) |
| Blitz Report™ XML Import | [FND_Responsibility_Upload.xml](https://www.enginatics.com/xml/fnd-responsibility-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-responsibility-upload/](https://www.enginatics.com/reports/fnd-responsibility-upload/) |



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
