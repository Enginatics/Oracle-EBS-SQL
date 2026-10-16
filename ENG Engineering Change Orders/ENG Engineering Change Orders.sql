/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: ENG Engineering Change Orders
-- Description: Engineering change orders (ECOs) with one row per revised item: the ECO header with its type, status, approval status, priority, reason, requestor and dates, and the revised item with its new revision, effectivity, implementation and cancellation dates, use-up item and material disposition. An ECO without revised items is listed once with blank revised item columns.
-- Change types are those based on the Change Order change category, as on the Engineering Change Orders form.
-- Show Component Changes adds one row per component the revised item adds, changes or disables. Old Quantity and Old Op Seq come from the component the change replaces.
-- Open Jobs is the current number of unreleased, released and on hold discrete jobs building the revised item in the ECO's organization, whatever the ECO's status. Open Job List shows the first 15 of these jobs by scheduled start date.
-- Estimated Eng Cost and Estimated Mfg Cost are shown on the first row of an ECO and Open Jobs on the first row of a revised item only, so that they can be summed.
-- Excel Example Output: https://www.enginatics.com/example/eng-engineering-change-orders/
-- Library Link: https://www.enginatics.com/reports/eng-engineering-change-orders/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
eec.change_notice change_notice,
ecotv.type_name change_type,
xxen_util.meaning(eec.status_type,'ECG_ECN_STATUS',700) change_status,
xxen_util.meaning(eec.approval_status_type,'ENG_ECN_APPROVAL_STATUS',700) approval_status,
eec.priority_code priority,
eec.reason_code reason,
(select hp.party_name from hz_parties hp where eec.requestor_id=hp.party_id) requestor,
(select hp.party_name from hz_parties hp where eec.assignee_id=hp.party_id) assignee,
(select haouv.name from hr_all_organization_units_vl haouv where eec.responsible_organization_id=haouv.organization_id) responsible_organization,
eec.description change_description,
eec.initiation_date,
eec.need_by_date,
eec.approval_request_date,
eec.approval_date,
eec.implementation_date change_implementation_date,
eec.cancellation_date change_cancellation_date,
eec.cancellation_comments,
decode(row_number() over (partition by eec.organization_id, eec.change_notice order by msiv.concatenated_segments, eri.revised_item_sequence_id &component_order),1,eec.estimated_eng_cost) estimated_eng_cost,
decode(row_number() over (partition by eec.organization_id, eec.change_notice order by msiv.concatenated_segments, eri.revised_item_sequence_id &component_order),1,eec.estimated_mfg_cost) estimated_mfg_cost,
&eco_dff_columns
msiv.concatenated_segments revised_item,
msiv.description revised_item_description,
msiv.primary_uom_code uom,
(select bsb.alternate_bom_designator from bom_structures_b bsb where eri.bill_sequence_id=bsb.bill_sequence_id) alternate_bom,
eri.new_item_revision new_revision,
eri.new_routing_revision,
xxen_util.meaning(eri.status_type,'ECG_ECN_STATUS',700) revised_item_status,
eri.early_schedule_date early_effectivity_date,
eri.scheduled_date effectivity_date,
eri.implementation_date,
eri.cancellation_date,
(select msiv2.concatenated_segments from mtl_system_items_vl msiv2 where eri.use_up_item_id=msiv2.inventory_item_id and eri.organization_id=msiv2.organization_id) use_up_item,
eri.use_up_plan_name use_up_plan,
xxen_util.meaning(eri.disposition_type,'ECG_MATERIAL_DISPOSITION',700) disposition,
xxen_util.yes(decode(eri.mrp_active,1,'Y')) mrp_active,
xxen_util.yes(decode(eri.update_wip,1,'Y')) update_wip,
eri.from_end_item_unit_number from_unit_number,
eri.descriptive_text revised_item_comment,
&revised_item_dff_columns
decode(row_number() over (partition by eec.organization_id, eec.change_notice, eri.revised_item_sequence_id order by eri.revised_item_sequence_id &component_order),1,wdj.open_jobs) open_jobs,
wdj.open_job_list
&component_columns
from
mtl_parameters mp,
eng_engineering_changes eec,
eng_change_order_types_vl ecotv,
eng_revised_items eri,
mtl_system_items_vl msiv,
(
select
y.organization_id,
y.primary_item_id,
count(*) open_jobs,
listagg(case when y.rn<=15 then y.wip_entity_name end,', ') within group (order by y.rn) open_job_list
from
(
select
wdj.organization_id,
wdj.primary_item_id,
we.wip_entity_name,
row_number() over (partition by wdj.organization_id, wdj.primary_item_id order by wdj.scheduled_start_date, we.wip_entity_name) rn
from
wip_discrete_jobs wdj,
wip_entities we
where
wdj.status_type in (1,3,6) and
(wdj.organization_id,wdj.primary_item_id) in (select eri.organization_id, eri.revised_item_id from eng_revised_items eri) and
wdj.wip_entity_id=we.wip_entity_id
) y
group by
y.organization_id,
y.primary_item_id
) wdj
&component_from
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=eec.organization_id and
eec.change_order_type_id=ecotv.change_order_type_id and
ecotv.base_change_mgmt_type_code='CHANGE_ORDER' and
eec.change_notice=eri.change_notice(+) and
eec.organization_id=eri.organization_id(+) and
eri.revised_item_id=msiv.inventory_item_id(+) and
eri.organization_id=msiv.organization_id(+) and
eri.organization_id=wdj.organization_id(+) and
eri.revised_item_id=wdj.primary_item_id(+)
&component_where
order by
mp.organization_code,
eec.change_notice,
msiv.concatenated_segments,
eri.revised_item_sequence_id
&component_order
