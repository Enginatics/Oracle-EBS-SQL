/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Material Status Change History
-- Description: Imported from BI Publisher
Description: Material Status Change History Report
Application: Inventory
Source: Material Status Change History Report (XML)
Short Name: INVMSCHR_XML
DB package: INV_INVMSCHR_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-material-status-change-history/
-- Library Link: https://www.enginatics.com/reports/inv-material-status-change-history/
-- Run Report: https://demo.enginatics.com/

with operating_unit as(
select
hou.name operating_unit_name, 
ood.operating_unit operating_unit_id, 
ood.organization_code, 
ood.organization_name inventory_organization_name,
ood.organization_id inv_organization_id
from
hr_operating_units hou,
org_organization_definitions ood
where
1=1 and
hou.organization_id=ood.operating_unit
)
select
ou.operating_unit_name operating_unit,
ou.organization_code,
ou.inventory_organization_name organization_name,
'01 SUBINVENTORY' row_Level,
mss.secondary_inventory_name subinventory,
null item_code,
null lot_number,
null serial_number,
null location,
mms.status_code,
mms.description status_description,
mms.enabled_flag,
mmsh.creation_date,
to_char(mmsh.creation_date,'hh24:mi:ss') creation_time,
mmsh.initial_status_flag initial_status,
decode(mmsh.from_mobile_apps_flag,'Y',:p_mob_apps,'N',:p_desk_apps,:p_desk_apps) updated_from,
ml.meaning update_method,
mtr.reason_name reason,
decode(p.person_id,null,fu.user_name,p.last_name||','||first_name) username
from
mtl_secondary_inventories mss,
mtl_material_status_history mmsh,
mfg_lookups ml,
mtl_transaction_reasons mtr,
mtl_material_statuses_vl mms,
per_all_people_f p,
fnd_user fu,
operating_unit ou
where
(2=2 and 2=1) and 
mss.organization_id=ou.inv_organization_id and 
mmsh.organization_id=mss.organization_id and
mmsh.zone_code=mss.secondary_inventory_name and
mmsh.status_id=mms.status_id and
mmsh.locator_id is null and
mmsh.lot_number is null and
mmsh.serial_number is null and
mtr.reason_id(+)=mmsh.update_reason_id and
ml.lookup_code=mmsh.update_method and
ml.lookup_type='MTL_STATUS_UPDATE_METHOD' and
mmsh.created_by=fu.user_id and
fu.employee_id=p.person_id(+)
&l_date_range
union all
select
ou.operating_unit_name operating_unit,
ou.organization_code,
ou.inventory_organization_name organization_name,
'02 LOCATOR' row_Level,
mil.subinventory_code subinventory,
null item_code,
null lot_number,
null serial_number,
mil.concatenated_segments location,
mms.status_code,
mms.description status_description,
mms.enabled_flag,
mmsh.creation_date,
to_char(mmsh.creation_date,'hh24:mi:ss') creation_time,
mmsh.initial_status_flag initial_status,
decode(mmsh.from_mobile_apps_flag,'Y',:p_mob_apps,'N',:p_desk_apps,:p_desk_apps) updated_from,
ml.meaning update_method,
mtr.reason_name reason,
decode(p.person_id,null,fu.user_name,p.last_name||','||first_name) username
from
mtl_item_locations_kfv mil,
mtl_material_status_history mmsh,
mfg_lookups ml,
mtl_transaction_reasons mtr,
mtl_material_statuses_vl mms,
per_all_people_f p,
fnd_user fu,
operating_unit ou
where 
&p_loc_where and
&p_xml_where and
mil.organization_id=ou.inv_organization_id and
mmsh.organization_id=mil.organization_id and
mmsh.zone_code=mil.subinventory_code and
mmsh.locator_id=mil.inventory_location_id and
mmsh.status_id=mms.status_id and
mmsh.locator_id is not null and
mmsh.lot_number is null and
mmsh.serial_number is null and
mtr.reason_id(+)=mmsh.update_reason_id and
ml.lookup_code=mmsh.update_method and
ml.lookup_type='MTL_STATUS_UPDATE_METHOD'and
mmsh.created_by=fu.user_id and
fu.employee_id=p.person_id (+)
&l_date_range
union all
select
ou.operating_unit_name operating_unit,
ou.organization_code,
ou.inventory_organization_name organization_name,
'03 LOT NUMBER' row_level,
mmsh.zone_code subinventory,
msi.concatenated_segments item_code,
mln.lot_number,
null serial_number,
null location,
mms.status_code,
mms.description status_description,
mms.enabled_flag,
mmsh.creation_date,
to_char(mmsh.creation_date,'hh24:mi:ss') creation_time,
mmsh.initial_status_flag initial_status,
decode(mmsh.from_mobile_apps_flag,'Y',:p_mob_apps,'N',:p_desk_apps,:p_desk_apps) updated_from,
ml.meaning update_method,
mtr.reason_name reason,
decode(p.person_id,null,fu.user_name,p.last_name||','||first_name) username
from
mtl_lot_numbers mln,
mtl_material_status_history mmsh,
mfg_lookups ml,
mtl_transaction_reasons mtr,
mtl_material_statuses_vl mms,
mtl_system_items_kfv msi,
per_all_people_f p,
fnd_user fu,
operating_unit ou
where
(3=3 and 3=1) and
mln.organization_id=ou.inv_organization_id and
mln.inventory_item_id=msi.inventory_item_id and
mln.organization_id=msi.organization_id and
mmsh.organization_id=mln.organization_id and
mmsh.inventory_item_id=mln.inventory_item_id and
mmsh.lot_number=mln.lot_number and
mmsh.status_id=mms.status_id and
mmsh.serial_number is null and
mtr.reason_id(+)=mmsh.update_reason_id and
ml.lookup_code=mmsh.update_method and
ml.lookup_type='MTL_STATUS_UPDATE_METHOD' and
mmsh.created_by=fu.user_id and
fu.employee_id=p.person_id(+)
&l_date_range
union all
select
ou.operating_unit_name operating_unit,
ou.organization_code,
ou.inventory_organization_name organization_name,
'04 SERIAL NUMBER' row_level,
mmsh.zone_code subinventory,
msi.concatenated_segments item_code,
null lot_number,
msn.serial_number,
null location,
mms.status_code,
mms.description status_description,
mms.enabled_flag,
mmsh.creation_date,
to_char(mmsh.creation_date,'hh24:mi:ss') creation_time,
mmsh.initial_status_flag initial_status,
decode(mmsh.from_mobile_apps_flag,'Y',:p_mob_apps,'N',:p_desk_apps,:p_desk_apps) updated_from,
ml.meaning update_method,
mtr.reason_name reason,
decode(p.person_id,null,fu.user_name,p.last_name||','||first_name) username
from
mtl_serial_numbers msn,
mtl_material_status_history mmsh,
mfg_lookups ml,
mtl_transaction_reasons mtr,
mtl_material_statuses_vl mms,
mtl_system_items_kfv msi,
per_all_people_f p,
fnd_user fu,
operating_unit ou 
where 
(4=4 and 4=1) and
msn.current_organization_id=ou.inv_organization_id and
msn.inventory_item_id=msi.inventory_item_id and
msn.current_organization_id=msi.organization_id and
mmsh.inventory_item_id=msn.inventory_item_id and
mmsh.serial_number=msn.serial_number and
mmsh.status_id=mms.status_id and
mtr.reason_id(+)= mmsh.update_reason_id and
ml.lookup_code=mmsh.update_method and
ml.lookup_type='MTL_STATUS_UPDATE_METHOD' and
mmsh.created_by=fu.user_id and
fu.employee_id=p.person_id (+)
&l_date_range