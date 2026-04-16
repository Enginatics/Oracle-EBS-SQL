---
layout: default
title: 'DBA Table Modifications | Oracle EBS SQL Report'
description: 'If table monitoring is activated, dbatabmodifications shows the number of rows modified since the last time a table was analyzed.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Table, Modifications, dba_tab_modifications, dba_tables'
permalink: /DBA%20Table%20Modifications/
---

# DBA Table Modifications – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-table-modifications/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
If table monitoring is activated, dba_tab_modifications shows the number of rows modified since the last time a table was analyzed.

## Report Parameters
Changes per Day From, Last Analyzed within x Days

## Oracle EBS Tables Used
[dba_tab_modifications](https://www.enginatics.com/library/?pg=1&find=dba_tab_modifications), [dba_tables](https://www.enginatics.com/library/?pg=1&find=dba_tables)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Report VPD Policy Setup](/Blitz%20Report%20VPD%20Policy%20Setup/ "Blitz Report VPD Policy Setup Oracle EBS SQL Report"), [FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [DBA Object Access Privileges](/DBA%20Object%20Access%20Privileges/ "DBA Object Access Privileges Oracle EBS SQL Report"), [DBA Table Columns](/DBA%20Table%20Columns/ "DBA Table Columns Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [FND Lookup Search](/FND%20Lookup%20Search/ "FND Lookup Search Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Table Modifications 14-Oct-2021 105513.xlsx](https://www.enginatics.com/example/dba-table-modifications/) |
| Blitz Report™ XML Import | [DBA_Table_Modifications.xml](https://www.enginatics.com/xml/dba-table-modifications/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-table-modifications/](https://www.enginatics.com/reports/dba-table-modifications/) |

## Case Study & Technical Analysis

### Abstract
The **DBA Table Modifications** report leverages the database's internal monitoring mechanism to track data manipulation language (DML) activity. It queries `DBA_TAB_MODIFICATIONS`, which records the approximate number of `INSERT`, `UPDATE`, and `DELETE` operations performed on a table since the last time optimizer statistics were gathered. This report is essential for understanding data volatility and tuning statistics gathering strategies.

### Technical Analysis

#### Core Metrics
*   **Inserts/Updates/Deletes**: The raw count of row changes.
*   **Timestamp**: The time of the last analysis vs. the timestamp of the modification data.
*   **Truncated**: A flag indicating if the table was truncated (which resets the high water mark but might not trigger a stats update immediately).

#### Key View
*   `DBA_TAB_MODIFICATIONS`: This view is populated by the database kernel in memory and flushed to disk periodically (or manually via `DBMS_STATS.FLUSH_DATABASE_MONITORING_INFO`).

#### Operational Use Cases
*   **Stale Statistics**: Identifying tables that have changed significantly (e.g., >10% of rows) but haven't been analyzed, leading to poor execution plans.
*   **Batch Verification**: Confirming that a nightly load job actually processed data.
*   **Volatility Profiling**: Distinguishing between static lookup tables and high-churn transaction tables.


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
