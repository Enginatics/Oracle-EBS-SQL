# Case Study & Technical Analysis: CAC Shipping Network (Inter-Org) Accounts Setup

## Executive Summary
The **CAC Shipping Network (Inter-Org) Accounts Setup** report is a critical financial control report. It documents the configuration of the "Shipping Network"—the rules and accounts that govern inventory transfers between organizations. This setup determines *how* transfers happen (Direct vs. Intransit) and *where* the money goes.

## Business Challenge
*   **Inter-Company Reconciliation**: If Org A (USA) ships to Org B (UK), the Inter-Company Receivable/Payable accounts must be set up correctly to eliminate upon consolidation.
*   **Intransit Visibility**: If the "Intransit Inventory" account is missing or wrong, goods in transit will disappear from the balance sheet.
*   **Transfer Failures**: Transactions will fail in the interface if the required accounts are not defined.

## Solution
This report audits the `mtl_interorg_parameters` table.
*   **Flow**: `From Org` -> `To Org`.
*   **Method**: Intransit (2-step) or Direct (1-step).
*   **FOB Point**: Shipment (Title passes at dock) or Receipt (Title passes at destination).
*   **Accounts**: Inter-Org Receivables, Payables, Intransit Inventory, Transfer Credit.

## Technical Architecture
*   **Tables**: `mtl_interorg_parameters`, `gl_code_combinations`.
*   **Logic**: Checks for null or invalid CCIDs in the setup.

## Parameters
*   **From Org / To Org**: (Optional) Filter specific lanes.

## Performance
*   **Fast**: Configuration data.

## FAQ
**Q: What is "FOB Point"?**
A: "Free On Board". It determines ownership during transit.
    *   FOB Shipment: Receiving Org owns it while on the truck.
    *   FOB Receipt: Shipping Org owns it while on the truck.
**Q: Why are the accounts blank?**
A: If the transfer type is "Direct", Intransit accounts are not required.
