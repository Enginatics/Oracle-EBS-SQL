---
layout: default
last_modified_at: 2026-10-26
title: 'FND Audit Setup | Oracle EBS SQL Report'
description: 'FND audit setup validation report including audit groups, audit tables and audited columns, and a check if the corresponding audit tables are created in…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Audit, Setup, fnd_audit_tmplt_dtl, fnd_product_installations, fnd_oracle_userid'
permalink: /FND%20Audit%20Setup/
report_name: 'FND Audit Setup'
report_web_name: fnd-audit-setup
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Audit Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-audit-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
FND audit setup validation report including audit groups, audit tables and audited columns, and a check if the corresponding audit tables are created in columns 'Audit Table Name' and 'Audit Column Exists'.

Oracle's standard audit trail works with a concurrent program 'AuditTrail Update Tables', which creates a set of database triggers for updates, inserts and deletes. The triggers write table changes to an audit table with the name: audited_table_A.

The whole audit trail setup process is describe in this blog: <a href="https://www.enginatics.com/blog/how-to-track-master-data-changes-using-oracle-ebs-audit-function-and-blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup" rel="nofollow" target="_blank">https://www.enginatics.com/blog/how-to-track-master-data-changes-using-oracle-ebs-audit-function-and-blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup</a>

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Audit Table, Audit Group

## Oracle EBS Tables Used
[fnd_audit_tmplt_dtl](https://www.enginatics.com/library/?pg=1&find=fnd_audit_tmplt_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup), [fnd_product_installations](https://www.enginatics.com/library/?pg=1&find=fnd_product_installations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup), [fnd_oracle_userid](https://www.enginatics.com/library/?pg=1&find=fnd_oracle_userid&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup), [dba_tables](https://www.enginatics.com/library/?pg=1&find=dba_tables&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup), [fnd_primary_key_columns](https://www.enginatics.com/library/?pg=1&find=fnd_primary_key_columns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup), [dba_tab_columns](https://www.enginatics.com/library/?pg=1&find=dba_tab_columns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup), [fnd_audit_groups](https://www.enginatics.com/library/?pg=1&find=fnd_audit_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup), [fnd_audit_tables](https://www.enginatics.com/library/?pg=1&find=fnd_audit_tables&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup), [fnd_tables](https://www.enginatics.com/library/?pg=1&find=fnd_tables&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup), [fnd_audit_columns](https://www.enginatics.com/library/?pg=1&find=fnd_audit_columns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup), [fnd_columns](https://www.enginatics.com/library/?pg=1&find=fnd_columns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup)

## Related Reports
[FND Applications](/FND%20Applications/ "FND Applications Oracle EBS SQL Report"), [FND Lookup Search](/FND%20Lookup%20Search/ "FND Lookup Search Oracle EBS SQL Report"), [FND Audit Table Changes by Column](/FND%20Audit%20Table%20Changes%20by%20Column/ "FND Audit Table Changes by Column Oracle EBS SQL Report"), [AR Transactions and Lines](/AR%20Transactions%20and%20Lines/ "AR Transactions and Lines Oracle EBS SQL Report"), [Blitz Report VPD Policy Setup](/Blitz%20Report%20VPD%20Policy%20Setup/ "Blitz Report VPD Policy Setup Oracle EBS SQL Report"), [FND Audit Table Changes by Record](/FND%20Audit%20Table%20Changes%20by%20Record/ "FND Audit Table Changes by Record Oracle EBS SQL Report"), [DBA Users](/DBA%20Users/ "DBA Users Oracle EBS SQL Report"), [AP Expenses](/AP%20Expenses/ "AP Expenses Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Audit%20Setup/FND%20Audit%20Setup.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Audit Setup 16-Aug-2020 161825.xlsx](https://www.enginatics.com/example/fnd-audit-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup) |
| Blitz Report™ XML Import | [FND_Audit_Setup.xml](https://www.enginatics.com/xml/fnd-audit-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup) |
| SQL Source | [FND Audit Setup.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Audit%20Setup/FND%20Audit%20Setup.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-audit-setup/](https://www.enginatics.com/reports/fnd-audit-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup) |

## Executive Summary
The **FND Audit Setup** report validates the configuration of the Oracle Audit Trail feature. It ensures that the audit groups, tables, and columns defined in the application match the actual database triggers and shadow tables created by the system.

## Business Challenge
*   **Compliance Gaps:** Believing that auditing is active when the underlying database objects (shadow tables) haven't been created.
*   **Configuration Drift:** Identifying discrepancies between the intended audit policy and the technical implementation.
*   **Troubleshooting:** Understanding why changes to a specific table are not being captured.

## The Solution
This Blitz Report performs a health check on the audit setup:
*   **Configuration vs. Reality:** Compares the FND setup tables with the DBA dictionary tables (`DBA_TABLES`, `DBA_TAB_COLUMNS`).
*   **Completeness Check:** Verifies that every column marked for audit actually exists in the shadow table (suffix `_A`).
*   **Group Visibility:** Shows which audit groups contain which tables.

## Technical Architecture
The report joins `FND_AUDIT_GROUPS`, `FND_AUDIT_TABLES`, and `FND_AUDIT_COLUMNS` to get the definition. It then left joins to `DBA_TABLES` and `DBA_TAB_COLUMNS` to verify the existence of the physical audit objects (e.g., `_A` tables).

## Parameters & Filtering
*   **Audit Table/Group:** Filter to check specific objects.

## Performance & Optimization
*   **Dictionary Access:** Queries `DBA_` views, which can be slow on very large databases, but usually performs well for metadata checks.

## FAQ
*   **Q: What does "Audit Table Exists = No" mean?**
    *   A: It means you have defined the audit policy in the application but haven't run the "AuditTrail Update Tables" concurrent program to build the database objects.
*   **Q: Can I audit any table?**
    *   A: Generally yes, but the table must have a primary key defined in EBS.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-setup)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
