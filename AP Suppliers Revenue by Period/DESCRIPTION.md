# Case Study & Technical Analysis: AP Suppliers Revenue by Period

## Executive Summary
The AP Suppliers Revenue by Period report shows Oracle Payables invoice value for each supplier and invoice currency, spread across a sequence of accounting periods. Each period is a column, so a finance or procurement user can see how spend with each supplier moved from one month to the next over a chosen range. It supports supplier spend reviews, budget tracking against trading partners and period-by-period analysis of purchasing volume before and after period close.

## Business Challenge
*   **Spend visibility by period:** Standard supplier reports show totals for one range, not how invoice value is distributed across the accounting calendar.
*   **Multi-currency suppliers:** Invoices for the same supplier can be in several currencies, and totals in different currencies must not be added together.
*   **Calendar alignment:** Invoices must be assigned to the same accounting periods that the general ledger uses, not to calendar months by invoice date.
*   **Supplier classification:** Analysts need to group spend by supplier type to compare categories of vendors.

## The Solution
*   **Invoice-level period assignment:** Each invoice is placed in the GL period whose date range contains its invoice GL date, using the ledger's period set and accounted period type.
*   **Dynamic period columns:** The report builds one column per period between Period From and Period To, so the range can be changed without modifying the layout.
*   **Currency-separated totals:** Totals are grouped by the invoice currency code, so each supplier shows one row per currency.
*   **Supplier context:** Supplier name, supplier number and vendor type are shown beside the amounts, with the vendor type translated to its meaning.

## Technical Architecture (High Level)
### Primary Tables
*   `GL_LEDGERS`: the ledger, which supplies the period set name and accounted period type used to find periods.
*   `GL_PERIODS`: the accounting calendar, read for period start and end dates. Adjustment periods are excluded.
*   `HR_OPERATING_UNITS`: the operating unit, linked to its ledger through the set of books ID and to invoices through the organization ID.
*   `AP_INVOICES_ALL`: the invoice header, which supplies the invoice amount, invoice currency code, GL date and operating unit.
*   `AP_SUPPLIERS`: the supplier master, which supplies the supplier name, number and vendor type.

### Logical Relationships
1.  `GL_LEDGERS` is joined to `HR_OPERATING_UNITS` on the ledger ID and set of books ID.
2.  `HR_OPERATING_UNITS` is joined to `AP_INVOICES_ALL` on the organization ID and invoice org ID.
3.  `AP_INVOICES_ALL` is joined to `AP_SUPPLIERS` on the vendor ID.
4.  For each invoice, a scalar subquery finds the non-adjustment `GL_PERIODS` row of the ledger's period set and period type whose range contains the invoice GL date. The result is reduced to a month label.
5.  The inner rows are summed by supplier, supplier number, vendor type, currency and period month in the outer query.

## Parameters & Filtering
*   **Ledger:** Selects the ledger whose period set defines the period columns and the operating units that belong to it.
*   **Operating Unit:** Restricts invoices to one operating unit.
*   **Supplier and Supplier Number:** Limit the output to one supplier or a specific supplier number.
*   **Period From and Period To:** Set the range of accounting periods that become columns.
*   **Summary Level:** Changes the grouping of the output rows.

## Performance & Optimization
*   **Ledger-driven scope:** The ledger and operating unit joins limit invoice rows to the operating units of the chosen ledger before aggregation.
*   **Adjustment periods excluded:** The period lookup filters out adjustment periods, so each invoice maps to exactly one ordinary period.
*   **Single aggregation pass:** Period amounts are computed as one inner row per invoice, then summed once per supplier and currency in the outer query.
*   **Dynamic column expansion:** Period columns are generated from the parameter range, so the column count, and the work per row, grows with the number of periods selected.

## FAQ
**Q: Why does an invoice appear in a different period from its invoice date?**
A: The report assigns each invoice to the GL period that contains its GL date, and the periods come from the ledger's accounting calendar, so the GL date controls the placement.

**Q: Are invoice amounts in different currencies added together?**
A: No. Totals are grouped by invoice currency code, so a supplier that invoices in two currencies appears on two rows.

**Q: Can I see one supplier over a single quarter?**
A: Yes. Enter the supplier or supplier number together with Period From and Period To covering the quarter.
