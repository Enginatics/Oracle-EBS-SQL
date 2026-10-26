---
layout: default
last_modified_at: 2026-10-26
title: 'FND Histogram Columns | Oracle EBS SQL Report'
description: 'Data from table fndhistogramcols, which Oracle uses to identify columns which are expected to have highly skewed data, for example a status column having…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Histogram, Columns, fnd_histogram_cols, fnd_application_vl, fnd_product_installations'
permalink: /FND%20Histogram%20Columns/
report_name: 'FND Histogram Columns'
report_web_name: fnd-histogram-columns
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Histogram Columns – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-histogram-columns/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Application, Table Name

## Oracle EBS Tables Used
[fnd_histogram_cols](https://www.enginatics.com/library/?pg=1&find=fnd_histogram_cols&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns), [fnd_product_installations](https://www.enginatics.com/library/?pg=1&find=fnd_product_installations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns), [fnd_oracle_userid](https://www.enginatics.com/library/?pg=1&find=fnd_oracle_userid&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns)

## Related Reports
[FND Lookup Search](/FND%20Lookup%20Search/ "FND Lookup Search Oracle EBS SQL Report"), [FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [DBA Users](/DBA%20Users/ "DBA Users Oracle EBS SQL Report"), [FND Applications](/FND%20Applications/ "FND Applications Oracle EBS SQL Report"), [FND Data Groups](/FND%20Data%20Groups/ "FND Data Groups Oracle EBS SQL Report"), [CAC Accounting Period Status](/CAC%20Accounting%20Period%20Status/ "CAC Accounting Period Status Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Histogram%20Columns/FND%20Histogram%20Columns.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Histogram Columns 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/fnd-histogram-columns/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns) |
| Blitz Report™ XML Import | [FND_Histogram_Columns.xml](https://www.enginatics.com/xml/fnd-histogram-columns/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns) |
| SQL Source | [FND Histogram Columns.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Histogram%20Columns/FND%20Histogram%20Columns.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-histogram-columns/](https://www.enginatics.com/reports/fnd-histogram-columns/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns) |

## Case Study & Technical Analysis: FND Histogram Columns

### Executive Summary
This report lists the table columns registered in the Oracle Application Object Library table `FND_HISTOGRAM_COLS`. These are the columns that Oracle expects to hold highly skewed data, such as a status column with many closed rows and only a few open ones. For each registration it shows the application, the schema owner, the table and column, the histogram size and the audit details. It is used by DBAs and EBS technical teams who tune the statistics gathered on the database, and who need to check which columns already receive histogram statistics before adding new ones.

### Business Challenge
*   **Skewed columns and poor plans:** When a column has a few rare values among many common ones, the optimizer can choose a poor plan unless it knows the value distribution.
*   **Statistics gathering across an EBS schema:** Gather Schema and Gather Table Statistics must know which columns need extra histograms, and that list must be correct for each application.
*   **Changing the list safely:** Columns are added to the list through an API, and the team needs to see the result of each change.
*   **Documentation for support:** Support teams need a current record of which columns were registered, by whom and when.

### The Solution
*   Reads every registration in `FND_HISTOGRAM_COLS` and shows the table name, the column name and the histogram size.
*   Resolves the application name and the Oracle schema owner of each registration, so the owner of the table is shown with the product.
*   Shows who created and last updated each registration, and when, using the user name and client time.
*   Sorts the output by application, table and column, so the registrations of one product are easy to compare.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_HISTOGRAM_COLS`: the registered histogram columns, with the table name, column name, histogram size, application identifier and audit columns.
*   `FND_APPLICATION_VL`: the application name and short name for each application identifier.
*   `FND_PRODUCT_INSTALLATIONS`: the installed products, linking each application identifier to an Oracle user identifier.
*   `FND_ORACLE_USERID`: the Oracle schema user name of each installed product.

#### Logical Relationships
1. `FND_HISTOGRAM_COLS` is joined to `FND_APPLICATION_VL` on application identifier, which gives the application name.
2. The same application identifier is joined to `FND_PRODUCT_INSTALLATIONS`.
3. The Oracle user identifier from the installation record is joined to `FND_ORACLE_USERID`, which gives the schema owner.
4. The result is ordered by application name, table name and column name.

### Parameters & Filtering
*   **Application:** limits the registrations to one EBS application.
*   **Table Name:** limits the registrations to one table.

### Performance & Optimization
*   The report reads a small registration table, so the joins to the application and installation data are inexpensive.
*   The application join is on the application identifier stored in the registration table, so the application name is taken from the same key that the registration uses.
*   The installation join returns the Oracle user of each product, which is needed for the owner column.
*   Because the output is sorted only on application, table and column, it is quick to review even when many products are installed.

### FAQ
**Q: How do I find out which columns already have histogram statistics defined?**
A: Run the report without parameters. Each row is a column registered in FND_HISTOGRAM_COLS, with its table, column and histogram size.

**Q: How do I see the histogram columns of one EBS product?**
A: Choose the product in the Application parameter. The owner column shows the Oracle schema of that product.

**Q: How do I add a column to this list?**
A: Columns are added through the FND_STATS loadhistogramcols API with the INSERT action, which takes the application identifier of the product that owns the table, the table name and the column name. The report then shows the new row.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-histogram-columns)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
