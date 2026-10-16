# Case Study & Technical Analysis: CAC Inventory Lot and Locator OPM Value (Period-End)

## Executive Summary
The **CAC Inventory Lot and Locator OPM Value (Period-End)** report provides a granular audit trail for Process Manufacturing (OPM) inventory. Unlike high-level summary reports, this tool drills down to the specific Lot and Locator (Row/Rack/Bin) level, providing the detailed evidence needed to substantiate inventory valuations for sensitive or regulated materials (e.g., chemicals, pharmaceuticals).

## Business Challenge
In Process Manufacturing, the value of inventory is often tied to specific batches or lots which may have different costs or expiration dates.
*   **Audit Granularity**: Auditors often require a "floor-to-sheet" count where they verify specific lots in specific bins. Summary reports are insufficient for this.
*   **Expiration Risk**: High-value chemicals often expire. Finance needs to know the value of inventory that is approaching its shelf life to accrue for potential write-offs.
*   **Locator Accuracy**: Verifying that hazardous materials are stored in the correct locations requires visibility into the locator-level balances.

## Solution
This report unlocks the detailed subledger data for OPM.
*   **Deep Dive**: Reports Quantity and Value by Item, Lot, and Locator.
*   **Expiration Visibility**: Includes the Lot Expiration Date, enabling "At-Risk" inventory analysis.
*   **Intransit Detail**: Also covers intransit inventory, providing a complete picture of owned assets.

## Technical Architecture
The report navigates the complex OPM table structure:
*   **Data Sources**: Joins `mtl_system_items` with OPM-specific quantity tables (likely `gmf_period_balances` or similar derived logic) and `mtl_item_locations` for locator definitions.
*   **Lot Details**: Pulls lot attributes from `mtl_lot_numbers`.
*   **Valuation**: Applies the period-end cost to the detailed quantities to derive the line-level value.

## Parameters
*   **Show OPM Lot Number**: (Mandatory) Toggle to enable/disable lot detail.
*   **Show OPM Locator**: (Mandatory) Toggle to enable/disable bin location detail.
*   **OPM Calendar/Period**: (Mandatory) Defines the reporting timeframe.

## Performance
*   **High Volume**: Enabling Lot and Locator details can result in a massive number of rows (millions) for large warehouses.
*   **Export Strategy**: It is recommended to export this report to Excel or a database for further analysis rather than printing it.

## FAQ
**Q: Can I see expired lots only?**
A: The report lists all lots. You can filter the output in Excel based on the "Lot Expiration Date" column.

**Q: Why is the locator field empty?**
A: If the item is not locator-controlled, or if the inventory is in an intransit location, the locator field will be blank.

**Q: Does this include Quality status?**
A: Yes, it typically includes the Lot Status (e.g., "Quarantine", "Released"), which is crucial for valuation (e.g., valuing quarantined items at zero).
