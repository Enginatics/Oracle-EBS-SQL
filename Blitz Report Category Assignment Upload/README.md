---
layout: default
title: 'Blitz Report Category Assignment Upload | Oracle EBS SQL Report'
description: 'Upload to maintain Blitz Report category assignments - the categories that reports and uploads are grouped under. Run modes: - Create with ''Create Empty…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Blitz, Report, Category, Assignment, xxen_reports_v, xxen_report_category_assigns_v'
permalink: /Blitz%20Report%20Category%20Assignment%20Upload/
---

# Blitz Report Category Assignment Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-category-assignment-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Upload to maintain Blitz Report category assignments - the categories that reports and uploads are grouped under.

Run modes:

- Create with 'Create Empty File' = Yes: opens an empty Excel file to enter new report and category rows.

- Create with 'Create Empty File' = blank: queries a list of reports (by name, category or type) as blank rows to assign categories to.

- Create, Update: queries existing category assignments, which can be removed by setting the Delete column to Yes.

Enter any Category name. If the category does not exist yet, it is created automatically in all installed languages and the report is assigned to it. Set Delete = Yes to remove a report from a category; the category itself is kept even if it becomes empty.

## Report Parameters
Upload Mode, Create Empty File, Report Name starts with, Report Category, Report Type

## Oracle EBS Tables Used
[xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v), [xxen_report_category_assigns_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_category_assigns_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[Blitz Report Parameter Table Alias Validation](/Blitz%20Report%20Parameter%20Table%20Alias%20Validation/ "Blitz Report Parameter Table Alias Validation Oracle EBS SQL Report"), [Blitz Report Category Assignments](/Blitz%20Report%20Category%20Assignments/ "Blitz Report Category Assignments Oracle EBS SQL Report"), [Blitz Report Default Templates](/Blitz%20Report%20Default%20Templates/ "Blitz Report Default Templates Oracle EBS SQL Report"), [Blitz Report Comparison between environments](/Blitz%20Report%20Comparison%20between%20environments/ "Blitz Report Comparison between environments Oracle EBS SQL Report"), [Blitz Report RDF Import Validation](/Blitz%20Report%20RDF%20Import%20Validation/ "Blitz Report RDF Import Validation Oracle EBS SQL Report"), [Blitz Upload Dependencies](/Blitz%20Upload%20Dependencies/ "Blitz Upload Dependencies Oracle EBS SQL Report"), [Blitz Report Assignment Upload](/Blitz%20Report%20Assignment%20Upload/ "Blitz Report Assignment Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/blitz-report-category-assignment-upload/) |
| Blitz Report™ XML Import | [Blitz_Report_Category_Assignment_Upload.xml](https://www.enginatics.com/xml/blitz-report-category-assignment-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-category-assignment-upload/](https://www.enginatics.com/reports/blitz-report-category-assignment-upload/) |



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
