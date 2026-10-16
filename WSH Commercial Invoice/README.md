---
layout: default
last_modified_at: 2026-10-16
title: 'WSH Commercial Invoice | Oracle EBS SQL Report'
description: 'Shipping commercial invoice report showing delivery details including shipped items, quantities, unit costs, extended costs, ship-from/ship-to addresses…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Shipping Execution, Enginatics, WSH, Commercial, Invoice, wsh_carrier_services, wsh_delivery_assignments_v, wsh_delivery_details'
permalink: /WSH%20Commercial%20Invoice/
report_name: 'WSH Commercial Invoice'
report_web_name: wsh-commercial-invoice
module: 'Shipping Execution'
module_url: /modules/shipping-execution/
---

# WSH Commercial Invoice – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wsh-commercial-invoice/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice).
**Oracle EBS module:** [Shipping Execution](/modules/shipping-execution/ "Oracle EBS Shipping Execution reports") · [all Shipping Execution reports](/modules/shipping-execution/)  

## Overview
Shipping commercial invoice report showing delivery details including shipped items, quantities, unit costs, extended costs, ship-from/ship-to addresses, freight information, and bill of lading details.
Blitz version of the Oracle standard Commercial Invoice (XML) concurrent program WSHRDINV_XML.
DB package: WSH_WSHRDINV_XMLP_PKG

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Trip Stop, Stop Planned Depart Date (Low), Stop Planned Depart Date (High), Freight Carrier, Warehouse, Delivery Name, Currency Code, Item Display, DFF Display, Print Customer Item

## Oracle EBS Tables Used
[wsh_carrier_services](https://www.enginatics.com/library/?pg=1&find=wsh_carrier_services&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [wsh_delivery_assignments_v](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_assignments_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [wsh_delivery_details](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [wsh_bols_rd_v](https://www.enginatics.com/library/?pg=1&find=wsh_bols_rd_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [hz_party_site_uses](https://www.enginatics.com/library/?pg=1&find=hz_party_site_uses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [hz_cust_account_roles](https://www.enginatics.com/library/?pg=1&find=hz_cust_account_roles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [hz_relationships](https://www.enginatics.com/library/?pg=1&find=hz_relationships&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [oke_k_deliverables_b](https://www.enginatics.com/library/?pg=1&find=oke_k_deliverables_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [wsh_freight_costs](https://www.enginatics.com/library/?pg=1&find=wsh_freight_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [wsh_freight_cost_types](https://www.enginatics.com/library/?pg=1&find=wsh_freight_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [wsh_new_deliveries](https://www.enginatics.com/library/?pg=1&find=wsh_new_deliveries&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [wsh_locations](https://www.enginatics.com/library/?pg=1&find=wsh_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [mtl_categories](https://www.enginatics.com/library/?pg=1&find=mtl_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [mtl_default_category_sets](https://www.enginatics.com/library/?pg=1&find=mtl_default_category_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [fnd_territories_tl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [bom_inventory_components](https://www.enginatics.com/library/?pg=1&find=bom_inventory_components&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice)

## Related Reports
[ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [WSH Shipping/Delivery Transactions](/WSH%20Shipping-Delivery%20Transactions/ "WSH Shipping/Delivery Transactions Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WSH%20Commercial%20Invoice/WSH%20Commercial%20Invoice.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [WSH Commercial Invoice 28-Mar-2026 011331.xlsx](https://www.enginatics.com/example/wsh-commercial-invoice/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice) |
| Blitz Report™ XML Import | [WSH_Commercial_Invoice.xml](https://www.enginatics.com/xml/wsh-commercial-invoice/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice) |
| SQL Source | [WSH Commercial Invoice.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WSH%20Commercial%20Invoice/WSH%20Commercial%20Invoice.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wsh-commercial-invoice/](https://www.enginatics.com/reports/wsh-commercial-invoice/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice) |

## Case Study & Technical Analysis: WSH Commercial Invoice

### Executive Summary
The WSH Commercial Invoice report is a shipping commercial invoice for Oracle Shipping Execution deliveries. It lists the delivery details of each delivery, with shipped items, quantities, unit costs, extended costs, ship-from and ship-to addresses, freight and bill of lading details. It is the Blitz version of the Oracle standard Commercial Invoice (XML) concurrent program WSHRDINVXML, and its database logic is held in the WSHWSHRDINVXMLPPKG package. Export and logistics teams use it to prepare the commercial invoice that accompanies an international shipment, with the commodity classes that customs requires. It runs in Excel through Blitz Report.

### Business Challenge
*   **International shipping documents:** A cross-border shipment needs a commercial invoice that shows the goods, their values and their origin for customs clearance.
*   **Value per item:** The unit and extended cost of each shipped item must be shown in the invoice currency and in the unit of measure of the shipment.
*   **Commodity codes:** Customs classification depends on the commodity class of each item, which must appear on the invoice.
*   **Consignee and carrier details:** The invoice carries the ship-from and ship-to addresses, the contact, the carrier, the bill of lading and the freight cost of the delivery.

### The Solution
*   Lists each delivery with its ship date, currency, shipping method, gross weight, number of boxes, ports of loading and discharge, waybill and bill of lading numbers.
*   Shows the ship-from and ship-to addresses with their countries, the ship-to customer or consignee and the ship-to contact.
*   Shows, for each item, its description, commodity class, shipped quantity, unit of measure, secondary quantity, unit cost and extended cost.
*   Shows the total freight cost of the delivery and the warehouse from the organization definition of the delivery line.

### Technical Architecture (High Level)
#### Primary Tables
*   `WSH_NEW_DELIVERIES`: the delivery header, with ship method, weights, ports, waybill and currency.
*   `WSH_DELIVERY_DETAILS`: the delivery lines, with items, quantities, source codes, locations and unit prices.
*   `WSH_DELIVERY_ASSIGNMENTS_V`: the assignment of each detail to its delivery.
*   `WSH_LOCATIONS`: the ship-from and ship-to locations, with their addresses and countries.
*   `WSH_CARRIER_SERVICES`, `WSH_BOLS_RD_V` and `WSH_FREIGHT_COSTS`: the ship method, bill of lading and freight costs.
*   `OE_ORDER_LINES_ALL`: the order line that is the source of a delivery line, with its selling price and component sequence.
*   `HZ_CUST_SITE_USES_ALL`, `HZ_CUST_ACCT_SITES_ALL`, `HZ_PARTY_SITES`, `HZ_PARTIES` and `HZ_CUST_ACCOUNT_ROLES`: the ship-to customer and contact.
*   `MTL_SYSTEM_ITEMS_VL`, `MTL_ITEM_CATEGORIES`, `MTL_CATEGORIES_KFV`, `MTL_CATEGORY_SETS_VL` and `MTL_DEFAULT_CATEGORY_SETS`: the item description and commodity class category.
*   `FND_TERRITORIES_TL`, `ORG_ORGANIZATION_DEFINITIONS` and `BOM_INVENTORY_COMPONENTS`: country names, the warehouse and the components flagged for shipping documents.

#### Logical Relationships
1.  `WSH_NEW_DELIVERIES` is joined to `WSH_DELIVERY_ASSIGNMENTS_V` and then to `WSH_DELIVERY_DETAILS` on the delivery detail id.
2.  Ship-from and ship-to locations are joined to `WSH_LOCATIONS`, and their countries to `FND_TERRITORIES_TL` in the user's language.
3.  The commodity class lists the categories of the item in the WSH_COMMODITY_CODE category set, from `MTL_ITEM_CATEGORIES` and `MTL_CATEGORIES_KFV`.
4.  The unit cost comes from the order line selling price for OE lines, the agreement deliverable price for OKE lines, or another delivery line of the same source for other sources.
5.  A component is included when it is flagged for shipping documents on the bill of material.

### Parameters & Filtering
*   **Trip Stop**, **Stop Planned Depart Date (Low)** and **(High):** select deliveries by trip stop and planned departure date.
*   **Freight Carrier** and **Warehouse:** select deliveries by carrier and shipping organization.
*   **Delivery Name** and **Currency Code:** select one delivery, or the deliveries in one currency.
*   **Item Display** and **Print Customer Item:** control how the item and the customer's item number are shown.

### Performance & Optimization
*   The delivery is the driving table, so the trip stop, carrier and warehouse parameters narrow the population before the item and address lookups run.
*   Unit cost and extended cost use scalar lookups on the order line and the agreement deliverable, evaluated per detail line rather than per delivery.
*   The total freight cost is a correlated subquery on the freight cost table for each delivery, which excludes detail-level costs.
*   Filtering by Delivery Name or Trip Stop keeps the grouped output small, since the report groups every item line by delivery and category.

### FAQ
**Q: Which costs appear on the commercial invoice?**
A: Each item shows its unit cost and extended cost, derived from the order line selling price or the agreement price. The total freight cost is shown for the delivery.

**Q: How are commodity classes determined?**
A: They are the categories assigned to the item in the WSH_COMMODITY_CODE category set. Items without one show a blank commodity class.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-commercial-invoice)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
