# Case Study & Technical Analysis: ONT Cancelled Orders Report

## Executive Summary

The ONT Cancelled Orders Report provides a detailed and analytical view of all sales order lines that have been cancelled within Oracle Order Management. This report is a crucial tool for sales managers, order administrators, and financial analysts to understand the frequency, reasons, and impact of order cancellations. By providing clear insights into cancellation trends, it helps businesses identify potential issues in their sales, fulfillment, or customer service processes.

## Business Challenge

Order cancellations are an unavoidable part of business, but a high or increasing cancellation rate can signal significant underlying problems. Organizations often struggle to get clear visibility into these cancellations, facing challenges such as:

-   **Lack of Insight:** Without a dedicated report, it's difficult to analyze the root causes of cancellations. Are customers cancelling due to pricing, delivery delays, or poor service?
-   **Manual Data Analysis:** Compiling data on cancelled orders often involves manually querying orders or running multiple standard reports and trying to consolidate the information in spreadsheets, which is time-consuming and error-prone.
-   **Hidden Revenue Loss:** The financial impact of cancelled orders is often underestimated because it is not easily visible. This lost revenue can significantly affect forecasts and profitability.
-   **Poor Customer Experience:** A high cancellation rate with specific customers may indicate dissatisfaction that, if left unaddressed, could lead to customer churn.

## The Solution

The ONT Cancelled Orders Report offers a streamlined and effective way to monitor and analyze order cancellations, turning raw data into actionable insights.

-   **Root Cause Analysis:** The report includes the cancellation reason for each order line, allowing managers to categorize and analyze why cancellations are occurring and address the root cause.
-   **Trend Monitoring:** By using date range and salesperson parameters, management can track cancellation trends over time, identify patterns, and evaluate performance.
-   **Impact Assessment:** The report provides details on the items, quantities, and pricing of cancelled lines, making it easy to quantify the financial impact of lost sales.
-   **Customer and Product Insights:** It helps to pinpoint if cancellations are concentrated around specific customers, products, or product categories, highlighting potential quality or demand issues.

## Technical Architecture (High Level)

This report is based on a direct query of the Order Management schema, ensuring real-time and accurate data. It was originally a standard BI Publisher report, now optimized for performance.

-   **Primary Tables Involved:**
    -   `oe_order_headers_all` (for header-level information like customer and order date)
    -   `oe_order_lines_all` (the central table for line-level details, including quantities and pricing)
    -   `oe_order_lines_history` (used to track the audit trail of order line changes, including cancellations)
    -   `oe_reasons` (to provide the descriptive meaning of the cancellation code)
    -   `mtl_system_items_vl` (to get details about the cancelled item)
    -   `oe_sold_to_orgs_v` (for customer name and details)
-   **Logical Relationships:** The query identifies cancelled order lines (where `cancelled_flag` = 'Y' in `oe_order_lines_all`) and joins to the header to get customer and order context. It then links to the reasons table to provide a clear explanation for the cancellation.

## Parameters & Filtering

The report includes a comprehensive set of parameters to allow for focused and relevant analysis:

-   **Operating Unit:** To run the report for a specific business unit.
-   **Sort By:** Allows users to organize the data for better readability (e.g., by Customer, Order Number).
-   **Customer and Order Filters:** Enables filtering by a range of customer names or order numbers.
-   **Salesperson and Date Ranges:** Allows for performance analysis of specific sales reps or analysis of trends over a specific period.
-   **Item and Category Filters:** To investigate cancellations related to particular products or product lines.

## Performance & Optimization

The report's performance is optimized for a fast and efficient user experience.

-   **Direct Database Query:** Unlike the original BI Publisher version that relies on generating an intermediate XML file, this Blitz Report queries the database directly, which is significantly faster for data extraction.
-   **Indexed Access:** The query is designed to use the standard Oracle indexes on the `oe_order_headers_all` and `oe_order_lines_all` tables (e.g., on `order_number`, `org_id`), ensuring efficient data retrieval.

## FAQ

**1. What is the difference between a 'closed' order line and a 'cancelled' one?**
   A 'closed' line has been successfully fulfilled and invoiced, completing its lifecycle. A 'cancelled' line, on the other hand, was intentionally terminated before fulfillment was complete and will not be shipped or invoiced.

**2. Does the report show who cancelled the order line and when?**
   Yes, the report typically includes the 'Last Updated By' and 'Last Update Date' columns for the order line, which would reflect the user who performed the cancellation and the timestamp of the action.

**3. Can I see order lines that were partially cancelled?**
   Yes. If an order line's quantity was reduced (e.g., from 10 to 6), the original line is often split. The report would show a cancelled line for the quantity of 4 with a corresponding cancellation reason, and the original line would now have a quantity of 6, which would proceed to fulfillment.
