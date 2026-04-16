---
layout: default
title: 'Blitz Report VPD Policy Setup | Oracle EBS SQL Report'
description: 'Lists tables and columns to be secured by Blitz Report''s VPD policy functionality (concurrent program ''Blitz Report Update VPD Policies'') from lookup…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, VPD, Policy, dba_policies, fnd_lookup_values, all_tables'
permalink: /Blitz%20Report%20VPD%20Policy%20Setup/
---

# Blitz Report VPD Policy Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-vpd-policy-setup/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists tables and columns to be secured by Blitz Report's VPD policy functionality (concurrent program 'Blitz Report Update VPD Policies') from lookup XXEN_REPORT_VPD_POLICY_TABLES and validates if corresponding DB policies have been created.

## Report Parameters


## Oracle EBS Tables Used
[dba_policies](https://www.enginatics.com/library/?pg=1&find=dba_policies), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values), [all_tables](https://www.enginatics.com/library/?pg=1&find=all_tables), [all_tab_columns](https://www.enginatics.com/library/?pg=1&find=all_tab_columns)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [CAC Accounting Period Status](/CAC%20Accounting%20Period%20Status/ "CAC Accounting Period Status Oracle EBS SQL Report"), [CAC OPM WIP Account Value](/CAC%20OPM%20WIP%20Account%20Value/ "CAC OPM WIP Account Value Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report VPD Policy Setup 29-Jun-2020 135303.xlsx](https://www.enginatics.com/example/blitz-report-vpd-policy-setup/) |
| Blitz Report™ XML Import | [Blitz_Report_VPD_Policy_Setup.xml](https://www.enginatics.com/xml/blitz-report-vpd-policy-setup/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-vpd-policy-setup/](https://www.enginatics.com/reports/blitz-report-vpd-policy-setup/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
