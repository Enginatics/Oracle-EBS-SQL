/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Recost Cost of Goods Sold
-- Description: Report to compare the "as transacted" cost of goods sold (COGS) transactions in Oracle Inventory with the "what if" costs from a simulation cost type. Use this report when you need to make manual journal entry corrections to your COGS entries, due to incorrect item costs. In addition to reporting the normal COGS entries for the COGS Recognition, Sales Order Issue, RMA Receipt and RMA Return transactions, you can also report user-defined material transactions such as Account Issues/Receipts, Miscellaneous Issues/Receipts and Account Alias transactions which could represent COGS entries from other ERP Systems. To report additional user-defined transactions enter these along with the defaulted values for the COGS Transaction Type parameter: COGS Recognition, Sales Order Issue, RMA Receipt and RMA Return.
-- Note: in order for COGS entries to be reported you must first run Create Accounting.
-- Parameters:
-- ===========
-- Transaction Date From: enter the starting transaction date for COGS transactions (mandatory).
-- Transaction Date To: enter the ending transaction date for PO COGS transactions (mandatory).
-- COGS Transaction Types: enter the COGS related transaction types you wish to report (mandatory).
-- Recost Cost Type: enter the cost type you wish to use to recost your COGS transactions (mandatory).
-- Minimum Value Difference: the absolute smallest COGS difference you want to report (mandatory).
-- Category Set 1: any item category you wish, typically the Cost or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Inventory category set (optional).
-- Item Number: enter the specific item number(s) you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2006- 2023 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxrecostcogsdetailrept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 02 Apr 2006 Douglas Volz Initial Coding
-- -- | 1.1 28 Apr 2006 Douglas Volz Final Coding
-- -- | 1.2 02 May 2017 Douglas Volz Modified for Client's use, added inline table
-- -- | to get one row for COGS accounting entries, to
-- -- | to get the mmt correct qty and avoid cross-joining.
-- -- | 1.3 13 Nov 2023 Douglas Volz Modified for organization access, removed tabs and
-- -- | added subledger accounting ccids.
-- -- | 1.4 16 Nov 2023 Douglas Volz Remove orgacctperiods, use period name from xlaaeheaders.
-- -- | 1.5 05 Dec 2023 Douglas Volz Added G/L and Operating Unit security restrictions.
-- -- | 1.6 12 Mar 2024 Douglas Volz Add cost elements for COGS per client request.
-- -- | 1.7 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-recost-cost-of-goods-sold/
-- Library Link: https://www.enginatics.com/reports/cac-recost-cost-of-goods-sold/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
haou.name organization_name,
y.period_name,
&segment_columns
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
xxen_util.meaning(y.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
xxen_util.yes(decode(y.inventory_asset_flag,1,'Y')) inventory_asset,
xxen_util.meaning(y.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_line_type,
y.transaction_type_name transaction_type,
mtst.transaction_source_type_name transaction_source,
y.document_number,
y.order_type,
y.transaction_id,
y.transaction_date,
y.transaction_reference transaction_comments,
&category_columns
msiv.primary_uom_code uom_code,
y.quantity,
y.original_cogs_material,
y.original_cogs_material_ovhd,
y.original_cogs_resource,
y.original_cogs_osp,
y.original_cogs_overhead,
y.original_cogs,
round(y.new_cogs_material,2) new_cogs_material,
round(y.new_cogs_material_overhead,2) new_cogs_material_overhead,
round(y.new_cogs_resource,2) new_cogs_resource,
round(y.new_cogs_osp,2) new_cogs_osp,
round(y.new_cogs_overhead,2) new_cogs_overhead,
round(y.new_cogs,2) new_cogs,
round(greatest(y.new_cogs-y.original_cogs,0),2) debit_cogs_amount,
abs(round(least(y.new_cogs-y.original_cogs,0),2)) credit_cogs_amount,
round(y.new_cogs-y.original_cogs,2) difference,
round((y.new_cogs-y.original_cogs)/decode(y.original_cogs,0,1,y.original_cogs)*100,1) percent_difference
from
(
select
x.organization_id,
x.inventory_item_id,
xah.period_name,
xal.code_combination_id,
x.accounting_line_type,
x.transaction_type_name,
x.transaction_source_type_id,
x.document_number,
x.order_type,
x.transaction_id,
x.transaction_date,
x.transaction_reference,
cic.based_on_rollup_flag,
cic.inventory_asset_flag,
sum(x.primary_quantity) quantity,
sum(x.material_value) original_cogs_material,
sum(x.material_overhead_value) original_cogs_material_ovhd,
sum(x.resource_value) original_cogs_resource,
sum(x.outside_processing_value) original_cogs_osp,
sum(x.overhead_value) original_cogs_overhead,
sum(x.base_transaction_value) original_cogs,
sum(decode(cic.material_cost,null,x.material_value,cic.material_cost*x.primary_quantity)) new_cogs_material,
sum(decode(cic.material_overhead_cost,null,x.material_overhead_value,cic.material_overhead_cost*x.primary_quantity)) new_cogs_material_overhead,
sum(decode(cic.resource_cost,null,x.resource_value,cic.resource_cost*x.primary_quantity)) new_cogs_resource,
sum(decode(cic.outside_processing_cost,null,x.outside_processing_value,cic.outside_processing_cost*x.primary_quantity)) new_cogs_osp,
sum(decode(cic.overhead_cost,null,x.overhead_value,cic.overhead_cost*x.primary_quantity)) new_cogs_overhead,
sum(decode(cic.item_cost,null,x.base_transaction_value,cic.item_cost*x.primary_quantity)) new_cogs
from
(
select
mta.organization_id,
mta.inventory_item_id,
mta.transaction_id,
mta.accounting_line_type,
mta.inv_sub_ledger_id,
mtt.transaction_type_name,
mmt.transaction_source_type_id,
case
when mmt.transaction_source_type_id in (2,4,8,12,101) or mmt.transaction_source_type_id=13 and mmt.transaction_action_id=13 then (select to_char(ooha.order_number) from oe_order_lines_all oola, oe_order_headers_all ooha where mmt.trx_source_line_id=oola.line_id and oola.header_id=ooha.header_id)
when mmt.transaction_source_type_id=13 and mmt.transaction_action_id in (9,10,14) then (select to_char(ooha.order_number) from mtl_material_transactions mmt2, oe_order_lines_all oola, oe_order_headers_all ooha where mmt.parent_transaction_id=mmt2.transaction_id and mmt2.trx_source_line_id=oola.line_id and oola.header_id=ooha.header_id)
when mmt.transaction_source_type_id=1 then (select pha.segment1 from po_headers_all pha where mmt.transaction_source_id=pha.po_header_id)
when mmt.transaction_source_type_id=5 then (select we.wip_entity_name from wip_entities we where mmt.transaction_source_id=we.wip_entity_id)
when mmt.transaction_source_type_id=6 then (select mgd.segment1 from mtl_generic_dispositions mgd where mmt.transaction_source_id=mgd.disposition_id)
when mmt.transaction_source_type_id=7 then (select prha.segment1 from po_requisition_headers_all prha where mmt.transaction_source_id=prha.requisition_header_id)
when mmt.transaction_source_type_id=9 then (select mcch.cycle_count_header_name from mtl_cycle_count_headers mcch where mmt.transaction_source_id=mcch.cycle_count_header_id)
when mmt.transaction_source_type_id=10 then (select mpi.description from mtl_physical_inventories mpi where mmt.transaction_source_id=mpi.physical_inventory_id)
when mmt.transaction_source_type_id=11 then (select ccu.description from cst_cost_updates ccu where mmt.cost_update_id=ccu.cost_update_id)
else xxen_util.meaning(mmt.transaction_action_id,'MTL_TRANSACTION_ACTION',700)
end document_number,
(select ottt.name from oe_order_lines_all oola, oe_order_headers_all ooha, oe_transaction_types_tl ottt where mmt.trx_source_line_id=oola.line_id and oola.header_id=ooha.header_id and ooha.order_type_id=ottt.transaction_type_id and ottt.language=userenv('lang')) order_type,
mta.transaction_date,
mmt.transaction_reference,
decode(mmt.transaction_action_id,24,mmt.quantity_adjusted,mta.primary_quantity/count(*) over (partition by mta.transaction_id,mta.reference_account,mta.accounting_line_type)) primary_quantity,
decode(nvl(mta.cost_element_id,1),1,mta.base_transaction_value,0) material_value,
decode(mta.cost_element_id,2,mta.base_transaction_value,0) material_overhead_value,
decode(mta.cost_element_id,3,mta.base_transaction_value,0) resource_value,
decode(mta.cost_element_id,4,mta.base_transaction_value,0) outside_processing_value,
decode(mta.cost_element_id,5,mta.base_transaction_value,0) overhead_value,
mta.base_transaction_value
from
mtl_parameters mp,
mtl_transaction_accounts mta,
mtl_material_transactions mmt,
mtl_transaction_types mtt
where
2=2 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=mta.organization_id and
mta.accounting_line_type in (35,2) and
mta.transaction_id=mmt.transaction_id and
mmt.transaction_type_id=mtt.transaction_type_id and
mmt.transaction_source_type_id=mtt.transaction_source_type_id and
mta.transaction_source_type_id=mtt.transaction_source_type_id
) x,
xla_distribution_links xdl,
xla_ae_lines xal,
xla_ae_headers xah,
(select cic.organization_id, cic.inventory_item_id, cic.based_on_rollup_flag, cic.inventory_asset_flag, cic.material_cost, cic.material_overhead_cost, cic.resource_cost, cic.outside_processing_cost, cic.overhead_cost, cic.item_cost from cst_item_costs cic, cst_cost_types cct where 3=3 and cic.cost_type_id=cct.cost_type_id) cic
where
x.inv_sub_ledger_id=xdl.source_distribution_id_num_1 and
xdl.source_distribution_type='MTL_TRANSACTION_ACCOUNTS' and
xdl.application_id=707 and
xdl.ae_header_id=xal.ae_header_id and
xdl.ae_line_num=xal.ae_line_num and
xal.application_id=707 and
xal.ae_header_id=xah.ae_header_id and
xal.application_id=xah.application_id and
xal.ledger_id=xah.ledger_id and
x.organization_id=cic.organization_id(+) and
x.inventory_item_id=cic.inventory_item_id(+)
group by
x.organization_id,
x.inventory_item_id,
xah.period_name,
xal.code_combination_id,
x.accounting_line_type,
x.transaction_type_name,
x.transaction_source_type_id,
x.document_number,
x.order_type,
x.transaction_id,
x.transaction_date,
x.transaction_reference,
cic.based_on_rollup_flag,
cic.inventory_asset_flag
having
abs(round(sum(decode(nvl(cic.item_cost,0)*x.primary_quantity,0,x.base_transaction_value,nvl(cic.item_cost,0)*x.primary_quantity)),2)-sum(x.base_transaction_value))>=nvl(:p_min_value_diff,.01)
) y,
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
mtl_txn_source_types mtst,
gl_code_combinations gcc
where
1=1 and
y.organization_id=mp.organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
y.organization_id=msiv.organization_id and
y.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
y.transaction_source_type_id=mtst.transaction_source_type_id and
y.code_combination_id=gcc.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
y.period_name,
item_number,
accounting_line_type,
y.document_number,
y.transaction_id
