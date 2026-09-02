---
layout: default
title: 'AR HSBC FAA Asset File (France) | Oracle EBS SQL Report'
description: 'Extracts completed Receivables invoices and credit memos in the HSBC FACTORING FRANCE FAA file format, for invoice discounting. One 532 character record…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, HSBC, FAA, Asset, File, zx_lines, ra_customer_trx_lines_all, ra_customer_trx_all'
permalink: /AR%20HSBC%20FAA%20Asset%20File%20%28France%29/
---

# AR HSBC FAA Asset File (France) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-hsbc-faa-asset-file-france/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Extracts completed Receivables invoices and credit memos in the HSBC FACTORING FRANCE FAA file format, for invoice discounting. One 532 character record per document.

The report is implemented from the HSBC specification document "HFF - Invoice Discounting - Asset File IT Protocol.pdf" dated 09/09/2025, and its output has been validated against both the field table in that document and the sample file supplied with it. The 31 zones are, in order, each followed by a semicolon: File type FAA (3), Seller account number (5), File creation date YYYYMMDDHHMM (12), Debtor's Seller Identifier (15), Debtor ID number (9), Debtor Activity Code (5), Debtor Country Code (2), Debtor's corporate name (40), Debtor's trade name (40), Debtor Address 1 to 3 (30 each), Debtor Town (30), Debtor postal code (10), Debtor contact name (20), Debtor telephone (15), Debtor fax (15), Document type (1), Document number (20), Document's secondary number (1), Credited invoice number (20), Document issue date YYYYMMDD (8), Document due date YYYYMMDD (8), Document currency (3), Document amount including tax (15), Document amount excluding tax (15), Document VAT rate (4), Order reference (10), Other invoice reference (25), Invoice Status (30), Free field (30).

Document type is F for an invoice and A for a credit note. Amounts are always positive, are expressed in the smallest unit of the invoice currency with no decimal separator, and are zero filled to the left. The VAT rate is the highest rate on the document, expressed without a decimal point, so 20 per cent is 2000. The credited invoice number is populated on a credit memo with the invoice it is applied to, and is blank on an invoice.

Amount including tax is the document total, being the sum of all instalments. Amount excluding tax is that total less the tax lines. The due date is the earliest instalment due date. The debtor name, address, town and postal code come from the bill to site. Invoice Status is RGL, or LIT1 when the document has an amount in dispute. Semicolons, tabs and line breaks are removed from text zones so they cannot break a record.

Run with Output Format set to TSV and Exclude Column Headers set to Yes, and set the Server Output Directory runtime option to the directory the file should be written to. The file is written as FAA<seller account number>_<YYYYMMDD>.

HSBC require a .txt extension, CR LF line endings and ANSI encoding. The report carries hsbc_faa_rename.sh as its Custom Postprocess to apply all three, so the script must be installed as $XXEN_TOP/bin/custom/hsbc_faa_rename.sh and be executable. It only acts on the file in the Server Output Directory, so the concurrent request output is unaffected and View Output continues to work.

The Seller account number is allocated by HSBC and differs by currency for the same seller, so a file must cover a single currency. Currency is therefore a required parameter, defaulted to the functional currency of the selected operating unit. Where invoices are raised in more than one currency, run the report once per currency with the matching Seller account number.

## Report Parameters
Operating Unit, Seller Account Number, Currency, Invoice Date From, Invoice Date To

## Oracle EBS Tables Used
[zx_lines](https://www.enginatics.com/library/?pg=1&find=zx_lines), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/ar-hsbc-faa-asset-file-france/) |
| Blitz Report™ XML Import | [AR_HSBC_FAA_Asset_File_France.xml](https://www.enginatics.com/xml/ar-hsbc-faa-asset-file-france/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-hsbc-faa-asset-file-france/](https://www.enginatics.com/reports/ar-hsbc-faa-asset-file-france/) |



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
