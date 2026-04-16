---
layout: default
title: 'MSC Plan Order Upload | Oracle EBS SQL Report'
description: 'Report: MSC Plan Orders Upload Description: Upload to action Plan Order recommendations. This upload can be used to either select for release or release…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, MSC, Plan, Order, msc_system_items&a2m_dblink, msc_item_categories&a2m_dblink, msc_category_sets&a2m_dblink'
permalink: /MSC%20Plan%20Order%20Upload/
---

# MSC Plan Order Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/msc-plan-order-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report: MSC Plan Orders Upload
Description: Upload to action Plan Order recommendations.

This upload can be used to either select for release or release Plan Order Recommendations from ASCP planning instances.

Currently supported recommendations that can be actioned by this upload are:
- Planned Order Releases
- Reschedule In/Out recommendations

 Additionally, it allows the user to amend the recommended Implement Date and/or Quantity.

In the generated Excel the user can amend the following columns:
- Implement Date
- Implement Quantity
- Update Release Status

Update Release Status can be either
- Select for Release
- Release the Order

This is determined by the Report Parameter: Upload Mode

For plan orders not yet selected for release, to amend the implement date and/or implement quantity, the Update Release Status column must also be specified as 'Select for Release' or 'Release the Order' against the Plan Order. 
If a plan order is already selected for release, then the user can amend the implement date and/or quantity in the generated excel without specifying a value in the Update Release Status column.

The report parameter Upload mode determines the allowable action to be taken against the plan order recommendations in the upload ('Select for Release' or 'Release the Order') 

The report parameter Auto Populate Release Status  if set to Yes, will automatically populate the 'Update Release Status' column and set the status to pending validation against all downloaded plan order recommendations in the generated excel. 
In this scenario, the generated excel can be saved and uploaded without the user needing to manually review and select the specific plan orders to be updated in the generated excel


## Report Parameters
Upload Mode, Auto Populate Release Status, Planning Instance, Plan, Organization, Source Organiziation, Category Set, Category, Item, Explode Assemblies, Project, Planner, Buyer, Make/Buy, Order Type, Action, Selected for Release, Suggested Due From, Suggested Due To, Show Item Descriptive Attributes

## Oracle EBS Tables Used
[msc_system_items&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_system_items&a2m_dblink), [msc_item_categories&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_item_categories&a2m_dblink), [msc_category_sets&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_category_sets&a2m_dblink), [msc_boms&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_boms&a2m_dblink), [msc_bom_components&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_bom_components&a2m_dblink), [q_selected_items](https://www.enginatics.com/library/?pg=1&find=q_selected_items), [q_sub_components](https://www.enginatics.com/library/?pg=1&find=q_sub_components), [msc_safety_stocks&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_safety_stocks&a2m_dblink), [msc_supplies&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_supplies&a2m_dblink), [msc_apps_instances&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_apps_instances&a2m_dblink), [msc_plans&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_plans&a2m_dblink), [msc_plan_organizations&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_plan_organizations&a2m_dblink), [q_all_items](https://www.enginatics.com/library/?pg=1&find=q_all_items)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[MSC Pegging Hierarchy](/MSC%20Pegging%20Hierarchy/ "MSC Pegging Hierarchy Oracle EBS SQL Report"), [MSC Pegging Hierarchy 11i](/MSC%20Pegging%20Hierarchy%2011i/ "MSC Pegging Hierarchy 11i Oracle EBS SQL Report"), [MSC Vertical Plan](/MSC%20Vertical%20Plan/ "MSC Vertical Plan Oracle EBS SQL Report"), [MSC Plan Orders](/MSC%20Plan%20Orders/ "MSC Plan Orders Oracle EBS SQL Report"), [MSC Horizontal Plan](/MSC%20Horizontal%20Plan/ "MSC Horizontal Plan Oracle EBS SQL Report"), [MSC Exceptions](/MSC%20Exceptions/ "MSC Exceptions Oracle EBS SQL Report"), [OPM Batch Lot Cost Details](/OPM%20Batch%20Lot%20Cost%20Details/ "OPM Batch Lot Cost Details Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/msc-plan-order-upload/) |
| Blitz Report™ XML Import | [MSC_Plan_Order_Upload.xml](https://www.enginatics.com/xml/msc-plan-order-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/msc-plan-order-upload/](https://www.enginatics.com/reports/msc-plan-order-upload/) |

## MSC Plan Order Upload - Case Study & Technical Analysis

### Executive Summary
The **MSC Plan Order Upload** is a powerful tool that allows planners to "action" the recommendations from the ASCP plan in bulk. Instead of manually clicking "Release" on hundreds of planned orders in the Planner's Workbench, users can download the recommendations to Excel, review/modify them, and upload the release actions back to Oracle.

### Business Challenge
The "Planner's Workbench" UI can be slow and cumbersome for mass updates.
-   **Mass Release:** "I have 500 planned orders for next week. I want to release them all to Purchasing at once."
-   **Modifications:** "I need to change the dates on 50 orders before releasing them. Doing this one by one takes hours."
-   **Review Process:** "I want to review the plan in Excel, filter for my suppliers, and then mark the ones I approve for release."

### Solution
The **MSC Plan Order Upload** bridges the gap between analysis (Excel) and execution (Oracle).

**Key Features:**
-   **Action Support:** Supports "Release", "Reschedule In", and "Reschedule Out" actions.
-   **Modification:** Allows users to change the Implement Date and Implement Quantity before releasing.
-   **Auto-Release:** Can be configured to automatically set the release status for all downloaded rows.

### Technical Architecture
The tool uses a WebADI-style upload mechanism to update the plan tables.

#### Key Tables and Views
-   **`MSC_SUPPLIES`**: The table storing the planned orders.
-   **`MSC_SYSTEM_ITEMS`**: Item validation.
-   **`MSC_PLAN_ORGANIZATIONS`**: Plan context.

#### Core Logic
1.  **Download:** Retrieves Planned Orders based on criteria (Plan, Org, Planner).
2.  **User Action:** The user updates the "Update Release Status" column (e.g., to 'Release') and optionally modifies dates/quantities.
3.  **Upload:** The tool updates the corresponding records in `MSC_SUPPLIES` with the new status and values.
4.  **Execution:** A subsequent concurrent request (in Oracle) processes these marked records and generates the actual WIP Jobs or Purchase Requisitions.

### Business Impact
-   **Productivity:** Reduces the time spent on administrative tasks (releasing orders) by 90%.
-   **Accuracy:** Reduces manual data entry errors during the release process.
-   **Control:** Gives planners a familiar environment (Excel) to review and approve the plan before execution.


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
