---
layout: default
last_modified_at: 2026-10-26
title: 'PER Previous Employment Upload | Oracle EBS SQL Report'
description: 'Upload to create, update and delete previous employment as in the Previous Employment window of the People form: previous employers with address, country…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, PER, Previous, Employment, fnd_territories_vl, per_previous_employers, per_previous_jobs'
permalink: /PER%20Previous%20Employment%20Upload/
report_name: 'PER Previous Employment Upload'
report_web_name: per-previous-employment-upload
---

# PER Previous Employment Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-previous-employment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload).

## Overview
Upload to create, update and delete previous employment as in the Previous Employment window of the People form: previous employers with address, country, type, period of service and the Additional Previous Employer Details flexfield, and the jobs held there with employee category, period and the Additional Previous Job Details flexfield.

Each row holds a previous employer and optionally one of its jobs; the employer columns repeat on every job row. A row is matched to an existing employer by the hidden id of a downloaded row, otherwise by employee, employer name and employer start date, and to an existing job by job name and start date within the employer.

The assignment usages of previous jobs (Assignment Details region) are not part of the upload.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Business Group, Employee Number, Employer like

## Oracle EBS Tables Used
[fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload), [per_previous_employers](https://www.enginatics.com/library/?pg=1&find=per_previous_employers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload), [per_previous_jobs](https://www.enginatics.com/library/?pg=1&find=per_previous_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload)

## Related Reports
[PER Person Upload](/PER%20Person%20Upload/ "PER Person Upload Oracle EBS SQL Report"), [PER Employee Assignments](/PER%20Employee%20Assignments/ "PER Employee Assignments Oracle EBS SQL Report"), [AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [PAY Employee Payroll History](/PAY%20Employee%20Payroll%20History/ "PAY Employee Payroll History Oracle EBS SQL Report"), [PO Approval History](/PO%20Approval%20History/ "PO Approval History Oracle EBS SQL Report"), [PER Person Assignment Upload](/PER%20Person%20Assignment%20Upload/ "PER Person Assignment Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Previous%20Employment%20Upload/PER%20Previous%20Employment%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/per-previous-employment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload) |
| Blitz Report™ XML Import | [PER_Previous_Employment_Upload.xml](https://www.enginatics.com/xml/per-previous-employment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload) |
| SQL Source | [PER Previous Employment Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Previous%20Employment%20Upload/PER%20Previous%20Employment%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/per-previous-employment-upload/](https://www.enginatics.com/reports/per-previous-employment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-previous-employment-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
