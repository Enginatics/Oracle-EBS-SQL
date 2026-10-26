---
layout: default
last_modified_at: 2026-10-26
title: 'PER Job Upload | Oracle EBS SQL Report'
description: 'Upload to create and update jobs as in the Job window (Define Job): job group, name, dates, approval authority, additional employment rights, benchmark…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, PER, Job, per_job_groups, per_jobs_tl, per_jobs'
permalink: /PER%20Job%20Upload/
report_name: 'PER Job Upload'
report_web_name: per-job-upload
---

# PER Job Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-job-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload).

## Overview
Upload to create and update jobs as in the Job window (Define Job): job group, name, dates, approval authority, additional employment rights, benchmark job and the Additional Job Details flexfield.

A row whose Name does not exist in the job group creates the job. Name is the concatenated Job flexfield segments of the job group's structure; changing it on a downloaded row renames the job. End a job by entering its Date To.

Evaluation, requirements and valid grades of the Job window are not part of the upload.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Business Group, Job Group, Job, Active Jobs Only

## Oracle EBS Tables Used
[per_job_groups](https://www.enginatics.com/library/?pg=1&find=per_job_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload), [per_jobs_tl](https://www.enginatics.com/library/?pg=1&find=per_jobs_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload), [per_jobs](https://www.enginatics.com/library/?pg=1&find=per_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload)

## Related Reports
[PER Position Upload](/PER%20Position%20Upload/ "PER Position Upload Oracle EBS SQL Report"), [PER Employee Salary Change](/PER%20Employee%20Salary%20Change/ "PER Employee Salary Change Oracle EBS SQL Report"), [PER Previous Employment Upload](/PER%20Previous%20Employment%20Upload/ "PER Previous Employment Upload Oracle EBS SQL Report"), [PER Person Assignment Upload](/PER%20Person%20Assignment%20Upload/ "PER Person Assignment Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Job%20Upload/PER%20Job%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/per-job-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload) |
| Blitz Report™ XML Import | [PER_Job_Upload.xml](https://www.enginatics.com/xml/per-job-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload) |
| SQL Source | [PER Job Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Job%20Upload/PER%20Job%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/per-job-upload/](https://www.enginatics.com/reports/per-job-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-job-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
