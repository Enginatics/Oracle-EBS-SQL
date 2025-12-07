# Case Study & Technical Analysis: CAC AP Accrual Reconciliation Load Request

## Executive Summary
The **CAC AP Accrual Reconciliation Load Request** report is an audit and diagnostic tool designed for Cost Accountants and Finance Managers. It tracks the execution history of the "Accrual Reconciliation Load Run" program, which is a prerequisite for reconciling the Accounts Payable (AP) accrual accounts. By providing visibility into *when* the load was run, *who* ran it, and for *which* operating units, this report helps ensure that the accrual data is up-to-date before month-end reconciliation activities begin.

## Business Challenge
The AP Accrual Reconciliation process in Oracle EBS relies on a concurrent program to populate the reconciliation tables (`CST_RECONCILIATION_BUILD`). Organizations often face challenges such as:
*   **Stale Data:** Users attempting to reconcile accounts using outdated data because the load program hasn't been run recently.
*   **Process Visibility:** Uncertainty about whether the load program was successfully executed for a specific Operating Unit or Ledger.
*   **Audit Compliance:** Lack of a clear audit trail showing who triggered the data refresh and when, which is critical for financial controls.

## The Solution
The **CAC AP Accrual Reconciliation Load Request** report solves these issues by providing a clear history of the load program's execution. It enables users to:
*   **Verify Data Freshness:** Confirm the "Run To Date" to ensure the reconciliation data includes the latest transactions.
*   **Monitor Schedule Compliance:** Check if the load program is being run according to the month-end close schedule.
*   **Identify Process Owners:** See exactly which user (`Created_By`) initiated the request, facilitating accountability and communication.

## Technical Architecture (High Level)
The report queries the specific build history table used by the Cost Management module.
*   **Core Table:** `CST_RECONCILIATION_BUILD` stores the history of each load request, including the build ID and date ranges.
*   **Context:** `HR_ALL_ORGANIZATION_UNITS_VL` and `GL_LEDGERS` provide the organizational context, linking the technical build ID to business units.
*   **Security:** The report incorporates robust security logic, respecting both Ledger Security (via `GL_ACCESS_SET_NORM_ASSIGN`) and Operating Unit Security (via `MO_GLOB_ORG_ACCESS_TMP`), ensuring users only see history for entities they are authorized to access.

## Parameters & Filtering
The report supports the following parameters:
*   **Beginning Creation Date:** Filters the history to show only load requests created on or after a specific date, useful for focusing on the current period.
*   **Operating Unit:** Allows filtering by specific operating units to audit a particular entity.
*   **Ledger:** Enables filtering by the general ledger to see all related operating units.

## Performance & Optimization
The report is designed for high performance:
*   **Direct Table Access:** It queries the build history table directly rather than calculating accruals, making it instantaneous.
*   **Efficient Joins:** Uses standard foreign key joins between the build table, organization definitions, and user tables.
*   **Security Profiles:** The security clauses are optimized to use standard Oracle temporary tables and profile options, ensuring consistent performance even in complex multi-org environments.

## FAQ
**Q: What is the "Build ID"?**
A: The Build ID is a unique system-generated identifier for each execution of the Accrual Load program. It links the request to the specific set of data populated in the reconciliation tables.

**Q: Why is the "Run To Date" important?**
A: The "Run To Date" indicates the cutoff date for transactions included in that specific load. If you are reconciling for January, you need to ensure the load was run with a "Run To Date" of at least Jan 31st.

**Q: Does this report show the actual accrual balance?**
A: No, this is a metadata report about the *process* of loading data. To see the actual balances and transactions, you would use reports like "CST AP and PO Accrual Reconciliation".
