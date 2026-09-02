---
layout: default
title: 'Blitz Report Template Sharing Upload | Oracle EBS SQL Report'
description: 'Upload to maintain Blitz Report template sharing - which users, responsibilities, or the whole site can see and use a report template (Excel layout). The…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Blitz, Report, Template, Sharing, xxen_report_templates_v, xxen_report_template_sharing_v, fnd_application_vl'
permalink: /Blitz%20Report%20Template%20Sharing%20Upload/
---

# Blitz Report Template Sharing Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-template-sharing-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Upload to maintain Blitz Report template sharing - which users, responsibilities, or the whole site can see and use a report template (Excel layout).

The upload can be run in the following modes:

-Create with 'Create Empty File'=Yes:
Opens an empty Excel file to enter new template shares.

-Create with 'Create Empty File'=blank:
Query the templates you want to share, filtered by report name, category or sharing level.

-Create, Update:
Query existing template shares, which can be deleted or copied to a different sharing level.

Sharing levels:
-Site shares the template with the whole system (all responsibilities and users).
-Responsibility shares it with one responsibility - enter the responsibility name in Shared With and its owning application in Description.
-User shares it with one named user.

Note: Site sharing is mutually exclusive with specific shares. Sharing a template at Site level removes any existing Responsibility or User shares for that template, and adding a Responsibility or User share removes any existing Site share - mirroring the Blitz Report template setup form.

## Report Parameters
Upload Mode, Create Empty File, Report Name starts with, Report Category, Sharing Level, Sharing Creation Date From, Sharing Creation Date To

## Oracle EBS Tables Used
[xxen_report_templates_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_templates_v), [xxen_report_template_sharing_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_template_sharing_v), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report"), [Blitz Report Templates](/Blitz%20Report%20Templates/ "Blitz Report Templates Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [DIS Migration identify missing EulConditions](/DIS%20Migration%20identify%20missing%20EulConditions/ "DIS Migration identify missing EulConditions Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [INV Item Templates](/INV%20Item%20Templates/ "INV Item Templates Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/blitz-report-template-sharing-upload/) |
| Blitz Report™ XML Import | [Blitz_Report_Template_Sharing_Upload.xml](https://www.enginatics.com/xml/blitz-report-template-sharing-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-template-sharing-upload/](https://www.enginatics.com/reports/blitz-report-template-sharing-upload/) |



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
