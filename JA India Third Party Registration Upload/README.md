---
layout: default
title: 'JA India Third Party Registration Upload | Oracle EBS SQL Report'
description: 'JA India Third Party Registration Upload ========================================= Use this upload to create or update India Localization Third Party…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, India Localization, Upload, India, Third, Party, Registration, jai_party_regs_v, jai_party_reg_lines_v, jai_reporting_associations_v'
permalink: /JA%20India%20Third%20Party%20Registration%20Upload/
---

# JA India Third Party Registration Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ja-india-third-party-registration-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
JA India Third Party Registration Upload
=========================================
Use this upload to create or update India Localization Third Party Registrations for customers and suppliers, including tax/registration identifiers such as PAN, TAN, TIN, GST, Service Tax, and other India-specific registration numbers.

This upload also supports Reporting Codes linked to Third Party Registrations.

NOTE: If you are creating new records for a third party, enter and upload all Registration records first, and then enter and upload the Reporting Code records.

Available columns:
1.Record Type: Select either Registration or Reporting Code. This determines whether you are creating/updating a registration record or a reporting code record.
2.Operating Unit: Select the Operating Unit to retrieve the list of party sites for that OU, or leave blank if you are entering a registration without a site (null site registration).
3.Party Type: Select Supplier or Customer. The available Party Numbers depend on this selection.
4.Party Number: Enter the Supplier Number or Customer Number. You can use the list of values (LOV); entering a few starting characters/numbers helps narrow the list.
5.Party Name: Auto-populates after you enter the Party Number. You can also use the LOV to search by Supplier/Customer name; the LOV displays the Party Number as well.
6.Party Site Name: Select the Party Site based on the Operating Unit. Leave blank for a null site registration.
7.Registration Regime Code, Registration Type, Registration Number, Secondary Registration Type, Secondary Registration Number: Enter these fields to create/update a party registration. These fields are available only when Record Type = Registration.
8.Assessable Price List: Enter an Assessable Price List when the selected Regime Code is a Non-TDS Regime. Available only when Record Type = Registration.
9.Default TDS Section: Enter a Default TDS Section code when the selected Regime Code is a TDS Regime. Available only when Record Type = Registration.
10.Registration Start Date, Registration End Date: Enter the effective dates for the registration. The Start Date defaults to 01-Jul-2017 (GST implementation date in India), but you can change it as needed.
11.Reporting Code Regime Code, Reporting Code Type, Reporting Code: Enter these fields to create/update a reporting code for the registration. These fields are available only when Record Type = Reporting Code.
12.Reporting Code Start Date, Reporting Code End Date: Enter the effective dates for the reporting code. The Start Date defaults to 01-Jul-2017, but you can change it as needed.


## Report Parameters
Operating Unit, Party Type, Party Name, Party Number, Party Site Name, Regime Code, Registration Number

## Oracle EBS Tables Used
[jai_party_regs_v](https://www.enginatics.com/library/?pg=1&find=jai_party_regs_v), [jai_party_reg_lines_v](https://www.enginatics.com/library/?pg=1&find=jai_party_reg_lines_v), [jai_reporting_associations_v](https://www.enginatics.com/library/?pg=1&find=jai_reporting_associations_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [India Localization](https://www.enginatics.com/library/?pg=1&category[]=India%20Localization), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[JA India GSTR-3B Return](/JA%20India%20GSTR-3B%20Return/ "JA India GSTR-3B Return Oracle EBS SQL Report"), [JA India GSTR-2 Return](/JA%20India%20GSTR-2%20Return/ "JA India GSTR-2 Return Oracle EBS SQL Report"), [JA India GSTR-1 Return](/JA%20India%20GSTR-1%20Return/ "JA India GSTR-1 Return Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ja-india-third-party-registration-upload/) |
| Blitz Report™ XML Import | [JA_India_Third_Party_Registration_Upload.xml](https://www.enginatics.com/xml/ja-india-third-party-registration-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ja-india-third-party-registration-upload/](https://www.enginatics.com/reports/ja-india-third-party-registration-upload/) |



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
