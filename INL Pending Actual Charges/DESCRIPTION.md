# Case Study & Technical Analysis: INL Pending Actual Charges

## Executive Summary
This report lists the landed cost charges on receipts that no Accounts Payable invoice has been matched to yet. Each row is a shipment line, charge type and charging party combination, aged by shipment date at the chosen as-of date. It shows the estimated amount of the freight, duty and brokerage charges still awaiting their invoices, and the accrual exposure they carry. Import and logistics accountants use it at period close to see which landed costs are still estimates and to chase the missing supplier invoices. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Unmatched landed costs:** Freight, duty and brokerage charges are estimated at receipt, and their invoices may arrive weeks later.
*   **Accrual exposure:** Estimated landed costs that are not yet invoiced affect inventory value and accruals at period end.
*   **Aging of open charges:** Charges that have waited for their invoices for months need escalation to the forwarder or broker.
*   **Interface failures:** A charge invoice that failed in the landed cost matches interface looks matched in Payables but is still pending in landed cost management.

## The Solution
*   **Estimate and current amount:** The current estimate, including later estimate changes, is shown with the original first calculation for comparison.
*   **Pending test per charge type:** A charge stops being pending on a receipt line once any invoice of that charge type is matched to it, whatever the amount.
*   **Aging buckets:** Each row is placed in 0-30, 31-60, 61-90, 91-180 or 181-plus day buckets by shipment date at the as-of date.
*   **Interface visibility:** The matched amount, interface status and invoice numbers of charges still in the matches interface are shown.
*   **Closed lines excluded:** Shipment lines closed for matching are excluded unless the Include Closed for Matching parameter is set.

## Technical Architecture (High Level)
### Primary Tables
*   `INL_SHIP_HEADERS_ALL` and `INL_SHIP_LINES_ALL`: the landed cost shipment and its lines.
*   `INL_ALLOCATIONS`: the allocated landed cost amounts, by adjustment number.
*   `INL_CHARGE_LINES`: the charge lines, with charge type and charging party.
*   `INL_MATCHES`: the matches already made to a charge type on a shipment line.
*   `INL_MATCHES_INT`: the charges waiting in the matches interface, with their processing status.
*   `RCV_SHIPMENT_LINES` and `RCV_SHIPMENT_HEADERS`: the receipt lines and headers linked to the landed cost line.
*   `RCV_TRANSACTIONS`: the receive transactions that give the receipt date.
*   `PO_HEADERS_ALL`, `PO_LINES_ALL` and `PO_LINE_LOCATIONS_ALL`: the purchase order that the shipment line came from.
*   `PON_COST_FACTORS_VL`: the landed cost charge type names.
*   `AP_SUPPLIERS` and `HZ_PARTIES`: the supplier and the charging party.
*   `GL_LEDGERS` and `ORG_ORGANIZATION_DEFINITIONS`: the ledger currency of each organization.

### Logical Relationships
1. The estimated amounts come from an inline view that sums allocations of the landed cost flag by shipment line and charge line type, for the original adjustment and the current adjustment.
2. The inline view is joined to the interface matches view on shipment line and charge line type, as an outer join, so a charge with no interface record still appears.
3. A charge is excluded when a matching `INL_MATCHES` row of type CHARGE already exists for the shipment line and charge type.
4. The shipment line joins to `RCV_SHIPMENT_LINES` through the LCM shipment line id, and to the purchase order through the line location of a PO source.
5. The charge type joins to `PON_COST_FACTORS_VL` on the price element type id, and the charging party to `HZ_PARTIES`.

## Parameters & Filtering
*   **Operating Unit and Organization Code:** restrict the shipments to one operating unit and organization.
*   **As of Date:** sets the date from which the age of each shipment is measured.
*   **Minimum Age Days:** excludes younger shipments from the list.
*   **Shipment Date From / Shipment Date To:** bound the shipments by shipment date.
*   **Supplier, Item, Charge Type and Charging Party:** narrow the charges to one supplier, item, charge or charging party.
*   **Include Closed for Matching:** when set to Y, includes shipment lines closed for matching.

## Performance & Optimization
*   The organization restriction uses the organization access view for the responsibility, so the inline view reads only the shipments the user can access.
*   The matched-charge exclusion is a NOT IN subquery on `INL_MATCHES`, which removes charges already invoiced before the outer joins run.

## FAQ
**Q: Why does a charge still show as pending after I entered its invoice?**
A: The invoice must be matched to the same shipment line and charge type, and the Landed Cost Management matches import must have processed it. Until then the charge stays pending.

**Q: Why are closed shipment lines missing?**
A: Shipment lines closed for matching are excluded unless the Include Closed for Matching parameter is set to Y.
