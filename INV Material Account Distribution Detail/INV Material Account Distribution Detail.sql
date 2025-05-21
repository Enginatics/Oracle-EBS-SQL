/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Material Account Distribution Detail
-- Description: Description: Material account distribution detail
Application: Inventory

Source: Material account distribution detail (XML)
Short Name: INVTRDST_XML
-- Excel Examle Output: https://www.enginatics.com/example/inv-material-account-distribution-detail/
-- Library Link: https://www.enginatics.com/reports/inv-material-account-distribution-detail/
-- Run Report: https://demo.enginatics.com/

select
y.*
from
(
select /*+ push_pred(x) push_pred(rctla) */
gl.name ledger,
haouv.name operating_unit,
mta.organization_code,
mta.transaction_date,
(select gp.period_name from gl_periods gp where mta.transaction_date>=gp.start_date and mta.transaction_date<gp.end_date+1 and gl.period_set_name=gp.period_set_name and gl.accounted_period_type=gp.period_type and gp.adjustment_period_flag='N') period,
to_number(to_char(mta.transaction_date,'yyyy')) year,
to_number(to_char(mta.transaction_date,'ww')) week,
msiv.description,
mtst.transaction_source_type_name source_type,
mtt.transaction_type_name transaction_type,
case
when mta.transaction_source_type_id in (2,8,12,101) then msok.concatenated_segments
when mta.transaction_source_type_id=1 then pha.segment1
when mta.transaction_source_type_id=3 then gcck2.concatenated_segments
when mta.transaction_source_type_id=4 then (select mtrh.request_number from mtl_txn_request_headers mtrh where mmt.transaction_source_id=mtrh.header_id)
when mta.transaction_source_type_id=5 then (select we.wip_entity_name from wip_entities we where mmt.transaction_source_id=we.wip_entity_id)
when mta.transaction_source_type_id=6 then mgdk.concatenated_segments
when mta.transaction_source_type_id=7 then (select prha.segment1 from po_requisition_headers_all prha where mmt.transaction_source_id=prha.requisition_header_id)
when mta.transaction_source_type_id=9 then (select mcch.cycle_count_header_name from mtl_cycle_count_headers mcch where mmt.transaction_source_id=mcch.cycle_count_header_id and mmt.organization_id=mcch.organization_id)
when mta.transaction_source_type_id=10 then (select mpi.physical_inventory_name from mtl_physical_inventories mpi where mmt.transaction_source_id=mpi.physical_inventory_id and mmt.organization_id=mpi.organization_id)
when mta.transaction_source_type_id=11 then (select ccu.description from cst_cost_updates ccu where mmt.transaction_source_id=ccu.cost_update_id)
else nvl(mmt.transaction_source_name, to_char(mmt.transaction_source_id))
end source,
nvl(oola.line_number,pla.line_num) source_line,
case
when mmt.transaction_action_id=3 then decode(mmt.organization_id,mta.organization_id,mmt.subinventory_code,mmt.transfer_subinventory)
when mmt.transaction_action_id in (2,28) then decode(sign(mta.primary_quantity),-1,mmt.subinventory_code,1,mmt.transfer_subinventory,mmt.subinventory_code)
else mmt.subinventory_code
end subinventory,
gcck.concatenated_segments account_segments,
fnd_flex_xml_publisher_apis.process_kff_combination_1('acc desc','SQLGL','GL#',gcck.chart_of_accounts_id,null,gcck.code_combination_id,'ALL','Y','DESCRIPTION') account_segments_description,
xxen_util.meaning(mta.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_type,
msiv.concatenated_segments item,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
mck.concatenated_segments category,
decode(mta.transaction_source_type_id,11,mmt.quantity_adjusted, mta.primary_quantity) quantity,
muomv.unit_of_measure_tl primary_uom,
decode(mmt.transaction_action_id,30,
abs(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0,1,null,1,mta.primary_quantity))),
abs(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0,1,null,1,mta.primary_quantity)))*sign(mta.base_transaction_value)*sign(mta.primary_quantity)
) base_unit_cost,
mta.base_transaction_value,
nvl(:p_currency_code,gl.currency_code) currency,
nvl(:p_exchange_rate,1) exchange_rate,
decode(mmt.transaction_action_id,30,
abs(round(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0,1,null,1,mta.primary_quantity))*nvl(:p_exchange_rate,1),:p_ext_prec)),
abs(round(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0,1,null,1,mta.primary_quantity))*nvl(:p_exchange_rate,1),:p_ext_prec))*sign(mta.base_transaction_value)*sign(mta.primary_quantity)
) unit_cost,
nvl(mta.base_transaction_value,0)*nvl(:p_exchange_rate,1) transaction_value,
(select mtr.reason_name from mtl_transaction_reasons mtr where mmt.reason_id=mtr.reason_id) transaction_reason,
&lp_sla_columns
case
when mmt.transaction_source_type_id in (2,8,12,101) then rcta.trx_number
when mmt.transaction_source_type_id=1 and mmt.source_code='RCV' then (select distinct max(aia.invoice_num) keep (dense_rank last order by aia.invoice_id) from ap_invoice_distributions_all aida, ap_invoices_all aia where rt.po_distribution_id=aida.po_distribution_id and aida.invoice_id=aia.invoice_id)
end invoice_number,
coalesce(aps.segment1,hca.account_number) vendor_or_customer_number,
coalesce(aps.vendor_name,hp.party_name) vendor_or_customer_name,
xxen_util.user_name(mta.created_by) created_by,
xxen_util.client_time(mta.creation_date) creation_date,
xxen_util.user_name(mta.last_updated_by) last_updated_by,
xxen_util.client_time(mta.last_update_date) last_update_date,
mta.transaction_id,
mta.inv_sub_ledger_id,
mta.gl_batch_id,
mta.set_of_books_id,
mmt.transaction_type_id,
mmt.transaction_action_id,
mta.transaction_source_type_id,
mta.transaction_source_id
from
(
select
mta.*,
ood.organization_code,
ood.operating_unit,
ood.set_of_books_id
from
mtl_transaction_accounts mta,
org_organization_definitions ood
where
mta.organization_id=ood.organization_id
) mta,
mtl_material_transactions mmt,
mtl_system_items_vl msiv,
mtl_units_of_measure_vl muomv,
mtl_category_sets_v mcsv,
mtl_item_categories mic,
mtl_categories_kfv mck,
mtl_txn_source_types mtst,
mtl_transaction_types mtt,
gl_code_combinations_kfv gcck,
hr_all_organization_units_vl haouv,
gl_ledgers gl,
po_headers_all pha, 
mtl_sales_orders_kfv msok,
gl_code_combinations_kfv gcck2,
mtl_generic_dispositions_kfv mgdk,
oe_order_lines_all oola,
oe_order_headers_all ooha,
hz_cust_accounts hca,
hz_parties hp,
(
select distinct
rctla.org_id,
rctla.interface_line_attribute6,
max(rctla.customer_trx_id) over (partition by rctla.org_id, rctla.interface_line_attribute6) customer_trx_id
from
ra_customer_trx_lines_all rctla
where
rctla.interface_line_context in ('INTERCOMPANY','ORDER ENTRY') and
nvl(rctla.interface_line_attribute11,0)=0 and
rctla.line_type='LINE'
) rctla,
ra_customer_trx_all rcta,
rcv_transactions rt,
po_lines_all pla,
ap_suppliers aps,
(
select
xdl.source_distribution_id_num_1,
xal.ledger_id,
gcck.concatenated_segments,
xal.code_combination_id,
gcck.chart_of_accounts_id,
xah.gl_transfer_status_code,
nvl(xal.entered_dr,0)-nvl(xal.entered_cr,0) entered_amount,
nvl(xal.accounted_dr,0)-nvl(xal.accounted_cr,0) accounted_amount,
xal.party_type_code,
xal.party_id, 
xal.party_site_id
from
(
select distinct --subquery required as there are a few cases with more than one xdl records per source_distribution_id_num_1 and ledger
xdl.source_distribution_id_num_1,
xdl.ae_header_id,
xdl.application_id,
min(xdl.ae_line_num) keep (dense_rank first order by decode(xdl.accounting_line_code,'INTERCOMPANY_COGS',1,2)) over (partition by xdl.application_id,xdl.source_distribution_id_num_1,xdl.accounting_line_code,xdl.ae_header_id) ae_line_num
from
xla_distribution_links xdl
where
'&show_sla'='Y' and
xdl.source_distribution_type='MTL_TRANSACTION_ACCOUNTS'
) xdl,
xla_ae_lines xal,
xla_ae_headers xah,
xla_events xe,
gl_code_combinations_kfv gcck
where
xdl.ae_header_id=xal.ae_header_id and
xdl.ae_line_num=xal.ae_line_num and
xdl.application_id=xal.application_id and
xdl.ae_header_id=xah.ae_header_id and
xdl.application_id=xah.application_id and
xah.event_id=xe.event_id and
xah.application_id=xe.application_id and
nvl(xe.budgetary_control_flag,'N')='N' and
xal.code_combination_id=gcck.code_combination_id
) x
where
1=1 and
nvl(:p_coa_id,-1)=nvl(:p_coa_id,-1) and
mta.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mta.transaction_id=mmt.transaction_id and
mta.inventory_item_id=msiv.inventory_item_id and
mta.organization_id=msiv.organization_id and
msiv.primary_uom_code=muomv.uom_code(+) and
mcsv.category_set_name=:category_set_name and
mcsv.category_set_id=mic.category_set_id and
mta.inventory_item_id=mic.inventory_item_id and
mta.organization_id=mic.organization_id and
mic.category_id=mck.category_id and
mta.transaction_source_type_id=mtst.transaction_source_type_id and
mmt.transaction_type_id=mtt.transaction_type_id and
mta.reference_account=gcck.code_combination_id and
mta.operating_unit=haouv.organization_id(+) and
mta.set_of_books_id=gl.ledger_id and
mta.accounting_line_type<>15 and
case when mmt.transaction_source_type_id=1 then mmt.transaction_source_id end=pha.po_header_id(+) and
case when mta.transaction_source_type_id in (2,8,12,101) then mta.transaction_source_id end=msok.sales_order_id(+) and
case when mta.transaction_source_type_id=3 then mta.transaction_source_id end=gcck2.code_combination_id(+) and
case when mta.transaction_source_type_id=6 then mta.transaction_source_id end=mgdk.disposition_id(+) and
case when mmt.transaction_source_type_id in (2,8,12,101) then mmt.trx_source_line_id end=oola.line_id(+) and
oola.header_id=ooha.header_id(+) and
ooha.sold_to_org_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
oola.org_id=rctla.org_id(+) and
to_char(oola.line_id)=rctla.interface_line_attribute6(+) and
rctla.customer_trx_id=rcta.customer_trx_id(+) and
case when mmt.transaction_source_type_id=1 and mmt.source_code='RCV' then mmt.source_line_id end=rt.transaction_id(+) and
rt.po_line_id=pla.po_line_id(+) and
pha.vendor_id=aps.vendor_id(+) and
mta.inv_sub_ledger_id=x.source_distribution_id_num_1(+) and
mta.set_of_books_id=x.ledger_id(+)
) y
where
2=2
order by
y.ledger,
y.account_segments,
y.transaction_date,
y.source_type,
y.transaction_type,
y.source,
y.subinventory,
y.quantity,
y.unit_cost,
y.transaction_value