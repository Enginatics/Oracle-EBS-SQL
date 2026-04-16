---
layout: default
title: 'CAC Purchase Price Variance | Oracle EBS SQL Report'
description: 'Report for Purchase Price Variance accounting entries for external inventory purchases, external outside processing purchases, (internal) intransit…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Purchase, Price, Variance, mtl_transaction_accounts, mtl_parameters, wip_transaction_accounts'
permalink: /CAC%20Purchase%20Price%20Variance/
---

# CAC Purchase Price Variance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-purchase-price-variance/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report for Purchase Price Variance accounting entries for external inventory purchases, external outside processing purchases, (internal) intransit shipments, (internal) direct organization transfers and transfer to regular (consignment) transactions.  The FOB point indicates when title passes to the receiving organization and it also determines which internal transfer transaction gets the PPV.  With FOB Shipment, PPV happens on the Intransit Shipment transaction.  With FOB Receipt, PPV happens on the Intransit Receipt transaction.  And if you enter PO receipts by lot numbers this report splits out the PPV variances by lot number.  The PPV Cost Amount column indicates PPV due to only cost differences; the PPV FX Amount column indicates PPV due to differences between the original PO currency exchange rate and the material transaction's daily exchange rate.

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Currency Conversion Type:  enter the currency conversion type to use for converting foreign currency purchases into the currency of hhe general ledger (mandatory).
Category Sets 1-3:  any item category you wish, typically the Cost, Product Line or Inventory category sets (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2010-25 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |  ======= =========== ============== =========================================
-- |  1.0     26 Jan 2010 Douglas Volz   Initial Coding
-- |  1.17    01 Jan 2021 Douglas Volz   Added Section 5 PPV for Transfer to Regular transactions.
-- |  1.18    08 Jan 2021 Douglas Volz   Removed redundant joins and tables to improve performance.
-- |  1.19    14 Dec 2021 Douglas Volz   Bug fix, Section I and V were both picking up
-- |                                     Transfer to Regular PPV transactions
-- |  1.20    21 Jun 2022 Douglas Volz   Add PO Line and PO Shipment Line Creation Date.
-- |  1.21    04 Apr 2022 Andy Haack     Added organization security restriction by org_access_view oav.
-- |  1.22    10 May 2023 Douglas Volz   Fix PPV calculations for RTV and Receipt Adjustment transactions.
-- |  1.23    13 Jan 2024 Douglas Volz   Rewrite report code for single material and WIP transaction pass,
-- |                                     add Transaction Exchange Rate, PPV Cost Amount and PPV FX columns,
-- |                                     improve performance and fix PPV amount and percent calculations.
-- |  1.24    24 Jan 2024 Douglas Volz   Rename column Standard Unit Cost to Standard Purchase Unit Cost.
-- |  1.25    30 May 2025 Douglas Volz   Bug fix for PO Unit Price, added in Clearing Accounting Line Type.
-- |  1.26    16 Jun 2025 Douglas Volz   Bug fix for Intransit Shipment and Internal Order Intransit
-- |                                     Shipment transaction types.
+=============================================================================+*/

## Report Parameters
Transaction Date From, Transaction Date To, Currency Conversion Type, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [wip_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=wip_transaction_accounts), [ppv_txns](https://www.enginatics.com/library/?pg=1&find=ppv_txns), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Purchase Price Variance 07-Jul-2022 173826.xlsx](https://www.enginatics.com/example/cac-purchase-price-variance/) |
| Blitz Report™ XML Import | [CAC_Purchase_Price_Variance.xml](https://www.enginatics.com/xml/cac-purchase-price-variance/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-purchase-price-variance/](https://www.enginatics.com/reports/cac-purchase-price-variance/) |


## Case Study & Technical Analysis: CAC Purchase Price Variance

### Executive Summary
The **CAC Purchase Price Variance** report is the definitive source for analyzing one of the most important metrics in a Standard Costing environment: Purchase Price Variance (PPV).
PPV represents the difference between the Standard Cost of an item and the actual price paid to the supplier. This report goes beyond simple GL balances by providing a detailed, transaction-level breakdown of *why* the variance occurred, distinguishing between price negotiation wins/losses and currency exchange rate fluctuations.

### Business Challenge
While the General Ledger shows the total PPV amount, it cannot explain the drivers.
*   **The "Black Box" of PPV:** A $100k unfavorable variance could be due to a supplier price hike, a rush order premium, or a sudden drop in the exchange rate.
*   **Internal vs. External:** PPV isn't just for external suppliers. Inter-company transfers between organizations with different standard costs also generate variance. Tracking this "Transfer PPV" is crucial for eliminating inter-company profit.
*   **Currency Confusion:** For multinational companies, a "price variance" might actually be a "currency variance." If the PO price in Euros didn't change, but the Euro/USD rate did, that's an FX issue, not a procurement performance issue.

### The Solution
This report provides a unified view of all PPV sources, enriched with analytical dimensions.
*   **Unified Architecture:** It combines data from:
    *   **Inventory:** External PO receipts and Internal Transfers (`MTL_TRANSACTION_ACCOUNTS`).
    *   **WIP:** Outside Processing (OSP) variances (`WIP_TRANSACTION_ACCOUNTS`).
*   **FX Separation:** It explicitly calculates two components of variance:
    *   **PPV Cost Amount:** The variance due to the difference in the base price (e.g., PO Price vs. Standard).
    *   **PPV FX Amount:** The variance due to the difference between the PO exchange rate and the daily rate at receipt.
*   **Transfer Logic:** It correctly handles the complex logic of Inter-Org transfers, using the FOB Point (Shipment vs. Receipt) to determine which organization—and which transaction—books the variance.

### Technical Architecture (High Level)
The query uses a Common Table Expression (CTE) approach to normalize data from disparate sources before aggregation.
*   **`mta_id` & `wta_id` CTEs:** These initial steps filter the massive transaction tables down to only those rows with `Accounting_Line_Type = 6` (Purchase Price Variance). This acts as a primary index filter for performance.
*   **`ppv_txns` CTE:** This is the core engine. It unions the Material and WIP transactions, normalizing columns like `Transaction_Id`, `Organization_Id`, and `Item_Id`.
*   **Complex Joins:** The main query joins this normalized transaction set to:
    *   `PO_HEADERS/LINES/DISTRIBUTIONS`: For supplier and price details.
    *   `RCV_TRANSACTIONS`: To link the accounting entry back to the physical receipt.
    *   `GL_DAILY_RATES`: To calculate the "True" daily rate vs. the "Frozen" PO rate for FX analysis.
*   **Logic for "Transfer to Regular":** Special logic handles Consignment inventory, where the PPV is recognized not at receipt, but when the ownership transfers (Consumption).

### Parameters & Filtering
*   **Transaction Date From/To:** The period for the analysis (usually matches the accounting period).
*   **Currency Conversion Type:** Used to calculate the "theoretical" FX impact.
*   **Category Sets:** Allows filtering by Product Line or Inventory Category.
*   **Organization/Operating Unit:** Standard security and filtering.

### Performance & Optimization
*   **Filtered CTEs:** By filtering `MTA` and `WTA` early (in the `WITH` clause) based on date and account type, the query avoids full table scans on these multi-million row tables.
*   **Single Pass:** The rewrite (Version 1.23) consolidated multiple `UNION ALL` blocks into a cleaner structure, reducing the number of times the heavy transaction tables are accessed.

### FAQ
**Q: Why do I see PPV on an Internal Transfer?**
A: If Org A ships to Org B, and Org A's standard cost is $10 but Org B's standard cost is $12, the $2 difference is recorded as variance. This report captures that to ensure the receiving org is valued at its own standard.

**Q: What is "PPV FX Amount"?**
A: This is the portion of the variance caused by exchange rate changes.
*   *Example:* PO Price = €100. Standard Cost = $110.
*   PO Rate ($1.10/€) -> PO Value = $110.
*   Receipt Rate ($1.20/€) -> Receipt Value = $120.
*   Total Variance = $10.
*   The report identifies this $10 as **FX Variance**, not Price Variance, because the €100 price didn't change.

**Q: Does this report match the GL?**
A: Yes, because it sources directly from `MTL_TRANSACTION_ACCOUNTS` and `WIP_TRANSACTION_ACCOUNTS` (or their SLA equivalents in newer versions), which are the source of truth for the GL journals.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
