/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Transaction Upload
-- Description: This upload can be used to create Invoices, Debit Memos and Credit Memos. Credit memos can be created On Account, or created and applied directly to an existing transaction (an applied credit memo).
-- The 'Upload Trx Identifier' column is used to uniquely identify each individual transaction (invoice, credit memo, debit memo) to be uploaded.
-- If the selected batch source uses manual transaction numbering, the Upload Trx Identifier will be copied to the Transaction Number column (the Oracle Transaction Number), but this can be overridden in the upload excel.
-- If the selected transaction type uses a Manual Document Sequence, the Upload Trx Identifier will be used as the Document Sequence Value in Oracle.
-- The upload supports the entry of
-- - Standard Invoice Lines
-- - Manual Tax Lines (if permitted)
-- - Header Level Freight Lines (if permitted) – identified by leaving the Link to Line Number null
-- - Line Level Freight Lines (if permitted) – identified by populating the Link to Line Number column
-- For Tax Lines, and Line level Freight Lines, use the Link to Line Number to identify the Invoice Line to which the Tax Line or Freight Line should be linked. Tax Lines must be linked to a standard invoice line.
-- Note. Tax Lines and Line level Freight Lines must occur after the row containing the invoice line to which they will be linked, although it does not need to be immediately following.
-- - A Quantity and Unit Price must be specified for standard invoice lines. The upload will calculate the line amount.
-- - You can specify a quantity and unit price for a freight line in which case the upload will calculate the line amount, or you enter the line amount directly. Only the amount is uploaded to Oracle.
-- - For manual Tax Lines, you can enter the line amount directly. If left blank, the upload will calculate the amount based on the selected Tax Rate and the line amount from the linked standard invoice.
-- For Manual Tax Lines you must specify the Tax Regime, Tax, Tax Jurisdiction, Tax Status, Tax Rate Name, and Tax Rate columns.
-- Applied Credit Memos
-- To create a credit memo and apply it to an existing transaction in one step, populate the Credit Against Transaction column with the transaction to be credited. A Credit Memo Reason is required for an applied credit memo.
-- The Transaction Type and Transaction Date are derived automatically from the credited invoice and are informational on this flow. The Transaction Type list shows only the credit memo type linked to the credited invoice's transaction type, and the Transaction Date defaults to the later of today and the credited invoice's date.
-- You can credit the invoice at header level or at line level.
-- Header level – leave the Credit Against Line column blank.
-- - Leave Credit Line Amount, Credit Tax Amount and Credit Freight Amount blank to credit the full outstanding balance of the invoice.
-- - Or enter negative Credit Line, Credit Tax and/or Credit Freight Amounts to credit part of the invoice.
-- Line level – populate the Credit Against Line column.
-- - Enter one row per invoice line to be credited, identifying the line in the Credit Against Line column.
-- - A negative Credit Line Amount is required for each credited line. It defaults to the full line amount; edit it for a partial line credit.
-- - Credit Tax Amount and Credit Freight Amount are not used at line level. Credit tax and freight using a header level credit, or let the credit method spread the tax automatically.
-- The report parameters Credit Method for Rules and Credit Method for Installments control how the credit is applied across accounting rule periods and payment schedules.
-- On a line with an invoicing rule, enter one distribution row per accounting class - Revenue plus Unearned Revenue or Unbilled Receivable - each allocating the whole line.
-- Excel Example Output: https://www.enginatics.com/example/ar-transaction-upload/
-- Library Link: https://www.enginatics.com/reports/ar-transaction-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
to_number(null) upload_row,
null use_salespersons,
null derive_applied_cm_batch_source,
null credit_method_for_rules,
null credit_method_for_installments,
to_number(null) p_trx_idx,
to_number(null) p_line_idx,
to_number(null) p_dist_idx,
to_number(null) p_scred_idx,
--
haouv.name operating_unit,
rbsa.name source,
trunc(sysdate) default_gl_date,
--
null upload_trx_identifier,
rcta.ct_reference reference,
--
hp_b.party_name bill_to_customer_name,
hca_b.account_number bill_to_customer_number,
hcsua_b.location bill_to_site,
hz_format_pub.format_address(hps_b.location_id,null,null,', ') bill_to_address,
--
hp_s.party_name ship_to_customer_name,
hca_s.account_number ship_to_customer_number,
hcsua_s.location ship_to_site,
hz_format_pub.format_address(hps_s.location_id,null,null,', ') ship_to_address,
hp_sold.party_name sold_to_customer_name,
--
null credit_against_transaction,
null credit_against_line,
to_number(null) credit_line_amount,
to_number(null) credit_tax_amount,
to_number(null) credit_freight_amount,
xxen_util.meaning(rcta.reason_code,'CREDIT_MEMO_REASON',222) credit_memo_reason,
null applied_credit_batch_source,
--
rctta.name trx_type,
rctta.type trx_class,
rcta.trx_number,
rcta.trx_date,
apsa.gl_date,
(select jrrev2.resource_name from jtf_rs_salesreps jrs2, jtf_rs_resource_extns_vl jrrev2 where rcta.primary_salesrep_id=jrs2.salesrep_id and jrs2.org_id=rcta.org_id and jrs2.resource_id=jrrev2.resource_id and rownum=1) salesperson,
rcta.purchase_order,
rcta.purchase_order_revision,
rcta.purchase_order_date,
(select
 rtv.name
 from
 ra_terms_vl rtv
 where
 rtv.term_id=rcta.term_id
) terms,
(select
 arm.name
 from
 ar_receipt_methods arm
 where
 arm.receipt_method_id=rcta.receipt_method_id
) receipt_method,
(select
 case itev.instrument_type
 when 'BANKACCOUNT' then itev.account_number || ' / ' || itev.currency_code || ' / ' || itev.bank_name || ' / ' || itev.bank_branch_name
 when 'CREDITCARD'  then itev.card_issuer_name || ' / ' || itev.card_number || ' / ' || itev.card_holder_name || ' / ' || itev.card_expiration_status
 else null
 end
 from
 iby_trxn_extensions_v itev
 where
 itev.trxn_extension_id=rcta.payment_trxn_extension_id
) payment_instrument,
--
apsa.amount_due_original trx_amount,
rcta.invoice_currency_code trx_currency,
(select
 gdct.user_conversion_type
 from
 gl_daily_conversion_types gdct
 where
 gdct.conversion_type=rcta.exchange_rate_type
) exchange_rate_type,
rcta.exchange_date exchange_rate_date,
rcta.exchange_rate,
(select
 gcck_rec.concatenated_segments
 from
 ra_cust_trx_line_gl_dist_all rctlgda_rec,
 gl_code_combinations_kfv gcck_rec
 where
 rctlgda_rec.customer_trx_id=rcta.customer_trx_id and
 rctlgda_rec.account_class='REC' and
 rctlgda_rec.latest_rec_flag='Y' and
 rctlgda_rec.code_combination_id=gcck_rec.code_combination_id
) receivables_account,
--
rctla.line_number,
initcap(rctla.line_type) line_type,
(select rctla2.line_number
 from
 ra_customer_trx_lines_all rctla2
 where
 rctla2.customer_trx_line_id=rctla.link_to_cust_trx_line_id
) link_to_line_number,
(select
 msiv.concatenated_segments
 from
 mtl_system_items_vl msiv
 where
 msiv.inventory_item_id=rctla.inventory_item_id and
 msiv.organization_id=to_number(oe_profile.value('SO_ORGANIZATION_ID', rctla.org_id))
) line_item,
(select
 aml.name
 from
 ar_memo_lines_all_vl aml
 where
 aml.memo_line_id=rctla.memo_line_id
) line_standard_memo,
rctla.description line_description,
xxen_util.meaning(rctla.reason_code,case rctta.type when 'CM' then 'CREDIT_MEMO_REASON' else 'INVOICING_REASON' end,222) line_reason,
(select
 muomv.unit_of_measure_tl
 from
 mtl_units_of_measure_vl muomv
 where
 muomv.uom_code=rctla.uom_code
) uom,
nvl(rctla.quantity_invoiced,
    rctla.quantity_credited
) quantity,
rctla.unit_selling_price unit_price,
rctla.extended_amount line_amount,
--
(select jrrev2.resource_name from jtf_rs_salesreps jrs2, jtf_rs_resource_extns_vl jrrev2 where rctlsa.salesrep_id=jrs2.salesrep_id and jrs2.org_id=rcta.org_id and jrs2.resource_id=jrrev2.resource_id) line_salesperson,
rctlsa.revenue_percent_split line_salescredit_revenue_pct,
rctlsa.revenue_amount_split line_salescredit_revenue_amt,
--
gcck.concatenated_segments distribution_account,
rctlgda.percent distribution_percent,
rctlgda.amount distribution_amount,
xxen_util.meaning(rctlgda.account_class,'AUTOGL_TYPE',222) distribution_class,
--
(select
 rr.name
 from
 ra_rules rr
 where
 rr.type='I' and
 rr.rule_id=rcta.invoicing_rule_id
) invoicing_rule,
(select
 rr.name
 from
 ra_rules rr
 where
 rr.type!='I' and
 rr.rule_id=rctla.accounting_rule_id
) accounting_rule,
rctla.accounting_rule_duration rule_duration,
rctla.rule_start_date,
rctla.rule_end_date,
--
(select
 ofr.description
 from
 org_freight ofr
 where
 ofr.freight_code=rcta.ship_via and
 ofr.organization_id=to_number(oe_profile.value('SO_ORGANIZATION_ID',rcta.org_id)) and
 rownum<=1
) carrier,
rcta.ship_date_actual ship_date,
rcta.waybill_number shipping_reference,
xxen_util.meaning(rcta.fob_point,'FOB',222) fob,
--
rctla.sales_order,
rctla.sales_order_line,
rctla.sales_order_date,
--
xxen_util.meaning(rctla.historical_flag,'YES_NO',0) historical,
xxen_util.meaning(rctla.taxable_flag,'YES_NO',0) taxable,
xxen_util.meaning(rctla.amount_includes_tax_flag,'YES_NO',0) amount_includes_tax,
xxen_util.meaning(rctla.tax_exempt_flag,'ZX_EXEMPTION_CONTROL',0) tax_handling,
rctla.tax_exempt_number,
xxen_util.meaning(rctla.tax_exempt_reason_code,'ZX_EXEMPTION_REASON_CODE',0) tax_exempt_reason,
--
-- default taxation country
(select
 ft.territory_short_name
 from
 fnd_territories_vl ft
 where
 ft.territory_code=zldt.default_taxation_country
) default_taxation_country,
-- tax_classification
(select
  zocv.meaning
 from
  zx_output_classifications_v zocv
 where
  zocv.lookup_type='ZX_OUTPUT_CLASSIFICATIONS' and
  zocv.lookup_code=rctla.tax_classification_code and
  (zocv.org_id=rctla.org_id or zocv.org_id=-99) and
  zocv.enabled_flag='Y' and
  trunc(rcta.trx_date) between nvl(zocv.start_date_active, trunc(rcta.trx_date)) and nvl(zocv.end_date_active, trunc(rcta.trx_date)) and
  rownum<=1
) tax_classification,
-- trx_business_category
(select
 zfbcv.classification_name
 from
 zx_fc_business_categories_v zfbcv
 where
 zfbcv.classification_code=zldt.trx_business_category and
 (zfbcv.country_code=zldt.default_taxation_country or zfbcv.country_code is null) and
 zfbcv.application_id=zldt.application_id and
 zfbcv.entity_code=zldt.entity_code and
 zfbcv.event_class_code=zldt.event_class_code and
 rownum<=1
) trx_business_category,
-- product_fisc_classification
(select
 zfpfv.classification_name
 from
 zx_fc_product_fiscal_v zfpfv
 where
 zfpfv.classification_code=zldt.product_fisc_classification and
 zfpfv.country_code=zldt.default_taxation_country and
 rownum<=1
) product_fisc_classification,
-- product_category
(select
 zfpcv.classification_name
 from
 zx_fc_product_categories_v zfpcv
 where
 zfpcv.classification_code=zldt.product_category and
 (zfpcv.country_code=zldt.default_taxation_country or zfpcv.country_code IS null) and
 rownum<=1
) product_category,
-- product_type
(select
 zptv.classification_name
 from
 zx_product_types_v zptv
 where
 zptv.classification_code=zldt.product_type and
 rownum<=1
) product_type,
-- line_intended_use
(select
 zfcv.classification_name
 from
 zx_fc_codes_vl zfcv
 where
 zfcv.classification_code=zldt.line_intended_use and
 zfcv.classification_type_code='INTENDED_USE' and
 not exists
 (select
  null
  from
  zx_fc_types_b zftb
  where
  zftb.classification_type_code=zfcv.classification_type_code and
  zftb.owner_table_code='MTL_CATEGORY_SETS_B'
 )
 union
 select
 mct.description
 from
 zx_fc_types_b zft,
 mtl_category_sets_b mcs,
 fnd_id_flex_structures_vl fifs,
 mtl_categories_b_kfv mc,
 mtl_categories_tl mct
 where
 zft.owner_table_code='MTL_CATEGORY_SETS_B' and
 zft.classification_type_code='INTENDED_USE' and
 mcs.category_set_id=zft.owner_id_num and
 fifs.id_flex_num=mcs.structure_id and
 mc.category_id=mct.category_id and
 mct.language=userenv ('LANG') and
 mc.structure_id=fifs.id_flex_num and
 fifs.application_id=401 and
 fifs.id_flex_code='MCAT' and
 mc.enabled_flag='Y' and
 replace(mc.concatenated_segments,fifs.concatenated_segment_delimiter, '')=zldt.line_intended_use and
 rownum<=1
) intended_use,
--(select
-- zfudv.classification_name
-- from
-- zx_fc_user_defined_v zfudv
-- where
-- zfudv.classification_code=zldt.user_defined_fisc_class and
-- (zfudv.country_code=zldt.default_taxation_country or zfudv.country_code is null) and
-- rownum<=1
--) user_defined_fisc_class,
--
zl.tax_regime_code,
zl.tax,
zl.tax_jurisdiction_code tax_jurisdiction,
zl.tax_status_code tax_status,
zl.tax_rate_code tax_rate_name,
zl.tax_rate,
--
rcta.internal_notes invoice_special_instructions,
rcta.comments invoice_comments,
-- interface header attributes
xxen_util.display_flexfield_context(222,'RA_INTERFACE_HEADER',rcta.interface_header_context) interface_header_context,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE1', rcta.rowid,rcta.interface_header_attribute1) ar_int_header_attribute1,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE2', rcta.rowid,rcta.interface_header_attribute2) ar_int_header_attribute2,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE3', rcta.rowid,rcta.interface_header_attribute3) ar_int_header_attribute3,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE4', rcta.rowid,rcta.interface_header_attribute4) ar_int_header_attribute4,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE5', rcta.rowid,rcta.interface_header_attribute5) ar_int_header_attribute5,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE6', rcta.rowid,rcta.interface_header_attribute6) ar_int_header_attribute6,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE7', rcta.rowid,rcta.interface_header_attribute7) ar_int_header_attribute7,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE8', rcta.rowid,rcta.interface_header_attribute8) ar_int_header_attribute8,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE9', rcta.rowid,rcta.interface_header_attribute9) ar_int_header_attribute9,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE10',rcta.rowid,rcta.interface_header_attribute10) ar_int_header_attribute10,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE11',rcta.rowid,rcta.interface_header_attribute11) ar_int_header_attribute11,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE12',rcta.rowid,rcta.interface_header_attribute12) ar_int_header_attribute12,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE13',rcta.rowid,rcta.interface_header_attribute13) ar_int_header_attribute13,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE14',rcta.rowid,rcta.interface_header_attribute14) ar_int_header_attribute14,
xxen_util.display_flexfield_value(222,'RA_INTERFACE_HEADER',rcta.interface_header_context,'INTERFACE_HEADER_ATTRIBUTE15',rcta.rowid,rcta.interface_header_attribute15) ar_int_header_attribute15,
-- header dff
xxen_util.display_flexfield_context(222,'RA_CUSTOMER_TRX',rcta.attribute_category) invoice_attribute_category,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE1', rcta.rowid,rcta.attribute1) ar_inv_attribute1,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE2', rcta.rowid,rcta.attribute2) ar_inv_attribute2,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE3', rcta.rowid,rcta.attribute3) ar_inv_attribute3,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE4', rcta.rowid,rcta.attribute4) ar_inv_attribute4,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE5', rcta.rowid,rcta.attribute5) ar_inv_attribute5,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE6', rcta.rowid,rcta.attribute6) ar_inv_attribute6,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE7', rcta.rowid,rcta.attribute7) ar_inv_attribute7,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE8', rcta.rowid,rcta.attribute8) ar_inv_attribute8,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE9', rcta.rowid,rcta.attribute9) ar_inv_attribute9,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE10',rcta.rowid,rcta.attribute10) ar_inv_attribute10,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE11',rcta.rowid,rcta.attribute11) ar_inv_attribute11,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE12',rcta.rowid,rcta.attribute12) ar_inv_attribute12,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE13',rcta.rowid,rcta.attribute13) ar_inv_attribute13,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE14',rcta.rowid,rcta.attribute14) ar_inv_attribute14,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX',rcta.attribute_category,'ATTRIBUTE15',rcta.rowid,rcta.attribute15) ar_inv_attribute15,
-- line dff
xxen_util.display_flexfield_context(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category) line_attribute_category,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE1',  rctla.rowid,rctla.attribute1) ar_inv_line_attribute1,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE2',  rctla.rowid,rctla.attribute2) ar_inv_line_attribute2,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE3',  rctla.rowid,rctla.attribute3) ar_inv_line_attribute3,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE4',  rctla.rowid,rctla.attribute4) ar_inv_line_attribute4,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE5',  rctla.rowid,rctla.attribute5) ar_inv_line_attribute5,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE6',  rctla.rowid,rctla.attribute6) ar_inv_line_attribute6,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE7',  rctla.rowid,rctla.attribute7) ar_inv_line_attribute7,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE8',  rctla.rowid,rctla.attribute8) ar_inv_line_attribute8,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE9',  rctla.rowid,rctla.attribute9) ar_inv_line_attribute9,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE10', rctla.rowid,rctla.attribute10) ar_inv_line_attribute10,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE11', rctla.rowid,rctla.attribute11) ar_inv_line_attribute11,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE12', rctla.rowid,rctla.attribute12) ar_inv_line_attribute12,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE13', rctla.rowid,rctla.attribute13) ar_inv_line_attribute13,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE14', rctla.rowid,rctla.attribute14) ar_inv_line_attribute14,
xxen_util.display_flexfield_value(222,'RA_CUSTOMER_TRX_LINES',rctla.attribute_category,'ATTRIBUTE15', rctla.rowid,rctla.attribute15) ar_inv_line_attribute15,
-- distribution dff
xxen_util.display_flexfield_context(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category) dist_attribute_category,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE1',  rctlgda.rowid,rctlgda.attribute1) ar_inv_dist_attribute1,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE2',  rctlgda.rowid,rctlgda.attribute2) ar_inv_dist_attribute2,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE3',  rctlgda.rowid,rctlgda.attribute3) ar_inv_dist_attribute3,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE4',  rctlgda.rowid,rctlgda.attribute4) ar_inv_dist_attribute4,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE5',  rctlgda.rowid,rctlgda.attribute5) ar_inv_dist_attribute5,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE6',  rctlgda.rowid,rctlgda.attribute6) ar_inv_dist_attribute6,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE7',  rctlgda.rowid,rctlgda.attribute7) ar_inv_dist_attribute7,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE8',  rctlgda.rowid,rctlgda.attribute8) ar_inv_dist_attribute8,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE9',  rctlgda.rowid,rctlgda.attribute9) ar_inv_dist_attribute9,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE10', rctlgda.rowid,rctlgda.attribute10) ar_inv_dist_attribute10,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE11', rctlgda.rowid,rctlgda.attribute11) ar_inv_dist_attribute11,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE12', rctlgda.rowid,rctlgda.attribute12) ar_inv_dist_attribute12,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE13', rctlgda.rowid,rctlgda.attribute13) ar_inv_dist_attribute13,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE14', rctlgda.rowid,rctlgda.attribute14) ar_inv_dist_attribute14,
xxen_util.display_flexfield_value(222,'RA_CUST_TRX_LINE_GL_DIST',rctlgda.attribute_category,'ATTRIBUTE15', rctlgda.rowid,rctlgda.attribute15) ar_inv_dist_attribute15,
null attachment_category_,
null attachment_title_,
null attachment_description_,
null attachment_type_,
null attachment_content_,
null attachment_file_id_
from
hr_all_organization_units_vl haouv,
ra_customer_trx_all rcta,
ar_payment_schedules_all apsa,
ra_customer_trx_lines_all rctla,
ra_cust_trx_line_gl_dist_all rctlgda,
ra_cust_trx_line_salesreps_all rctlsa,
gl_code_combinations_kfv gcck,
ra_batch_sources_all rbsa,
ra_batches_all rba,
ra_cust_trx_types_all rctta,
hz_cust_accounts hca_b,
hz_parties hp_b,
hz_cust_site_uses_all hcsua_b,
hz_cust_acct_sites_all hcasa_b,
hz_party_sites hps_b,
hz_cust_accounts hca_s,
hz_parties hp_s,
hz_cust_site_uses_all hcsua_s,
hz_cust_acct_sites_all hcasa_s,
hz_party_sites hps_s,
hz_cust_accounts hca_sold,
hz_parties hp_sold,
zx_lines_det_factors zldt,
zx_lines zl
--
where
haouv.organization_id=rcta.org_id and
rcta.customer_trx_id=apsa.customer_trx_id and
rcta.customer_trx_id=rctla.customer_trx_id and
rctla.line_type in ('LINE','FREIGHT','TAX') and
rctla.customer_trx_line_id=rctlgda.customer_trx_line_id and
rctlgda.account_class in ('REV','UNEARN','UNBILL','FREIGHT','TAX') and
rctlgda.code_combination_id=gcck.code_combination_id and
rctla.customer_trx_id = rctlsa.customer_trx_id and
rctla.customer_trx_line_id = rctlsa.customer_trx_line_id and
--
rcta.batch_source_id=rbsa.batch_source_id (+) and
rcta.org_id=rbsa.org_id (+) and
rcta.batch_id=rba.batch_id (+) and
rcta.org_id=rba.org_id (+) and
rcta.cust_trx_type_id=rctta.cust_trx_type_id and
rcta.org_id=rctta.org_id and
rcta.bill_to_customer_id=hca_b.cust_account_id and
hca_b.party_id=hp_b.party_id and
rcta.bill_to_site_use_id=hcsua_b.site_use_id and
hcsua_b.cust_acct_site_id=hcasa_b.cust_acct_site_id and
hcasa_b.party_site_id=hps_b.party_site_id and
rcta.ship_to_customer_id=hca_s.cust_account_id(+) and
hca_s.party_id=hp_s.party_id(+) and
rcta.ship_to_site_use_id=hcsua_s.site_use_id (+) and
hcsua_s.cust_acct_site_id=hcasa_s.cust_acct_site_id (+) and
hcasa_s.party_site_id=hps_s.party_site_id (+) and
rcta.sold_to_customer_id=hca_sold.cust_account_id(+) and
hca_sold.party_id=hp_sold.party_id(+) and
--
rctla.customer_trx_id=zldt.trx_id (+) and
rctla.customer_trx_line_id=zldt.trx_line_id (+) and
zldt.application_id (+)=222 and
zldt.entity_code (+)='TRANSACTIONS' and
zldt.line_level_action (+) NOT IN ('CANCEL','DISCARD','DELETE') and
--
case when rctla.line_type='TAX' then rctla.tax_line_id end=zl.tax_line_id (+) and
--
:p_operating_unit=:p_operating_unit and
:p_source=:p_source and
nvl(:p_default_trx_type,'?')=nvl(:p_default_trx_type,'?') and
nvl(:p_default_gl_date,sysdate)=nvl(:p_default_gl_date,sysdate) and
nvl(:p_default_trx_date,sysdate)=nvl(:p_default_trx_date,sysdate) and
nvl(:p_default_trx_curr,'?')=nvl(:p_default_trx_curr,'?') and
nvl(:p_default_exch_rate_type,'?')=nvl(:p_default_exch_rate_type,'?') and
nvl(:p_use_salespersons,'?')=nvl(:p_use_salespersons,'?') and
nvl(:p_historical_load,'?')=nvl(:p_historical_load,'?') and
nvl(:p_derive_batch_source_applied,'?')=nvl(:p_derive_batch_source_applied,'?') and
nvl(:p_credit_method_rules,'?')=nvl(:p_credit_method_rules,'?') and
nvl(:p_credit_method_installments,'?')=nvl(:p_credit_method_installments,'?') and
1=0
