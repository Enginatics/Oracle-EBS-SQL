/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PN Billing/Payment Upload
-- Description: Property Management - Billing and Payments Upload
-- Excel Examle Output: https://www.enginatics.com/example/pn-billing-payment-upload/
-- Library Link: https://www.enginatics.com/reports/pn-billing-payment-upload/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
decode(:p_upload_mode,'Copy','Create',null) action_,
decode(:p_upload_mode,'Copy','New',null) status_,
decode(:p_upload_mode,'Copy','Validation pending',null) message_,
null request_id_,
null row_id,
haouv.name operating_unit,
plv.lease_name,
plv.lease_number,
xxen_util.meaning(plv.status,'PN_LEASE_STATUS_TYPE',0) final_draft,
plv.lease_class,
plv.lease_type,
nvl(plv.customer_name,plv.supplier_name) lease_third_party_name,
nvl(
 plv.customer_number,
 (select asu.segment1 from ap_suppliers asu where asu.vendor_id = plv.supplier_id)
) lease_third_party_number,
plv.location_code_disp primary_location,
plv.property_name_disp property,
plv.user_responsible,
--
pptv.term_template,
pptv.payment_purpose purpose,
pptv.payment_term_type type,
pptv.frequency_type frequency,
pptv.estimated_amount,
pptv.actual_amount,
pptv.currency_code,
pptv.rate,
--
to_char(
  case when not(:p_upload_mode = 'Copy' and :p_date_incr_type is not null and :p_date_incr_unit is not null)
  then pptv.start_date
  else case upper(:p_date_incr_type)
       when 'DAYS'   then pptv.start_date + :p_date_incr_unit
       when 'MONTHS' then add_months(pptv.start_date,:p_date_incr_unit)
       when 'YEARS'  then add_months(pptv.start_date,:p_date_incr_unit*12)
       end
  end
,'DD-Mon-YYYY') start_date,
to_char(
  case when not(:p_upload_mode = 'Copy' and :p_date_incr_type is not null and :p_date_incr_unit is not null)
  then pptv.end_date
  else case upper(:p_date_incr_type)
       when 'DAYS'   then pptv.end_date + :p_date_incr_unit
       when 'MONTHS' then add_months(pptv.end_date,:p_date_incr_unit)
       when 'YEARS'  then add_months(pptv.end_date,:p_date_incr_unit*12)
       end
  end
,'DD-Mon-YYYY') end_date,
to_char(
  case when not(:p_upload_mode = 'Copy' and :p_date_incr_type is not null and :p_date_incr_unit is not null)
  then pptv.target_date
  else case upper(:p_date_incr_type)
       when 'DAYS'   then pptv.target_date + :p_date_incr_unit
       when 'MONTHS' then add_months(pptv.target_date,:p_date_incr_unit)
       when 'YEARS'  then add_months(pptv.target_date,:p_date_incr_unit*12)
       end
  end
,'DD-Mon-YYYY') target_date,
--to_char(pptv.start_date,'DD-Mon-YYYY') start_date,
--to_char(pptv.end_date,'DD-Mon-YYYY') end_date,
--to_char(pptv.target_date,'DD-Mon-YYYY') target_date,
--
pptv.schedule_day,
--
pla.location_code location,
xxen_util.meaning(pptv.area_type_code,'PN_AREA_TYPE_CODE',0) area_type,
pptv.area,
pptv.actual_amount * 12 annual_amount,
case when nvl(pptv.area,0) = 0
then to_number(null)
else round((pptv.actual_amount * 12)/pptv.area,2)
end annual_area_amount,
--
nvl(pptv.customer_name,pptv.vendor_name) third_party_name,
nvl(pptv.customer_number,pptv.vendor_number) third_party_number,
nvl(pptv.customer_site_use,pptv.vendor_site) third_party_bill_site,
pptv.cust_ship_site_use third_party_ship_site,
pptv.cust_po_number third_party_po_number,
(select poha.segment1 po_number from po_headers_all poha where poha.po_header_id = pptv.po_header_id) po_number,
--
case when plv.lease_class_code in ('THIRD_PARTY','SUB_LEASE','REC')
then (select rtv.name from ra_terms_vl rtv where rtv.term_id = pptv.ap_ar_term_id)
else (select atv.name from ap_terms_vl atv where atv.term_id = pptv.ap_ar_term_id)
end payment_terms,
-- billing
(select arm.name from ar_receipt_methods arm where arm.receipt_method_id = pptv.receipt_method_id) payment_method,
(select rctta.name from ra_cust_trx_types_all rctta where rctta.org_id = pptv.org_id and rctta.cust_trx_type_id = pptv.cust_trx_type_id) ar_invoice_type,
(select rsa.name from ra_salesreps_all rsa where rsa.org_id = pptv.org_id and rsa.salesrep_id = pptv.salesrep_id) salesperson,
(select rr.name from ra_rules rr where rr.rule_id = pptv.inv_rule_id) invoicing_rule,
(select rr.name from ra_rules rr where rr.rule_id = pptv.account_rule_id) accounting_rule,
-- payments
pptv.inv_group_name invoice_grouping_rule,
(select distribution_set_name from ap_distribution_sets_all adsa where adsa.distribution_set_id = pptv.distribution_set_id) distribution_set,
(select ppa.name from pa_projects_all ppa where ppa.project_id = pptv.project_id and ppa.org_id = pptv.org_id) project,
(select ptev.task_name from pa_tasks_expend_v ptev where ptev.task_id = pptv.task_id) task,
--pptv.agreement_name,
--pptv.agreement_number,
pptv.expenditure_type,
to_char(pptv.expenditure_item_date,'DD-Mon-YYYY') expenditure_item_date,
(select poev.name from pa_organizations_expend_v poev where poev.organization_id = pptv.organization_id) expenditure_organization,
-- tax
xxen_util.meaning(decode(pptv.tax_included,'A','Y',pptv.tax_included),'YES_NO',0) tax_included,
pptv.tax_classification_code,
--
(select
 gcck.concatenated_segments
 from
 pn_distributions_v pdv,
 gl_code_combinations_kfv gcck
 where
 pdv.payment_term_id = pptv.payment_term_id and
 gcck.code_combination_id = pdv.account_id and
 pdv.account_class in ('LIA','REC') and
 pdv.percentage = 100
) receivables_liability_account,
(select
 gcck.concatenated_segments
 from
 pn_distributions_v pdv,
 gl_code_combinations_kfv gcck
 where
 pdv.payment_term_id = pptv.payment_term_id and
 gcck.code_combination_id = pdv.account_id and
 pdv.account_class in ('EXP','REV') and
 pdv.percentage = 100
) revenue_expense_account,
(select
 gcck.concatenated_segments
 from
 pn_distributions_v pdv,
 gl_code_combinations_kfv gcck
 where
 pdv.payment_term_id = pptv.payment_term_id and
 gcck.code_combination_id = pdv.account_id and
 pdv.account_class in ('ACC','UNEARN') and
 pdv.percentage = 100
) accrual_account,
--
pptv.term_comments,
--
xxen_util.meaning(pptv.recoverable_flag,'YES_NO',0) recoverable,
xxen_util.meaning(pptv.normalize,'YES_NO',0) normalize,
null rou_asset,
null liability,
null report_from_inception,
null intercompany,
xxen_util.meaning(pptv.changed_flag,'YES_NO',0) changed,
xxen_util.meaning(pptv.include_in_var_rent,'PN_PAYMENT_BKPT_BASIS_TYPE',0) natural_breakpoint_basis,
xxen_util.meaning(pptv.source_module,'PN_TERM_SOURCE_MODULE',0) source,
--
pptv.attribute_category,
pptv.attribute1,
pptv.attribute2,
pptv.attribute3,
pptv.attribute4,
pptv.attribute5,
pptv.attribute6,
pptv.attribute7,
pptv.attribute8,
pptv.attribute9,
pptv.attribute10,
pptv.attribute11,
pptv.attribute12,
pptv.attribute13,
pptv.attribute14,
pptv.attribute15,
--
decode(:p_upload_mode,'Copy',to_number(null),pptv.payment_term_id) payment_term_id,
pptv.term_template_id,
pptv.lease_id,
pptv.lease_change_id,
nvl(pptv.customer_id,pptv.vendor_id) third_party_id,
nvl(pptv.customer_site_use_id,pptv.vendor_site_id) third_party_bill_to_site_id,
pptv.cust_ship_site_id third_party_ship_to_site_id,
to_number(to_char(pptv.start_date,'j')) start_date_j,
to_number(to_char(pptv.end_date,'j')) end_date_j
from
pn_leases_v plv,
pn_payment_terms_v pptv,
pn_locations_all pla,
hr_all_organization_units_vl haouv
where
1=1 and
:p_upload_mode in ('Create or Update','Copy') and
plv.lease_id = pptv.lease_id and
plv.org_id = haouv.organization_id and
--
pptv.location_id = pla.location_id (+) and
plv.status = nvl(xxen_util.lookup_code(:p_final_draft_status,'PN_LEASE_STATUS_TYPE',0),'F') and
plv.lease_class = :p_lease_class
&not_use_first_block
&report_table_select &report_table_name &report_table_where_clause
&success_records
&processed_run
) x
order by
x.operating_unit,
x.lease_name,
x.start_date_j,
x.end_date_j,
x.purpose,
x.type