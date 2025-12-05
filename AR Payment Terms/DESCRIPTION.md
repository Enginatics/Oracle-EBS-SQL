# AR Payment Terms - Case Study & Technical Analysis

## Executive Summary

The **AR Payment Terms** report is a configuration audit tool that lists all defined payment terms within the Oracle Receivables module. Payment terms dictate the due dates and discount eligibility for customer invoices. This report is essential for Finance Managers and System Administrators to verify that the system's logic aligns with the company's credit policies and to identify obsolete terms for cleanup.

## Business Challenge

Payment terms are the rules of engagement for cash collection.
*   **Consistency:** If "Net 30" is defined differently in two different systems or operating units, it causes confusion.
*   **Revenue Leakage:** Incorrectly configured discount terms (e.g., offering 2% discount for too long) can directly impact profit margins.
*   **Data Hygiene:** Over years of operation, systems often accumulate duplicate or unused terms (e.g., "Net 30 Old", "Net 30 New"), leading to data entry errors.

## Solution

The **AR Payment Terms** report provides a structured inventory of these rules:
*   **Definition Review:** Displays the exact calculation logic (e.g., "Due 30 days after invoice date").
*   **Discount Audit:** Shows the percentage and days for early payment discounts.
*   **Split Terms:** Identifies complex terms where payments are split (e.g., "50% due in 30 days, 50% due in 60 days").

## Technical Architecture

The report queries the core setup tables for payment terms.

### Key Tables & Joins

*   **Header:** `RA_TERMS_B` and `RA_TERMS_TL` store the term name, description, and effective dates.
*   **Lines:** `RA_TERMS_LINES` defines the schedule. A simple term has one line (100% due). Complex terms have multiple lines.
*   **Discounts:** `RA_TERMS_LINES_DISCOUNTS` stores the discount percentage and the number of days the discount is valid.
*   **Billing Cycle:** May link to billing cycle definitions if the term is cycle-based.

### Logic

1.  **Retrieval:** Fetches all terms from the header table.
2.  **Expansion:** Joins to the lines table to show the "Due Days" or "Fixed Date" logic.
3.  **Detailing:** Joins to the discount table to display any early payment incentives.

## Parameters

*   **None (Standard):** Often runs as a full list.
*   **Term Name:** (Optional) To filter for a specific term.
*   **Active Only:** (Implicit) Often filtered to show only currently active terms, though auditing inactive ones is also useful.

## FAQ

**Q: What is the difference between "Due Days" and "Fixed Date"?**
*   **Due Days:** Adds a number of days to the invoice date (e.g., Invoice Date + 30).
*   **Fixed Date:** Sets the due date to a specific day of the month (e.g., 15th of the following month).

**Q: Can I change a payment term after it has been used?**
A: You can change the description, but changing the schedule (lines) of a term that is already assigned to invoices can have side effects. It is best practice to end-date the old term and create a new one.

**Q: How do "Split Terms" work?**
A: The report will show multiple rows for a single term name, each representing a portion of the payment (e.g., Sequence 1: 50%, Sequence 2: 50%).
