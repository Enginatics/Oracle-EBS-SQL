/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Cycle count unscheduled items
-- Description: Imported Oracle standard Cycle count unscheduled items report
Source: Cycle count unscheduled items report (XML)
Short Name: INVARUIR_XML
DB package: INV_INVARUIR_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-cycle-count-unscheduled-items/
-- Library Link: https://www.enginatics.com/reports/inv-cycle-count-unscheduled-items/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
ood.organization_name,
gl.currency_code,
mcch.cycle_count_header_name cycle_count_name,
decode(mcch.autoschedule_enabled_flag,1, 'Yes', 'No') auto_schedule_flag,
case when decode(mcch.autoschedule_enabled_flag, 1, mcch.schedule_interval_time, -1)=-1 then null
else (select ml.meaning from mfg_lookups ml where ml.lookup_type = 'MTL_CC_SCHED_TIME' and ml.lookup_code=decode(mcch.autoschedule_enabled_flag, 1, mcch.schedule_interval_time, -1))
end scheduled_interval,
msiv.concatenated_segments item,
msiv.description description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
mcci.item_last_schedule_date,
mac.abc_class_name,
mcch.f_nworkdaysyear/decode( mccc.num_counts_per_year,null,1,0,1,mccc.num_counts_per_year) count_interval_work_days
from
mtl_abc_classes mac,
mtl_system_items_vl msiv,
(select mcch.*,
nvl(inv_invaruir_xmlp_pkg.f_nworkdaysyearformula(mcch.cycle_count_calendar, mcch.calendar_exception_set),0) f_nworkdaysyear
from
mtl_cycle_count_headers mcch
where
nvl(mcch.disable_date,sysdate+1)>sysdate) mcch,
mtl_cycle_count_items mcci,
mtl_cycle_count_classes mccc,
org_organization_definitions ood,
gl_ledgers gl
where
1=1 and
ood.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.set_of_books_id=gl.ledger_id and
mcch.organization_id=ood.organization_id and
msiv.organization_id=ood.organization_id and
mac.organization_id=ood.organization_id and
mcch.autoschedule_enabled_flag=1 and
mcci.abc_class_id=mac.abc_class_id and
mcci.cycle_count_header_id=mcch.cycle_count_header_id and
msiv.inventory_item_id=mcci.inventory_item_id and
mccc.abc_class_id=mac.abc_class_id and
mccc.cycle_count_header_id=mcch.cycle_count_header_id and
mccc.organization_id=ood.organization_id and
(((mcci.item_last_schedule_date +( mcch.f_nworkdaysyear/decode(mccc.num_counts_per_year,null,1,0,1,mccc.num_counts_per_year) ))<=sysdate)or (mcci.item_last_schedule_date is null ))
union all
select
ood.organization_code,
ood.organization_name,
gl.currency_code,
mcch.cycle_count_header_name cycle_count_name,
decode(mcch.autoschedule_enabled_flag,1, 'Yes', 'No') auto_schedule_flag,
case when decode(mcch.autoschedule_enabled_flag, 1, mcch.schedule_interval_time, -1)=-1 then null
else (select mfg.meaning from mfg_lookups mfg where mfg.lookup_type = 'MTL_CC_SCHED_TIME' and mfg.lookup_code = decode(mcch.autoschedule_enabled_flag, 1, mcch.schedule_interval_time, -1))
end scheduled_interval,
msiv.concatenated_segments item,
msiv.description description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
mcci.item_last_schedule_date,
mac.abc_class_name,
null count_interval_work_days
from
mtl_abc_classes mac,
mtl_system_items_vl msiv,
mtl_cycle_count_headers mcch,
mtl_cycle_count_items mcci,
org_organization_definitions ood,
gl_ledgers gl
where
1=1 and
ood.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.set_of_books_id=gl.ledger_id and
mcch.organization_id=ood.organization_id and
msiv.organization_id=ood.organization_id and
mac.organization_id=ood.organization_id and
nvl(mcch.disable_date,sysdate+1)>sysdate and
mcch.autoschedule_enabled_flag<>1 and
mcci.abc_class_id=mac.abc_class_id and
mcch.cycle_count_header_id=mcci.cycle_count_header_id and
msiv.inventory_item_id=mcci.inventory_item_id and
(((mcci.item_last_schedule_date+5)<=sysdate) or (mcci.item_last_schedule_date is null))
order by
abc_class_name,
item