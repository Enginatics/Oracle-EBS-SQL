---
layout: default
title: 'PER Person Extra Information Upload | Oracle EBS SQL Report'
description: 'Upload to create and update Person Extra Information Types (EITs) within Oracle HRMS - the People form > Others > Extra Information > Extra Person…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, PER, Person, Extra, Information, per_business_groups, per_all_people_f, per_people_extra_info'
permalink: /PER%20Person%20Extra%20Information%20Upload/
---

# PER Person Extra Information Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-person-extra-information-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Upload Mode, Business Group, Employee Number, Information Type

## Oracle EBS Tables Used
[per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [per_people_extra_info](https://www.enginatics.com/library/?pg=1&find=per_people_extra_info), [fnd_descr_flex_contexts_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_contexts_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[PER Organization Upload](/PER%20Organization%20Upload/ "PER Organization Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/per-person-extra-information-upload/) |
| Blitz Report™ XML Import | [PER_Person_Extra_Information_Upload.xml](https://www.enginatics.com/xml/per-person-extra-information-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/per-person-extra-information-upload/](https://www.enginatics.com/reports/per-person-extra-information-upload/) |



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
