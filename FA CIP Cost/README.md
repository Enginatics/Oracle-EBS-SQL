---
layout: default
title: 'FA CIP Cost | Oracle EBS SQL Report'
description: 'CIP Costs Summary/Detail Report Equivalent to Oracle Standard Reports: CIP Summary Report CIP Detail Report DB package: XXENFAFASXMLP'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CIP, Cost, fa_system_controls, gl_ledgers, fnd_currencies'
permalink: /FA%20CIP%20Cost/
---

# FA CIP Cost – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-cip-cost/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
CIP Costs Summary/Detail Report

Equivalent to Oracle Standard Reports:
CIP Summary Report
CIP Detail Report

DB package: XXEN_FA_FAS_XMLP

## Report Parameters
Book, Set of Books Currency, From Period, To Period

## Oracle EBS Tables Used
[fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [fa_balances_report_gt](https://www.enginatics.com/library/?pg=1&find=fa_balances_report_gt), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FA Asset Cost](/FA%20Asset%20Cost/ "FA Asset Cost Oracle EBS SQL Report"), [FA Revaluation Reserve](/FA%20Revaluation%20Reserve/ "FA Revaluation Reserve Oracle EBS SQL Report"), [FA Depreciation Reserve](/FA%20Depreciation%20Reserve/ "FA Depreciation Reserve Oracle EBS SQL Report"), [FA Tax Reserve Ledger](/FA%20Tax%20Reserve%20Ledger/ "FA Tax Reserve Ledger Oracle EBS SQL Report"), [FA Journal Entry Reserve Ledger](/FA%20Journal%20Entry%20Reserve%20Ledger/ "FA Journal Entry Reserve Ledger Oracle EBS SQL Report"), [FA Cost Adjustments](/FA%20Cost%20Adjustments/ "FA Cost Adjustments Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA CIP Cost 30-Aug-2021 075221.xlsx](https://www.enginatics.com/example/fa-cip-cost/) |
| Blitz Report™ XML Import | [FA_CIP_Cost.xml](https://www.enginatics.com/xml/fa-cip-cost/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-cip-cost/](https://www.enginatics.com/reports/fa-cip-cost/) |

## Executive Summary
The **FA CIP Cost** report tracks Construction-In-Process (CIP) assets. It details the costs accumulated for assets that are being built or installed but are not yet placed in service. This is crucial for managing capital projects and ensuring timely capitalization.

## Business Challenge
*   **Capital Project Tracking:** Monitoring the spend on ongoing projects.
*   **Timely Capitalization:** Identifying projects that are complete and should be moved to active assets to start depreciation.
*   **Expense vs. Capital:** Verifying that only valid capital costs are accumulating in CIP accounts.

## The Solution
This Blitz Report provides visibility into CIP accounts by:
*   **Summary & Detail:** Offering both high-level project totals and detailed invoice line items.
*   **Aging Analysis:** Helping identify old CIP items that may need write-off or capitalization.
*   **Reconciliation:** Matching CIP subledger balances to the General Ledger CIP account.

## Technical Architecture
Equivalent to the standard CIP Summary/Detail reports, it queries `FA_ADDITIONS` where the asset type is 'CIP'. It sums up the cost from `FA_BOOKS` and details from `FA_ASSET_INVOICES`.

## Parameters & Filtering
*   **Book:** The corporate book used for tracking CIP.
*   **Period:** The reporting period (usually the current open period).

## Performance & Optimization
*   **Clean Up:** Regularly capitalizing or expensing CIP items keeps this report performant and the subledger clean.
*   **Detail Level:** Running in "Detail" mode can produce many rows if there are many small invoices attached to CIP assets.

## FAQ
*   **Q: Do CIP assets depreciate?**
    *   A: No, CIP assets do not depreciate until they are capitalized and placed in service.
*   **Q: How do I move items off this report?**
    *   A: You must perform a "Capitalization" transaction in Oracle Assets to move them from CIP to Capitalized status.


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
