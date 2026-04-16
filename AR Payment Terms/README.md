---
layout: default
title: 'AR Payment Terms | Oracle EBS SQL Report'
description: 'Master data report showing the payment terms codes with their respective profile options.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Payment, Terms, ra_terms_lines_discounts, ra_terms_b, ra_terms_tl'
permalink: /AR%20Payment%20Terms/
---

# AR Payment Terms – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-payment-terms/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report showing the payment terms codes with their respective profile options.

## Report Parameters


## Oracle EBS Tables Used
[ra_terms_lines_discounts](https://www.enginatics.com/library/?pg=1&find=ra_terms_lines_discounts), [ra_terms_b](https://www.enginatics.com/library/?pg=1&find=ra_terms_b), [ra_terms_tl](https://www.enginatics.com/library/?pg=1&find=ra_terms_tl), [&billing_cycle_table](https://www.enginatics.com/library/?pg=1&find=&billing_cycle_table)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [AR Incomplete Transactions](/AR%20Incomplete%20Transactions/ "AR Incomplete Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Payment Terms 24-Jul-2017 144054.xlsx](https://www.enginatics.com/example/ar-payment-terms/) |
| Blitz Report™ XML Import | [AR_Payment_Terms.xml](https://www.enginatics.com/xml/ar-payment-terms/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-payment-terms/](https://www.enginatics.com/reports/ar-payment-terms/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
