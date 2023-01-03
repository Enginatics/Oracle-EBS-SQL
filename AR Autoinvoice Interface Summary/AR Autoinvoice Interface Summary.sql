/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Autoinvoice Interface Summary
-- Description: Summary of records in the autoinvoice interface, sorted by operating unit, and including order count, total orders value and currency code.
-- Excel Examle Output: https://www.enginatics.com/example/ar-autoinvoice-interface-summary/
-- Library Link: https://www.enginatics.com/reports/ar-autoinvoice-interface-summary/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
count(*) count,
count(distinct decode(rila.interface_line_context,'ORDER ENTRY',rila.interface_line_attribute1)) order_count,
&columns
sum(rila.amount) amount,
rila.currency_code,
riea.message_text,
rila.batch_source_name,
rila.interface_line_context,
rila.request_id
from
hr_all_organization_units_vl haouv,
ra_interface_lines_all rila,
ra_interface_errors_all riea
where
haouv.organization_id=rila.org_id and
rila.interface_line_id=riea.interface_line_id(+)
group by
haouv.name,
&group_by
rila.currency_code,
riea.message_text,
rila.interface_status,
rila.batch_source_name,
rila.interface_line_context,
rila.request_id
order by
haouv.name,
count(*) desc