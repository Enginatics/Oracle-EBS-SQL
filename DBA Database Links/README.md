---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Database Links | Oracle EBS SQL Report'
description: 'Database links with their owner, remote user and connect string. – Oracle EBS Database Administration SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Database, Links, dba_db_links'
permalink: /DBA%20Database%20Links/
report_name: 'DBA Database Links'
report_web_name: dba-database-links
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Database Links – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-database-links/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Database links with their owner, remote user and connect string.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Owner

## Oracle EBS Tables Used
[dba_db_links](https://www.enginatics.com/library/?pg=1&find=dba_db_links&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/ "DBA AWR CPU vs Wait Time Summary Oracle EBS SQL Report"), [DBA AWR System Time Summary](/DBA%20AWR%20System%20Time%20Summary/ "DBA AWR System Time Summary Oracle EBS SQL Report"), [DBA Tablespace Usage](/DBA%20Tablespace%20Usage/ "DBA Tablespace Usage Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR System Time Percentages](/DBA%20AWR%20System%20Time%20Percentages/ "DBA AWR System Time Percentages Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Database%20Links/DBA%20Database%20Links.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Database Links 12-Oct-2026 062806.xlsx](https://www.enginatics.com/example/dba-database-links/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links) |
| Blitz Report™ XML Import | [DBA_Database_Links.xml](https://www.enginatics.com/xml/dba-database-links/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links) |
| SQL Source | [DBA Database Links.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Database%20Links/DBA%20Database%20Links.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-database-links/](https://www.enginatics.com/reports/dba-database-links/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links) |

## Case Study & Technical Analysis: DBA Database Links

### Executive Summary
This report lists the database links defined in the Oracle database that runs Oracle E-Business Suite. For each link it shows the owner schema, the link name, the remote user the link connects as, the connect string, and the date the link was created. It is written for DBAs and technical administrators who must inventory the connections that leave the EBS database, check which accounts hold credentials to other systems, and confirm that the links an integration relies on still exist after a clone, upgrade or security review. Because the output is a plain list, it is easy to compare between environments and to share with security auditors.

### Business Challenge
*   **Unknown outbound connections:** Database links allow one database to query or change objects in another, and an inventory is needed to know which systems the EBS database can reach.
*   **Credentials stored in the database:** Each link holds a remote user name and a connect string, so the accounts that use them must be known and reviewed.
*   **Environment cloning:** After a clone or refresh, links can point at the wrong remote systems, and the list has to be checked against the target environment.
*   **Audit and compliance:** Security reviews ask for a current list of all database connections, with the owner and creation date of each.

### The Solution
*   Reads every database link visible in the data dictionary view `DBA_DB_LINKS`, so all owners are included, not only the current user.
*   Shows the owner, the link name, the remote user, the host string and the created date in one row per link.
*   Sorts the output by owner and then by link name, so links of the same schema are grouped together.
*   Accepts an Owner parameter, so a DBA can focus on the links of one schema, for example an integration account.

### Technical Architecture (High Level)
#### Primary Tables
*   `DBA_DB_LINKS`: the data dictionary view of database links, with the owner, the link name, the remote user, the host and the creation date.

#### Logical Relationships
1. The report reads `DBA_DB_LINKS` alone, with no joins.
2. The Owner parameter filters the owner column of that view.
3. The result is ordered by owner and then by the link name.

The report is deliberately simple: there is no join to the Oracle EBS application tables, so the output reflects the database dictionary and not the application setup that uses the links.

### Parameters & Filtering
*   **Owner:** restricts the list to the database links owned by one schema. Leave it blank to see every link in the database.

### Performance & Optimization
*   The query has one source view and no joins, so its cost is that of reading the dictionary view for the links in the database.
*   The filter on the owner column reduces the rows returned when a single schema is needed.
*   The sort on owner and link name is applied on a short result set, so it adds little cost even for databases with many links.
*   Because the output does not include connect passwords, it can be shared with reviewers, but the host string and remote user still identify the target systems and should be treated as sensitive.

### FAQ
**Q: How do I list all database links in the EBS database?**
A: Run the report with the Owner parameter blank. Each link is listed with its owner, name, remote user, host and created date.

**Q: How do I find the database links of one schema?**
A: Enter the schema name in the Owner parameter. Only the links owned by that schema are returned.

**Q: Does this report show the passwords of database links?**
A: No. The report shows the remote user and the host, and it does not include any password.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-links)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
