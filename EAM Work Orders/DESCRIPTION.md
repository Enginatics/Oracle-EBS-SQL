# EAM Work Orders - Case Study & Technical Analysis

## Executive Summary

The **EAM Work Orders** report provides a comprehensive view of Enterprise Asset Management (EAM) maintenance activities. It serves as a central dashboard for maintenance planners and financial analysts to monitor work order status, schedule adherence, asset performance, and associated costs. By consolidating operational data (dates, statuses, asset details) with financial data (estimated vs. actual costs), this report enables organizations to optimize maintenance schedules, control budget overruns, and improve asset reliability.

## Business Challenge

Maintenance organizations often struggle with disjointed data residing in separate modules—work order management, asset tracking, and costing. This fragmentation leads to several challenges:

*   **Lack of Visibility:** Difficulty in tracking the real-time status of maintenance jobs across different departments and assets.
*   **Cost Control Issues:** Inability to compare estimated costs against actual expenses at the work order level, leading to budget variances.
*   **Scheduling Inefficiencies:** Challenges in monitoring scheduled vs. actual completion dates, impacting asset availability and production uptime.
*   **Asset History Gaps:** fragmented history of maintenance activities performed on specific assets, hindering root cause analysis for failures.

## Solution

The **EAM Work Orders** report addresses these challenges by delivering a unified view of the maintenance lifecycle. It links work orders directly to the assets they service and provides a detailed breakdown of costs and scheduling metrics.

**Key Benefits:**

*   **Operational Insight:** Tracks work orders from creation to completion, including status, priority, and assigned department.
*   **Financial Transparency:** detailed comparison of estimated vs. actual costs for material, labor, and equipment, aggregated by period.
*   **Asset Management:** Provides a clear history of maintenance performed on each asset, including failure codes and causes.
*   **Schedule Adherence:** Calculates duration and highlights discrepancies between scheduled and actual dates.

## Technical Architecture

The report is built on the Oracle E-Business Suite EAM and WIP (Work in Process) architecture. It primarily queries the `WIP_DISCRETE_JOBS` table, which stores the header information for maintenance work orders, and joins it with `CSI_ITEM_INSTANCES` for asset details.

**Key Tables & Joins:**

*   `WIP_DISCRETE_JOBS` (WDJ): The core table containing work order headers, status, dates, and class codes.
*   `CSI_ITEM_INSTANCES` (CII): Links the work order to the specific asset being maintained (Asset Number, Serial Number).
*   `MTL_SYSTEM_ITEMS_B_KFV` (MSIBK): Provides item details for the Asset Group and Activity.
*   `BOM_DEPARTMENTS` (BD): Identifies the maintenance department responsible for the work.
*   `EAM_WORK_ORDER_DETAILS` (EWOD): Stores EAM-specific attributes like shutdown type and failure information.
*   `WIP_EAM_PERIOD_BALANCES` & `WIP_EAM_COST_DETAILS_V`: Used to retrieve period-based cost information (Actual vs. Estimated).

## Parameters

The report supports a wide range of parameters to filter data for specific analysis needs:

*   **Organization Code:** Filter by the EAM maintenance organization.
*   **Department:** Filter by the specific maintenance department.
*   **Asset Group:** Select work orders for a specific group of assets.
*   **Asset Number:** Filter for a specific asset instance.
*   **Scheduled Start Date From/To:** Range for planned start dates.
*   **Work Order Creation Date From/To:** Range for when the work orders were created.
*   **Work Order Status:** Filter by status (e.g., Released, Complete, On Hold).
*   **Planner:** Filter by the assigned maintenance planner.
*   **Work Order Created By:** Filter by the user who created the work order.
*   **Cost Period from Date/to Date:** Define the period for cost accumulation analysis.
*   **Cost Detail Level:** Toggle between summary or detailed cost views.

## FAQ

**Q: How are "Actual Costs" calculated in this report?**
A: Actual costs are derived from the `WIP_EAM_PERIOD_BALANCES` table, summing up charges (Material, Labor, Equipment) posted to the work order within the specified cost period.

**Q: Can I see work orders that are currently on hold?**
A: Yes, you can use the "Work Order Status" parameter to filter for specific statuses, including "On Hold" or "Pending".

**Q: Does this report include failure analysis data?**
A: Yes, the report includes columns for `Failure Code`, `Failure Description`, and `Cause`, provided that failure information was captured on the work order.

**Q: Why do some work orders show no asset number?**
A: Rebuildable work orders or work orders created for general maintenance activities not linked to a specific serialized asset instance might not have an asset number.
