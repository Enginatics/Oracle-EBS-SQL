---
layout: default
title: 'DBA Editioned Object Summary | Oracle EBS SQL Report'
description: 'Summary of editioned objects per edition from ADZDSHOWOBJS.sql There is a good blog: https://www.pythian.com/blog/technical-track/adop-edition-cleanup'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Editioned, Object, Summary, obj$, user$, dba_users'
permalink: /DBA%20Editioned%20Object%20Summary/
---

# DBA Editioned Object Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-editioned-object-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary of editioned objects per edition from ADZDSHOWOBJS.sql
There is a good blog: <a href="https://www.pythian.com/blog/technical-track/adop-edition-cleanup" rel="nofollow" target="_blank">https://www.pythian.com/blog/technical-track/adop-edition-cleanup</a>

## Report Parameters


## Oracle EBS Tables Used
[obj$](https://www.enginatics.com/library/?pg=1&find=obj$), [user$](https://www.enginatics.com/library/?pg=1&find=user$), [dba_users](https://www.enginatics.com/library/?pg=1&find=dba_users)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/ "DIS Folders, Business Areas, Items and LOVs Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [FND Applications](/FND%20Applications/ "FND Applications Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Editioned Object Summary 22-Dec-2025 083843.xlsx](https://www.enginatics.com/example/dba-editioned-object-summary/) |
| Blitz Report™ XML Import | [DBA_Editioned_Object_Summary.xml](https://www.enginatics.com/xml/dba-editioned-object-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-editioned-object-summary/](https://www.enginatics.com/reports/dba-editioned-object-summary/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
