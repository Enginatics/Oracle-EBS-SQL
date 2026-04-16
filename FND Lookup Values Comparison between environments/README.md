---
layout: default
title: 'FND Lookup Values Comparison between environments | Oracle EBS SQL Report'
description: 'Compares lookup values between the local and a remote database environment – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Lookup, Values, Comparison, fnd_lookup_values'
permalink: /FND%20Lookup%20Values%20Comparison%20between%20environments/
---

# FND Lookup Values Comparison between environments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-lookup-values-comparison-between-environments/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Compares lookup values between the local and a remote database environment

## Report Parameters
Type, Code contains, Language Code, Remote Database, Exclude Language Code, Show Differences only

## Oracle EBS Tables Used
[fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-lookup-values-comparison-between-environments/) |
| Blitz Report™ XML Import | [FND_Lookup_Values_Comparison_between_environments.xml](https://www.enginatics.com/xml/fnd-lookup-values-comparison-between-environments/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-lookup-values-comparison-between-environments/](https://www.enginatics.com/reports/fnd-lookup-values-comparison-between-environments/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
