---
layout: default
title: 'IEX Collection Note Upload | Oracle EBS SQL Report'
description: 'Creates and updates Collection Notes in Oracle Collections (IEX) - the same notes shown in the Collections work area. Each note is attached at a single…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, IEX, Collection, Note, hz_cust_accounts, hz_cust_site_uses_all, hz_cust_acct_sites_all'
permalink: /IEX%20Collection%20Note%20Upload/
---

# IEX Collection Note Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/iex-collection-note-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

Only the Note Type, Note Status and descriptive flexfield attributes can be changed on an existing note; the note text and its target are read only. Download notes in Create, Update mode to reclassify them.

## Report Parameters
Upload Mode, Party, Party Number, Account Number, Operating Unit, Bill To Site, Transaction Number, Note Level, Note Date From, Note Date To

## Oracle EBS Tables Used
[hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [jtf_notes_vl](https://www.enginatics.com/library/?pg=1&find=jtf_notes_vl), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [jtf_objects_vl](https://www.enginatics.com/library/?pg=1&find=jtf_objects_vl), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/iex-collection-note-upload/) |
| Blitz Report™ XML Import | [IEX_Collection_Note_Upload.xml](https://www.enginatics.com/xml/iex-collection-note-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/iex-collection-note-upload/](https://www.enginatics.com/reports/iex-collection-note-upload/) |



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
