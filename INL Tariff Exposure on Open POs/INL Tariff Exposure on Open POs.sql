/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INL Tariff Exposure on Open POs
-- Description: Open quantity of approved PO shipments enabled for Landed Cost Management, with simulated and historical duty, to project the tariff cost of goods not received yet.
-- Simulated Duty comes from the purchase order's latest landed cost simulation, scaled to the open quantity. Historical Duty Rate is the duty to item value ratio of the shipments of the same item, organization and country of origin since History Date From. Projected Duty is the simulated duty, else the open value at the historical rate.
-- Additional Tariff Percent applies a what-if tariff to the open value, for example a newly announced rate for one country of origin. Amounts are in functional currency at the PO exchange rate.
-- Excel Example Output: https://www.enginatics.com/example/inl-tariff-exposure-on-open-pos/
-- Library Link: https://www.enginatics.com/reports/inl-tariff-exposure-on-open-pos/
-- Run Report: https://demo.enginatics.com/

select
y.*,
nvl(y.projected_duty,0)+nvl(y.additional_tariff,0) total_projected_duty,
y.open_value+nvl(y.projected_duty,0)+nvl(y.additional_tariff,0)+nvl(y.simulated_other_charges,0) projected_landed_cost
from
(
select
x.*,
coalesce(x.simulated_duty,x.open_value*x.historical_duty_rate_percent/100) projected_duty,
x.open_value*:additional_tariff_percent/100 additional_tariff
from
(
select
haouv.name operating_unit,
mp.organization_code,
aps.vendor_name supplier,
pha.segment1 po_number,
pla.line_num po_line,
plla.shipment_num po_shipment,
nvl(plla.promised_date,plla.need_by_date) promised_date,
msiv.concatenated_segments item,
msiv.description item_description,
ftv.territory_short_name country_of_origin,
(
select
max(mck.concatenated_segments)
from
mtl_category_sets_vl mcsv,
mtl_item_categories mic,
mtl_categories_kfv mck
where
mcsv.category_set_name=:tariff_code_category_set and
mcsv.category_set_id=mic.category_set_id and
pla.item_id=mic.inventory_item_id and
plla.ship_to_organization_id=mic.organization_id and
mic.category_id=mck.category_id
) tariff_code,
plla.quantity-nvl(plla.quantity_received,0)-nvl(plla.quantity_cancelled,0) open_quantity,
pla.unit_meas_lookup_code uom,
pha.currency_code po_currency,
plla.price_override unit_price,
gl.currency_code,
(plla.quantity-nvl(plla.quantity_received,0)-nvl(plla.quantity_cancelled,0))*plla.price_override*nvl(pha.rate,1) open_value,
s.simulation_date,
s.duty_per_unit*(plla.quantity-nvl(plla.quantity_received,0)-nvl(plla.quantity_cancelled,0)) simulated_duty,
s.other_charges_per_unit*(plla.quantity-nvl(plla.quantity_received,0)-nvl(plla.quantity_cancelled,0)) simulated_other_charges,
round(100*s.duty_per_unit/nullif(s.item_value_per_unit,0),2) simulated_duty_rate_percent,
round(100*h.duty/nullif(h.item_value,0),2) historical_duty_rate_percent,
h.shipment_count historical_shipments
from
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
hr_all_organization_units_vl haouv,
mtl_parameters mp,
org_organization_definitions ood,
gl_ledgers gl,
mtl_system_items_vl msiv,
ap_suppliers aps,
fnd_territories_vl ftv,
(
select
isl.ship_line_source_id line_location_id,
max(isim.creation_date) simulation_date,
sum(case when ia.from_parent_table_name='INL_SHIP_LINES' then ia.allocation_amt end)/nullif(max(isl.primary_qty),0) item_value_per_unit,
sum(case when ia.from_parent_table_name='INL_CHARGE_LINES' and 4=4 then ia.allocation_amt end)/nullif(max(isl.primary_qty),0) duty_per_unit,
nvl(sum(case when ia.from_parent_table_name<>'INL_SHIP_LINES' then ia.allocation_amt end),0)/nullif(max(isl.primary_qty),0)-nvl(sum(case when ia.from_parent_table_name='INL_CHARGE_LINES' and 4=4 then ia.allocation_amt end),0)/nullif(max(isl.primary_qty),0) other_charges_per_unit
from
(
select
isim.*,
max(isim.version_num) over (partition by isim.parent_table_name, isim.parent_table_id) max_version_num
from
inl_simulations isim
where
isim.parent_table_name='PO_HEADERS'
) isim,
inl_ship_headers_all ish,
inl_ship_lines_all isl,
inl_allocations ia,
inl_charge_lines icl,
pon_cost_factors_vl pcfv
where
isim.version_num=isim.max_version_num and
isim.simulation_id=ish.simulation_id and
ish.ship_header_id=isl.ship_header_id and
isl.ship_line_src_type_code='PO' and
isl.parent_ship_line_id is null and
isl.ship_header_id=ia.ship_header_id and
isl.ship_line_id=ia.ship_line_id and
ia.adjustment_num=ish.adjustment_num and
ia.landed_cost_flag='Y' and
decode(ia.from_parent_table_name,'INL_CHARGE_LINES',ia.from_parent_table_id)=icl.charge_line_id(+) and
icl.charge_line_type_id=pcfv.price_element_type_id(+)
group by
isl.ship_line_source_id
) s,
(
select
plla.line_location_id,
y.shipment_count,
y.item_value,
y.duty
from
po_line_locations_all plla,
po_lines_all pla,
(
select
ish.organization_id,
isl.inventory_item_id,
nvl(rsl.country_of_origin_code,plla.country_of_origin_code) country_of_origin_code,
count(distinct ish.ship_header_id) shipment_count,
sum(case when ia.from_parent_table_name='INL_SHIP_LINES' then ia.allocation_amt end) item_value,
sum(case when ia.from_parent_table_name='INL_CHARGE_LINES' and 4=4 then ia.allocation_amt end) duty
from
inl_ship_headers_all ish,
inl_allocations ia,
inl_ship_lines_all isl,
inl_ship_lines_all isl0,
po_line_locations_all plla,
rcv_shipment_lines rsl,
inl_charge_lines icl,
pon_cost_factors_vl pcfv
where
ish.simulation_id is null and
ish.ship_date>=:history_date_from and
ish.ship_header_id=ia.ship_header_id and
ia.adjustment_num=ish.adjustment_num and
ia.landed_cost_flag='Y' and
ia.ship_line_id=isl.ship_line_id and
nvl(isl.parent_ship_line_id,isl.ship_line_id)=isl0.ship_line_id and
decode(isl0.ship_line_src_type_code,'PO',isl0.ship_line_source_id)=plla.line_location_id(+) and
isl0.ship_line_id=rsl.lcm_shipment_line_id(+) and
decode(ia.from_parent_table_name,'INL_CHARGE_LINES',ia.from_parent_table_id)=icl.charge_line_id(+) and
icl.charge_line_type_id=pcfv.price_element_type_id(+)
group by
ish.organization_id,
isl.inventory_item_id,
nvl(rsl.country_of_origin_code,plla.country_of_origin_code)
) y
where
plla.lcm_flag='Y' and
plla.quantity-nvl(plla.quantity_received,0)-nvl(plla.quantity_cancelled,0)>0 and
plla.po_line_id=pla.po_line_id and
plla.ship_to_organization_id=y.organization_id and
pla.item_id=y.inventory_item_id and
plla.country_of_origin_code=y.country_of_origin_code
) h
where
1=1 and
plla.lcm_flag='Y' and
plla.shipment_type in ('STANDARD','BLANKET','SCHEDULED') and
pha.authorization_status='APPROVED' and
nvl(plla.cancel_flag,'N')='N' and
nvl(plla.closed_code,'OPEN') in ('OPEN','CLOSED FOR INVOICE') and
plla.quantity-nvl(plla.quantity_received,0)-nvl(plla.quantity_cancelled,0)>0 and
plla.ship_to_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
pha.po_header_id=pla.po_header_id and
pla.po_line_id=plla.po_line_id and
pha.org_id=haouv.organization_id and
plla.ship_to_organization_id=mp.organization_id and
plla.ship_to_organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
pla.item_id=msiv.inventory_item_id and
plla.ship_to_organization_id=msiv.organization_id and
pha.vendor_id=aps.vendor_id and
plla.country_of_origin_code=ftv.territory_code(+) and
plla.line_location_id=s.line_location_id(+) and
plla.line_location_id=h.line_location_id(+)
) x
) y
where
5=5
order by
y.operating_unit,
y.organization_code,
y.supplier,
y.po_number,
y.po_line,
y.po_shipment
