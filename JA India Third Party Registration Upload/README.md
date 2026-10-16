---
layout: default
last_modified_at: 2026-10-16
title: 'JA India Third Party Registration Upload | Oracle EBS SQL Report'
description: 'JA India Third Party Registration Upload ========================================= Use this upload to create or update India Localization Third Party…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, India, Third, Party, Registration, jai_party_regs_v, jai_party_reg_lines_v, jai_reporting_associations_v'
permalink: /JA%20India%20Third%20Party%20Registration%20Upload/
report_name: 'JA India Third Party Registration Upload'
report_web_name: ja-india-third-party-registration-upload
---

# JA India Third Party Registration Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ja-india-third-party-registration-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Party Type, Party Name, Party Number, Party Site Name, Regime Code, Registration Number

## Oracle EBS Tables Used
[jai_party_regs_v](https://www.enginatics.com/library/?pg=1&find=jai_party_regs_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload), [jai_party_reg_lines_v](https://www.enginatics.com/library/?pg=1&find=jai_party_reg_lines_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload), [jai_reporting_associations_v](https://www.enginatics.com/library/?pg=1&find=jai_reporting_associations_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload)

## Related Reports
[JA India GSTR-3B Return](/JA%20India%20GSTR-3B%20Return/ "JA India GSTR-3B Return Oracle EBS SQL Report"), [JA India GSTR-2 Return](/JA%20India%20GSTR-2%20Return/ "JA India GSTR-2 Return Oracle EBS SQL Report"), [JA India GSTR-1 Return](/JA%20India%20GSTR-1%20Return/ "JA India GSTR-1 Return Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/JA%20India%20Third%20Party%20Registration%20Upload/JA%20India%20Third%20Party%20Registration%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ja-india-third-party-registration-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload) |
| Blitz Report™ XML Import | [JA_India_Third_Party_Registration_Upload.xml](https://www.enginatics.com/xml/ja-india-third-party-registration-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload) |
| SQL Source | [JA India Third Party Registration Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/JA%20India%20Third%20Party%20Registration%20Upload/JA%20India%20Third%20Party%20Registration%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ja-india-third-party-registration-upload/](https://www.enginatics.com/reports/ja-india-third-party-registration-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload) |

## Case Study & Technical Analysis: JA India Third Party Registration Upload

### Executive Summary
This upload creates and updates India localization third party registrations for customers and suppliers in Oracle E-Business Suite. It maintains the tax and registration identifiers that Indian compliance requires, such as PAN, TAN, TIN, GST and service tax numbers, together with the TDS section and assessable price list where the regime calls for them, and the reporting codes linked to each registration. Indian finance and tax compliance teams use it to load registrations for a large supplier and customer base, and to keep the registration dates correct for each operating unit. The template runs in Excel through Blitz Report.

### Business Challenge
*   **Statutory identifiers:** Every Indian supplier and customer that is taxed or reported must carry the correct registration numbers for its regime.
*   **Large party base:** Registrations must be entered for each party and each party site, which is slow to do in the forms.
*   **Regime-specific fields:** TDS and non-TDS regimes need different fields, and the wrong one invalidates the registration.
*   **Ordering of records:** Reporting codes depend on the registration they belong to, so registrations must exist before their codes are loaded.

### The Solution
*   **Two record types:** A Registration row creates or updates a party registration. A Reporting Code row creates or updates a reporting code linked to a registration.
*   **Party and site selection:** The operating unit determines which party sites are offered. Leaving the site blank creates a registration without a site.
*   **Regime-driven fields:** An assessable price list is used for non-TDS regimes, and a default TDS section for TDS regimes.
*   **Effective dates:** Registration and reporting code start and end dates are set per row, with the start date defaulting to 1 July 2017, the India GST implementation date.
*   **Load order:** The file processes registrations first and reporting codes second, which matches the dependency between them.

### Technical Architecture (High Level)
#### Primary Tables
*   `JAI_PARTY_REGS_V`: the third party registration header, with party class, party number, name and operating unit.
*   `JAI_PARTY_REG_LINES_V`: the registration lines, with regime, registration type, registration number, secondary registration, price list, TDS section and effective dates.
*   `JAI_REPORTING_ASSOCIATIONS_V`: the reporting codes associated with a third party registration.

#### Logical Relationships
1. `JAI_PARTY_REGS_V` joins to `JAI_PARTY_REG_LINES_V` on the party registration id, for Registration rows.
2. `JAI_PARTY_REGS_V` joins to `JAI_REPORTING_ASSOCIATIONS_V` on the party registration id, with the entity code restricted to third party, for Reporting Code rows.
3. Both row sets are limited to registrations whose registration class is third party.
4. The two row sets are combined with UNION ALL and ordered by party type, party number, record type and registration identifiers.

### Parameters & Filtering
*   **Operating Unit:** restricts the registrations to one operating unit, and determines the party sites offered.
*   **Party Type:** restricts the registrations to suppliers or customers.
*   **Party Name and Party Number:** select one supplier or customer.
*   **Party Site Name:** restricts the registrations to one party site.
*   **Regime Code:** restricts the registrations to one regime.
*   **Registration Number:** finds one registration by its number.

### Performance & Optimization
*   The third party class filter is applied to both halves of the UNION ALL, so no other registration class is read.
*   The registration view is joined to the line and association views on identifiers, so each registration is read once per line or code.
*   Ordering uses the party keys and nulls last on line identifiers, so reporting code rows sit beneath their registration.

### FAQ
**Q: Why is my reporting code rejected on upload?**
A: The registration it belongs to must exist first. Upload the Registration rows in the file, and then upload the Reporting Code rows.

**Q: Which fields apply to a TDS regime?**
A: The Default TDS Section applies to a TDS regime. The Assessable Price List applies to a non-TDS regime.

**Q: What is the default start date for a registration?**
A: The Registration Start Date defaults to 1 July 2017, the India GST implementation date, and can be changed for each row.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ja-india-third-party-registration-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
