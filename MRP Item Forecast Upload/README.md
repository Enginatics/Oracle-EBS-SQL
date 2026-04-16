---
layout: default
title: 'MRP Item Forecast Upload | Oracle EBS SQL Report'
description: 'MRP Item Forecast Upload ================================ - Create New Item Forecast Entries. - Update Existing Item Forecast Entries. - Delete Existing…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, MRP, Item, Forecast, pa_projects_all, pjm_seiban_numbers, pa_tasks'
permalink: /MRP%20Item%20Forecast%20Upload/
---

# MRP Item Forecast Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-item-forecast-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
MRP Item Forecast Upload
================================
- Create New Item Forecast Entries.
- Update Existing Item Forecast Entries.
- Delete Existing Item Forecast Entries (Delete by setting the Forecast Quantity = 0).

Prerequisites/Restrictions
==========================

- Forecast Designators must be defined.
- Item Forecasts can only be uploaded to a Forecast, not a Forecast Set.

Upload Modes
============

Create
------
Opens an empty spreadsheet where the user can enter new Forecast Entries against any accessible Forecast. 

Use the Organization Code, Forecast Set, Forecast Name parameters to restrict the Organizations, Forecast Sets, and Forecasts LOVs in the spreadsheet.

Create and Update
-----------------
Create new Forecast Entries and/or Modify Existing Forecast Entries.

Allows the user to 
- download existing Forecast Entries for the Forecasts meeting the entered selection criteria.
- modify (add/update/delete) the Forecast Entries within the downloaded Forecasts.
- create new Forecast Entries in any accessible Forecast.

This mode allows the creation of Forecast Entries against Forecasts not included in the download.
This mode can be used for downloading Forecast Entries from an existing Forecast and copying them to a different Forecast.

Update
------
Modify (Add/Update/Delete) Forecast Entries against the downloaded Forecasts only.

Allows the user to 
- download existing Forecast Entries for the Forecasts meeting the entered selection criteria.
- modify (add/update/delete) the Forecast Entries within the downloaded Forecasts only.

This mode does not allow the creation of Forecast Entries against Forecasts not included in the download.

Parameters that control the upload behaviour: 
======================================

Delete Existing Forecast
-----------------------
Select ‘DELETE all existing forecast entries and replace’ if this upload will replace all existing entries in the forecast. In this case all existing forecast entries are deleted before the new forecast entries are loaded.
Select ‘KEEP existing forecast entries and update’ if this upload is creating new entries to add to the forecast and/or updating/deleting specific forecast entries. In this case the existing forecast entries are retained.
The option to delete the existing forecast is only available when the upload is run in the Create upload mode.

Default Bucket Type
---------------------------
This is the default bucket type used for the forecast entries if not specified in the upload spreadsheet. It will default from the selected forecast name, selected forecast set or will default to Days if a Forecast Set or Forecast Name is not specified.
This can be overridden in the Upload spreadsheet for individual forecast entries.

Default Workday Control
---------------------------------
This parameter determines the default behaviour for handling a non-workday forecast date or forecast end date. 
The options are Reject the forecast entry, shift the date backwards to the previous working bucket date, or shift the date forward to the next working bucket date.   
This can be overridden in the Upload spreadsheet for individual forecast entries.





## Report Parameters
Upload Mode, Delete Existing Forecast, Default Bucket Type, Default Workday Control, Organization Code, Forecast Set, Forecast Name, Planner, Item, Project, Forecast Date From, Forecast Date To

## Oracle EBS Tables Used
[pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pjm_seiban_numbers](https://www.enginatics.com/library/?pg=1&find=pjm_seiban_numbers), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mrp_forecast_designators](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_designators), [mrp_forecast_items_v](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_items_v), [mrp_forecast_dates](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_dates), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[MRP Item Forecast](/MRP%20Item%20Forecast/ "MRP Item Forecast Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [WIP Entities](/WIP%20Entities/ "WIP Entities Oracle EBS SQL Report"), [INV Safety Stocks](/INV%20Safety%20Stocks/ "INV Safety Stocks Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MRP Item Forecast Upload - Default 04-May-2025 154504.xlsm](https://www.enginatics.com/example/mrp-item-forecast-upload/) |
| Blitz Report™ XML Import | [MRP_Item_Forecast_Upload.xml](https://www.enginatics.com/xml/mrp-item-forecast-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/mrp-item-forecast-upload/](https://www.enginatics.com/reports/mrp-item-forecast-upload/) |

## MRP Item Forecast Upload - Case Study & Technical Analysis

### Executive Summary
The **MRP Item Forecast Upload** is a data management tool designed to streamline the maintenance of demand forecasts. Instead of manually entering forecast quantities line-by-line in the Oracle forms, planners can use this tool to upload, update, or delete forecast entries in bulk via Excel.

### Business Challenge
Managing forecasts for thousands of items is tedious and error-prone when done manually.
-   **Data Entry Volume:** "We have 5,000 items with monthly forecasts for the next 2 years. I can't type all that in."
-   **Scenario Planning:** "We want to create a 'Best Case' forecast scenario by copying the 'Base' forecast and increasing it by 10%. How do we do that quickly?"
-   **Integration:** "Our sales team does their forecasting in a separate tool. We need to import those numbers into Oracle MRP."

### Solution
The **MRP Item Forecast Upload** provides a bi-directional interface for forecast data.

**Key Features:**
-   **Bulk Creation:** Upload new forecast entries for multiple items and organizations at once.
-   **Mass Updates:** Download existing forecasts, modify quantities or dates in Excel, and upload the changes.
-   **Copy Functionality:** Download data from one forecast set and upload it to another (e.g., Copy '2023_BUDGET' to '2023_REVISED').
-   **Deletion:** Allows deleting entries by setting the quantity to zero.

### Technical Architecture
The tool uses a WebADI-style approach (Blitz Report Upload) to interface with the MRP forecast tables.

#### Key Tables and Views
-   **`MRP_FORECAST_ITEMS`**: The underlying table where forecast entries are stored.
-   **`MRP_FORECAST_DESIGNATORS`**: Validates the forecast names and sets.
-   **`MRP_FORECAST_DATES`**: Stores the specific date and quantity buckets.

#### Core Logic
1.  **Download (Optional):** Retrieves existing forecast data based on parameters (Organization, Forecast Set).
2.  **Validation:** Checks that the Item, Organization, and Forecast Name exist and are valid.
3.  **Processing:**
    -   **Insert:** Creates new records in `MRP_FORECAST_DATES`.
    -   **Update:** Modifies existing records matching the primary key (Forecast, Item, Date, Bucket).
    -   **Delete:** Removes records where the uploaded quantity is 0.

### Business Impact
-   **Efficiency:** Reduces forecast entry time from days to minutes.
-   **Agility:** Enables rapid scenario planning and "what-if" analysis.
-   **Accuracy:** Eliminates manual data entry errors by allowing copy-paste from external sources.


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
