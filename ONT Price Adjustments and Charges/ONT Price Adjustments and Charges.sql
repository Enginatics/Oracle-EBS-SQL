/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Price Adjustments and Charges
-- Description: Price adjustments applied to sales orders: discounts, surcharges, price breaks, promotional goods and freight and special charges, one row per adjustment of an order header or line.
-- Extended Amount is the unit adjustment times the ordered quantity, a lumpsum charge once per line. Discounts and credits are negative, and line amounts of return lines carry the reverse sign, as in ONT Orders and Lines.
-- Order level modifiers are stored once per order without a line. The line selling prices include their effect, but Oracle stores no amount for it, so Unit Adjustment and Extended Amount are blank on these rows, except for a lumpsum order level charge.
-- Tax records and shipping cost records are not listed.
-- Excel Example Output: https://www.enginatics.com/example/ont-price-adjustments-and-charges/
-- Library Link: https://www.enginatics.com/reports/ont-price-adjustments-and-charges/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ooha.order_number,
ottt.name order_type,
xxen_util.client_time(ooha.ordered_date) ordered_date,
hp.party_name customer,
hca.account_number customer_number,
xxen_util.meaning(ooha.flow_status_code,'FLOW_STATUS',660) order_status,
ooha.transactional_curr_code currency,
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') line,
xxen_util.meaning(oola.line_category_code,'ORDER_CATEGORY',660) line_category,
xxen_util.meaning(oola.flow_status_code,'LINE_FLOW_STATUS',660) line_status,
msiv.concatenated_segments item,
msiv.description item_description,
oola.ordered_quantity quantity,
oola.order_quantity_uom uom,
oola.unit_list_price list_price,
oola.unit_selling_price,
xxen_util.meaning(opa.list_line_type_code,'LIST_LINE_TYPE_CODE',661) adjustment_type,
xxen_util.meaning(opa.modifier_level_code,'MODIFIER_LEVEL_CODE',661) modifier_level,
qlhv.name modifier,
xxen_util.meaning(qlhv.list_type_code,'LIST_TYPE_CODE',661) modifier_type,
opa.list_line_no modifier_line,
(select qpp.name from qp_pricing_phases qpp where opa.pricing_phase_id=qpp.pricing_phase_id) pricing_phase,
coalesce(xxen_util.meaning(opa.charge_type_code,'FREIGHT_CHARGES_TYPE',661),xxen_util.meaning(opa.charge_type_code,'FREIGHT_COST_TYPE',665)) charge_type,
xxen_util.meaning(opa.credit_or_charge_flag,'CREDIT_OR_CHARGE_FLAG',660) credit_or_charge,
xxen_util.meaning(opa.arithmetic_operator,'ARITHMETIC_OPERATOR',661) operator,
opa.operand,
case when opa.line_id is not null then opa.adjusted_amount end unit_adjustment,
case
when opa.line_id is null then case when opa.list_line_type_code='FREIGHT_CHARGE' and opa.arithmetic_operator='LUMPSUM' then decode(opa.credit_or_charge_flag,'C',-1,1)*opa.operand end
when opa.list_line_type_code='FREIGHT_CHARGE' then decode(opa.credit_or_charge_flag,'C',-1,1)*decode(opa.arithmetic_operator,'LUMPSUM',case when oola.ordered_quantity>0 then opa.operand end,oola.ordered_quantity*opa.adjusted_amount)
else decode(oola.line_category_code,'RETURN',-1,1)*oola.ordered_quantity*opa.adjusted_amount
end extended_amount,
xxen_util.yes(opa.automatic_flag) automatic,
xxen_util.yes(opa.update_allowed) override_allowed,
xxen_util.yes(opa.updated_flag) overridden,
xxen_util.yes(opa.applied_flag) applied,
xxen_util.yes(opa.accrual_flag) accrual,
xxen_util.yes(opa.invoiced_flag) invoiced,
xxen_util.meaning(opa.change_reason_code,'CHANGE_CODE',660) change_reason,
opa.change_reason_text change_comments,
&dff_columns
xxen_util.user_name(opa.created_by) created_by,
xxen_util.client_time(opa.creation_date) creation_date,
xxen_util.user_name(opa.last_updated_by) last_updated_by,
xxen_util.client_time(opa.last_update_date) last_update_date,
ooha.header_id,
oola.line_id,
opa.price_adjustment_id
from
hr_all_organization_units_vl haouv,
oe_order_headers_all ooha,
oe_price_adjustments opa,
oe_order_lines_all oola,
oe_transaction_types_tl ottt,
hz_cust_accounts hca,
hz_parties hp,
mtl_system_items_vl msiv,
qp_list_headers_vl qlhv
where
1=1 and
ooha.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
opa.list_line_type_code in (select flvv.lookup_code from fnd_lookup_values_vl flvv where flvv.lookup_type='LIST_LINE_TYPE_CODE' and flvv.view_application_id=661 and flvv.security_group_id=0) and
haouv.organization_id=ooha.org_id and
ooha.header_id=opa.header_id and
opa.line_id=oola.line_id(+) and
ooha.order_type_id=ottt.transaction_type_id(+) and
ottt.language(+)=userenv('lang') and
ooha.sold_to_org_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
oola.inventory_item_id=msiv.inventory_item_id(+) and
oola.ship_from_org_id=msiv.organization_id(+) and
opa.list_header_id=qlhv.list_header_id(+)
order by
haouv.name,
ooha.order_number,
oola.line_number nulls first,
oola.shipment_number,
oola.option_number,
oola.component_number,
oola.service_number,
opa.pricing_group_sequence,
opa.price_adjustment_id
