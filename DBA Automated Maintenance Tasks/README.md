---
layout: default
title: 'DBA Automated Maintenance Tasks | Oracle EBS SQL Report'
description: 'There are several automated jobs and ''advisors'' running by default in an Oracle database that are often not required or should not run in Oracle EBS…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Automated, Maintenance, Tasks, dba_autotask_window_clients'
permalink: /DBA%20Automated%20Maintenance%20Tasks/
---

# DBA Automated Maintenance Tasks – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-automated-maintenance-tasks/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
There are several automated jobs and 'advisors' running by default in an Oracle database that are often not required or should not run in Oracle EBS environments. Their status and history can be queried by the following SQLs:
select dao.* from dba_autotask_operation dao
select dajh.* from dba_autotask_job_history dajh

- Automatic Optimizer Statistics Collection
For EBS, the automated DB statistics collection must be deactivated by setting DB initialization parameter _optimizer_autostats_job=false, and concurrent 'Gather Schema Statistics' scheduled instead, see note KA1002 <a href="https://support.oracle.com/support/?kmContentId=11158187" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=11158187</a>

- Automatic Segment Advisor
Identifies segments that have space available for reclamation, and makes recommendations on how to defragment those segments. This process causes significant IO overhead and we therefore recommend disabling the automated scheduling. It can be run on demand instead, in case DBAs would want to take action on optimizing the storage.

- Automatic SQL Tuning Advisor
Examines the performance of high-load SQL statements, and makes recommendations on how to tune those statements. In EBS environents, such automated tuning recommendations are typically useless, as the majority of performance issues is caused by incorrect custom SQL coding, e.g. lack of where-clause restrictions to allow index access or coding that prevents the optimizer from executing queries efficiently. The automatic tuning advisor can not optimize such SQLs, as it can not modify the SQL logic, which is required for most scenarios. We recommend deactivating the advisor to reduce processing overhead.

- Automatic Database Diagnostic Monitor (ADDM)
This job runs after each AWR snapshot and creates performance tuning recommendations. In environments which are  not actively monitored by DBAs such as development or test systems, this should be deactivated by setting alter system set "_addm_auto_enable"=false.
Blitz Report's DBA AWR reports give better and more detailed insights into performance bottlenecks, such as wait times or problematic SQLs.

To deactivate automated tasks individually, execute the following commands:
exec dbms_auto_task_admin.disable(client_name=>'auto optimizer stats collection',operation=>null,window_name=>null);
exec dbms_auto_task_admin.disable(client_name=>'auto space advisor',operation=>null,window_name=>null);
exec dbms_auto_task_admin.disable(client_name=>'sql tuning advisor', operation=>null,window_name=>null);

To deactivate all automated tasks completely, execute the following commands:
exec dbms_auto_task_admin.disable;
alter system set "_addm_auto_enable"=false;

## Report Parameters


## Oracle EBS Tables Used
[dba_autotask_window_clients](https://www.enginatics.com/library/?pg=1&find=dba_autotask_window_clients)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA AWR Wait Event Summary (active session history)](/DBA%20AWR%20Wait%20Event%20Summary%20%28active%20session%20history%29/ "DBA AWR Wait Event Summary (active session history) Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Attribute Master/Child Conflicts](/INV%20Item%20Attribute%20Master-Child%20Conflicts/ "INV Item Attribute Master/Child Conflicts Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [FND Key Flexfields](/FND%20Key%20Flexfields/ "FND Key Flexfields Oracle EBS SQL Report"), [FND Descriptive Flexfields](/FND%20Descriptive%20Flexfields/ "FND Descriptive Flexfields Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/dba-automated-maintenance-tasks/) |
| Blitz Report™ XML Import | [DBA_Automated_Maintenance_Tasks.xml](https://www.enginatics.com/xml/dba-automated-maintenance-tasks/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-automated-maintenance-tasks/](https://www.enginatics.com/reports/dba-automated-maintenance-tasks/) |

## Executive Summary
The **DBA Automated Maintenance Tasks** report audits the status of the Oracle Database's built-in automated maintenance jobs. In an Oracle E-Business Suite (EBS) environment, many of these default tasks (like the Automatic Optimizer Statistics Collection) conflict with EBS-specific best practices and must be disabled or carefully managed to prevent performance degradation.

## Business Challenge
*   **EBS Compliance**: Oracle EBS has its own specific method for gathering statistics (`FND_STATS`). The default database job can overwrite these with suboptimal stats, causing severe performance regressions.
*   **Resource Contention**: The "Segment Advisor" or "SQL Tuning Advisor" can consume significant I/O and CPU during their maintenance windows, potentially impacting batch jobs.
*   **Configuration Drift**: Ensuring that these jobs haven't been accidentally re-enabled during a database upgrade or patch.

## Solution
This report lists the configuration and run history of the automated tasks.

**Key Features:**
*   **Status Check**: Shows whether "Auto Optimizer Stats", "Segment Advisor", and "SQL Tuning Advisor" are Enabled or Disabled.
*   **Run History**: Shows when these jobs last ran and their duration.

## Architecture
The report queries the Scheduler and Autotask views.

**Key Tables:**
*   `DBA_AUTOTASK_WINDOW_CLIENTS`: Shows the status of tasks per maintenance window.
*   `DBA_AUTOTASK_OPERATION`: Operation details.
*   `DBA_AUTOTASK_JOB_HISTORY`: Execution logs.

## Impact
*   **Performance Stability**: Prevents the "Monday Morning Meltdown" caused by bad statistics gathered automatically over the weekend.
*   **Best Practice Adherence**: Verifies the system is configured according to Oracle Support Note 396009.1.
*   **Resource Optimization**: Reclaims system resources by disabling unnecessary background tasks.


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
