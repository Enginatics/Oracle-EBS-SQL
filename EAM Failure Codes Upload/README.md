---
layout: default
title: 'EAM Failure Codes Upload | Oracle EBS SQL Report'
description: 'Create, update, and delete EAM failure codes, cause codes, and resolution codes. Upload Mode =========== Create ------ Opens an empty spreadsheet to…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, EAM, Failure, Codes, eam_failure_codes, eam_cause_codes, eam_resolution_codes'
permalink: /EAM%20Failure%20Codes%20Upload/
---

# EAM Failure Codes Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-failure-codes-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Create, update, and delete EAM failure codes, cause codes, and resolution codes.

Upload Mode
===========

Create
------
Opens an empty spreadsheet to define new codes.

Create, Update
--------------
Downloads existing codes for review and modification, and allows adding new rows.

Code Type
=========
Determines which of the three code tables is affected:
- Failure Code   (stored in eam_failure_codes)
- Cause Code     (stored in eam_cause_codes)
- Resolution Code (stored in eam_resolution_codes)

Codes are global - not scoped to any operating unit.

Fields
======
- Code Type: Required. Failure Code, Cause Code, or Resolution Code.
- Code: Required. Unique within its code type.
- Description: Optional.
- Effective End Date: Optional. Blank to keep the code active; set to reactivate an end-dated code.
- Delete Record: Optional. Set to Yes to delete an existing code.

## Report Parameters
Upload Mode, Code Type

## Oracle EBS Tables Used
[eam_failure_codes](https://www.enginatics.com/library/?pg=1&find=eam_failure_codes), [eam_cause_codes](https://www.enginatics.com/library/?pg=1&find=eam_cause_codes), [eam_resolution_codes](https://www.enginatics.com/library/?pg=1&find=eam_resolution_codes)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [EAM Failure Sets Upload](/EAM%20Failure%20Sets%20Upload/ "EAM Failure Sets Upload Oracle EBS SQL Report"), [EAM Assets](/EAM%20Assets/ "EAM Assets Oracle EBS SQL Report"), [BOM Standard Operations Upload](/BOM%20Standard%20Operations%20Upload/ "BOM Standard Operations Upload Oracle EBS SQL Report"), [EAM Weekly Schedule](/EAM%20Weekly%20Schedule/ "EAM Weekly Schedule Oracle EBS SQL Report"), [EAM Asset Activity Association Upload](/EAM%20Asset%20Activity%20Association%20Upload/ "EAM Asset Activity Association Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/eam-failure-codes-upload/) |
| Blitz Report™ XML Import | [EAM_Failure_Codes_Upload.xml](https://www.enginatics.com/xml/eam-failure-codes-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/eam-failure-codes-upload/](https://www.enginatics.com/reports/eam-failure-codes-upload/) |



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
