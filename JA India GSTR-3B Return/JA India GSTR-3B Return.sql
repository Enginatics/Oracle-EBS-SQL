/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: JA India GSTR-3B Return
-- Description: Imported from BI Publisher
Description: GSTR-3B Return Report
Application: Asia/Pacific Localizations
Source: India GSTR-3B Return Report
Short Name: JAIGSTR3B
DB package:
-- Excel Examle Output: https://www.enginatics.com/example/ja-india-gstr-3b-return/
-- Library Link: https://www.enginatics.com/reports/ja-india-gstr-3b-return/
-- Run Report: https://demo.enginatics.com/

with party as (
select
registration_number gstn,
party_name registered_person,
operating_unit
from
jai_party_reg_lines_v a,
jai_party_regs_v b
where 
1=1 and
a.party_reg_id=b.party_reg_id and
b.party_type_code in ('IO','OU')
)
select
'31a' name,
tax_dtls.gstn "GSTN",
tax_dtls.registered_person,
tax_dtls.operating_unit,
null pos,
null type,
line_amt taxable_value,
tax_dtls.cgst "CGST",
tax_dtls.sgst "SGST",
tax_dtls.igst "IGST",
tax_dtls.cess "CESS"
from 
jai_tax_det_factors det_fact,
(select distinct
x.*,
tax.det_factor_id,
sum(decode(tax_assc.reporting_code, 'IGST', (tax_lines.rounded_tax_amt_fun_curr))) igst,
sum(decode(tax_assc.reporting_code, 'CGST', (tax_lines.rounded_tax_amt_fun_curr))) cgst,
sum(decode(tax_assc.reporting_code, 'SGST', (tax_lines.rounded_tax_amt_fun_curr))) sgst,
sum(decode(tax_assc.reporting_code, 'CESS', (tax_lines.rounded_tax_amt_fun_curr))) cess
from
party x,
jai_tax_det_factors tax,
jai_tax_lines_v tax_lines,
jai_reporting_associations_v tax_assc,
jai_rgm_recovery_lines tax_rec
where
2=2 and
to_char(trunc(tax.tax_invoice_date),'MONYYYY') = :p_period and
tax.det_factor_id=tax_lines.det_factor_id and
tax_assc.entity_code='TAX_TYPE' and
tax_assc.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
tax_lines.first_party_primary_reg_num=x.gstn and
tax_rec.tax_line_id=tax_lines.tax_line_id and
tax_lines.tax_type_id=tax_assc.entity_id and
tax_lines.actual_tax_rate<>0 and
tax_lines.actual_tax_rate is not null and
tax_lines.exemption_type is null and
tax.ship_to_country='IN' and
tax_rec.liability_amount<>0 and
tax_rec.status='CONFIRMED' and
not exists(select 1
from
jai_party_regs jpr,
jai_reporting_associations_v jrav_party
where
upper (jrav_party.reporting_code) in (upper ('Deemed Exports EOU'), upper ('SEZ'))
and jrav_party.entity_code='THIRD_PARTY'
and jrav_party.reporting_type_code='THIRD_PARTY_CLASSIFICATION'
and jpr.party_reg_id=jrav_party.entity_id
and jpr.party_id=tax.party_id
)
group by
tax.det_factor_id,
x.gstn,
x.registered_person,
x.operating_unit
) tax_dtls
where
det_fact.det_factor_id=tax_dtls.det_factor_id
union all
select
'31b' name,
tax_dtls.gstn "GSTN",
tax_dtls.registered_person,
tax_dtls.operating_unit,
null pos,
null type,
line_amt taxable_value,
null "CGST",
null "SGST",
tax_dtls.igst "IGST",
tax_dtls.cess "CESS"
from 
jai_tax_det_factors det_fact,
(select distinct
x.*,
tax.det_factor_id,
sum(decode(tax_assc.reporting_code, 'IGST', (tax_lines.rounded_tax_amt_fun_curr))) igst,
sum(decode(tax_assc.reporting_code, 'CESS', (tax_lines.rounded_tax_amt_fun_curr))) cess
from
party x,
jai_tax_det_factors tax,
jai_tax_lines_v tax_lines,
jai_reporting_associations_v tax_assc,
jai_rgm_recovery_lines tax_rec
where
2=2 and
to_char(trunc(tax.tax_invoice_date),'MONYYYY') = :p_period and
tax.det_factor_id=tax_lines.det_factor_id and
tax_assc.entity_code='TAX_TYPE' and
tax_assc.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
tax_lines.first_party_primary_reg_num=x.gstn and
tax_rec.tax_line_id=tax_lines.tax_line_id and
tax_lines.tax_type_id=tax_assc.entity_id and
tax_rec.liability_amount<>0 and
tax_rec.status='CONFIRMED' and
(tax.ship_to_country<>'IN' or
exists(select 1
from
jai_party_regs jpr,
jai_reporting_associations_v jrav_party
where
upper (jrav_party.reporting_code) in (upper ('Deemed Exports EOU'), upper ('SEZ'))
and jrav_party.entity_code='THIRD_PARTY'
and jrav_party.reporting_type_code='THIRD_PARTY_CLASSIFICATION'
and jpr.party_reg_id=jrav_party.entity_id
and jpr.party_id=tax.party_id
))
group by
tax.det_factor_id,
x.gstn,
x.registered_person,
x.operating_unit
) tax_dtls
where
det_fact.det_factor_id=tax_dtls.det_factor_id
union all
select
'31c' name,
tax_dtls.gstn "GSTN",
tax_dtls.registered_person,
tax_dtls.operating_unit,
null pos,
null type,
line_amt taxable_value,
null "CGST",
null "SGST",
null "IGST",
null "CESS"
from 
jai_tax_det_factors det_fact,
(select distinct
x.*,
tax.det_factor_id
from
party x,
jai_tax_det_factors tax,
jai_tax_lines_v tax_lines,
jai_reporting_associations_v tax_assc,
jai_rgm_recovery_lines tax_rec
where
2=2 and
to_char(trunc(tax.tax_invoice_date),'MONYYYY') = :p_period and
tax.det_factor_id=tax_lines.det_factor_id and
tax_assc.entity_code='TAX_TYPE' and
tax_assc.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
tax_lines.first_party_primary_reg_num=x.gstn and
tax_rec.tax_line_id=tax_lines.tax_line_id and
tax_lines.tax_type_id=tax_assc.entity_id and
tax_rec.status='CONFIRMED' and
((tax_lines.tax_rate_percentage is null or tax_lines.tax_rate_percentage=0) or
 (tax_lines.tax_amt_before_exemption>0 and nvl(tax_lines.rounded_tax_amt_fun_curr,0)=0))
) tax_dtls
where
det_fact.det_factor_id=tax_dtls.det_factor_id
union all
select
'31d' name,
tax_dtls.gstn "GSTN",
tax_dtls.registered_person,
tax_dtls.operating_unit,
null pos,
null type,
line_amt taxable_value,
tax_dtls.cgst "CGST",
tax_dtls.sgst "SGST",
tax_dtls.igst "IGST",
tax_dtls.cess "CESS"
from 
jai_tax_det_factors det_fact,
(select distinct
x.*,
tax.det_factor_id,
sum(decode(tax_assc.reporting_code, 'IGST', (tax_lines.rounded_tax_amt_fun_curr))) igst,
sum(decode(tax_assc.reporting_code, 'CGST', (tax_lines.rounded_tax_amt_fun_curr))) cgst,
sum(decode(tax_assc.reporting_code, 'SGST', (tax_lines.rounded_tax_amt_fun_curr))) sgst,
sum(decode(tax_assc.reporting_code, 'CESS', (tax_lines.rounded_tax_amt_fun_curr))) cess
from
party x,
jai_tax_det_factors tax,
jai_tax_lines_v tax_lines,
jai_reporting_associations_v tax_assc,
jai_rgm_recovery_lines tax_rec
where
2=2 and
to_char(trunc(tax.tax_invoice_date),'MONYYYY') = :p_period and
tax.det_factor_id=tax_lines.det_factor_id and
tax_assc.entity_code='TAX_TYPE' and
tax_assc.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
tax_lines.first_party_primary_reg_num=x.gstn and
tax_rec.tax_line_id=tax_lines.tax_line_id and
tax_lines.tax_type_id=tax_assc.entity_id and
tax_rec.liability_amount<>0 and
tax_rec.status='CONFIRMED' and
tax_lines.self_assessed_flag='Y'
group by
tax.det_factor_id,
x.gstn,
x.registered_person,
x.operating_unit
) tax_dtls
where
det_fact.det_factor_id=tax_dtls.det_factor_id
union all
select
'31e' name,
tax_dtls.gstn "GSTN",
tax_dtls.registered_person,
tax_dtls.operating_unit,
null pos,
null type,
line_amt taxable_value,
null "CGST",
null "SGST",
null "IGST",
null "CESS"
from 
jai_tax_det_factors det_fact,
(select distinct
x.*,
tax.det_factor_id
from
party x,
jai_tax_det_factors tax,
jai_tax_lines_v tax_lines,
jai_rgm_recovery_lines tax_rec
where
2=2 and
to_char(trunc(tax.tax_invoice_date),'MONYYYY') = :p_period and
tax.det_factor_id=tax_lines.det_factor_id and
tax_lines.first_party_primary_reg_num=x.gstn and
tax_rec.tax_line_id=tax_lines.tax_line_id and
tax_rec.liability_amount<>0 and
tax_rec.status='CONFIRMED' and
not exists (select 1 
from
jai_tax_types_v a,
jai_reporting_associations_v b
where 
a.tax_type_id=tax_lines.tax_type_id and
a.tax_type_id = b.entity_id and
b.reporting_code in ('IGST','SGST','CGST','CESS'))
) tax_dtls
where
det_fact.det_factor_id=tax_dtls.det_factor_id
union all
select 
'32a' name,
y.gstn "GSTN",
y.registered_person,
y.operating_unit,
y.pos,
null type,
y.taxable_value,
null "CGST",
null "SGST",
y.igst "IGST",
null "CESS"
from
(
select
x.gstn,
x.registered_person,
x.operating_unit,
tax.bill_to_state pos,
sum(tax.line_amt) taxable_value,
sum(tax_lines.rounded_tax_amt_fun_curr) igst
from
party x,
jai_tax_det_factors tax,
jai_tax_lines_v tax_lines,
jai_reporting_associations_v tax_assc,
jai_rgm_recovery_lines tax_rec
where
2=2 and
to_char(trunc(tax.tax_invoice_date),'MONYYYY') = :p_period and
tax_assc.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
tax_assc.reporting_code='IGST' and
tax_assc.entity_id=tax_lines.tax_type_id and
tax.det_factor_id=tax_lines.det_factor_id and
tax_lines.first_party_primary_reg_num=x.gstn and
tax_lines.third_party_primary_reg_num is null and
tax_rec.tax_line_id=tax_lines.tax_line_id and
tax_rec.liability_amount<>0 and
tax_rec.status='CONFIRMED' and
tax.ship_from_state<>tax.bill_to_state
group by
x.gstn,
x.registered_person,
x.operating_unit,
tax.bill_to_state
) y
union all
select
'32b' name,
x.gstn "GSTN",
x.registered_person,
x.operating_unit,
null pos,
null type,
null taxable_value,
null "CGST",
null "SGST",
null "IGST",
null "CESS"
from
party x,
dual
union all
select
'32c' name,
x.gstn "GSTN",
x.registered_person,
x.operating_unit,
null pos,
null type,
null taxable_value,
null "CGST",
null "SGST",
null "IGST",
null "CESS"
from
party x,
dual
union all
select 
'4a1' name,
y.gstn "GSTN",
y.registered_person,
y.operating_unit,
null pos,
y.type,
null taxable_value,
y.cgst "CGST",
y.sgst "SGST",
y.igst "IGST",
y.cess "CESS"
from
(
select
'IMPG' type,
x.gstn,
x.registered_person,
x.operating_unit,
sum(decode(jrav.reporting_code,'IGST',jtl.rounded_tax_amt_fun_curr)) igst,
sum(decode(jrav.reporting_code,'CGST',jtl.rounded_tax_amt_fun_curr)) cgst,
sum(decode(jrav.reporting_code,'SGST',jtl.rounded_tax_amt_fun_curr)) sgst,
sum(decode(jrav.reporting_code,'CESS',jtl.rounded_tax_amt_fun_curr)) cess
from
party x,
jai_reporting_associations_v jrav,
jai_tax_lines_v jtl,
jai_tax_det_factors tax,
jai_rgm_recovery_lines jrr
WHERE
2=2 and
to_char(trunc(tax.tax_invoice_date),'MONYYYY') = :p_period and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
sysdate between nvl(jrav.EFFECTIVE_FROM,sysdate) and nvl(jrav.effective_to,'31-DEC-4017') and
jtl.tax_type_id=jrav.entity_id and
jtl.first_party_primary_reg_num=x.gstn and
exists (select '1' from jai_tax_lines jtl1 where tax.trx_id=jtl1.trx_id and tax.trx_line_id=jtl1.trx_line_id and jtl1.applied_to_entity_code='BILL_OF_ENTRY') and
tax.det_factor_id=jtl.det_factor_id and
jrr.tax_line_id=jtl.tax_line_id and
tax.hsn_code_id is not null
group by
x.gstn,
x.registered_person,
x.operating_unit
) y
union all
select 
'4a2' name,
y.gstn "GSTN",
y.registered_person,
y.operating_unit,
null pos,
y.type,
null taxable_value,
y.cgst "CGST",
y.sgst "SGST",
y.igst "IGST",
y.cess "CESS"
from
(
select
'IMPS' type,
x.gstn,
x.registered_person,
x.operating_unit,
sum(decode(jrav.reporting_code,'IGST',jtl.rounded_tax_amt_fun_curr)) igst,
sum(decode(jrav.reporting_code,'CGST',jtl.rounded_tax_amt_fun_curr)) cgst,
sum(decode(jrav.reporting_code,'SGST',jtl.rounded_tax_amt_fun_curr)) sgst,
sum(decode(jrav.reporting_code,'CESS',jtl.rounded_tax_amt_fun_curr)) cess
from
party x,
jai_reporting_associations_v jrav,
jai_tax_lines_v jtl,
jai_tax_det_factors tax,
jai_rgm_recovery_lines jrr
where
2=2 and
to_char(trunc(tax.tax_invoice_date),'MONYYYY') = :p_period and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
sysdate between nvl(jrav.EFFECTIVE_FROM,sysdate) and nvl(jrav.effective_to,'31-DEC-4017') and
jtl.tax_type_id=jrav.entity_id and
jtl.first_party_primary_reg_num=x.gstn and
tax.ship_from_country<>'IN' and
tax.det_factor_id = jtl.det_factor_id and
jrr.tax_line_id = jtl.tax_line_id and
tax.sac_code_id is not null
group by
x.gstn,
x.registered_person,
x.operating_unit
) y
union all
select 
'4a3' name,
y.gstn "GSTN",
y.registered_person,
y.operating_unit,
null pos,
y.type,
null taxable_value,
y.cgst "CGST",
y.sgst "SGST",
y.igst "IGST",
y.cess "CESS"
from
(
select
'ISRC' type,
x.gstn,
x.registered_person,
x.operating_unit,
sum(decode(jrav.reporting_code,'IGST',jtl.rounded_tax_amt_fun_curr)) igst,
sum(decode(jrav.reporting_code,'CGST',jtl.rounded_tax_amt_fun_curr)) cgst,
sum(decode(jrav.reporting_code,'SGST',jtl.rounded_tax_amt_fun_curr)) sgst,
sum(decode(jrav.reporting_code,'CESS',jtl.rounded_tax_amt_fun_curr)) cess
from
party x,
jai_reporting_associations_v jrav,
jai_tax_lines_v jtl,
jai_tax_det_factors tax,
jai_rgm_recovery_lines jrr
where
2=2 and
to_char(trunc(tax.tax_invoice_date),'MONYYYY') = :p_period and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
sysdate between nvl(jrav.EFFECTIVE_FROM,sysdate) and nvl(jrav.effective_to,'31-DEC-4017') and
jtl.tax_type_id=jrav.entity_id and
jtl.first_party_primary_reg_num=x.gstn and
tax.det_factor_id=jtl.det_factor_id and
jrr.tax_line_id=jtl.tax_line_id and
jtl.self_assessed_flag='Y' and
jrr.status='RECOVERED' and
jrr.recovered_amount<>0
group by
x.gstn,
x.registered_person,
x.operating_unit      
) y
union all
select
'4a4' name,
x.gstn "GSTN",
x.registered_person,
x.operating_unit,
null pos,
'ISD' type,
null taxable_value,
null "CGST",
null "SGST",
null "IGST",
null "CESS"
from
party x,
dual
union all
select 
'4a5' name,
y.gstn "GSTN",
y.registered_person,
y.operating_unit,
null pos,
y.type,
null taxable_value,
y.cgst "CGST",
y.sgst "SGST",
y.igst "IGST",
y.cess "CESS"
from
(
select
'OTH' type,
x.gstn,
x.registered_person,
x.operating_unit,
sum(decode(jrav.reporting_code,'IGST',jtl.rounded_tax_amt_fun_curr)) igst,
sum(decode(jrav.reporting_code,'CGST',jtl.rounded_tax_amt_fun_curr)) cgst,
sum(decode(jrav.reporting_code,'SGST',jtl.rounded_tax_amt_fun_curr)) sgst,
sum(decode(jrav.reporting_code,'CESS',jtl.rounded_tax_amt_fun_curr)) cess
from
party x,
jai_reporting_associations_v jrav,
jai_tax_lines_v jtl,
jai_tax_det_factors tax,
jai_rgm_recovery_lines jrr
where
2=2 and
to_char(trunc(tax.tax_invoice_date),'MONYYYY') = :p_period and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
sysdate between nvl(jrav.effective_from,sysdate) and nvl(jrav.effective_to,'31-DEC-4017') and
jtl.tax_type_id=jrav.entity_id and
jtl.first_party_primary_reg_num=x.gstn and
tax.det_factor_id=jtl.det_factor_id and
jrr.tax_line_id=jtl.tax_line_id and
(nvl(jtl.applied_to_entity_code,'X')<>'BILL_OF_ENTRY' and (tax.hsn_code_id is null or tax.sac_code_id is null)) and
(jtl.self_assessed_flag<>'Y' and jrr.status='RECOVERED' and jrr.recovered_amount<>0)
group by
x.gstn,
x.registered_person,
x.operating_unit
) y
union all
select 
'4b1' name,
y.gstn "GSTN",
y.registered_person,
y.operating_unit,
null pos,
y.type,
null taxable_value,
y.cgst "CGST",
y.sgst "SGST",
y.igst "IGST",
y.cess "CESS"
from
(
select
'RUL' type,
x.gstn,
x.registered_person,
x.operating_unit,
sum(decode(jrav.reporting_code,'IGST',jtl.rounded_tax_amt_fun_curr)) igst,
sum(decode(jrav.reporting_code,'CGST',jtl.rounded_tax_amt_fun_curr)) cgst,
sum(decode(jrav.reporting_code,'SGST',jtl.rounded_tax_amt_fun_curr)) sgst,
sum(decode(jrav.reporting_code,'CESS',jtl.rounded_tax_amt_fun_curr)) cess
from
party x,
jai_reporting_associations_v jrav,
jai_tax_lines_v jtl,
jai_tax_det_factors tax,
jai_rgm_recovery_lines jrr
where
2=2 and
to_char(trunc(tax.tax_invoice_date),'MONYYYY') = :p_period and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
sysdate between nvl(jrav.effective_from,sysdate) and nvl(jrav.effective_to,'31-DEC-4017') and
jtl.tax_type_id=jrav.entity_id and
jtl.first_party_primary_reg_num=x.gstn and
tax.det_factor_id=jtl.det_factor_id and
jrr.tax_line_id=jtl.tax_line_id and
jrr.status = 'REVERSED'
group by
x.gstn,
x.registered_person,
x.operating_unit
) y
union all
select
'4b2' name,
x.gstn "GSTN",
x.registered_person,
x.operating_unit,
null pos,
'OTH' type,
null taxable_value,
null "CGST",
null "SGST",
null "IGST",
null "CESS"
from
party x,
dual
union all
select
'4c' name,
x.gstn "GSTN",
x.registered_person,
x.operating_unit,
null pos,
null type,
null taxable_value,
null "CGST",
null "SGST",
null "IGST",
null "CESS"
from
party x,
dual
union all
select 
'4d1' name,
y.gstn "GSTN",
y.registered_person,
y.operating_unit,
null pos,
y.type,
null taxable_value,
y.cgst "CGST",
y.sgst "SGST",
y.igst "IGST",
y.cess "CESS"
from
(
select
'RUL' type,
x.gstn,
x.registered_person,
x.operating_unit,
sum((select jtl2.rounded_tax_amt_fun_curr 
from jai_tax_lines_v jtl2, jai_reporting_associations_v jrav2
where
jtl2.tax_line_id=jtl.tax_line_id and jrav.entity_id=jrav2.entity_id and jrav2.reporting_code='IGST')) igst,
sum((select jtl2.rounded_tax_amt_fun_curr
from jai_tax_lines_v jtl2, jai_reporting_associations_v jrav2
where
jtl2.tax_line_id=jtl.tax_line_id and jrav.entity_id=jrav2.entity_id and jrav2.reporting_code='CGST')) cgst,
sum((select jtl2.rounded_tax_amt_fun_curr
from jai_tax_lines_v jtl2, jai_reporting_associations_v jrav2
where
jtl2.tax_line_id=jtl.tax_line_id and jrav.entity_id=jrav2.entity_id and jrav2.reporting_code='SGST')) sgst,
sum((select jtl2.rounded_tax_amt_fun_curr
from jai_tax_lines_v jtl2, jai_reporting_associations_v jrav2
where
jtl2.tax_line_id=jtl.tax_line_id and jrav.entity_id=jrav2.entity_id and jrav2.reporting_code='CESS')) cess
from
party x,
jai_reporting_associations_v jrav,
jai_tax_lines_v jtl,
jai_tax_det_factors tax,
jai_rgm_recovery_lines jrr
where
2=2 and
to_char(trunc(tax.tax_invoice_date),'MONYYYY') = :p_period and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
sysdate between nvl(jrav.effective_from,sysdate) and nvl(jrav.effective_to,'31-DEC-4017') and
jtl.tax_type_id=jrav.entity_id and
jtl.first_party_primary_reg_num=x.gstn and
tax.det_factor_id=jtl.det_factor_id and
jrr.tax_line_id=jtl.tax_line_id and
jrr.status='INELIGIBLE'
group by
x.gstn,
x.registered_person,
x.operating_unit
) y
union all
select
'4d2' name,
x.gstn "GSTN",
x.registered_person,
x.operating_unit,
null pos,
'OTH' type,
null taxable_value,
null "CGST",
null "SGST",
null "IGST",
null "CESS"
from
party x,
dual