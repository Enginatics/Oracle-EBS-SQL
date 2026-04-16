---
layout: default
title: 'AR European Sales Listing | Oracle EBS SQL Report'
description: 'Summary report listing sales by country and currency code, with transaction amount / currency and accounted amount/ currency'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, European, Sales, Listing, hz_cust_acct_sites, hz_party_sites, hz_locations'
permalink: /AR%20European%20Sales%20Listing/
---

# AR European Sales Listing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-european-sales-listing/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary report listing sales by country and currency code, with transaction amount / currency and accounted amount/ currency

## Report Parameters
Detail/Summary, Ledger, From Date, To Date, Branch (to which remitted), Site Reported, EU Countries Only

## Oracle EBS Tables Used
[hz_cust_acct_sites](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [xle_etb_profiles](https://www.enginatics.com/library/?pg=1&find=xle_etb_profiles), [zx_party_tax_profile](https://www.enginatics.com/library/?pg=1&find=zx_party_tax_profile), [zx_registrations](https://www.enginatics.com/library/?pg=1&find=zx_registrations), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [ra_cust_trx_line_gl_dist_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_gl_dist_all), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [ZX Party Tax Profiles](/ZX%20Party%20Tax%20Profiles/ "ZX Party Tax Profiles Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR European Sales Listing 25-Jul-2017 120805.xlsx](https://www.enginatics.com/example/ar-european-sales-listing/) |
| Blitz Report™ XML Import | [AR_European_Sales_Listing.xml](https://www.enginatics.com/xml/ar-european-sales-listing/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-european-sales-listing/](https://www.enginatics.com/reports/ar-european-sales-listing/) |

## AR European Sales Listing - Case Study & Technical Analysis

### Executive Summary

The **AR European Sales Listing** (often referred to as the EC Sales List or ESL) is a critical compliance report for organizations trading within the European Union. It summarizes sales of goods and services to VAT-registered customers in other EU member states. This report facilitates the preparation of statutory declarations required by tax authorities to monitor cross-border trade and combat VAT fraud.

### Business Challenge

EU VAT laws require businesses to submit periodic statements listing the total value of supplies made to each customer in other EU countries.
*   **Compliance Risk:** Failure to report or incorrect reporting can lead to significant fines and audits.
*   **Data Complexity:** The data requires linking financial transactions with customer master data (VAT numbers) and geographical data (Country codes), which are often stored in different modules.
*   **Currency Conversion:** Transactions may be in various currencies, but reporting must often be in the functional currency of the reporting entity.

### Solution

The **AR European Sales Listing** report automates the data gathering process:
*   **VAT Number Validation:** It retrieves the Tax Registration Number (TRN) for each customer, a mandatory field for the ESL.
*   **Geographical Filtering:** The "EU Countries Only" parameter ensures that only relevant intra-community supplies are included, excluding domestic sales or exports to non-EU nations.
*   **Aggregation:** It groups transactions by Customer and Country, summing the values to provide the line items needed for the tax return.

### Technical Architecture

The report integrates financial transaction data with the Tax and Trading Community Architecture (TCA) models.

#### Key Tables & Joins

*   **Transactions:** `RA_CUSTOMER_TRX_ALL` and `RA_CUSTOMER_TRX_LINES_ALL` provide the invoice details and amounts.
*   **Distributions:** `RA_CUST_TRX_LINE_GL_DIST_ALL` is used to get the accounted amounts (functional currency).
*   **Customer Location:** `HZ_LOCATIONS` (via `HZ_CUST_ACCT_SITES_ALL`) determines the "Ship-To" country, which defines the destination of the goods.
*   **Tax Profiles:** `ZX_PARTY_TAX_PROFILE` and `ZX_REGISTRATIONS` are queried to fetch the customer's VAT registration number.
*   **Legal Entity:** `XLE_ETB_PROFILES` identifies the legal entity responsible for the reporting.

#### Logic

1.  **Scope:** Selects AR transactions (Invoices, Credit Memos, Debit Memos) within the date range.
2.  **Location Check:** Checks the country code of the Ship-To address. If "EU Countries Only" is selected, it filters against a list of EU member state codes.
3.  **Tax Calculation:** Aggregates the net transaction amounts (excluding VAT) as ESL reporting typically requires the net value of supplies.
4.  **Currency:** Reports both the entered currency amount and the accounted (ledger) currency amount.

### Parameters

*   **Ledger:** Specifies the accounting book.
*   **From/To Date:** Defines the reporting period (usually monthly or quarterly).
*   **Detail/Summary:**
    *   *Summary:* One line per Customer/Country (for the tax form).
    *   *Detail:* Lists individual invoices (for internal audit and reconciliation).
*   **EU Countries Only:** A flag to restrict the output to intra-community trade.
*   **Site Reported:** Filters by specific business sites if the entity has multiple locations.

### FAQ

**Q: Does this report include VAT amounts?**
A: Typically, the EC Sales List requires the *value of supplies* (Net Amount), not the VAT amount itself, as the customer accounts for the VAT (Reverse Charge mechanism).

**Q: How are Credit Memos handled?**
A: Credit Memos are subtracted from the total sales value for the period. If the net total is negative, it is reported as such (depending on specific country rules).

**Q: Why is a customer missing from the report?**
A: Ensure the customer has a valid "Ship-To" address in an EU country and that the transaction date falls within the selected range. Also, verify that the customer has a VAT number defined in their Tax Profile.


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
