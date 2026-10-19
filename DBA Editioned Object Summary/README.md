---
layout: default
last_modified_at: 2026-10-19
title: 'DBA Editioned Object Summary | Oracle EBS SQL Report'
description: 'Summary of editioned objects per edition from ADZDSHOWOBJS.sql There is a good blog: https://www.pythian.com/blog/technical-track/adop-edition-cleanup'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Editioned, Object, Summary, obj$, user$, dba_users'
permalink: /DBA%20Editioned%20Object%20Summary/
report_name: 'DBA Editioned Object Summary'
report_web_name: dba-editioned-object-summary
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Editioned Object Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-editioned-object-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Summary of editioned objects per edition from ADZDSHOWOBJS.sql
There is a good blog: <a href="https://www.pythian.com/blog/technical-track/adop-edition-cleanup" rel="nofollow" target="_blank">https://www.pythian.com/blog/technical-track/adop-edition-cleanup</a>

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[obj$](https://www.enginatics.com/library/?pg=1&find=obj%24&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary), [user$](https://www.enginatics.com/library/?pg=1&find=user%24&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary), [dba_users](https://www.enginatics.com/library/?pg=1&find=dba_users&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary)

## Related Reports
[DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [Blitz Report Custom Reports Converter](/Blitz%20Report%20Custom%20Reports%20Converter/ "Blitz Report Custom Reports Converter Oracle EBS SQL Report"), [FND Applications](/FND%20Applications/ "FND Applications Oracle EBS SQL Report"), [DBA Users](/DBA%20Users/ "DBA Users Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Editioned%20Object%20Summary/DBA%20Editioned%20Object%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Editioned Object Summary 22-Dec-2025 083843.xlsx](https://www.enginatics.com/example/dba-editioned-object-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary) |
| Blitz Report™ XML Import | [DBA_Editioned_Object_Summary.xml](https://www.enginatics.com/xml/dba-editioned-object-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary) |
| SQL Source | [DBA Editioned Object Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Editioned%20Object%20Summary/DBA%20Editioned%20Object%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-editioned-object-summary/](https://www.enginatics.com/reports/dba-editioned-object-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary) |

## Executive Summary
The **DBA Editioned Object Summary** report is essential for managing Oracle E-Business Suite 12.2+ environments, which use Edition-Based Redefinition (EBR) for online patching. It provides a summary of how many objects exist in each "Edition". This is critical for monitoring the cleanup process (`adop phase=cleanup`) and managing the growth of the database.

## Business Challenge
*   **Storage Growth**: "Why is the database growing so fast? Are we keeping too many old patch editions?"
*   **Patching Health**: "Did the cleanup phase of the last patch cycle actually remove the obsolete objects?"
*   **Performance**: "Are we suffering from dictionary performance issues due to having 500 old editions?"

## Solution
This report summarizes the count of editioned objects (Views, PL/SQL, Synonyms) per edition.

**Key Features:**
*   **Edition Name**: The name of the patch edition (e.g., `V_20230101_1200`).
*   **Object Count**: Number of actual objects vs. "stub" objects.
*   **Active Status**: Identifies the current Run and Patch editions.

## Architecture
The report queries `OBJ$`, `USER$`, and `DBA_USERS`.

**Key Tables:**
*   `OBJ$`: The core object table (includes the `EDITION_NAME` column).
*   `DBA_OBJECTS_AE`: The view showing all editioned objects.

## Impact
*   **Space Reclamation**: Identifies when it's safe (and necessary) to run a full cleanup to reclaim space.
*   **System Hygiene**: Ensures the database doesn't become cluttered with thousands of obsolete object versions.
*   **Patching Success**: Verifies that the Online Patching cycle is completing all its housekeeping tasks.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-editioned-object-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
