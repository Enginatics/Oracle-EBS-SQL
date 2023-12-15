/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Cycle count hit/miss analysis
-- Description: Imported Oracle standard Cycle count hit/miss analysis report
Source: Cycle count hit/miss analysis (XML)
Short Name: INVARHMA_XML
DB package: INV_INVARHMA_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-cycle-count-hit-miss-analysis/
-- Library Link: https://www.enginatics.com/reports/inv-cycle-count-hit-miss-analysis/
-- Run Report: https://demo.enginatics.com/

select
mcch.organization_code,
mcch.organization_name,
mcch.currency_code,
mcch.cycle_count_header_name cycle_count_name,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
nvl(inv_project.get_locator(milk.inventory_location_id,milk.organization_id),milk.concatenated_segments) locator,
milk.description locator_description,
mcce.count_date_first,
mcce.count_date_prior,
mcce.count_date_current,
(
select
ml.meaning
from
mfg_lookups ml
where
ml.lookup_type='SYS_YES_NO' and
ml.lookup_code=(case when nvl(mcce.serial_detail,0)>0 then 1 else 2 end)) serialized_item_included,
mcce.subinventory subinventory,
mac.abc_class_name class,
nvl(mccc.hit_miss_tolerance_positive, mcch.hit_miss_tolerance_positive)  hit_miss_tolerance_positive,
nvl(mccc.hit_miss_tolerance_negative, mcch.hit_miss_tolerance_negative) hit_miss_tolerance_negative,
100*( 1 - 
case 
when mcce.serial_detail=2 and mcce.serial_number is not null then
case when (mcce.adj_quantity=0) or (mcce.adj_quantity is null) then 0 else 1 end
else 
case 
when(mcce.adj_quantity=0) or (mcce.adj_quantity is null) then 0
when (mcce.adj_quantity<0) then case when (abs(mcce.adj_quantity)>=(mcce.system_quantity_first*nvl(mccc.hit_miss_tolerance_negative, mcch.hit_miss_tolerance_negative)/100)) then 1 else 0 end
else case when (abs((mcce.count_quantity_first - mcce.system_quantity_first ))>=(mcce.system_quantity_first*nvl(mccc.hit_miss_tolerance_positive, mcch.hit_miss_tolerance_positive)/100)) then 1 else 0 end
end
end) accuracy_percent,
mcce.system_quantity_first  system_quantity,
mcce.adj_quantity adjusted_quantity,
case when mcce.serial_detail=2 and mcce.serial_number is not null then
case when (mcce.adj_quantity=0) or (mcce.adj_quantity is null) then 0 else 1 end
else
case when (mcce.adj_quantity = 0) or (mcce.adj_quantity is null) then 0  
when (mcce.adj_quantity<0) then case when abs(mcce.adj_quantity)>=(mcce.system_quantity_first * nvl(mccc.hit_miss_tolerance_negative, mcch.hit_miss_tolerance_negative)/100) then 1 else 0 end
else case when abs(mcce.adj_quantity)>=(mcce.system_quantity_first * nvl(mccc.hit_miss_tolerance_positive, mcch.hit_miss_tolerance_positive)/100) then 1 else 0 end
end
end out_tolerance_flag
from 
mtl_abc_classes mac,
mtl_cycle_count_classes mccc,
mtl_item_locations_kfv milk,
mtl_system_items_vl msiv,
(
select 
ood.organization_name,
ood.organization_code,
gl.currency_code,
mcch.*
from
org_organization_definitions ood,
gl_ledgers gl,
mtl_cycle_count_headers mcch
where
1=1 and
ood.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.set_of_books_id=gl.ledger_id and
nvl(mcch.disable_date,sysdate+1)>sysdate and
mcch.organization_id=ood.organization_id) mcch,
mtl_cycle_count_items mcci,
(select
mcce.*,
(mcce.count_quantity_first-mcce.system_quantity_first) adj_quantity
from
mtl_cycle_count_entries mcce
) mcce
where
2=2 and
mcch.cycle_count_header_id=mcci.cycle_count_header_id and
mcch.cycle_count_header_id=mcce.cycle_count_header_id and
mcch.cycle_count_header_id=mccc.cycle_count_header_id and
mcce.inventory_item_id=mcci.inventory_item_id and
msiv.inventory_item_id=mcce.inventory_item_id and
msiv.organization_id=mcce.organization_id and
mcce.locator_id=milk.inventory_location_id(+) and
mcce.organization_id=milk.organization_id(+) and
mcci.abc_class_id=mac.abc_class_id and
mcci.abc_class_id=mccc.abc_class_id and
(mcce.entry_status_code=5 or mcce.entry_status_code=2 or mcce.entry_status_code=3) and
mcce.count_type_code<>4
order by 
mcce.subinventory,
mac.abc_class_name