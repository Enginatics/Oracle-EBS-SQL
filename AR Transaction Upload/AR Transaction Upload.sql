/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Transaction Upload
-- Description: This upload can be used to create Invoices, On Account Credit Memos and Debit Memos.

The ‘Upload Trx Identifier’ column is used to uniquely identify each individual transaction (invoice, credit memo, debit memo) to be uploaded. 
If the selected batch source uses manual transaction numbering, the Upload Trx Identifier will be copied to the Transaction Number column (the Oracle Transaction Number), but this can be overridden in the upload excel.
If the selected transaction type uses a Manual Document Sequence, the Upload Trx Identifier will be used as the Document Sequence Value in Oracle.

The upload supports the entry of
- Standard Invoice Lines
- Manual Tax Lines (if permitted)
- Header Level Freight Lines (if permitted) – identified by leaving the Link to Line Number null
- Line Level Freight Lines (if permitted) – identified by populating the Link to Line Number column 

For Tax Lines, and Line level Freight Lines, use the Link to Line Number to identify the Invoice Line to which the Tax Line or Freight Line should be linked. Tax Lines must be linked to a standard invoice line.

Note. Tax Lines and Line level Freight Lines must occur after the row containing the invoice line to which they will be linked, although it does not need to be immediately following.

- A Quantity and Unit Price must be specified for standard invoice lines. The upload will calculate the line amount.
- You can specify a quantity and unit price for a freight line in which case the upload will calculate the line amount, or you enter the line amount directly. Only the amount is uploaded to Oracle.
- For manual Tax Lines, you can enter the line amount directly. If left blank, the upload will calculate the amount based on the selected Tax Rate and the line amount from the linked standard invoice.

For Manual Tax Lines you must specify the Tax Regime, Tax, Tax Jurisdiction, Tax Status, Tax Rate Name, and Tax Rate columns.  

-- Excel Examle Output: https://www.enginatics.com/example/ar-transaction-upload/
-- Library Link: https://www.enginatics.com/reports/ar-transaction-upload/
-- Run Report: https://demo.enginatics.com/

/*
&report_table_name
*/
select
x.*
from
(
select
null                               action_,
null                               status_,
null                               message_,
null                               request_id_,
to_number(null)                    p_trx_idx,
to_number(null)                    p_line_idx,
to_number(null)                    p_dist_idx,
--
--rba.name                           batch_name,
haouv.name                         operating_unit,
rbsa.name                          source,
trunc(sysdate)                     default_gl_date,
--
null                               upload_trx_identifier,
--
hp_b.party_name                    bill_to_customer_name,
hca_b.account_number               bill_to_customer_number,
hcsua_b.location                   bill_to_site,
hz_format_pub.format_address(hps_b.location_id,null,null,', ') bill_to_address,
--
hp_s.party_name                    ship_to_customer_name,
hca_s.account_number               ship_to_customer_number,
hcsua_s.location                   ship_to_site,
hz_format_pub.format_address(hps_s.location_id,null,null,', ') ship_to_address,
--
rctta.name                         trx_type,
rcta.trx_number                    trx_number,
rcta.trx_date                      trx_date,
apsa.gl_date                       gl_date,
jrrev.resource_name                salesperson,
(select
 rtv.name
 from
 ra_terms_vl rtv
 where
 rtv.term_id = rcta.term_id
)                                  terms,
(select
 arm.name
 from
 ar_receipt_methods arm
 where
 arm.receipt_method_id = rcta.receipt_method_id
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
 itev.trxn_extension_id = rcta.payment_trxn_extension_id
) payment_instrument,
--
apsa.amount_due_original           trx_amount,
rcta.invoice_currency_code         trx_currency,
(select
 gdct.user_conversion_type
 from
 gl_daily_conversion_types gdct
 where
 gdct.conversion_type = rcta.exchange_rate_type
)                                  exchange_rate_type,
rcta.exchange_date                 exchange_rate_date,
rcta.exchange_rate                 exchange_rate,
--
rctla.line_number                  line_number,
initcap(rctla.line_type)           line_type,
(select rctla2.line_number
 from
 ra_customer_trx_lines_all rctla2
 where
 rctla2.customer_trx_line_id = rctla.link_to_cust_trx_line_id
) link_to_line_number,
(select
 msiv.concatenated_segments
 from
 mtl_system_items_vl msiv
 where
 msiv.inventory_item_id = rctla.inventory_item_id and
 msiv.organization_id = to_number(oe_profile.value('SO_ORGANIZATION_ID', rctla.org_id))
)                                  line_item,
rctla.description                  line_description,
xxen_util.meaning(rctla.reason_code,case rctta.type when 'CM' then 'CREDIT_MEMO_REASON' else 'INVOICING_REASON' end,222) line_reason,
(select
 muomv.unit_of_measure_tl
 from
 mtl_units_of_measure_vl muomv
 where
 muomv.uom_code = rctla.uom_code
)                                  uom,
nvl(rctla.quantity_invoiced,
    rctla.quantity_credited
)                                  quantity,
rctla.unit_selling_price           unit_price,
rctla.extended_amount              amount,
--
gcck.concatenated_segments         distribution_account,
rctlgda.percent                    distribution_percent,
rctlgda.amount                     distribution_amount,
xxen_util.meaning(rctlgda.account_class,'AUTOGL_TYPE',222) distribution_class,
--
(select
 rr.name
 from
 ra_rules rr
 where
 rr.type = 'I' and
 rr.rule_id = rcta.invoicing_rule_id
) invoicing_rule,
(select
 rr.name
 from
 ra_rules rr
 where
 rr.type != 'I' and
 rr.rule_id = rctla.accounting_rule_id
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
 ofr.freight_code = rcta.ship_via and
 ofr.organization_id = to_number(oe_profile.value('SO_ORGANIZATION_ID',rcta.org_id)) and
 rownum <= 1
) carrier,
rcta.ship_date_actual ship_date,
rcta.waybill_number shipping_reference,
xxen_util.meaning(rcta.fob_point,'FOB',222) fob,
--
rctla.sales_order,
rctla.sales_order_line,
rctla.sales_order_date,
--
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
 ft.territory_code = zldt.default_taxation_country
) default_taxation_country,
-- tax_classification
(select
  zocv.meaning
 from
  zx_output_classifications_v zocv
 where
  zocv.lookup_type = 'ZX_OUTPUT_CLASSIFICATIONS' and
  zocv.lookup_code = rctla.tax_classification_code and
  (zocv.org_id = rctla.org_id or zocv.org_id = -99) and
  zocv.enabled_flag = 'Y' and
  trunc(rcta.trx_date) between nvl(zocv.start_date_active, trunc(rcta.trx_date)) and nvl(zocv.end_date_active, trunc(rcta.trx_date)) and
  rownum <= 1
) tax_classification,
-- trx_business_category
(select
 zfbcv.classification_name
 from
 zx_fc_business_categories_v zfbcv
 where
 zfbcv.classification_code = zldt.trx_business_category and
 (zfbcv.country_code = zldt.default_taxation_country or zfbcv.country_code is null) and
 zfbcv.application_id = zldt.application_id and
 zfbcv.entity_code = zldt.entity_code and
 zfbcv.event_class_code = zldt.event_class_code and
 rownum <= 1
) trx_business_category,
-- product_fisc_classification
(select
 zfpfv.classification_name
 from
 zx_fc_product_fiscal_v zfpfv
 where
 zfpfv.classification_code = zldt.product_fisc_classification and
 zfpfv.country_code = zldt.default_taxation_country and
 rownum <= 1
) product_fisc_classification,
-- product_category
(select
 zfpcv.classification_name
 from
 zx_fc_product_categories_v zfpcv
 where
 zfpcv.classification_code = zldt.product_category and
 (zfpcv.country_code = zldt.default_taxation_country or zfpcv.country_code IS null) and
 rownum <= 1
) product_category,
-- product_type
(select
 zptv.classification_name
 from
 zx_product_types_v zptv
 where
 zptv.classification_code = zldt.product_type and
 rownum <= 1
) product_type,
-- line_intended_use
(select
 zfcv.classification_name
 from
 zx_fc_codes_vl zfcv
 where
 zfcv.classification_code = zldt.line_intended_use and
 zfcv.classification_type_code = 'INTENDED_USE' and
 not exists
 (select
  null
  from
  zx_fc_types_b zftb
  where
  zftb.classification_type_code = zfcv.classification_type_code and
  zftb.owner_table_code = 'MTL_CATEGORY_SETS_B'
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
 zft.owner_table_code = 'MTL_CATEGORY_SETS_B' and
 zft.classification_type_code = 'INTENDED_USE' and
 mcs.category_set_id = zft.owner_id_num and
 fifs.id_flex_num = mcs.structure_id and
 mc.category_id = mct.category_id and
 mct.language = userenv ('LANG') and
 mc.structure_id = fifs.id_flex_num and
 fifs.application_id = 401 and
 fifs.id_flex_code = 'MCAT' and
 mc.enabled_flag = 'Y' and
 replace(mc.concatenated_segments,fifs.concatenated_segment_delimiter, '') = zldt.line_intended_use and
 rownum <= 1
) intended_use,
--(select
-- zfudv.classification_name
-- from
-- zx_fc_user_defined_v zfudv
-- where
-- zfudv.classification_code = zldt.user_defined_fisc_class and
-- (zfudv.country_code = zldt.default_taxation_country or zfudv.country_code is null) and
-- rownum <= 1
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
rcta.comments invoice_comments
from
hr_all_organization_units_vl haouv,
ra_customer_trx_all rcta,
ar_payment_schedules_all apsa,
ra_customer_trx_lines_all rctla,
ra_cust_trx_line_gl_dist_all rctlgda,
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
jtf_rs_salesreps jrs,
jtf_rs_resource_extns_vl jrrev,
zx_lines_det_factors zldt,
zx_lines zl
--
where
haouv.organization_id = rcta.org_id and
rcta.customer_trx_id = apsa.customer_trx_id and
rcta.customer_trx_id = rctla.customer_trx_id and
rctla.line_type in ('LINE','FREIGHT','TAX') and
rctla.customer_trx_line_id = rctlgda.customer_trx_line_id and
rctlgda.account_class in ('REV','FREIGHT','TAX') and
rctlgda.code_combination_id = gcck.code_combination_id and

--
rcta.batch_source_id = rbsa.batch_source_id (+) and
rcta.org_id = rbsa.org_id (+) and
rcta.batch_id = rba.batch_id (+) and
rcta.org_id = rba.org_id (+) and
rcta.cust_trx_type_id = rctta.cust_trx_type_id and
rcta.org_id = rctta.org_id and
rcta.bill_to_customer_id = hca_b.cust_account_id and
hca_b.party_id = hp_b.party_id and
rcta.bill_to_site_use_id = hcsua_b.site_use_id and
hcsua_b.cust_acct_site_id = hcasa_b.cust_acct_site_id and
hcasa_b.party_site_id = hps_b.party_site_id and
rcta.ship_to_customer_id = hca_s.cust_account_id(+) and
hca_s.party_id = hp_s.party_id(+) and
rcta.ship_to_site_use_id = hcsua_s.site_use_id (+) and
hcsua_s.cust_acct_site_id = hcasa_s.cust_acct_site_id (+) and
hcasa_s.party_site_id = hps_s.party_site_id (+) and
rcta.primary_salesrep_id=jrs.salesrep_id(+) and
rcta.org_id=jrs.org_id(+) and
jrs.resource_id=jrrev.resource_id(+) and
--
rctla.customer_trx_id = zldt.trx_id (+) and
rctla.customer_trx_line_id = zldt.trx_line_id (+) and
zldt.application_id (+) = 222 and
zldt.entity_code (+) = 'TRANSACTIONS' and
zldt.line_level_action (+) NOT IN ('CANCEL','DISCARD','DELETE') and
--
case when rctla.line_type = 'TAX' then rctla.tax_line_id end = zl.tax_line_id (+) and
--
:p_operating_unit = :p_operating_unit and
:p_source = :p_source and
nvl(:p_default_trx_type,'?') = nvl(:p_default_trx_type,'?') and
nvl(:p_default_gl_date,sysdate) = nvl(:p_default_gl_date,sysdate) and
nvl(:p_default_trx_date,sysdate) = nvl(:p_default_trx_date,sysdate) and
nvl(:p_default_trx_curr,'?') = nvl(:p_default_trx_curr,'?') and
nvl(:p_default_exch_rate_type,'?') = nvl(:p_default_exch_rate_type,'?') and
1=0
&not_use_first_block
&processed_errors_query
&processed_success_query
&processed_run
) x
order by
x.p_trx_idx,
x.p_line_idx,
x.p_dist_idx