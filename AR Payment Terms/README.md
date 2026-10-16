---
layout: default
last_modified_at: 2026-10-16
title: 'AR Payment Terms | Oracle EBS SQL Report'
description: 'Master data report showing the payment terms codes with their respective profile options.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Receivables, Enginatics, Payment, Terms, ra_terms_lines_discounts, ra_terms_b, ra_terms_tl'
permalink: /AR%20Payment%20Terms/
report_name: 'AR Payment Terms'
report_web_name: ar-payment-terms
module: 'Receivables'
module_url: /modules/receivables/
---

# AR Payment Terms – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-payment-terms/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms).
**Oracle EBS module:** [Receivables](/modules/receivables/ "Oracle EBS Receivables reports") · [all Receivables reports](/modules/receivables/)  

## Overview
Master data report showing the payment terms codes with their respective profile options.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[ra_terms_lines_discounts](https://www.enginatics.com/library/?pg=1&find=ra_terms_lines_discounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms), [ra_terms_b](https://www.enginatics.com/library/?pg=1&find=ra_terms_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms), [ra_terms_tl](https://www.enginatics.com/library/?pg=1&find=ra_terms_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms), [ra_terms_lines](https://www.enginatics.com/library/?pg=1&find=ra_terms_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms)

## Related Reports
[AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Payment%20Terms/AR%20Payment%20Terms.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Payment Terms 24-Jul-2017 144054.xlsx](https://www.enginatics.com/example/ar-payment-terms/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms) |
| Blitz Report™ XML Import | [AR_Payment_Terms.xml](https://www.enginatics.com/xml/ar-payment-terms/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms) |
| SQL Source | [AR Payment Terms.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Payment%20Terms/AR%20Payment%20Terms.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-payment-terms/](https://www.enginatics.com/reports/ar-payment-terms/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms) |

## AR Payment Terms - Case Study & Technical Analysis

### Executive Summary

The **AR Payment Terms** report is a configuration audit tool that lists all defined payment terms within the Oracle Receivables module. Payment terms dictate the due dates and discount eligibility for customer invoices. This report is essential for Finance Managers and System Administrators to verify that the system's logic aligns with the company's credit policies and to identify obsolete terms for cleanup.

### Business Challenge

Payment terms are the rules of engagement for cash collection.
*   **Consistency:** If "Net 30" is defined differently in two different systems or operating units, it causes confusion.
*   **Revenue Leakage:** Incorrectly configured discount terms (e.g., offering 2% discount for too long) can directly impact profit margins.
*   **Data Hygiene:** Over years of operation, systems often accumulate duplicate or unused terms (e.g., "Net 30 Old", "Net 30 New"), leading to data entry errors.

### Solution

The **AR Payment Terms** report provides a structured inventory of these rules:
*   **Definition Review:** Displays the exact calculation logic (e.g., "Due 30 days after invoice date").
*   **Discount Audit:** Shows the percentage and days for early payment discounts.
*   **Split Terms:** Identifies complex terms where payments are split (e.g., "50% due in 30 days, 50% due in 60 days").

### Technical Architecture

The report queries the core setup tables for payment terms.

#### Key Tables & Joins

*   **Header:** `RA_TERMS_B` and `RA_TERMS_TL` store the term name, description, and effective dates.
*   **Lines:** `RA_TERMS_LINES` defines the schedule. A simple term has one line (100% due). Complex terms have multiple lines.
*   **Discounts:** `RA_TERMS_LINES_DISCOUNTS` stores the discount percentage and the number of days the discount is valid.
*   **Billing Cycle:** May link to billing cycle definitions if the term is cycle-based.

#### Logic

1.  **Retrieval:** Fetches all terms from the header table.
2.  **Expansion:** Joins to the lines table to show the "Due Days" or "Fixed Date" logic.
3.  **Detailing:** Joins to the discount table to display any early payment incentives.

### Parameters

*   **None (Standard):** Often runs as a full list.
*   **Term Name:** (Optional) To filter for a specific term.
*   **Active Only:** (Implicit) Often filtered to show only currently active terms, though auditing inactive ones is also useful.

### FAQ

**Q: What is the difference between "Due Days" and "Fixed Date"?**
*   **Due Days:** Adds a number of days to the invoice date (e.g., Invoice Date + 30).
*   **Fixed Date:** Sets the due date to a specific day of the month (e.g., 15th of the following month).

**Q: Can I change a payment term after it has been used?**
A: You can change the description, but changing the schedule (lines) of a term that is already assigned to invoices can have side effects. It is best practice to end-date the old term and create a new one.

**Q: How do "Split Terms" work?**
A: The report will show multiple rows for a single term name, each representing a portion of the payment (e.g., Sequence 1: 50%, Sequence 2: 50%).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-payment-terms)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
