---
layout: default
title: 'FND Lookup Values | Oracle EBS SQL Report'
description: 'Lookup types and values, for example to find a lookup type for a particular lookup code value or meaning.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Lookup, Values, fnd_application_vl, fnd_lookup_types_vl, fnd_lookup_values'
permalink: /FND%20Lookup%20Values/
---

# FND Lookup Values – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-lookup-values/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lookup types and values, for example to find a lookup type for a particular lookup code value or meaning.

## Report Parameters
Type, View Application, Code contains, Meaning contains, Description contains, Creation Date From, Creation Date To, Created By, Language Code, Missing Translation to Lang Code

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_lookup_types_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_types_vl), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values), [fnd_languages](https://www.enginatics.com/library/?pg=1&find=fnd_languages)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Lookup Values 27-Jul-2018 212911.xlsx](https://www.enginatics.com/example/fnd-lookup-values/) |
| Blitz Report™ XML Import | [FND_Lookup_Values.xml](https://www.enginatics.com/xml/fnd-lookup-values/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-lookup-values/](https://www.enginatics.com/reports/fnd-lookup-values/) |

## Executive Summary
The **FND Lookup Values** report is the standard dictionary for all lookup codes in the system. It allows you to search for codes, meanings, or descriptions across all lookup types.

## Business Challenge
*   **Configuration Review:** Checking the list of available values for a dropdown list (e.g., "Payment Terms" or "Vendor Types").
*   **Translation Gap Analysis:** Finding lookup codes that are missing translations in a multi-language environment.
*   **Search:** Finding which Lookup Type contains a specific code (e.g., finding where 'NET30' is defined).

## The Solution
This Blitz Report lists the full lookup definition:
*   **Type:** The parent Lookup Type.
*   **Code:** The internal code stored in the database.
*   **Meaning:** The user-visible text.
*   **Description:** Additional details.
*   **Effectivity:** Start/End dates and Enabled flag.

## Technical Architecture
The report queries `FND_LOOKUP_TYPES_VL` and `FND_LOOKUP_VALUES`. It handles the language join to show translations.

## Parameters & Filtering
*   **Type:** Filter by the specific lookup type (e.g., `YES_NO`).
*   **Meaning contains:** Search for a specific text string across all lookups.
*   **Missing Translation to Lang Code:** A powerful filter to find codes that exist in the base language but not in the target language.

## Performance & Optimization
*   **Volume:** There are thousands of lookup types. Always filter by Type or Application to avoid a massive export.

## FAQ
*   **Q: Can I see System lookups?**
    *   A: Yes, this report shows all lookups (System, User, and Extensible).


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
