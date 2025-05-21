/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WMS Control Board Tasks
-- Description: List All the Warehouse Control Board Tasks
------------------------------------------------------------------------
Parameters:
Task Type: Filter by Task Type
User Task Type: Filter by selected user task type based on task.
Task Status : Filter by Task Statuses.
Excluded Task Status: Filter the tasks excluding status like "Completed"
Show WIP Material Movements: In case WIP details to be extracted corresponding to tasks
Show Sales Order Movements: In case Sales Order details to be extracted corresponding to tasks
-------------------------------------------------------------------------------------------------------------------------
-- Excel Examle Output: https://www.enginatics.com/example/wms-control-board-tasks/
-- Library Link: https://www.enginatics.com/reports/wms-control-board-tasks/
-- Run Report: https://demo.enginatics.com/

select
wtv.organization_code,
wtv.organization_name,
wtv.task_creation_date,
wtv.task_type,
wtv.task_status,
wtv.user_task_type_code,
wtv.user_task_type,
wtv.task_assigned_to,
wtv.item,
wtv.item_description,
wtv.lot_number,
wtv.subinventory_code,
wtv.locator,
&wip_columns
&order_columns
wtv.transaction_type,
wtv.transaction_action,
wtv.transaction_source_type,
wtv.transaction_source_name,
wtv.transaction_uom,
wtv.transaction_quantity,
wtv.transfer_organization_name,
wtv.transfer_subinventory,
wtv.transfer_locator,
wtv.equipment,
wtv.equipment_description,
wtv.task_dispatched_time,
--id columns 
wtv.move_order_line_id,
wtv.transaction_temp_id,
wtv.inventory_item_id,
wtv.organization_id,
wtv.locator_id,
wtv.transaction_type_id,
wtv.transaction_action_id,
wtv.transaction_source_type_id,
wtv.transaction_source_id,
wtv.transaction_source_line_id,
wtv.task_id,
wtv.person_id,
wtv.status_id,
--who columns
wtv.last_update_date,
wtv.last_updated_by,
wtv.created_by,
wtv.last_update_login
from
(select 
wtv.organization_code,
wtv.organization_name,
wtv.creation_date  task_creation_date,
wtv.task_type_description task_type,
wtv.status_code task_status,
wtv.user_task_type_code,
wtv.user_task_type_description user_task_type,
wtv.full_name task_assigned_to,
wtv.item,
wtv.item_description,
wtv.lot_number,
wtv.subinventory_code,
wtv.locator_description locator,
we.wip_entity_name wip_job_number,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) wip_job_status,
decode (wdj.firm_planned_flag,  1, 'Yes',  2, 'No') wip_job_firmed,
ooh.order_number sales_order_number,
ool.schedule_ship_date sales_order_ssd,
rtrim(ool.line_number||'.'||ool.shipment_number||'.'||ool.option_number||'.'||ool.component_number||'.'||ool.service_number,'.') sales_order_line,
hp.party_name customer_name,
wtv.transaction_type,
wtv.transaction_action,
wtv.transaction_source_type,
wtv.transaction_source_name,
wtv.transaction_uom,
wtv.transaction_quantity,
wtv.transfer_organization_name,
wtv.transfer_subinventory,
wtv.transfer_locator_description transfer_locator,
wtv.equipment,
wtv.equipment_description,
wtv.dispatched_time task_dispatched_time,
--id columns 
wtv.move_order_line_id,
wtv.transaction_temp_id,
wtv.inventory_item_id,
wtv.organization_id,
wtv.locator_id,
wtv.transaction_type_id,
wtv.transaction_action_id,
wtv.transaction_source_type_id,
wtv.transaction_source_id,
wtv.transaction_source_line_id,
wtv.task_id,
wtv.person_id,
wtv.status status_id,
--who columns
wtv.last_update_date,
wtv.last_updated_by,
wtv.created_by,
wtv.last_update_login
from 
wms_tasks_v wtv,
wip_entities we,
wip_discrete_jobs wdj,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_cust_accounts hca,
hz_parties hp,
oe_order_lines_all ool,
mtl_reservations mr,
oe_order_headers_all ooh
where 
1=1 and
we.wip_entity_id=wtv.transaction_source_id and
wdj.wip_entity_id=we.wip_entity_id and
we.wip_entity_id=mr.supply_source_header_id(+) and
ool.line_id(+)=mr.demand_source_line_id and
ool.ship_to_org_id=hcsua.site_use_id(+) and
ool.header_id=ooh.header_id(+) and
hcasa.cust_acct_site_id(+)=hcsua.cust_acct_site_id and
hca.cust_account_id(+)=hcasa.cust_account_id and
hca.party_id=hp.party_id(+) and
wtv.transaction_source_type<>'Sales order' and
:p_show_wip_movements='Y' 
union all
select 
wtv.organization_code,
wtv.organization_name,
wtv.creation_date  task_creation_date,
wtv.task_type_description task_type,
wtv.status_code task_status,
wtv.user_task_type_code,
wtv.user_task_type_description user_task_type,
wtv.full_name task_assigned_to,
wtv.item,
wtv.item_description,
wtv.lot_number,
wtv.subinventory_code,
wtv.locator_description locator,
null wip_job_number,
null wip_job_status,
null wip_job_firmed,
ooh.order_number sales_order_number,
ool.schedule_ship_date sales_order_ssd,
rtrim(ool.line_number||'.'||ool.shipment_number||'.'||ool.option_number||'.'||ool.component_number||'.'||ool.service_number,'.') sales_order_line,
hp.party_name customer_name,
wtv.transaction_type,
wtv.transaction_action,
wtv.transaction_source_type,
wtv.transaction_source_name,
wtv.transaction_uom,
wtv.transaction_quantity,
wtv.transfer_organization_name,
wtv.transfer_subinventory,
wtv.transfer_locator_description transfer_locator,
wtv.equipment,
wtv.equipment_description,
wtv.dispatched_time task_dispatched_time,
--id columns 
wtv.move_order_line_id,
wtv.transaction_temp_id,
wtv.inventory_item_id,
wtv.organization_id,
wtv.locator_id,
wtv.transaction_type_id,
wtv.transaction_action_id,
wtv.transaction_source_type_id,
wtv.transaction_source_id,
wtv.transaction_source_line_id,
wtv.task_id,
wtv.person_id,
wtv.status status_id,
--who columns
wtv.last_update_date,
wtv.last_updated_by,
wtv.created_by,
wtv.last_update_login
from 
wms_tasks_v wtv,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_cust_accounts hca,
hz_parties hp,
oe_order_lines_all ool,
oe_order_headers_all ooh
where 
1=1 and
ool.line_id=wtv.transaction_source_line_id and
ool.ship_to_org_id=hcsua.site_use_id(+) and
ool.header_id=ooh.header_id and
hcasa.cust_acct_site_id(+)=hcsua.cust_acct_site_id and
hca.cust_account_id(+)=hcasa.cust_account_id and
hca.party_id=hp.party_id(+) and
:p_sales_order_movements='Y'
union all
select 
wtv.organization_code,
wtv.organization_name,
wtv.creation_date  task_creation_date,
wtv.task_type_description task_type,
wtv.status_code task_status,
wtv.user_task_type_code,
wtv.user_task_type_description user_task_type,
wtv.full_name task_assigned_to,
wtv.item,
wtv.item_description,
wtv.lot_number,
wtv.subinventory_code,
wtv.locator_description locator,
null wip_job_number,
null wip_job_status,
null wip_job_firmed,
null sales_order_number,
null sales_order_line,
null sales_order_ssd,
null customer_name,
wtv.transaction_type,
wtv.transaction_action,
wtv.transaction_source_type,
wtv.transaction_source_name,
wtv.transaction_uom,
wtv.transaction_quantity,
wtv.transfer_organization_name,
wtv.transfer_subinventory,
wtv.transfer_locator_description transfer_locator,
wtv.equipment,
wtv.equipment_description,
wtv.dispatched_time task_dispatched_time,
--id columns 
wtv.move_order_line_id,
wtv.transaction_temp_id,
wtv.inventory_item_id,
wtv.organization_id,
wtv.locator_id,
wtv.transaction_type_id,
wtv.transaction_action_id,
wtv.transaction_source_type_id,
wtv.transaction_source_id,
wtv.transaction_source_line_id,
wtv.task_id,
wtv.person_id,
wtv.status status_id,
--who columns
wtv.last_update_date,
wtv.last_updated_by,
wtv.created_by,
wtv.last_update_login
from 
wms_tasks_v wtv
where 
1=1 and
2=2 
)wtv