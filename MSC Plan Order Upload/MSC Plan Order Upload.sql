/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Plan Order Upload
-- Description: Report: MSC Plan Orders Upload
Description: ASCP: Upload to action Plan Order recommendations.

This upload can be used to either select for release or release Plan Order Recommendations.

Currently supported recommendations that can be actioned by this upload are:
-	Planned Order Releases
-	Reschedule In/Out recommendations

 Additionally, it allows the user to amend the recommended Implement Date and/or Quantity.

In the generated Excel the user can amend the following columns:
-	Implement Date
-	Implement Quantity
-	Update Release Status

Update Release Status can be either
-	Select for Release
-	Release the Order

This is determined by the Report Parameter: Allow Release in Upload

If left null, then the user can only “Select for Release”
If set to Yes, then the user can only select “Release the Order”

‘Select for Release’ will update the implement date and quantity and flag the Plan Order for Release.
‘Release the Order’ will update the implement date and quantity and release the Plan Order

For Plan Orders not yet selected for release, to amend the implement date and/or implement quantity, the plan order must also be either selected for release or released.

If a plan order is already selected for release, then the user can amend the implement date and/or quantity in the generated excel without specifying a value in the Update Release Status column.

-- Excel Examle Output: https://www.enginatics.com/example/msc-plan-order-upload/
-- Library Link: https://www.enginatics.com/reports/msc-plan-order-upload/
-- Run Report: https://demo.enginatics.com/

select
x.*,
-- custom attributes from lookup XXEN_MSC_CUSTOM_ATTRIBUTES
&lp_custom_attributes
-- item dff attributes
&lp_item_dff_cols
'.' last_col_flag
from
(
select
mov.*
from
(
select
 case when :p_autopopulate_release_status is not null and :p_upload_mode is not null then 'Update' else null end action_,
 case when :p_autopopulate_release_status is not null and :p_upload_mode is not null then 'New' else null end status_,
 case when :p_autopopulate_release_status is not null and :p_upload_mode is not null then 'Validation pending' else null end message_,
 null                                            request_id_,
 nvl(:p_instance_code,mai.instance_code)         instance,
 nvl(:p_plan_name,mp.compile_designator)         plan,
 mpo.organization_code                           organization,
 decode(mov.project_id, null, null, msc_get_name.project(mov.project_id, mov.organization_id, mov.plan_id, mov.sr_instance_id)) project_number,
 decode(mov.task_id, null, null, msc_get_name.task(mov.task_id, mov.project_id, mov.organization_id, mov.plan_id, mov.sr_instance_id)) task_number,
 msi.planner_code                                planner,
 msi.buyer_name                                  buyer_name,
 --
 msc_get_name.lookup_meaning ('MTL_PLANNING_MAKE_BUY',msi.planning_make_buy_code) make_buy,
 msi.item_name item,
 msi.description item_description,
 nvl(:p_category_set_name,(select mcs.category_set_name from msc_category_sets mcs where sr_instance_id = mov.sr_instance_id and mcs.default_flag = 1)) category_set,
 mic.category_name category,
 (select distinct
    max(mss.safety_stock_quantity) keep (dense_rank last order by mss.period_start_date) over (partition by mss.organization_id,mss.inventory_item_id) safety_stock
  from
   msc_safety_stocks mss
  where
      mss.sr_instance_id     = mov.sr_instance_id
  and mss.plan_id            = mov.plan_id
  and mss.organization_id    = mov.organization_id
  and mss.inventory_item_id  = mov.inventory_item_id
  and mss.period_start_date <= sysdate
 ) safety_stock,
 --
 xxen_util.meaning('SUPPLY','MSC_QUESTION_TYPE',3) supply_demand,
 decode(mp.plan_type
       , 8,decode(mov.order_type
                 , 1, msc_get_name.lookup_meaning('SRP_CHANGED_ORDER_TYPE',mov.order_type)
                 , 2, decode(mov.source_organization_id, null, msc_get_name.lookup_meaning('SRP_CHANGED_ORDER_TYPE',mov.order_type), msc_get_name.lookup_meaning('MRP_ORDER_TYPE',53))
                 ,51, msc_get_name.lookup_meaning('SRP_CHANGED_ORDER_TYPE',mov.order_type)
                    , msc_get_name.lookup_meaning('MRP_ORDER_TYPE',decode(mov.order_type,92,70,mov.order_type))
                 )
       ,msc_get_name.lookup_meaning('MRP_ORDER_TYPE',decode(mov.order_type,92,70,mov.order_type))
       ) order_type,
 msc_get_name.supply_order_number (mov.order_type ,mov.order_number ,mov.plan_id ,mov.sr_instance_id ,mov.transaction_id ,mov.disposition_id) order_number,
 to_char(trunc(mov.need_by_date),'DD-Mon-YYYY')  need_by_date,
 to_char(trunc(mov.promised_date),'DD-Mon-YYYY')  promise_date,
 to_char(trunc(mov.old_schedule_date),'DD-Mon-YYYY')  old_due_date,
 to_char(trunc(mov.new_schedule_date),'DD-Mon-YYYY')  suggested_due_date,
 nvl(mov.daily_rate,mov.new_order_quantity) quantity,
 msc_get_name.action('MSC_SUPPLIES', msi.bom_item_type, msi.base_item_id, msi.wip_supply_type, mov.order_type, mov.reschedule_flag, mov.disposition_status_type, mov.new_schedule_date, mov.old_schedule_date, mov.implemented_quantity, mov.quantity_in_process, mov.new_order_quantity, msi.release_time_fence_code, mov.reschedule_days, mov.firm_quantity, mov.plan_id, msi.critical_component_flag, msi.mrp_planning_code, msi.lots_exist, mov.item_type_value, mov.transaction_id) action,
 --
 nvl(decode(mov.implement_as,null,null,msc_get_name.lookup_meaning('MRP_WORKBENCH_IMPLEMENT_AS',mov.implement_as))
    ,nvl2(:p_default_impl_cols,
      xxen_util.meaning(xxen_msc_rel_plan_api.implement_as
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
     ,null))                                     implement_as,
 to_char(nvl(mov.implement_date,nvl2(:p_default_impl_cols,
      xxen_msc_rel_plan_api.implement_date
      ( mov.sr_instance_id
      , mov.plan_id
      , mp.plan_type
      , mov.organization_id
      , 'MSC_SUPPLIES'
      , mov.transaction_id
      , mov.order_type
      , -- implement_as
        nvl(mov.implement_as
           ,xxen_msc_rel_plan_api.implement_as
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
     ),null)),'DD-Mon-YYYY')                      implement_date,
 nvl(nvl(mov.implement_daily_rate,mov.implement_quantity),nvl2(:p_default_impl_cols,
      xxen_msc_rel_plan_api.implement_qty_rate
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
     ),null))                                    implement_quantity,
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
 msc_get_name.get_order_comments(mov.plan_id, 'SUPPLY', mov.transaction_id) comments,
 decode(mov.firm_planned_type, 1, 'Y',null)      firm,
 to_char(trunc(mov.firm_date),'DD-Mon-YYYY')     firm_date,
 mov.firm_quantity                               firm_quantity,
 --
 msc_get_name.org_code(mov.source_organization_id,mov.source_sr_instance_id) source_organization,
 msc_get_name.supplier(mov.supplier_id) supplier,
 msc_get_name.supplier_site(mov.supplier_site_id) supplier_site,
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
 msc_supplies           mov,
 msc_apps_instances     mai,
 msc_plans              mp,
 msc_plan_organizations mpo,
 msc_system_items       msi,
 msc_item_categories    mic
where
    mov.sr_instance_id              = mai.instance_id
and mov.plan_id                     = mp.plan_id
and mov.sr_instance_id              = mpo.sr_instance_id
and mov.plan_id                     = mpo.plan_id
and mov.organization_id             = mpo.organization_id
and mov.sr_instance_id              = msi.sr_instance_id
and mov.plan_id                     = msi.plan_id
and mov.organization_id             = msi.organization_id
and mov.inventory_item_id           = msi.inventory_item_id
and mov.sr_instance_id              =  mic.sr_instance_id
and mov.inventory_item_id           = mic.inventory_item_id
and mov.organization_id             = mic.organization_id
and mic.category_set_id             = nvl(:p_category_set_id,(select mcs.category_set_id from msc_category_sets mcs where sr_instance_id = mov.sr_instance_id and mcs.default_flag = 1))

and nvl(nvl(mov.daily_rate,mov.new_order_quantity),0) != 0
and nvl(mov.implemented_quantity,0) = 0
and (   xxen_util.lookup_code(msc_get_name.action('MSC_SUPPLIES', msi.bom_item_type, msi.base_item_id, msi.wip_supply_type, mov.order_type, mov.reschedule_flag, mov.disposition_status_type, mov.new_schedule_date, mov.old_schedule_date, mov.implemented_quantity, mov.quantity_in_process, mov.new_order_quantity, msi.release_time_fence_code, mov.reschedule_days, mov.firm_quantity, mov.plan_id, msi.critical_component_flag, msi.mrp_planning_code, msi.lots_exist, mov.item_type_value, mov.transaction_id)
                             ,'MRP_ACTIONS',700) in (2,3,4) -- Reschedule In, Reschedule Out, Release
     or mov.release_status = 1
    )
and nvl(:p_ebs_org_code,'?')=nvl(:p_ebs_org_code,'?')
and nvl('&m2a_dblink','?') = nvl('&m2a_dblink','?')
and nvl(:p_show_item_dff,'?') = nvl(:p_show_item_dff,'?')
and 1=1
) mov
where
2=2
--
&not_use_first_block
&report_table_select &report_table_name &report_table_where_clause &success_records1 &success_records2
&processed_run
--
) x
order by
x.instance,
x.plan,
x.organization,
x.planner,
x.item,
to_date(x.suggested_due_date,'DD-Mon-YYYY'),
x.order_type,
x.order_number