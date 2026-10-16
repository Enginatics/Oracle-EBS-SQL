# Case Study & Technical Analysis: CAC Inventory and Intransit Value (Period-End) - Discrete/OPM

## Executive Summary
The **CAC Inventory and Intransit Value (Period-End) - Discrete/OPM** report is a unified valuation tool designed for hybrid manufacturing environments. It consolidates inventory reporting for organizations using Oracle Discrete Manufacturing and Oracle Process Manufacturing (OPM). By providing a single view of inventory assets across both methodologies, it simplifies the month-end reconciliation process for complex enterprises.

## Business Challenge
Companies operating both Discrete and Process manufacturing often face a "reporting divide."
*   **Data Silos**: Discrete inventory data lives in `cst_period_close_summary`, while OPM data is historically stored in separate GMF tables.
*   **Consolidation Pain**: Finance teams often have to run two separate sets of reports and manually merge them in Excel to get a total inventory number.
*   **Intransit Complexity**: OPM has historically lacked robust month-end snapshots for intransit inventory, making accurate valuation difficult.

## Solution
This report bridges the architectural gap between the two modules.
*   **Unified Output**: Presents Discrete and OPM inventory side-by-side in a consistent format.
*   **OPM Intransit Logic**: Implements a custom logic (based on the last two years of shipments) to reconstruct OPM intransit balances, addressing a known gap in standard OPM reporting.
*   **Flexible Costing**: Allows valuation using either the historical snapshot cost or a "What-If" cost type.

## Technical Architecture
The report employs a sophisticated "Union" structure to merge the data sources:
*   **Discrete Leg**: Queries `cst_period_close_summary` for standard discrete organizations.
*   **OPM Leg**: Queries OPM-specific tables (implied by the need for Calendar/Period codes) and logic to derive quantities.
*   **Intransit Calculation**: For OPM, it calculates intransit based on shipment history rather than a simple table read, ensuring accuracy even without a native snapshot.

## Parameters
*   **Period Name**: (Mandatory) The accounting period to report.
*   **OPM Calendar/Period Code**: (Mandatory) Specific OPM timeframes required to align with the Discrete period.
*   **Cost Type**: (Optional) For revaluation analysis.

## Performance
*   **Complex Execution**: Due to the need to calculate OPM intransit from transaction history, this report may take longer to run than a standard discrete-only report.
*   **Optimization**: Users should filter by Organization or Operating Unit if performance becomes an issue in large environments.

## FAQ
**Q: Why do I need OPM Calendar codes?**
A: OPM uses a different calendar system than the standard General Ledger/Inventory calendar. The report needs these codes to find the correct period in the OPM subledger.

**Q: Does this support "Process" organizations that use Standard Costing?**
A: Yes, the report is designed to handle the specific costing nuances of OPM organizations.

**Q: What if I only have Discrete orgs?**
A: You can use this report, but the standard "CAC Inventory and Intransit Value (Period-End)" report might be slightly faster as it doesn't contain the OPM logic overhead.
