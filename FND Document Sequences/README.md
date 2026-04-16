---
layout: default
title: 'FND Document Sequences | Oracle EBS SQL Report'
description: 'Document sequence details including database sequence name and last seqeunce number.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Document, Sequences, dba_sequences, fnd_application_vl, fnd_document_sequences'
permalink: /FND%20Document%20Sequences/
---

# FND Document Sequences – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-document-sequences/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Document sequence details including database sequence name and last seqeunce number.

## Report Parameters
Application, Table Name

## Oracle EBS Tables Used
[dba_sequences](https://www.enginatics.com/library/?pg=1&find=dba_sequences), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_document_sequences](https://www.enginatics.com/library/?pg=1&find=fnd_document_sequences)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Document Sequence Assignments](/FND%20Document%20Sequence%20Assignments/ "FND Document Sequence Assignments Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Document Sequences 24-May-2025 131533.xlsx](https://www.enginatics.com/example/fnd-document-sequences/) |
| Blitz Report™ XML Import | [FND_Document_Sequences.xml](https://www.enginatics.com/xml/fnd-document-sequences/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-document-sequences/](https://www.enginatics.com/reports/fnd-document-sequences/) |

## Executive Summary
The **FND Document Sequences** report provides a master list of all defined document sequences in the system, regardless of whether they are currently assigned.

## Business Challenge
*   **Sequence Management:** Monitoring the consumption of sequences to prevent running out of numbers (e.g., hitting the maximum value).
*   **Cleanup:** Identifying old or unused sequences from previous years.
*   **Type Analysis:** Reviewing which sequences are "Gapless" vs. "Automatic".

## The Solution
This Blitz Report details the sequence definition:
*   **Sequence Name:** The name of the sequence object.
*   **Type:** Automatic, Manual, or Gapless.
*   **Initial Value:** The starting number.
*   **Current Value:** The last number generated (from `DBA_SEQUENCES`).

## Technical Architecture
The report queries `FND_DOCUMENT_SEQUENCES` and joins to `DBA_SEQUENCES` to fetch the current state of the database object.

## Parameters & Filtering
*   **Application:** Filter by the owning application.
*   **Table Name:** Filter by the table the sequence is intended for.

## Performance & Optimization
*   **Fast Execution:** Runs quickly against the metadata tables.

## FAQ
*   **Q: What is the difference between this and the "Assignments" report?**
    *   A: This report lists the *sequences* themselves (the number generators). The "Assignments" report shows *where* those sequences are used (linked to a Category and Ledger).


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
