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

select
jprlv.registration_number gstn,
jprv.party_name registered_person,
jprv.operating_unit,
jgrtdt.section_code,
jgrtdt.period_name,
jgrtdt.rev_inv_num isnum,
jgrtdt.flag flag,
jgrtdt.supp_type sply_ty,
trunc(jgrtdt.rev_inv_date) isdt,
jgrtdt.inv_check_sum_val chksum,
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
jgrtdt.state pos
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
jgrtdt.attribute2 from_num,
jgrtdt.attribute3 to_num,
jgrtdt.attribute9 totnum,
jgrtdt.attribute10 cancel_num,
jgrtdt.attribute11 net_issue    
from
jai_party_reg_lines_v jprlv,
jai_party_regs_v jprv,
jai_gst_rep_trx_detail_t jgrtdt
where
2=2 and
jprlv.registration_number=:p_first_pty_reg_num and
jprlv.party_reg_id=jprv.party_reg_id and
jprv.party_type_code in ('IO','OU') and
jprlv.registration_number=jgrtdt.first_party_primary_reg_num