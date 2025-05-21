/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MRP Item Forecast Upload
-- Description: MRP Item Forecast Upload
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

Replace Forecast
-----------------------
Select Yes if this upload will replace all existing entries in the forecast. In this case all existing forecast entries are deleted before the new forecast entries are loaded.
Select No if this upload is creating new entries to add to the forecast and/or updating/deleting specific forecast entries. In this case the existing forecast entries are retained.

Default Bucket Type
---------------------------
This is the default bucket type used for the forecast entries if not specified in the upload spreadsheet. It will default from the selected forecast name, selected forecast set or will default to Days if a Forecast Set or Forecast Name is not specified.
This can be overridden in the Upload spreadsheet for individual forecast entries.

Default Workday Control
---------------------------------
This parameter determines the default behaviour for handling a non-workday forecast date or forecast end date. 
The options are Reject the forecast entry, shift the date backwards to the previous working bucket date, or shift the date forward to the next working bucket date.   
This can be overridden in the Upload spreadsheet for individual forecast entries.


-- Excel Examle Output: https://www.enginatics.com/example/mrp-item-forecast-upload/
-- Library Link: https://www.enginatics.com/reports/mrp-item-forecast-upload/
-- Run Report: https://demo.enginatics.com/

select
 null action_,
 null status_,
 null message_,
 null request_id_,
 null modified_columns_,
 to_char(null) row_id,
 to_char(null) request_id,
 :p_upload_mode upload_mode,
 to_char(null) source_code,
 to_char(null) replace_forecast,
 --
 mp.organization_code,
 mfds.forecast_set,
 mfds.forecast_designator forecast,
 mfds.description forecast_description,
 msiv.concatenated_segments item,
 msiv.description item_description,
 msiv.primary_uom_code uom,
 msiv.planner_code planner,
 mfd.forecast_date forecast_date,
 mfd.rate_end_date forecast_end_date,
 mfd.original_forecast_quantity original_quantity,
 mfd.current_forecast_quantity quantity,
 mfd.comments,
 xxen_util.meaning(mfd.bucket_type,'MRP_BUCKET_TYPE',700) bucket_type,
 to_char(null) workday_control,
 mfd.confidence_percentage,
 nvl(
  (select ppa.segment1 project_number from pa_projects_all ppa where ppa.project_id = mfd.project_id),
  (select psm.project_number from pjm_seiban_numbers psm where psm.project_id = mfd.project_id)
 ) project,
 (select pt.task_number from pa_tasks pt where pt.task_id = mfd.task_id) task,
 (select wl.line_code from wip_lines wl where wl.line_id = mfd.line_id and wl.organization_id = mfd.organization_id)  wip_line_code,
 mfd.attribute_category,
 mfd.attribute1,
 mfd.attribute2,
 mfd.attribute3,
 mfd.attribute4,
 mfd.attribute5,
 mfd.attribute6,
 mfd.attribute7,
 mfd.attribute8,
 mfd.attribute9,
 mfd.attribute10,
 mfd.attribute11,
 mfd.attribute12,
 mfd.attribute13,
 mfd.attribute14,
 mfd.attribute15,
 mfd.transaction_id
from
 mtl_parameters mp,
 mrp_forecast_designators mfds,
 mrp_forecast_items_v mfiv,
 mrp_forecast_dates mfd,
 mtl_system_items_vl msiv
where
 1=1 and
 mfds.forecast_set        = nvl(:p_forecast_set,mfds.forecast_set) and 
 mfds.organization_id     = mp.organization_id and
 mfds.organization_id     = mfiv.organization_id and
 mfds.forecast_designator = mfiv.forecast_designator and
 mfiv.organization_id     = mfd.organization_id and
 mfiv.forecast_designator = mfd.forecast_designator and
 mfiv.inventory_item_id   = mfd.inventory_item_id and
 mfiv.organization_id     = msiv.organization_id and
 mfiv.inventory_item_id   = msiv.inventory_item_id