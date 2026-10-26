---
layout: default
last_modified_at: 2026-10-26
title: 'FND Lookup Values Comparison between environments | Oracle EBS SQL Report'
description: 'Compares lookup values between the local and a remote database environment – Oracle EBS Application Object Library SQL report: free SQL, parameters and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Lookup, Values, Comparison, fnd_lookup_values, fnd_lookup_values@'
permalink: /FND%20Lookup%20Values%20Comparison%20between%20environments/
report_name: 'FND Lookup Values Comparison between environments'
report_web_name: fnd-lookup-values-comparison-between-environments
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Lookup Values Comparison between environments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-lookup-values-comparison-between-environments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Compares lookup values between the local and a remote database environment

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Type, Code contains, Language Code, Remote Database, Exclude Language Code, Show Differences only

## Oracle EBS Tables Used
[fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments), [fnd_lookup_values@](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values%40&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments)

## Related Reports
[GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Lookup%20Values%20Comparison%20between%20environments/FND%20Lookup%20Values%20Comparison%20between%20environments.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fnd-lookup-values-comparison-between-environments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments) |
| Blitz Report™ XML Import | [FND_Lookup_Values_Comparison_between_environments.xml](https://www.enginatics.com/xml/fnd-lookup-values-comparison-between-environments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments) |
| SQL Source | [FND Lookup Values Comparison between environments.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Lookup%20Values%20Comparison%20between%20environments/FND%20Lookup%20Values%20Comparison%20between%20environments.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-lookup-values-comparison-between-environments/](https://www.enginatics.com/reports/fnd-lookup-values-comparison-between-environments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments) |

## Executive Summary
The **FND Lookup Values Comparison between environments** report is a migration validation tool. It compares the lookup configurations between the current instance (e.g., PROD) and a remote instance (e.g., DEV) via a database link.

## Business Challenge
*   **Migration Verification:** Ensuring that all new lookup codes created in DEV have been successfully migrated to PROD.
*   **Drift Analysis:** Identifying configuration changes made directly in PROD that are missing from DEV.
*   **Sync Check:** Verifying that lookup descriptions match across environments.

## The Solution
This Blitz Report compares the two datasets:
*   **Match:** Identifies codes that exist in both but have different descriptions or enabled statuses.
*   **Missing:** Identifies codes that exist in one environment but not the other.

## Technical Architecture
The report uses a `DB Link` to query the remote `FND_LOOKUP_VALUES` table and compares it with the local table using `MINUS` or `FULL OUTER JOIN` logic.

## Parameters & Filtering
*   **Remote Database:** The name of the database link to the other environment.
*   **Show Differences only:** Toggle to hide matching records and focus on discrepancies.

## Performance & Optimization
*   **Network:** Performance depends on the speed of the database link. Filter by specific Lookup Types to improve speed.

## FAQ
*   **Q: Do I need a DB Link?**
    *   A: Yes, this report requires a valid database link to the target environment.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-values-comparison-between-environments)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
