/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Cycle count open requests listing
-- Description: Imported Oracle standard Cycle count open requests listing report
Source: Cycle count open requests listing (XML)
Short Name: INVARORE_XML
DB package: INV_INVARORE_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-cycle-count-open-requests-listing/
-- Library Link: https://www.enginatics.com/reports/inv-cycle-count-open-requests-listing/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
ood.organization_name,
gl.currency_code,
mcch.cycle_count_header_name cycle_count_name,
mcce.subinventory subinventory,
mif.item_number schedule_item,
mif.description description,
xxen_util.meaning(mif.item_type,'ITEM_TYPE',3) user_item_type,
mcce.revision revision,
mcce.lot_number lot_number,
mac.abc_class_name abc_class_name, 
nvl(inv_project.get_locator(milk.inventory_location_id,milk.organization_id),milk.concatenated_segments) locator,
milk.description locator_description,  
mcce.creation_date request_date,
mcce.count_due_date due_date, 
ml2.meaning count_type,
ml1.meaning status,
decode (mcce.entry_status_code,3, 'N',decode(greatest (mcce.count_due_date, sysdate ),sysdate, 'Yes','No' )) over_due_flag,
wlpn1.license_plate_number outermost_license_plate_number,
wlpn2.license_plate_number parent_license_plate_number,
ccg.cost_group cost_group,
(select distinct 
listagg(mcsn.serial_number,', ') within group (order by mcsn.cycle_count_entry_id) 
from 
mtl_cc_serial_numbers mcsn
where
mcsn.cycle_count_entry_id=mcce.cycle_count_entry_id
) serial_numbers
from 
mfg_lookups ml1,
mfg_lookups ml2,
mtl_item_locations_kfv milk,
mtl_item_flexfields mif,
mtl_cycle_count_headers mcch,
mtl_cycle_count_items mcci,
mtl_cycle_count_entries mcce,
mtl_abc_classes mac,
org_organization_definitions ood,
gl_ledgers gl,
cst_cost_groups ccg,
wms_license_plate_numbers wlpn1,
wms_license_plate_numbers wlpn2
where
1=1 and
ood.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mif.organization_id=ood.organization_id and
mcch.organization_id=ood.organization_id and
mcce.organization_id=ood.organization_id and
mac.organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
mcce.locator_id=milk.inventory_location_id(+) and
mcce.organization_id=milk.organization_id(+) and
mcce.cycle_count_header_id=mcch.cycle_count_header_id and
nvl(mcch.disable_date,sysdate+1)>sysdate and
mif.item_id=mcce.inventory_item_id and
mcci.abc_class_id= mac.abc_class_id and
mcce.cycle_count_header_id=mcci.cycle_count_header_id(+) and
mcce.inventory_item_id=mcci.inventory_item_id (+) and
ml1.lookup_type='MTL_CC_ENTRY_STATUSES' and
ml1.lookup_code=mcce.entry_status_code and
ml2.lookup_type='MTL_CC_COUNT_TYPES' and
ml2.lookup_code = mcce.count_type_code and
mcce.cost_group_id=ccg.cost_group_id(+) and
mcce.outermost_lpn_id=wlpn1.lpn_id(+) and
mcce.parent_lpn_id=wlpn2.lpn_id(+)
order by 
mcce.subinventory,
mif.item_number,
mcce.revision,
mcce.creation_date