---
layout: default
title: 'GL Journals (Drilldown) 11g | Oracle EBS SQL Report'
description: 'GL batches and journals report, including amounts and attachments.This report is used by the GL Financial Statement and Drilldown report, to show…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Journals, (Drilldown), 11g, gl_code_combinations_kfv, per_people_f, gl_je_sources_vl'
permalink: /GL%20Journals%20%28Drilldown%29%2011g/
---

# GL Journals (Drilldown) 11g – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-journals-drilldown-11g/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
GL batches and journals report, including amounts and attachments.This report is used by the GL Financial Statement and Drilldown report, to show subledger details.

## Report Parameters
Ledger, Period, Ledger ID, Journal Source, Journal Category, Status, Batch, Batch ID, Journal, Journal Header ID, Journal Line Num, Concatenated Segments, Code Combination ID, Currency, Show Attachment Details, Balance Type, Budget Name, Encumbrance Type, Amount Type

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [per_people_f](https://www.enginatics.com/library/?pg=1&find=per_people_f), [gl_je_sources_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_sources_vl), [gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers), [gl_system_usages](https://www.enginatics.com/library/?pg=1&find=gl_system_usages), [zx_rates_b](https://www.enginatics.com/library/?pg=1&find=zx_rates_b), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_je_batches](https://www.enginatics.com/library/?pg=1&find=gl_je_batches), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines), [gl_je_lines_recon](https://www.enginatics.com/library/?pg=1&find=gl_je_lines_recon), [gcck](https://www.enginatics.com/library/?pg=1&find=gcck), [fnd_attached_documents](https://www.enginatics.com/library/?pg=1&find=fnd_attached_documents), [fnd_documents](https://www.enginatics.com/library/?pg=1&find=fnd_documents), [fnd_documents_tl](https://www.enginatics.com/library/?pg=1&find=fnd_documents_tl), [fnd_document_datatypes](https://www.enginatics.com/library/?pg=1&find=fnd_document_datatypes), [fnd_document_categories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_document_categories_vl), [fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs), [fnd_documents_short_text](https://www.enginatics.com/library/?pg=1&find=fnd_documents_short_text), [fnd_documents_long_text](https://www.enginatics.com/library/?pg=1&find=fnd_documents_long_text)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Journals](/GL%20Journals/ "GL Journals Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/gl-journals-drilldown-11g/) |
| Blitz Report™ XML Import | [GL_Journals_Drilldown_11g.xml](https://www.enginatics.com/xml/gl-journals-drilldown-11g/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-journals-drilldown-11g/](https://www.enginatics.com/reports/gl-journals-drilldown-11g/) |

## GL Journals (Drilldown) 11g - Case Study & Technical Analysis

### Executive Summary
The **GL Journals (Drilldown) 11g** report is a version of the drill-down report tailored for Oracle Database 11g environments or specific legacy configurations. It shares the same functional purpose as the standard drill-down report—providing detailed journal views from summary reports—but may contain SQL syntax or optimization hints specific to the 11g optimizer to ensure performance stability in that environment.

### Business Use Cases
*   **Legacy System Support**: Ensures that organizations running on older Oracle database versions maintain fast and reliable drill-down capabilities.
*   **Performance Tuning**: May include specific optimizer hints (`/*+ INDEX(...) */`) that were necessary in 11g but might be deprecated or unnecessary in 12c/19c.
*   **Consistent User Experience**: Provides the same "click-through" analysis experience for end-users regardless of the underlying database version.

### Technical Analysis

#### Core Tables
*   `GL_JE_HEADERS`
*   `GL_JE_LINES`
*   `GL_JE_BATCHES`

#### Key Joins & Logic
*   **11g Specifics**: The primary difference lies in the SQL construction. It might avoid certain analytical functions or lateral joins that were introduced or optimized in later versions.
*   **Drill-down Context**: Accepts parameters like `JE_HEADER_ID` to fetch specific records.

#### Key Parameters
*   **Journal Header ID**: Target journal to display.
*   **Period**: Accounting period context.


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
