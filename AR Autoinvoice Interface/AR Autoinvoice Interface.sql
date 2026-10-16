/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Autoinvoice Interface
-- Description: Lines in the Autoinvoice interface table, one row per interface line, with all errors of the line from the last Autoinvoice run concatenated in Error Messages and Invalid Values.
-- Interface Line Id is assigned by Autoinvoice, so lines that it has not picked up yet have none and cannot have errors.
-- With Show Distributions and Sales Credits, each line is repeated per interface distribution and sales credit, and its quantity, amount and Line Count of 1 are shown on the first of these rows only.
-- The template Autoinvoice Interface Summary totals the lines per operating unit, batch source, context, error messages and request.
-- Excel Example Output: https://www.enginatics.com/example/ar-autoinvoice-interface/
-- Library Link: https://www.enginatics.com/reports/ar-autoinvoice-interface/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
rila.batch_source_name batch_source,
rila.request_id,
xxen_util.yes(decode(rila.interface_status,'P','Y')) processed,
rila.interface_line_context,
rtrim(rila.interface_line_attribute1||'|'||rila.interface_line_attribute2||'|'||rila.interface_line_attribute3||'|'||rila.interface_line_attribute4||'|'||rila.interface_line_attribute5||'|'||rila.interface_line_attribute6||'|'||rila.interface_line_attribute7||'|'||rila.interface_line_attribute8||'|'||rila.interface_line_attribute9||'|'||rila.interface_line_attribute10||'|'||rila.interface_line_attribute11||'|'||rila.interface_line_attribute12||'|'||rila.interface_line_attribute13||'|'||rila.interface_line_attribute14||'|'||rila.interface_line_attribute15,'|') interface_line_reference,
rila.sales_order,
rila.sales_order_line,
decode(rila.interface_line_context,'ORDER ENTRY',rila.interface_line_attribute1) order_number,
rila.trx_number,
rila.trx_date,
rila.gl_date,
nvl(rctta.name,rila.cust_trx_type_name) transaction_type,
xxen_util.meaning(rila.line_type,'STD_LINE_TYPE',222) line_type,
nvl(hp.party_name,rila.orig_system_bill_customer_ref) bill_to_customer,
hca.account_number bill_to_account_number,
(select msiv.concatenated_segments from mtl_system_items_vl msiv where rila.inventory_item_id=msiv.inventory_item_id and nvl(rila.warehouse_id,oe_sys_parameters.value('MASTER_ORGANIZATION_ID',rila.org_id))=msiv.organization_id) item,
rila.description,
rila.uom_code uom,
case when row_number() over (partition by rila.rowid order by null&show_dist_order)=1 then rila.quantity end quantity,
rila.unit_selling_price,
case when row_number() over (partition by rila.rowid order by null&show_dist_order)=1 then rila.amount end amount,
rila.currency_code currency,
case when row_number() over (partition by rila.rowid order by null&show_dist_order)=1 then 1 end line_count,
&lp_columns
riea.error_count,
riea.error_messages,
riea.invalid_values,
&show_dist_columns
xxen_util.user_name(rila.created_by) created_by,
xxen_util.client_time(rila.creation_date) creation_date,
rila.interface_line_id
from
hr_all_organization_units_vl haouv,
ra_interface_lines_all rila,
(
select
x.interface_line_id,
max(x.error_count) error_count,
listagg(case when x.message_len<=4000 then x.message_text end,'; ') within group (order by x.message_number) error_messages,
listagg(case when x.invalid_len<=4000 then x.invalid_value end,'; ') within group (order by x.message_number) invalid_values
from
(
select
riea.interface_line_id,
riea.message_text,
riea.invalid_value,
row_number() over (partition by riea.interface_line_id order by riea.rowid) message_number,
count(*) over (partition by riea.interface_line_id) error_count,
sum(lengthb(riea.message_text)+2) over (partition by riea.interface_line_id order by riea.rowid rows between unbounded preceding and current row) message_len,
sum(nvl(lengthb(riea.invalid_value),0)+2) over (partition by riea.interface_line_id order by riea.rowid rows between unbounded preceding and current row) invalid_len
from
ra_interface_errors_all riea
) x
group by
x.interface_line_id
) riea,
ra_cust_trx_types_all rctta,
hz_cust_accounts hca,
hz_parties hp
&show_dist_from
where
1=1 and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
haouv.organization_id=rila.org_id and
rila.interface_line_id=riea.interface_line_id(+) and
rila.cust_trx_type_id=rctta.cust_trx_type_id(+) and
rila.org_id=rctta.org_id(+) and
rila.orig_system_bill_customer_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+)
&show_dist_where
order by
haouv.name,
rila.batch_source_name,
rila.interface_line_context,
rila.interface_line_attribute1,
rila.interface_line_attribute2,
rila.interface_line_attribute3,
rila.interface_line_id
