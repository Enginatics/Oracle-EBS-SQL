---
layout: default
title: 'ONT Recurring Billing Plan | Oracle EBS SQL Report'
description: 'Profile report showing the Sales order recurring billing plan for header and line details including status, frequency, billing period, billing amounts and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, ONT, Recurring, Billing, Plan, hr_operating_units, gl_ledgers, oe_order_headers_all'
permalink: /ONT%20Recurring%20Billing%20Plan/
---

# ONT Recurring Billing Plan – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-recurring-billing-plan/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Profile report showing the Sales order recurring billing plan for header and line details including status, frequency, billing period, billing amounts and dates.

## Report Parameters
Ledger, Operating Unit, Order Number

## Oracle EBS Tables Used
[hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [oe_billing_plan_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_billing_plan_headers_all), [oe_billing_plan_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_billing_plan_lines_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Transactions and Lines](/AR%20Transactions%20and%20Lines/ "AR Transactions and Lines Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ONT Recurring Billing Plan 28-Jul-2020 181125.xlsx](https://www.enginatics.com/example/ont-recurring-billing-plan/) |
| Blitz Report™ XML Import | [ONT_Recurring_Billing_Plan.xml](https://www.enginatics.com/xml/ont-recurring-billing-plan/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ont-recurring-billing-plan/](https://www.enginatics.com/reports/ont-recurring-billing-plan/) |

## Case Study & Technical Analysis: ONT Recurring Billing Plan Report

### Executive Summary

The ONT Recurring Billing Plan report provides a detailed profile of recurring billing schedules associated with sales orders in Oracle Order Management. This report is essential for businesses with subscription, service, or other recurring revenue models. It offers a clear and concise view of billing frequencies, periods, amounts, and dates for specific orders, enabling finance and order administration teams to accurately manage and forecast this critical revenue stream.

### Business Challenge

Managing recurring billing manually or with inadequate tools is fraught with risk and inefficiency. As businesses increasingly adopt subscription-based models, they face significant challenges in tracking and managing these complex billing arrangements within Oracle EBS. Key pain points include:

-   **Revenue Leakage:** Without a clear way to audit billing plan setups, incorrect configurations can lead to under-billing customers, causing significant revenue leakage over the life of a contract.
-   **Poor Forecasting Capability:** Accurately forecasting future revenue from recurring streams is impossible without a consolidated report that details all active billing plans and their schedules.
-   **Customer Disputes:** Ambiguity or errors in billing schedules can lead to customer confusion and invoice disputes, which negatively impact customer satisfaction and increase administrative overhead.
-   **Lack of Visibility:** The standard Oracle forms are not designed for easily viewing a holistic billing schedule for an entire order, making it difficult to perform quick reviews or answer customer inquiries.

### The Solution

This report provides a clear, detailed, and easily accessible view of an order's entire recurring billing plan, directly addressing the challenges of managing recurring revenue.

-   **Accurate Billing Verification:** It allows administrators to review and verify the complete billing plan—including frequency, billing period, and amounts—before an order is finalized, ensuring it perfectly matches the customer's contract.
-   **Improved Financial Forecasting:** By providing a detailed schedule of future billing events for any given order, the report serves as a key input for creating more accurate and reliable revenue forecasts.
-   **Enhanced Customer Service:** When customers have questions about their billing, service agents can use this report to quickly pull up the exact schedule and provide clear, confident answers, improving the customer experience.
-   **Streamlined Auditing:** The report simplifies the process of auditing recurring revenue streams, allowing finance teams to easily confirm that all active contracts are set up to be billed correctly.

### Technical Architecture (High Level)

The report is built upon a direct join between the sales order and the dedicated billing plan tables in Oracle Order Management.

-   **Primary Tables Involved:**
    -   `oe_order_headers_all` (to identify the sales order)
    -   `oe_order_lines_all` (to link the billing plan to a specific order line)
    -   `oe_billing_plan_headers_all` (contains the header-level details of the billing plan)
    -   `oe_billing_plan_lines_all` (contains the detailed schedule of billing events, including dates and amounts)
-   **Logical Relationships:** The report works by taking a given sales order number and joining from the order header or lines to the `oe_billing_plan_headers_all` table. It then retrieves and displays all the detailed schedule lines from the `oe_billing_plan_lines_all` table associated with that plan.

### Parameters & Filtering

The report is designed as a detailed drill-down tool with focused parameters:

-   **Ledger / Operating Unit:** Standard parameters to provide the correct organizational context.
-   **Order Number:** The primary parameter used to select the specific sales order for which you want to view the recurring billing plan.

### Performance & Optimization

As a targeted lookup report, it is highly performant.

-   **Indexed Lookups:** The query is driven by the `Order Number`, which is a primary key. This ensures that the data retrieval from all related tables is extremely fast and efficient, using the standard indexes provided by Oracle.
-   **Focused Data Set:** By design, the report retrieves data for a single order at a time, ensuring the volume of data processed is small and the report runs almost instantaneously.

### FAQ

**1. Does this report show which billing installments have already been invoiced?**
   This report primarily focuses on displaying the configured billing *plan*. While it may have status indicators, a separate Accounts Receivable report would typically be used to confirm which specific installments have been successfully invoiced and collected.

**2. What is the difference between a header-level and a line-level billing plan?**
   A header-level billing plan applies a single billing schedule to the entire sales order. A line-level plan, which is more common, applies a billing schedule to a specific order line. This allows a single order to have multiple items with different recurring billing schedules (e.g., one subscription billed monthly, another billed quarterly).

**3. Can this report be used for non-recurring billing plans, such as milestone-based billing?**
   Yes, the underlying `oe_billing_plan` tables can store various types of billing plans, including milestone-based plans where billing events are tied to project milestones rather than a recurring date. This report would display the configured milestones and their corresponding billing amounts.


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
