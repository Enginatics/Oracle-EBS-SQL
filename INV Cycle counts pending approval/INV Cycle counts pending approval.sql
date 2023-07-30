/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Cycle counts pending approval
-- Description: Imported Oracle standard Cycle counts pending approval report
Source: Cycle counts pending approval report (XML)
Short Name: INVARCPA_XML
DB package: INV_INVARCPA_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-cycle-counts-pending-approval/
-- Library Link: https://www.enginatics.com/reports/inv-cycle-counts-pending-approval/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
ood.organization_name,
gl.currency_code,
mcch.cycle_count_header_name cycle_count_name,
mcce.subinventory,
msiv.concatenated_segments item_number,
msiv.description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
inv_project.get_locator(mil.inventory_location_id,mil.organization_id) locator,
mil.description locator_description,
mcce.count_date_current,
mcce.revision,
mcce.lot_number,
mac.abc_class_name,
mcce.adjustment_date,
round( mcce.adjustment_quantity, :p_qty_precision) adjustment_quantity,
round(nvl(mcce.adjustment_quantity,0)*nvl(mcce.item_unit_cost,0),gl.std_precision) adjustment_amount,
round( mcce.count_quantity_current, :p_qty_precision) count_quantity_current,
round( mcce.neg_adjustment_quantity, :p_qty_precision) negative_adjustment_quantity,
round(nvl(mcce.neg_adjustment_quantity,0)*nvl(mcce.item_unit_cost,0),gl.std_precision) negative_adjustment_amount,
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
mtl_item_locations mil,
mtl_system_items_vl msiv,
mtl_cycle_count_headers mcch,
mtl_cycle_count_items mcci,
mtl_cycle_count_entries mcce,
mtl_abc_classes mac,
org_organization_definitions ood,
(select 
gl.ledger_id,
gl.currency_code,
first_value(fc.precision) over() std_precision
from 
gl_ledgers gl,
fnd_currencies fc
where
fc.currency_code=gl.currency_code
) gl,
cst_cost_groups ccg,
wms_license_plate_numbers wlpn1,
wms_license_plate_numbers wlpn2
where
1=1 and
msiv.organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
mcch.organization_id=ood.organization_id and
nvl(mcch.disable_date,sysdate+1)>sysdate and
mcch.organization_id=mcce.organization_id and
mac.organization_id=mcch.organization_id and
mcce.locator_id=mil.inventory_location_id(+) and
mcce.organization_id=mil.organization_id(+) and
mcce.cycle_count_header_id=mcch.cycle_count_header_id and
mcce.entry_status_code=2 and
msiv.inventory_item_id=mcce.inventory_item_id and
mcci.abc_class_id=mac.abc_class_id and
mcci.cycle_count_header_id=mcch.cycle_count_header_id and
mcci.inventory_item_id=mcce.inventory_item_id and
mcce.cost_group_id=ccg.cost_group_id(+) and
mcce.outermost_lpn_id=wlpn1.lpn_id(+) and
mcce.parent_lpn_id=wlpn2.lpn_id(+) 
order by
ood.organization_name,
mcce.subinventory,
mcch.cycle_count_header_name,
decode(:p_sort_option,1,msiv.concatenated_segments,(mil.segment1||'\n'||mil.segment2||'\n'||mil.segment3||'\n'||mil.segment4||'\n'||mil.segment5||'\n'||mil.segment6||'\n'||mil.segment7||'\n'||mil.segment8||'\n'||mil.segment9||'\n'||mil.segment10||'\n'||mil.segment11||'\n'||mil.segment12||'\n'||mil.segment13||'\n'||mil.segment14||'\n'||mil.segment15||'\n')),
decode(:p_sort_option,1,(mil.segment1||'\n'||mil.segment2||'\n'||mil.segment3||'\n'||mil.segment4||'\n'||mil.segment5||'\n'||mil.segment6||'\n'||mil.segment7||'\n'||mil.segment8||'\n'||mil.segment9||'\n'||mil.segment10||'\n'||mil.segment11||'\n'||mil.segment12||'\n'||mil.segment13||'\n'||mil.segment14||'\n'||mil.segment15||'\n'),msiv.concatenated_segments)