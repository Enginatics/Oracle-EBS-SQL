/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Project Tasks and Budgets
-- Excel Examle Output: https://www.enginatics.com/example/pa-project-tasks-and-budgets/
-- Library Link: https://www.enginatics.com/reports/pa-project-tasks-and-budgets/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ood.organization_code,
ppa.segment1 project_number,
ppa.name project_name,
ppa.description project_description,
ppa.project_type,
ppa.project_status_code,
ppa.start_date project_start_date,
ppa.completion_date project_completion_date,
ppa.closed_date project_closed_date,
pt.task_number,
pt.task_name,
pt.description task_description,
pt.service_type_code,
pt.start_date task_start_date,
pt.completion_date task_completion_date,
pt.wbs_level,
pbvdv.burdened_cost budget_cost,
xxen_util.user_name(ppa.created_by) project_created_by,
ppa.creation_date poject_creation_date,
(select ppx.full_name from pa_project_players ppp, per_people_x ppx where ppx.person_id=ppp.person_id and ppa.project_id=ppp.project_id and ppp.project_role_type='PROJECT MANAGER' and rownum=1) key_member,
pbvdv.cur_base_date approval_date,
(select sum(pbl.burdened_cost) from pafv_budget_lines pbl where pt.task_id=pbl.task_id and pbvdv.budget_version_id=pbl.budget_version_id and rownum=1) task_budget,
pod.destination_type_code,
-- pod.po_distribution_id,
(select item_id from po_lines_all where rcv1.po_line_id=pod.po_line_id and rownum=1) item,
(select description from mtl_system_items_kfv k where inventory_item_id = (select item_id from po_lines_all where rcv1.po_line_id=pod.po_line_id and rownum=1)
and organization_id = ppa.carrying_out_organization_id and rownum=1) item_desc,
(select concatenated_segments from mtl_system_items_kfv k where inventory_item_id =(select item_id from po_lines_all where po_line_id=pod.po_line_id and rownum=1)
and organization_id = ppa.carrying_out_organization_id) item_code,
(select  pha.segment1 from po_headers_all pha where pha.po_header_id=pod.po_header_id and rownum=1) po_num,
(select  pv.vendor_name from po_headers_all pha,po_vendors pv where pv.vendor_id=pha.vendor_id and pha.po_header_id=pod.po_header_id and rownum=1) vendor_name,
(select  pha.currency_code from po_headers_all pha where pha.po_header_id=pod.po_header_id and rownum=1) currency_code,
(select  trunc(pha.creation_date) from po_headers_all pha where pha.po_header_id=pod.po_header_id and rownum=1) po_date,    
(select quantity from po_lines_all where po_line_id=pod.po_line_id and rownum=1) po_qty,
(select unit_price from po_lines_all where po_line_id=pod.po_line_id and rownum=1) po_unit_price,
(select (pl.unit_price * pl.quantity * nvl(ph.rate,1)) from po_lines_all pl,po_headers_all ph where ph.po_header_id=pl.po_header_id and pl.po_line_id=pod.po_line_id and rownum=1) po_commit_cost,
(select distinct receipt_num from rcv_shipment_headers rsh, rcv_transactions rcv,po_lines_all pla where rsh.shipment_header_id = rcv.shipment_header_id and rcv.po_line_id=pla.po_line_id
and po_distribution_id=pod.po_distribution_id and transaction_id=rcv1.transaction_id and rownum=1) rec_num,
(select distinct trunc(transaction_date) from rcv_transactions rcv where po_distribution_id=pod.po_distribution_id and transaction_type = 'DELIVER' and rownum=1) rec_date,
(select sum((decode (transaction_type,'DELIVER',quantity,'RETURN TO VENDOR', (quantity * (-1)))))
from rcv_transactions rcv
where po_distribution_id=pod.po_distribution_id
and shipment_line_id = rcv1.shipment_line_id
and transaction_type in ('DELIVER','RETURN TO VENDOR')) rec_qty,
(select distinct po_unit_price from rcv_transactions rcv
where po_distribution_id=pod.po_distribution_id
and transaction_type = 'DELIVER') rec_price ,
((select sum((decode (transaction_type,'DELIVER',quantity
,'RETURN TO VENDOR', (quantity * (-1)))))
from rcv_transactions rcv
where po_distribution_id=pod.po_distribution_id
and shipment_line_id = rcv1.shipment_line_id
and transaction_type in ('DELIVER','RETURN TO VENDOR')) * (select distinct po_unit_price from rcv_transactions rcv where po_distribution_id=pod.po_distribution_id and transaction_type = 'DELIVER')) rec_val,
null transfered_project_from_other,
null transfered_qty_from_other,
null transfered_date_from_other,
null transfered_cost_from_other,
null transfer_project_to_other,
null transfer_qty_to_other,
null transfer_cost_to_other,
null transfer_date_to_other,
null issued_qty,
null issued_date,
null issued_cost,
null issued_ref_no,
decode (pod.destination_type_code,'EXPENSE', ((select sum((decode (transaction_type,'DELIVER',quantity,'RETURN TO VENDOR', (quantity * (-1)))))
from rcv_transactions rcv
where po_distribution_id=pod.po_distribution_id
and transaction_type in ('DELIVER','RETURN TO VENDOR')) * (select distinct po_unit_price from rcv_transactions rcv
where po_distribution_id=pod.po_distribution_id
and transaction_type = 'DELIVER'))) expense_loaded_to_project,
null to_project_id,
null transaction_quantity,
null transaction_type,
null subinventory_code,
null locator_id,
null location,          
(select distinct uom_code from mtl_units_of_measure_tl uo,po_lines_all pl where pl.unit_meas_lookup_code=uo.unit_of_measure and po_line_id=pod.po_line_id and rownum=1) transaction_uom,
(select  pha.creation_date from po_headers_all pha where pha.po_header_id=pod.po_header_id and rownum=1) trans_date,
null per_unit_cost,
ppa.project_id,
pt.task_id,
pt.top_task_id,
pbvdv.budget_version_id
from
hr_all_organization_units_vl haouv,
org_organization_definitions ood,
pa_projects_all ppa,
pa_tasks pt,
pa_budget_versions_draft_v pbvdv,
pa_budget_types ty,
po_distributions_all pod,
rcv_transactions rcv1
where
1=1 and
haouv.organization_id=ppa.org_id and
ppa.carrying_out_organization_id=ood.organization_id and
ppa.project_id=pt.project_id and
ppa.project_id=pbvdv.project_id and
ty.budget_type_code=pbvdv.budget_type_code and
pod.task_id(+)=pt.task_id and
pod.task_id=rcv1.task_id(+) and
pod.po_distribution_id=rcv1.po_distribution_id(+)