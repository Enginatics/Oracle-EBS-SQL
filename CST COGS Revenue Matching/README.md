---
layout: default
title: 'CST COGS Revenue Matching | Oracle EBS SQL Report'
description: 'Imported from Concurrent Program Application: Bills of Material Source: COGS Revenue Matching Report Short Name: CSTRCMRX The COGS/Revenue Matching Report…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Nidec changes, R12 only, CST, COGS, Revenue, Matching, cst_revenue_cogs_match_lines, cst_cogs_events, oe_order_lines_all'
permalink: /CST%20COGS%20Revenue%20Matching/
---

# CST COGS Revenue Matching – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-cogs-revenue-matching/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from Concurrent Program
Application: Bills of Material
Source: COGS Revenue Matching Report
Short Name: CSTRCMRX

The COGS/Revenue Matching Report displays earned and unearned (deferred) revenue, and cost of goods sold amounts for sales orders issues specified in the report's run-time parameters.
The report displays shipped sales order and associated sales order lines and shows the accounts where the earned and deferred COGS were charged.

The report is based on the Revenue and COGS Matching functionality delivered in Oracle EBS R12. Please refer to the following documentation regarding this functionality:
- Oracle Cost Management User Guide, Section: Revenue and COGS Matching
- MOS Document 1060202.1 Understanding COGS and DCOGS Recognition Accounting

Revenue / COGS Recognition Process Flow
=======================================
When you ship confirm one or more order lines in Oracle Order Management and then run the applicable Cost Management cost and accounting processes, the cost of goods sold associated with the sales order line is immediately debited to a Deferred COGS account pending the invoicing and recognition of the sales order revenue in Oracle Receivables.

When Oracle Receivables recognizes all or part of the sales revenue associated with a sales order line, you run a cost process that calculates the percentage of total billed revenue recognized. Oracle Inventory then creates a cost recognition transaction that adjusts the Deferred COGS and regular COGS amount for the order line. The proportion of total shipment cost that is recognized as COGS will always match the proportion of total billable quantity that is recognized as revenue.

Revenue / COGS Recognition Concurrent Processes
================================================
It is recommended the Revenue and COGS concurrent processes be run in the following order:

Run the AR Concurrent Processes first:

- Autoinvoice Master Program.  Run autoinvoice to generate the invoice transactions.
- Revenue Recognition. Run the Revenue Recognition Master Program to generate the AR revenue recognition

Then the COGS Concurrent Processes:

- Record Order Management Transactions
 The Record Order Management Transactions concurrent process picks up and costs all uncosted sales order issue and RMA return transactions and creates a record for each new order line in the costing COGS recognition matching table. This process is not for Perpetual Discrete Costing (Standard, Average, FIFO). In Discrete Costing, the cost processor selects and costs the uncosted sales order issues and inserts them into the COGS matching table

- Collect Revenue Recognition Information
 The Collect Revenue Recognition Information concurrent process calls an Oracle Receivables API to retrieve the latest revenue recognition percentage of all invoiced sales order lines in Oracle receivables for a specific ledger and with activity dates within a user-specified date range. This process must be run before the Generate COGS recognition Event concurrent process.

- Generate COGS Recognition Events
 The Generate COGS Recognition Events concurrent request compares the COGS recognition percentage for each sales order line and accounting period combination to the current earned revenue percentage. When the compared percentages are different, the process raises a COGS recognition event and creates a COGS recognition transaction in Oracle Inventory that adjusts the ratio of earned and deferred COGS to match that of earned and deferred revenue. You must run this process after completion of the Collect Revenue Recognition Information concurrent process.


## Report Parameters
Ledger, Operating Unit, Period, Order Number, Sales Order Issue Date From, Sales Order Issue Date To, Ship From Warehouse, Organization, Display Matched Lines, Tolerance Amount, Display Cost Type, Category Set 1, Category Set 2, Category Set 3

## Oracle EBS Tables Used
[cst_revenue_cogs_match_lines](https://www.enginatics.com/library/?pg=1&find=cst_revenue_cogs_match_lines), [cst_cogs_events](https://www.enginatics.com/library/?pg=1&find=cst_cogs_events), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [perpetual_qry_1](https://www.enginatics.com/library/?pg=1&find=perpetual_qry_1), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [perpetual_qry_2](https://www.enginatics.com/library/?pg=1&find=perpetual_qry_2), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [perpetual_qry](https://www.enginatics.com/library/?pg=1&find=perpetual_qry)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Nidec changes](https://www.enginatics.com/library/?pg=1&category[]=Nidec%20changes), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST COGS Revenue Matching - Pivot Summary by COGS Account Deferred COGS Account 14-Feb-2024 152412.xlsx](https://www.enginatics.com/example/cst-cogs-revenue-matching/) |
| Blitz Report™ XML Import | [CST_COGS_Revenue_Matching.xml](https://www.enginatics.com/xml/cst-cogs-revenue-matching/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-cogs-revenue-matching/](https://www.enginatics.com/reports/cst-cogs-revenue-matching/) |

## Executive Summary
The **CST COGS Revenue Matching** report is essential for complying with the matching principle of accounting, which states that expenses (Cost of Goods Sold) should be recognized in the same period as the related revenue. In Oracle R12, this is handled by the "Deferred COGS" functionality. This report analyzes the synchronization between Revenue Recognition events in AR and the corresponding COGS Recognition events in Costing, ensuring that margins are reported accurately.

## Business Challenge
When a product is shipped, the revenue might not be recognized immediately (e.g., due to acceptance clauses).
*   **Margin Distortion**: If COGS is recognized upon shipment but Revenue is deferred, the current period shows a loss and a future period shows 100% profit.
*   **Audit Compliance**: Auditors require proof that the COGS recognition percentage exactly matches the Revenue recognition percentage for every sales order line.
*   **Stuck Transactions**: Identifying lines where Revenue has been recognized but COGS has failed to move from "Deferred" to "Actual".

## Solution
This report displays the earned and unearned (deferred) portions of both Revenue and COGS for sales orders.

**Key Features:**
*   **Percentage Comparison**: Shows the "Revenue Recognition %" vs. "COGS Recognition %" to highlight discrepancies.
*   **Account Visibility**: Displays the specific Deferred COGS and COGS accounts used.
*   **Process Validation**: Verifies that the "Generate COGS Recognition Events" program is working correctly.

## Architecture
The report queries `CST_REVENUE_COGS_MATCH_LINES` and `CST_COGS_EVENTS`, linking them to Order Management (`OE_ORDER_LINES_ALL`) and AR (`RA_CUSTOMER_TRX_LINES_ALL`).

**Key Tables:**
*   `CST_REVENUE_COGS_MATCH_LINES`: Stores the link between the sales order line and the revenue recognition percentage.
*   `CST_COGS_EVENTS`: The history of COGS recognition transactions.
*   `OE_ORDER_LINES_ALL`: The sales order line.
*   `RA_CUSTOMER_TRX_LINES_ALL`: The AR invoice line.

## Impact
*   **Margin Accuracy**: Ensures that gross margin analysis is meaningful by aligning costs with revenues.
*   **Financial Compliance**: Supports adherence to GAAP/IFRS revenue recognition standards (e.g., ASC 606).
*   **Troubleshooting**: Identifies specific orders where the COGS recognition process has stalled.


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
