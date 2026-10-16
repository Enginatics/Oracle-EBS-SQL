/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INL Landed Unit Cost Trend
-- Description: Unit landed cost per item over its landed cost shipments, broken down into item cost, charges and taxes, with the change against the item's previous shipment in the same organization.
-- Unit amounts are the current landed cost allocations in functional currency divided by the shipment line's primary quantity, Estimated Unit Landed Cost the first calculation. The previous shipment is taken from the shipments within the parameter selection.
-- Excel Example Output: https://www.enginatics.com/example/inl-landed-unit-cost-trend/
-- Library Link: https://www.enginatics.com/reports/inl-landed-unit-cost-trend/
-- Run Report: https://demo.enginatics.com/

select
y.*,
y.unit_landed_cost-y.previous_unit_landed_cost unit_landed_cost_change,
round(100*(y.unit_landed_cost-y.previous_unit_landed_cost)/nullif(y.previous_unit_landed_cost,0),2) unit_landed_cost_change_pct
from
(
select
haouv.name operating_unit,
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
ish.ship_date shipment_date,
ish.ship_num shipment_number,
isl.ship_line_num shipment_line,
aps.vendor_name supplier,
(select ftv.territory_short_name from fnd_territories_vl ftv where nvl(rsl.country_of_origin_code,plla.country_of_origin_code)=ftv.territory_code) country_of_origin,
pha.segment1 po_number,
pla.line_num po_line,
isl.primary_qty quantity,
isl.primary_uom_code uom,
pha.currency_code po_currency,
plla.price_override po_unit_price,
gl.currency_code,
z.item_current/nullif(isl.primary_qty,0) unit_item_cost,
z.charges_current/nullif(isl.primary_qty,0) unit_charges,
z.taxes_current/nullif(isl.primary_qty,0) unit_taxes,
(z.item_estimated+z.charges_estimated+z.taxes_estimated)/nullif(isl.primary_qty,0) estimated_unit_landed_cost,
(z.item_current+z.charges_current+z.taxes_current)/nullif(isl.primary_qty,0) unit_landed_cost,
lag((z.item_current+z.charges_current+z.taxes_current)/nullif(isl.primary_qty,0)) over (partition by ish.organization_id, isl.inventory_item_id order by ish.ship_date, ish.ship_num, isl.ship_line_num) previous_unit_landed_cost,
round(100*(z.charges_current+z.taxes_current)/nullif(z.item_current,0),2) landed_cost_uplift_percent,
z.item_current+z.charges_current+z.taxes_current landed_cost
from
(
select
ia.ship_header_id,
nvl(isl.parent_ship_line_id,isl.ship_line_id) ship_line_id,
sum(case when ia.adjustment_num=0 and ia.from_parent_table_name='INL_SHIP_LINES' then ia.allocation_amt else 0 end) item_estimated,
sum(case when ia.adjustment_num=0 and ia.from_parent_table_name='INL_CHARGE_LINES' then ia.allocation_amt else 0 end) charges_estimated,
sum(case when ia.adjustment_num=0 and ia.from_parent_table_name='INL_TAX_LINES' then ia.allocation_amt else 0 end) taxes_estimated,
sum(case when ia.adjustment_num=ish.adjustment_num and ia.from_parent_table_name='INL_SHIP_LINES' then ia.allocation_amt else 0 end) item_current,
sum(case when ia.adjustment_num=ish.adjustment_num and ia.from_parent_table_name='INL_CHARGE_LINES' then ia.allocation_amt else 0 end) charges_current,
sum(case when ia.adjustment_num=ish.adjustment_num and ia.from_parent_table_name='INL_TAX_LINES' then ia.allocation_amt else 0 end) taxes_current
from
inl_ship_headers_all ish,
inl_allocations ia,
inl_ship_lines_all isl
where
1=1 and
2=2 and
ish.simulation_id is null and
ish.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ish.ship_header_id=ia.ship_header_id and
ia.adjustment_num in (0,ish.adjustment_num) and
ia.landed_cost_flag='Y' and
ia.ship_line_id=isl.ship_line_id
group by
ia.ship_header_id,
nvl(isl.parent_ship_line_id,isl.ship_line_id)
) z,
inl_ship_headers_all ish,
inl_ship_lines_all isl,
inl_ship_line_groups islg,
hr_all_organization_units_vl haouv,
mtl_parameters mp,
org_organization_definitions ood,
gl_ledgers gl,
mtl_system_items_vl msiv,
ap_suppliers aps,
po_line_locations_all plla,
po_lines_all pla,
po_headers_all pha,
rcv_shipment_lines rsl
where
3=3 and
z.ship_header_id=ish.ship_header_id and
z.ship_line_id=isl.ship_line_id and
isl.ship_line_group_id=islg.ship_line_group_id and
ish.org_id=haouv.organization_id and
ish.organization_id=mp.organization_id and
ish.organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
isl.inventory_item_id=msiv.inventory_item_id and
ish.organization_id=msiv.organization_id and
islg.party_id=aps.party_id(+) and
decode(isl.ship_line_src_type_code,'PO',isl.ship_line_source_id)=plla.line_location_id(+) and
plla.po_line_id=pla.po_line_id(+) and
plla.po_header_id=pha.po_header_id(+) and
isl.ship_line_id=rsl.lcm_shipment_line_id(+)
) y
order by
y.operating_unit,
y.organization_code,
y.item,
y.shipment_date,
y.shipment_number,
y.shipment_line
