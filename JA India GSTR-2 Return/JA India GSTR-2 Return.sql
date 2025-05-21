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

select
jprlv.registration_number gstn,
jprv.party_name registered_person,
jprv.operating_unit,
jgrtdt.section_code,
jgrtdt.period_name,
jgrtdt.supp_type sply_ty,
case when jgrtdt.section_code in ('B2B','B2BUR','IMPS','IMPG','CDN','TXI','TXPD') then jgrtdt.inv_check_sum_val end chksum,
jgrtdt.third_party_reg_num ctin,
jgrtdt.tax_invoice_number inum,
jgrtdt.tax_invoice_date idt,
jgrtdt.tax_invoice_value val,
jgrtdt.rev_charge rchrg,
jgrtdt.ecom_operator etin,
jgrtdt.inv_type inv_typ,
jgrtdt.tax_rate rt,
jgrtdt.taxable_amt,
jgrtdt.sgst samt,
jgrtdt.cgst camt,
jgrtdt.igst iamt,
jgrtdt.cess csamt,
jgrtdt.state pos,
case when jgrtdt.section_code in ('B2B','CDN') then 'A'
when jgrtdt.section_code in ('B2BUR','IMPG','NIL','ITRVSL','HSN') then 'D' 
else jgrtdt.flag
end flag,
jgrtdt.trx_number,
jgrtdt.trx_date,
decode(jgrtdt.event_class_code,'CREDIT_MEMO','C','DEBIT_MEMO','D') ntty,
jgrtdt.export_type typ,
jgrtdt.nil_amount nil_amt,
jgrtdt.expt_amount expt_amt,
jgrtdt.ngsup_amount ngsup_amt,
jgrtdt.adv_receipt_amt ad_amt,
jgrtdt.hsn_code hsn_sc,
jgrtdt.hsn_desc "desc",
jgrtdt.uom uqc ,
jgrtdt.qty qty,           
jgrtdt.attribute1,
jgrtdt.inelig_itc_flag elig,
jgrtdt.itc_igst itc_igst,
jgrtdt.itc_sgst itc_sgst,
jgrtdt.itc_cgst itc_cgst,
jgrtdt.itc_cess itc_cess,
jgrtdt.port_code portcode,
jgrtdt.is_sez is_sez,
jgrtdt.rev_gstin revctin,
jgrtdt.rev_inv_num revinum,
jgrtdt.rev_inv_date revidt,
jgrtdt.rev_inv_val revinvval,
jgrtdt.note_type ntty,
jgrtdt.p_gst p_gst,
jgrtdt.rsn rsn,
jgrtdt.expt_amount expt_amt,
jgrtdt.ngsup_amount ngsup_amt
from
jai_party_reg_lines_v jprlv,
jai_party_regs_v jprv,
jai_gst_rep_trx_detail_t jgrtdt
where
2=2 and
jprlv.party_reg_id=jprv.party_reg_id and
jprv.party_type_code in ('IO','OU') and
jprlv.registration_number=jgrtdt.first_party_primary_reg_num and
jprlv.registration_number=:p_first_pty_reg_num and
jgrtdt.attribute12='GSTR2'