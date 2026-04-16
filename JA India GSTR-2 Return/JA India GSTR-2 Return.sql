/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: JA India GSTR-2 Return
-- Description: Imported from BI Publisher
Description: India GSTR-2 Return Report with XML Format
Application: Asia/Pacific Localizations
Source: India GSTR-2 Return Report(XML)
Short Name: JAIGSTR2_XML
DB package: JAI_GSTR2_EXTRACT_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ja-india-gstr-2-return/
-- Library Link: https://www.enginatics.com/reports/ja-india-gstr-2-return/
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
jpr.registration_number gstn,
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
jgrtdt.inelig_itc_flag ineligible_for_itc,
jgrtdt.itc_igst itc_igst,
jgrtdt.itc_sgst itc_sgst,
jgrtdt.itc_cgst itc_cgst,
jgrtdt.itc_cess itc_cess,
case when jgrtdt.section_code in ('B2B','CDN') then 'A'
when jgrtdt.section_code in ('B2BUR','IMPG','NIL','ITRVSL','HSN') then 'D' 
else jgrtdt.flag
end flag,
case when jgrtdt.section_code in ('B2B','B2BUR','IMPS','IMPG','CDN','TXI','TXPD') then jgrtdt.inv_check_sum_val end chksum,
jgrtdt.ecom_operator,
jgrtdt.inv_type,
jgrtdt.supp_type supply_type,
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
jgrtdt.attribute1,
jgrtdt.port_code,
jgrtdt.is_sez,
jgrtdt.rev_gstin,
jgrtdt.rev_inv_num,
jgrtdt.rev_inv_date,
jgrtdt.rev_inv_val,
jgrtdt.note_type,
jgrtdt.p_gst,
jgrtdt.rsn,
jgrtdt.expt_amount,
jgrtdt.ngsup_amount
from
jai_party_reg jpr,
jai_gst_rep_trx_detail_t jgrtdt
where
2=2 and
jpr.registration_number=jgrtdt.first_party_primary_reg_num and
jgrtdt.attribute12='GSTR2'