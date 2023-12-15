/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: EAM Assets
-- Description: Enterprise asset management asset details such as location, department etc.
-- Excel Examle Output: https://www.enginatics.com/example/eam-assets/
-- Library Link: https://www.enginatics.com/reports/eam-assets/
-- Run Report: https://demo.enginatics.com/

select
cii.organization_code,
cii.instance_number asset_number,
cii.instance_description,
msiv.concatenated_segments asset_group,
msiv.description asset_group_description,
cii0.instance_number parent_asset_number,
msibk0.concatenated_segments parent_asset_group,
fab.asset_number fixed_asset_number,
mcbk.concatenated_segments category,
eomd.accounting_class_code accounting_class,
nvl(cii.maintainable_flag,'Y') maintainable,
msn2.serial_number equipment_serial_number,
null asset_route,
cii.supplier_warranty_exp_date,
efs.set_name failure_set,
cii.inv_subinventory_name subinventory,
milk.concatenated_segments locator,
mel.location_codes area,
case when cii.location_type_code in ('HZ_LOCATIONS','PO','WIP','PROJECT','IN_TRANSIT','HZ_PARTY_SITES','VENDOR_SITE') then
hl.address1||','||hl.address2||','||hl.address3||','||hl.address4||','||hl.city||','||hl.state||','||hl.postal_code||','||hl.country else
hla.address_line_1||','||hla.address_line_2||','||hla.address_line_3||','||hla.region_1||','||hla.postal_code||','||hla.country
end location,
xxen_util.meaning(cii.asset_criticality_code,'MTL_EAM_ASSET_CRITICALITY',700) criticality,
bd.department_code owning_department,
pla.location_code,
pla.location_alias
from
(
select
mp.organization_code,
mp.maint_organization_id,
case
when cii.location_type_code in ('HZ_LOCATIONS','PO','WIP','PROJECT','IN_TRANSIT') then cii.location_id
when cii.location_type_code='HZ_PARTY_SITES' then (select hps.location_id from hz_party_sites hps where cii.location_id=hps.party_site_id)
when cii.location_type_code='VENDOR_SITE' then (select assa.location_id from ap_supplier_sites_all assa where cii.location_id=assa.vendor_site_id)
end hl_location_id,
cii.*
from
mtl_parameters mp,
csi_item_instances cii
where
1=1 and
cii.last_vld_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=cii.last_vld_organization_id
) cii,
mtl_system_items_vl msiv,
mtl_item_locations_kfv milk,
eam_org_maint_defaults eomd,
bom_departments bd,
mtl_eam_locations mel,
mtl_categories_b_kfv mcbk,
(select cia.* from csi_i_assets cia where sysdate<=nvl(cia.active_end_date,sysdate)) cia,
fa_additions_b fab,
pn_locations_all pla,
mtl_serial_numbers msn,
(select mog.* from mtl_object_genealogy mog where mog.genealogy_type=5 and sysdate between mog.start_date_active and nvl(mog.end_date_active,sysdate)) mog,
mtl_serial_numbers msn0,
mtl_serial_numbers msn2,
csi_item_instances cii0,
mtl_system_items_b_kfv msibk0,
(
select
efsa.inventory_item_id,
efs.set_name
from
eam_failure_set_associations efsa,
eam_failure_sets efs
where
efsa.set_id=efs.set_id and
sysdate<=nvl(efsa.effective_end_date,sysdate) and
sysdate<=nvl(efs.effective_end_date,sysdate)
) efs,
hz_locations hl,
hr_locations_all hla
where
2=2 and
sysdate between nvl(cii.active_start_date,sysdate) and nvl(cii.active_end_date,sysdate) and
cii.last_vld_organization_id=msiv.organization_id and
cii.inventory_item_id=msiv.inventory_item_id and
msiv.eam_item_type in (1,3) and
msiv.serial_number_control_code<>1 and
cii.inv_locator_id=milk.inventory_location_id(+) and
cii.instance_id=eomd.object_id(+) and
maint_organization_id=eomd.organization_id(+) and
eomd.object_type(+)=50 and
eomd.owning_department_id=bd.department_id(+) and
eomd.area_id=mel.location_id(+) and
cii.category_id=mcbk.category_id(+) and
cii.instance_id=cia.instance_id(+) and
cia.fa_asset_id=fab.asset_id(+) and
cii.pn_location_id=pla.location_id(+) and
cii.serial_number=msn.serial_number(+) and
cii.inventory_item_id=msn.inventory_item_id(+) and
msn.gen_object_id=mog.object_id(+) and
mog.parent_object_id=msn0.gen_object_id(+) and
msn0.inventory_item_id=cii0.inventory_item_id(+) and
msn0.serial_number=cii0.serial_number(+) and
cii0.last_vld_organization_id=msibk0.organization_id(+) and
cii0.inventory_item_id=msibk0.inventory_item_id(+) and
cii.equipment_gen_object_id=msn2.gen_object_id(+) and
cii.inventory_item_id=efs.inventory_item_id(+) and
case when cii.location_type_code in ('HZ_LOCATIONS','PO','WIP','PROJECT','IN_TRANSIT','HZ_PARTY_SITES','VENDOR_SITE') then cii.hl_location_id end=hl.location_id(+) and
case when cii.location_type_code in ('INVENTORY','INTERNAL_SITE') then cii.location_id end=hla.location_id(+)