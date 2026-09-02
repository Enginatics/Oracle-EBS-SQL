---
layout: default
title: 'QP GSA Pricing Upload | Oracle EBS SQL Report'
description: 'This upload supports the creation and update of GSA Pricing Setup in Oracle Advanced Pricing. The upload supports creation/update/deletion of the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, GSA, Pricing, qp_secu_list_headers_vl, qp_qualifiers_v, qp_modifier_summary_v'
permalink: /QP%20GSA%20Pricing%20Upload/
---

# QP GSA Pricing Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qp-gsa-pricing-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This upload supports the creation and update of GSA Pricing Setup in Oracle Advanced Pricing.

The upload supports creation/update/deletion of the following entities within a GSA Pricing List:

- GSA Lists (created as a Modifier List)
- GSA List Qualifiers (created as a Modifier List Qualifier)
- GSA List Lines (created as Modifier Lines)

Notes:

When downloading existing GSA Lists into the upload excel; the List level Qualifiers and the List Lines will be downloaded into separate rows in the excel. This is to minimize the duplication of data in the excel.  

However:
When entering List Header qualifiers, these can be added in the same excel row as the List Lines (i.e. You can upload an excel row containing list line details and a list header qualifier). 

Modifier Line Numbering
====================
The Modifier Numbering report parameter determines if you want the system to automatically generate Modifier Numbers when creating new GSA List Lines or if the line number specified in the Line No column in the upload should be retained. If Automatic is specified, any Line Numbers specified in the upload excel for new GSA List Lines will be replaced by a system generated line number on upload.
The Line No column is required when entering list line details. The upload uses the combination of List Number, List Version, and Line No to identify the GSA List Line. If the combination already exists in Oracle the upload will update the existing GSA List Line, otherwise it will create a new GSA List Line.


## Report Parameters
Upload Mode, End Date Matching Modifiers?, Modifier Numbering, List Number, List Number Like, List Name, List Name Like, Version Number, Global List, Operating Unit, Product Value (Item), Item Category Set, Item Category, Effective Date, Download Modifier Lines, Download List Qualifiers

## Oracle EBS Tables Used
[qp_secu_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_secu_list_headers_vl), [qp_qualifiers_v](https://www.enginatics.com/library/?pg=1&find=qp_qualifiers_v), [qp_modifier_summary_v](https://www.enginatics.com/library/?pg=1&find=qp_modifier_summary_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/qp-gsa-pricing-upload/) |
| Blitz Report™ XML Import | [QP_GSA_Pricing_Upload.xml](https://www.enginatics.com/xml/qp-gsa-pricing-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qp-gsa-pricing-upload/](https://www.enginatics.com/reports/qp-gsa-pricing-upload/) |



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
