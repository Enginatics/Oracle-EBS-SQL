# Executive Summary
The **CE Bank Branches** report serves as a master directory of all bank branches defined in the system, covering both internal (company-owned) and external (supplier/customer) banks. It provides a clear view of the banking network relationships, indicating whether a branch is used for internal treasury operations, supplier payments, or customer receipts. This report is vital for Master Data Management (MDM) teams to maintain a clean and accurate banking hierarchy.

# Business Challenge
As organizations grow, the number of bank branches in the system can proliferate, leading to:
*   **Duplicate Records**: Multiple entries for the same physical branch (e.g., "Citibank NY" vs. "Citi New York").
*   **Obsolete Data**: Branches that are no longer in use but remain active in the system.
*   **Routing Errors**: Payments failing because they are routed to an incorrect or inactive branch code (SWIFT/BIC).

Maintaining a clean "Golden Source" of bank branch data is critical for payment processing efficiency.

# Solution
This report lists every bank branch along with its parent Bank and its usage flags.

**Key Features:**
*   **Usage Indicators**: Clearly marks if a branch is used for:
    *   *Internal*: Linked to the company's own bank accounts.
    *   *Supplier*: Linked to supplier payment details.
    *   *Customer*: Linked to customer remittance details.
*   **Global Coverage**: Includes branches from all territories and countries.
*   **Integration**: Links to the underlying party tables (`HZ_PARTIES`) to show the full relationship structure.

# Architecture
The report queries `CE_BANK_BRANCHES_V` and `CE_BANKS_V` for the core branch data. It joins to `IBY` (Payments) tables to determine usage.

**Key Tables:**
*   `CE_BANK_BRANCHES_V`: The primary view for bank branch definitions.
*   `CE_BANK_ACCOUNTS`: To identify internal usage.
*   `IBY_EXT_BANK_ACCOUNTS`: To identify external (supplier/customer) usage.
*   `AP_SUPPLIERS`: To link branches to specific suppliers.

# Impact
*   **Data Hygiene**: Enables the identification and cleanup of duplicate or unused branch records.
*   **Payment Success**: Reduces payment rejections caused by invalid branch routing codes.
*   **Compliance**: Helps ensure that the banking master data matches official bank records.
