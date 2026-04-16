---
layout: default
title: 'FND Histogram Columns | Oracle EBS SQL Report'
description: 'Data from table fndhistogramcols, which Oracle uses to identify columns which are expected to have highly skewed data, for example a status column having…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Histogram, Columns, fnd_histogram_cols, fnd_application_vl, fnd_product_installations'
permalink: /FND%20Histogram%20Columns/
---

# FND Histogram Columns – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-histogram-columns/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Data from table fnd_histogram_cols, which Oracle uses to identify columns which are expected to have highly skewed data, for example a status column having a large number of closed, but only a small number of open records.
The Gather Schema and Gather Table Statistics concurrent programs use this information to create additional histrogram statistics for these columns.

To add a column to this table, use the following API:
declare
l_table_name varchar2(30):='AP_INVOICES_ALL';
l_column_name varchar2(30):='ORG_ID';
begin
for c in (
  select
  fpi.application_id
  from
  fnd_oracle_userid fou,
  fnd_product_installations fpi
  where
  xxen_util.instring(xxen_api.object_owner_type(l_table_name),'.',1)=fou.oracle_username and
  fou.oracle_id=fpi.oracle_id
  ) loop
    fnd_stats.load_histogram_cols(
    action =>'INSERT',
    appl_id =>c.application_id,
    tabname =>l_table_name,
    colname =>l_column_name,
    commit_flag =>'Y');
  end loop;
end;

## Report Parameters
Application, Table Name

## Oracle EBS Tables Used
[fnd_histogram_cols](https://www.enginatics.com/library/?pg=1&find=fnd_histogram_cols), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_product_installations](https://www.enginatics.com/library/?pg=1&find=fnd_product_installations), [fnd_oracle_userid](https://www.enginatics.com/library/?pg=1&find=fnd_oracle_userid)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Lookup Search](/FND%20Lookup%20Search/ "FND Lookup Search Oracle EBS SQL Report"), [FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [FND Applications](/FND%20Applications/ "FND Applications Oracle EBS SQL Report"), [FND Data Groups](/FND%20Data%20Groups/ "FND Data Groups Oracle EBS SQL Report"), [CAC Accounting Period Status](/CAC%20Accounting%20Period%20Status/ "CAC Accounting Period Status Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Histogram Columns 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/fnd-histogram-columns/) |
| Blitz Report™ XML Import | [FND_Histogram_Columns.xml](https://www.enginatics.com/xml/fnd-histogram-columns/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-histogram-columns/](https://www.enginatics.com/reports/fnd-histogram-columns/) |



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
