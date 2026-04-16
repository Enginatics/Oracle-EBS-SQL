/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WSH Commercial Invoice
-- Description: Shipping commercial invoice report showing delivery details including shipped items, quantities, unit costs, extended costs, ship-from/ship-to addresses, freight information, and bill of lading details.
Blitz version of the Oracle standard Commercial Invoice (XML) concurrent program WSHRDINV_XML.
DB package: WSH_WSHRDINV_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/wsh-commercial-invoice/
-- Library Link: https://www.enginatics.com/reports/wsh-commercial-invoice/
-- Run Report: https://demo.enginatics.com/

select
wnd.delivery_id,
wnd.initial_pickup_date ship_date,
nvl(wnd.currency_code,wdd.currency_code) currency_code,
(
select
wcs.ship_method_meaning
from
wsh_carrier_services wcs
where
wcs.ship_method_code=wnd.ship_method_code
) ship_method,
wnd.gross_weight,
wnd.weight_uom_code,
(
select
count(*)
from
wsh_delivery_assignments_v wda0,
wsh_delivery_details wdd0
where
wdd0.delivery_detail_id=wda0.delivery_detail_id and
wdd0.container_flag='Y' and
wda0.parent_delivery_detail_id is null and
wda0.delivery_id is not null and
wda0.delivery_id=wnd.delivery_id
) number_of_boxes,
wnd.port_of_loading,
wnd.port_of_discharge,
wnd.waybill,
(
select
listagg(wbrdv.bill_of_lading_number,', ') within group (order by wbrdv.bill_of_lading_number)
from
wsh_bols_rd_v wbrdv
where
wbrdv.delivery_id=wnd.delivery_id
) bill_of_lading,
terr_from.territory_short_name from_country,
loc.address1 from_address1,
loc.address2 from_address2,
loc.address3 from_address3,
loc.address4 from_address4,
loc.city||', '||nvl(nvl(loc.state,loc.province),loc.county)||' '||loc.postal_code from_city_state,
case when nvl(wdd.consignee_flag,'C')='V' then
(
select
hp.party_name
from
hz_party_site_uses hpsu,
hz_party_sites hps,
hz_parties hp
where
hpsu.party_site_use_id=wdd.ship_to_site_use_id and
hpsu.site_use_type='PURCHASING' and
hps.party_site_id=hpsu.party_site_id and
hp.party_id=hps.party_id
)
else
(
select
hp.party_name
from
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
hz_parties hp
where
hcsua.site_use_id=wdd.ship_to_site_use_id and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id and
hcasa.party_site_id=hps.party_site_id and
hp.party_id=hps.party_id
)
end ship_to_customer,
terr_to.territory_short_name to_country,
loc1.address1 to_address1,
loc1.address2 to_address2,
loc1.address3 to_address3,
loc1.address4 to_address4,
loc1.city||', '||nvl(nvl(loc1.province,loc1.state),loc1.county)||' '||loc1.postal_code to_city_state,
(
select
hp.party_name
from
hz_cust_account_roles hcar,
hz_relationships hr,
hz_parties hp
where
hcar.cust_account_role_id=wdd.ship_to_contact_id and
hcar.party_id=hr.party_id and
hcar.role_type='CONTACT' and
hr.subject_table_name='HZ_PARTIES' and
hr.object_table_name='HZ_PARTIES' and
hr.directional_flag='F' and
hr.subject_id=hp.party_id
) ship_to_contact,
wdd.cust_po_number,
decode(wms_deploy.wms_deployment_mode,'D',wdd.source_header_number,nvl(wdd.reference_number,wdd.source_header_number)) order_number,
mc.description category,
coalesce(
(
select
msiv.description
from
mtl_system_items_vl msiv
where
msiv.inventory_item_id=wdd.inventory_item_id and
msiv.organization_id=wdd.organization_id
),
wdd.item_description
) item_description,
(
select
msiv.concatenated_segments
from
mtl_system_items_vl msiv
where
msiv.inventory_item_id=wdd.inventory_item_id and
msiv.organization_id=wdd.organization_id
) item,
(
select
listagg(mck.concatenated_segments,', ') within group (order by mck.category_id)
from
mtl_categories_kfv mck,
mtl_item_categories mic0,
mtl_category_sets_vl mcsv
where
mic0.inventory_item_id=wdd.inventory_item_id and
mic0.organization_id=wdd.organization_id and
mic0.category_set_id=mcsv.category_set_id and
mck.category_id=mic0.category_id and
mcsv.category_set_name='WSH_COMMODITY_CODE'
) commodity_class,
sum(nvl(wdd.shipped_quantity,wdd.requested_quantity)) shipped_quantity,
wdd.requested_quantity_uom unit_of_measure,
wdd.requested_quantity2 secondary_quantity,
wdd.requested_quantity_uom2 secondary_uom,
round(
case wdd.source_code
when 'OE' then (select oola.unit_selling_price from oe_order_lines_all oola where oola.line_id=wdd.source_line_id)
when 'OKE' then (select okdb.unit_price from oke_k_deliverables_b okdb where okdb.deliverable_id=wdd.source_line_id)
else (select wdd2.unit_price from wsh_delivery_details wdd2 where wdd2.source_line_id=wdd.source_line_id and wdd2.source_code=wdd.source_code and rownum=1)
end
*wsh_wv_utils.convert_uom(wdd.requested_quantity_uom,wdd.src_requested_quantity_uom,1,wdd.inventory_item_id)
,2) unit_cost,
round(
sum(
case wdd.source_code
when 'OE' then (select oola.unit_selling_price from oe_order_lines_all oola where oola.line_id=wdd.source_line_id)
when 'OKE' then (select okdb.unit_price from oke_k_deliverables_b okdb where okdb.deliverable_id=wdd.source_line_id)
else (select wdd2.unit_price from wsh_delivery_details wdd2 where wdd2.source_line_id=wdd.source_line_id and wdd2.source_code=wdd.source_code and rownum=1)
end
*wsh_wv_utils.convert_uom(wdd.requested_quantity_uom,wdd.src_requested_quantity_uom,nvl(wdd.shipped_quantity,wdd.requested_quantity),wdd.inventory_item_id)
)
,2) extended_cost,
(
select
sum(wfc.unit_amount)
from
wsh_freight_costs wfc,
wsh_freight_cost_types wfct
where
wfc.freight_cost_type_id=wfct.freight_cost_type_id and
wfc.delivery_detail_id is null and
(wfct.name='SUMMARY' and wfct.freight_cost_type_code='FTESUMMARY' or wfc.charge_source_code<>'PRICING_ENGINE') and
wfc.delivery_id=wnd.delivery_id
) total_freight_cost,
wdd.delivery_detail_id,
wdd.source_code,
wdd.source_line_id,
wdd.source_header_id,
ood.organization_name warehouse
&dff_columns
from
wsh_new_deliveries wnd,
wsh_delivery_assignments_v wda,
wsh_delivery_details wdd,
wsh_locations loc,
wsh_locations loc1,
mtl_categories mc,
mtl_item_categories mic,
mtl_default_category_sets mdc,
fnd_territories_tl terr_from,
fnd_territories_tl terr_to,
org_organization_definitions ood
where
1=1 and
wnd.delivery_id=wda.delivery_id and
nvl(wnd.shipment_direction,'O') in ('O','IO') and
wnd.delivery_type='STANDARD' and
(wdd.requested_quantity>0 or wdd.released_status<>'D') and
wdd.container_flag in ('N','Y') and
wdd.delivery_detail_id=wda.delivery_detail_id and
wda.delivery_id is not null and
wdd.ship_from_location_id=loc.wsh_location_id and
wdd.ship_to_location_id=loc1.wsh_location_id and
wdd.organization_id=mic.organization_id and
wdd.inventory_item_id=mic.inventory_item_id and
loc.country=terr_from.territory_code(+) and
loc1.country=terr_to.territory_code(+) and
decode(loc.country,null,userenv('lang'),terr_from.language)=userenv('lang') and
decode(loc1.country,null,userenv('lang'),terr_to.language)=userenv('lang') and
mic.category_id=mc.category_id and
mic.category_set_id=mdc.category_set_id and
mdc.functional_area_id=7 and
exists (
select null from bom_inventory_components bic
where bic.include_on_ship_docs=1 and
bic.component_sequence_id=(select oola.component_sequence_id from oe_order_lines_all oola where oola.line_id=wdd.source_line_id)
union
select null from dual where wdd.top_model_line_id is null
union
select null from dual where wdd.top_model_line_id is not null and wdd.ato_line_id is not null
union
select null from dual where wdd.top_model_line_id=wdd.source_line_id
) and
wdd.organization_id=ood.organization_id(+)
group by
wnd.delivery_id,
wnd.initial_pickup_date,
nvl(wnd.currency_code,wdd.currency_code),
wnd.ship_method_code,
wnd.gross_weight,
wnd.weight_uom_code,
wnd.port_of_loading,
wnd.port_of_discharge,
wnd.waybill,
terr_from.territory_short_name,
loc.address1,
loc.address2,
loc.address3,
loc.address4,
loc.city||', '||nvl(nvl(loc.state,loc.province),loc.county)||' '||loc.postal_code,
wdd.consignee_flag,
wdd.ship_to_site_use_id,
terr_to.territory_short_name,
loc1.address1,
loc1.address2,
loc1.address3,
loc1.address4,
loc1.city||', '||nvl(nvl(loc1.province,loc1.state),loc1.county)||' '||loc1.postal_code,
wdd.ship_to_contact_id,
wdd.cust_po_number,
decode(wms_deploy.wms_deployment_mode,'D',wdd.source_header_number,nvl(wdd.reference_number,wdd.source_header_number)),
mc.description,
wdd.inventory_item_id,
wdd.organization_id,
wdd.item_description,
wdd.customer_item_id,
wdd.requested_quantity_uom,
wdd.src_requested_quantity_uom,
wdd.requested_quantity2,
wdd.requested_quantity_uom2,
wdd.source_code,
wdd.source_line_id,
wdd.source_header_id,
wdd.delivery_detail_id,
&dff_columns_grp
ood.organization_name
order by
wnd.delivery_id,
mc.description