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

with wms_tasks as
(
select /*+ materialize*/ wtv.* from
wms_tasks_v wtv where 
1=1
),
wms_all_tasks as
(
select /*+ materialize*/ 
(select wlpn.license_plate_number from wms_license_plate_numbers wlpn where lpn_id=mmtt.allocated_lpn_id)allocated_lpn,
(select wlpn.license_plate_number from wms_license_plate_numbers wlpn where lpn_id=mmtt.cartonization_id)cartonize_lpn,
(select wlpn.license_plate_number from wms_license_plate_numbers wlpn where lpn_id=nvl(mmtt.lpn_id,mmt.lpn_id))from_lpn,
(select wlpn.license_plate_number from wms_license_plate_numbers wlpn where lpn_id=nvl(mmtt.content_lpn_id,mmt.content_lpn_id))content_lpn,
(select wlpn.license_plate_number from wms_license_plate_numbers wlpn where lpn_id=nvl(mmtt.transfer_lpn_id,mmt.transfer_lpn_id))to_lpn,
(select wlpn.license_plate_number from wms_license_plate_numbers wlpn where lpn_id=case when wt.status=6 then nvl(mmt.content_lpn_id, mmt.lpn_id) when wt.status!=6 and wt.status>3 then nvl(mmtt.content_lpn_id, mmtt.lpn_id)end)picked_lpn,
(select wlpn.license_plate_number from wms_license_plate_numbers wlpn where lpn_id=case when wt.status=6 then nvl(mmt.transfer_lpn_id,nvl(mmt.content_lpn_id,mmt.lpn_id)) when wt.status!=6 and wt.status>3 then nvl(mmtt.transfer_lpn_id,nvl(mmtt.content_lpn_id,mmtt.lpn_id))end)loaded_lpn,
(select wlpn.license_plate_number from wms_license_plate_numbers wlpn where lpn_id=nvl(mmt.transfer_lpn_id,nvl(mmt.content_lpn_id,mmt.lpn_id)))drop_lpn,
wt.* 
from
wms_tasks wt,
mtl_material_transactions_temp mmtt,
mtl_material_transactions mmt
where 
wt.transaction_temp_id=mmtt.transaction_temp_id(+) and
wt.transaction_temp_id=mmt.transaction_id(+)
)
select
wtv.transaction_temp_id transaction_number,
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
--LPN Columns
wtv.cartonize_lpn,
wtv.allocated_lpn,
wtv.content_lpn,
wtv.from_lpn,
wtv.to_lpn,
wtv.picked_lpn,
wtv.loaded_lpn,
wtv.drop_lpn,
--id columns 
wtv.move_order_line_id,
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
wat.organization_code,
wat.organization_name,
wat.creation_date  task_creation_date,
wat.task_type_description task_type,
wat.status_code task_status,
wat.user_task_type_code,
wat.user_task_type_description user_task_type,
wat.full_name task_assigned_to,
wat.item,
wat.item_description,
wat.lot_number,
wat.subinventory_code,
wat.locator_description locator,
we.wip_entity_name wip_job_number,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) wip_job_status,
decode (wdj.firm_planned_flag,  1, 'Yes',  2, 'No') wip_job_firmed,
ooha.order_number sales_order_number,
oola.schedule_ship_date sales_order_ssd,
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') sales_order_line,
hp.party_name customer_name,
wat.transaction_type,
wat.transaction_action,
wat.transaction_source_type,
wat.transaction_source_name,
wat.transaction_uom,
wat.transaction_quantity,
wat.transfer_organization_name,
wat.transfer_subinventory,
wat.transfer_locator_description transfer_locator,
wat.equipment,
wat.equipment_description,
wat.dispatched_time task_dispatched_time,
--id columns 
wat.move_order_line_id,
wat.transaction_temp_id,
wat.inventory_item_id,
wat.organization_id,
wat.locator_id,
wat.transaction_type_id,
wat.transaction_action_id,
wat.transaction_source_type_id,
wat.transaction_source_id,
wat.transaction_source_line_id,
wat.task_id,
wat.person_id,
wat.status status_id,
--LPN Columns
wat.cartonize_lpn,
wat.allocated_lpn,
wat.content_lpn,
wat.from_lpn,
wat.to_lpn,
wat.picked_lpn,
wat.loaded_lpn,
wat.drop_lpn,
--who columns
wat.last_update_date,
wat.last_updated_by,
wat.created_by,
wat.last_update_login
from 
wms_all_tasks wat,
wip_entities we,
wip_discrete_jobs wdj,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_cust_accounts hca,
hz_parties hp,
oe_order_lines_all oola,
mtl_reservations mr,
oe_order_headers_all ooha
where 
we.wip_entity_id=wat.transaction_source_id and
wdj.wip_entity_id=we.wip_entity_id and
we.wip_entity_id=mr.supply_source_header_id(+) and
oola.line_id(+)=mr.demand_source_line_id and
oola.ship_to_org_id=hcsua.site_use_id(+) and
oola.header_id=ooha.header_id(+) and
hcasa.cust_acct_site_id(+)=hcsua.cust_acct_site_id and
hca.cust_account_id(+)=hcasa.cust_account_id and
hca.party_id=hp.party_id(+) and
wat.transaction_source_type<>'Sales order' and
:p_show_wip_movements='Y' 
union all
select 
wat.organization_code,
wat.organization_name,
wat.creation_date  task_creation_date,
wat.task_type_description task_type,
wat.status_code task_status,
wat.user_task_type_code,
wat.user_task_type_description user_task_type,
wat.full_name task_assigned_to,
wat.item,
wat.item_description,
wat.lot_number,
wat.subinventory_code,
wat.locator_description locator,
null wip_job_number,
null wip_job_status,
null wip_job_firmed,
ooha.order_number sales_order_number,
oola.schedule_ship_date sales_order_ssd,
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') sales_order_line,
hp.party_name customer_name,
wat.transaction_type,
wat.transaction_action,
wat.transaction_source_type,
wat.transaction_source_name,
wat.transaction_uom,
wat.transaction_quantity,
wat.transfer_organization_name,
wat.transfer_subinventory,
wat.transfer_locator_description transfer_locator,
wat.equipment,
wat.equipment_description,
wat.dispatched_time task_dispatched_time,
--id columns 
wat.move_order_line_id,
wat.transaction_temp_id,
wat.inventory_item_id,
wat.organization_id,
wat.locator_id,
wat.transaction_type_id,
wat.transaction_action_id,
wat.transaction_source_type_id,
wat.transaction_source_id,
wat.transaction_source_line_id,
wat.task_id,
wat.person_id,
wat.status status_id,
--LPN Columns
wat.cartonize_lpn,
wat.allocated_lpn,
wat.content_lpn,
wat.from_lpn,
wat.to_lpn,
wat.picked_lpn,
wat.loaded_lpn,
wat.drop_lpn,
--who columns
wat.last_update_date,
wat.last_updated_by,
wat.created_by,
wat.last_update_login
from 
wms_all_tasks wat,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_cust_accounts hca,
hz_parties hp,
oe_order_lines_all oola,
oe_order_headers_all ooha
where 
oola.line_id=wat.transaction_source_line_id and
oola.ship_to_org_id=hcsua.site_use_id(+) and
oola.header_id=ooha.header_id and
hcasa.cust_acct_site_id(+)=hcsua.cust_acct_site_id and
hca.cust_account_id(+)=hcasa.cust_account_id and
hca.party_id=hp.party_id(+) and
:p_sales_order_movements='Y'
union all
select 
wat.organization_code,
wat.organization_name,
wat.creation_date  task_creation_date,
wat.task_type_description task_type,
wat.status_code task_status,
wat.user_task_type_code,
wat.user_task_type_description user_task_type,
wat.full_name task_assigned_to,
wat.item,
wat.item_description,
wat.lot_number,
wat.subinventory_code,
wat.locator_description locator,
null wip_job_number,
null wip_job_status,
null wip_job_firmed,
null sales_order_number,
null sales_order_line,
null sales_order_ssd,
null customer_name,
wat.transaction_type,
wat.transaction_action,
wat.transaction_source_type,
wat.transaction_source_name,
wat.transaction_uom,
wat.transaction_quantity,
wat.transfer_organization_name,
wat.transfer_subinventory,
wat.transfer_locator_description transfer_locator,
wat.equipment,
wat.equipment_description,
wat.dispatched_time task_dispatched_time,
--id columns 
wat.move_order_line_id,
wat.transaction_temp_id,
wat.inventory_item_id,
wat.organization_id,
wat.locator_id,
wat.transaction_type_id,
wat.transaction_action_id,
wat.transaction_source_type_id,
wat.transaction_source_id,
wat.transaction_source_line_id,
wat.task_id,
wat.person_id,
wat.status status_id,
--LPN Columns
wat.cartonize_lpn,
wat.allocated_lpn,
wat.content_lpn,
wat.from_lpn,
wat.to_lpn,
wat.picked_lpn,
wat.loaded_lpn,
wat.drop_lpn,
--who columns
wat.last_update_date,
wat.last_updated_by,
wat.created_by,
wat.last_update_login
from 
wms_all_tasks wat
where
2=2 
) wtv