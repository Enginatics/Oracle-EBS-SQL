/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: EAM Weekly Schedule
-- Description: Based on Oracle standard's EAM Weekly Schedule report
Application: Enterprise Asset Management
Source: EAM Weekly Schedule report (XML)
Short Name: EAMWSREP_XML
DB package: EAM_EAMWSREP_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/eam-weekly-schedule/
-- Library Link: https://www.enginatics.com/reports/eam-weekly-schedule/
-- Run Report: https://demo.enginatics.com/

select distinct
mp.organization_code,
we.wip_entity_name,
xxen_util.meaning(wdj.firm_planned_flag,'SYS_YES_NO',700) firm_planned_flag,
bd2.department_code owning_department,
we.description,
cii.instance_number asset,
cii.instance_description descriptive_text,
msib.concatenated_segments asset_group,
xxen_util.meaning(wdj.priority,'WIP_EAM_ACTIVITY_PRIORITY',700) priority,
mel.location_codes area,
worp.op_seq_num,
bd.department_code assigned_department,
xxen_util.meaning(worp.shutdown_type,'BOM_EAM_SHUTDOWN_TYPE',700) shutdown_type,
br.resource_code,
worp.assigned_units,
xxen_util.meaning(ewod.material_shortage_flag,'EAM_MATERIAL_SHORTAGE',700) material_shortage_flag,
xxen_util.meaning(ewod.workflow_type,'EAM_WORKFLOW_TYPE',700) workflow_type,
xxen_util.meaning(ewod.warranty_claim_status,'EAM_WARRANTY_STATUS',700) warranty_status,
((select papf.full_name from per_all_people_f papf,bom_resource_employees bre,bom_resources br1
where trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and
papf.person_id=bre.person_id  and
bre.instance_id=worp.instance_id and
bre.resource_id=br.resource_id and
br1.resource_id=bre.resource_id and
br1.organization_id=worp.organization_id  and
bre.organization_id=worp.organization_id and
br1.resource_type=2)
union
(select msik.concatenated_segments
from mtl_system_items_kfv msik, bom_resource_equipments bre,bom_resources br2
where bre.inventory_item_id=msik.inventory_item_id and
msik.item_type='EQ'  and
bre.instance_id =worp.instance_id and
bre.resource_id=br.resource_id and
br2.resource_id=bre.resource_id and
br2.organization_id=worp.organization_id  and
bre.organization_id=worp.organization_id
and br2.resource_type=1)) instance_name,
worp.res_start_date,
worp.res_completion_date,
round((worp.res_completion_date- worp.res_start_date)*24) duration,
round((wdj.scheduled_completion_date-wdj.scheduled_start_date)*24) workorder_duration,
eam_eamwsrep_xmlp_pkg.days(res_start_date,res_completion_date) days,
eam_eamwsrep_xmlp_pkg.cp_1_p cp_1,
eam_eamwsrep_xmlp_pkg.cp_2_p cp_2,
eam_eamwsrep_xmlp_pkg.cp_3_p cp_3,
eam_eamwsrep_xmlp_pkg.cp_4_p cp_4,
eam_eamwsrep_xmlp_pkg.cp_5_p cp_5,
eam_eamwsrep_xmlp_pkg.cp_6_p cp_6,
eam_eamwsrep_xmlp_pkg.cp_7_p cp_7,
eam_eamwsrep_xmlp_pkg.cp_8_p cp_8,
wdj.scheduled_start_date,
wdj.scheduled_completion_date,
worp.op_start_date,
worp.op_end_date,
decode(:p_sort_by,1,we.wip_entity_name,2,wdj.scheduled_start_date,3,wdj.scheduled_completion_date,4,round(wdj.scheduled_completion_date-wdj.scheduled_start_date),5,wdj.asset_number,6,msib.concatenated_segments,7,xxen_util.meaning(wdj.priority,'WIP_EAM_ACTIVITY_PRIORITY',700),8,mel.location_codes,we.wip_entity_name) sort_by
from
wip_entities we,
wip_discrete_jobs wdj,
(
select distinct
wo.wip_entity_id wip_entity_id, wo.operation_seq_num op_seq_num, wo.department_id, wo.organization_id,
wo.first_unit_start_date op_start_date, wo.last_unit_completion_date op_end_date,
wor.assigned_units, wor.resource_id, wor.start_date res_start_date, wor.completion_date res_completion_date,
wor.resource_seq_num,wori.instance_id,wo.operation_completed,wo.shutdown_type
from
wip_operations wo,
wip_operation_resources wor,
wip_op_resource_instances wori
where
wo.wip_entity_id=wor.wip_entity_id(+) and
wo.organization_id=wor.organization_id(+) and
wo.operation_seq_num=wor.operation_seq_num(+) and
wor.operation_seq_num=wori.operation_seq_num(+) and
wor.resource_seq_num=wori.resource_seq_num(+) and
wor.wip_entity_id=wori.wip_entity_id(+)
) worp,
eam_work_order_details ewod,
bom_resources br,
bom_departments bd,
bom_departments bd2,
mtl_parameters mp,
mtl_system_items_b_kfv msib,
csi_item_instances cii,
eam_org_maint_defaults eomd,
mtl_eam_locations mel
where
1=1 and
we.wip_entity_id=wdj.wip_entity_id and
we.organization_id=wdj.organization_id and
wdj.status_type=3 and /*released*/
wdj.wip_entity_id=worp.wip_entity_id(+) and
nvl(worp.operation_completed,'N')='N' and
wdj.organization_id=ewod.organization_id and
wdj.wip_entity_id=ewod.wip_entity_id and
worp.organization_id=br.organization_id(+) and
worp.resource_id=br.resource_id(+) and
worp.department_id=bd.department_id and
wdj.owning_department=bd2.department_id(+) and 
wdj.organization_id=mp.maint_organization_id and
mp.organization_id=msib.organization_id and
nvl(wdj.asset_group_id,wdj.rebuild_item_id)=msib.inventory_item_id and
decode(wdj.maintenance_object_type,3,wdj.maintenance_object_id, null)=cii.instance_id(+) and
eomd.object_type(+)=50 and
(eomd.organization_id is null or eomd.organization_id=wdj.organization_id) and
cii.instance_id=eomd.object_id(+) and
eomd.area_id=mel.location_id(+)
order by
organization_code,
sort_by,
wip_entity_name,
owning_department,
firm_planned_flag,
description,
asset