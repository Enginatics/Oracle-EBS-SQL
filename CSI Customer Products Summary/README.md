---
layout: default
title: 'CSI Customer Products Summary | Oracle EBS SQL Report'
description: 'Imported Oracle standard Installed Base Customer Products Summary report Source: CSI: Customer Products Summary Report (XML) Short Name: CSICPREPXML DB…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, BI Publisher, Enginatics, CSI, Customer, Products, Summary, csi_item_instances, csi_instance_statuses, mtl_system_items_vl'
permalink: /CSI%20Customer%20Products%20Summary/
---

# CSI Customer Products Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/csi-customer-products-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard Installed Base Customer Products Summary report
Source: CSI: Customer Products Summary Report (XML)
Short Name: CSICPREP_XML
DB package: CSI_CSICPREP_XMLP_PKG

## Report Parameters
Account Number, Customer Name, Instance Number, Item, Status, City, Country, Creation Date From, Creation Date To

## Oracle EBS Tables Used
[csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances), [csi_instance_statuses](https://www.enginatics.com/library/?pg=1&find=csi_instance_statuses), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [csi_systems_v](https://www.enginatics.com/library/?pg=1&find=csi_systems_v), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all)

## Report Categories
[BI Publisher](https://www.enginatics.com/library/?pg=1&category[]=BI%20Publisher), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CSI Customer Products Summary 11-Jul-2021 195211.xlsx](https://www.enginatics.com/example/csi-customer-products-summary/) |
| Blitz Report™ XML Import | [CSI_Customer_Products_Summary.xml](https://www.enginatics.com/xml/csi-customer-products-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/csi-customer-products-summary/](https://www.enginatics.com/reports/csi-customer-products-summary/) |

## Executive Summary
The **CSI Customer Products Summary** report provides a high-level view of the "Installed Base"—the products that have been sold to and are currently owned by customers. This report is essential for Service and Support organizations to understand the fleet of products they are responsible for maintaining. It summarizes item instances by customer, location, and status, providing a snapshot of the active install base.

## Business Challenge
After a product is shipped, tracking its lifecycle is critical for revenue generation (service contracts) and customer satisfaction.
*   **Asset Visibility**: "What products does Customer X currently have?"
*   **Warranty Management**: Knowing when a product was installed is key to determining warranty eligibility.
*   **Recall/Upgrade Management**: Identifying all customers who own a specific version of a product.

## Solution
This report queries the Oracle Installed Base (CSI) tables to list customer products.

**Key Features:**
*   **Customer-Centric View**: Groups products by Customer Account and Location.
*   **Instance Details**: Shows the Instance Number (Serial Number), Item, and current Status (e.g., "Active", "Expired").
*   **Date Filtering**: Allows filtering by Creation Date to see new installations within a period.

## Architecture
The report is built on `CSI_ITEM_INSTANCES`, the core table of the Installed Base. It joins to `HZ_PARTIES` and `HZ_LOCATIONS` for customer details.

**Key Tables:**
*   `CSI_ITEM_INSTANCES`: The unique record of each specific product unit (instance).
*   `CSI_INSTANCE_STATUSES`: The current state of the instance.
*   `HZ_CUST_ACCOUNTS`: The customer who owns the product.
*   `MTL_SYSTEM_ITEMS`: Product description and details.

## Impact
*   **Revenue Opportunities**: Helps sales teams identify customers with aging products who might be ready for an upgrade.
*   **Service Efficiency**: Allows support agents to quickly verify what equipment a customer has before dispatching a technician.
*   **Data Accuracy**: Serves as a tool to audit the accuracy of the installed base records against shipping history.


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
