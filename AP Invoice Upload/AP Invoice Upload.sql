/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoice Upload
-- Description: AP Invoice Upload
-- Excel Examle Output: https://www.enginatics.com/example/ap-invoice-upload/
-- Library Link: https://www.enginatics.com/reports/ap-invoice-upload/
-- Run Report: https://demo.enginatics.com/

/*
&report_table_name
*/
select
x.*
from
(
with
q_dual as (select * from dual) -- dummy to allow the lexical to follow
&processed_with_queries
select
null                    action_,
null                    status_,
null                    message_,
null                    request_id_,
null                    row_id,
null batch_name,
null submit_validation,
'Invoice Source'        source,
'OU Name'               operating_unit,
'Standard'              invoice_type,
'VEND_NAME'             supplier_name,
'99999'                 supplier_number,
'VEND_SITE_CODE'        supplier_site,
trunc(sysdate)          invoice_date,
'INV#0001'              invoice_number,
100                     invoice_amount,
'USD'                   invoice_currency,
'30 Days'               terms,
trunc(sysdate)          gl_date,
'USD'                   payment_currency,
'Check'                 payment_method,
1                       line_number,
'Item'                  line_type,
100                     line_amount,
'Line Description'      line_description,
'Distribution Alias'    distribution_account_alias,
'00-000-0000-0000-000'  distribution_account,
'Tax Class code'        tax_classification,
'Primary Intended Use'  primary_intended_use,
'Ship To Location'      ship_to_location,
'Prod Fix Class'        product_fiscal_classification,
'Fiscal Class'          fiscal_classification,
'Business Category'     business_category,
'Product Type'          product_type,
'Product Category'      product_category
from
q_dual
where
:p_operating_unit = :p_operating_unit and
:p_source = :p_source and
:p_batch_name = :p_batch_name and
nvl(:p_tax_inclusive_flag,'?') = nvl(:p_tax_inclusive_flag,'?') and
nvl(:p_calulate_tax_flag,'?') = nvl(:p_calulate_tax_flag,'?') and
nvl(:p_gl_date,sysdate) = nvl(:p_gl_date,sysdate) and
nvl(:p_submit_validation,'N') = nvl(:p_submit_validation,'N') and
1=0
&not_use_first_block
&processed_run_query
&processed_run
) x
order by
x.operating_unit,
x.invoice_date,
x.supplier_name,
x.invoice_number,
x.line_number