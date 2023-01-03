/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Cycle count listing
-- Description: Imported Oracle standard cycle count listing report
Source: Cycle count listing (XML)
Short Name: INVARCLI_XML
DB package: INV_INVARCLI_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-cycle-count-listing/
-- Library Link: https://www.enginatics.com/reports/inv-cycle-count-listing/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
ood.organization_name,
gl.currency_code,
mcch.cycle_count_header_name cycle_count_name,
mcce.subinventory subinventory,
mcce.count_list_sequence sequence,
msiv.concatenated_segments item,
msiv.description description,
inv_project.get_locator(mcce.locator_id,mcce.organization_id) locator,
mcce.revision revision,
mcce.lot_number lot_number,
mac.abc_class_name,
mcce.count_due_date due_date,
msiv.primary_uom_code uom,
mfg.meaning status,
case 
when (msiv.serial_number_control_code in (1,6) or mcch.serial_count_option=1) then
(select 
nvl(sum(moqd.primary_transaction_quantity),0) 
from
mtl_onhand_quantities_detail moqd
where
moqd.inventory_item_id=mcce.inventory_item_id and
moqd.organization_id=ood.organization_id and
moqd.subinventory_code=mcce.subinventory and
nvl(moqd.lot_number,'XX')=nvl(mcce.lot_number,'XX') and
nvl(moqd.revision,'XXX')=nvl(mcce.revision,'XXX') and
nvl(moqd.locator_id,-2)=nvl(mcce.locator_id,-2) and
nvl(moqd.lpn_id,-3)=nvl(mcce.parent_lpn_id,-3))
when (msiv.serial_number_control_code in (2,5) and mcch.serial_count_option>1) then 
(select
nvl(sum(decode(msn.current_status,3,1,0)),0)
from
mtl_serial_numbers msn
where
msn.serial_number=nvl(mcce.serial_number,msn.serial_number) and
msn.inventory_item_id=mcce.inventory_item_id and
msn.current_organization_id=ood.organization_id and
msn.current_subinventory_code=mcce.subinventory and
nvl(msn.lot_number,'XX')=nvl(mcce.lot_number,'XX') and
nvl(msn.revision,'XXX')=nvl(mcce.revision,'XXX') and
nvl(msn.current_locator_id,-2)=nvl(mcce.locator_id,-2) and
nvl(msn.lpn_id,-3)=nvl(mcce.parent_lpn_id,-3))
end system_quantity,
case when (nvl(mcch.container_enabled_flag,-99)>0) then wlpn1.license_plate_number end outermost_license_plate_number,
case when (nvl(mcch.container_enabled_flag,-99)>0) then wlpn2.license_plate_number end parent_license_plate_number,
ccg.cost_group cost_group,
(select distinct 
listagg(mcsn.serial_number,', ') within group (order by mcsn.cycle_count_entry_id) 
from 
mtl_cc_serial_numbers mcsn
where
mcsn.cycle_count_entry_id=mcce.cycle_count_entry_id
) serial_numbers
from 
mfg_lookups mfg,
mtl_abc_classes mac,
mtl_system_items_vl msiv, 
mtl_cycle_count_headers mcch,
mtl_cycle_count_items mcci,
mtl_cycle_count_entries mcce,
org_organization_definitions ood,
gl_ledgers gl,
cst_cost_groups ccg,
wms_license_plate_numbers wlpn1,
wms_license_plate_numbers wlpn2
where
msiv.organization_id=ood.organization_id and
1=1 and
ood.set_of_books_id=gl.ledger_id and
mcch.organization_id=ood.organization_id and
nvl(mcch.disable_date,sysdate+1)>sysdate and
mcce.organization_id=ood.organization_id and
mac.organization_id=ood.organization_id and
mcce.inventory_item_id=mcci.inventory_item_id and
mcci.abc_class_id=mac.abc_class_id and
mcce.cycle_count_header_id=mcci.cycle_count_header_id and
mcce.cycle_count_header_id=mcch.cycle_count_header_id and
msiv.inventory_item_id=mcce.inventory_item_id and
mfg.lookup_type='MTL_CC_ENTRY_STATUSES' and
mfg.lookup_code=mcce.entry_status_code and
mcce.cost_group_id=ccg.cost_group_id(+) and
mcce.outermost_lpn_id=wlpn1.lpn_id(+) and
mcce.parent_lpn_id=wlpn2.lpn_id(+)
order by
mcce.count_list_sequence,
mcce.subinventory,
msiv.concatenated_segments,
mcce.revision