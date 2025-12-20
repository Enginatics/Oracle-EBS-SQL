# GL Daily Rates Upload - Case Study & Technical Analysis

## Executive Summary
The **GL Daily Rates Upload** is a utility report and interface tool designed to facilitate the bulk upload or update of daily exchange rates into Oracle EBS. It streamlines the maintenance of currency rates, replacing manual data entry with an efficient Excel-based interface. This tool is vital for organizations that manage high volumes of currency pairs or require frequent rate updates from external treasury systems.

## Business Use Cases
*   **Bulk Rate Maintenance**: Enables the mass upload of monthly or daily rates from central treasury systems or external feeds (e.g., Bloomberg, Reuters) directly into Oracle GL.
*   **Correction of Errors**: Allows for the rapid correction of incorrect rates across a date range by simply uploading the correct values, which overwrite the existing entries.
*   **New Currency Setup**: Accelerates the initialization of historical rates when a new currency is introduced to the business.
*   **Month-End Close**: Ensures all necessary period-end rates are populated quickly to allow for timely revaluation and translation processes.

## Technical Analysis

### Core Tables
*   `GL_DAILY_RATES_INTERFACE`: The interface table where data is initially staged before being validated and imported.
*   `GL_DAILY_RATES`: The final destination table for the validated exchange rates.
*   `GL_DAILY_CONVERSION_TYPES`: Validates the conversion type provided in the upload.
*   `FND_CURRENCIES`: Validates the currency codes.

### Key Joins & Logic
*   **Interface Mechanism**: This tool typically functions as a wrapper for the Oracle GL Currency API (`GL_CURRENCY_API`) or the standard open interface.
*   **Upsert Logic**: The logic checks if a rate already exists for the given currency pair, date, and type.
    *   If it **exists**, the tool performs an `UPDATE` to modify the rate.
    *   If it **does not exist**, it performs an `INSERT` to create a new record.
*   **Validation**: It enforces strict validation rules:
    *   Currencies must be active and valid.
    *   Conversion dates must be in valid open or future periods (depending on configuration).
    *   No duplicate rates for the same key combination.

### Key Parameters
*   **Upload Mode**: Specifies whether to validate only or validate and load.
*   **From Currency / To Currency**: The currency pair being loaded.
*   **Conversion Date**: The date for which the rate applies.
*   **Conversion Type**: The rate type (e.g., Corporate).
*   **Conversion Rate**: The numerical exchange rate value.
