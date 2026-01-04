/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: JA India GSTR-1 Return
-- Description: Imported from BI Publisher
Description: India GSTR-1 Return Report in XML format
Application: Asia/Pacific Localizations
Source: India GSTR-1 Return Report(XML)
Short Name: JAIGSTR1_XML
DB package: JAI_GST_EXTRACT_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ja-india-gstr-1-return/
-- Library Link: https://www.enginatics.com/reports/ja-india-gstr-1-return/
-- Run Report: https://demo.enginatics.com/

with jai_party_reg as(
select 
jprv.party_reg_id,
jprlv.registration_number,
jprv.party_name,
jprv.operating_unit
from  
jai_party_reg_lines_v jprlv,
jai_party_regs_v jprv
where 
1=1 and
jprlv.registration_number=:p_first_pty_reg_num and 
jprlv.party_reg_id=jprv.party_reg_id and 
jprv.party_type_code in ('IO','OU') and 
rownum=1)
-- main query
select
jpr.registration_number "GSTIN",
jpr.party_name registered_person,
jpr.operating_unit,
jgrtdt.period_name,
jgrtdt.section_code,
jgrtdt.rev_charge reverse_charge,
jgrtdt.third_party_reg_num "GSTIN/UIN",
jgrtdt.tax_invoice_number invoice_number,
jgrtdt.tax_invoice_date invoice_date,
jgrtdt.tax_invoice_value invoice_value,
jgrtdt.tax_rate,
jgrtdt.taxable_amt taxable_value,
jgrtdt.igst,
jgrtdt.cgst,
jgrtdt.sgst,
jgrtdt.cess cess_amount,
jgrtdt.state,
jgrtdt.shippable_bill_no "Shipping Bill/Bill of Export",
jgrtdt.rev_inv_num,
jgrtdt.flag,
jgrtdt.supp_type supply_type,
trunc(jgrtdt.rev_inv_date) rev_inv_date,
jgrtdt.inv_check_sum_val,
jgrtdt.ecom_operator,
jgrtdt.inv_type,
jgrtdt.trx_number,
jgrtdt.trx_date,
decode(jgrtdt.event_class_code,'CREDIT_MEMO','C','DEBIT_MEMO','D') event_class_code,
jgrtdt.export_type,
jgrtdt.nil_amount nil_rated_supplies_amt,
jgrtdt.expt_amount exempted_amt,
jgrtdt.ngsup_amount non_gst_supplies_amt,
jgrtdt.adv_receipt_amt "Gross Advance Received/Adjusted",
jgrtdt.hsn_code,
jgrtdt.hsn_desc,
jgrtdt.uom,
jgrtdt.qty quantity,           
jgrtdt.attribute1 doc_issue,
jgrtdt.attribute2 from_num,
jgrtdt.attribute3 to_num,
jgrtdt.attribute9 total_num,
jgrtdt.attribute10 cancelled_num,
jgrtdt.attribute11 net_issued    
from
jai_party_reg jpr,
jai_gst_rep_trx_detail_t jgrtdt
where
2=2 and
jpr.registration_number=jgrtdt.first_party_primary_reg_num