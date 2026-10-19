---
layout: default
last_modified_at: 2026-10-19
title: 'CE Bank and Branch Upload | Oracle EBS SQL Report'
description: 'CE Bank and Branch Upload ========================== Creates or updates banks and bank branches in Oracle Cash Management (CE) using the cebankpub API…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Bank, Branch, fnd_territories_vl, ce_bank_branches_v, hz_parties'
permalink: /CE%20Bank%20and%20Branch%20Upload/
report_name: 'CE Bank and Branch Upload'
report_web_name: ce-bank-and-branch-upload
---

# CE Bank and Branch Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-bank-and-branch-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode

## Oracle EBS Tables Used
[fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload)

## Related Reports
[AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [AR Unapplied Receipts Register](/AR%20Unapplied%20Receipts%20Register/ "AR Unapplied Receipts Register Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [AP Accounted Invoice Aging](/AP%20Accounted%20Invoice%20Aging/ "AP Accounted Invoice Aging Oracle EBS SQL Report"), [AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [CE Cleared Transactions](/CE%20Cleared%20Transactions/ "CE Cleared Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CE%20Bank%20and%20Branch%20Upload/CE%20Bank%20and%20Branch%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ce-bank-and-branch-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload) |
| Blitz Report™ XML Import | [CE_Bank_and_Branch_Upload.xml](https://www.enginatics.com/xml/ce-bank-and-branch-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload) |
| SQL Source | [CE Bank and Branch Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CE%20Bank%20and%20Branch%20Upload/CE%20Bank%20and%20Branch%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ce-bank-and-branch-upload/](https://www.enginatics.com/reports/ce-bank-and-branch-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload) |

## Case Study & Technical Analysis: CE Bank and Branch Upload

### Executive Summary
The CE Bank and Branch Upload is a spreadsheet-driven maintenance tool for banks and bank branches in Oracle Cash Management. It is written for treasury administrators and implementation teams who must set up or correct the bank master data behind bank accounts, payments and reconciliation. Each row represents one bank branch, and the upload creates a bank automatically when it does not exist. It creates or updates the branch within that bank through the Cash Management bank public API, which is TCA based. The report runs in the Cash Management module and is restricted to R12.

### Business Challenge
*   **Bulk bank setup:** Implementations often need hundreds of banks and branches loaded, and entering them through the form one at a time is slow and error prone.
*   **Consistent identification:** Banks and branches must be recognised consistently across uploads, so that re-running a file updates rows rather than creating duplicates.
*   **Routing and identifier data:** Routing numbers, BIC or SWIFT codes, EFT numbers and branch types must be captured correctly for payments and electronic transfers.
*   **Extended bank attributes:** Descriptive flexfield values on the bank and branch parties must be loaded alongside the core data.

### The Solution
*   **Create or update in one file:** Create mode opens an empty spreadsheet for new entries, and Create, Update mode returns the existing bank branches for editing and re-upload.
*   **Matching rules:** A bank is matched by country and bank name, with the bank number used where it is provided. A branch is matched by bank and branch name within that bank.
*   **Creation on demand:** If no matching bank is found, the bank is created, and the branch is then created within it.
*   **Bank fields applied once:** Short and alternate bank names are applied only on bank creation, so later uploads do not overwrite them.
*   **Flexfield columns:** The branch and bank party descriptive flexfield attributes are included as separate columns, so they are downloaded and uploaded with the rest of the row.

### Technical Architecture (High Level)
#### Primary Tables
*   `CE_BANK_BRANCHES_V`: the view of banks and their branches, supplying the bank name, number, branch name, branch type, BIC or SWIFT code, EFT number and descriptions.
*   `HZ_PARTIES`: the party records for the branch and for the bank. The report joins it twice, once for each party.
*   `FND_TERRITORIES_VL`: the territory names used to translate the bank home country code into a country name.

#### Logical Relationships
1. `CE_BANK_BRANCHES_V` joins to `HZ_PARTIES` on the branch party identifier, which provides the branch descriptive flexfield attributes.
2. `CE_BANK_BRANCHES_V` joins to `HZ_PARTIES` again on the bank party identifier, which provides the bank descriptive flexfield attributes under bank-prefixed column names.
3. The country name is derived by a scalar subquery on `FND_TERRITORIES_VL` using the bank home country code.
4. The result has one row per branch, so the bank's descriptive fields appear on each branch row.

### Parameters & Filtering
*   **Upload Mode:** Chooses between Create, which returns an empty template for new entries, and Create, Update, which returns the existing bank branches for amendment. The SQL retrieves all branches in both cases, so the mode governs the purpose of the file rather than a predicate in the query.

The report has no other user parameter. Narrowing the existing data is therefore done in the spreadsheet, and the bank and branch identifiers are the keys used when the file is uploaded.

### Performance & Optimization
*   **Branch-driven query:** The query starts from `CE_BANK_BRANCHES_V`, so the number of rows returned equals the number of bank branches in the instance.
*   **Two party joins:** Bank and branch party records are joined on their identifiers, which avoids any correlated lookup for the descriptive flexfield values.
*   **Upload-side validation:** The description notes that country-specific routing number format validation is bypassed to allow loading data across all countries. This is a behaviour of the upload API, not of the query.

### FAQ
**Q: How do I add a new bank and branch to Oracle Cash Management in bulk?**
A: Run CE Bank and Branch Upload in Create mode, enter the country, bank name and branch name for each row, and upload the file.

**Q: What happens if a bank already exists when I upload a branch for it?**
A: The bank is matched by country and bank name, with the bank number used where supplied. The branch is then created or updated within the existing bank.

**Q: Are the short bank name and alternate bank name updated on later uploads?**
A: No. The description states that these bank fields are applied only when the bank is created, not when it is updated.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-and-branch-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
