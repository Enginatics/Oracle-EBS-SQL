/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
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


-- Excel Examle Output: https://www.enginatics.com/example/inv-safety-stock-upload/
-- Library Link: https://www.enginatics.com/reports/inv-safety-stock-upload/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
null action_,
null status_,
null message_,
null request_id_,
rowidtochar(mss.rowid) row_id,
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
ppov.project_number,
ppov.project_name,
ptv.task_number,
ptv.task_name,
to_char(mss.effectivity_date,'DD-Mon-YYYY') effective_date,
msiv.primary_uom_code uom,
mss.safety_stock_quantity quantity,
null delete_this_entry,
xxen_util.meaning(mss.safety_stock_code,'MTL_SAFETY_STOCK',700) safety_stock_method,
mss.forecast_designator forecast,
mss.safety_stock_percent,
mss.service_level service_level_percent,
msiv.planner_code planner
from
mtl_safety_stocks mss,
mtl_parameters mp,
mtl_system_items_vl msiv,
pjm_projects_org_v ppov,
pjm_tasks_v ptv
where
:p_upload_mode != 'Create' and
1=1 and
mss.organization_id = mp.organization_id and
mss.organization_id = msiv.organization_id and
mss.inventory_item_id = msiv.inventory_item_id and
mss.organization_id = ppov.inventory_organization_id (+) and
mss.project_id = ppov.project_id (+) and
mss.project_id = ptv.project_id (+) and
mss.task_id = ptv.task_id (+)
&not_use_first_block
&report_table_select &report_table_name &report_table_where_clause &success_records
&processed_run
) x
order by
x.organization_code,
x.item,
x.effective_date,
x.project_number,
x.task_number