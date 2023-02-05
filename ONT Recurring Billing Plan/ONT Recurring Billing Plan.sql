/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Recurring Billing Plan
-- Description: Profile report showing the Sales order recurring billing plan for header and line details including status, frequency, billing period, billing amounts and dates.
-- Excel Examle Output: https://www.enginatics.com/example/ont-recurring-billing-plan/
-- Library Link: https://www.enginatics.com/reports/ont-recurring-billing-plan/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
hou.name operating_unit,
ooha.order_number,
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') line,
xxen_util.meaning(obpha.billing_plan_status,'BILLING_PLAN_STATUS',660) billing_plan_status,
obpha.billing_frequency,
obpha.billing_period,
obpha.start_date,
obpha.billing_amount,
obpha.bill_with_source_line,
obpha.type_of_billing,
obpha.last_reviewed_extd_price,
obpha.usage_unit_desc,
obpha.type_of_usage,
obpla.sequence_number,
obpla.bill_date,
obpla.bill_amount,
obpla.description,
rtrim(oola2.line_number||'.'||oola2.shipment_number||'.'||oola2.option_number||'.'||oola2.component_number||'.'||oola2.service_number,'.') billed_line,
xxen_util.meaning(obpla.milestone,'BILLING_PLAN_MILESTONE',660) milestone,
obpla.usage,
xxen_util.user_name(obpha.created_by) created_by,
xxen_util.client_time(obpha.creation_date) creation_date,
xxen_util.user_name(obpha.last_updated_by) last_updated_by,
xxen_util.client_time(obpha.last_update_date) last_update_date
from
hr_operating_units hou,
gl_ledgers gl,
oe_order_headers_all ooha,
oe_order_lines_all oola,
oe_billing_plan_headers_all obpha,
oe_billing_plan_lines_all obpla,
oe_order_lines_all oola2
where
1=1 and
hou.organization_id=ooha.org_id and
gl.ledger_id=hou.set_of_books_id and
ooha.header_id=obpha.source_order_header_id and
oola.line_id=obpha.source_order_line_id and
obpha.billing_plan_header_id=obpla.billing_plan_header_id and
obpla.billed_line_id=oola2.line_id(+)
order by
gl.name,
hou.name,
ooha.order_number,
line,
obpla.sequence_number