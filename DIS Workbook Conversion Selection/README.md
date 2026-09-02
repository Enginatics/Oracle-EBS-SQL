---
layout: default
title: 'DIS Workbook Conversion Selection | Oracle EBS SQL Report'
description: 'Lists the Discoverer workbook xmls uploaded to Blitz Report (Setup>Tools>Import>XML Upload), enriched with information supporting the decision which…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, DIS, Workbook, Conversion, Selection, xxen_discoverer_workbook_xmls, eul5_documents, eul5_qpp_stats'
permalink: /DIS%20Workbook%20Conversion%20Selection/
---

# DIS Workbook Conversion Selection – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-workbook-conversion-selection/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists the Discoverer workbook xmls uploaded to Blitz Report (Setup>Tools>Import>XML Upload), enriched with information supporting the decision which workbooks to convert: latest run date, run count and distinct users from the end user layer's usage statistics, last update and creation date from the workbook definition, owner, description and sheet count.

Set Convert Workbook to Yes for each workbook that should be converted to Blitz Report and upload the file. The selection is stored on the staged workbook xml, and the 'Blitz Report Discoverer Import' concurrent program converts the selected workbooks.

With the Submit Import parameter set to Yes, the upload submits the 'Blitz Report Discoverer Import' itself after storing the selection, waits for it to complete, and reports per workbook how many Blitz reports and templates exist for its worksheets. A workbook whose worksheet folder sets could not all be converted is reported as an error row.

The usage statistics are informational only: workbooks without any usage history are listed as well, with an empty run count and last run date.

The migration process is described in the following link: <a href="https://www.enginatics.com/blog/discoverer-replacement-with-blitz-report/" rel="nofollow" target="_blank">https://www.enginatics.com/blog/discoverer-replacement-with-blitz-report/</a>

## Report Parameters
Upload Mode, End User Layer, Workbook, Workbook Id, Submit Import, Report Name Prefix

## Oracle EBS Tables Used
[xxen_discoverer_workbook_xmls](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbook_xmls), [eul5_documents](https://www.enginatics.com/library/?pg=1&find=eul5_documents), [eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats), [xxen_discoverer_sheets](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_sheets), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Converter Diagnostic Dump](/DIS%20Converter%20Diagnostic%20Dump/ "DIS Converter Diagnostic Dump Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [DIS Worksheet SQLs](/DIS%20Worksheet%20SQLs/ "DIS Worksheet SQLs Oracle EBS SQL Report"), [DIS Discoverer and Blitz Report Users](/DIS%20Discoverer%20and%20Blitz%20Report%20Users/ "DIS Discoverer and Blitz Report Users Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/dis-workbook-conversion-selection/) |
| Blitz Report™ XML Import | [DIS_Workbook_Conversion_Selection.xml](https://www.enginatics.com/xml/dis-workbook-conversion-selection/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-workbook-conversion-selection/](https://www.enginatics.com/reports/dis-workbook-conversion-selection/) |



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
