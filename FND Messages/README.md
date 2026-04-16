---
layout: default
title: 'FND Messages | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Messages, fnd_new_messages, fnd_application_vl'
permalink: /FND%20Messages/
---

# FND Messages – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-messages/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters
Message Text contains, Message Name like, Application, Language Code

## Oracle EBS Tables Used
[fnd_new_messages](https://www.enginatics.com/library/?pg=1&find=fnd_new_messages), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Messages 19-Oct-2024 094002.xlsx](https://www.enginatics.com/example/fnd-messages/) |
| Blitz Report™ XML Import | [FND_Messages.xml](https://www.enginatics.com/xml/fnd-messages/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-messages/](https://www.enginatics.com/reports/fnd-messages/) |

## Executive Summary
The **FND Messages** report lists the standard and custom messages defined in the Message Dictionary. These are the text strings used for error messages, warnings, and labels in Forms and OAF pages.

## Business Challenge
*   **Customization Review:** Finding all custom messages (e.g., starting with `XX%`) created for custom validations.
*   **Translation:** Extracting message text to send to a translation agency.
*   **Error Analysis:** Searching for the text of a cryptic error message to find its internal name and owning application.

## The Solution
This Blitz Report lists the message details:
*   **Message Name:** The internal code (e.g., `APP-FND-01234`).
*   **Message Text:** The user-facing text, including token placeholders (e.g., `Value &VALUE is invalid`).
*   **Application:** The owning module.

## Technical Architecture
The report queries `FND_NEW_MESSAGES`.

## Parameters & Filtering
*   **Message Text contains:** Search for a specific phrase (e.g., "insufficient funds").
*   **Message Name like:** Filter by code pattern.

## Performance & Optimization
*   **Fast Execution:** Runs quickly against the message table.

## FAQ
*   **Q: Can I change standard Oracle messages?**
    *   A: It is technically possible but highly discouraged as patches will overwrite them. You should use "Custom Messages" or "Forms Personalization" to override text.


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
