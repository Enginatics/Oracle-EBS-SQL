---
layout: default
last_modified_at: 2026-10-26
title: 'FND Messages | Oracle EBS SQL Report'
description: 'Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Messages, fnd_new_messages, fnd_application_vl'
permalink: /FND%20Messages/
report_name: 'FND Messages'
report_web_name: fnd-messages
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Messages – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-messages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Message Text contains, Message Name like, Application, Language Code

## Oracle EBS Tables Used
[fnd_new_messages](https://www.enginatics.com/library/?pg=1&find=fnd_new_messages&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages)

## Related Reports
[PAY Payroll Process Summary](/PAY%20Payroll%20Process%20Summary/ "PAY Payroll Process Summary Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Messages/FND%20Messages.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Messages 19-Oct-2024 094002.xlsx](https://www.enginatics.com/example/fnd-messages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages) |
| Blitz Report™ XML Import | [FND_Messages.xml](https://www.enginatics.com/xml/fnd-messages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages) |
| SQL Source | [FND Messages.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Messages/FND%20Messages.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-messages/](https://www.enginatics.com/reports/fnd-messages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-messages)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
