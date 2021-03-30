/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Order Holds
-- Description: Detail Sales Order report with line item details for all order lines that are on hold and the reason for the hold.
-- Excel Examle Output: https://www.enginatics.com/example/ont-order-holds/
-- Library Link: https://www.enginatics.com/reports/ont-order-holds/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
hca.account_number,
hp.party_name,
ooha.order_number,
ottt.name order_type,
xxen_util.meaning(ooha.flow_status_code,'FLOW_STATUS',660) order_status,
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') line,
ottt2.name line_type,
xxen_util.meaning(oola.flow_status_code,'FLOW_STATUS',660) line_status,
oola.unit_selling_price*oola.ordered_quantity extended_price,
xxen_util.meaning(oohoa.released_flag,'YES_NO',0) released,
xxen_util.meaning(ohd.type_code,'HOLD_TYPE',660) hold_type,
ohd.name hold_name,
xxen_util.meaning(ohsa.hold_entity_code,'HOLD_ENTITY_DESC',660) hold_criteria,
ohsa.hold_until_date hold_until,
xxen_util.client_time(oohoa.creation_date) applied_date,
xxen_util.user_name(oohoa.created_by) applied_by,
ohsa.hold_comment,
xxen_util.client_time(ohr.creation_date) release_date,
xxen_util.user_name(ohr.created_by) released_by,
xxen_util.meaning(ohr.release_reason_code,'RELEASE_REASON',660) release_reason,
ohr.release_comment,
ppa.project_number project,
pt.task_number task
from
hr_all_organization_units_vl haouv,
oe_order_holds_all oohoa,
oe_hold_sources_all ohsa,
oe_hold_releases ohr,
oe_hold_definitions ohd,
oe_order_headers_all ooha,
oe_order_lines_all oola,
hz_cust_accounts hca,
hz_parties hp,
oe_transaction_types_tl ottt,
oe_transaction_types_tl ottt2,
(
select ppa.project_id, ppa.segment1 project_number from pa_projects_all ppa union
select psm.project_id, psm.project_number from pjm_seiban_numbers psm
) ppa,
pa_tasks pt
where
1=1 and
oohoa.hold_source_id=ohsa.hold_source_id and
oohoa.hold_release_id=ohr.hold_release_id(+) and
ohsa.hold_id=ohd.hold_id(+) and
haouv.organization_id=ooha.org_id and
oohoa.header_id=ooha.header_id and
oohoa.line_id=oola.line_id(+) and
ooha.sold_to_org_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
ooha.order_type_id=ottt.transaction_type_id(+) and
ottt.language(+)=userenv('lang') and
oola.line_type_id=ottt2.transaction_type_id(+) and
ottt2.language(+)=userenv('lang') and
oola.project_id=ppa.project_id(+) and
oola.task_id=pt.task_id(+)
order by
haouv.name,
hp.party_name,
ooha.order_number,
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.')