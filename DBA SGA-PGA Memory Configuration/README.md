---
layout: default
last_modified_at: 2026-10-19
title: 'DBA SGA+PGA Memory Configuration | Oracle EBS SQL Report'
description: 'Current SGA and PGA memory configuration in gigabytes. A frequent configuration problem is not making full use of the available hardware resources…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, SGA+PGA, Memory, Configuration, dba_hist_snapshot, dba_hist_sqlstat, dba_hist_sqltext'
permalink: /DBA%20SGA-PGA%20Memory%20Configuration/
report_name: 'DBA SGA+PGA Memory Configuration'
report_web_name: dba-sga-pga-memory-configuration
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA SGA+PGA Memory Configuration – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sga-pga-memory-configuration/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Current SGA and PGA memory configuration in gigabytes.

A frequent configuration problem is not making full use of the available hardware resources, especially the physical RAM of the database server.
This report shows the servers SGA, PGA and CPU configuration in comparison to the available hardware.
For maximum performance, configure the SGA+PGA to use the full available memory of your server minus a few gig for OS level caching, e.g. for writing and reading of PLSQL output files on the DB node and for process memory (an estimated 4MB per process, see below).

Oracle's performance tuning guide:
<a href="https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgdba/database-memory-allocation.html" rel="nofollow" target="_blank">https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgdba/database-memory-allocation.html</a>

Oracle's exadata best practices whitepaper:
SUM of databases (SGA_TARGET + PGA_AGGREGATE_TARGET) + 4 MB * (Maximum PROCESSES) < Physical Memory per Database Node

Tom Kyte's recommendation:
"... if you want it all automatic, give ALL FREE MEMORY on your machine to the SGA and be done with it. No more monitoring, no more thinking about how it could be, should be, would be used.
Set the PGA aggregate target and the SGA target to be a tad less than physical memory on the machine and you are done."
<a href="https://asktom.oracle.com/pls/asktom/f?p=100:11:0::::P11_QUESTION_ID:30011178429375" rel="nofollow" target="_blank">https://asktom.oracle.com/pls/asktom/f?p=100:11:0::::P11_QUESTION_ID:30011178429375</a>

Database created or cloned is the date of the last clone: the controlfile creation date, which Rapid Clone and RMAN DUPLICATE reset, or the PDB creation date on a multitenant database if that is later.

The report also shows the status of system statistics.
select * from sys.aux_stats$

If CPUSPEEDNW still shows the default of 4096, it either means that the stats have never been gathered or it could also mean that your storage is too fast to gather them with the standard NOWORKLOAD method and you should set reasonable values manually then.
exec dbms_stats.gather_system_stats();
exec dbms_stats.set_system_stats('IOSEEKTIM',1);
exec dbms_stats.set_system_stats('IOTFRSPEED',85782);

There is also an Exadata mode, considering the faster storage correctly and updating the MBRC too
exec dbms_stats.gather_system_stats(‘EXADATA');

The following command checks if hugepages are configured and how many are in use:
grep Huge /proc/meminfo
<a href="https://access.redhat.com/solutions/320303" rel="nofollow" target="_blank">https://access.redhat.com/solutions/320303</a>

To configure hugepages, set the vm.nr_hugepages in the /etc/sysctl.conf file and hard and soft memlock in /etc/security/limits.conf for the oracle user.
/etc/sysctl.conf
vm.nr_hugepages = SGA GB x 512 + 5
/etc/security/limits.conf
oracle               soft    memlock (SGA GB x 512 + 5) * 2048
oracle               hard    memlock (SGA GB x 512 + 5) * 2048
<a href="https://www.enginatics.com/blog/how-to-configure-hugepages-for-oracle-ebs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration" rel="nofollow" target="_blank">https://www.enginatics.com/blog/how-to-configure-hugepages-for-oracle-ebs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration</a>

Check if all database parameters are set according to Oracle's requirement:
Database Initialization Parameters for Oracle E-Business Suite Release 12 (KA1002)
<a href="https://support.oracle.com/support/?kmContentId=11158187" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=11158187</a>

To perform this check automatically, install and run Oracle's 'Database Performance and Statistics Analyzer' concurrent program (KB627702)
<a href="https://support.oracle.com/rs?type=doc&id=2126712" rel="nofollow" target="_blank">https://support.oracle.com/rs?type=doc&id=2126712</a>

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [dba_hist_sqlstat](https://www.enginatics.com/library/?pg=1&find=dba_hist_sqlstat&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [dba_hist_sqltext](https://www.enginatics.com/library/?pg=1&find=dba_hist_sqltext&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [gv$osstat](https://www.enginatics.com/library/?pg=1&find=gv%24osstat&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [gv$system_parameter](https://www.enginatics.com/library/?pg=1&find=gv%24system_parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [gv$sgainfo](https://www.enginatics.com/library/?pg=1&find=gv%24sgainfo&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [gv$instance](https://www.enginatics.com/library/?pg=1&find=gv%24instance&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [dba_hist_pgastat](https://www.enginatics.com/library/?pg=1&find=dba_hist_pgastat&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [aux_stats$](https://www.enginatics.com/library/?pg=1&find=aux_stats%24&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [v$parameter](https://www.enginatics.com/library/?pg=1&find=v%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [dba_feature_usage_statistics](https://www.enginatics.com/library/?pg=1&find=dba_feature_usage_statistics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [v$database](https://www.enginatics.com/library/?pg=1&find=v%24database&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [dba_editions](https://www.enginatics.com/library/?pg=1&find=dba_editions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration), [dba_tablespace_usage_metrics](https://www.enginatics.com/library/?pg=1&find=dba_tablespace_usage_metrics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration)

## Related Reports
[DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR PGA History](/DBA%20AWR%20PGA%20History/ "DBA AWR PGA History Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA SGA Buffer Cache Object Usage](/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/ "DBA SGA Buffer Cache Object Usage Oracle EBS SQL Report"), [DBA AWR Interconnect Traffic](/DBA%20AWR%20Interconnect%20Traffic/ "DBA AWR Interconnect Traffic Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA-PGA%20Memory%20Configuration/DBA%20SGA-PGA%20Memory%20Configuration.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA SGA+PGA Memory Configuration 29-Jul-2018 103004.xlsx](https://www.enginatics.com/example/dba-sga-pga-memory-configuration/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration) |
| Blitz Report™ XML Import | [DBA_SGA_PGA_Memory_Configuration.xml](https://www.enginatics.com/xml/dba-sga-pga-memory-configuration/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration) |
| SQL Source | [DBA SGA-PGA Memory Configuration.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA-PGA%20Memory%20Configuration/DBA%20SGA-PGA%20Memory%20Configuration.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-sga-pga-memory-configuration/](https://www.enginatics.com/reports/dba-sga-pga-memory-configuration/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration) |

## Case Study & Technical Analysis

### Abstract
The **DBA SGA+PGA Memory Configuration** report is a comprehensive audit of the database server's memory architecture. It compares the Oracle instance configuration (`SGA_TARGET`, `PGA_AGGREGATE_TARGET`) against the physical hardware resources to ensure optimal utilization. It also validates critical system statistics that influence the Cost-Based Optimizer (CBO).

### Technical Analysis

#### Core Checks
*   **Memory Utilization**: Calculates the total potential memory footprint (SGA + PGA + Process Overhead) and compares it to the server's physical RAM.
*   **System Statistics**: Checks `SYS.AUX_STATS$` for `CPUSPEEDNW`, `IOSEEKTIM`, and `IOTFRSPEED`. Default values (like 4096 for CPU speed) indicate that system stats have not been gathered, potentially leading the CBO to make suboptimal plan choices.
*   **HugePages**: (Contextual) The description emphasizes the importance of HugePages for large SGAs to reduce page table overhead.

#### Best Practices
*   **Sizing**: The sum of SGA and PGA should generally consume most of the available RAM on a dedicated database server, leaving a safety margin for the OS.
*   **Exadata**: Specific checks for Exadata-optimized system statistics.

#### Key Views
*   `V$PARAMETER`: For memory settings.
*   `SYS.AUX_STATS$`: For optimizer system statistics.

#### Operational Use Cases
*   **Health Check**: Standard validation for new deployments.
*   **Performance Tuning**: Ensuring the CBO has accurate information about the hardware's I/O and CPU capabilities.
*   **Cost Optimization**: Verifying that expensive RAM hardware is actually being allocated to the database instance.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-pga-memory-configuration)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
