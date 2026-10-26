---
layout: default
last_modified_at: 2026-10-26
title: 'PER Payroll Element Link Upload | Oracle EBS SQL Report'
description: 'Upload to create, update and end date element links as in the Element Link form: the element, the eligibility criteria (organization, job, position…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, PER, Payroll, Element, Link, pay_element_classifications_vl, pay_element_links_f, hr_all_organization_units_vl'
permalink: /PER%20Payroll%20Element%20Link%20Upload/
report_name: 'PER Payroll Element Link Upload'
report_web_name: per-payroll-element-link-upload
---

# PER Payroll Element Link Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-payroll-element-link-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload).

## Overview
Upload to create, update and end date element links as in the Element Link form: the element, the eligibility criteria (organization, job, position, grade, people group, location, salary basis, employment category, payroll or all payrolls), standard link, costing, qualifying conditions and the Further Information flexfield.

Changes are made as of the Effective Date. When Datetrack Mode is blank, the link is corrected if the Effective Date is the start date of its current record, and otherwise a change is inserted from the Effective Date (Update, or Update - Insert when later changes exist).

The element and the eligibility criteria of an existing link cannot be changed, as in the form. A new row with the criteria of an existing link of the element updates that link. Entering an End Date end dates the link on that date, clearing it removes the end date.

Costing and Balancing take the segment values the form shows (segments enabled for the Element and Balancing levels), separated by the flexfield delimiter. People Group takes the concatenated segment values. New combinations are created as needed.

Link input values are not maintained by this upload.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Business Group, Effective Date, Element Name, Classification, Organization, Payroll, Costable Type

## Oracle EBS Tables Used
[pay_element_classifications_vl](https://www.enginatics.com/library/?pg=1&find=pay_element_classifications_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [pay_element_links_f](https://www.enginatics.com/library/?pg=1&find=pay_element_links_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [per_jobs_vl](https://www.enginatics.com/library/?pg=1&find=per_jobs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [hr_positions_f](https://www.enginatics.com/library/?pg=1&find=hr_positions_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [per_grades_vl](https://www.enginatics.com/library/?pg=1&find=per_grades_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [pay_people_groups](https://www.enginatics.com/library/?pg=1&find=pay_people_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [hr_locations_all_vl](https://www.enginatics.com/library/?pg=1&find=hr_locations_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [per_pay_bases](https://www.enginatics.com/library/?pg=1&find=per_pay_bases&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [pay_all_payrolls_f](https://www.enginatics.com/library/?pg=1&find=pay_all_payrolls_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [pay_element_sets](https://www.enginatics.com/library/?pg=1&find=pay_element_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [pay_element_types_f_vl](https://www.enginatics.com/library/?pg=1&find=pay_element_types_f_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload)

## Related Reports
[PER Person Assignment Upload](/PER%20Person%20Assignment%20Upload/ "PER Person Assignment Upload Oracle EBS SQL Report"), [PER Position Upload](/PER%20Position%20Upload/ "PER Position Upload Oracle EBS SQL Report"), [PER Employee Assignments](/PER%20Employee%20Assignments/ "PER Employee Assignments Oracle EBS SQL Report"), [PAY Gross to Net Summary](/PAY%20Gross%20to%20Net%20Summary/ "PAY Gross to Net Summary Oracle EBS SQL Report"), [PER Terminations and Separations](/PER%20Terminations%20and%20Separations/ "PER Terminations and Separations Oracle EBS SQL Report"), [PER New Hires](/PER%20New%20Hires/ "PER New Hires Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Payroll%20Element%20Link%20Upload/PER%20Payroll%20Element%20Link%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/per-payroll-element-link-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload) |
| Blitz Report™ XML Import | [PER_Payroll_Element_Link_Upload.xml](https://www.enginatics.com/xml/per-payroll-element-link-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload) |
| SQL Source | [PER Payroll Element Link Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Payroll%20Element%20Link%20Upload/PER%20Payroll%20Element%20Link%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/per-payroll-element-link-upload/](https://www.enginatics.com/reports/per-payroll-element-link-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-payroll-element-link-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
