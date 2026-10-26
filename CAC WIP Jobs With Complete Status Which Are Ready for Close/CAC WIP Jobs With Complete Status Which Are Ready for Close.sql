/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Jobs With Complete Status Which Are Ready for Close
-- Description: Report WIP jobs which have a status of "Complete", do not exceed variance tolerances, have completed or exceeded the WIP start quantity, with no open material requirements, no unearned OSP (outside processing) charges and no stuck transactions in interfaces. When you include scrap quantities, any scrapped assemblies are counted with the completed units. Note that for material requirements, expense items are ignored.
-- / +=============================================================================+
-- -- | Copyright 2017 - 2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas A. Volz
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============= =========================================
-- -- | 1.0 16 MAR 2017 Douglas Volz Initial Coding
-- -- | 1.1 19 MAR 2017 Douglas Volz Added interface conditions for eligibility
-- -- | and check for no applied OSP
-- -- | 1.3 27 MAR 2017 Douglas Volz Fix "return more than one row" error for
-- -- | correlated sub-query on OSP and add in check for purchase requisitions
-- -- | 1.4 27 APR 2017 Douglas Volz Fix for cross-joining results
-- -- | 1.6 25 Oct 2017 Douglas Volz Remove pdatecompleted parameter, not needed
-- -- | 1.7 25 Jul 2018 Douglas Volz Removed all categories except Inventory
-- -- | 1.8 25 Jul 2018 Douglas Volz Removed all category values
-- -- | 1.9 11 Dec 2020 Douglas Volz Now for Standard, Lot Based Standard and Non-
-- -- | Standard Asset Jobs. Added another category.
-- -- | 1.10 26 Jan 2021 Douglas Volz Check for unissued materials and WIP scrap controls
-- -- | 1.11 11 Feb 2021 Douglas Volz Added parameter to include scrap for requirements
-- -- | 1.12 05 Mar 2021 Douglas Volz Added parameter to include bulk items for requirements.
-- -- | 1.13 12 Mar 2021 Douglas Volz Add logic to ignore Phantom WIP Supply Types as
-- -- | these requirements are never issued.
-- -- | 1.14 15 Apr 2021 Douglas Volz Added Date Released
-- -- | 1.15 10 Jul 2022 Douglas Volz Added WIP Variance Percentage parameter.
-- -- | 1.16 21 Jan 2024 Douglas Volz Bug fix for Pending Material and Pending Shop Floor
-- -- | Move. Remove tabs and add inventory access controls.
-- -- | 1.17 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-wip-jobs-with-complete-status-which-are-ready-for-close/
-- Library Link: https://www.enginatics.com/reports/cac-wip-jobs-with-complete-status-which-are-ready-for-close/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.operating_unit,
x.org_code,
x.wip_class,
x.class_type,
x.wip_job,
x.job_status,
x.date_released,
x.date_completed,
x.last_update_date,
x.completion_subinventory,
x.assembly_number,
x.assembly_description,
x.item_type,
x.item_status,
x.make_buy_code,
&category_columns
x.uom_code,
x.start_quantity,
x.quantity_completed,
x.quantity_scrapped,
x.total_quantity,
case
when x.done_quantity=0 then xxen_util.meaning('N','YES_NO_ALL',0)
when x.open_quantity>0 then xxen_util.meaning(2,'SYS_RANGE',700)
else xxen_util.meaning('A','YES_NO_ALL',0)
end quantities_completed,
xxen_util.yes(x.open_material_quantities) open_material_quantities,
xxen_util.yes(x.no_earned_osp) no_earned_osp,
x.currency_code,
x.wip_value,
x.wip_costs_in,
round(x.wip_value_unrounded/decode(x.wip_costs_in_unrounded,0,1,x.wip_costs_in_unrounded),3)*100 wip_variance_percent,
xxen_util.yes(x.unprocessed_material) unprocessed_material,
xxen_util.yes(x.uncosted_material) uncosted_material,
xxen_util.yes(x.pending_wip_costing) pending_wip_costing,
xxen_util.yes(x.pending_receiving) pending_receiving,
xxen_util.yes(x.pending_requisitions) pending_requisitions,
xxen_util.yes(x.pending_material) pending_material,
xxen_util.yes(x.pending_shop_floor_move) pending_shop_floor_move,
xxen_util.yes(x.uncosted_split_merge_txn) uncosted_split_merge_txn,
xxen_util.yes(x.unprocessed_wsm_txn_interface) unprocessed_wsm_txn_interface,
xxen_util.yes(x.pending_resulting_lots) pending_resulting_lots,
xxen_util.yes(x.pending_wsm_job_lots) pending_wsm_job_lots
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
wac.class_code wip_class,
xxen_util.meaning(wac.class_type,'WIP_CLASS_TYPE',700) class_type,
we.wip_entity_name wip_job,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) job_status,
wdj.date_released,
wdj.date_completed,
wdj.last_update_date,
wdj.completion_subinventory,
msiv.concatenated_segments assembly_number,
msiv.description assembly_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
msiv.primary_uom_code uom_code,
nvl(wdj.start_quantity,0) start_quantity,
nvl(wdj.quantity_completed,0) quantity_completed,
nvl(wdj.quantity_scrapped,0) quantity_scrapped,
nvl(wdj.quantity_completed,0)+nvl(wdj.quantity_scrapped,0) total_quantity,
nvl(wdj.start_quantity,0)-nvl(wdj.quantity_completed,0)-decode(:p_include_scrap,'N',0,nvl(wdj.quantity_scrapped,0)) open_quantity,
nvl(wdj.quantity_completed,0)+decode(:p_include_scrap,'N',0,nvl(wdj.quantity_scrapped,0)) done_quantity,
case when wdj.wip_entity_id in (
select
wro.wip_entity_id
from
wip_requirement_operations wro,
mtl_system_items_b msib
where
2=2 and
wdj.wip_entity_id=wro.wip_entity_id and
wdj.organization_id=wro.organization_id and
wro.wip_supply_type<>6 and
wro.organization_id=msib.organization_id and
wro.inventory_item_id=msib.inventory_item_id and
msib.inventory_asset_flag='Y' and
round(decode(wro.basis_type,2,nvl(wro.required_quantity,1),decode(wro.basis_type,1,nvl(wro.quantity_per_assembly,wdj.start_quantity),nvl(wro.quantity_per_assembly,0))/nvl(wro.component_yield_factor,1)*(nvl(wdj.quantity_completed,0)+decode(:p_include_scrap,'N',0,nvl(wdj.quantity_scrapped,0)))),3)-round(nvl(wro.quantity_issued,0),3)>0
) then 'Y' end open_material_quantities,
case when wdj.wip_entity_id in (select wor.wip_entity_id from wip_operation_resources wor where wdj.wip_entity_id=wor.wip_entity_id and wdj.organization_id=wor.organization_id and wor.autocharge_type in (3,4) and nvl(wor.applied_resource_units,0)=0) then 'Y' end no_earned_osp,
gl.currency_code,
wpb.wip_value,
wpb.wip_value_unrounded,
wpb.wip_costs_in,
wpb.wip_costs_in_unrounded,
case when wdj.wip_entity_id in (select mmtt.transaction_source_id from mtl_material_transactions_temp mmtt where wdj.organization_id=mmtt.organization_id and mmtt.transaction_source_type_id=5) then 'Y' end unprocessed_material,
case when wdj.wip_entity_id in (select mmt.transaction_source_id from mtl_material_transactions mmt where wdj.organization_id=mmt.organization_id and mmt.transaction_source_type_id=5 and mmt.costed_flag is not null) then 'Y' end uncosted_material,
case when wdj.wip_entity_id in (select wcti.wip_entity_id from wip_cost_txn_interface wcti where wdj.organization_id=wcti.organization_id) then 'Y' end pending_wip_costing,
case when wdj.wip_entity_id in (select rti.wip_entity_id from rcv_transactions_interface rti where wdj.organization_id=rti.to_organization_id) then 'Y' end pending_receiving,
case when wdj.wip_entity_id in (select pri.wip_entity_id from po_requisitions_interface pri, wip_operation_resources wor where wdj.organization_id=pri.destination_organization_id and pri.wip_entity_id=wor.wip_entity_id and pri.destination_organization_id=wor.organization_id and wor.autocharge_type in (3,4) and nvl(wor.applied_resource_units,0)=0) then 'Y' end pending_requisitions,
case when wdj.wip_entity_id in (select mti.transaction_source_id from mtl_transactions_interface mti where wdj.organization_id=mti.organization_id and mti.transaction_source_type_id=5 and mti.process_flag<>9) then 'Y' end pending_material,
case when wdj.wip_entity_id in (select wmti.wip_entity_id from wip_move_txn_interface wmti where wdj.organization_id=wmti.organization_id) then 'Y' end pending_shop_floor_move,
case when wdj.wip_entity_id in (select wssj.wip_entity_id from wsm_sm_starting_jobs wssj, wsm_split_merge_transactions wsmt where wdj.organization_id=wssj.organization_id and wssj.transaction_id=wsmt.transaction_id and wsmt.costed<>4 union all select wsrj.wip_entity_id from wsm_sm_resulting_jobs wsrj, wsm_split_merge_transactions wsmt where wdj.organization_id=wsrj.organization_id and wsrj.transaction_id=wsmt.transaction_id and wsmt.costed<>4) then 'Y' end uncosted_split_merge_txn,
case when wdj.wip_entity_id in (select wsji.wip_entity_id from wsm_starting_jobs_interface wsji, wsm_split_merge_txn_interface wsmti where wdj.organization_id=wsji.organization_id and wsji.header_id=wsmti.header_id and wsmti.process_status<>4) or (we.wip_entity_name,we.organization_id) in (select wrji.wip_entity_name, wrji.organization_id from wsm_resulting_jobs_interface wrji, wsm_split_merge_txn_interface wsmti where wrji.header_id=wsmti.header_id and wsmti.process_status<>4) then 'Y' end unprocessed_wsm_txn_interface,
case when wdj.wip_entity_id in (select wrli.wip_entity_id from wsm_resulting_lots_interface wrli, wsm_lot_split_merges_interface wlsmi where wdj.organization_id=wrli.organization_id and wrli.header_id=wlsmi.header_id and wlsmi.wip_flag=1 and wlsmi.process_status<>4) then 'Y' end pending_resulting_lots,
case when wdj.wip_entity_id in (select wlji.wip_entity_id from wsm_lot_job_interface wlji where wdj.organization_id=wlji.organization_id and wlji.process_status<>4) then 'Y' end pending_wsm_job_lots,
msiv.inventory_item_id,
msiv.organization_id
from
wip_discrete_jobs wdj,
wip_entities we,
wip_accounting_classes wac,
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv,
(
select
wpb.wip_entity_id,
round(sum(nvl(wpb.pl_material_in,0)-nvl(wpb.tl_material_out,0)-nvl(wpb.pl_material_out,0)-nvl(wpb.tl_material_var,0)-nvl(wpb.pl_material_var,0)+
nvl(wpb.pl_material_overhead_in,0)-nvl(wpb.tl_material_overhead_out,0)-nvl(wpb.pl_material_overhead_out,0)-nvl(wpb.tl_material_overhead_var,0)-nvl(wpb.pl_material_overhead_var,0)+
nvl(wpb.tl_resource_in,0)+nvl(wpb.pl_resource_in,0)-nvl(wpb.tl_resource_out,0)-nvl(wpb.pl_resource_out,0)-nvl(wpb.tl_resource_var,0)-nvl(wpb.pl_resource_var,0)+
nvl(wpb.tl_outside_processing_in,0)+nvl(wpb.pl_outside_processing_in,0)-nvl(wpb.tl_outside_processing_out,0)-nvl(wpb.pl_outside_processing_out,0)-nvl(wpb.tl_outside_processing_var,0)-nvl(wpb.pl_outside_processing_var,0)+
nvl(wpb.tl_overhead_in,0)+nvl(wpb.pl_overhead_in,0)-nvl(wpb.tl_overhead_out,0)-nvl(wpb.pl_overhead_out,0)-nvl(wpb.tl_overhead_var,0)-nvl(wpb.pl_overhead_var,0)+
nvl(wpb.tl_scrap_in,0)-nvl(wpb.tl_scrap_out,0)-nvl(wpb.tl_scrap_var,0)),2) wip_value,
sum(nvl(wpb.pl_material_in,0)-nvl(wpb.tl_material_out,0)-nvl(wpb.pl_material_out,0)-nvl(wpb.tl_material_var,0)-nvl(wpb.pl_material_var,0)+
nvl(wpb.pl_material_overhead_in,0)-nvl(wpb.tl_material_overhead_out,0)-nvl(wpb.pl_material_overhead_out,0)-nvl(wpb.tl_material_overhead_var,0)-nvl(wpb.pl_material_overhead_var,0)+
nvl(wpb.tl_resource_in,0)+nvl(wpb.pl_resource_in,0)-nvl(wpb.tl_resource_out,0)-nvl(wpb.pl_resource_out,0)-nvl(wpb.tl_resource_var,0)-nvl(wpb.pl_resource_var,0)+
nvl(wpb.tl_outside_processing_in,0)+nvl(wpb.pl_outside_processing_in,0)-nvl(wpb.tl_outside_processing_out,0)-nvl(wpb.pl_outside_processing_out,0)-nvl(wpb.tl_outside_processing_var,0)-nvl(wpb.pl_outside_processing_var,0)+
nvl(wpb.tl_overhead_in,0)+nvl(wpb.pl_overhead_in,0)-nvl(wpb.tl_overhead_out,0)-nvl(wpb.pl_overhead_out,0)-nvl(wpb.tl_overhead_var,0)-nvl(wpb.pl_overhead_var,0)+
nvl(wpb.tl_scrap_in,0)-nvl(wpb.tl_scrap_out,0)-nvl(wpb.tl_scrap_var,0)) wip_value_unrounded,
round(sum(nvl(wpb.pl_material_in,0)+nvl(wpb.pl_material_overhead_in,0)+nvl(wpb.tl_resource_in,0)+nvl(wpb.pl_resource_in,0)+nvl(wpb.tl_outside_processing_in,0)+
nvl(wpb.pl_outside_processing_in,0)+nvl(wpb.tl_overhead_in,0)+nvl(wpb.pl_overhead_in,0)+nvl(wpb.tl_scrap_in,0))) wip_costs_in,
sum(nvl(wpb.pl_material_in,0)+nvl(wpb.pl_material_overhead_in,0)+nvl(wpb.tl_resource_in,0)+nvl(wpb.pl_resource_in,0)+nvl(wpb.tl_outside_processing_in,0)+
nvl(wpb.pl_outside_processing_in,0)+nvl(wpb.tl_overhead_in,0)+nvl(wpb.pl_overhead_in,0)+nvl(wpb.tl_scrap_in,0)) wip_costs_in_unrounded
from
wip_period_balances wpb
group by
wpb.wip_entity_id
) wpb
where
1=1 and
wdj.status_type=4 and
wdj.date_completed is not null and
wdj.date_closed is null and
wdj.wip_entity_id=we.wip_entity_id and
wdj.class_code=wac.class_code and
wdj.organization_id=wac.organization_id and
wac.class_type in (1,3,5) and
wdj.organization_id=mp.organization_id and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
wdj.organization_id=msiv.organization_id and
wdj.primary_item_id=msiv.inventory_item_id and
wdj.wip_entity_id=wpb.wip_entity_id
) x
where
coalesce(x.open_material_quantities,x.no_earned_osp,x.unprocessed_material,x.uncosted_material,x.pending_wip_costing,x.pending_receiving,x.pending_requisitions,x.pending_material,x.pending_shop_floor_move,x.uncosted_split_merge_txn,x.unprocessed_wsm_txn_interface,x.pending_resulting_lots,x.pending_wsm_job_lots,case when x.open_quantity>0 then 'Y' end) is null and
abs(x.wip_value_unrounded)<:p_wip_var_threshold and
abs(round(x.wip_value_unrounded/decode(x.wip_costs_in_unrounded,0,1,x.wip_costs_in_unrounded),3)*100)<:p_wip_var_percent
order by
x.ledger,
x.operating_unit,
x.org_code,
x.wip_job
