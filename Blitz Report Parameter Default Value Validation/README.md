---
layout: default
title: 'Blitz Report Parameter Default Value Validation | Oracle EBS SQL Report'
description: 'Lists report parameters whose LOV returns an id that differs from the displayed value, and shows whether the parameter''s default value is stored as that…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Parameter, Default, xxen_report_parameters_v'
permalink: /Blitz%20Report%20Parameter%20Default%20Value%20Validation/
---

# Blitz Report Parameter Default Value Validation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-parameter-default-value-validation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists report parameters whose LOV returns an id that differs from the displayed value, and shows whether the parameter's default value is stored as that id or as the display text.

Default Value Correct is the id the LOV resolves the stored default to. Where it differs from Default Value, the default was entered as the display value instead of the id. Use the 'Show non matching defaults only' parameter to list those cases.

The framework binds the id for such LOVs, so a report level default given as display text only works through a fallback validation, which costs an additional LOV execution every time the run screen opens and is ambiguous if the same text also exists as an id. Template and user level defaults are matched against the id only, so there the display text does not resolve at all.

Is Function and Is Select show whether the default is expressed as a function, e.g. fnd_profile.value, or as a select statement, and Dupl Count how many of the listed parameters share the identical default expression.

Use the Category and Report Name parameters to limit the scope.

## Report Parameters
Category, Report Name, Show non matching defaults only, Show functions ony, Show selects only

## Oracle EBS Tables Used
[xxen_report_parameters_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameters_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Transaction Historical Summary](/INV%20Transaction%20Historical%20Summary/ "INV Transaction Historical Summary Oracle EBS SQL Report"), [Blitz Report Parameter Comparison between reports](/Blitz%20Report%20Parameter%20Comparison%20between%20reports/ "Blitz Report Parameter Comparison between reports Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [Blitz Report Parameter Link Validation](/Blitz%20Report%20Parameter%20Link%20Validation/ "Blitz Report Parameter Link Validation Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [INV Physical Inventory Purge Upload](/INV%20Physical%20Inventory%20Purge%20Upload/ "INV Physical Inventory Purge Upload Oracle EBS SQL Report"), [Blitz Report LOV SQL Validation](/Blitz%20Report%20LOV%20SQL%20Validation/ "Blitz Report LOV SQL Validation Oracle EBS SQL Report"), [Blitz Report Text Search](/Blitz%20Report%20Text%20Search/ "Blitz Report Text Search Oracle EBS SQL Report"), [CAC WIP Account Value](/CAC%20WIP%20Account%20Value/ "CAC WIP Account Value Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/blitz-report-parameter-default-value-validation/) |
| Blitz Report™ XML Import | [Blitz_Report_Parameter_Default_Value_Validation.xml](https://www.enginatics.com/xml/blitz-report-parameter-default-value-validation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-parameter-default-value-validation/](https://www.enginatics.com/reports/blitz-report-parameter-default-value-validation/) |



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
