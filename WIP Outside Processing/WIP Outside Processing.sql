/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Outside Processing
-- Description: Imported from BI Publisher
Description: WIP Outside Processing Report
Application: Work in Process
Source: WIP Outside Processing Report (XML)
Short Name: WIPLBOSP_XML
DB package: WIP_WIPLBOSP_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/wip-outside-processing/
-- Library Link: https://www.enginatics.com/reports/wip-outside-processing/
-- Run Report: https://demo.enginatics.com/

select
x.organization_code,
x.job_name,
x.job_description,
x.assembly,
x.assembly_description,
x.uom,
x.entity_type,
x.job_type,
x.status,
x.scheduled_start_date,
x.scheduled_completion_date,
x.scheduled_quantity,
x.quantity_completed,
-- repetitive schedule
decode(x.rec_type,'R',x.line,null) line,
decode(x.rec_type,'R',x.line_description,null) line_description,
decode(x.rec_type,'R',x.scheduled_start_date,null) first_unit_start_date,
decode(x.rec_type,'R',x.first_unit_completion_date,null) first_unit_completion_date,
decode(x.rec_type,'R',x.last_unit_start_date,null) last_unit_start_date,
decode(x.rec_type,'R',x.scheduled_completion_date,null) last_unit_completion_date,
decode(x.rec_type,'R',x.rate,null) daily_rate,
decode(x.rec_type,'R',x.days,null) processing_days,
decode(x.rec_type,'R',x.scheduled_quantity,null) total_quantity,
--
x.wip_operation_seq_num operation_seq,
x.wip_resource_seq_num resource_seq,
x.resource_code "Resource",
x.po_number po_number,
x.release_num po_release,
x.buyer,
x.vendor_name vendor,
x.po_line,
x.outside_processing_item,
x.outside_processing_item_uom,
x.po_shipment,
x.quantity_ordered,
x.quantity_delivered,
x.due_date
from
(
select
 mp.organization_code,
 we.wip_entity_name job_name,
 dj.description job_description,
 -1 wip_rep_sched_id,
 msiv1.concatenated_segments assembly,
 msiv1.description assembly_description,
 null line,
 null line_description,
 xxen_util.meaning(dj.status_type,'WIP_JOB_STATUS',700) status,
 msiv1.primary_uom_code uom,
 dj.scheduled_start_date scheduled_start_date,
 null first_unit_completion_date,
 null last_unit_start_date,
 dj.scheduled_completion_date scheduled_completion_date,
 0 rate,
 0 days,
 xxen_util.meaning(dj.job_type,'WIP_DISCRETE_JOB',700) job_type,
 dj.quantity_completed quantity_completed,
 dj.start_quantity scheduled_quantity,
 pod.wip_operation_seq_num wip_operation_seq_num,
 pod.wip_resource_seq_num wip_resource_seq_num,
 por.release_num release_num,
 br.resource_code resource_code,
 nvl(poll.promised_date, poll.need_by_date) due_date,
 poll.shipment_num po_shipment,
 msiv2.concatenated_segments outside_processing_item,
 pol.line_num po_line,
 uom.uom_code outside_processing_item_uom,
 hp.party_name vendor_name,
 decode(nvl(pod.po_release_id,-1),-1,poh.agent_id,por.agent_id) buyer_id,
 mev.full_name buyer,
 poh.segment1 po_number,
 xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) entity_type,
 sum(pod.quantity_ordered) over (partition by we.wip_entity_id,poll.line_location_id) quantity_ordered,
 sum(pod.quantity_delivered) over (partition by we.wip_entity_id,poll.line_location_id) quantity_delivered,
 row_number() over (partition by we.wip_entity_id,poll.line_location_id order by pod.po_distribution_id) po_dist_seq,
 poll.line_location_id,
 'D' rec_type
from
 mtl_parameters mp,
 mtl_system_items_vl msiv2,
 po_headers_all poh,
 mtl_units_of_measure uom,
 po_lines_all pol,
 po_line_locations_all poll,
 po_distributions_all pod,
 ap_suppliers pov,
 hz_parties hp,
 po_releases_all por,
 mtl_employees_view mev,
 bom_resources br,
 mtl_system_items_vl msiv1,
 hr_organization_information oog,
 wip_entities we,
 wip_discrete_jobs dj
where
 1=1 and
 2=2 and
 :p_from_line is null and
 :p_to_line is null and
 mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
 dj.organization_id = mp.organization_id and
 oog.organization_id = mp.organization_id and
 dj.wip_entity_id = we.wip_entity_id and
 we.organization_id = mp.organization_id and
 we.wip_entity_id = pod.wip_entity_id and
 we.entity_type != 2 and
 msiv1.organization_id (+) = dj.organization_id and
 msiv1.inventory_item_id (+) = dj.primary_item_id and
 pod.destination_organization_id = mp.organization_id and
 nvl(pod.org_id, nvl(oog.org_information3, -1)) = nvl(oog.org_information3, -1) and
 oog.org_information_context = 'Accounting Information' and
 pod.destination_type_code = 'SHOP FLOOR' and
 pod.wip_entity_id is not null and
 poh.po_header_id = pod.po_header_id and
 poll.line_location_id = pod.line_location_id and
 poh.po_header_id = pol.po_header_id and
 pol.po_line_id = poll.po_line_id and
 poh.po_header_id = poll.po_header_id and
 decode(nvl(pod.po_release_id,-1),-1,poh.agent_id,por.agent_id) = mev.employee_id and
 mev.organization_id = mp.organization_id and
 por.po_release_id (+) = pod.po_release_id and
 por.po_header_id (+) = pod.po_header_id and
 pov.vendor_id (+) = poh.vendor_id and
 pov.party_id = hp.party_id (+) and
 br.resource_id (+) = pod.bom_resource_id and
 msiv2.inventory_item_id = pol.item_id and
 msiv2.organization_id = mp.organization_id and
 uom.unit_of_measure = pol.unit_meas_lookup_code
union
select
 mp.organization_code,
 we.wip_entity_name job_name,
 we.description job_description,
 wrs.repetitive_schedule_id wip_rep_sched_id,
 null assembly,
 null assembly_description,
 wl.line_code line,
 wl.description line_description,
 xxen_util.meaning(wrs.status_type,'WIP_JOB_STATUS',700) status,
 msiv1.primary_uom_code uom,
 wrs.first_unit_start_date scheduled_start_date,
 wrs.first_unit_completion_date first_unit_completion_date,
 wrs.last_unit_start_date last_unit_start_date,
 wrs.last_unit_completion_date scheduled_completion_date,
 wrs.daily_production_rate rate,
 wrs.processing_work_days days,
 null job_type,
 wrs.quantity_completed quantity_completed,
 (wrs.daily_production_rate * wrs.processing_work_days) scheduled_quantity,
 pod.wip_operation_seq_num wip_operation_seq_num,
 pod.wip_resource_seq_num wip_resource_seq_num,
 por.release_num release_num,
 br.resource_code resource_code,
 nvl(poll.promised_date, poll.need_by_date) due_date,
 poll.shipment_num po_shipment,
 msiv2.concatenated_segments outside_processing_item,
 pol.line_num po_line,
 uom.uom_code outside_processing_item_uom,
 hp.party_name vendor_name,
 decode(nvl(pod.po_release_id,-1),-1,por.agent_id) buyer_id,
 mev.full_name buyer,
 poh.segment1 po_number,
 xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) entity_type,
 sum(pod.quantity_ordered) over (partition by we.wip_entity_id,wrs.repetitive_schedule_id,poll.line_location_id) quantity_ordered,
 sum(pod.quantity_delivered) over (partition by we.wip_entity_id,wrs.repetitive_schedule_id,poll.line_location_id) quantity_delivered,
 row_number() over (partition by we.wip_entity_id,wrs.repetitive_schedule_id,poll.line_location_id order by pod.po_distribution_id) po_dist_seq,
 poll.line_location_id,
 'R' rec_type
from
 mtl_parameters mp,
 mtl_system_items_vl msiv2,
 wip_repetitive_schedules wrs,
 wip_repetitive_items wri,
 wip_lines wl,
 po_headers_all poh,
 mtl_units_of_measure uom,
 po_lines_all pol,
 po_line_locations_all poll,
 po_distributions_all pod,
 ap_suppliers pov,
 hz_parties hp,
 po_releases_all por,
 mtl_employees_view mev,
 bom_resources br,
 mtl_system_items_vl msiv1,
 hr_organization_information oog,
 wip_entities we
where
 1=1 and
 3=3 and
 mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
 we.organization_id = mp.organization_id and
 we.entity_type = 2 and
 we.wip_entity_id = pod.wip_entity_id and
 msiv1.inventory_item_id = we.primary_item_id and
 msiv1.organization_id = mp.organization_id and
 wrs.wip_entity_id = we.wip_entity_id and
 wrs.organization_id = mp.organization_id and
 wri.primary_item_id = msiv1.inventory_item_id and
 wri.wip_entity_id = we.wip_entity_id and
 wl.line_id = wrs.line_id and
 wl.organization_id = mp.organization_id and
 pod.wip_entity_id is not null and
 pod.destination_organization_id = mp.organization_id and
 oog.organization_id = mp.organization_id and
 nvl(pod.org_id, nvl(oog.org_information3, -1)) = nvl(oog.org_information3, -1) and
 oog.org_information_context = 'Accounting Information' and
 pod.wip_entity_id = we.wip_entity_id and
 pod.wip_repetitive_schedule_id = wrs.repetitive_schedule_id and
 pod.destination_type_code = 'SHOP FLOOR' and
 poh.po_header_id = pod.po_header_id and
 poll.line_location_id = pod.line_location_id and
 poll.po_header_id = pod.po_header_id and
 pol.po_line_id = poll.po_line_id and
 pol.po_header_id = pod.po_header_id and
 decode(nvl(pod.po_release_id,-1),-1,poh.agent_id,por.agent_id) = mev.employee_id and
 mev.organization_id = mp.organization_id and
 por.po_release_id (+) = pod.po_release_id and
 por.po_header_id (+) = pod.po_header_id and
 pov.vendor_id (+) = poh.vendor_id and
 pov.party_id = hp.party_id (+) and
 br.resource_id (+) = pod.bom_resource_id and
 msiv2.inventory_item_id = pol.item_id and
 msiv2.organization_id = pod.destination_organization_id and
 uom.unit_of_measure = pol.unit_meas_lookup_code
) x
where
x.po_dist_seq = 1
order by
x.organization_code,
x.job_name,
x.line,
x.scheduled_start_date,
x.wip_operation_seq_num,
x.wip_resource_seq_num,
x.vendor_name,
x.outside_processing_item,
x.due_date