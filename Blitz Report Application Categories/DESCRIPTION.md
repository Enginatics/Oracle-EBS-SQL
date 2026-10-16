# Blitz Report Application Categories - Case Study & Technical Analysis

## Executive Summary

The **Blitz Report Application Categories** report is a configuration audit and setup tool. It defines the mapping between Oracle E-Business Suite Applications (e.g., "Payables", "Receivables") and Blitz Report Categories. This mapping drives the automatic categorization of reports when they are imported from standard Concurrent Programs or BI Publisher, ensuring an organized and intuitive report repository.

## Business Challenge

When migrating hundreds of legacy reports into Blitz Report, organization is key.
*   **Clutter:** Without categorization, a library of 500 reports becomes unsearchable.
*   **Manual Effort:** Manually assigning a category to every imported report is tedious.
*   **Consistency:** Different developers might categorize "Invoice Aging" differently (e.g., "AP" vs. "Payables" vs. "Finance").

## Solution

The **Blitz Report Application Categories** setup automates this organization:
*   **Auto-Assignment:** When a report is imported (e.g., `APXAGING`), the system looks up its application (`SQLAP`), finds the mapped category (e.g., "Accounts Payable"), and assigns it automatically.
*   **Standardization:** Enforces a consistent taxonomy across the organization.
*   **Maintenance:** Allows for easy re-mapping if category structures change.

## Technical Architecture

The logic relies on a specific lookup type that acts as the mapping table.

### Key Tables & Joins

*   **Mapping:** `FND_LOOKUP_VALUES` (specifically the lookup type `XXEN_REPORT_APPS_CATEGORIES`) stores the relationship.
    *   *Lookup Code:* The Oracle Application Short Name (e.g., 'SQLAP').
    *   *Meaning:* The Blitz Report Category Name (e.g., 'Accounts Payable').
*   **Application:** `FND_APPLICATION_VL` validates the application codes.

### Logic

1.  **Retrieval:** Lists all defined mappings from the lookup type.
2.  **Validation:** Ensures that the Application Short Name exists in FND_APPLICATION.
3.  **Usage:** This mapping is consumed by the "Import" feature in Blitz Report.

## Parameters

*   **None:** Typically runs as a full list of all mappings.

## FAQ

**Q: What happens if an application is not mapped?**
A: If a report belongs to an application that isn't in this mapping, it is usually assigned to a default category (e.g., "Uncategorized" or "Other") or the category matching the application name itself.

**Q: Can I map multiple applications to one category?**
A: Yes. For example, you could map both 'SQLAP' (Payables) and 'AP' (Payables Intelligence) to the single category "Accounts Payable".

**Q: How do I add a new mapping?**
A: You add a new code to the `XXEN_REPORT_APPS_CATEGORIES` lookup type via the standard Oracle Lookups form or via a setup upload.
