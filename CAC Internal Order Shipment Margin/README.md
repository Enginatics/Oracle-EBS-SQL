---
layout: default
title: 'CAC Internal Order Shipment Margin | Oracle EBS SQL Report'
description: 'Report to display the internal sales orders/requisition shipments with COGS, margin, inter-company profit and other useful information. This report…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Internal, Order, Shipment, ra_customer_trx_all, gl_daily_rates, gl_daily_conversion_types'
permalink: /CAC%20Internal%20Order%20Shipment%20Margin/
---

# CAC Internal Order Shipment Margin – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-internal-order-shipment-margin/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to display the internal sales orders/requisition shipments with COGS, margin, inter-company profit and other useful information.  This report separately gets the COGS and revenue entries for the entered date range. If the COGS information is not reported the sales order line was not shipped in the entered date range.  If the revenue nformation is not reported the sales order line was not billed in the entered date range.

/* +=============================================================================+
-- |  Copyright 2010 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Parameters:
-- |  p_from_org_ledger         -- general ledger you wish to report, for the From Organization, optional
-- |  p_to_org_ledger           -- general ledger you wish to report, for the To Organization, optional
-- |  p_from_org_code           -- the source or from inventory organization you wish to report, optional
-- |  p_trx_date_from           -- starting transaction date for internal shipment transactions, mandatory
-- |  p_trx_date_to             -- ending transaction date for internal shipment transactions, mandatory
-- |  p_pii_cost_type           -- the profit in inventory costs you wish to report
-- |  p_pii_resource_code       -- the sub-element or resource for profit in inventory,
-- |                               such as PII or ICP 
-- |  p_curr_conv_date          -- currency conversion date
-- |  p_std_cost_curr_conv_type -- currency conversion type used to set your standard costs and
-- |                               transfer prices
-- | 
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== =========================================
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     12 Nov 2009 Douglas Volz   Initial Coding based on XXX_IRO_COGS.sql
-- |  1.27     25 May 2020 Douglas Volz  Changed to multi-language views for organizations, operating units,
-- |                                     categories and units of measure.  Remove RA Batches code logic.
-- |                                     Remove sections for custom IR/ISO transactions.
-- +=============================================================================+*/
-- ======================================================== 
-- Program Outline
-- ======================================================== 
-- Section I:   Output the Report Columns for the Internal Shipment Entries
-- Section II:  Get the currency conversion rates, based on the currency conversion
--              type and currency conversion date parameters
-- Section III: Condense the 2 union all statements into one line
--              for each Transaction Id.  Also get the PII item costs.
-- Section IV:  Get the material, payables and revenue transactions
--              which represent the Internal Order activity.
--              Assume IR/ISO shipments may or may not use custom billing
--              Section IV has 2 union all reports as follows:
--	 Report 1:  Get IR/ISO COGS and Sales for Intransit Shipments
--	            where title passes upon shipment (FOB = 1, Shipment)
--	 Report 2:  Get IR/ISO COGS and Sales for IR/ISO Intransit Receipts
--	            where title passes upon receipt (FOB_Point = 2, Receipt)







## Report Parameters
Transaction Date From, Transaction Date To, Currency Conversion Date, Currency Conversion Type, Budget Currency Conversion Type, Category Set 1, Category Set 2, Category Set 3, PII Sub-Element, PII Cost Type, From Org Ledger, To Org Ledger

## Oracle EBS Tables Used
[ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_transaction_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_lot_numbers), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hz_cust_accounts_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts_all), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [mtl_intercompany_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_intercompany_parameters), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [qp_list_headers_tl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_tl), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Internal Order Shipment Margin 23-Jun-2022 160407.xlsx](https://www.enginatics.com/example/cac-internal-order-shipment-margin/) |
| Blitz Report™ XML Import | [CAC_Internal_Order_Shipment_Margin.xml](https://www.enginatics.com/xml/cac-internal-order-shipment-margin/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-internal-order-shipment-margin/](https://www.enginatics.com/reports/cac-internal-order-shipment-margin/) |

## Case Study & Technical Analysis: CAC Internal Order Shipment Margin

### Executive Summary
The **CAC Internal Order Shipment Margin** report is a high-value financial analysis tool designed to evaluate the profitability and cost implications of internal stock transfers. It provides a detailed view of Internal Sales Orders (ISO) and Requisition shipments, calculating Cost of Goods Sold (COGS), margin, and inter-company profit. This report is essential for Finance and Supply Chain leaders to monitor transfer pricing policies and ensure accurate financial reporting across entities.

### Business Challenge
Managing the financial impact of internal movements in a multi-org environment is complex. Companies often struggle with:
*   **Inter-Company Profit Tracking:** Difficulty in calculating and tracking profit in inventory (PII) for goods moving between legal entities.
*   **Margin Visibility:** Lack of clear visibility into the "margin" generated by internal transfers, which is crucial for transfer pricing compliance.
*   **COGS Reconciliation:** Challenges in reconciling the COGS entries generated by shipments with the revenue recognized.
*   **Data Fragmentation:** Critical financial data (COGS, Revenue, Shipments) is often scattered across different modules and tables.

### The Solution
The **CAC Internal Order Shipment Margin** report addresses these issues by consolidating shipment, cost, and revenue data.
*   **Operational View:** It links the shipment transaction with its associated financial impact, providing a line-by-line analysis of internal orders.
*   **Profit Analysis:** Calculates the margin and inter-company profit, helping to validate transfer pricing models.
*   **COGS & Revenue Matching:** Separately retrieves COGS and revenue entries for a given date range, highlighting discrepancies where goods are shipped but not billed, or billed but not shipped.
*   **Currency Conversion:** Supports currency conversion to a common reporting currency, enabling global consolidation and comparison.

### Technical Architecture (High Level)
The report utilizes a complex query structure to join shipping execution, order management, and cost management data.

**Primary Tables Involved:**
*   `OE_ORDER_LINES_ALL` / `OE_ORDER_HEADERS_ALL`: The driver for sales order shipment lines.
*   `MTL_MATERIAL_TRANSACTIONS`: Records the physical shipment and associated costs.
*   `RA_CUSTOMER_TRX_ALL`: Source of the inter-company invoicing and revenue data.
*   `CST_ITEM_COST_DETAILS` / `CST_COST_TYPES`: Used to retrieve detailed cost elements and profit in inventory.
*   `GL_DAILY_RATES`: Used for converting transaction amounts to the reporting currency.

**Logical Relationships:**
*   **Shipment to Invoice:** Links the physical shipment (Inventory) to the AR Invoice (Receivables) to match COGS with Revenue.
*   **Cost Breakdown:** Joins with Cost Details to separate standard costs from profit elements (PII).
*   **Union Logic:** The report typically employs a `UNION ALL` structure to handle different scenarios, such as Intransit Shipments (FOB Shipment) vs. Intransit Receipts (FOB Receipt), ensuring comprehensive coverage of ownership transfer points.

### Parameters & Filtering
The report provides extensive parameters for precise financial analysis:
*   **Transaction Date Range:** Defines the period for analyzing shipments and financial entries.
*   **Currency Conversion:** Parameters for `Date`, `Type`, and `Budget Type` allow for flexible financial reporting in a target currency.
*   **Category Sets:** Filters by item categories to analyze specific product lines.
*   **PII Settings:** `PII Sub-Element` and `PII Cost Type` allow users to specifically target and report on profit components within the cost structure.
*   **Org Ledgers:** Filters for From and To Organization Ledgers to isolate specific inter-company relationships.

### Performance & Optimization
*   **Optimized Aggregation:** The report logic is designed to condense multiple transaction lines (e.g., split lines) into a single meaningful record for analysis.
*   **Materialized View Usage:** Where applicable, it leverages standard Oracle views or efficient table joins to avoid costly runtime calculations of on-hand values.
*   **Indexed Date Filters:** Heavy reliance on indexed date columns (`TRX_DATE`) ensures that the query remains performant even when querying large historical datasets.

### FAQ
**Q: Why might a line show COGS but no Revenue?**
A: This typically happens if the shipment has occurred (triggering COGS) but the inter-company invoice has not yet been generated or imported into Receivables.

**Q: How is "Profit in Inventory" (PII) calculated?**
A: PII is derived from specific cost sub-elements defined in the system (passed as parameters) that represent the markup added during the transfer.

**Q: Does this report handle different currencies?**
A: Yes, it includes logic to convert transaction amounts to a specified currency using the daily rates defined in the General Ledger.


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
