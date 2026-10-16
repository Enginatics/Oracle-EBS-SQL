# Case Study & Technical Analysis: INV Movement Statistics

## Executive Summary
This report produces the Intrastat movement statistics for an EU legal entity, covering arrivals, dispatches and their adjustments for a reporting period. It is the detail behind a statutory declaration to the national statistics authority, and it presents either a summary or a line-level detail for each movement type. Trade compliance and tax teams use it at the end of each period to prepare the Intrastat return, and to reconcile the shipments and invoices that feed it. The report runs in Excel through Blitz Report and reproduces the layout of the Oracle Movement Statistics report.

## Business Challenge
*   **Statutory reporting:** Each EU entity must declare its intra-community arrivals and dispatches by commodity code, country and value for every period.
*   **Multiple source documents:** Movements come from purchase receipts, sales invoices, purchase orders, sales orders and requisitions, and each must be traced to the declaration.
*   **Adjustments and corrections:** Arrival and dispatch adjustments must be reported separately from original movements.
*   **Parameter-driven layout:** Summary and detail declarations, usage types and statistical types each change the declared values.

## The Solution
*   **Movement type titles:** The report title is chosen from the movement type and the report option, so an arrival summary, a dispatch detail or an adjustment is labeled correctly.
*   **Legal entity and tax office data:** The legal entity name, address, contact, VAT registration number and tax office details are returned from the legal entity and statistics setup.
*   **Statistical rules:** Usage type, statistical type and economic zone are matched to the statistics setup for each movement, and their meanings are returned.
*   **Source traceability:** Each movement is linked to its receipt, invoice, purchase order or sales order, with the customer or supplier site.
*   **Currency and rate:** Values are shown in the chosen currency using the exchange rate entered as a parameter.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_MOVEMENT_STATISTICS`: the movement records, with movement type, status, commodity code, quantity, value and period.
*   `MTL_STAT_TYPE_USAGES`: the usage type, statistical type and tax office for each legal entity and zone.
*   `MTL_ECONOMIC_ZONES_VL`: the economic zone name and code.
*   `GL_LEDGER_LE_V` and `GL_PERIODS`: the primary ledger of the legal entity and the period dates.
*   `RCV_TRANSACTIONS`, `RCV_SHIPMENT_HEADERS` and `RCV_SHIPMENT_LINES`: the receipts and shipments behind arrivals.
*   `PO_HEADERS_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL`, `PO_RELEASES_ALL` and `PO_REQUISITION_HEADERS_ALL`: the purchase sources of movements.
*   `AP_INVOICES_ALL`: the supplier invoice that supports an arrival.
*   `RA_CUSTOMER_TRX_ALL` and `RA_CUSTOMER_TRX_LINES_ALL`: the customer invoice that supports a dispatch.
*   `OE_ORDER_HEADERS_ALL` and `OE_ORDER_LINES_ALL`: the sales order behind a dispatch.
*   `MTL_SYSTEM_ITEMS_KFV` and `MTL_SYSTEM_ITEMS_TL`: the item and its description.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES`, `HZ_CUST_SITE_USES_ALL` and `HZ_LOCATIONS`: the customer, site and tax office address.
*   `HR_LOCATIONS_NO_JOIN`, `PER_PEOPLE_F` and `FND_LOOKUPS`: the entity address, the contact person and the lookup meanings.

### Logical Relationships
1. The movement records are the driving source, and the report keeps only movements in status O or V.
2. For arrivals and dispatches, only the parent movement is kept. For other movement types, the earliest movement of each parent is kept.
3. Each movement joins to its source documents through outer joins on receipt, purchase order, sales order, invoice and shipment identifiers.
4. The legal entity joins to `MTL_STAT_TYPE_USAGES` on statistics type, usage type and zone, which supplies the tax office and the usage meaning.
5. The period joins to `GL_PERIODS` on the period name, giving the start and end dates shown in the header.

## Parameters & Filtering
*   **Legal Entity:** restricts the declaration to one legal entity.
*   **Economic Zone:** restricts the movements to one zone.
*   **Usage Type and Statistical Type:** restrict the movements to one usage or statistical type.
*   **Movement Type:** restricts the movements to arrivals, arrival adjustments, dispatches or dispatch adjustments.
*   **Period Name:** sets the reporting period.
*   **Report Option:** selects a summary or a detail layout.
*   **Currency, Exchange Rate, Amount Display Format, Reporting Precision and Rounding Method:** control how values are presented.

## Performance & Optimization
*   The period, legal entity and statistics type conditions are applied in the outer query, so each source join runs only for movements of the chosen declaration.
*   Source joins are outer joins, which keeps movements whose source document is missing rather than dropping them from the declaration.
*   The correlated minimum-movement check for non-arrival and non-dispatch types limits each parent movement to one declared line.

## FAQ
**Q: Why does the report show only some movements of a purchase order?**
A: Only movements in status O or V are included, and for arrivals and dispatches only the parent movement is kept.

**Q: How are adjustments shown?**
A: Adjustments are reported under their own movement types, with titles such as Arrival Adjustment or Dispatch Adjustment.
