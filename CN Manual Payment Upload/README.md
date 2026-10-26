---
layout: default
last_modified_at: 2026-10-26
title: 'CN Manual Payment Upload | Oracle EBS SQL Report'
description: 'Creates, updates and deletes Incentive Compensation manual payments - the Excel equivalent of the Manual Payments tab of the Paysheet Detail page…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Manual, Payment, cn_payment_transactions_all, cn_payruns_all, cn_period_statuses_all'
permalink: /CN%20Manual%20Payment%20Upload/
report_name: 'CN Manual Payment Upload'
report_web_name: cn-manual-payment-upload
---

# CN Manual Payment Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cn-manual-payment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload).

## Overview
Creates, updates and deletes Incentive Compensation manual payments - the Excel equivalent of the Manual Payments tab of the Paysheet Detail page (Payments, Payment Batches).

A manual payment adjusts a resource's paysheet in an unpaid payment batch for one plan element. The paysheet must already exist and must not be locked or submitted for approval. A recoverable payment is recovered from future earnings.

Each change writes the same system note on the paysheet as the Paysheet Detail page. Text entered in Reason is added as a user note on the paysheet, once per paysheet and text.

Existing manual payments are downloaded with Upload Mode Create, Update. Only the Payment Amount and Recoverable flag of an existing manual payment can be changed; to move it to another plan element, delete it and create a new one.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Payment Batch, Pay Period, Resource Name, Unpaid Batches Only

## Oracle EBS Tables Used
[cn_payment_transactions_all](https://www.enginatics.com/library/?pg=1&find=cn_payment_transactions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload), [cn_payruns_all](https://www.enginatics.com/library/?pg=1&find=cn_payruns_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload), [cn_period_statuses_all](https://www.enginatics.com/library/?pg=1&find=cn_period_statuses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload), [cn_quotas_all](https://www.enginatics.com/library/?pg=1&find=cn_quotas_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CN%20Manual%20Payment%20Upload/CN%20Manual%20Payment%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cn-manual-payment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload) |
| Blitz Report™ XML Import | [CN_Manual_Payment_Upload.xml](https://www.enginatics.com/xml/cn-manual-payment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload) |
| SQL Source | [CN Manual Payment Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CN%20Manual%20Payment%20Upload/CN%20Manual%20Payment%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cn-manual-payment-upload/](https://www.enginatics.com/reports/cn-manual-payment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cn-manual-payment-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
