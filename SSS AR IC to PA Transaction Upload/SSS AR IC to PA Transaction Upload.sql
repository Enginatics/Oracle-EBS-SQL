/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: SSS AR IC to PA Transaction Upload
-- Description: Extracts billing transactions from an internal supplier AR invoice for an internal customer then uploads as expenditure items to the internal customer project
-- Excel Examle Output: https://www.enginatics.com/example/sss-ar-ic-to-pa-transaction-upload/
-- Library Link: https://www.enginatics.com/reports/sss-ar-ic-to-pa-transaction-upload/
-- Run Report: https://demo.enginatics.com/

select
xxen_upload.action_meaning(xxen_upload.action_create) action_,
xxen_upload.status_meaning(xxen_upload.status_new) status_,
xxen_util.description('U_EXCEL_MSG_VALIDATION_PENDING','XXEN_REPORT_TRANSLATIONS',0) message_,
null request_id_,
null modified_columns_,
null row_id,
--
haouv.name operating_unit,
(select pts.user_transaction_source from pa_transaction_sources pts where pts.transaction_source = ptia.transaction_source) transaction_source,
(select psl.meaning from pa_system_linkages psl where psl.function = ptia.system_linkage and rownum = 1) expnd_type_class,
ptia.expenditure_ending_date expnd_ending_date,
ptia.batch_name batch_name,
ptia.orig_transaction_reference original_trans_ref,
--
ptia.organization_name organization_name,
ptia.expenditure_item_date expnd_item_date,
ptia.project_number project_number,
ptia.task_number task_number,
ptia.expenditure_type expnd_type,
ptia.quantity quantity,
ptia.denom_raw_cost trans_raw_cost,
ptia.raw_cost_rate,
xxen_util.meaning(ptia.unmatched_negative_txn_flag,'YES_NO',0) negative_txn_flag,
ptia.expenditure_comment,
ptia.orig_user_expnd_trans_ref,
ptia.orig_exp_txn_reference1,
ptia.orig_exp_txn_reference2,
ptia.vendor_number,
--
xxen_util.meaning(nvl(:p_submit_import,'Y'),'YES_NO',0) import_transactions
from
(
--pa_ic_mtl_events_to_exp_items_upload_01
--scm ar invoices
select distinct
0 org_id,
'IC Materials Inv/Date: '||ct.trx_number||' '|| to_char(ct.trx_date, 'DD-MON-YY') batch_name,
to_date(ct.trx_date + decode(to_char(ct.trx_date, 'DY'), 'FRI', 0, 'THU', 1, 'WED', 2, 'TUE', 3, 'MON', 4, 'SUN', 5, 6), 'DD-MON-RR') expenditure_ending_date,
'SSS IC Materials' transaction_source,
'PJ' system_linkage,
'Y' unmatched_negative_txn_flag,
'5200' organization_name,
'SCM Newington' orig_user_expnd_trans_ref,
to_date(ct.trx_date, 'DD-MON-RR') expenditure_item_date,
substr(p.segment1, 5, 6) project_number,
decode
(
  (select distinct
   t1.task_number
   from
   apps.pa_tasks t1,
   apps.pa_projects_all p1
   where
   substr(p.segment1, 5, 6) = p1.segment1 and
   p1.project_id = t1.project_id and
   t1.task_number = '6A01'
  ),
 null,decode(t.task_number, 'Fiber', '3AA', 'Extrusions', '3AB', 'Armor & Transitions', '3AC', 'Integrations', '3AD', 'Miscellaneous', '3AE', 'Product Loading', '3AF'),
      '6A01'
) task_number,
'Materials ('||upper(e.uom_code)||')' expenditure_type,
e.quantity_billed quantity,
e.unit_price raw_cost_rate,
e.project_bill_amount denom_raw_cost,
replace( ct.trx_number||'.'|| to_char(ctl.line_number, '000'), ' ', '') orig_transaction_reference,
e.reference2 orig_exp_txn_reference1,
'Inv Org.Item ID: '|| e.inventory_org_id ||'.'|| e.inventory_item_id orig_exp_txn_reference2,
'2275' vendor_number,
e.description expenditure_comment
from
apps.pa_tasks t,
apps.pa_events e,
apps.pa_draft_invoice_items dii,
apps.pa_draft_invoices_all di,
apps.pa_projects_all p,
apps.ra_customer_trx_lines_all ctl,
apps.ra_customer_trx_all ct
where
1=1 and
--joins
ct.customer_trx_id = ctl.customer_trx_id and
ct.interface_header_attribute1 = p.segment1 and
p.project_id = di.project_id and
ct.interface_header_attribute2 = di.draft_invoice_num and
di.project_id = dii.project_id and
di.draft_invoice_num = dii.draft_invoice_num and
ctl.interface_line_attribute6 = dii.line_num and
dii.project_id = e.project_id and
dii.task_id = e.task_id and
ctl.description = e.description and
dii.event_num = e.event_num and
e.task_id = t.task_id and
--permanent criteria
ct.interface_header_context = 'PA INVOICES' and
ct.bill_to_customer_id = 17311 and --subcom submarine systems (sss 61)
ct.interface_header_attribute1 like 'SCM%' and
e.event_type = 'PJM Manual Event' and
e.project_bill_amount <> 0 and
--exclude invoice lines previously imported or pending import
--/*
not exists
( (select
   'ic invoice line previously imported'
   from
   apps.pa_expenditure_items_all ei,
   apps.pa_projects_all p1
   where
   replace(ct.trx_number||'.'||to_char(ctl.line_number, '000'), ' ', '') = ei.orig_transaction_reference
  )
) and
not exists
( (select
   'ic invoice line pending import'
   from
   apps.pa_transaction_interface_all ti
   where
   replace(ct.trx_number||'.'||to_char(ctl.line_number, '000'), ' ', '') = ti.orig_transaction_reference
  )
) and
--*/
--temporary criteria
ct.trx_date >= :p_trx_date_fr
union all
--ots ic invoices
select distinct
0 org_id,
'IC Materials Inv/Date: '||ct.trx_number||' '|| to_char(ct.trx_date, 'DD-MON-YY') batch_name,
to_date(ct.trx_date + decode(to_char(ct.trx_date, 'DY'), 'FRI', 0, 'THU', 1, 'WED', 2, 'TUE', 3, 'MON', 4, 'SUN', 5, 6), 'DD-MON-RR') expenditure_ending_date,
'SSS IC Materials' transaction_source,
'PJ' system_linkage,
'Y' unmatched_negative_txn_flag,
'5200' organization_name,
'Optical Transmission Systems' orig_user_expnd_trans_ref,
to_date(ct.trx_date, 'DD-MON-RR') expenditure_item_date,
(select distinct
 p.segment1
 from
 apps.pa_projects_all p,
 apps.gl_code_combinations cc,
 apps.ra_cust_trx_line_gl_dist_all d
 where
 ctl.customer_trx_line_id = d.customer_trx_line_id and
 d.code_combination_id = cc.code_combination_id and
 cc.segment7 = p.segment1
) project_number,
(select distinct
 t.task_number
 from
 apps.pa_tasks t,
 apps.pa_projects_all p,
 apps.gl_code_combinations cc,
 apps.ra_cust_trx_line_gl_dist_all d
 where
 ctl.customer_trx_line_id = d.customer_trx_line_id and
 d.code_combination_id = cc.code_combination_id and
 cc.segment7 = p.segment1 and
 p.project_id = t.project_id and
 t.task_number in ( '6B01', '3BA')
) task_number,
'Materials ('||upper(ctl.uom_code)||')' expenditure_type,
ctl.quantity_invoiced quantity,
ctl.unit_selling_price raw_cost_rate,
ctl.extended_amount denom_raw_cost,
replace( ct.trx_number||'.'|| to_char(ctl.line_number, '000'), ' ', '') orig_transaction_reference,
'SO Ref: '||ct.interface_header_attribute1||'.'||interface_line_attribute10 orig_exp_txn_reference1,
'Inv Org.Item ID: '||ct.interface_header_attribute10||'.'||ctl.inventory_item_id orig_exp_txn_reference2,
'2042' vendor_number,
(select distinct
 i.segment9
 from
 apps.mtl_system_items_b i
 where
 ctl.interface_line_attribute10 = i.organization_id and
 ctl.inventory_item_id = i.inventory_item_id
) ||' '|| ctl.description expenditure_comment
from
apps.ra_customer_trx_lines_all ctl,
apps.ra_customer_trx_all ct,
apps.ra_batch_sources_all bs
where
1=1 and
--joins
ct.customer_trx_id = ctl.customer_trx_id and
--permanent criteria
bs.name = 'OTS MFG' and
bs.batch_source_id = ct.batch_source_id and
ct.bill_to_customer_id = 17311 and --subcom submarine systems (sss 61)
ct.customer_trx_id = ctl.customer_trx_id and
--exclude invoice lines previously imported or pending import
--/*
not exists
( (select
   'ic invoice line previously imported'
   from
   apps.pa_expenditure_items_all ei
   where
   replace(ct.trx_number||'.'||to_char(ctl.line_number, '000'), ' ', '') = ei.orig_transaction_reference
  )
) and
not exists
( (select
   'ic invoice line pending import'
   from
   apps.pa_transaction_interface_all ti
   where
   replace(ct.trx_number||'.'||to_char(ctl.line_number, '000'), ' ', '') = ti.orig_transaction_reference
  )
) and
--*/
--temporary criteria
ct.trx_date >= :p_trx_date_fr
) ptia,
hr_all_organization_units_vl haouv
where
1=1 and
ptia.org_id = haouv.organization_id and
:p_upload_mode like '%' || xxen_upload.action_update