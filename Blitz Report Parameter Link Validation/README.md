---
layout: default
title: 'Blitz Report Parameter Link Validation | Oracle EBS SQL Report'
description: 'Lists orphaned parameter rows: additional-anchor (sub) parameter rows - those without a display sequence - that do not link to a visible parameter of the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Parameter, Link, xxen_report_parameters_v, xxen_report_parameters_link_v'
permalink: /Blitz%20Report%20Parameter%20Link%20Validation/
---

# Blitz Report Parameter Link Validation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-parameter-link-validation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists orphaned parameter rows: additional-anchor (sub) parameter rows - those without a display sequence - that do not link to a visible parameter of the same name in the same report (parameter_id not in xxen_report_parameters_link_v).

These are typically left behind by an incomplete parameter rename (e.g. 'Show DFF Attributes' to 'DFF Display'), leaving the old-named multi-anchor sub-rows dangling.

The run-time SQL is assembled solely from xxen_report_parameters_link_v, so an unlinked sub-row is never injected and is harmless at run time, but it clutters the parameter setup and would re-activate unexpectedly if a visible parameter with the old name were re-created.

Use the Category parameter to limit the scope.

## Report Parameters
Category

## Oracle EBS Tables Used
[xxen_report_parameters_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameters_v), [xxen_report_parameters_link_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameters_link_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Report LOV Comparison between environments](/Blitz%20Report%20LOV%20Comparison%20between%20environments/ "Blitz Report LOV Comparison between environments Oracle EBS SQL Report"), [Blitz Report Parameter Table Alias Validation](/Blitz%20Report%20Parameter%20Table%20Alias%20Validation/ "Blitz Report Parameter Table Alias Validation Oracle EBS SQL Report"), [Blitz Report Parameter Bind Variable Validation](/Blitz%20Report%20Parameter%20Bind%20Variable%20Validation/ "Blitz Report Parameter Bind Variable Validation Oracle EBS SQL Report"), [Blitz Report Parameter Comparison between environments](/Blitz%20Report%20Parameter%20Comparison%20between%20environments/ "Blitz Report Parameter Comparison between environments Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [Blitz Report Comparison between environments](/Blitz%20Report%20Comparison%20between%20environments/ "Blitz Report Comparison between environments Oracle EBS SQL Report"), [Blitz Report Parameter Comparison between reports](/Blitz%20Report%20Parameter%20Comparison%20between%20reports/ "Blitz Report Parameter Comparison between reports Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/blitz-report-parameter-link-validation/) |
| Blitz Report™ XML Import | [Blitz_Report_Parameter_Link_Validation.xml](https://www.enginatics.com/xml/blitz-report-parameter-link-validation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-parameter-link-validation/](https://www.enginatics.com/reports/blitz-report-parameter-link-validation/) |



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
