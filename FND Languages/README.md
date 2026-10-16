---
layout: default
last_modified_at: 2026-10-16
title: 'FND Languages | Oracle EBS SQL Report'
description: 'Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Languages, fnd_languages_vl'
permalink: /FND%20Languages/
report_name: 'FND Languages'
report_web_name: fnd-languages
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Languages – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-languages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Show installed only

## Oracle EBS Tables Used
[fnd_languages_vl](https://www.enginatics.com/library/?pg=1&find=fnd_languages_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages)

## Related Reports
[AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [Blitz Report Add-in Environment Setup](/Blitz%20Report%20Add-in%20Environment%20Setup/ "Blitz Report Add-in Environment Setup Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [Blitz Report Column Translation Upload](/Blitz%20Report%20Column%20Translation%20Upload/ "Blitz Report Column Translation Upload Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [PER Person Upload](/PER%20Person%20Upload/ "PER Person Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Languages/FND%20Languages.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Languages 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/fnd-languages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages) |
| Blitz Report™ XML Import | [FND_Languages.xml](https://www.enginatics.com/xml/fnd-languages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages) |
| SQL Source | [FND Languages.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Languages/FND%20Languages.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-languages/](https://www.enginatics.com/reports/fnd-languages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages) |

## Executive Summary
The **FND Languages** report lists the languages defined in the Oracle EBS installation.

## Business Challenge
*   **Global Rollout:** Verifying which languages are installed and active (Base vs. Installed).
*   **NLS Support:** Checking the NLS Language and Territory codes for system configuration.

## The Solution
This Blitz Report lists the language details:
*   **Language Code:** The short code (e.g., "US", "D").
*   **Description:** The full name (e.g., "American English", "German").
*   **Status:** Whether the language is "Installed" or just defined.

## Technical Architecture
The report queries `FND_LANGUAGES_VL`.

## Parameters & Filtering
*   **Show installed only:** Toggle to hide the dozens of languages that are defined but not installed on your server.

## Performance & Optimization
*   **Simple List:** Runs instantly.

## FAQ
*   **Q: Can I install a new language from here?**
    *   A: No, installing a language requires running the "License Manager" and applying the NLS translation patches.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-languages)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
