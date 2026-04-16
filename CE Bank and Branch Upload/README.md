---
layout: default
title: 'CE Bank and Branch Upload | Oracle EBS SQL Report'
description: 'CE Bank and Branch Upload ========================== Creates or updates banks and bank branches in Oracle Cash Management (CE) using the cebankpub API…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Bank, Branch, fnd_territories_vl, ce_bank_branches_v, hz_parties'
permalink: /CE%20Bank%20and%20Branch%20Upload/
---

# CE Bank and Branch Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-bank-and-branch-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
CE Bank and Branch Upload
==========================
Creates or updates banks and bank branches in Oracle Cash Management (CE) using the ce_bank_pub API (TCA-based).

Each row represents one bank branch. If the bank does not exist it is created automatically. The branch is then created or updated within that bank.

Upload Mode
===========

Create
------
Opens an empty spreadsheet to enter new banks and branches.

Create, Update
--------------
Returns existing bank branches. Edit fields and re-upload to update.

Required Fields
===============
- Country: Country of the bank (e.g. United States, Australia).
- Bank Name: Name of the bank. Used together with Country to identify an existing bank.
- Branch Name: Name of the branch. Used together with Bank Name and Country to identify an existing branch.

Optional Fields
===============
- Bank Number: Routing or institution number for the bank.
- Short Bank Name: Abbreviated bank name.
- Alternate Bank Name: Phonetic or alternate-language bank name.
- Branch Number: Branch routing or BSB number.
- Branch Type: Routing/clearing type. Options: ABA, CHIPS, SWIFT, Other. Leave blank if not applicable.
- BIC / SWIFT Code: Bank Identifier Code (ISO 9362).
- EFT Number: Electronic Funds Transfer user number.
- Alternate Branch Name: Phonetic or alternate-language branch name.
- Description: Free text description of the branch.
- DFF Columns (Attribute Category, Attribute 1-24): Descriptive Flexfield segments on the branch party (HZ_PARTIES).

Notes
=====
- Bank is matched by Country + Bank Name (+ Bank Number if provided). If no match is found, a new bank is created.
- Branch is matched by Bank + Branch Name. If no match is found, a new branch is created within the bank.
- Bank fields (Short Bank Name, Alternate Bank Name) are only applied on bank creation, not on update.
- Country-specific routing number format validation is bypassed to allow loading data across all countries.

## Report Parameters
Upload Mode

## Oracle EBS Tables Used
[fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [AP Accounted Invoice Aging](/AP%20Accounted%20Invoice%20Aging/ "AP Accounted Invoice Aging Oracle EBS SQL Report"), [AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ce-bank-and-branch-upload/) |
| Blitz Report™ XML Import | [CE_Bank_and_Branch_Upload.xml](https://www.enginatics.com/xml/ce-bank-and-branch-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ce-bank-and-branch-upload/](https://www.enginatics.com/reports/ce-bank-and-branch-upload/) |



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
