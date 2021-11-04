/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Cycle count entries and adjustments
-- Description: Imported Oracle standard Cycle count entries and adjustments report
Source: Cycle count entries and adjustments report (XML)
Short Name: INVARCTA_XML
DB package: INV_INVARCTA_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-cycle-count-entries-and-adjustments/
-- Library Link: https://www.enginatics.com/reports/inv-cycle-count-entries-and-adjustments/
-- Run Report: https://demo.enginatics.com/

select
mcce.organization_code,
mcce.organization_name,
mcce.currency_code,
mcce.cycle_count_header_name cycle_count_name,
mcce.subinventory subinventory,
msiv.concatenated_segments item_number,
msiv.description item_description,
inv_project.get_locator(mil.inventory_location_id,mil.organization_id) locator,
mil.description locator_description,
mcce.revision revision,
mac.abc_class_name abc_class_name,
mcce.current_date count_date,
substr(ml.meaning,1,9) count_type,
case when mcce.entry_status_code=5 then ml1.meaning else ml2.meaning end approved_flag,
mcce.count_quantity_first quantity,
mcce.uom,
mcce.pos_adjustment_quantity adjustments_quantity,
mcce.pos_adjustment_amount adjustments_amount,
mcce.number_of_counts,
mcce.cost_group,
mcce.outermost_license_plate_number,
mcce.parent_license_plate_number,
mcce.number_of_counts-mcce.completed_counter other_count,
mcce.pos_adj+abs(mcce.neg_adj) gross_adjustment_value,
mcce.pos_adj-abs(mcce.neg_adj) net_adjustment_value,
mcce.item_inv_value_current item_inventory_value,
case when ((mcce.pos_adj+abs(mcce.neg_adj)=0) and (mcce.item_inv_value_current=0)) then 100
else case when (mcce.item_inv_value_current=0) then 0.00 else case when (abs(mcce.pos_adj+abs(mcce.neg_adj))>abs(mcce.item_inv_value_current)) then 0.00 else 100-((abs(mcce.pos_adj+abs(mcce.neg_adj))/abs(mcce.item_inv_value_current))*100) end  end
end gross_accuracy_percentage,
case when ((mcce.item_inv_value_current=0) and (mcce.pos_adj-abs(mcce.neg_adj)=0)) then 100.00
else case when (mcce.item_inv_value_current=0) then 0.00 else case when (abs(mcce.pos_adj-abs(mcce.neg_adj))>abs(mcce.item_inv_value_current)) then 0.00 else round(100 - ((abs(mcce.pos_adj-abs(mcce.neg_adj))/abs(mcce.item_inv_value_current))*100),2) end end
end net_accuracy_percentage,
mcce.pos_adj positive_adjustment_values,
mcce.neg_adj negtaive_adjustment_values,
mcce.serials,
mcce.lot_number lot_number
from
mtl_item_locations mil,
mtl_cycle_count_items mcci,
mtl_abc_classes mac,
mfg_lookups ml,
mfg_lookups ml1,
mfg_lookups ml2,
mtl_system_items_vl msiv,
(select distinct
mcce.organization_id,
org.organization_name,
org.organization_code,
org.currency_code,
mcch.cycle_count_header_name,
mcce.inventory_item_id,
mcce.cycle_count_header_id,
mcce.count_type_code,
mcce.locator_id,
mcce.subinventory,
mif.item_number,
mcce.revision,
mcce.lot_number,
mcce.current_date,
mcce.entry_status_code,
mcce.completed_counter,
mcce.count_quantity_first_ count_quantity_first,
mif.primary_uom_code uom,
mcce.number_of_counts number_of_counts,
mcce.adjustment_quantity pos_adjustment_quantity,
mcce.adjustment_amount pos_adjustment_amount,
mcce.neg_adjustment_quantity,
mcce.neg_adjustment_amount,
case when(mcce.entry_status_code=5) and (mcce.count_type_code<>4) then 
round(
nvl(mcce.system_quantity_current,0)*
case when (mcce.count_uom_current is null) then 1
else (select mucv.conversion_rate from mtl_uom_conversions_view mucv where mucv.inventory_item_id=mcce.inventory_item_id and mucv.organization_id=org.organization_id and mucv.primary_uom_code=mif.primary_uom_code and mucv.uom_code=mcce.count_uom_current)
end*mcce.item_unit_cost_,
org.std_precision)
else 0
end item_inv_value_current,
case when (case when ((mcce.entry_status_code=5 or :p_approved=2) and (mcce.count_type_code<>4)) then
round(mcce.adjustment_quantity_current *
case when (mcce.count_uom_current is null) then 1
else (select mucv.conversion_rate from mtl_uom_conversions_view mucv where mucv.inventory_item_id=mcce.inventory_item_id and mucv.organization_id=org.organization_id and mucv.primary_uom_code=mif.primary_uom_code and mucv.uom_code=mcce.count_uom_current)
end *
mcce.item_unit_cost_, org.std_precision)
else 0
end) < 0 then
abs((case when ((mcce.entry_status_code=5 or :p_approved=2) and (mcce.count_type_code<>4)) then
round(mcce.adjustment_quantity_current *
case when (mcce.count_uom_current is null) then 1
else (select mucv.conversion_rate from mtl_uom_conversions_view mucv where mucv.inventory_item_id=mcce.inventory_item_id and mucv.organization_id=org.organization_id and mucv.primary_uom_code=mif.primary_uom_code and mucv.uom_code=mcce.count_uom_current)
end *
mcce.item_unit_cost_, org.std_precision)
else 0
end)) + nvl(mcce.neg_adjustment_amount,0)
else 0
end neg_adj,
case when (case when ((mcce.entry_status_code=5 or :p_approved=2) and (mcce.count_type_code<>4)) then
round(mcce.adjustment_quantity_current * case when (mcce.count_uom_current is null) then 1 else (select mucv.conversion_rate from mtl_uom_conversions_view mucv where mucv.inventory_item_id=mcce.inventory_item_id and mucv.organization_id=org.organization_id and mucv.primary_uom_code=mif.primary_uom_code and mucv.uom_code=mcce.count_uom_current) end *
mcce.item_unit_cost_, org.std_precision) else 0 end) > 0 then
(case when ((mcce.entry_status_code=5 or :p_approved=2) and (mcce.count_type_code<>4)) then
round(mcce.adjustment_quantity_current * case when (mcce.count_uom_current is null) then 1 else (select mucv.conversion_rate from mtl_uom_conversions_view mucv where mucv.inventory_item_id=mcce.inventory_item_id and mucv.organization_id=org.organization_id and mucv.primary_uom_code=mif.primary_uom_code and mucv.uom_code=mcce.count_uom_current)
end * mcce.item_unit_cost_, org.std_precision)
else 0 end)
else 0 
end pos_adj,
case when ((mcce.entry_status_code=5 or :p_approved=2) and (mcce.count_type_code<>4)) then
round(mcce.adjustment_quantity_current * case when (mcce.count_uom_current is null) then 1 else (select mucv.conversion_rate from mtl_uom_conversions_view mucv where mucv.inventory_item_id=mcce.inventory_item_id and mucv.organization_id=org.organization_id and mucv.primary_uom_code=mif.primary_uom_code and mucv.uom_code=mcce.count_uom_current)
end * mcce.item_unit_cost_, org.std_precision)
else 0 end adjustment_amount,
wlpn1.license_plate_number outermost_license_plate_number,
wlpn2.license_plate_number parent_license_plate_number,
org.std_precision,
ccg.cost_group cost_group,
(select distinct 
listagg(mcsn.serial_number,', ') within group (order by mcsn.cycle_count_entry_id) 
from 
mtl_cc_serial_numbers mcsn
where
mcce.cycle_count_entry_id=mcsn.cycle_count_entry_id
) serials
from
mtl_item_flexfields mif,
(select
decode (mcce.count_type_code, 4,0, decode(mcce.entry_status_code, 5,1,0) ) completed_counter,
nvl(mcce.item_unit_cost,0) item_unit_cost_,
round(nvl(mcce.count_quantity_first,0), :p_qty_precision) count_quantity_first_,
round (nvl( mcce.adjustment_quantity,0), :p_qty_precision) adjustment_quantity_current,
decode(mcce.entry_status_code, 5, mcce.approval_date,mcce.count_date_current) current_date,
(
select
ml.meaning
from
mfg_lookups ml
where
ml.lookup_type='SYS_YES_NO' and
ml.lookup_code=(case when nvl(mcce.serial_detail,0)>0 then 1 else 2 end)) serialized_item_included,
mcce.*
from
mtl_cycle_count_entries mcce) mcce,
cst_cost_groups ccg,
(select
ood.organization_id,
ood.organization_name,
ood.organization_code,
gl.currency_code,
first_value(fc.precision) over() std_precision
from
org_organization_definitions ood,
gl_ledgers gl,
fnd_currencies fc
where
1=1 and
ood.set_of_books_id=gl.ledger_id and
fc.currency_code=gl.currency_code
) org,
mtl_cycle_count_headers mcch,
wms_license_plate_numbers wlpn1,
wms_license_plate_numbers wlpn2
where
mcce.organization_id=org.organization_id and
mif.organization_id=org.organization_id and
mcce.inventory_item_id=mif.item_id and
2=2 and
mcce.entry_status_code<>1 and
mcch.cycle_count_header_id=mcce.cycle_count_header_id and
nvl(mcch.disable_date,sysdate+1)>sysdate and
mcce.entry_status_code = decode(:p_approved,1,5,mcce.entry_status_code) and
mcce.cost_group_id=ccg.cost_group_id(+) and
mcce.outermost_lpn_id=wlpn1.lpn_id(+) and
mcce.parent_lpn_id=wlpn2.lpn_id(+)
) mcce
where
mcce.locator_id=mil.inventory_location_id(+) and
mcce.organization_id=mil.organization_id(+) and
msiv.inventory_item_id=mcce.inventory_item_id and
msiv.organization_id=mcce.organization_id and
ml.lookup_type='MTL_CC_COUNT_TYPES' and
ml.lookup_code=mcce.count_type_code and
mcci.cycle_count_header_id=mcce.cycle_count_header_id and
mcci.inventory_item_id=mcce.inventory_item_id and
mcci.abc_class_id=mac.abc_class_id and
ml1.lookup_type='SYS_YES_NO' and
ml1.lookup_code=1 and
ml2.lookup_type='SYS_YES_NO' and
ml2.lookup_code=2 
order by
mcce.subinventory,
item_number,
count_date desc