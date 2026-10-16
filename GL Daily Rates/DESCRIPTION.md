# GL Daily Rates - Case Study & Technical Analysis

## Executive Summary
The **GL Daily Rates** report provides a comprehensive listing of daily currency exchange rates defined in the Oracle EBS system. It is an essential tool for multi-currency environments, ensuring that conversion rates for foreign currency transactions are accurate, complete, and compliant with corporate treasury policies. This report serves as a primary control for verifying the rates used in currency translation and revaluation processes.

## Business Use Cases
*   **Treasury Management**: Monitors exchange rate trends and ensures that corporate rates (e.g., daily spot rates, monthly average rates) are loaded correctly into the ERP.
*   **Transaction Audit**: Verifies the specific exchange rate applied to a transaction on a given date, which is crucial when investigating currency variances in subledgers (AP/AR).
*   **Missing Rate Identification**: Proactively checks for missing rates between currency pairs before period-end processes (like Revaluation or Translation) fail due to undefined rates.
*   **Intercompany Reconciliation**: Ensures consistent exchange rates are being used across different legal entities for intercompany transactions.
*   **Audit Trail**: Provides a historical record of exchange rates for tax and statutory reporting purposes.

## Technical Analysis

### Core Tables
*   `GL_DAILY_RATES`: The primary table storing the actual exchange rates. It contains the `FROM_CURRENCY`, `TO_CURRENCY`, `CONVERSION_DATE`, and `CONVERSION_RATE`.
*   `GL_DAILY_CONVERSION_TYPES`: Stores the definitions of rate types (e.g., 'Corporate', 'Spot', 'User').
*   `FND_CURRENCIES`: Used to validate currency codes and retrieve precision information.

### Key Joins & Logic
*   **Rate Retrieval**: The query selects from `GL_DAILY_RATES` based on the requested date range and currency pairs.
*   **Type Resolution**: Joins to `GL_DAILY_CONVERSION_TYPES` to display the user-friendly conversion type name instead of the internal code.
*   **Inverse Rates**: Depending on the configuration, the system may store rates in one direction (e.g., USD to EUR) and calculate the inverse (EUR to USD) dynamically. The report typically shows the stored rate but may need to handle inverse logic if requested.
*   **Date Filtering**: Strictly filters by `CONVERSION_DATE` to show the rates active for the specific period of interest.

### Key Parameters
*   **From Currency**: The source currency code (e.g., USD).
*   **To Currency**: The target currency code (e.g., EUR).
*   **Conversion Type**: The specific rate type to report on (e.g., Corporate, Spot).
*   **Conversion Date From/To**: The date range for the report.
