/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Transaction Update Upload
-- Description: Updates the post completion header fields of Receivables transactions in the same way as the Transactions workbench: comments, special instructions, print option, purchase order details, salesperson, remit to address, late charges exemption, ship via, FOB, waybill, cross reference and the transaction descriptive flexfield.

The transaction is identified by Operating Unit and Transaction Number. A hidden transaction id links downloaded rows exactly; pasted rows resolve by number, and a number existing under more than one transaction source is rejected with a request to download the transaction instead.

Updates are applied through the Transactions workbench header handler, so the same validations apply as in the form. Completion status, transaction status, amounts, dates, customers and accounting are not changed by this upload. Commitments (deposits and guarantees) are excluded.

The upload only processes changed cells. A row without changes reports No change.
-- Excel Examle Output: https://www.enginatics.com/example/ar-transaction-update-upload/
-- Library Link: https://www.enginatics.com/reports/ar-transaction-update-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
haouv.name operating_unit,
rcta.trx_number,
rcta.trx_date,
nvl(xxen_util.meaning(rctt.type,'INV/CM',222),rctt.type) class,
rctt.name transaction_type,
rbsa.name source,
hp.party_name bill_to_customer,
hca.account_number bill_to_account,
xxen_util.yes(rcta.complete_flag) complete,
xxen_util.meaning(rcta.status_trx,'INVOICE_TRX_STATUS',222) trx_status,
rcta.comments,
rcta.internal_notes special_instructions,
xxen_util.meaning(rcta.printing_option,'INVOICE_PRINT_OPTIONS',222) print_option,
rcta.purchase_order,
rcta.purchase_order_revision,
rcta.purchase_order_date,
(select rsa.name from ra_salesreps_all rsa where rcta.primary_salesrep_id=rsa.salesrep_id and rcta.org_id=rsa.org_id) salesperson,
(select rsa.salesrep_number from ra_salesreps_all rsa where rcta.primary_salesrep_id=rsa.salesrep_id and rcta.org_id=rsa.org_id) salesperson_number,
(select aartav.concatenated_address from ar_active_remit_to_addresses_v aartav where rcta.remit_to_address_id=aartav.address_id) remit_to_address,
xxen_util.meaning(decode(rcta.finance_charges,'N','Y','Y','N'),'YES_NO',0) exempt_from_late_charges,
rcta.ship_via,
xxen_util.meaning(rcta.fob_point,'FOB',222) fob,
rcta.waybill_number,
rcta.ct_reference cross_reference,
xxen_util.display_flexfield_context(222,'RA_CUSTOMER_TRX',rcta.attribute_category) ar_inv_attribute_category,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE1',rcta.rowid,rcta.attribute1) ar_inv_attribute1,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE2',rcta.rowid,rcta.attribute2) ar_inv_attribute2,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE3',rcta.rowid,rcta.attribute3) ar_inv_attribute3,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE4',rcta.rowid,rcta.attribute4) ar_inv_attribute4,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE5',rcta.rowid,rcta.attribute5) ar_inv_attribute5,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE6',rcta.rowid,rcta.attribute6) ar_inv_attribute6,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE7',rcta.rowid,rcta.attribute7) ar_inv_attribute7,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE8',rcta.rowid,rcta.attribute8) ar_inv_attribute8,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE9',rcta.rowid,rcta.attribute9) ar_inv_attribute9,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE10',rcta.rowid,rcta.attribute10) ar_inv_attribute10,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE11',rcta.rowid,rcta.attribute11) ar_inv_attribute11,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE12',rcta.rowid,rcta.attribute12) ar_inv_attribute12,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE13',rcta.rowid,rcta.attribute13) ar_inv_attribute13,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE14',rcta.rowid,rcta.attribute14) ar_inv_attribute14,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE15',rcta.rowid,rcta.attribute15) ar_inv_attribute15,
rcta.customer_trx_id,
null upload_row
from
ra_customer_trx_all rcta,
hz_cust_accounts hca,
hz_parties hp,
ra_cust_trx_types_all rctt,
ra_batch_sources_all rbsa,
hr_all_organization_units_vl haouv
where
1=1 and
rctt.type not in ('DEP','GUAR') and
rcta.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
rcta.bill_to_customer_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
rcta.cust_trx_type_id=rctt.cust_trx_type_id and
rcta.org_id=rctt.org_id and
rcta.batch_source_id=rbsa.batch_source_id(+) and
rcta.org_id=rbsa.org_id(+) and
rcta.org_id=haouv.organization_id