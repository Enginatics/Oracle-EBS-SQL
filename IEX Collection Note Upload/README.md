---
layout: default
last_modified_at: 2026-10-16
title: 'IEX Collection Note Upload | Oracle EBS SQL Report'
description: 'Creates and updates Collection Notes in Oracle Collections (IEX) - the same notes shown in the Collections work area. Each note is attached at a single…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, IEX, Collection, Note, hz_cust_accounts, hz_cust_site_uses_all, hz_cust_acct_sites_all'
permalink: /IEX%20Collection%20Note%20Upload/
report_name: 'IEX Collection Note Upload'
report_web_name: iex-collection-note-upload
---

# IEX Collection Note Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/iex-collection-note-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload).

## Overview
Creates and updates Collection Notes in Oracle Collections (IEX)  - the same notes shown in the Collections work area.

Each note is attached at a single Note Level: Customer (party), Account, Bill To, or Collections Transaction.

The Note column is limited to 2,000 characters. The upload will reject the row if the note exceeds this.
The Note Detail column is limited to 4,000 characters. Note details exceeding this will be truncated.

Party Level Notes:
Pary Name is required
Party Number is required only when the Party Name is not unique.

Account Level Notes:
Party Name and Account Number are required.

Bill To Level Notes:
Party Name, Account Number and Bill To Location are required .
Operating Unit is optional unless the same Bill To Location (code) is used across accessible Operating Units.
Bill to Address is informational only.

Transaction Level Notes:
Party Name, Account Number, Transaction Number are required.
Bill To Site and Operating Unit are only required if the same transaction number exists across different accessible Bill To Sites/Operating Units.
Installment is optional unless the Transaction has muliple Installments, in which case it must be specified.

Unpaid Reason applies to Transaction level notes only. Oracle Collections holds it on the transaction's delinquency rather than on the note, so it applies to every note on that transaction.
Delinquency Status shows whether the transaction is already delinquent. When it is blank, set Create Delinquency to Yes to create a delinquency with status Current, as the Collections form asks.
Unpaid Reason and Create Delinquency can only be set when the note is created.

Only the Note Type, Note Status and descriptive flexfield attributes can be changed on an existing note; the note text and its target are read only. Download notes in Create, Update mode to reclassify them.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Party, Party Number, Account Number, Operating Unit, Bill To Site, Transaction Number, Note Level, Note Date From, Note Date To

## Oracle EBS Tables Used
[hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [jtf_notes_vl](https://www.enginatics.com/library/?pg=1&find=jtf_notes_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [jtf_objects_vl](https://www.enginatics.com/library/?pg=1&find=jtf_objects_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [iex_delinquencies_all](https://www.enginatics.com/library/?pg=1&find=iex_delinquencies_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload)

## Related Reports
[AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/IEX%20Collection%20Note%20Upload/IEX%20Collection%20Note%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/iex-collection-note-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload) |
| Blitz Report™ XML Import | [IEX_Collection_Note_Upload.xml](https://www.enginatics.com/xml/iex-collection-note-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload) |
| SQL Source | [IEX Collection Note Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/IEX%20Collection%20Note%20Upload/IEX%20Collection%20Note%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/iex-collection-note-upload/](https://www.enginatics.com/reports/iex-collection-note-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload) |

## Case Study & Technical Analysis: IEX Collection Note Upload

### Executive Summary
The IEX Collection Note Upload creates and updates Collection Notes in Oracle Collections, the same notes that appear in the Collections work area. Each note is attached to one of four note levels: the customer party, the account, the bill-to site or a collections transaction. Credit and collections teams use the upload to load call notes, promise-to-pay records and dispute comments in bulk, to correct note types and statuses, and to set up delinquencies on transactions. Blitz Report downloads existing notes so they can be reclassified, and the upload writes the changes back through the JTF notes and Collections tables.

### Business Challenge
*   **Bulk note loading:** Collection activity recorded outside Oracle, or migrated from a legacy system, must be entered against the right customer, account, site or transaction without retyping each note.
*   **Note level accuracy:** A note is attached to exactly one level, and each level needs different identifying fields, so the wrong level makes the note unreachable from the right work item.
*   **Delinquency status:** The unpaid reason and delinquency status belong to the transaction, so they must be set consistently with the notes on it.
*   **Reclassification:** Existing notes often need a new note type or status once a dispute or payment plan is resolved.

### The Solution
*   Creates notes at the party, account, bill-to or transaction level, with the Note Level column deciding which identifying fields are required.
*   Accepts note text of up to 2,000 characters, and a note detail that is truncated at 4,000 characters.
*   Sets the unpaid reason, and creates a delinquency with status Current when Create Delinquency is Yes.
*   Downloads existing notes in Create, Update mode, where only the note type, note status and descriptive flexfield attributes can be changed.

### Technical Architecture (High Level)
#### Primary Tables
*   `JTF_NOTES_VL`: the collection notes, with source object code and id, note type, status, text and flexfield columns.
*   `HZ_PARTIES`, `HZ_CUST_ACCOUNTS`, `HZ_CUST_ACCT_SITES_ALL`, `HZ_CUST_SITE_USES_ALL` and `HZ_PARTY_SITES`: the customer party, account, account site, bill-to site use and address.
*   `AR_PAYMENT_SCHEDULES_ALL` and `RA_CUSTOMER_TRX_ALL`: the transaction installments and transactions that a transaction-level note is attached to.
*   `IEX_DELINQUENCIES_ALL`: the delinquency of a transaction, with its status and unpaid reason.
*   `JTF_OBJECTS_VL`: the source object for each note level.
*   `HR_ALL_ORGANIZATION_UNITS_VL` and `MO_GLOB_ORG_ACCESS_TMP`: the operating unit and organization access.

#### Logical Relationships
1.  Notes are read from `JTF_NOTES_VL` where the source object code is PARTY, IEX_ACCOUNT, IEX_BILLTO or IEX_INVOICES.
2.  Each note's party, account, bill-to site and payment schedule are derived from its source object by a CASE expression on the source object code.
3.  The derived party, account and site are joined to `HZ_PARTIES`, `HZ_CUST_ACCOUNTS` and the site tables, which supply the party name, party number, account number and bill-to location.
4.  For transaction notes, the payment schedule joins to `RA_CUSTOMER_TRX_ALL` for the transaction number, and `IEX_DELINQUENCIES_ALL` is joined on the payment schedule id.
5.  The note level name comes from `JTF_OBJECTS_VL`, and the operating unit is limited to the organizations in `MO_GLOB_ORG_ACCESS_TMP`.

### Parameters & Filtering
*   **Upload Mode:** selects the rows to download for update, create or both.
*   **Party** and **Party Number:** select the customer party.
*   **Account Number:** selects one customer account.
*   **Operating Unit** and **Bill To Site:** select the operating unit and bill-to site of site-level or transaction-level notes.
*   **Transaction Number:** selects a transaction for transaction-level notes.
*   **Note Level:** selects one of the four levels: party, account, bill-to or transaction.
*   **Note Date From** and **Note Date To:** bound the entered dates of the notes.

### Performance & Optimization
*   The note source is decided in the inner query by the source object code, so each note is resolved once to its party, account and site.
*   Joins to the customer tables are outer joins on primary keys, so each note reads at most one row from each table.
*   The operating unit condition checks for a null operating unit first, so party-level notes skip the access list.
*   The delinquency and transaction joins apply only to transaction-level notes, which keeps the other levels fast.

### FAQ
**Q: How do I add a collection note to a customer account in Oracle Collections?**
A: Set the Note Level to the account level, enter the Party Name and Account Number, and add the note text. The note is created against the account and appears in the Collections work area.

**Q: Can I change the text of an existing collection note through the upload?**
A: No. Only the note type, note status and descriptive flexfield attributes can be changed on an existing note. The note text and its target are read only.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=iex-collection-note-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
