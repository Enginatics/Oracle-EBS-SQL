/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoice Approval Status
-- Description: Imported from Concurrent Program
Application: Payables
Source: Invoice Approval Status
Short Name: APXAPRST
-- Excel Examle Output: https://www.enginatics.com/example/ap-invoice-approval-status/
-- Library Link: https://www.enginatics.com/reports/ap-invoice-approval-status/
-- Run Report: https://demo.enginatics.com/

select
x.c_legal_entity legal_entity,
x.c_operating_unit operating_unit,
x.c_vendor_name supplier,
x.c_vendor_site supplier_site,
x.c_invoice_number invoice_number,
trunc(x.c_invoice_date) invoice_date,
x.c_inv_curr currency,
x.c_approval_context approval_context,
x.c_line_number line_number,
x.c_status status,
x.c_action_date action_date,
x.c_action action,
x.c_approver approver,
x.c_applicable_amount applicable_amount,
x.c_amount reviewed_amount,
--
case
when :p_sort_by = 'T' and 1 = row_number() over (partition by x.c_invoice_id order by x.c_action_date desc,x.c_approval_history_id desc)
then case when x.c_status_code in ('INITIATED','SENT','NEEDS WFREAPPROVAL') then x.c_invoice_amount else 0 end
when :p_sort_by = 'A'
then case when x.c_action_code in ('SENT') then x.c_amount else 0 end
else null
end pending_amount,
case
when :p_sort_by = 'T' and 1 = row_number() over (partition by x.c_invoice_id order by x.c_action_date desc,x.c_approval_history_id desc)
then case when x.c_status_code in ('REJECTED','REJECT','STOPPED') then x.c_invoice_amount else 0 end
when :p_sort_by = 'A'
then case when x.c_action_code in ('REJECT','REJECTED','STOPPED') then x.c_amount else 0 end
else null
end rejected_amount,
case
when :p_sort_by = 'T' and 1 = row_number() over (partition by x.c_invoice_id order by x.c_action_date desc,x.c_approval_history_id desc)
then case when x.c_status_code in ('WFAPPROVED','MANUALLY APPROVED') then x.c_invoice_amount else 0 end
when :p_sort_by = 'A'
then case when x.c_action_code in ('APPROVED','MANUALLY APPROVED') then x.c_amount else 0 end
else null
end approved_amount,
--
x.c_approval_history_id approval_history_id
from
(
select -- Q1 By Approver/By Trading Partner - Document Approval
 le.name c_legal_entity,
 mo_global.get_ou_name(ai.org_id) c_operating_unit,
 ai.vendor_id c_vendor_id,
 hzp.party_name c_vendor_name,
 ai.vendor_site_id c_vendor_site_id,
 pos.vendor_site_code c_vendor_site,
 ai.wfapproval_status c_status_code,
 ai.invoice_currency_code c_inv_curr,
 fc.precision c_precision,
 ai.invoice_num c_invoice_number,
 his.amount_approved c_amount,
 his.approver_name c_approver,
 alc2.displayed_field c_action,
 his.last_update_date c_action_date,
 his.iteration c_iteration,
 alc.displayed_field c_status,
 ai.invoice_id c_invoice_id,
 ai.invoice_date c_invoice_date,
 ai.invoice_amount c_invoice_amount,
 ai.invoice_amount c_applicable_amount,
 nvl(alc3.displayed_field,'Document Approval') c_approval_context, /* bug 6002946 added nvl to display approver context */
 his.response c_action_code,
 to_number(null) c_line_number,
 his.approval_history_id c_approval_history_id
from
 ap_inv_aprvl_hist_all his,
 ap_invoices_all ai,
 gl_ledgers gl,
 ap_suppliers pov,
 ap_supplier_sites_all pos,
 hz_parties hzp,
 fnd_currencies fc,
 xle_entity_profiles le,
 ap_lookup_codes alc,
 ap_lookup_codes alc2,
 ap_lookup_codes alc3
where
 :p_reporting_level = :p_reporting_level and
 nvl(:p_status,'?') = nvl(:p_status,'?') and
 1=1 and
 2=2 and
 ai.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
 his.invoice_id = ai.invoice_id and
 ai.set_of_books_id = gl.ledger_id and
 ai.invoice_currency_code = fc.currency_code and
 hzp.party_id=ai.party_id and
 pov.vendor_id(+) = ai.vendor_id and
 pos.vendor_site_id(+) = ai.vendor_site_id and
 le.legal_entity_id (+) = ai.legal_entity_id and
 alc.lookup_code = ai.wfapproval_status and
 alc.lookup_type = 'AP_WFAPPROVAL_STATUS' and
 alc2.lookup_code (+) = his.response and
 alc2.lookup_type (+) = 'AP_WFAPPROVAL_STATUS' and
 alc3.lookup_type (+) = 'AP_WFAPPROVAL_CONTEXT' and
 alc3.lookup_code (+) = his.history_type and
 (his.history_type is null or /* bug 6002946 , added or condition */
  his.history_type= 'DOCUMENTAPPROVAL'
 )
union
select -- Q2 By Approver/By Trading Partner - Line Approval
 le.name c_legal_entity,
 mo_global.get_ou_name(ai.org_id) c_operating_unit,
 ai.vendor_id c_vendor_id,
 hzp.party_name c_vendor_name,
 ai.vendor_site_id c_vendor_site_id,
 pos.vendor_site_code c_vendor_site,
 ail.wfapproval_status c_status_code,
 ai.invoice_currency_code c_inv_curr,
 fc.precision c_precision,
 ai.invoice_num c_invoice_number,
 his.amount_approved c_amount,
 his.approver_name c_approver,
 alc2.displayed_field c_action,
 his.last_update_date c_action_date,
 his.iteration c_iteration,
 alc.displayed_field c_status,
 ai.invoice_id c_invoice_id,
 ai.invoice_date c_invoice_date,
 decode(ai.wfapproval_status,'INITIATED',0,ai.invoice_amount) c_invoice_amount,
 ail.amount c_applicable_amount,
 alc3.displayed_field c_approval_context,
 his.response c_action_code,
 his.line_number c_line_number,
 his.approval_history_id c_approval_history_id
from
 ap_inv_aprvl_hist_all his,
 ap_invoice_lines_all ail,
 ap_invoices_all ai,
 gl_ledgers gl,
 ap_suppliers pov,
 ap_supplier_sites_all pos,
 hz_parties hzp,
 fnd_currencies fc,
 xle_entity_profiles le,
 ap_lookup_codes alc,
 ap_lookup_codes alc2,
 ap_lookup_codes alc3
where
 1=1 and
 2=2 and
 ai.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
 ai.invoice_id=ail.invoice_id and
 his.invoice_id = ail.invoice_id and
 his.line_number = ail.line_number and
 his.history_type = 'LINESAPPROVAL' and
 ai.set_of_books_id = gl.ledger_id and
 ai.invoice_currency_code = fc.currency_code and
 hzp.party_id=ai.party_id and
 alc.lookup_code = ail.wfapproval_status and
 alc.lookup_type = 'AP_WFAPPROVAL_STATUS' and
 pov.vendor_id(+) = ai.vendor_id and
 pos.vendor_site_id(+) = ai.vendor_site_id and
 le.legal_entity_id (+) = ai.legal_entity_id and
 alc2.lookup_code (+) = his.response and
 alc2.lookup_type (+) = 'AP_WFAPPROVAL_STATUS' and
 alc3.lookup_type (+) = 'AP_WFAPPROVAL_CONTEXT' and
 alc3.lookup_code (+) = his.history_type
union
select --Q3 By Trading Partner
 le.name c_legal_entity,
 mo_global.get_ou_name(ai.org_id) c_operating_unit,
 ai.vendor_id c_vendor_id,
 hzp.party_name c_vendor_name,
 ai.vendor_site_id c_vendor_site_id,
 pos.vendor_site_code c_vendor_site,
 ai.wfapproval_status c_status_code,
 ai.invoice_currency_code c_inv_curr,
 fc.precision c_precision,
 ai.invoice_num c_invoice_number,
 0 c_amount,
 'N/A' c_approver,
 'Required' c_action,
 null c_action_date,
 null c_iteration,
 'Required' c_status,
 ai.invoice_id c_invoice_id,
 ai.invoice_date c_invoice_date,
 ai.invoice_amount c_invoice_amount,
 ai.invoice_amount c_applicable_amount,
 'Invoice Approval' c_approval_context,
 'N/A' c_action_code,
 to_number(null) c_line_number,
 0 c_approval_history_id
from
 ap_invoices_all ai,
 gl_ledgers gl,
 ap_suppliers pov,
 ap_supplier_sites_all pos,
 hz_parties hzp,
 fnd_currencies fc,
 xle_entity_profiles le,
 ap_lookup_codes alc
where
 :p_sort_by = 'T' and
 1=1 and
 3=3 and
 ai.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
 ai.set_of_books_id = gl.ledger_id and
 ai.invoice_currency_code = fc.currency_code and
 hzp.party_id=ai.party_id and
 pov.vendor_id(+) = ai.vendor_id and
 pos.vendor_site_id(+) = ai.vendor_site_id and
 le.legal_entity_id(+) = ai.legal_entity_id and
 alc.lookup_code = ai.wfapproval_status and
 alc.lookup_type='AP_WFAPPROVAL_STATUS'
) x
order by
x.c_legal_entity,
x.c_operating_unit,
decode(:p_sort_by,'A',x.c_approver,null),
decode(:p_sort_by,'A',x.c_inv_curr,null),
decode(:p_sort_by,'A',x.c_approval_context,null),
decode(:p_sort_by,'A',x.c_action_date,null) desc,
decode(:p_sort_by,'T',x.c_vendor_name,null),
decode(:p_sort_by,'T',x.c_vendor_site,null),
decode(:p_sort_by,'T',x.c_inv_curr,null),
x.c_invoice_date,
x.c_invoice_number,
x.c_action_date desc,
x.c_approval_history_id desc