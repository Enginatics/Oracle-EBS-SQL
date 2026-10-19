---
layout: default
last_modified_at: 2026-10-19
title: 'AR HSBC FAA Asset File (France) | Oracle EBS SQL Report'
description: 'Extracts completed Receivables invoices and credit memos in the HSBC FACTORING FRANCE FAA file format, for invoice discounting. One 532 character record…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Receivables, Enginatics, R12 only, HSBC, FAA, Asset, File, zx_lines, ra_customer_trx_lines_all, ra_customer_trx_all'
permalink: /AR%20HSBC%20FAA%20Asset%20File%20%28France%29/
report_name: 'AR HSBC FAA Asset File (France)'
report_web_name: ar-hsbc-faa-asset-file-france
module: 'Receivables'
module_url: /modules/receivables/
---

# AR HSBC FAA Asset File (France) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-hsbc-faa-asset-file-france/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france).
**Oracle EBS module:** [Receivables](/modules/receivables/ "Oracle EBS Receivables reports") · [all Receivables reports](/modules/receivables/)  

## Overview
Extracts completed Receivables invoices and credit memos in the HSBC FACTORING FRANCE FAA file format, for invoice discounting. One 532 character record per document.

The report is implemented from the HSBC specification document "HFF - Invoice Discounting - Asset File IT Protocol.pdf" dated 09/09/2025, and its output has been validated against both the field table in that document and the sample file supplied with it. The 31 zones are, in order, each followed by a semicolon: File type FAA (3), Seller account number (5), File creation date YYYYMMDDHHMM (12), Debtor's Seller Identifier (15), Debtor ID number (9), Debtor Activity Code (5), Debtor Country Code (2), Debtor's corporate name (40), Debtor's trade name (40), Debtor Address 1 to 3 (30 each), Debtor Town (30), Debtor postal code (10), Debtor contact name (20), Debtor telephone (15), Debtor fax (15), Document type (1), Document number (20), Document's secondary number (1), Credited invoice number (20), Document issue date YYYYMMDD (8), Document due date YYYYMMDD (8), Document currency (3), Document amount including tax (15), Document amount excluding tax (15), Document VAT rate (4), Order reference (10), Other invoice reference (25), Invoice Status (30), Free field (30).

Document type is F for an invoice and A for a credit note. Amounts are always positive, are expressed in the smallest unit of the invoice currency with no decimal separator, and are zero filled to the left. The VAT rate is the highest rate on the document, expressed without a decimal point, so 20 per cent is 2000. The credited invoice number is populated on a credit memo with the invoice it is applied to, and is blank on an invoice.

Amount including tax is the document total, being the sum of all instalments. Amount excluding tax is that total less the tax lines. The due date is the earliest instalment due date. The debtor name, address, town and postal code come from the bill to site. Invoice Status is RGL, or LIT1 when the document has an amount in dispute. Semicolons, tabs and line breaks are removed from text zones so they cannot break a record.

Run with Output Format set to TSV and Exclude Column Headers set to Yes, and set the Server Output Directory runtime option to the directory the file should be written to. The file is written as FAA<seller account number>_<YYYYMMDD>.

HSBC require a .txt extension, CR LF line endings and ANSI encoding. The report carries hsbc_faa_rename.sh as its Custom Postprocess to apply all three, so the script must be installed as $XXEN_TOP/bin/custom/hsbc_faa_rename.sh and be executable. It only acts on the file in the Server Output Directory, so the concurrent request output is unaffected and View Output continues to work.

The Seller account number is allocated by HSBC and differs by currency for the same seller, so a file must cover a single currency. Currency is therefore a required parameter, defaulted to the functional currency of the selected operating unit. Where invoices are raised in more than one currency, run the report once per currency with the matching Seller account number.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Seller Account Number, Currency, Invoice Date From, Invoice Date To

## Oracle EBS Tables Used
[zx_lines](https://www.enginatics.com/library/?pg=1&find=zx_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report"), [AR Open Items Revaluation](/AR%20Open%20Items%20Revaluation/ "AR Open Items Revaluation Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AR Customer Statement](/AR%20Customer%20Statement/ "AR Customer Statement Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [AR Transactions and Payments](/AR%20Transactions%20and%20Payments/ "AR Transactions and Payments Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20HSBC%20FAA%20Asset%20File%20%28France%29/AR%20HSBC%20FAA%20Asset%20File%20%28France%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ar-hsbc-faa-asset-file-france/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france) |
| Blitz Report™ XML Import | [AR_HSBC_FAA_Asset_File_France.xml](https://www.enginatics.com/xml/ar-hsbc-faa-asset-file-france/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france) |
| SQL Source | [AR HSBC FAA Asset File (France).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20HSBC%20FAA%20Asset%20File%20%28France%29/AR%20HSBC%20FAA%20Asset%20File%20%28France%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-hsbc-faa-asset-file-france/](https://www.enginatics.com/reports/ar-hsbc-faa-asset-file-france/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france) |

## Case Study & Technical Analysis: AR HSBC FAA Asset File (France)

### Executive Summary
This report extracts completed Receivables invoices and credit memos in the HSBC Factoring France FAA file format used for invoice discounting, producing one 532-character record per document. French sellers that assign receivables to HSBC use it to build each submission's asset file. The output is a delimited text file that is run through Blitz Report™ with Output Format set to TSV and written to the server output directory.

### Business Challenge
*   **Fixed-format submission:** HSBC requires a fixed-length asset file with 31 zones in a set order, and a manual build of that layout is error-prone.
*   **Debtor identification:** Each debtor must be identified with its French fiscal identifier, activity code, legal name, trade name and full bill-to address.
*   **Amount conventions:** Amounts must be positive, expressed in the smallest unit of the invoice currency and zero-filled to the left, with no decimal separator.
*   **Credit memo linkage:** A credit memo must carry the number of the invoice it reduces so that HSBC can reconcile the file.

### The Solution
*   Assembles each record in the exact zone order of the HSBC specification, padding or truncating each zone to its defined length and terminating each zone with a semicolon.
*   Converts amounts with the currency precision from `FND_CURRENCIES`, and derives the VAT rate as the highest tax rate on the document.
*   Populates the credited invoice number from the largest credit memo application, and sets the document type to F for an invoice and A for a credit note.
*   Removes semicolons, tabs and line breaks from text zones so that no record can be split, and applies the HSBC invoice status of RGL or LIT1 from amounts in dispute.

### Technical Architecture (High Level)
#### Primary Tables
*   `RA_CUSTOMER_TRX_ALL`: the completed invoice and credit memo headers, including trx number, date, currency, purchase order and bill-to customer.
*   `RA_CUSTOMER_TRX_LINES_ALL`: the TAX lines whose extended amount gives the tax total of each document.
*   `AR_PAYMENT_SCHEDULES_ALL`: the INV and CM installments, supplying the amount including tax, due date and amount in dispute.
*   `AR_RECEIVABLE_APPLICATIONS_ALL`: the applications that link a credit memo to the invoice it reduces.
*   `ZX_LINES`: the tax rate of each transaction line, used for the VAT rate zone.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES`, `HZ_CUST_SITE_USES_ALL`, `HZ_CUST_ACCT_SITES_ALL`, `HZ_PARTY_SITES` and `HZ_LOCATIONS`: the debtor account, legal name, bill-to site and address.
*   `HR_OPERATING_UNITS`: the operating unit that restricts the transactions.
*   `FND_CURRENCIES`: the precision of the invoice currency.

#### Logical Relationships
1.  Completed transactions (`COMPLETE_FLAG` = Y) in the selected operating unit are joined to their INV and CM payment schedules and grouped per transaction.
2.  The tax total comes from the TAX lines of `RA_CUSTOMER_TRX_LINES_ALL`, and the amount excluding tax is the total less that tax.
3.  The due date is the earliest installment due date, and the invoice status is LIT1 when any installment has an amount in dispute.
4.  The credited invoice is found in `AR_RECEIVABLE_APPLICATIONS_ALL` for applications of type CM with status APP, choosing the application with the largest amount.
5.  The bill-to customer account is joined to its party, then to the bill-to site use, account site, party site and location, supplying the debtor address.
6.  Records are built per document and ordered by debtor identifier and document number.

### Parameters & Filtering
*   **Operating Unit:** selects the transactions of one operating unit.
*   **Seller Account Number:** the account number allocated by HSBC; only its digits are kept, truncated to five characters and zero-filled.
*   **Currency:** a required parameter that defaults to the functional currency of the operating unit, and restricts each file to one currency.
*   **Invoice Date From** and **Invoice Date To:** bound the documents included in the file.

### Performance & Optimization
*   The transaction header is aggregated in an inline view before the debtor joins, so each document is processed once rather than once per installment.
*   The file creation timestamp uses an analytic MAX over the result, so no second pass is needed.
*   The VAT rate is a correlated subquery on `ZX_LINES` restricted to the transactions application and entity code, which keeps the lookup to one entity per document.
*   Text zones are cleaned with TRANSLATE and padded with RPAD to their fixed lengths.

### FAQ
**Q: What format does the HSBC France FAA asset file use?**
A: Each record is 532 characters long, contains 31 zones separated by semicolons, and is written as a text file with CR LF line endings and ANSI encoding by the custom post-process script.

**Q: How are amounts written in the FAA file?**
A: Amounts are always positive, expressed in the smallest unit of the invoice currency with no decimal separator, and zero-filled to the left.

**Q: Why must the report be run once for each currency?**
A: HSBC allocates a different seller account number for each currency, so a single file can only cover one currency and one seller account.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-hsbc-faa-asset-file-france)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
