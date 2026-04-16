---
layout: default
title: 'WSH Commercial Invoice | Oracle EBS SQL Report'
description: 'Shipping commercial invoice report showing delivery details including shipped items, quantities, unit costs, extended costs, ship-from/ship-to addresses…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, WSH, Commercial, Invoice, wsh_carrier_services, wsh_delivery_assignments_v, wsh_delivery_details'
permalink: /WSH%20Commercial%20Invoice/
---

# WSH Commercial Invoice – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wsh-commercial-invoice/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Shipping commercial invoice report showing delivery details including shipped items, quantities, unit costs, extended costs, ship-from/ship-to addresses, freight information, and bill of lading details.
Blitz version of the Oracle standard Commercial Invoice (XML) concurrent program WSHRDINV_XML.
DB package: WSH_WSHRDINV_XMLP_PKG

## Report Parameters
Trip Stop, Stop Planned Depart Date (Low), Stop Planned Depart Date (High), Freight Carrier, Warehouse, Delivery Name, Currency Code, Item Display, Show DFF Attributes, Print Customer Item

## Oracle EBS Tables Used
[wsh_carrier_services](https://www.enginatics.com/library/?pg=1&find=wsh_carrier_services), [wsh_delivery_assignments_v](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_assignments_v), [wsh_delivery_details](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_details), [wsh_bols_rd_v](https://www.enginatics.com/library/?pg=1&find=wsh_bols_rd_v), [hz_party_site_uses](https://www.enginatics.com/library/?pg=1&find=hz_party_site_uses), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_cust_account_roles](https://www.enginatics.com/library/?pg=1&find=hz_cust_account_roles), [hz_relationships](https://www.enginatics.com/library/?pg=1&find=hz_relationships), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [oke_k_deliverables_b](https://www.enginatics.com/library/?pg=1&find=oke_k_deliverables_b), [wsh_freight_costs](https://www.enginatics.com/library/?pg=1&find=wsh_freight_costs), [wsh_freight_cost_types](https://www.enginatics.com/library/?pg=1&find=wsh_freight_cost_types), [wsh_new_deliveries](https://www.enginatics.com/library/?pg=1&find=wsh_new_deliveries), [wsh_locations](https://www.enginatics.com/library/?pg=1&find=wsh_locations), [mtl_categories](https://www.enginatics.com/library/?pg=1&find=mtl_categories), [mtl_default_category_sets](https://www.enginatics.com/library/?pg=1&find=mtl_default_category_sets), [fnd_territories_tl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_tl), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [bom_inventory_components](https://www.enginatics.com/library/?pg=1&find=bom_inventory_components), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[WSH Shipping/Delivery Transactions](/WSH%20Shipping-Delivery%20Transactions/ "WSH Shipping/Delivery Transactions Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [WSH Commercial Invoice 28-Mar-2026 011331.xlsx](https://www.enginatics.com/example/wsh-commercial-invoice/) |
| Blitz Report™ XML Import | [WSH_Commercial_Invoice.xml](https://www.enginatics.com/xml/wsh-commercial-invoice/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/wsh-commercial-invoice/](https://www.enginatics.com/reports/wsh-commercial-invoice/) |



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
