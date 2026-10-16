---
layout: default
last_modified_at: 2026-10-16
title: 'AP Suppliers Revenue by Period | Oracle EBS SQL Report'
description: 'AP invoice amount per supplier and invoice currency, with one column per GL period from Period From to Period To. An invoice is counted in the period of…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, Suppliers, Revenue, Period, gl_periods, gl_ledgers, hr_operating_units'
permalink: /AP%20Suppliers%20Revenue%20by%20Period/
report_name: 'AP Suppliers Revenue by Period'
report_web_name: ap-suppliers-revenue-by-period
module: 'Payables'
module_url: /modules/payables/
---

# AP Suppliers Revenue by Period – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-suppliers-revenue-by-period/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

## Overview
AP invoice amount per supplier and invoice currency, with one column per GL period from Period From to Period To.

An invoice is counted in the period of its invoice GL date. Periods are taken from the ledger's accounting calendar, excluding adjustment periods, and each column is named after the month the period falls in.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Operating Unit, Supplier, Supplier Number, Period From, Period To, Summary Level

## Oracle EBS Tables Used
[gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period)

## Related Reports
[GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Suppliers%20Revenue%20by%20Period/AP%20Suppliers%20Revenue%20by%20Period.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Suppliers Revenue by Period 10-Oct-2026 112409.xlsx](https://www.enginatics.com/example/ap-suppliers-revenue-by-period/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period) |
| Blitz Report™ XML Import | [AP_Suppliers_Revenue_by_Period.xml](https://www.enginatics.com/xml/ap-suppliers-revenue-by-period/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period) |
| SQL Source | [AP Suppliers Revenue by Period.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Suppliers%20Revenue%20by%20Period/AP%20Suppliers%20Revenue%20by%20Period.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-suppliers-revenue-by-period/](https://www.enginatics.com/reports/ap-suppliers-revenue-by-period/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period) |

## Case Study & Technical Analysis: AP Suppliers Revenue by Period

### Executive Summary
The AP Suppliers Revenue by Period report shows Oracle Payables invoice value for each supplier and invoice currency, spread across a sequence of accounting periods. Each period is a column, so a finance or procurement user can see how spend with each supplier moved from one month to the next over a chosen range. It supports supplier spend reviews, budget tracking against trading partners and period-by-period analysis of purchasing volume before and after period close.

### Business Challenge
*   **Spend visibility by period:** Standard supplier reports show totals for one range, not how invoice value is distributed across the accounting calendar.
*   **Multi-currency suppliers:** Invoices for the same supplier can be in several currencies, and totals in different currencies must not be added together.
*   **Calendar alignment:** Invoices must be assigned to the same accounting periods that the general ledger uses, not to calendar months by invoice date.
*   **Supplier classification:** Analysts need to group spend by supplier type to compare categories of vendors.

### The Solution
*   **Invoice-level period assignment:** Each invoice is placed in the GL period whose date range contains its invoice GL date, using the ledger's period set and accounted period type.
*   **Dynamic period columns:** The report builds one column per period between Period From and Period To, so the range can be changed without modifying the layout.
*   **Currency-separated totals:** Totals are grouped by the invoice currency code, so each supplier shows one row per currency.
*   **Supplier context:** Supplier name, supplier number and vendor type are shown beside the amounts, with the vendor type translated to its meaning.

### Technical Architecture (High Level)
#### Primary Tables
*   `GL_LEDGERS`: the ledger, which supplies the period set name and accounted period type used to find periods.
*   `GL_PERIODS`: the accounting calendar, read for period start and end dates. Adjustment periods are excluded.
*   `HR_OPERATING_UNITS`: the operating unit, linked to its ledger through the set of books ID and to invoices through the organization ID.
*   `AP_INVOICES_ALL`: the invoice header, which supplies the invoice amount, invoice currency code, GL date and operating unit.
*   `AP_SUPPLIERS`: the supplier master, which supplies the supplier name, number and vendor type.

#### Logical Relationships
1.  `GL_LEDGERS` is joined to `HR_OPERATING_UNITS` on the ledger ID and set of books ID.
2.  `HR_OPERATING_UNITS` is joined to `AP_INVOICES_ALL` on the organization ID and invoice org ID.
3.  `AP_INVOICES_ALL` is joined to `AP_SUPPLIERS` on the vendor ID.
4.  For each invoice, a scalar subquery finds the non-adjustment `GL_PERIODS` row of the ledger's period set and period type whose range contains the invoice GL date. The result is reduced to a month label.
5.  The inner rows are summed by supplier, supplier number, vendor type, currency and period month in the outer query.

### Parameters & Filtering
*   **Ledger:** Selects the ledger whose period set defines the period columns and the operating units that belong to it.
*   **Operating Unit:** Restricts invoices to one operating unit.
*   **Supplier and Supplier Number:** Limit the output to one supplier or a specific supplier number.
*   **Period From and Period To:** Set the range of accounting periods that become columns.
*   **Summary Level:** Changes the grouping of the output rows.

### Performance & Optimization
*   **Ledger-driven scope:** The ledger and operating unit joins limit invoice rows to the operating units of the chosen ledger before aggregation.
*   **Adjustment periods excluded:** The period lookup filters out adjustment periods, so each invoice maps to exactly one ordinary period.
*   **Single aggregation pass:** Period amounts are computed as one inner row per invoice, then summed once per supplier and currency in the outer query.
*   **Dynamic column expansion:** Period columns are generated from the parameter range, so the column count, and the work per row, grows with the number of periods selected.

### FAQ
**Q: Why does an invoice appear in a different period from its invoice date?**
A: The report assigns each invoice to the GL period that contains its GL date, and the periods come from the ledger's accounting calendar, so the GL date controls the placement.

**Q: Are invoice amounts in different currencies added together?**
A: No. Totals are grouped by invoice currency code, so a supplier that invoices in two currencies appears on two rows.

**Q: Can I see one supplier over a single quarter?**
A: Yes. Enter the supplier or supplier number together with Period From and Period To covering the quarter.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-revenue-by-period)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
