---
layout: default
last_modified_at: 2026-10-26
title: 'Blitz Report VPD Policy Setup | Oracle EBS SQL Report'
description: 'Lists tables and columns to be secured by Blitz Report''s VPD policy functionality (concurrent program ''Blitz Report Update VPD Policies'') from lookup…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, VPD, Policy, dba_policies, fnd_lookup_values, all_tables'
permalink: /Blitz%20Report%20VPD%20Policy%20Setup/
report_name: 'Blitz Report VPD Policy Setup'
report_web_name: blitz-report-vpd-policy-setup
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report VPD Policy Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-vpd-policy-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
Lists tables and columns to be secured by Blitz Report's VPD policy functionality (concurrent program 'Blitz Report Update VPD Policies') from lookup XXEN_REPORT_VPD_POLICY_TABLES and validates if corresponding DB policies have been created.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[dba_policies](https://www.enginatics.com/library/?pg=1&find=dba_policies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup), [all_tables](https://www.enginatics.com/library/?pg=1&find=all_tables&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup), [all_tab_columns](https://www.enginatics.com/library/?pg=1&find=all_tab_columns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup)

## Related Reports
[DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [FND Lookup Search](/FND%20Lookup%20Search/ "FND Lookup Search Oracle EBS SQL Report"), [FND Audit Table Changes by Column](/FND%20Audit%20Table%20Changes%20by%20Column/ "FND Audit Table Changes by Column Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [DBA Table Modifications](/DBA%20Table%20Modifications/ "DBA Table Modifications Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [CAC Accounting Period Status](/CAC%20Accounting%20Period%20Status/ "CAC Accounting Period Status Oracle EBS SQL Report"), [AR AutoAccounting Upload](/AR%20AutoAccounting%20Upload/ "AR AutoAccounting Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20VPD%20Policy%20Setup/Blitz%20Report%20VPD%20Policy%20Setup.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report VPD Policy Setup 29-Jun-2020 135303.xlsx](https://www.enginatics.com/example/blitz-report-vpd-policy-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup) |
| Blitz Report™ XML Import | [Blitz_Report_VPD_Policy_Setup.xml](https://www.enginatics.com/xml/blitz-report-vpd-policy-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup) |
| SQL Source | [Blitz Report VPD Policy Setup.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20VPD%20Policy%20Setup/Blitz%20Report%20VPD%20Policy%20Setup.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-vpd-policy-setup/](https://www.enginatics.com/reports/blitz-report-vpd-policy-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup) |

## Executive Summary
The Blitz Report VPD Policy Setup report is a security administration tool designed to manage and validate Virtual Private Database (VPD) policies within the Blitz Report framework. It lists the tables and columns configured for VPD security and verifies whether the corresponding database policies have been correctly applied.

## Business Challenge
Implementing row-level security via VPD is critical for protecting sensitive data in Oracle EBS. However, ensuring that these policies are correctly defined and active across all relevant tables can be complex. Misconfigurations can lead to data leaks or unauthorized access. Administrators need a reliable way to audit the setup of VPD policies to ensure compliance with security standards.

## Solution
The Blitz Report VPD Policy Setup report provides a clear audit trail of the VPD configuration. It compares the intended security setup (defined in the `XXEN_REPORT_VPD_POLICY_TABLES` lookup) with the actual database policies in effect. This validation step ensures that the security measures intended by the administrators are technically enforced in the database.

## Key Features
*   **Policy Validation:** Checks if the database policies match the configuration in Blitz Report.
*   **Configuration Review:** Lists tables and columns targeted for VPD security.
*   **Security Audit:** Helps identify gaps between the intended security design and the actual implementation.

## Technical Details
The report queries `dba_policies` to check for existing database policies and compares them against the configuration stored in `fnd_lookup_values`. It also references `all_tables` and `all_tab_columns` to validate the existence of the secured objects.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-vpd-policy-setup)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
