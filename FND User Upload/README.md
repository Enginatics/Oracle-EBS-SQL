---
layout: default
last_modified_at: 2026-10-26
title: 'FND User Upload | Oracle EBS SQL Report'
description: 'Listing and updating all EBS users and their responsiblities – Oracle E-Business Suite SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, FND, User, fnd_user, per_all_people_f, per_business_groups'
permalink: /FND%20User%20Upload/
report_name: 'FND User Upload'
report_web_name: fnd-user-upload
---

# FND User Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-user-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload).

## Overview
Listing and updating all EBS users and their responsiblities

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, User Name, Has Access to Responsibility, Has Access to Application, Active only, Creation Date From, Creation Date To, Created within days

## Oracle EBS Tables Used
[fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload), [fnd_application](https://www.enginatics.com/library/?pg=1&find=fnd_application&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload), [fnd_user_resp_groups_direct](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups_direct&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload)

## Related Reports
[AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [FND Users](/FND%20Users/ "FND Users Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20User%20Upload/FND%20User%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fnd-user-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload) |
| Blitz Report™ XML Import | [FND_User_Upload.xml](https://www.enginatics.com/xml/fnd-user-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload) |
| SQL Source | [FND User Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20User%20Upload/FND%20User%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-user-upload/](https://www.enginatics.com/reports/fnd-user-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload) |

## Executive Summary
The **FND User Upload** report is a dual-purpose tool: it provides a detailed extract of user and responsibility data, and it is designed to facilitate mass updates or creation of users via the Blitz Report Upload functionality.

## Business Challenge
Managing users in bulk is time-consuming. Tasks like "Create 50 new users for the training department" or "Add the 'GL Inquiry' responsibility to these 200 users" are tedious to perform manually in the Forms interface.

## The Solution
This report extracts user data in a format that can be modified in Excel and then uploaded back into Oracle EBS (using the Blitz Report Upload framework). It streamlines:
- Mass user creation.
- Mass assignment of responsibilities.
- Updating user attributes (email, description, etc.).

## Technical Architecture
The report queries `fnd_user` and `fnd_user_resp_groups_direct`. It is structured to align with the API parameters required for the user management APIs used by the upload process.

## Parameters & Filtering
- **Upload Mode:** Controls the behavior of the upload (e.g., Create, Update).
- **User Name:** Filter for specific users to extract/update.
- **Has Access to Responsibility:** Find users with a specific responsibility (useful for cloning access).

## Performance & Optimization
The report is optimized for data extraction. When used for uploading, performance depends on the volume of records being processed by the API.

## FAQ
**Q: Can I reset passwords with this?**
A: Yes, if the upload template and API support password updates, this can be used for bulk password resets (usually to a temporary password).

**Q: Does it validate the data?**
A: The upload process typically uses standard Oracle APIs which perform validation (e.g., checking if the responsibility name is valid).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
