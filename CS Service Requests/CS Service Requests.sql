/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CS Service Requests
-- Description: Service requests with customer, product, owner, status and response and resolution times, one row per request.
-- Response and resolution hours are measured from the reported date to the responded and resolved dates. A request is overdue when it was responded to or resolved after its respond by or resolve by date. Without a responded or resolved date, its close date is used, or the current date while it is open.
-- Detail Level adds the request's tasks or notes, one row per task or note; private notes are listed only for the user who entered them.
-- Excel Example Output: https://www.enginatics.com/example/cs-service-requests/
-- Library Link: https://www.enginatics.com/reports/cs-service-requests/
-- Run Report: https://demo.enginatics.com/

select
(select haouv.name from hr_all_organization_units_vl haouv where cibs.org_id=haouv.organization_id) operating_unit,
cibs.incident_number request_number,
citv.name request_type,
cisv.name status,
(select cisv2.name from cs_incident_severities_vl cisv2 where cibs.incident_severity_id=cisv2.incident_severity_id) severity,
(select ciuv.name from cs_incident_urgencies_vl ciuv where cibs.incident_urgency_id=ciuv.incident_urgency_id) urgency,
ciat.summary,
xxen_util.meaning(cibs.problem_code,'REQUEST_PROBLEM_CODE',170) problem_code,
xxen_util.meaning(cibs.resolution_code,'REQUEST_RESOLUTION_CODE',170) resolution_code,
ciat.resolution_summary,
hp.party_name customer,
hp.party_number customer_number,
(select hca.account_number from hz_cust_accounts hca where cibs.account_id=hca.cust_account_id) account_number,
case
when cpc.contact_type='EMPLOYEE' then (select papf.full_name from per_all_people_f papf where cpc.party_id=papf.person_id and trunc(sysdate) between papf.effective_start_date and papf.effective_end_date)
when cpc.contact_type='PARTY_RELATIONSHIP' then (select hp2.party_name from hz_relationships hr, hz_parties hp2 where cpc.party_id=hr.party_id and hr.subject_type='PERSON' and hr.directional_flag='F' and hr.subject_id=hp2.party_id)
else (select hp2.party_name from hz_parties hp2 where cpc.party_id=hp2.party_id)
end primary_contact,
msiv.concatenated_segments item,
msiv.description item_description,
(select cii.instance_number from csi_item_instances cii where cibs.customer_product_id=cii.instance_id) instance_number,
cibs.current_serial_number serial_number,
(select jrrev.resource_name from jtf_rs_resource_extns_vl jrrev where cibs.incident_owner_id=jrrev.resource_id) owner,
(select jrgv.group_name from jtf_rs_groups_vl jrgv where cibs.owner_group_id=jrgv.group_id and cibs.group_type='RS_GROUP') owner_group,
nvl(xxen_util.meaning(cibs.sr_creation_channel,'CS_SR_CREATION_CHANNEL',170),cibs.sr_creation_channel) channel,
cibs.contract_number,
cibs.incident_date reported_date,
cibs.obligation_date respond_by_date,
cibs.inc_responded_by_date responded_date,
cibs.expected_resolution_date resolve_by_date,
cibs.incident_resolved_date resolved_date,
cibs.close_date,
round((cibs.inc_responded_by_date-cibs.incident_date)*24,2) response_hours,
round((cibs.incident_resolved_date-cibs.incident_date)*24,2) resolution_hours,
round(nvl(cibs.close_date,sysdate)-cibs.incident_date,1) days_open,
xxen_util.yes(case when coalesce(cibs.inc_responded_by_date,cibs.close_date,sysdate)>cibs.obligation_date then 'Y' end) response_overdue,
xxen_util.yes(case when coalesce(cibs.incident_resolved_date,cibs.close_date,sysdate)>cibs.expected_resolution_date then 'Y' end) resolution_overdue,
&detail_columns
xxen_util.user_name(cibs.created_by) created_by,
cibs.creation_date
from
cs_incidents_b_sec cibs,
cs_incidents_all_tl ciat,
cs_incident_types_vl citv,
cs_incident_statuses_vl cisv,
hz_parties hp,
mtl_system_items_vl msiv,
(select chscp.incident_id, chscp.contact_type, chscp.party_id from cs_hz_sr_contact_points chscp where chscp.primary_flag='Y') cpc
&detail_from
where
1=1 and
cibs.incident_id=ciat.incident_id and
ciat.language=userenv('lang') and
cibs.incident_type_id=citv.incident_type_id and
cibs.incident_status_id=cisv.incident_status_id and
cibs.customer_id=hp.party_id(+) and
cibs.inventory_item_id=msiv.inventory_item_id(+) and
cibs.inv_organization_id=msiv.organization_id(+) and
cibs.incident_id=cpc.incident_id(+)
&detail_where
order by
cibs.incident_date desc,
cibs.incident_number
&detail_order
