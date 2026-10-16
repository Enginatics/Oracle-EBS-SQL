---
layout: default
last_modified_at: 2026-10-16
title: 'PER Person Extra Information Upload | Oracle EBS SQL Report'
description: 'Upload to create and update Person Extra Information Types (EITs) within Oracle HRMS - the People form > Others > Extra Information > Extra Person…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, PER, Person, Extra, Information, per_business_groups, per_all_people_f, per_people_extra_info'
permalink: /PER%20Person%20Extra%20Information%20Upload/
report_name: 'PER Person Extra Information Upload'
report_web_name: per-person-extra-information-upload
---

# PER Person Extra Information Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-person-extra-information-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload).

## Overview
Upload to create and update Person Extra Information Types (EITs) within Oracle HRMS - the People form > Others > Extra Information > Extra Person Information window.

Scope:
- Generic upload covering all person extra information types. The Information Type parameter/column lists every enabled context of the Extra Person Info DDF flexfield (titled Extra Person Information), which holds the registered EIT types.
- The segment values are loaded as raw Information 1..30 columns (pei_information1..30), matching the order of the information type's flexfield segments.
- Create new person extra information records and update existing ones (auto-detected by the hidden Person Extra Information ID downloaded in Create, Update mode).

Notes:
- A person can hold multiple records of the same information type (e.g. one per year), so existing rows are matched by the hidden Person Extra Information ID, not by person and type.
- The information type must be eligible for the person; ineligible types are rejected by the API.
- For information type segments validated against a value set, enter the stored value the segment expects.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Business Group, Employee Number, Information Type

## Oracle EBS Tables Used
[per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload), [per_people_extra_info](https://www.enginatics.com/library/?pg=1&find=per_people_extra_info&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload), [fnd_descr_flex_contexts_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_contexts_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload)

## Related Reports
[PER Person Extra Information Upload 11i](/PER%20Person%20Extra%20Information%20Upload%2011i/ "PER Person Extra Information Upload 11i Oracle EBS SQL Report"), [FA Mass Additions Upload](/FA%20Mass%20Additions%20Upload/ "FA Mass Additions Upload Oracle EBS SQL Report"), [FA Mass Additions Upload 11i](/FA%20Mass%20Additions%20Upload%2011i/ "FA Mass Additions Upload 11i Oracle EBS SQL Report"), [PER Organization Upload](/PER%20Organization%20Upload/ "PER Organization Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Person%20Extra%20Information%20Upload/PER%20Person%20Extra%20Information%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/per-person-extra-information-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload) |
| Blitz Report™ XML Import | [PER_Person_Extra_Information_Upload.xml](https://www.enginatics.com/xml/per-person-extra-information-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload) |
| SQL Source | [PER Person Extra Information Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Person%20Extra%20Information%20Upload/PER%20Person%20Extra%20Information%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/per-person-extra-information-upload/](https://www.enginatics.com/reports/per-person-extra-information-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload) |

## Case Study & Technical Analysis: PER Person Extra Information Upload

### Executive Summary
This upload maintains the Person Extra Information types (EITs) of Oracle Human Resources, the records held in the People form under Others, Extra Information, Extra Person Information. It downloads the existing extra information records of employees in a business group, and lets an HR administrator create new records and update existing ones in a spreadsheet, for any information type registered in the Extra Person Info flexfield. HR specialists use it to load certifications, licence details, language skills or other personal data that the business records for each employee, when the data comes from an external system or from an HR survey. Blitz Report™ provides the spreadsheet in which the segment values are entered.

### Business Challenge
*   **Bulk personal data:** Many employees need the same kind of extra information, such as a certification, and entering each record through the People form takes too long.
*   **Several records of one type:** A person can hold several records of the same type, for example one per year, so the existing rows must be identified correctly.
*   **Eligibility and value rules:** Each information type is eligible only for certain persons, and segments can be validated against value sets, so the entered values must follow those rules.
*   **Consistent layout:** The segments of each information type are stored in a fixed order, and the spreadsheet must present them in that order.

### The Solution
*   Downloads each extra information record of the employees in a business group, with the employee number, name, business group and information type.
*   Shows the Information 1 to Information 30 segments of each record, with their values resolved through the flexfield segment labels.
*   Keeps the Person Extra Information identifier on each row, so an updated row is matched to its existing record and not to the person and type.
*   Lists every enabled information type of the Extra Person Info flexfield, so a new record can be created for any eligible type.
*   Treats a row without a Person Extra Information identifier as a new record to create.

### Technical Architecture (High Level)
#### Primary Tables
*   `PER_BUSINESS_GROUPS`: the business group that the employees belong to.
*   `PER_ALL_PEOPLE_F`: the employee, with employee number and full name, effective on the run date.
*   `PER_PEOPLE_EXTRA_INFO`: the extra information records, with the information type category and the 30 information segments.
*   `FND_DESCR_FLEX_CONTEXTS_VL`: the contexts of the Extra Person Info flexfield, which are the registered information types.

#### Logical Relationships
1. `PER_BUSINESS_GROUPS` restricts the employees to the chosen business group.
2. `PER_ALL_PEOPLE_F` is joined to the business group, and limited to the person record effective on the run date.
3. `PER_PEOPLE_EXTRA_INFO` is joined to the employee on the person identifier.
4. The information type of each record is found in `FND_DESCR_FLEX_CONTEXTS_VL`, where the context code equals the information category of the record and the flexfield is the Extra Person Info flexfield of the Human Resources application.
5. Only enabled contexts are shown, so disabled information types do not appear.

### Parameters & Filtering
*   **Upload Mode:** selects create only, or create and update with existing records downloaded.
*   **Business Group:** limits the employees to one business group.
*   **Employee Number:** selects one employee.
*   **Information Type:** selects one registered information type.

### Performance & Optimization
*   The employee record is limited to the person version effective on the run date, so historical versions of each person are not returned.
*   The context lookup joins on the information category of each record and on enabled contexts only, so the value translation uses the matching flexfield context.
*   The segment values are translated through the flexfield display function for each of the 30 segments, using the row's own category.
*   Filtering by information type on download reduces the number of records and the flexfield translations performed.

### FAQ
**Q: Why do I need the Person Extra Information ID on each row?**
A: A person can hold several records of the same information type, so an update must identify the exact record. The ID does this; the person and type alone do not.

**Q: What value should I enter for a segment that uses a value set?**
A: Enter the stored value the segment expects, as the value set is validated when the record is created or updated.

**Q: Why is an information type missing from the Information Type list?**
A: Only enabled contexts of the Extra Person Info flexfield are listed, so a disabled information type does not appear.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
