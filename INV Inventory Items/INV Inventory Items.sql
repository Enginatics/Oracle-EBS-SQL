/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Inventory Items
-- Description: Master data report that lists item master attributes such as item type, UOM, status, serial control, account numbers and various other attributes
-- Excel Examle Output: https://www.enginatics.com/example/inv-inventory-items/
-- Library Link: https://www.enginatics.com/reports/inv-inventory-items/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
haouv.name organization_name,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
msiv.concatenated_segments item,
msiv.description,
msiv.long_description,
&columns
misv.inventory_item_status_code_tl item_status,
muot.unit_of_measure_tl primary_uom,
msiv.unit_weight,
msiv.weight_uom_code weight_uom,
msiv.unit_volume,
msiv.volume_uom_code volume_uom,
msiv.unit_length,
msiv.unit_width,
msiv.unit_height,
msiv.dimension_uom_code dimension_uom,
xxen_util.meaning(msiv.lot_control_code,'MTL_LOT_CONTROL',700) lot_control,
msiv.shelf_life_days,
nvl(xxen_util.meaning(msiv.serial_number_control_code,'CSP_INV_ITEM_SERIAL_CONTROL',0),xxen_util.meaning(msiv.serial_number_control_code,'MTL_SERIAL_NUMBER',700)) serial_control,
xxen_util.meaning(msiv.bom_item_type,'BOM_ITEM_TYPE',700) bom_item_type,
xxen_util.meaning(msiv.costing_enabled_flag,'YES_NO',0) costing_enabled,
xxen_util.meaning(msiv.inventory_asset_flag,'YES_NO',0) inventory_asset_value,
xxen_util.meaning(msiv.default_include_in_rollup_flag,'YES_NO',0) include_in_rollup,
gcc.concatenated_segments cost_of_goods_sold_account,
xxen_util.meaning(msiv.serv_req_enabled_code,'CS_SR_SERV_REQ_ENABLED_TYPE',170) serv_req_enabled_code,
xxen_util.meaning(msiv.serviceable_product_flag,'YES_NO',0) enable_contract_coverage,
xxen_util.meaning(msiv.comms_nl_trackable_flag,'YES_NO',0) track_in_installed_base,
xxen_util.meaning(msiv.serviceable_product_flag,'YES_NO',0) enable_contract_coverage,
xxen_util.meaning(msiv.serviceable_component_flag,'YES_NO',0) serviceable_component_flag,
xxen_util.meaning(msiv.contract_item_type_code,'OKB_CONTRACT_ITEM_TYPE',0) contract_item_type,
msiv.service_duration,
(select muot.unit_of_measure from mtl_units_of_measure_tl muot where msiv.service_duration_period_code=muot.uom_code and muot.language=userenv('lang')) service_duration_period,
(select oklv.name from okc_k_lines_v oklv where msiv.coverage_schedule_id=oklv.id) coverate_template,
msiv.service_starting_delay service_starting_delay_days,
(select xxen_util.meaning('Y','YES_NO',0) from csi_item_instances cii where msiv.inventory_item_id=cii.inventory_item_id and cii.accounting_class_code='CUST_PROD' and rownum=1) ib_exists,
ccg.name counter_group,
xxen_util.user_name(msiv.created_by) created_by,
xxen_util.client_time(msiv.creation_date) creation_date,
xxen_util.user_name(msiv.last_updated_by) last_updated_by,
xxen_util.client_time(msiv.last_update_date) last_update_date,
mm.manufacturer_name manufaturer,
mmpn.mfg_part_num manufacturer_part_number,
fcbk.concatenated_segments asset_category,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_or_buy,
ppx.full_name buyer,
msiv.planner_code planner,
mpl.description planner_description,
xxen_util.meaning(msiv.inventory_planning_code,'MTL_MATERIAL_PLANNING',700) inventory_planning_method,
(select distinct max(mss.safety_stock_quantity) keep (dense_rank last order by mss.effectivity_date) over (partition by mss.organization_id,mss.inventory_item_id) safety_stock from mtl_safety_stocks mss where msiv.organization_id=mss.organization_id and msiv.inventory_item_id=mss.inventory_item_id and mss.effectivity_date<=sysdate) safety_stock,
msiv.min_minmax_quantity,
msiv.max_minmax_quantity,
msiv.minimum_order_quantity,
msiv.maximum_order_quantity,
msiv.fixed_order_quantity,
msiv.fixed_lot_multiplier,
xxen_util.meaning(msiv.mrp_planning_code,'MRP_PLANNING_CODE',700) planning_method,
xxen_util.meaning(msiv.ato_forecast_control,'MRP_ATO_FORECAST_CONTROL',700) forecast_control,
xxen_util.meaning(msiv.end_assembly_pegging_flag,'ASSEMBLY_PEGGING_CODE',0) pegging,
xxen_util.meaning(msiv.planning_time_fence_code,'MTL_TIME_FENCE',700) planning_time_fence,
msiv.planning_time_fence_days,
msiv.full_lead_time processing_lead_time,
xxen_util.meaning(msiv.atp_flag,'ATP_FLAG',3) check_atp,
mar.rule_name atp_rule,
xxen_util.meaning(msiv.atp_components_flag,'ATP_FLAG',3) atp_components,
xxen_util.meaning(msiv.internal_order_flag,'YES_NO',0) internal_order_flag,
xxen_util.meaning(msiv.pick_components_flag,'YES_NO',0) pick_components,
xxen_util.meaning(msiv.replenish_to_order_flag,'YES_NO',0) assemble_to_order,
xxen_util.meaning(msiv.returnable_flag,'YES_NO',0) returnable,
xxen_util.meaning(msiv.customer_order_enabled_flag,'YES_NO',0) customer_orders_enabled,
xxen_util.meaning(msiv.shippable_item_flag,'YES_NO',0) shippable,
mp2.organization_code default_shipping_org,
msiv.default_so_source_type default_so_source_type,
xxen_util.meaning(msiv.inventory_item_flag,'YES_NO',0) inventory_item_flag,
xxen_util.meaning(msiv.stock_enabled_flag,'YES_NO',0) stock_enabled_flag,
xxen_util.meaning(msiv.mtl_transactions_enabled_flag,'YES_NO',0) transactable,
xxen_util.meaning(msiv.so_transactions_flag,'YES_NO',0) oe_transactable,
xxen_util.meaning(msiv.purchasing_enabled_flag,'YES_NO',0) purchasable,
xxen_util.meaning(msiv.customer_order_flag,'YES_NO',0) customer_ordered,
xxen_util.meaning(msiv.internal_order_enabled_flag,'YES_NO',0) internal_orders_enabled,
xxen_util.meaning(msiv.invoiceable_item_flag,'YES_NO',0) invoiceable_item,
xxen_util.meaning(msiv.invoice_enabled_flag,'YES_NO',0) invoice_enabled,
&flexfield_columns
msiv.inventory_item_id
from
hr_all_organization_units_vl haouv,
mtl_parameters mp,
mtl_system_items_vl msiv,
mtl_parameters mp2,
mtl_units_of_measure_tl muot,
mtl_item_status_vl misv,
cs_ctr_associations cca,
cs_counter_groups ccg,
per_people_x ppx,
fa_categories_b_kfv fcbk,
mtl_mfg_part_numbers mmpn,
mtl_manufacturers mm,
gl_code_combinations_kfv gcc,
(
select
mic.organization_id,
mic.inventory_item_id,
mcsv.category_set_name,
mck.concatenated_segments
from
mtl_item_categories mic,
mtl_category_sets_v mcsv,
mtl_categories_kfv mck
where
'&enable_categories'='Y' and
2=2 and
mic.category_set_id=mcsv.category_set_id and
mic.category_id=mck.category_id
) x,
&xrrpv_table
mtl_atp_rules mar,
mtl_planners mpl
where
1=1 and
msiv.organization_id=haouv.organization_id and
msiv.organization_id=mp.organization_id and
msiv.default_shipping_org=mp2.organization_id(+) and
msiv.primary_uom_code=muot.uom_code(+) and
muot.language(+)=userenv('lang') and
msiv.inventory_item_status_code=misv.inventory_item_status_code(+) and
msiv.inventory_item_id=cca.source_object_id(+) and
cca.counter_group_id=ccg.counter_group_id(+) and
msiv.buyer_id=ppx.person_id(+) and
msiv.asset_category_id=fcbk.category_id(+) and
msiv.inventory_item_id=mmpn.inventory_item_id(+) and
msiv.organization_id=mmpn.organization_id(+) and
mmpn.manufacturer_id=mm.manufacturer_id(+) and
msiv.cost_of_sales_account=gcc.code_combination_id(+) and
msiv.organization_id=x.organization_id(+) and
msiv.inventory_item_id=x.inventory_item_id(+) and
msiv.atp_rule_id=mar.rule_id(+) and
msiv.planner_code=mpl.planner_code(+) and
msiv.organization_id=mpl.organization_id(+)
order by
mp.organization_code,
msiv.concatenated_segments,
x.category_set_name