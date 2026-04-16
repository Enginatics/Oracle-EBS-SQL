---
layout: default
title: 'FND Languages | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Languages, fnd_languages_vl'
permalink: /FND%20Languages/
---

# FND Languages – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-languages/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters
Show installed only

## Oracle EBS Tables Used
[fnd_languages_vl](https://www.enginatics.com/library/?pg=1&find=fnd_languages_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [Blitz Report Column Translations](/Blitz%20Report%20Column%20Translations/ "Blitz Report Column Translations Oracle EBS SQL Report"), [FND Lookup Values](/FND%20Lookup%20Values/ "FND Lookup Values Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Languages 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/fnd-languages/) |
| Blitz Report™ XML Import | [FND_Languages.xml](https://www.enginatics.com/xml/fnd-languages/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-languages/](https://www.enginatics.com/reports/fnd-languages/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
