---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Users | Oracle EBS SQL Report'
description: 'Database user accounts with their status, lock and expiry dates, profile, tablespaces and quotas. Default Password flags accounts that still have an…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Users, dba_users, dba_users_with_defpwd, fnd_oracle_userid'
permalink: /DBA%20Users/
report_name: 'DBA Users'
report_web_name: dba-users
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Users – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Database user accounts with their status, lock and expiry dates, profile, tablespaces and quotas.

Default Password flags accounts that still have an Oracle-supplied default password (dba_users_with_defpwd). EBS Applications lists the Oracle EBS applications installed in the schema.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Username, Account Status, Expiring within Days, Default Password only, EBS Schemas only

## Oracle EBS Tables Used
[dba_users](https://www.enginatics.com/library/?pg=1&find=dba_users&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users), [dba_users_with_defpwd](https://www.enginatics.com/library/?pg=1&find=dba_users_with_defpwd&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users), [fnd_oracle_userid](https://www.enginatics.com/library/?pg=1&find=fnd_oracle_userid&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users), [fnd_product_installations](https://www.enginatics.com/library/?pg=1&find=fnd_product_installations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users), [dba_ts_quotas](https://www.enginatics.com/library/?pg=1&find=dba_ts_quotas&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users)

## Related Reports
[FND Applications](/FND%20Applications/ "FND Applications Oracle EBS SQL Report"), [FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [FND Lookup Search](/FND%20Lookup%20Search/ "FND Lookup Search Oracle EBS SQL Report"), [Blitz Report Custom Reports Converter](/Blitz%20Report%20Custom%20Reports%20Converter/ "Blitz Report Custom Reports Converter Oracle EBS SQL Report"), [FND Histogram Columns](/FND%20Histogram%20Columns/ "FND Histogram Columns Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [Blitz Report Web Service Sessions](/Blitz%20Report%20Web%20Service%20Sessions/ "Blitz Report Web Service Sessions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Users/DBA%20Users.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Users 12-Oct-2026 061639.xlsx](https://www.enginatics.com/example/dba-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users) |
| Blitz Report™ XML Import | [DBA_Users.xml](https://www.enginatics.com/xml/dba-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users) |
| SQL Source | [DBA Users.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Users/DBA%20Users.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-users/](https://www.enginatics.com/reports/dba-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users) |

## Case Study & Technical Analysis: DBA Users

### Executive Summary
The DBA Users report lists every database user account in the Oracle instance with its status, lock and expiry dates, profile, tablespace assignments and quotas. It is written for DBAs and Oracle EBS security administrators who must audit accounts, prepare for password expiry and remove exposure from default credentials. It also flags accounts that still carry an Oracle-supplied default password and shows which Oracle E-Business Suite applications are installed in each schema. The report belongs to the Database Administration area of the Oracle EBS technology stack and supports security reviews, periodic access audits and pre-go-live hardening.

### Business Challenge
*   **Default password exposure:** Accounts that still use an Oracle-supplied default password are a known security weakness, and the DBA needs a list of them to remediate.
*   **Expiry and lockout management:** Locked and expiring accounts can interrupt batch jobs and integrations, so the team needs to see them before they fail.
*   **Quota and tablespace governance:** Users with unlimited or large tablespace quotas can consume storage outside the planned allocation.
*   **Identifying EBS schemas:** In an Oracle EBS database, the schemas that belong to applications must be distinguished from other accounts for audit and support purposes.

### The Solution
*   **Account status in one view:** The report returns account status, lock date, expiry date and creation date for each user, with the profile and authentication type.
*   **Default password flag:** Accounts listed in the default password view are marked with a yes or no flag, so they can be filtered and remediated.
*   **Application ownership:** The Oracle EBS applications installed in each schema are listed as a single text value, so EBS schemas are identifiable.
*   **Quota summary:** Tablespace quotas are summarised per user, with the size shown in megabytes or as unlimited.
*   **Editions indicator:** Whether editions are enabled is shown for each account.

### Technical Architecture (High Level)
#### Primary Tables
*   `DBA_USERS`: the main list of database accounts, with status, dates, profile, default and temporary tablespace.
*   `DBA_USERS_WITH_DEFPWD`: the accounts that still hold an Oracle-supplied default password.
*   `DBA_TS_QUOTAS`: the tablespace quotas granted to each user.
*   `FND_ORACLE_USERID`: the mapping between Oracle database user names and EBS application identifiers.
*   `FND_PRODUCT_INSTALLATIONS`: the installed products, linked to the Oracle identifiers.
*   `FND_APPLICATION_VL`: the translated application names.

#### Logical Relationships
1. `DBA_USERS` is the driving table, and each of the three supporting sets is joined to it by username with an outer join.
2. The default password set is joined on username, and a yes flag is produced where a match exists.
3. The EBS application set joins `FND_ORACLE_USERID` to `FND_PRODUCT_INSTALLATIONS` on the Oracle identifier, then to `FND_APPLICATION_VL` on the application identifier, and is aggregated per Oracle user name.
4. The quota set is aggregated per username, with each tablespace and its size concatenated into one value.
5. The result is ordered by username.

### Parameters & Filtering
*   **Username:** Restricts the output to one database account.
*   **Account Status:** Filters the accounts by their status, such as open, locked or expired.
*   **Expiring within Days:** Shows accounts whose expiry date falls within the given number of days.
*   **Default Password only:** When set, limits the output to accounts that still have a default password.
*   **EBS Schemas only:** When set, limits the output to accounts that are linked to installed Oracle EBS applications.

### Performance & Optimization
*   **Materialised subqueries:** The default password, EBS application and quota sets are each placed in a `no_merge` inline view, so each is evaluated once and then joined.
*   **Aggregation before join:** The application and quota lists are aggregated with `LISTAGG` before the join to `DBA_USERS`, which keeps the result to one row per account.
*   **Dictionary views only:** The report reads data dictionary views, not application tables, so its cost is that of reading the database catalogue.
*   **Outer joins:** All supporting sets are attached with outer joins, so accounts without a default password, application or quota are still returned.

### FAQ
**Q: How do I find database accounts that still have a default password in Oracle EBS?**
A: Run DBA Users with Default Password only set to Yes, and read the accounts returned.

**Q: Which accounts are Oracle EBS application schemas?**
A: The EBS Applications column lists the Oracle EBS applications installed in each schema, and EBS Schemas only restricts the output to those accounts.

**Q: How can I see which accounts are close to expiry?**
A: Set Expiring within Days to the number of days you want to check, and read the expiry date on the returned accounts.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-users)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
