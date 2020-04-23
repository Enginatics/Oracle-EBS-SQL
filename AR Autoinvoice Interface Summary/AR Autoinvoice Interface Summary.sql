/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Autoinvoice Interface Summary
-- Description: Summary of records in the autoinvoice interface
-- Excel Examle Output: https://www.enginatics.com/example/ar-autoinvoice-interface-summary/
-- Library Link: https://www.enginatics.com/reports/ar-autoinvoice-interface-summary/
-- Run Report: https://demo.enginatics.com/

select
haou.name ou,
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
hr_all_organization_units haou,
ra_interface_lines_all rila,
ra_interface_errors_all riea
where
haou.organization_id=rila.org_id and
rila.interface_line_id=riea.interface_line_id(+)
group by
haou.name,
&group_by
rila.currency_code,
riea.message_text,
rila.interface_status,
rila.batch_source_name,
rila.interface_line_context,
rila.request_id
order by
haou.name,
count(*) desc