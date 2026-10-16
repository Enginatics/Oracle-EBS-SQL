---
layout: default
last_modified_at: 2026-10-16
title: 'PER Person Extra Information Upload 11i | Oracle EBS SQL Report'
description: 'Upload to create and update Person Extra Information Types (EITs) within Oracle HRMS - the People form > Others > Extra Information > Extra Person…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, PER, Person, Extra, Information, per_business_groups, per_all_people_f, per_people_extra_info'
permalink: /PER%20Person%20Extra%20Information%20Upload%2011i/
report_name: 'PER Person Extra Information Upload 11i'
report_web_name: per-person-extra-information-upload-11i
---

# PER Person Extra Information Upload 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-person-extra-information-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Business Group, Employee Number, Information Type

## Oracle EBS Tables Used
[per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i), [per_people_extra_info](https://www.enginatics.com/library/?pg=1&find=per_people_extra_info&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i), [fnd_descr_flex_contexts_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_contexts_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i)

## Related Reports
[PER Person Extra Information Upload](/PER%20Person%20Extra%20Information%20Upload/ "PER Person Extra Information Upload Oracle EBS SQL Report"), [FA Mass Additions Upload](/FA%20Mass%20Additions%20Upload/ "FA Mass Additions Upload Oracle EBS SQL Report"), [FA Mass Additions Upload 11i](/FA%20Mass%20Additions%20Upload%2011i/ "FA Mass Additions Upload 11i Oracle EBS SQL Report"), [PER Organization Upload](/PER%20Organization%20Upload/ "PER Organization Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Person%20Extra%20Information%20Upload%2011i/PER%20Person%20Extra%20Information%20Upload%2011i.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/per-person-extra-information-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i) |
| Blitz Report™ XML Import | [PER_Person_Extra_Information_Upload_11i.xml](https://www.enginatics.com/xml/per-person-extra-information-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i) |
| SQL Source | [PER Person Extra Information Upload 11i.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Person%20Extra%20Information%20Upload%2011i/PER%20Person%20Extra%20Information%20Upload%2011i.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/per-person-extra-information-upload-11i/](https://www.enginatics.com/reports/per-person-extra-information-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i) |

## Case Study & Technical Analysis: PER Person Extra Information Upload 11i

### Executive Summary
PER Person Extra Information Upload 11i creates and updates Person Extra Information records in Oracle HRMS, the extra information types that hold additional data about an employee or applicant beyond the standard person record. It mirrors the Extra Person Information window reached from the People form, and it covers every information type registered in the Extra Person Info flexfield. HR administrators and HRIS teams use it to load certifications, union or licence data, and other structured person information for many employees, using the same validation the form applies.

### Business Challenge
*   **Bulk Person Data:** Organizations with large workforces often hold information such as licences, certifications or yearly declarations that must be loaded for hundreds of people.
*   **Repeated Records:** One person can hold several records of the same type, such as one per year, and each must be maintained separately.
*   **Eligibility Rules:** An information type is available only to eligible people, and ineligible entries must be prevented before they are loaded.
*   **Value Set Compliance:** Segments validated against a value set must receive stored values, which are hard to recall for every type.

### The Solution
*   **Generic Information Columns:** The thirty information segments of each type are presented as columns, in the order of the type's flexfield segments.
*   **Existing Record Matching:** Existing records are matched by the hidden person extra information identifier, so repeated records of one type are updated correctly.
*   **Type Selection:** The Information Type parameter lists every enabled context of the Extra Person Info flexfield.
*   **Display Values:** Segment values are displayed through the flexfield value function, so the downloaded values match what the form shows.

### Technical Architecture (High Level)
#### Primary Tables
*   `PER_BUSINESS_GROUPS`: the business group that scopes the people selected.
*   `PER_ALL_PEOPLE_F`: the person records, with employee number and full name, effective on the current date.
*   `PER_PEOPLE_EXTRA_INFO`: the extra information records, with the information category and thirty information segments.
*   `FND_DESCR_FLEX_CONTEXTS_VL`: the flexfield contexts of the Extra Person Info flexfield, which supply the information type names.

#### Logical Relationships
1.  The business group in `PER_BUSINESS_GROUPS` is joined to the people in `PER_ALL_PEOPLE_F` on the business group identifier.
2.  People are restricted to records effective on the current date.
3.  Extra information records in `PER_PEOPLE_EXTRA_INFO` are joined to people on the person identifier.
4.  Each record's information category is matched to an enabled context of the Extra Person Info flexfield in `FND_DESCR_FLEX_CONTEXTS_VL`, which provides the information type name.
5.  Each information segment is decoded through the flexfield value function using the category and the segment column.

### Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update, which controls whether existing records are downloaded.
*   **Business Group:** Restricts the people to one business group. It is required.
*   **Employee Number:** Restricts the output to one employee.
*   **Information Type:** Restricts the records to one information type.

### Performance & Optimization
*   **Business Group Driven:** The business group filter is the first restriction on the people table, so the extract covers only one business group.
*   **Current Person Records:** Only person records effective today are read, which avoids duplicate rows from historical person changes.
*   **Enabled Contexts Only:** The flexfield context join keeps only enabled contexts, so disabled information types are not offered.
*   **Flexfield Decode Per Segment:** Display values are produced per segment by the value function, so the cost is proportional to the number of records and segments returned.

### FAQ
**Q: How do I add a second record of the same information type for one person?**
A: Create a new row with the same person and type and leave the hidden Person Extra Information ID blank. Existing records are matched by that identifier, not by person and type.

**Q: Why is the upload rejecting a row for an information type?**
A: The information type must be eligible for the person. The API rejects types the person is not eligible for.

**Q: Which value do I enter for a segment that is validated by a value set?**
A: Enter the stored value that the segment expects, as the description states.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-extra-information-upload-11i)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
