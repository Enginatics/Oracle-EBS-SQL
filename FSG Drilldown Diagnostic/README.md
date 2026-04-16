---
layout: default
title: 'FSG Drilldown Diagnostic | Oracle EBS SQL Report'
description: 'Troubleshooting report for FSG journal drilldown issues. Checks glbalances, posted/unposted journals, period status, account properties, and flex value…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FSG, Drilldown, Diagnostic, gl_code_combinations_kfv, gl_ledgers, gl_balances'
permalink: /FSG%20Drilldown%20Diagnostic/
---

# FSG Drilldown Diagnostic – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fsg-drilldown-diagnostic/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Troubleshooting report for FSG journal drilldown issues. Checks gl_balances, posted/unposted journals, period status, account properties, and flex value security for a given account and period. Use the GL segment parameters to filter to the specific account combination that is not drilling down.

## Report Parameters
Ledger, Period, GL_SEGMENT1, GL_SEGMENT2, GL_SEGMENT3, GL_SEGMENT4, GL_SEGMENT5, GL_SEGMENT6, GL_SEGMENT7, GL_SEGMENT8, GL_SEGMENT9

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_balances](https://www.enginatics.com/library/?pg=1&find=gl_balances), [gcck](https://www.enginatics.com/library/?pg=1&find=gcck), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines), [gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=gl_period_statuses), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Balance Drilldown](/GL%20Balance%20Drilldown/ "GL Balance Drilldown Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Code Combinations](/GL%20Code%20Combinations/ "GL Code Combinations Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fsg-drilldown-diagnostic/) |
| Blitz Report™ XML Import | [FSG_Drilldown_Diagnostic.xml](https://www.enginatics.com/xml/fsg-drilldown-diagnostic/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fsg-drilldown-diagnostic/](https://www.enginatics.com/reports/fsg-drilldown-diagnostic/) |



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
