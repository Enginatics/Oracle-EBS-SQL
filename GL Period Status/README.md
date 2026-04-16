---
layout: default
title: 'GL Period Status | Oracle EBS SQL Report'
description: 'Accounting period status of all application modules for all or a selected list of ledgers, operating units and inventory organizations. To see if an…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Period, Status, fnd_application_vl, gl_ledgers, hr_operating_units'
permalink: /GL%20Period%20Status/
---

# GL Period Status – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-period-status/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Accounting period status of all application modules for all or a selected list of ledgers, operating units and inventory organizations. To see if an accounting period should be opened, use the CAC Accounting Period Status report, as it has more reporting options and features.

## Report Parameters
Period From, Period To, Ledger, Chart of Accounts, Application

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=gl_period_statuses), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report"), [CAC Receiving Account Detail](/CAC%20Receiving%20Account%20Detail/ "CAC Receiving Account Detail Oracle EBS SQL Report"), [CAC Inventory Periods Not Closed or Summarized](/CAC%20Inventory%20Periods%20Not%20Closed%20or%20Summarized/ "CAC Inventory Periods Not Closed or Summarized Oracle EBS SQL Report"), [CAC Receiving Account Summary](/CAC%20Receiving%20Account%20Summary/ "CAC Receiving Account Summary Oracle EBS SQL Report"), [CAC Missing Receiving Accounting Transactions](/CAC%20Missing%20Receiving%20Accounting%20Transactions/ "CAC Missing Receiving Accounting Transactions Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/gl-period-status/) |
| Blitz Report™ XML Import | [GL_Period_Status.xml](https://www.enginatics.com/xml/gl-period-status/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-period-status/](https://www.enginatics.com/reports/gl-period-status/) |

## GL Period Status - Case Study & Technical Analysis

### Executive Summary
The **GL Period Status** report provides a centralized view of the accounting period statuses across all Oracle EBS modules (GL, AP, AR, PO, INV, etc.). It allows finance managers and system administrators to quickly verify which periods are Open, Closed, or Permanently Closed for specific ledgers and operating units. This report is a critical tool for managing the month-end close process efficiently.

### Business Use Cases
*   **Month-End Close Monitoring**: Provides a single dashboard to check if all subledgers (Payables, Receivables, Inventory) have been successfully closed before closing the General Ledger.
*   **Troubleshooting Posting Errors**: Helps identify if a transaction failed to post because a specific module's period was accidentally closed or never opened.
*   **Audit Compliance**: Documents the precise status of periods at a given point in time, proving that periods were closed in a timely manner.
*   **Multi-Org Management**: Essential for shared service centers managing dozens of entities, allowing them to see the status of all ledgers in one list.

### Technical Analysis

#### Core Tables
*   `GL_PERIOD_STATUSES`: The primary table storing the status (`O`=Open, `C`=Closed, `F`=Future, `N`=Never Opened) for each application and period.
*   `FND_APPLICATION_VL`: Resolves the Application ID to a name (e.g., "General Ledger", "Payables").
*   `GL_LEDGERS`: Defines the ledger context.
*   `HR_OPERATING_UNITS`: Links subledger statuses to their respective Operating Units.
*   `ORG_ACCT_PERIODS`: (For Inventory) Stores the specific period statuses for Inventory Organizations.

#### Key Joins & Logic
*   **Cross-Module Aggregation**: The query likely unions data from `GL_PERIOD_STATUSES` (for financial modules) and `ORG_ACCT_PERIODS` (for inventory) to provide a unified view.
*   **Status Decoding**: Translates the internal status codes (O, C, F, N, P) into user-friendly descriptions.
*   **Hierarchy Resolution**: Links Inventory Orgs to Operating Units and Operating Units to Ledgers to allow filtering at any level of the organization structure.

#### Key Parameters
*   **Period From/To**: The range of periods to check.
*   **Ledger**: Filter by specific ledger.
*   **Application**: Filter by specific module (e.g., show only "Payables" status).


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
