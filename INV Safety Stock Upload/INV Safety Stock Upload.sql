/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Safety Stock Upload
-- Description: INV Safety Stock Upload
================================
- Upload New Safety Stock Entries.
- Update Existing Safety Stock Entries.
- Delete Existing Saffety Stock Entries (Delete by setting the 'Delete This Entry' = Yes).

Upload Modes
============

Create
------
Opens an empty spreadsheet where the user can enter new Safety Stock Quantities

Create or Update
-----------------
Create new Safety Stock entries and/or modify existing Safety Stock entries.

Allows the user to 
- download existing Safety Stock entiries based on the selection criteria specified in the report parameters.
- modify (update/delete) the downloaded Safety Stock entries
- create new Safety Stock entries

Note:
The greyed out columns are display only and included to provide additional information. These cannot be altered and are ignored by the upload.


-- Excel Examle Output: https://www.enginatics.com/example/inv-safety-stock-upload/
-- Library Link: https://www.enginatics.com/reports/inv-safety-stock-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
rowidtochar(mss.rowid) row_id,
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
ppov.project_number,
ppov.project_name,
ptv.task_number,
ptv.task_name,
mss.effectivity_date effective_date,
msiv.primary_uom_code uom,
mss.safety_stock_quantity quantity,
null delete_this_entry,
xxen_util.meaning(mss.safety_stock_code,'MTL_SAFETY_STOCK',700) safety_stock_method,
mss.forecast_designator forecast,
mss.safety_stock_percent,
mss.service_level service_level_percent,
msiv.planner_code planner,
(select 
 sum(moq.transaction_quantity)
 from   
 mtl_onhand_quantities moq
 where
 moq.organization_id = mss.organization_id and  
 moq.inventory_item_id = mss.inventory_item_id
 having 
 sum(moq.transaction_quantity) != 0
) onhand
from
mtl_safety_stocks mss,
mtl_parameters mp,
mtl_system_items_vl msiv,
pjm_projects_org_v ppov,
pjm_tasks_v ptv
where
:p_upload_mode like '%' || xxen_upload.action_update and
1=1 and
mss.organization_id = mp.organization_id and
mss.organization_id = msiv.organization_id and
mss.inventory_item_id = msiv.inventory_item_id and
mss.organization_id = ppov.inventory_organization_id (+) and
mss.project_id = ppov.project_id (+) and
mss.project_id = ptv.project_id (+) and
mss.task_id = ptv.task_id (+)