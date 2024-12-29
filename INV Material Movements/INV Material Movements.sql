/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Material Movements
-- Description: Detailed report of On Hand Quantity with stock movements by Item , Org Code .
Material Movements involve cumulative buckets for stock/in/mvmt and month wise non cumulative buckets for stock out

-- Excel Examle Output: https://www.enginatics.com/example/inv-material-movements/
-- Library Link: https://www.enginatics.com/reports/inv-material-movements/
-- Run Report: https://demo.enginatics.com/

select distinct ood.organization_name,
ood.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
to_char(msiv.creation_date,'DD-Mon-YYYY HH24:MI:SS') item_creation_date,
misv.inventory_item_status_code_tl item_status,
&category_columns
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy,
muomv.unit_of_measure_tl unit_of_measure,
sum(moqd.primary_transaction_quantity) over (partition by moqd.organization_id, moqd.inventory_item_id) on_hand,
cic.cost_type,
cic.item_cost,
round(sum(moqd.primary_transaction_quantity * nvl(cic.item_cost,0)) over (partition by moqd.organization_id, moqd.inventory_item_id),2) on_hand_value,
moqd.inventory_item_id,
moqd.organization_id,
mmt.stock_out_3m,
mmt.stock_out_6m,
mmt.stock_out_12m,
mmt.stock_out_24m,
mmt.stock_out_36m,
mmt.stock_in_3m,
mmt.stock_in_6m,
mmt.stock_in_12m,
mmt.stock_in_24m,
mmt.stock_in_36m,
mmt.stock_mvmt_3m,
mmt.stock_mvmt_6m,
mmt.stock_mvmt_12m,
mmt.stock_mvmt_24m,
mmt.stock_mvmt_36m,
mmt.stock_out_3m*nvl(cic.item_cost,0) value_out_3m,
mmt.stock_out_6m*nvl(cic.item_cost,0) value_out_6m,
mmt.stock_out_12m*nvl(cic.item_cost,0) value_out_12m,
mmt.stock_out_24m*nvl(cic.item_cost,0) value_out_24m,
mmt.stock_out_36m*nvl(cic.item_cost,0) value_out_36m,
mmt.stock_out_3m*nvl(cic.item_cost,0) value_in_3m,
mmt.stock_out_6m*nvl(cic.item_cost,0) value_in_6m,
mmt.stock_out_12m*nvl(cic.item_cost,0) value_in_12m,
mmt.stock_out_24m*nvl(cic.item_cost,0) value_in_24m,
mmt.stock_out_36m*nvl(cic.item_cost,0) value_in_36m,
mmt.stock_mvmt_3m*nvl(cic.item_cost,0) value_mvmt_3m,
mmt.stock_mvmt_6m*nvl(cic.item_cost,0) value_mvmt_6m,
mmt.stock_mvmt_12m*nvl(cic.item_cost,0) value_mvmt_12m,
mmt.stock_mvmt_24m*nvl(cic.item_cost,0) value_mvmt_24m,
mmt.stock_mvmt_36m*nvl(cic.item_cost,0) value_mvmt_36m,
/*adding cumulative buckets for stock/in/mvmt*/
mmt.stock_out_0_3m,
mmt.stock_out_0_6m ,
mmt.stock_out_0_12m,
mmt.stock_out_0_24m,
mmt.stock_out_0_36m,
mmt.stock_in_0_3m,
mmt.stock_in_0_6m,
mmt.stock_in_0_12m,
mmt.stock_in_0_24m,
mmt.stock_in_0_36m,
mmt.stock_mvmt_0_3m,
mmt.stock_mvmt_0_6m,
mmt.stock_mvmt_0_12m,
mmt.stock_mvmt_0_24m,
mmt.stock_mvmt_0_36m,
/*adding month wise non cumulative buckets for stock out*/
mmt.stock_out_1mo,
mmt.stock_out_2mo,
mmt.stock_out_3mo,
mmt.stock_out_4mo,
mmt.stock_out_5mo,
mmt.stock_out_6mo,
mmt.stock_out_7mo,
mmt.stock_out_8mo,
mmt.stock_out_9mo,
mmt.stock_out_10mo,
mmt.stock_out_11mo,
mmt.stock_out_12mo,
mmt.stock_out_13mo,
mmt.stock_out_14mo,
mmt.stock_out_15mo,
mmt.stock_out_16mo,
mmt.stock_out_17mo,
mmt.stock_out_18mo,
mmt.stock_out_19mo,
mmt.stock_out_20mo,
mmt.stock_out_21mo,
mmt.stock_out_22mo,
mmt.stock_out_23mo,
mmt.stock_out_24mo
from
org_organization_definitions ood,
mtl_onhand_quantities_detail moqd,
mtl_item_status_vl misv,
mtl_system_items_vl msiv,
mtl_units_of_measure_vl muomv,
(
select
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-3) then mmt.primary_quantity end) stock_out_3m,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-6) and mmt.transaction_date<=add_months(sysdate,-3) then mmt.primary_quantity end) stock_out_6m,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-12) and mmt.transaction_date<=add_months(sysdate,-6) then mmt.primary_quantity end) stock_out_12m,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-24) and mmt.transaction_date<=add_months(sysdate,-12) then mmt.primary_quantity end) stock_out_24m,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-36) and mmt.transaction_date<=add_months(sysdate,-24) then mmt.primary_quantity end) stock_out_36m,
sum(case when mmt.transaction_action_id in (27,12,31,33) and mmt.transaction_date>add_months(sysdate,-3) then mmt.primary_quantity end) stock_in_3m,
sum(case when mmt.transaction_action_id in (27,12,31,33) and mmt.transaction_date>add_months(sysdate,-6) and mmt.transaction_date<=add_months(sysdate,-3) then mmt.primary_quantity end) stock_in_6m,
sum(case when mmt.transaction_action_id in (27,12,31,33) and mmt.transaction_date>add_months(sysdate,-12) and mmt.transaction_date<=add_months(sysdate,-6) then mmt.primary_quantity end) stock_in_12m,
sum(case when mmt.transaction_action_id in (27,12,31,33) and mmt.transaction_date>add_months(sysdate,-24) and mmt.transaction_date<=add_months(sysdate,-12) then mmt.primary_quantity end) stock_in_24m,
sum(case when mmt.transaction_action_id in (27,12,31,33) and mmt.transaction_date>add_months(sysdate,-36) and mmt.transaction_date<=add_months(sysdate,-24) then mmt.primary_quantity end) stock_in_36m,
sum(case when mmt.transaction_date>add_months(sysdate,-3) then mmt.primary_quantity end) stock_mvmt_3m,
sum(case when mmt.transaction_date>add_months(sysdate,-6) and mmt.transaction_date<=add_months(sysdate,-3) then mmt.primary_quantity end) stock_mvmt_6m,
sum(case when mmt.transaction_date>add_months(sysdate,-12) and mmt.transaction_date<=add_months(sysdate,-6) then mmt.primary_quantity end) stock_mvmt_12m,
sum(case when mmt.transaction_date>add_months(sysdate,-24) and mmt.transaction_date<=add_months(sysdate,-12) then mmt.primary_quantity end) stock_mvmt_24m,
sum(case when mmt.transaction_date>add_months(sysdate,-36) and mmt.transaction_date<=add_months(sysdate,-24) then mmt.primary_quantity end) stock_mvmt_36m,
/*adding cumulative buckets for stock/in/mvmt*/
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-3) then mmt.primary_quantity end) stock_out_0_3m,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-6) then mmt.primary_quantity end) stock_out_0_6m,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-12)then mmt.primary_quantity end) stock_out_0_12m,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-24)then mmt.primary_quantity end) stock_out_0_24m,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-36)then mmt.primary_quantity end) stock_out_0_36m,
sum(case when mmt.transaction_action_id in (27,12,31,33) and mmt.transaction_date>add_months(sysdate,-3) then mmt.primary_quantity end) stock_in_0_3m,
sum(case when mmt.transaction_action_id in (27,12,31,33) and mmt.transaction_date>add_months(sysdate,-6) then mmt.primary_quantity end) stock_in_0_6m,
sum(case when mmt.transaction_action_id in (27,12,31,33) and mmt.transaction_date>add_months(sysdate,-12) then mmt.primary_quantity end) stock_in_0_12m,
sum(case when mmt.transaction_action_id in (27,12,31,33) and mmt.transaction_date>add_months(sysdate,-24) then mmt.primary_quantity end) stock_in_0_24m,
sum(case when mmt.transaction_action_id in (27,12,31,33) and mmt.transaction_date>add_months(sysdate,-36) then mmt.primary_quantity end) stock_in_0_36m,
sum(case when mmt.transaction_date>add_months(sysdate,-3) then mmt.primary_quantity end) stock_mvmt_0_3m,
sum(case when mmt.transaction_date>add_months(sysdate,-6) then mmt.primary_quantity end) stock_mvmt_0_6m,
sum(case when mmt.transaction_date>add_months(sysdate,-12)then mmt.primary_quantity end) stock_mvmt_0_12m,
sum(case when mmt.transaction_date>add_months(sysdate,-24)then mmt.primary_quantity end) stock_mvmt_0_24m,
sum(case when mmt.transaction_date>add_months(sysdate,-36)then mmt.primary_quantity end) stock_mvmt_0_36m,
/*adding month wise non cumulative buckets for stock out*/
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-1) then mmt.primary_quantity end) stock_out_1mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-2) and mmt.transaction_date<=add_months(sysdate,-1) then mmt.primary_quantity end) stock_out_2mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-3) and mmt.transaction_date<=add_months(sysdate,-2) then mmt.primary_quantity end) stock_out_3mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-4) and mmt.transaction_date<=add_months(sysdate,-3) then mmt.primary_quantity end) stock_out_4mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-5) and mmt.transaction_date<=add_months(sysdate,-4) then mmt.primary_quantity end) stock_out_5mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-6) and mmt.transaction_date<=add_months(sysdate,-5) then mmt.primary_quantity end) stock_out_6mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-7) and mmt.transaction_date<=add_months(sysdate,-6) then mmt.primary_quantity end) stock_out_7mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-8) and mmt.transaction_date<=add_months(sysdate,-7) then mmt.primary_quantity end) stock_out_8mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-9) and mmt.transaction_date<=add_months(sysdate,-8) then mmt.primary_quantity end) stock_out_9mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-10) and mmt.transaction_date<=add_months(sysdate,-9) then mmt.primary_quantity end) stock_out_10mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-11) and mmt.transaction_date<=add_months(sysdate,-10) then mmt.primary_quantity end) stock_out_11mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-12) and mmt.transaction_date<=add_months(sysdate,-11) then mmt.primary_quantity end) stock_out_12mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-13) and mmt.transaction_date<=add_months(sysdate,-12) then mmt.primary_quantity end) stock_out_13mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-14) and mmt.transaction_date<=add_months(sysdate,-13) then mmt.primary_quantity end) stock_out_14mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-15) and mmt.transaction_date<=add_months(sysdate,-14) then mmt.primary_quantity end) stock_out_15mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-16) and mmt.transaction_date<=add_months(sysdate,-15) then mmt.primary_quantity end) stock_out_16mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-17) and mmt.transaction_date<=add_months(sysdate,-16) then mmt.primary_quantity end) stock_out_17mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-18) and mmt.transaction_date<=add_months(sysdate,-17) then mmt.primary_quantity end) stock_out_18mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-19) and mmt.transaction_date<=add_months(sysdate,-18) then mmt.primary_quantity end) stock_out_19mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-20) and mmt.transaction_date<=add_months(sysdate,-19) then mmt.primary_quantity end) stock_out_20mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-21) and mmt.transaction_date<=add_months(sysdate,-20) then mmt.primary_quantity end) stock_out_21mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-22) and mmt.transaction_date<=add_months(sysdate,-21) then mmt.primary_quantity end) stock_out_22mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-23) and mmt.transaction_date<=add_months(sysdate,-22) then mmt.primary_quantity end) stock_out_23mo,
sum(case when mmt.transaction_action_id in (1,21,3,32,34) and mmt.transaction_date>add_months(sysdate,-24) and mmt.transaction_date<=add_months(sysdate,-23) then mmt.primary_quantity end) stock_out_24mo,
mmt.inventory_item_id,
mmt.organization_id
from
mtl_material_transactions mmt,
mtl_parameters mp
where
2=2 and
:p_show_trx_hist is not null and
mmt.transaction_action_id in (1,21,27,12,31,33,3,32,34) and
mp.organization_id=mmt.organization_id and
case when :p_txn_date_from is not null and  mmt.transaction_date > :p_txn_date_from and mmt.transaction_date <=trunc(sysdate) then 1
when :p_txn_date_from is null and mmt.transaction_date>add_months(sysdate,-36) then 1
end=1
group by
mmt.inventory_item_id,
mmt.organization_id
) mmt,
(
select
cic.organization_id,
cic.inventory_item_id,
cct.cost_type,
cic.item_cost
from
mtl_parameters mp,
cst_cost_types cct,
cst_item_costs cic
where
cic.organization_id=mp.organization_id and
cic.cost_type_id=mp.primary_cost_method and
cic.cost_type_id=cct.cost_type_id
) cic
where
1=1 and
ood.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.organization_id=moqd.organization_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code(+) and
moqd.organization_id=msiv.organization_id and
moqd.inventory_item_id=msiv.inventory_item_id and
msiv.primary_uom_code=muomv.uom_code(+) and
moqd.inventory_item_id=mmt.inventory_item_id(+) and
moqd.organization_id=mmt.organization_id(+) and
moqd.organization_id=cic.organization_id(+)and
moqd.inventory_item_id=cic.inventory_item_id(+)
order by
ood.organization_code,
item
desc