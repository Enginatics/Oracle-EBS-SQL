# Case Study & Technical Analysis: AR Customer Credit Limits

## Executive Summary
The **AR Customer Credit Limits** report is a strategic tool for Credit Managers and Financial Controllers. It provides a comprehensive audit of customer credit profiles, limits, and associated General Ledger accounts. By consolidating data from the complex Trading Community Architecture (TCA), this report enables organizations to proactively manage credit risk, ensure compliance with credit policies, and streamline the dunning process.

## Business Challenge
Managing customer credit risk in Oracle EBS can be daunting due to the scattered nature of the data. Common challenges include:
*   **Credit Risk Exposure:** Inability to easily identify customers with missing or outdated credit limits, leading to potential bad debt.
*   **Operational Inefficiency:** Manual checks required to verify if a customer is on "Credit Hold" or if their credit limit aligns with their current sales volume.
*   **Audit Gaps:** Difficulty in extracting a clean list of all credit limits and GL accounts for internal or external audits.
*   **Dunning Errors:** Incorrect dunning letters sent due to misconfigured profiles or missing contact information.

## The Solution
This report delivers a centralized "Operational View" of customer credit setups. It solves the business challenges by:
*   **Unified Reporting:** Merging Customer, Account, and Site level credit profiles into a single view.
*   **Exception Management:** The "Show Missing Credit Amounts" feature allows users to instantly isolate customers who have no credit limit defined, a key risk indicator.
*   **Financial Visibility:** Optionally including "Receivables Balance" and "Uninvoiced Orders" provides a real-time snapshot of credit utilization against the defined limits.

## Technical Architecture (High Level)
The report navigates the Oracle Trading Community Architecture (TCA) to retrieve credit profile data.
*   **Primary Tables:**
    *   `HZ_CUSTOMER_PROFILES`: The core table storing the credit profile class and settings (e.g., Credit Hold flag).
    *   `HZ_CUST_PROFILE_AMTS`: Stores the actual currency-based credit limits and order limits.
    *   `HZ_PARTIES` & `HZ_CUST_ACCOUNTS`: Provides the customer identity and account structure.
    *   `HZ_CUST_ACCT_SITES_ALL` & `HZ_CUST_SITE_USES_ALL`: Used when reporting at the specific "Bill To" site level.
    *   `AR_PAYMENT_SCHEDULES_ALL`: Accessed to calculate current open balances if requested.

*   **Logical Relationships:**
    The report logic handles the hierarchy of credit enforcement. It checks for profiles at the Site level first; if not found, it falls back to the Account level. This mirrors the Oracle Order Management credit checking logic, ensuring the report matches system behavior.

## Parameters & Filtering
*   **Display Level:** Critical for choosing between a high-level "Customer" summary or a detailed "Site" level audit.
*   **Show Missing Credit Amounts:** A powerful filter for exception reporting. Setting this to 'Yes' filters the output to only show customers lacking a defined credit limit.
*   **Show Receivables Balance:** When enabled, adds a column for the current outstanding balance, transforming the report from a static setup audit to a dynamic risk analysis tool.

## Performance & Optimization
*   **TCA Optimization:** The query is optimized to handle the complex joins between Parties, Accounts, and Sites efficiently.
*   **Conditional Logic:** The calculation of "Receivables Balance" is conditional. If the user does not request it, the report skips the heavy aggregation of `AR_PAYMENT_SCHEDULES_ALL`, ensuring the report runs instantly for simple setup audits.

## FAQ
**Q: Why do I see multiple rows for the same customer?**
A: This usually happens if you are running the report at the "Site" level and the customer has multiple Bill-To sites, each with its own credit profile or limit.

**Q: How can I find all customers who are currently on Credit Hold?**
A: You can filter the output in Excel on the "Credit Hold" column (looking for 'Y'), or add a filter to the report definition if you run this frequently.

**Q: Does this report show the "Global" credit limit?**
A: Yes, if your system is configured to use Global Credit Checking, the report retrieves the limits defined at the Global level in `HZ_CUST_PROFILE_AMTS`.
