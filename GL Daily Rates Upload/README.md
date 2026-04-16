---
layout: default
title: 'GL Daily Rates Upload | Oracle EBS SQL Report'
description: 'GL Daily Rates Upload ================== Use this upload to upload new or update existing GL Daily Exchange Rate Conversions. If exchange rates do not…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Daily, Rates, gl_daily_rates, gl_daily_conversion_types, fnd_user'
permalink: /GL%20Daily%20Rates%20Upload/
---

# GL Daily Rates Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-daily-rates-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
GL Daily Rates Upload
==================
Use this upload to upload new or update existing GL Daily Exchange Rate Conversions.
If exchange rates do not already exist for the entered data, they will be created.
If exchange rates do already exist for the entered data, they will be updated.

## Report Parameters
Upload Mode, Default User Conversion Type, From Currency, To Currency, Conversion Type, From Date, To Date

## Oracle EBS Tables Used
[gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Journals (Drilldown) 11g](/GL%20Journals%20%28Drilldown%29%2011g/ "GL Journals (Drilldown) 11g Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report"), [AR Receipt Register](/AR%20Receipt%20Register/ "AR Receipt Register Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/gl-daily-rates-upload/) |
| Blitz Report™ XML Import | [GL_Daily_Rates_Upload.xml](https://www.enginatics.com/xml/gl-daily-rates-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-daily-rates-upload/](https://www.enginatics.com/reports/gl-daily-rates-upload/) |

## GL Daily Rates Upload - Case Study & Technical Analysis

### Executive Summary
The **GL Daily Rates Upload** is a utility report and interface tool designed to facilitate the bulk upload or update of daily exchange rates into Oracle EBS. It streamlines the maintenance of currency rates, replacing manual data entry with an efficient Excel-based interface. This tool is vital for organizations that manage high volumes of currency pairs or require frequent rate updates from external treasury systems.

### Business Use Cases
*   **Bulk Rate Maintenance**: Enables the mass upload of monthly or daily rates from central treasury systems or external feeds (e.g., Bloomberg, Reuters) directly into Oracle GL.
*   **Correction of Errors**: Allows for the rapid correction of incorrect rates across a date range by simply uploading the correct values, which overwrite the existing entries.
*   **New Currency Setup**: Accelerates the initialization of historical rates when a new currency is introduced to the business.
*   **Month-End Close**: Ensures all necessary period-end rates are populated quickly to allow for timely revaluation and translation processes.

### Technical Analysis

#### Core Tables
*   `GL_DAILY_RATES_INTERFACE`: The interface table where data is initially staged before being validated and imported.
*   `GL_DAILY_RATES`: The final destination table for the validated exchange rates.
*   `GL_DAILY_CONVERSION_TYPES`: Validates the conversion type provided in the upload.
*   `FND_CURRENCIES`: Validates the currency codes.

#### Key Joins & Logic
*   **Interface Mechanism**: This tool typically functions as a wrapper for the Oracle GL Currency API (`GL_CURRENCY_API`) or the standard open interface.
*   **Upsert Logic**: The logic checks if a rate already exists for the given currency pair, date, and type.
    *   If it **exists**, the tool performs an `UPDATE` to modify the rate.
    *   If it **does not exist**, it performs an `INSERT` to create a new record.
*   **Validation**: It enforces strict validation rules:
    *   Currencies must be active and valid.
    *   Conversion dates must be in valid open or future periods (depending on configuration).
    *   No duplicate rates for the same key combination.

#### Key Parameters
*   **Upload Mode**: Specifies whether to validate only or validate and load.
*   **From Currency / To Currency**: The currency pair being loaded.
*   **Conversion Date**: The date for which the rate applies.
*   **Conversion Type**: The rate type (e.g., Corporate).
*   **Conversion Rate**: The numerical exchange rate value.


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
