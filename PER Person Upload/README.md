---
layout: default
last_modified_at: 2026-10-19
title: 'PER Person Upload | Oracle EBS SQL Report'
description: 'Upload to create and update people as in the People form (Combined Person and Assignment form, People window): employees, contingent workers and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, PER, Person, fnd_territories_vl, fnd_languages_vl, per_business_groups'
permalink: /PER%20Person%20Upload/
report_name: 'PER Person Upload'
report_web_name: per-person-upload
---

# PER Person Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-person-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload).

## Overview
Upload to create and update people as in the People form (Combined Person and Assignment form, People window): employees, contingent workers and applicants, their personal details, Further Person Information and Additional Personal Details flexfields.

A new person is created with hr_employee_api, hr_contingent_worker_api or hr_applicant_api depending on the system type of the Person Type. The Latest Start Date is the hire, placement or application date, and the API creates the default primary assignment in the business group. Use the PER Person Assignment Upload for the assignment details.

Person details are changed as of the Effective Date. When Datetrack Mode is blank, the record is corrected if the Effective Date is its start date, and otherwise a change is inserted from the Effective Date (Update, or Update - Insert when later changes exist).

Entering a Termination Date terminates an employee (with the Final Process Date if given) or ends a contingent worker placement. Changing the Person Type of an ex-employee to an employee person type rehires the employee on the Latest Start Date.

Existing people are matched by the hidden person id when downloaded, otherwise by Person Number: the employee number, contingent worker number or applicant number according to the Person Type.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Business Group, Effective Date, Person Type, Person Number, Full Name like, Organization

## Oracle EBS Tables Used
[fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload), [fnd_languages_vl](https://www.enginatics.com/library/?pg=1&find=fnd_languages_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload), [per_person_type_usages_f](https://www.enginatics.com/library/?pg=1&find=per_person_type_usages_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload), [per_person_types](https://www.enginatics.com/library/?pg=1&find=per_person_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload), [per_person_types_tl](https://www.enginatics.com/library/?pg=1&find=per_person_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload), [per_periods_of_service](https://www.enginatics.com/library/?pg=1&find=per_periods_of_service&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload), [per_periods_of_placement](https://www.enginatics.com/library/?pg=1&find=per_periods_of_placement&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload)

## Related Reports
[AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report"), [GL Journals](/GL%20Journals/ "GL Journals Oracle EBS SQL Report"), [GL Journals (Drilldown) 11g](/GL%20Journals%20%28Drilldown%29%2011g/ "GL Journals (Drilldown) 11g Oracle EBS SQL Report"), [PER Employee Assignments](/PER%20Employee%20Assignments/ "PER Employee Assignments Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [PER Payroll Element Entry Upload](/PER%20Payroll%20Element%20Entry%20Upload/ "PER Payroll Element Entry Upload Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Person%20Upload/PER%20Person%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/per-person-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload) |
| Blitz Report™ XML Import | [PER_Person_Upload.xml](https://www.enginatics.com/xml/per-person-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload) |
| SQL Source | [PER Person Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Person%20Upload/PER%20Person%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/per-person-upload/](https://www.enginatics.com/reports/per-person-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload) |

## Case Study & Technical Analysis: PER Person Upload

### Executive Summary
The PER Person Upload is a Blitz Report upload that creates and updates people in Oracle Human Resources, using the People window of the Combined Person and Assignment form. It covers employees, contingent workers and applicants, with their personal details, national identifier, contact data and the Further Person Information and Additional Personal Details flexfields. HR administrators use it to load new hires, maintain personal records across many people, and record terminations and rehires. The upload applies the same HR person APIs as the form, so each change is validated and dated as it would be in the application. The workflow runs in Excel through Blitz Report.

### Business Challenge
*   **High-volume onboarding:** New employees, contingent workers and applicants must be created with the right person type and start date before payroll and assignments can be set up.
*   **Personal data maintenance:** Names, addresses, nationality, marital status and contact details change over time, and each change must be effective on a specific date.
*   **Termination and rehire:** Leavers must be terminated with a final process date and a reason, and former staff who return must be rehired without losing their history.
*   **Identifier accuracy:** People must be matched correctly, by person ID or by the employee, contingent worker or applicant number that applies to their person type.

### The Solution
*   **Person type driven APIs:** New people are created through the employee, contingent worker or applicant API, depending on the system type of the chosen person type.
*   **Datetrack handling:** Changes are dated by the Effective Date. A correction is applied if the effective date is the record start date, and otherwise a new change is inserted from that date.
*   **Termination mapping:** An entered termination date terminates an employee with an optional final process date, or ends a contingent worker placement.
*   **Rehire rule:** Changing the person type of an ex-employee to an employee type rehires the employee on the latest start date.

### Technical Architecture (High Level)
#### Primary Tables
*   `PER_ALL_PEOPLE_F`: the person record, with name, identifiers, personal details, contact details and the person flexfield values, dated by effective start and end dates.
*   `PER_BUSINESS_GROUPS`: the business group that owns the person.
*   `PER_PERSON_TYPE_USAGES_F`: the person type assigned to the person over time.
*   `PER_PERSON_TYPES` and `PER_PERSON_TYPES_TL`: the person type system code and its user name.
*   `PER_PERIODS_OF_SERVICE`: the employee service period, with the start, actual termination and final process dates.
*   `PER_PERIODS_OF_PLACEMENT`: the contingent worker placement period.
*   `FND_TERRITORIES_VL`: the country of birth name.
*   `FND_LANGUAGES_VL`: the correspondence language name.

#### Logical Relationships
1.  `PER_BUSINESS_GROUPS` joins to `PER_ALL_PEOPLE_F` on the business group ID, and the person is taken as at the effective date.
2.  The person joins to an inline view that selects one person type usage per person, ranking employee, contingent worker, applicant and former types by a `DECODE` order with `KEEP (DENSE_RANK FIRST)`.
3.  That person type joins to `PER_PERSON_TYPES_TL` in the user's language, which supplies the person type name shown in the upload.
4.  The latest start date and termination details come from the most recent service period and the most recent placement period, each selected with `ROW_NUMBER` on the start date.
5.  The person number is chosen by person type, using the NPW number for contingent workers, the applicant number for applicants and the employee number otherwise.

### Parameters & Filtering
*   **Upload Mode:** selects the download or the create and update action.
*   **Business Group:** the business group whose people are reported.
*   **Effective Date:** the date at which the person records are read and the changes are dated.
*   **Person Type:** restricts the output to one person type.
*   **Person Number:** selects one person by employee, contingent worker or applicant number.
*   **Full Name like:** filters on part of the full name.
*   **Organization:** limits the output to people in one organization.

### Performance & Optimization
*   The person type inline view is grouped by person ID, so each person contributes one row before the main join.
*   The service and placement period inline views are filtered by business group and start date before the `ROW_NUMBER` ranking, which limits the rows that are ranked.
*   Country and language names are scalar lookups on primary codes, so no join multiplies the person rows.
*   Flexfield values are displayed through the `XXEN_UTIL` helpers, which keeps the main query to one pass over the person table.

### FAQ
**Q: How is an existing person matched when the file is uploaded?**
A: Downloaded rows carry a hidden person ID that is used for matching. Otherwise the person is matched by the person number that applies to the person type.

**Q: What does entering a termination date do?**
A: It terminates an employee, with the final process date if one is entered, or ends a contingent worker placement.

**Q: Where are assignment details maintained?**
A: The description states that assignment details are uploaded with the PER Person Assignment Upload report.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
