---
layout: default
title: 'Blitz Report Assignment Validation | Oracle EBS SQL Report'
description: 'Lists every Blitz Report with the number of assignments it has at each assignment level, so you can validate that all reports are assigned. Each level…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Assignment, Validation, xxen_reports_v, xxen_report_assignments'
permalink: /Blitz%20Report%20Assignment%20Validation/
---

# Blitz Report Assignment Validation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-assignment-validation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists every Blitz Report with the number of assignments it has at each assignment level, so you can validate that all reports are assigned.

Each level column counts the distinct included assignment targets at that level (Site, Application, Request Group, Responsibility, User, Form, Function, Report). The Excluded column counts exclusion assignments. The zero_to_null function leaves a blank cell where there is no assignment, so reports missing an assignment stand out at a glance - a row that is completely blank across the assignment columns is not assigned to anyone.

Use the Category, Not in Category and Type parameters to limit the scope. Set 'Not Assigned Only' to Yes to list only reports that have no include assignment at any level, or pick a level in 'Not Assigned at Level' to find reports missing an assignment at one specific level.

## Report Parameters
Category, Not in Category, Type, Disabled, Not Assigned Only, Not Assigned at Level

## Oracle EBS Tables Used
[xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v), [xxen_report_assignments](https://www.enginatics.com/library/?pg=1&find=xxen_report_assignments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Report Assignment Upload](/Blitz%20Report%20Assignment%20Upload/ "Blitz Report Assignment Upload Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [Blitz Report Assignments](/Blitz%20Report%20Assignments/ "Blitz Report Assignments Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report Security](/Blitz%20Report%20Security/ "Blitz Report Security Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/blitz-report-assignment-validation/) |
| Blitz Report™ XML Import | [Blitz_Report_Assignment_Validation.xml](https://www.enginatics.com/xml/blitz-report-assignment-validation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-assignment-validation/](https://www.enginatics.com/reports/blitz-report-assignment-validation/) |



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
