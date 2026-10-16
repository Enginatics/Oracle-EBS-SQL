/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Blanket Sales Agreements
-- Description: Blanket sales agreements, one row per agreement line, with the minimum and maximum quantity and amount, and the quantity and amount released, fulfilled and returned by the sales order lines that reference the agreement.
-- Remaining is the maximum plus the returned less the released quantity or amount, the limit that Order Management validates new releases against. Agreement level amounts are shown on the first line of each agreement only, so that they can be summed. Releases counts the sales orders with a not cancelled line released against the agreement line.
-- Use ONT Orders and Lines with the Sales Agreement Number parameter for the release order lines.
-- Excel Example Output: https://www.enginatics.com/example/ont-blanket-sales-agreements/
-- Library Link: https://www.enginatics.com/reports/ont-blanket-sales-agreements/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
obha.order_number agreement_number,
obha.sales_document_name agreement_name,
ottt.name agreement_type,
xxen_util.meaning(obha.flow_status_code,'FLOW_STATUS',660) agreement_status,
hp.party_name customer,
hca.account_number customer_number,
obha.cust_po_number customer_po,
jrrev.resource_name salesperson,
obha.transactional_curr_code currency,
(select qlhv.name from qp_list_headers_vl qlhv where obha.price_list_id=qlhv.list_header_id) price_list,
(select qlhv.name from qp_list_headers_vl qlhv where obhe.new_modifier_list_id=qlhv.list_header_id) modifier_list,
obha.version_number agreement_version,
obhe.start_date_active agreement_start_date,
obhe.end_date_active agreement_end_date,
xxen_util.yes(obhe.on_hold_flag) on_hold,
case when row_number() over (partition by obha.header_id order by obla.line_number)=1 then obhe.blanket_min_amount end agreement_min_amount,
case when row_number() over (partition by obha.header_id order by obla.line_number)=1 then obhe.blanket_max_amount end agreement_max_amount,
case when row_number() over (partition by obha.header_id order by obla.line_number)=1 then obhe.released_amount end agreement_released_amount,
case when row_number() over (partition by obha.header_id order by obla.line_number)=1 then obhe.fulfilled_amount end agreement_fulfilled_amount,
case when row_number() over (partition by obha.header_id order by obla.line_number)=1 then obhe.returned_amount end agreement_returned_amount,
case when row_number() over (partition by obha.header_id order by obla.line_number)=1 then obhe.blanket_max_amount+nvl(obhe.returned_amount,0)-nvl(obhe.released_amount,0) end agreement_remaining_amount,
obla.line_number,
xxen_util.meaning(obla.item_identifier_type,'ITEM_IDENTIFIER_TYPE',660) item_identifier_type,
nvl(msiv.concatenated_segments,obla.ordered_item) item,
msiv.description item_description,
obla.order_quantity_uom uom,
obla.unit_list_price list_price,
oble.start_date_active line_start_date,
oble.end_date_active line_end_date,
oble.blanket_min_quantity line_min_quantity,
oble.blanket_max_quantity line_max_quantity,
oble.released_quantity line_released_quantity,
oble.fulfilled_quantity line_fulfilled_quantity,
oble.returned_quantity line_returned_quantity,
oble.blanket_line_min_amount line_min_amount,
oble.blanket_line_max_amount line_max_amount,
oble.released_amount line_released_amount,
oble.fulfilled_amount line_fulfilled_amount,
oble.returned_amount line_returned_amount,
oble.blanket_max_quantity+nvl(oble.returned_quantity,0)-nvl(oble.released_quantity,0) line_remaining_quantity,
oble.blanket_line_max_amount+nvl(oble.returned_amount,0)-nvl(oble.released_amount,0) line_remaining_amount,
round(100*nvl(oble.released_quantity,0)/nullif(oble.blanket_max_quantity,0),2) line_released_quantity_percent,
round(100*nvl(oble.released_amount,0)/nullif(oble.blanket_line_max_amount,0),2) line_released_amount_percent,
oble.min_release_quantity,
oble.max_release_quantity,
oble.min_release_amount,
oble.max_release_amount,
xxen_util.yes(oble.override_blanket_controls_flag) override_blanket_controls,
(select count(distinct oola.header_id) from oe_order_lines_all oola where obha.order_number=oola.blanket_number and obla.line_number=oola.blanket_line_number and oola.cancelled_flag='N') releases,
&dff_columns
xxen_util.user_name(obha.created_by) created_by,
xxen_util.client_time(obha.creation_date) creation_date,
xxen_util.user_name(obla.last_updated_by) line_last_updated_by,
xxen_util.client_time(obla.last_update_date) line_last_update_date,
obha.header_id,
obla.line_id
from
hr_all_organization_units_vl haouv,
oe_blanket_headers_all obha,
oe_blanket_headers_ext obhe,
oe_blanket_lines_all obla,
oe_blanket_lines_ext oble,
oe_transaction_types_tl ottt,
hz_cust_accounts hca,
hz_parties hp,
jtf_rs_salesreps jrs,
jtf_rs_resource_extns_vl jrrev,
mtl_system_items_vl msiv
where
1=1 and
obha.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
haouv.organization_id=obha.org_id and
obha.order_number=obhe.order_number and
obha.header_id=obla.header_id and
obla.line_id=oble.line_id and
obha.order_type_id=ottt.transaction_type_id(+) and
ottt.language(+)=userenv('lang') and
obha.sold_to_org_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
obha.salesrep_id=jrs.salesrep_id(+) and
obha.org_id=jrs.org_id(+) and
jrs.resource_id=jrrev.resource_id(+) and
decode(obla.item_identifier_type,'CAT',to_number(null),obla.inventory_item_id)=msiv.inventory_item_id(+) and
nvl(obla.ship_from_org_id,oe_sys_parameters.value('MASTER_ORGANIZATION_ID',obla.org_id))=msiv.organization_id(+)
order by
haouv.name,
obha.order_number,
obla.line_number
