---
layout: default
title: 'FA Journal Entry Reserve Ledger | Oracle EBS SQL Report'
description: 'Imported Oracle standard journal entry reserve ledger report Source: Journal Entry Reserve Ledger Report (XML) Short Name: FAS400XML DB package…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Journal, Entry, Reserve, Ledger, fa_system_controls, gl_ledgers, fa_reserve_ledger_gt'
permalink: /FA%20Journal%20Entry%20Reserve%20Ledger/
---

# FA Journal Entry Reserve Ledger – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-journal-entry-reserve-ledger/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard journal entry reserve ledger report
Source: Journal Entry Reserve Ledger Report (XML)
Short Name: FAS400_XML
DB package: XXEN_FA_FAS_XMLP

## Report Parameters
Book, Set of Books Currency, Period

## Oracle EBS Tables Used
[fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fa_reserve_ledger_gt](https://www.enginatics.com/library/?pg=1&find=fa_reserve_ledger_gt), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [&lp_fa_deprn_summary](https://www.enginatics.com/library/?pg=1&find=&lp_fa_deprn_summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FA Asset Cost](/FA%20Asset%20Cost/ "FA Asset Cost Oracle EBS SQL Report"), [FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report"), [FA Tax Reserve Ledger](/FA%20Tax%20Reserve%20Ledger/ "FA Tax Reserve Ledger Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Asset Retirements](/FA%20Asset%20Retirements/ "FA Asset Retirements Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [FA Depreciation Reserve](/FA%20Depreciation%20Reserve/ "FA Depreciation Reserve Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Journal Entry Reserve Ledger 30-Aug-2021 053316.xlsx](https://www.enginatics.com/example/fa-journal-entry-reserve-ledger/) |
| Blitz Report™ XML Import | [FA_Journal_Entry_Reserve_Ledger.xml](https://www.enginatics.com/xml/fa-journal-entry-reserve-ledger/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-journal-entry-reserve-ledger/](https://www.enginatics.com/reports/fa-journal-entry-reserve-ledger/) |

## Executive Summary
The **FA Journal Entry Reserve Ledger** is a specialized report used to reconcile depreciation expense and the depreciation reserve with the General Ledger. It lists the journal entries created by the depreciation run.

## Business Challenge
*   **Journal Verification:** Ensuring that the depreciation run created the correct journal entries.
*   **Account Balance Proof:** Proving the balance of the Accumulated Depreciation account at the journal line level.
*   **Audit Compliance:** Providing a detailed list of all system-generated depreciation journals.

## The Solution
This Blitz Report replicates the standard `FAS400_XML` report, providing:
*   **Journal Details:** Listing the specific accounts and amounts credited/debited during depreciation.
*   **Asset-Level Granularity:** Showing which assets contributed to each journal line.
*   **Tying to GL:** Serving as the bridge between the FA subledger and GL journal batches.

## Technical Architecture
The report queries `FA_RESERVE_LEDGER_GT`, which is populated during the reporting process to show the breakdown of depreciation by account. It links back to `FA_ADDITIONS` for asset details.

## Parameters & Filtering
*   **Book:** The asset book.
*   **Period:** The period for which depreciation was run.

## Performance & Optimization
*   **Period Specific:** This report is strictly period-based. It is designed to be run after the depreciation close for that period.
*   **Data Volume:** Can be large if there are many assets and complex account distributions.

## FAQ
*   **Q: Why doesn't this match my GL?**
    *   A: Check if the depreciation journals have been posted to GL. Also, check for manual journals in GL that wouldn't be in this report.
*   **Q: Is this the same as the "Journal Entry Reserve Ledger" PDF?**
    *   A: Yes, it is the Excel version of that standard Oracle report.


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
