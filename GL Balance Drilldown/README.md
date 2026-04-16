---
layout: default
title: 'GL Balance Drilldown | Oracle EBS SQL Report'
description: 'Shows GL balance details by code combination. Uses glbalances for standard queries, gljelines when filtering by journal source/category or using JED…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Balance, Drilldown, gl_ledgers, gl_code_combinations_kfv, gl_balances'
permalink: /GL%20Balance%20Drilldown/
---

# GL Balance Drilldown – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-balance-drilldown/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Shows GL balance details by code combination. Uses gl_balances for standard queries, gl_je_lines when filtering by journal source/category or using JED balance types.

## Report Parameters
Ledger ID, Period Name, Balance Type, Currency Code, Translated Flag, Actual Flag, Budget Name, Encumbrance Type, Journal Source, Journal Category, Multiplier

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [gl_balances](https://www.enginatics.com/library/?pg=1&find=gl_balances), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types), [xxen_report_temp_ids](https://www.enginatics.com/library/?pg=1&find=xxen_report_temp_ids), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_je_sources_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_sources_vl), [gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Journals (Drilldown) 11g](/GL%20Journals%20%28Drilldown%29%2011g/ "GL Journals (Drilldown) 11g Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/gl-balance-drilldown/) |
| Blitz Report™ XML Import | [GL_Balance_Drilldown.xml](https://www.enginatics.com/xml/gl-balance-drilldown/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-balance-drilldown/](https://www.enginatics.com/reports/gl-balance-drilldown/) |



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
