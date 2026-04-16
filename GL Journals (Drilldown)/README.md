---
layout: default
title: 'GL Journals (Drilldown) | Oracle EBS SQL Report'
description: 'This report is used by the GL Financial Statement and Drilldown report, to show Journal details. GL batches and journals report, including amounts and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Journals, (Drilldown), per_people_f, gl_budget_versions, gl_encumbrance_types'
permalink: /GL%20Journals%20%28Drilldown%29/
---

# GL Journals (Drilldown) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-journals-drilldown/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
** This report is used by the GL Financial Statement and Drilldown report, to show Journal details. **

GL batches and journals report, including amounts and attachments.To enable next level drilldown below columns should be present in Display columns of the custom templates
Drill To Subledger
Drill To Journal Attachment
Drill To Full Journal

## Report Parameters
Ledger, Period, Ledger ID, Journal Source, Journal Category, Posting Status, Batch, Batch ID, Journal, Journal Header ID, Journal Line Num, Concatenated Segments, Code Combination ID, Restrict CCIDs through GTT, Restrict JHI through GTT, Currency, Show Attachment Details, Balance Type, Budget Name, Encumbrance Type, Amount Type, Creation Date From, Creation Date To, Created By, Posted Date From, Posted Date To, Funds Status, Reference

## Oracle EBS Tables Used
[per_people_f](https://www.enginatics.com/library/?pg=1&find=per_people_f), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers), [gl_system_usages](https://www.enginatics.com/library/?pg=1&find=gl_system_usages), [zx_rates_b](https://www.enginatics.com/library/?pg=1&find=zx_rates_b), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_je_batches](https://www.enginatics.com/library/?pg=1&find=gl_je_batches), [gl_je_sources_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_sources_vl), [gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines), [gl_je_lines_recon](https://www.enginatics.com/library/?pg=1&find=gl_je_lines_recon), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [fnd_attached_documents](https://www.enginatics.com/library/?pg=1&find=fnd_attached_documents), [fnd_documents](https://www.enginatics.com/library/?pg=1&find=fnd_documents), [fnd_documents_tl](https://www.enginatics.com/library/?pg=1&find=fnd_documents_tl), [fnd_document_datatypes](https://www.enginatics.com/library/?pg=1&find=fnd_document_datatypes), [fnd_document_categories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_document_categories_vl), [fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs), [fnd_documents_short_text](https://www.enginatics.com/library/?pg=1&find=fnd_documents_short_text), [fnd_documents_long_text](https://www.enginatics.com/library/?pg=1&find=fnd_documents_long_text)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/gl-journals-drilldown/) |
| Blitz Report™ XML Import | [GL_Journals_Drilldown.xml](https://www.enginatics.com/xml/gl-journals-drilldown/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-journals-drilldown/](https://www.enginatics.com/reports/gl-journals-drilldown/) |

## GL Journals (Drilldown) - Case Study & Technical Analysis

### Executive Summary
The **GL Journals (Drilldown)** report is a specialized variation of the standard GL Journals report, specifically engineered to serve as the "target" for drill-down operations from high-level financial statements (like the FSG report). It is optimized to accept specific context parameters (such as a Journal Header ID or a specific Account/Period combination) passed from a parent report, allowing users to instantly view the granular details behind a summary balance.

### Business Use Cases
*   **Interactive Financial Analysis**: Enables a seamless workflow where a CFO or controller reviewing a Balance Sheet can click on a "Cash" balance and immediately see the list of journals comprising that figure.
*   **Variance Investigation**: Facilitates rapid root-cause analysis of budget-to-actual variances by drilling down to the transaction level.
*   **Subledger Connectivity**: Often acts as a bridge, allowing further drill-down from the GL Journal line to the underlying Subledger transaction (e.g., the specific AP Invoice).

### Technical Analysis

#### Core Tables
*   `GL_JE_HEADERS`: The entry point for the drill-down, often filtered by `JE_HEADER_ID`.
*   `GL_JE_LINES`: The detailed lines associated with the header.
*   `GL_IMPORT_REFERENCES`: (Implicitly used in subledger drill-downs) Links GL lines back to XLA/Subledger tables.

#### Key Joins & Logic
*   **Parameter-Driven Filtering**: Unlike the standard report which uses broad ranges (Date, Period), this report is designed to handle specific IDs (`JE_HEADER_ID`, `JE_LINE_NUM`) or precise combinations (`CODE_COMBINATION_ID`) passed from the calling application.
*   **Performance Optimization**: The query is likely tuned for "lookup by ID" operations to ensure instant response times during interactive drill-down sessions.

#### Key Parameters
*   **Journal Header ID**: The primary key for a specific journal entry.
*   **Batch ID**: The primary key for a specific batch.
*   **Code Combination ID**: The unique identifier for an account string.


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
