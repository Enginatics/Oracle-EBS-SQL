# Case Study & Technical Analysis: CE Bank Account Balances Report

## Executive Summary
The **CE Bank Account Balances** report is a comprehensive Treasury Management tool designed to provide immediate visibility into cash positions across the enterprise. It consolidates functionality from multiple standard Oracle Cash Management reports into a single, flexible interface. This report is essential for Treasury Managers and Financial Controllers who need to monitor liquidity, reconcile bank statements, and forecast cash flow requirements without running disparate processes.

## Business Challenge
Managing cash visibility in Oracle EBS can be fragmented:
*   **Fragmented Reporting:** Users often have to run separate reports for "As Of" dates versus "Date Ranges," making trend analysis difficult.
*   **Data Gaps:** If no transaction occurred on a specific date, standard reports might show a zero balance or no record, rather than carrying forward the last known closing balance.
*   **Forecasting Disconnect:** Comparing actual bank balances against projected cash flows usually requires manual extraction and merging of data in Excel.
*   **Multi-Currency Complexity:** Consolidating balances across different currencies and legal entities for a global cash position is time-consuming.

## The Solution
This report solves these challenges by offering a unified view of bank balances with advanced logic to handle data gaps.
*   **Unified Modes:** Supports "Single Date," "Date Range," and "Actual vs. Projected" analysis in one report.
*   **Smart Roll-Forward:** Includes a "Bring Forward Prior Balances" feature. If a bank account had no activity on the requested date, the report automatically retrieves the most recent closing balance, ensuring a complete picture of liquidity.
*   **Variance Analysis:** Allows direct comparison between Actual Ledger Balances and Projected Balances (based on cash flow forecasting), highlighting variances immediately.
*   **Global Visibility:** Aggregates data across Legal Entities and Currencies, with options for reporting currency conversion.

## Technical Architecture (High Level)
The report utilizes advanced SQL analytic functions to perform complex balance calculations directly in the database.

### Primary Tables
*   `CE_BANK_ACCT_BALANCES`: The core table storing daily closing balances (Ledger, Available, Value Dated).
*   `CE_PROJECTED_BALANCES`: Stores forecasted balances derived from Cash Flow Mapping.
*   `CE_BANK_ACCTS_GT_V`: View providing bank account details and security.
*   `XLE_ENTITY_PROFILES`: Links bank accounts to Legal Entities.
*   `HZ_PARTIES`: Provides Bank and Branch names.

### Logical Relationships
*   **Complex Balance Logic:** The query uses a Common Table Expression (CTE) with analytic functions (`KEEP (DENSE_RANK LAST ORDER BY ...)`). This is the technical engine behind the "Bring Forward" logic, allowing the query to efficiently find the last valid balance for each account without expensive correlated subqueries.
*   **Full Outer Join:** It performs a full outer join between `CE_BANK_ACCT_BALANCES` and `CE_PROJECTED_BALANCES`. This ensures that the report shows days where there is a projection but no actual balance, and vice versa.
*   **Security:** The report integrates with Oracle's security model via `CE_BANK_ACCTS_GT_V` to ensure users only see bank accounts they are authorized to access.

## Parameters & Filtering
The report offers versatile parameters to switch between reporting modes:
*   **As Of Date:** Defines the target date for a snapshot view.
*   **Balance Date From / To:** Defines the range for trend analysis.
*   **Bring Forward Prior Balances:** (Yes/No) Determines if the report should search for the last known balance if the "As Of" date has no record.
*   **Actual vs Projected Balance Type:** Selects the specific balance type (e.g., Ledger, Available) to compare against projections.
*   **Bank Account / Legal Entity:** Standard filters to narrow down the scope of the report.

## Performance & Optimization
*   **Analytic Functions:** By using window functions to calculate the "last known balance," the report avoids the performance penalty of running a separate query for every bank account to find its max date.
*   **Single Pass Execution:** The report calculates actuals, projections, and variances in a single database pass, reducing I/O overhead compared to running three separate standard reports.

## FAQ
**Q: Why do I see a balance date different from my "As Of Date"?**
A: If you set "Bring Forward Prior Balances" to 'Yes', and there was no activity on your "As Of Date," the report shows the date of the last actual balance update. This confirms you are looking at the most current valid data.

**Q: Can I see both Ledger and Available balances?**
A: Yes, the report extracts multiple balance types (Ledger, Available, Value Dated, 1-Day Float, etc.) simultaneously. You can choose which columns to display in the Excel output.

**Q: How does the "Actual vs Projected" comparison work?**
A: When you select a balance type for comparison, the report calculates the variance (Actual - Projected). This is useful for validating the accuracy of your cash forecasting rules.
