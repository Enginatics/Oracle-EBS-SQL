---
layout: default
last_modified_at: 2026-10-26
title: 'ONT Audit History | Oracle EBS SQL Report'
description: 'Order Management audit history report showing changes to order headers, lines, sales credits, and price adjustments with old/new values, change reasons…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Order Management, Enginatics, ONT, Audit, History, oe_order_lines_all, oe_sales_credits, oe_price_adjustments'
permalink: /ONT%20Audit%20History/
report_name: 'ONT Audit History'
report_web_name: ont-audit-history
module: 'Order Management'
module_url: /modules/order-management/
---

# ONT Audit History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-audit-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history).
**Oracle EBS module:** [Order Management](/modules/order-management/ "Oracle EBS Order Management reports") · [all Order Management reports](/modules/order-management/)  

## Overview
Order Management audit history report showing changes to order headers, lines, sales credits, and price adjustments with old/new values, change reasons, and the user who made the change.
Based on Oracle standard report OEXAUDHR_XML (Audit History Report).

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, History Date From, History Date To, Entity, Attribute, Order Number From, Order Number To, User Name, Responsibility

## Oracle EBS Tables Used
[oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history), [oe_sales_credits](https://www.enginatics.com/library/?pg=1&find=oe_sales_credits&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history), [oe_price_adjustments](https://www.enginatics.com/library/?pg=1&find=oe_price_adjustments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history), [oe_audit_attr_desc_v](https://www.enginatics.com/library/?pg=1&find=oe_audit_attr_desc_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history)

## Related Reports
[QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [ONT Price Adjustments and Charges](/ONT%20Price%20Adjustments%20and%20Charges/ "ONT Price Adjustments and Charges Oracle EBS SQL Report"), [ONT Blanket Sales Agreements](/ONT%20Blanket%20Sales%20Agreements/ "ONT Blanket Sales Agreements Oracle EBS SQL Report"), [AR Autoinvoice Interface](/AR%20Autoinvoice%20Interface/ "AR Autoinvoice Interface Oracle EBS SQL Report"), [AR Customer Credit Limits](/AR%20Customer%20Credit%20Limits/ "AR Customer Credit Limits Oracle EBS SQL Report"), [INV Intercompany Invoice Reconciliation](/INV%20Intercompany%20Invoice%20Reconciliation/ "INV Intercompany Invoice Reconciliation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Audit%20History/ONT%20Audit%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ont-audit-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history) |
| Blitz Report™ XML Import | [ONT_Audit_History.xml](https://www.enginatics.com/xml/ont-audit-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history) |
| SQL Source | [ONT Audit History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Audit%20History/ONT%20Audit%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ont-audit-history/](https://www.enginatics.com/reports/ont-audit-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history) |

## Case Study & Technical Analysis: ONT Audit History

### Executive Summary
This report is the Order Management audit history. It lists every recorded change to order lines, sales credits and price adjustments, with the entity and attribute that changed, the old and new values, the change reason and comments, and the user and responsibility that made the change. It is based on Oracle's standard Audit History Report (OEXAUDHRXML). Order management supervisors, revenue assurance teams and auditors use it to answer questions such as who changed a price, when a requested date was moved, or why a line was cancelled. It can be run for an operating unit and a date range, or narrowed to a range of order numbers.

### Business Challenge
*   **Explaining order changes:** Customers and internal teams ask why an order changed after it was booked, and the answer must come from a record of the change.
*   **Pricing control:** Manual price adjustments and changes to the price of a line must be visible to the people who review discounts.
*   **Accountability:** The user and responsibility behind each change must be recorded, so that sensitive changes can be traced.
*   **Audit evidence:** Internal and external auditors need a complete history of changes for a period, grouped by operating unit.

### The Solution
*   Reads the audit history view for the operating units the user can access, and shows the operating unit and order number of each change.
*   Identifies the order line for each change, including its line, shipment, option, component and service numbers, even when the change was made to a sales credit or a price adjustment.
*   Shows the entity and attribute display names, the old and new display values, the reason, the comments and the history date.
*   Shows the user name and responsibility that made each change, so changes can be attributed.
*   Orders the output by history date, newest first, and then by entity.

### Technical Architecture (High Level)
#### Primary Tables
*   `OE_AUDIT_ATTR_DESC_V`: the Order Management audit history, with the entity, attribute, old and new display values, reason, user, responsibility and history date.
*   `OE_ORDER_LINES_ALL`: the order line, with its line, shipment, option, component and service numbers.
*   `OE_SALES_CREDITS`: the sales credit records, which link to the order line.
*   `OE_PRICE_ADJUSTMENTS`: the price adjustments, which link to the order line.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the operating unit access list, extended with the current org for release 11.

#### Logical Relationships
1. `OE_AUDIT_ATTR_DESC_V` is joined to the operating unit on the organization identifier.
2. The operating unit is restricted to those the user can access through `MO_GLOB_ORG_ACCESS_TMP`.
3. For an audit row whose entity is an order line, the line is the entity number itself.
4. For a sales credit, the order line is found from the sales credit record, and for a price adjustment from the price adjustment record.
5. The order line's line, shipment, option, component and service numbers are combined into one dotted line number.

### Parameters & Filtering
*   **Operating Unit:** limits the history to one operating unit.
*   **History Date From** and **History Date To:** bound the date of the change.
*   **Entity** and **Attribute:** select the kind of record and the field that changed.
*   **Order Number From** and **Order Number To:** limit the history to a range of orders.
*   **User Name** and **Responsibility:** show the changes made by one user or through one responsibility.

### Performance & Optimization
*   The history is restricted to the operating units the user can access before the audit rows are read.
*   The line number lookup is a correlated subquery that runs only for the entities that refer to order lines, and it is limited to one row.
*   The order by history date, newest first, is applied after the filters, so the most recent changes appear first.
*   The date and entity parameters should be set for large histories, since the audit table grows with every change.

### FAQ
**Q: How do I see who changed the price of an order line?**
A: Run the report with the Entity set to the order line or price adjustment and the Attribute set to the price field, for the order number and date range in question. The User Name and Responsibility columns show who made the change.

**Q: What does a dotted line number such as 1.1.2 mean?**
A: It is the line number, followed by the shipment, option and component or service numbers of the order line. Each part is shown only when it is present on the line.

**Q: Can I see the reason for a change?**
A: Yes. The Reason and Comments columns show the reason and comments that were recorded with the change.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-audit-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
