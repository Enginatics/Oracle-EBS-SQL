/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: IEX Collection Note Upload
-- Description: Creates and updates Collection Notes in Oracle Collections (IEX) - the same notes shown in the Collections work area.
-- Each note is attached at a single Note Level: Customer (party), Account, Bill To, or Collections Transaction.
-- The Note column is limited to 2,000 characters. The upload will reject the row if the note exceeds this.
-- The Note Detail column is limited to 4,000 characters. Note details exceeding this will be truncated.
-- Party Level Notes:
-- Pary Name is required
-- Party Number is required only when the Party Name is not unique.
-- Account Level Notes:
-- Party Name and Account Number are required.
-- Bill To Level Notes:
-- Party Name, Account Number and Bill To Location are required .
-- Operating Unit is optional unless the same Bill To Location (code) is used across accessible Operating Units.
-- Bill to Address is informational only.
-- Transaction Level Notes:
-- Party Name, Account Number, Transaction Number are required.
-- Bill To Site and Operating Unit are only required if the same transaction number exists across different accessible Bill To Sites/Operating Units.
-- Installment is optional unless the Transaction has muliple Installments, in which case it must be specified.
-- Unpaid Reason applies to Transaction level notes only. Oracle Collections holds it on the transaction's delinquency rather than on the note, so it applies to every note on that transaction.
-- Delinquency Status shows whether the transaction is already delinquent. When it is blank, set Create Delinquency to Yes to create a delinquency with status Current, as the Collections form asks.
-- Unpaid Reason and Create Delinquency can only be set when the note is created.
-- Only the Note Type, Note Status and descriptive flexfield attributes can be changed on an existing note; the note text and its target are read only. Download notes in Create, Update mode to reclassify them.
-- Excel Example Output: https://www.enginatics.com/example/iex-collection-note-upload/
-- Library Link: https://www.enginatics.com/reports/iex-collection-note-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) jtf_note_id_out,
hp.party_name party,
hp.party_number party_number,
hca.account_number,
hcsua.location bill_to_site,
haouv.name operating_unit,
hz_format_pub.format_address(hps.location_id,null,null,', ') bill_to_address,
rcta.trx_number transaction_number,
to_char(aps.terms_sequence_number) installment,
jov.name note_level,
xxen_util.meaning(ida.status,'IEX_DELINQUENCY_STATUS',695) delinquency_status,
to_char(null) create_delinquency,
xxen_util.meaning(ida.unpaid_reason_code,'IEX_UNPAID_REASON',695) unpaid_reason,
x.entered_date,
xxen_util.meaning(x.note_type,'JTF_NOTE_TYPE',0) note_type,
xxen_util.meaning(x.note_status,'JTF_NOTE_STATUS',0) note_status,
x.notes note,
dbms_lob.substr(xxen_util.clob_substrb(x.notes_detail,4000),4000,1) note_detail,
xxen_util.display_flexfield_context(690,'COM_FLEX',x.context) attribute_category,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE1',x.row_id,x.attribute1) attribute1,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE2',x.row_id,x.attribute2) attribute2,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE3',x.row_id,x.attribute3) attribute3,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE4',x.row_id,x.attribute4) attribute4,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE5',x.row_id,x.attribute5) attribute5,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE6',x.row_id,x.attribute6) attribute6,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE7',x.row_id,x.attribute7) attribute7,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE8',x.row_id,x.attribute8) attribute8,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE9',x.row_id,x.attribute9) attribute9,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE10',x.row_id,x.attribute10) attribute10,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE11',x.row_id,x.attribute11) attribute11,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE12',x.row_id,x.attribute12) attribute12,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE13',x.row_id,x.attribute13) attribute13,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE14',x.row_id,x.attribute14) attribute14,
xxen_util.display_flexfield_value(690,'COM_FLEX',x.context,'ATTRIBUTE15',x.row_id,x.attribute15) attribute15,
xxen_util.user_name(x.created_by) created_by,
to_number(null) upload_row,
x.jtf_note_id
from
(
select
jnv.jtf_note_id,
jnv.source_object_code,
jnv.source_object_id,
jnv.note_type,
jnv.note_status,
jnv.notes,
jnv.notes_detail,
jnv.entered_date,
jnv.created_by,
jnv.context,
jnv.row_id,
jnv.attribute1,
jnv.attribute2,
jnv.attribute3,
jnv.attribute4,
jnv.attribute5,
jnv.attribute6,
jnv.attribute7,
jnv.attribute8,
jnv.attribute9,
jnv.attribute10,
jnv.attribute11,
jnv.attribute12,
jnv.attribute13,
jnv.attribute14,
jnv.attribute15,
case jnv.source_object_code
when 'PARTY' then jnv.source_object_id
when 'IEX_ACCOUNT' then (select hca2.party_id from hz_cust_accounts hca2 where hca2.cust_account_id=jnv.source_object_id)
when 'IEX_BILLTO' then (select hca2.party_id from hz_cust_site_uses_all hcsua2,hz_cust_acct_sites_all hcasa2,hz_cust_accounts hca2 where hcsua2.site_use_id=jnv.source_object_id and hcasa2.cust_acct_site_id=hcsua2.cust_acct_site_id and hca2.cust_account_id=hcasa2.cust_account_id)
when 'IEX_INVOICES' then (select hca2.party_id from ar_payment_schedules_all aps2,ra_customer_trx_all rcta2,hz_cust_accounts hca2 where aps2.payment_schedule_id=jnv.source_object_id and rcta2.customer_trx_id=aps2.customer_trx_id and hca2.cust_account_id=rcta2.bill_to_customer_id)
end party_id,
case jnv.source_object_code
when 'IEX_ACCOUNT' then jnv.source_object_id
when 'IEX_BILLTO' then (select hcasa2.cust_account_id from hz_cust_site_uses_all hcsua2,hz_cust_acct_sites_all hcasa2 where hcsua2.site_use_id=jnv.source_object_id and hcasa2.cust_acct_site_id=hcsua2.cust_acct_site_id)
when 'IEX_INVOICES' then (select rcta2.bill_to_customer_id from ar_payment_schedules_all aps2,ra_customer_trx_all rcta2 where aps2.payment_schedule_id=jnv.source_object_id and rcta2.customer_trx_id=aps2.customer_trx_id)
end cust_account_id,
case jnv.source_object_code
when 'IEX_BILLTO' then jnv.source_object_id
when 'IEX_INVOICES' then (select rcta2.bill_to_site_use_id from ar_payment_schedules_all aps2,ra_customer_trx_all rcta2 where aps2.payment_schedule_id=jnv.source_object_id and rcta2.customer_trx_id=aps2.customer_trx_id)
end site_use_id,
case when jnv.source_object_code='IEX_INVOICES' then jnv.source_object_id end payment_schedule_id,
case jnv.source_object_code
when 'IEX_BILLTO' then (select hcasa2.org_id from hz_cust_site_uses_all hcsua2,hz_cust_acct_sites_all hcasa2 where hcsua2.site_use_id=jnv.source_object_id and hcasa2.cust_acct_site_id=hcsua2.cust_acct_site_id)
when 'IEX_INVOICES' then (select aps2.org_id from ar_payment_schedules_all aps2 where aps2.payment_schedule_id=jnv.source_object_id)
end org_id
from
jtf_notes_vl jnv
where
jnv.source_object_code in ('PARTY','IEX_ACCOUNT','IEX_BILLTO','IEX_INVOICES')
) x,
hz_parties hp,
hz_cust_accounts hca,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
ar_payment_schedules_all aps,
ra_customer_trx_all rcta,
hr_all_organization_units_vl haouv,
jtf_objects_vl jov,
iex_delinquencies_all ida
where
hp.party_id(+)=x.party_id and
hca.cust_account_id(+)=x.cust_account_id and
hcsua.site_use_id(+)=x.site_use_id and
hcasa.cust_acct_site_id(+)=hcsua.cust_acct_site_id and
hps.party_site_id(+)=hcasa.party_site_id and
aps.payment_schedule_id(+)=x.payment_schedule_id and
rcta.customer_trx_id(+)=aps.customer_trx_id and
haouv.organization_id(+)=x.org_id and
jov.object_code(+)=x.source_object_code and
jov.application_id(+)=decode(x.source_object_code,'PARTY',690,695) and
ida.payment_schedule_id(+)=x.payment_schedule_id and
(x.org_id is null or x.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)) and
1=1
