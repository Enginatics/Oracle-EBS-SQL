/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Plan Order Upload
-- Description: Report: MSC Plan Orders Upload
Description: Upload to action Plan Order recommendations.

This upload can be used to either select for release or release Plan Order Recommendations from ASCP planning instances.

Currently supported recommendations that can be actioned by this upload are:
- Planned Order Releases
- Reschedule In/Out recommendations

 Additionally, it allows the user to amend the recommended Implement Date and/or Quantity.

In the generated Excel the user can amend the following columns:
- Implement Date
- Implement Quantity
- Update Release Status

Update Release Status can be either
- Select for Release
- Release the Order

This is determined by the Report Parameter: Upload Mode

For plan orders not yet selected for release, to amend the implement date and/or implement quantity, the Update Release Status column must also be specified as 'Select for Release' or 'Release the Order' against the Plan Order. 
If a plan order is already selected for release, then the user can amend the implement date and/or quantity in the generated excel without specifying a value in the Update Release Status column.

The report parameter Upload mode determines the allowable action to be taken against the plan order recommendations in the upload ('Select for Release' or 'Release the Order') 

The report parameter Auto Populate Release Status  if set to Yes, will automatically populate the 'Update Release Status' column and set the status to pending validation against all downloaded plan order recommendations in the generated excel. 
In this scenario, the generated excel can be saved and uploaded without the user needing to manually review and select the specific plan orders to be updated in the generated excel

-- Excel Examle Output: https://www.enginatics.com/example/msc-plan-order-upload/
-- Library Link: https://www.enginatics.com/reports/msc-plan-order-upload/
-- Run Report: https://demo.enginatics.com/

with
q_selected_items as
(select /*+ materialize */distinct
  msi.sr_instance_id,
  msi.plan_id,
  msi.organization_id,
  msi.inventory_item_id
 from
  msc_system_items&a2m_dblink       msi,
  msc_item_categories&a2m_dblink    mic
 where
     msi.sr_instance_id      = mic.sr_instance_id
 and msi.organization_id     = mic.organization_id
 and msi.inventory_item_id   = mic.inventory_item_id
 and mic.category_set_id     = nvl(xxen_msc.get_category_set_id&a2m_dblink(:p_instance_code,:p_category_set_name),(select mcs.category_set_id from msc_category_sets&a2m_dblink mcs where mcs.sr_instance_id = msi.sr_instance_id and mcs.default_flag = 1))
 and 1=1
),
q_sub_components as
(select distinct
  mbc.sr_instance_id,
  xxen_msc.get_plan_id&a2m_dblink(:p_instance_code,:p_plan_name) plan_id,
  mbc.organization_id,
  mbc.inventory_item_id
 from
  msc_boms&a2m_dblink mb,
  msc_bom_components&a2m_dblink mbc
 where
     mb.alternate_bom_designator is null
 and mb.sr_instance_id = mbc.sr_instance_id
 and mb.plan_id = mbc.plan_id
 and mb.organization_id = mbc.organization_id
 and mb.bill_sequence_id = mbc.bill_sequence_id
 connect by nocycle
     prior mbc.sr_instance_id = mb.sr_instance_id
 and prior mbc.plan_id = mb.plan_id
 and prior mbc.organization_id = mb.organization_id
 and prior mbc.inventory_item_id = mb.assembly_item_id
 start with
 (mb.sr_instance_id,mb.plan_id,mb.organization_id,mb.assembly_item_id) in
 (select
  msi.sr_instance_id,
  -1,
  msi.organization_id,
  msi.inventory_item_id
  from
  q_selected_items msi
  where
  nvl(:p_explode_boms,decode(nvl(:p_called_from_schub,'N'),'Y',decode(nvl(xxen_api.user_preference('BOM_EXPLOSION_DEFAULT','XXEN_SCHUB'),'expanded'),'expanded','Y',null),null)) = 'Y'
 )
),
q_all_items as
(select
  msi.sr_instance_id,
  msi.plan_id,
  msi.organization_id,
  msi.inventory_item_id
 from
  q_selected_items msi
 union
 select
  msi.sr_instance_id,
  msi.plan_id,
  msi.organization_id,
  msi.inventory_item_id
 from
  q_sub_components msi
)
--
-- Main Query
select /*+ driving_site(mov) */
mov.*,
-- custom attributes from lookup XXEN_MSC_CUSTOM_ATTRIBUTES
&lp_custom_attributes
-- item dff attributes
&lp_item_dff_cols
'.' last_col_flag
from
(
select
case when :p_autopopulate_release_status is not null and :p_upload_mode is not null then xxen_upload.action_meaning&a2m_dblink(xxen_upload.action_update&a2m_dblink) else null end action_,
case when :p_autopopulate_release_status is not null and :p_upload_mode is not null then xxen_upload.status_meaning&a2m_dblink(xxen_upload.status_new&a2m_dblink) else null end status_,
case when :p_autopopulate_release_status is not null and :p_upload_mode is not null then xxen_util.description&a2m_dblink('U_EXCEL_MSG_VALIDATION_PENDING','XXEN_REPORT_TRANSLATIONS',0) else null end message_,
null                                            request_id_,
null modified_columns_,
nvl(:p_instance_code,mai.instance_code)         instance,
nvl(:p_plan_name,mp.compile_designator)         plan,
mpo.organization_code                           organization,
decode(mov.project_id, null, null, msc_get_name.project&a2m_dblink(mov.project_id, mov.organization_id, mov.plan_id, mov.sr_instance_id)) project_number,
decode(mov.task_id, null, null, msc_get_name.task&a2m_dblink(mov.task_id, mov.project_id, mov.organization_id, mov.plan_id, mov.sr_instance_id)) task_number,
msi.planner_code                                planner,
msi.buyer_name                                  buyer_name,
--
msc_get_name.lookup_meaning&a2m_dblink('MTL_PLANNING_MAKE_BUY',msi.planning_make_buy_code) make_buy,
msi.item_name item,
msi.description item_description,
nvl(:p_category_set_name,(select mcs.category_set_name from msc_category_sets&a2m_dblink mcs where mcs.sr_instance_id = mov.sr_instance_id and mcs.default_flag = 1)) category_set,
mic.category_name category,
(select distinct
   max(mss.safety_stock_quantity) keep (dense_rank last order by mss.period_start_date) over (partition by mss.organization_id,mss.inventory_item_id) safety_stock
 from
  msc_safety_stocks&a2m_dblink mss
 where
     mss.sr_instance_id     = mov.sr_instance_id
 and mss.plan_id            = mov.plan_id
 and mss.organization_id    = mov.organization_id
 and mss.inventory_item_id  = mov.inventory_item_id
 and mss.period_start_date <= sysdate
) safety_stock,
--
xxen_util.meaning&a2m_dblink('SUPPLY','MSC_QUESTION_TYPE',3) supply_demand,
decode(mp.plan_type
      , 8,decode(mov.order_type
                , 1, msc_get_name.lookup_meaning&a2m_dblink('SRP_CHANGED_ORDER_TYPE',mov.order_type)
                , 2, decode(mov.source_organization_id, null, msc_get_name.lookup_meaning&a2m_dblink('SRP_CHANGED_ORDER_TYPE',mov.order_type), msc_get_name.lookup_meaning&a2m_dblink('MRP_ORDER_TYPE',53))
                ,51, msc_get_name.lookup_meaning&a2m_dblink('SRP_CHANGED_ORDER_TYPE',mov.order_type)
                   , msc_get_name.lookup_meaning&a2m_dblink('MRP_ORDER_TYPE',decode(mov.order_type,92,70,mov.order_type))
                )
      ,msc_get_name.lookup_meaning&a2m_dblink('MRP_ORDER_TYPE',decode(mov.order_type,92,70,mov.order_type))
      ) order_type,
msc_get_name.supply_order_number&a2m_dblink(mov.order_type ,mov.order_number ,mov.plan_id ,mov.sr_instance_id ,mov.transaction_id ,mov.disposition_id) order_number,
trunc(mov.need_by_date)  need_by_date,
trunc(mov.promised_date)  promise_date,
trunc(mov.old_schedule_date)  old_due_date,
trunc(mov.new_schedule_date)  suggested_due_date,
nvl(mov.daily_rate,mov.new_order_quantity) quantity,
msc_get_name.action&a2m_dblink('MSC_SUPPLIES', msi.bom_item_type, msi.base_item_id, msi.wip_supply_type, mov.order_type, mov.reschedule_flag, mov.disposition_status_type, mov.new_schedule_date, mov.old_schedule_date, mov.implemented_quantity, mov.quantity_in_process, mov.new_order_quantity, msi.release_time_fence_code, mov.reschedule_days, mov.firm_quantity, mov.plan_id, msi.critical_component_flag, msi.mrp_planning_code, msi.lots_exist, mov.item_type_value, mov.transaction_id) action,
--
nvl(decode(mov.implement_as,null,null,msc_get_name.lookup_meaning&a2m_dblink('MRP_WORKBENCH_IMPLEMENT_AS',mov.implement_as))
   ,xxen_util.meaning&a2m_dblink(xxen_msc_rel_plan_api.implement_as&a2m_dblink
     ( mov.sr_instance_id
     , mp.plan_type
     , 'MSC_SUPPLIES'
     , mov.order_type
     , mov.organization_id
     , msi.purchasing_enabled_flag
     , msi.planning_make_buy_code
     , msi.build_in_wip_flag
     , msi.repetitive_type
     , mov.source_sr_instance_id
     , mov.source_organization_id
     , mov.source_supplier_id
     , null -- dest_inst_id
     , null -- dest_org_id
     ),'MRP_WORKBENCH_IMPLEMENT_AS',700)
   )                                     implement_as,
nvl(mov.implement_date,
     xxen_msc_rel_plan_api.implement_date&a2m_dblink
     ( mov.sr_instance_id
     , mov.plan_id
     , mp.plan_type
     , mov.organization_id
     , 'MSC_SUPPLIES'
     , mov.transaction_id
     , mov.order_type
     , -- implement_as
       nvl(mov.implement_as
          ,xxen_msc_rel_plan_api.implement_as&a2m_dblink
           ( mov.sr_instance_id
           , mp.plan_type
           , 'MSC_SUPPLIES'
           , mov.order_type
           , mov.organization_id
           , msi.purchasing_enabled_flag
           , msi.planning_make_buy_code
           , msi.build_in_wip_flag
           , msi.repetitive_type
           , mov.source_sr_instance_id
           , mov.source_organization_id
           , mov.source_supplier_id
           , null -- dest_inst_id
           , null -- dest_org_id
           ))
     , mov.new_schedule_date
     , mov.last_unit_completion_date
     , mov.firm_date
     , mov.new_ship_date
     , null -- dmd_satisfied_date
    ))                      implement_date,
nvl(nvl(mov.implement_daily_rate,mov.implement_quantity),
     xxen_msc_rel_plan_api.implement_qty_rate&a2m_dblink
     ( mov.sr_instance_id
     , mov.plan_id
     , 'MSC_SUPPLIES'
     , mov.transaction_id
     , mov.order_type
     , mov.disposition_status_type
     , mov.original_quantity
     , nvl(mov.daily_rate,mov.new_order_quantity)
     , mov.firm_quantity
     , mov.quantity_in_process
     , mov.implemented_quantity
    ))                                    implement_quantity,
case when :p_autopopulate_release_status is not null then :p_upload_mode else null end update_release_status,
--
case
when  mov.release_status = 1
then  'Selected'
when  mov.reschedule_flag = 1
and   nvl(mov.implement_daily_rate,mov.implement_quantity) = 0
then  'Cancelled'
when  mov.reschedule_flag = 1
then  'Recheduled'
when  mov.implemented_quantity is not null
then  'Released'
else  null
end                                             released_status,
mov.implemented_quantity                        implemented_quantity,
--
msc_get_name.get_order_comments&a2m_dblink(mov.plan_id, 'SUPPLY', mov.transaction_id) comments,
decode(mov.firm_planned_type, 1, 'Y',null)      firm,
trunc(mov.firm_date)                            firm_date,
mov.firm_quantity                               firm_quantity,
--
msc_get_name.org_code&a2m_dblink(mov.source_organization_id,mov.source_sr_instance_id) source_organization,
msc_get_name.supplier&a2m_dblink(mov.supplier_id) supplier,
msc_get_name.supplier_site&a2m_dblink(mov.supplier_site_id) supplier_site,
--
mov.reschedule_days                             reschedule_days,
decode(mp.plan_type, 5, to_number(null), mov.schedule_priority) order_priority,
--
'SUPPLY' supply_demand_code,
mov.transaction_id,
mov.sr_instance_id,
mov.plan_id,
mov.organization_id,
mov.inventory_item_id,
msi.sr_inventory_item_id,
mic.category_set_id category_set_id,
nvl(mov.release_status,2) release_status
from
msc_supplies&a2m_dblink           mov,
msc_apps_instances&a2m_dblink     mai,
msc_plans&a2m_dblink              mp,
msc_plan_organizations&a2m_dblink mpo,
msc_system_items&a2m_dblink       msi,
msc_item_categories&a2m_dblink    mic
where
2=2
and mov.sr_instance_id              = mai.instance_id
and mov.plan_id                     = mp.plan_id
and mov.sr_instance_id              = mpo.sr_instance_id
and mov.plan_id                     = mpo.plan_id
and mov.organization_id             = mpo.organization_id
and mov.sr_instance_id              = msi.sr_instance_id
and mov.plan_id                     = msi.plan_id
and mov.organization_id             = msi.organization_id
and mov.inventory_item_id           = msi.inventory_item_id
and mov.sr_instance_id              = mic.sr_instance_id
and mov.inventory_item_id           = mic.inventory_item_id
and mov.organization_id             = mic.organization_id
and mic.category_set_id             = nvl(xxen_msc.get_category_set_id&a2m_dblink(:p_instance_code,:p_category_set_name),(select mcs.category_set_id from msc_category_sets&a2m_dblink mcs where sr_instance_id = mov.sr_instance_id and mcs.default_flag = 1))
and (mov.sr_instance_id,mov.plan_id,mov.organization_id,mov.inventory_item_id) in
    (select
     qai.sr_instance_id,
     qai.plan_id,
     qai.organization_id,
     qai.inventory_item_id
     from
     q_all_items qai
    )
and nvl(nvl(mov.daily_rate,mov.new_order_quantity),0) != 0
and nvl(mov.implemented_quantity,0) = 0
and (   xxen_util.lookup_code&a2m_dblink(msc_get_name.action&a2m_dblink('MSC_SUPPLIES', msi.bom_item_type, msi.base_item_id, msi.wip_supply_type, mov.order_type, mov.reschedule_flag, mov.disposition_status_type, mov.new_schedule_date, mov.old_schedule_date, mov.implemented_quantity, mov.quantity_in_process, mov.new_order_quantity, msi.release_time_fence_code, mov.reschedule_days, mov.firm_quantity, mov.plan_id, msi.critical_component_flag, msi.mrp_planning_code, msi.lots_exist, mov.item_type_value, mov.transaction_id)
                             ,'MRP_ACTIONS',700) in (2,3,4) -- Reschedule In, Reschedule Out, Release
     or mov.release_status = 1
    )
and (nvl(:p_called_from_schub,'N') = 'N' or mov.order_type = 5)
and nvl('&m2a_dblink','?') = nvl('&m2a_dblink','?')
and nvl(:p_show_item_dff,'?') = nvl(:p_show_item_dff,'?')
) mov
where
3=3