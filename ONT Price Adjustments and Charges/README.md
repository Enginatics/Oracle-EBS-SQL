---
layout: default
last_modified_at: 2026-10-19
title: 'ONT Price Adjustments and Charges | Oracle EBS SQL Report'
description: 'Price adjustments applied to sales orders: discounts, surcharges, price breaks, promotional goods and freight and special charges, one row per adjustment…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Order Management, Enginatics, ONT, Price, Adjustments, Charges, qp_pricing_phases, hr_all_organization_units_vl, oe_order_headers_all'
permalink: /ONT%20Price%20Adjustments%20and%20Charges/
report_name: 'ONT Price Adjustments and Charges'
report_web_name: ont-price-adjustments-and-charges
module: 'Order Management'
module_url: /modules/order-management/
---

# ONT Price Adjustments and Charges – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-price-adjustments-and-charges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges).
**Oracle EBS module:** [Order Management](/modules/order-management/ "Oracle EBS Order Management reports") · [all Order Management reports](/modules/order-management/)  

## Overview
Price adjustments applied to sales orders: discounts, surcharges, price breaks, promotional goods and freight and special charges, one row per adjustment of an order header or line.

Extended Amount is the unit adjustment times the ordered quantity, a lumpsum charge once per line. Discounts and credits are negative, and line amounts of return lines carry the reverse sign, as in ONT Orders and Lines.

Order level modifiers are stored once per order without a line. The line selling prices include their effect, but Oracle stores no amount for it, so Unit Adjustment and Extended Amount are blank on these rows, except for a lumpsum order level charge.

Tax records and shipping cost records are not listed.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Ordered Date From, Ordered Date To, Order Number, Customer Name, Account Number, Order Type, Item, Adjustment Type, Modifier, Charge Type, Change Reason, Manual or Overridden Only, Applied, DFF Display

## Oracle EBS Tables Used
[qp_pricing_phases](https://www.enginatics.com/library/?pg=1&find=qp_pricing_phases&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges), [oe_price_adjustments](https://www.enginatics.com/library/?pg=1&find=oe_price_adjustments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges), [qp_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges)

## Related Reports
[ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report"), [QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [ONT Blanket Sales Agreements](/ONT%20Blanket%20Sales%20Agreements/ "ONT Blanket Sales Agreements Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [ONT Orders](/ONT%20Orders/ "ONT Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Price%20Adjustments%20and%20Charges/ONT%20Price%20Adjustments%20and%20Charges.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ONT Price Adjustments and Charges 15-Oct-2026 022638.xlsx](https://www.enginatics.com/example/ont-price-adjustments-and-charges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges) |
| Blitz Report™ XML Import | [ONT_Price_Adjustments_and_Charges.xml](https://www.enginatics.com/xml/ont-price-adjustments-and-charges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges) |
| SQL Source | [ONT Price Adjustments and Charges.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Price%20Adjustments%20and%20Charges/ONT%20Price%20Adjustments%20and%20Charges.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ont-price-adjustments-and-charges/](https://www.enginatics.com/reports/ont-price-adjustments-and-charges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges) |

## Case Study & Technical Analysis: ONT Price Adjustments and Charges

### Executive Summary
ONT Price Adjustments and Charges lists the price adjustments applied to sales orders in Oracle Order Management: discounts, surcharges, price breaks, promotional goods, and freight and special charges. It returns one row for each adjustment on an order header or order line, with the modifier that created it, the adjustment amount and the extended value. Pricing analysts, order management supervisors and revenue controllers use it to review discount levels by customer or item, audit manual overrides, and reconcile charges that were billed against those that were approved.

### Business Challenge
*   **Discount Governance:** Sales management must see how much discount each order received, and from which modifier, to enforce pricing policy.
*   **Manual Overrides:** Adjustments changed by users rather than applied automatically carry a higher risk, and they must be identifiable.
*   **Charge Reconciliation:** Freight and special charges need to be checked against the order lines they belong to.
*   **Modifier Analysis:** Pricing teams need to see which price list modifiers generate the most adjustment value.

### The Solution
*   **Adjustment Level Detail:** Each adjustment is one row, with its level, type, modifier, line and operator, so the source of the price is clear.
*   **Extended Values:** The unit adjustment is multiplied by the ordered quantity to give an extended amount, and lumpsum charges are reported once per line.
*   **Sign Convention:** Discounts and credits are negative, and return lines carry the reverse sign, consistent with the Orders and Lines report.
*   **Override and Application Flags:** Automatic, overridden, applied, accrued and invoiced status are each returned as yes or no.

### Technical Architecture (High Level)
#### Primary Tables
*   `OE_PRICE_ADJUSTMENTS`: the price adjustment rows on orders, with the list line type, operand, adjusted amount and status flags.
*   `OE_ORDER_HEADERS_ALL`: the order headers, with order number, ordered date, currency and sold-to customer.
*   `OE_ORDER_LINES_ALL`: the order lines, with item, quantity, unit prices and the line category.
*   `OE_TRANSACTION_TYPES_TL`: the order type names.
*   `QP_LIST_HEADERS_VL`: the modifier list names and types.
*   `QP_PRICING_PHASES`: the pricing phase names.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit names.
*   `HZ_CUST_ACCOUNTS`: the customer accounts, with the account number.
*   `HZ_PARTIES`: the customer party names.
*   `MTL_SYSTEM_ITEMS_VL`: the items.
*   `FND_LOOKUP_VALUES_VL`: the lookup meanings of the list line types.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units the user can access.
*   `DUAL`: used to add the release check to the operating unit list.

#### Logical Relationships
1.  Each adjustment in `OE_PRICE_ADJUSTMENTS` is joined to its order header in `OE_ORDER_HEADERS_ALL` on the header identifier.
2.  Adjustments with a line identifier are outer joined to `OE_ORDER_LINES_ALL` on the line identifier.
3.  The header is joined to its operating unit, its order type and its customer account, and the account to its party.
4.  The line is joined to `MTL_SYSTEM_ITEMS_VL` on the inventory item and ship-from organization.
5.  The adjustment's modifier is outer joined to `QP_LIST_HEADERS_VL` on the list header identifier.
6.  Adjustment types are restricted to the list line type lookup values in `FND_LOOKUP_VALUES_VL`.

### Parameters & Filtering
*   **Operating Unit:** Restricts the output to one operating unit.
*   **Ordered Date From and Ordered Date To:** Limit the orders to an ordered date window.
*   **Order Number, Customer Name, Account Number, Order Type and Item:** Select orders by identifier, customer, type or product.
*   **Adjustment Type and Modifier:** Restrict the output to one list line type or one modifier.
*   **Charge Type and Change Reason:** Restrict the freight and special charges or the change reason codes.
*   **Manual or Overridden Only:** Limits the output to adjustments that were changed by a user.
*   **Applied:** Filters on whether the adjustment was applied.
*   **DFF Display:** Controls whether descriptive flexfield columns are shown.

### Performance & Optimization
*   **Operating Unit Security:** The order header is restricted through the multi-org access table, so the scan is limited to permitted operating units.
*   **Lookup Driven Adjustment Types:** The list line types come from a lookup subquery, which keeps only the adjustment types defined for the pricing setup.
*   **Outer Join to Lines:** Header-level adjustments have no line, so the line join is an outer join.
*   **Lumpsum Branch:** The extended amount expression evaluates a separate branch for lumpsum freight and header adjustments, so the calculation is decided per row.

### FAQ
**Q: Why are the Unit Adjustment and Extended Amount blank on some rows?**
A: Oracle does not store an amount for line price effects that are included in the selling price, so these fields are blank. The exception is a lumpsum order level charge, which carries an extended amount.

**Q: How do I find the manually changed discounts for one customer?**
A: Enter the customer name in the Customer Name parameter, and set Manual or Overridden Only to Yes.

**Q: Are tax lines included in this report?**
A: No. Tax records and shipping cost records are not listed.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-price-adjustments-and-charges)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
