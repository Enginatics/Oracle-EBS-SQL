---
layout: default
last_modified_at: 2026-10-19
title: 'ONT Blanket Sales Agreements | Oracle EBS SQL Report'
description: 'Blanket sales agreements, one row per agreement line, with the minimum and maximum quantity and amount, and the quantity and amount released, fulfilled…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Order Management, Enginatics, ONT, Blanket, Sales, Agreements, qp_list_headers_vl, oe_order_lines_all, hr_all_organization_units_vl'
permalink: /ONT%20Blanket%20Sales%20Agreements/
report_name: 'ONT Blanket Sales Agreements'
report_web_name: ont-blanket-sales-agreements
module: 'Order Management'
module_url: /modules/order-management/
---

# ONT Blanket Sales Agreements – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-blanket-sales-agreements/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements).
**Oracle EBS module:** [Order Management](/modules/order-management/ "Oracle EBS Order Management reports") · [all Order Management reports](/modules/order-management/)  

## Overview
Blanket sales agreements, one row per agreement line, with the minimum and maximum quantity and amount, and the quantity and amount released, fulfilled and returned by the sales order lines that reference the agreement.

Remaining is the maximum plus the returned less the released quantity or amount, the limit that Order Management validates new releases against. Agreement level amounts are shown on the first line of each agreement only, so that they can be summed. Releases counts the sales orders with a not cancelled line released against the agreement line.

Use ONT Orders and Lines with the Sales Agreement Number parameter for the release order lines.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Agreement Number, Agreement Type, Status, Customer Name, Account Number, Salesperson, Item, End Date From, End Date To, Expiring Within Days, Open Only, DFF Display

## Oracle EBS Tables Used
[qp_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [oe_blanket_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_blanket_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [oe_blanket_headers_ext](https://www.enginatics.com/library/?pg=1&find=oe_blanket_headers_ext&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [oe_blanket_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_blanket_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [oe_blanket_lines_ext](https://www.enginatics.com/library/?pg=1&find=oe_blanket_lines_ext&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements)

## Related Reports
[ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [ONT Orders](/ONT%20Orders/ "ONT Orders Oracle EBS SQL Report"), [QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report"), [ONT Price Adjustments and Charges](/ONT%20Price%20Adjustments%20and%20Charges/ "ONT Price Adjustments and Charges Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Blanket%20Sales%20Agreements/ONT%20Blanket%20Sales%20Agreements.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ONT Blanket Sales Agreements 15-Oct-2026 022641.xlsx](https://www.enginatics.com/example/ont-blanket-sales-agreements/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements) |
| Blitz Report™ XML Import | [ONT_Blanket_Sales_Agreements.xml](https://www.enginatics.com/xml/ont-blanket-sales-agreements/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements) |
| SQL Source | [ONT Blanket Sales Agreements.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Blanket%20Sales%20Agreements/ONT%20Blanket%20Sales%20Agreements.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ont-blanket-sales-agreements/](https://www.enginatics.com/reports/ont-blanket-sales-agreements/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements) |

## Case Study & Technical Analysis: ONT Blanket Sales Agreements

### Executive Summary
The ONT Blanket Sales Agreements report lists the blanket sales agreements in Oracle Order Management, one row per agreement line. For each agreement it shows the minimum and maximum quantities and amounts, the amounts released, fulfilled and returned, and the remaining balance that Order Management checks new releases against. Sales administrators and customer account teams use it to see how much of each commitment has been drawn down and which agreements are close to their limit or end date. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Commitment tracking:** Customers buy against a negotiated blanket commitment, and the team must know what remains before new releases are entered.
*   **Limit breaches:** A release that exceeds the blanket limit is rejected, so the remaining balance must be visible before the order is taken.
*   **Expiry management:** Agreements near their end date, or on hold, need renewal or release before the commitment lapses.
*   **Commercial terms:** Price list, modifier list and salesperson of each agreement must be checked against the agreed terms.

### The Solution
*   **Agreement and line structure:** The blanket header joins to its lines and to the extension records holding the minimum, maximum, released, fulfilled and returned values.
*   **Remaining balance:** Remaining is the maximum plus the returned, less the released value, the same limit Order Management validates against.
*   **Release counting:** The number of sales orders with a non-cancelled line released against the agreement line is shown as Releases.
*   **Header amounts once:** Agreement level amounts appear only on the first line of each agreement, so they can be summed without double counting.

### Technical Architecture (High Level)
#### Primary Tables
*   `OE_BLANKET_HEADERS_ALL` and `OE_BLANKET_HEADERS_EXT`: the agreement header and its amount and status extension.
*   `OE_BLANKET_LINES_ALL` and `OE_BLANKET_LINES_EXT`: the agreement lines and their quantity and amount extension.
*   `OE_ORDER_LINES_ALL`: the sales order lines that reference an agreement line, used for the release count.
*   `OE_TRANSACTION_TYPES_TL`: the agreement type name.
*   `QP_LIST_HEADERS_VL`: the price list and modifier list names.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the customer account number and name.
*   `JTF_RS_SALESREPS` and `JTF_RS_RESOURCE_EXTNS_VL`: the salesperson name.
*   `MTL_SYSTEM_ITEMS_VL`: the item number and description.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the current user.

#### Logical Relationships
1.  `OE_BLANKET_HEADERS_ALL` joins to `OE_BLANKET_HEADERS_EXT` on the order number, and to `OE_BLANKET_LINES_ALL` on the header ID.
2.  Each agreement line joins to `OE_BLANKET_LINES_EXT` on the line ID, which supplies the quantity and amount balances.
3.  The header joins to the customer account and party, the salesperson resource and the agreement type name.
4.  The line joins to `MTL_SYSTEM_ITEMS_VL` on the inventory item, or on the item identifier for non-item lines.
5.  The release count is a correlated subquery on `OE_ORDER_LINES_ALL` matching the blanket number and line number, excluding cancelled lines.

### Parameters & Filtering
*   **Operating Unit:** limits the agreements to one organization within the accessible set.
*   **Agreement Number** and **Agreement Type:** select one agreement or one agreement type.
*   **Status:** filters on the flow status of the agreement.
*   **Customer Name** and **Account Number:** identify the customer.
*   **End Date From** and **End Date To:** bound the agreement end date.
*   **Expiring Within Days:** shows agreements whose end date falls within the given number of days.
*   **Open Only:** restricts the output to open agreements.

### Performance & Optimization
*   The operating unit restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, so agreement tables are read only for accessible organizations.
*   The release count is a scalar subquery keyed on the blanket number and line number, so order lines are not joined into the main row set.
*   Agreement-level amounts are computed with a `ROW_NUMBER` over the header, so each agreement contributes its totals once.
*   Item and customer joins are outer joins on primary identifiers, so agreements without an item or account are still returned.

### FAQ
**Q: How much of a blanket agreement is still available for release?**
A: The Remaining column for a line is the maximum quantity plus the returned quantity less the released quantity, and the amount equivalent is shown for the agreement.

**Q: Why are agreement amounts blank on some lines?**
A: Agreement level amounts are shown on the first line of each agreement only, so they are not counted more than once when summed.

**Q: How do I see the orders released against an agreement?**
A: Use ONT Orders and Lines with the Sales Agreement Number parameter, which lists the release order lines.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-blanket-sales-agreements)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
