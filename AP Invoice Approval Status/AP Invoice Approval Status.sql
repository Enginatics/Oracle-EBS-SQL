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
x.legal_entity,
x.operating_unit,
x.party_name supplier,
x.supplier_number,
x.vendor_site_code supplier_site,
x.invoice_num invoice_number,
x.invoice_status,
x.invoice_date,
x.invoice_currency_code currency,
x.approval_context,
x.line_number,
x.approval_status,
x.action_date,
x.action,
x.approver_name approver,
x.applicable_amount,
x.amount_approved reviewed_amount,
case
when :p_sort_by='T' and 1=row_number() over (partition by x.invoice_id order by x.approval_history_id desc nulls last,x.action_date desc) then case when x.wfapproval_status in ('INITIATED','SENT','NEEDS WFREAPPROVAL') then x.invoice_amount else 0 end
when :p_sort_by='A' then case when x.action_code in ('SENT') then x.amount_approved else 0 end
end pending_amount,
case
when :p_sort_by='T' and 1=row_number() over (partition by x.invoice_id order by x.approval_history_id desc nulls last,x.action_date desc) then case when x.wfapproval_status in ('REJECTED','REJECT','STOPPED') then x.invoice_amount else 0 end
when :p_sort_by='A' then case when x.action_code in ('REJECT','REJECTED','STOPPED') then x.amount_approved else 0 end
end rejected_amount,
case
when :p_sort_by='T' and 1=row_number() over (partition by x.invoice_id order by x.approval_history_id desc nulls last,x.action_date desc) then case when x.wfapproval_status in ('WFAPPROVED','MANUALLY APPROVED') then x.invoice_amount else 0 end
when :p_sort_by='A' then case when x.action_code in ('APPROVED','MANUALLY APPROVED') then x.amount_approved else 0 end
end approved_amount,
x.approval_history_id
from
(
(
select -- Q1 By Approver/By Trading Partner - Document Approval
xep.name legal_entity,
mo_global.get_ou_name(aia.org_id) operating_unit,
aia.vendor_id,
hp.party_name,
aps.segment1 supplier_number,
aia.vendor_site_id,
assa.vendor_site_code,
aia.wfapproval_status,
aia.invoice_currency_code,
fc.precision,
aia.invoice_num,
xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id) invoice_status,
aiaha.amount_approved,
aiaha.approver_name,
alc2.displayed_field action,
aiaha.last_update_date action_date,
aiaha.iteration,
alc.displayed_field approval_status,
aia.invoice_id,
aia.invoice_date,
aia.invoice_amount,
aia.invoice_amount applicable_amount,
nvl(alc3.displayed_field,'Document Approval') approval_context,
aiaha.response action_code,
to_number(null) line_number,
aiaha.approval_history_id
from
ap_inv_aprvl_hist_all aiaha,
ap_invoices_all aia,
gl_ledgers gl,
ap_suppliers aps,
ap_supplier_sites_all assa,
hz_parties hp,
fnd_currencies fc,
xle_entity_profiles xep,
ap_lookup_codes alc,
ap_lookup_codes alc2,
ap_lookup_codes alc3
where
:p_reporting_level=:p_reporting_level and
nvl(:p_status,'?')=nvl(:p_status,'?') and
1=1 and
2=2 and
aia.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
aiaha.invoice_id=aia.invoice_id and
aia.set_of_books_id=gl.ledger_id and
aia.invoice_currency_code=fc.currency_code and
hp.party_id=aia.party_id and
aps.vendor_id(+)=aia.vendor_id and
assa.vendor_site_id(+)=aia.vendor_site_id and
xep.legal_entity_id(+)=aia.legal_entity_id and
alc.lookup_code=aia.wfapproval_status and
alc.lookup_type='AP_WFAPPROVAL_STATUS' and
alc2.lookup_code(+)=aiaha.response and
alc2.lookup_type(+)='AP_WFAPPROVAL_STATUS' and
alc3.lookup_type(+)='AP_WFAPPROVAL_CONTEXT' and
alc3.lookup_code(+)=aiaha.history_type and
(aiaha.history_type is null or
aiaha.history_type='DOCUMENTAPPROVAL'
)
union
select -- Q2 By Approver/By Trading Partner - Line Approval
xep.name legal_entity,
mo_global.get_ou_name(aia.org_id) operating_unit,
aia.vendor_id,
hp.party_name,
aps.segment1 supplier_number,
aia.vendor_site_id,
assa.vendor_site_code,
ail.wfapproval_status,
aia.invoice_currency_code,
fc.precision,
aia.invoice_num,
xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id) invoice_status,
aiaha.amount_approved,
aiaha.approver_name,
alc2.displayed_field action,
aiaha.last_update_date action_date,
aiaha.iteration,
alc.displayed_field approval_status,
aia.invoice_id,
aia.invoice_date,
decode(aia.wfapproval_status,'INITIATED',0,aia.invoice_amount) invoice_amount,
ail.amount applicable_amount,
alc3.displayed_field approval_context,
aiaha.response action_code,
aiaha.line_number,
aiaha.approval_history_id
from
ap_inv_aprvl_hist_all aiaha,
ap_invoice_lines_all ail,
ap_invoices_all aia,
gl_ledgers gl,
ap_suppliers aps,
ap_supplier_sites_all assa,
hz_parties hp,
fnd_currencies fc,
xle_entity_profiles xep,
ap_lookup_codes alc,
ap_lookup_codes alc2,
ap_lookup_codes alc3
where
1=1 and
2=2 and
aia.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
aia.invoice_id=ail.invoice_id and
aiaha.invoice_id=ail.invoice_id and
aiaha.line_number=ail.line_number and
aiaha.history_type='LINESAPPROVAL' and
aia.set_of_books_id=gl.ledger_id and
aia.invoice_currency_code=fc.currency_code and
hp.party_id=aia.party_id and
alc.lookup_code=ail.wfapproval_status and
alc.lookup_type='AP_WFAPPROVAL_STATUS' and
aps.vendor_id(+)=aia.vendor_id and
assa.vendor_site_id(+)=aia.vendor_site_id and
xep.legal_entity_id(+)=aia.legal_entity_id and
alc2.lookup_code(+)=aiaha.response and
alc2.lookup_type(+)='AP_WFAPPROVAL_STATUS' and
alc3.lookup_type(+)='AP_WFAPPROVAL_CONTEXT' and
alc3.lookup_code(+)=aiaha.history_type
union
select --Q3 By Trading Partner
xep.name legal_entity,
mo_global.get_ou_name(aia.org_id) operating_unit,
aia.vendor_id,
hp.party_name,
aps.segment1 supplier_number,
aia.vendor_site_id,
assa.vendor_site_code,
aia.wfapproval_status,
aia.invoice_currency_code,
fc.precision,
aia.invoice_num,
xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id) invoice_status,
0 amount,
'N/A' approver,
'Required' action,
null action_date,
null iteration,
'Required' approval_status,
aia.invoice_id,
aia.invoice_date,
aia.invoice_amount,
aia.invoice_amount applicable_amount,
'Invoice Approval' approval_context,
'N/A' action_code,
to_number(null) line_number,
0 approval_history_id
from
ap_invoices_all aia,
gl_ledgers gl,
ap_suppliers aps,
ap_supplier_sites_all assa,
hz_parties hp,
fnd_currencies fc,
xle_entity_profiles xep,
ap_lookup_codes alc
where
:p_sort_by='T' and
1=1 and
3=3 and
aia.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
aia.set_of_books_id=gl.ledger_id and
aia.invoice_currency_code=fc.currency_code and
hp.party_id=aia.party_id and
aps.vendor_id(+)=aia.vendor_id and
assa.vendor_site_id(+)=aia.vendor_site_id and
xep.legal_entity_id(+)=aia.legal_entity_id and
alc.lookup_code=aia.wfapproval_status and
alc.lookup_type='AP_WFAPPROVAL_STATUS'
)
union all
select --Q4 Future Approvers
xep.name legal_entity,
mo_global.get_ou_name(aia.org_id) operating_unit,
aia.vendor_id,
hp.party_name,
aps.segment1 supplier_number,
aia.vendor_site_id,
assa.vendor_site_code,
aia.wfapproval_status,
aia.invoice_currency_code,
fc.precision,
aia.invoice_num,
xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id) invoice_status,
awh.amount_approved,
listagg(awh.approver_name,''||chr(10)) within group(order by decode(awh.iteration,0,9999,awh.iteration),decode(awh.line_number,null,9999,awh.line_number),awh.last_update_date,awh.approver_order_number) approver_name,
awh.response_dsp action,
awh.last_update_date action_date,
awh.iteration,
xxen_util.meaning(aia.wfapproval_status,'AP_WFAPPROVAL_STATUS',200) approval_status,
aia.invoice_id,
aia.invoice_date,
aia.invoice_amount,
aia.invoice_amount applicable_amount,
xxen_util.meaning(awh.approval_context,'AP_WFAPPROVAL_CONTEXT',200) approval_context,
awh.response action_code,
null line_number,
null approval_history_id
from
ap_wfapproval_history_v awh,
ap_invoices_all aia,
gl_ledgers gl,
ap_suppliers aps,
ap_supplier_sites_all assa,
hz_parties hp,
fnd_currencies fc,
xle_entity_profiles xep
where
1=1 and
2=2 and
awh.response='FUTURE' and
aia.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
awh.invoice_id=aia.invoice_id and
aia.set_of_books_id=gl.ledger_id and
aia.invoice_currency_code=fc.currency_code and
hp.party_id=aia.party_id and
aps.vendor_id(+)=aia.vendor_id and
assa.vendor_site_id(+)=aia.vendor_site_id and
xep.legal_entity_id(+)=aia.legal_entity_id
group by 
xep.name,
mo_global.get_ou_name(aia.org_id),
aia.vendor_id,
hp.party_name,
aps.segment1,
aia.vendor_site_id,
assa.vendor_site_code,
aia.wfapproval_status,
aia.invoice_currency_code,
fc.precision,
aia.invoice_num,
awh.amount_approved,
awh.response_dsp,
awh.last_update_date,
awh.iteration,
aia.invoice_id,
aia.invoice_date,
aia.invoice_amount,
xxen_util.meaning(awh.approval_context,'AP_WFAPPROVAL_CONTEXT',200),
awh.response,
xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id)
) x
order by
x.legal_entity,
x.operating_unit,
decode(:p_sort_by,'A',x.approver_name,null),
decode(:p_sort_by,'A',x.invoice_currency_code,null),
decode(:p_sort_by,'A',x.approval_context,null),
decode(:p_sort_by,'A',x.action_date,null) desc,
decode(:p_sort_by,'T',x.party_name,null),
decode(:p_sort_by,'T',x.vendor_site_code,null),
decode(:p_sort_by,'T',x.invoice_currency_code,null),
x.approval_history_id desc nulls last,
x.invoice_date,
x.invoice_num,
x.action_date desc