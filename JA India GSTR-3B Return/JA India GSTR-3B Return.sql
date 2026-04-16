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

with jai_party_reg as (
select
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
-- 31a
select
'31a' section_code,
tax_dtls.registration_number gstin,
tax_dtls.party_name registered_person,
tax_dtls.operating_unit,
null pos,
null type,
tax_dtls.taxable_basis taxable_value,
tax_dtls.cgst,
tax_dtls.sgst,
tax_dtls.igst,
tax_dtls.cess_amount
from
(select
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
jtdf.det_factor_id,
jtlv.organization_name,
jtlv.location_code,
jtlv.application_name,
jtlv.entity_code,
jtlv.event_class_code,
jtlv.event_type_code,
jtlv.tax_event_class_code,
jtlv.tax_event_type_code,
jtlv.trx_type,
jtlv.trx_number,
jtlv.trx_date,
jtlv.trx_line_number,
jtlv.item_id,
jtlv.frozen_flag,
jtlv.party_type,
jtlv.party_number,
jtlv.party_site_name,
nvl(jtlv.line_amt,0) line_amt,
nvl(jtlv.taxable_basis,0) taxable_basis,
nvl(sum(decode(jrav.reporting_code,'IGST',jtlv.rounded_tax_amt_fun_curr)),0) igst,
nvl(sum(decode(jrav.reporting_code,'CGST',jtlv.rounded_tax_amt_fun_curr)),0) cgst,
nvl(sum(decode(jrav.reporting_code,'SGST',jtlv.rounded_tax_amt_fun_curr)),0) sgst,
nvl(sum(decode(jrav.reporting_code,'CESS',jtlv.rounded_tax_amt_fun_curr)),0) cess_amount
from
jai_tax_det_factors jtdf,
jai_tax_lines_v jtlv,
jai_reporting_associations_v jrav,
jai_rgm_recovery_lines jrrl,
jai_party_reg jpr
where
1=1 and
to_char(trunc(jtdf.tax_invoice_date),'MONYYYY')=:p_period and
jtdf.det_factor_id=jtlv.det_factor_id and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
jtlv.first_party_primary_reg_num=jpr.registration_number and
jrrl.tax_line_id=jtlv.tax_line_id and
jtlv.tax_type_id=jrav.entity_id and
jtlv.actual_tax_rate<>0 and
jtlv.actual_tax_rate is not null and
jtlv.exemption_type is null and
jtdf.bill_to_country='IN' and
jrrl.liability_amount<>0 and
jrrl.status='CONFIRMED' and
jtlv.self_assessed_flag<>'Y' and
not exists (select null
from
jai_party_regs jpr2,
jai_reporting_associations_v jrav2
where
upper(jrav2.reporting_code) in ('DEEMED EXPORTS EOU','SEZ') and
jrav2.entity_code='THIRD_PARTY' and
jrav2.reporting_type_code='THIRD_PARTY_CLASSIFICATION' and
jpr2.party_reg_id=jrav2.entity_id and
jpr2.party_id=jtdf.party_id)
group by
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
jtdf.det_factor_id,
jtlv.organization_name,
jtlv.location_code,
jtlv.application_name,
jtlv.entity_code,
jtlv.event_class_code,
jtlv.event_type_code,
jtlv.tax_event_class_code,
jtlv.tax_event_type_code,
jtlv.trx_type,
jtlv.trx_number,
jtlv.trx_date,
jtlv.trx_line_number,
jtlv.item_id,
jtlv.frozen_flag,
jtlv.party_type,
jtlv.party_number,
jtlv.party_site_name,
nvl(jtlv.line_amt,0),
nvl(jtlv.taxable_basis,0)) tax_dtls
union all
-- 31b
select
'31b' section_code,
tax_dtls.registration_number gstin,
tax_dtls.party_name registered_person,
tax_dtls.operating_unit,
null pos,
null type,
tax_dtls.line_amt taxable_value,
null cgst,
null sgst,
tax_dtls.igst,
tax_dtls.cess_amount
from
(select
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
jtdf.det_factor_id,
jtdf.line_amt,
sum(decode(jrav.reporting_code,'IGST',jtlv.rounded_tax_amt_fun_curr)) igst,
sum(decode(jrav.reporting_code,'CESS',jtlv.rounded_tax_amt_fun_curr)) cess_amount
from
jai_party_reg jpr,
jai_tax_det_factors jtdf,
jai_tax_lines_v jtlv,
jai_reporting_associations_v jrav,
jai_rgm_recovery_lines jrrl
where
2=2 and
to_char(trunc(jtdf.tax_invoice_date),'MONYYYY')=:p_period and
jtdf.det_factor_id=jtlv.det_factor_id and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
jtlv.first_party_primary_reg_num=jpr.registration_number and
jrrl.tax_line_id=jtlv.tax_line_id and
jtlv.tax_type_id=jrav.entity_id and
jrrl.liability_amount<>0 and
jrrl.status='CONFIRMED' and
(jtdf.ship_to_country<>'IN' or
exists (select null
from
jai_party_regs jpr2,
jai_reporting_associations_v jrav2
where
upper(jrav2.reporting_code) in ('DEEMED EXPORTS EOU','SEZ') and
jrav2.entity_code='THIRD_PARTY' and
jrav2.reporting_type_code='THIRD_PARTY_CLASSIFICATION' and
jpr2.party_reg_id=jrav2.entity_id and
jpr2.party_id=jtdf.party_id))
group by
jtdf.det_factor_id,
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
jtdf.line_amt) tax_dtls
union all
-- 31c
select
'31c' section_code,
tax_dtls.registration_number gstin,
tax_dtls.party_name registered_person,
tax_dtls.operating_unit,
null pos,
null type,
tax_dtls.line_amt taxable_value,
null cgst,
null sgst,
null igst,
null cess_amount
from
(select distinct
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
jtdf.det_factor_id,
jtdf.line_amt
from
jai_party_reg jpr,
jai_tax_det_factors jtdf,
jai_tax_lines_v jtlv,
jai_reporting_associations_v jrav,
jai_rgm_recovery_lines jrrl
where
2=2 and
to_char(trunc(jtdf.tax_invoice_date),'MONYYYY')=:p_period and
jtdf.det_factor_id=jtlv.det_factor_id and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
jtlv.first_party_primary_reg_num=jpr.registration_number and
jrrl.tax_line_id=jtlv.tax_line_id and
jtlv.tax_type_id=jrav.entity_id and
jrrl.status='CONFIRMED' and
((jtlv.tax_rate_percentage is null or jtlv.tax_rate_percentage=0) or
(jtlv.tax_amt_before_exemption>0 and nvl(jtlv.rounded_tax_amt_fun_curr,0)=0))) tax_dtls
union all
-- 31d
select
'31d' section_code,
tax_dtls.registration_number gstin,
tax_dtls.party_name registered_person,
tax_dtls.operating_unit,
null pos,
null type,
tax_dtls.line_amt taxable_value,
tax_dtls.cgst,
tax_dtls.sgst,
tax_dtls.igst,
tax_dtls.cess_amount
from
(select
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
jtdf.det_factor_id,
jtdf.line_amt,
sum(decode(jrav.reporting_code,'IGST',jtlv.rounded_tax_amt_fun_curr)) igst,
sum(decode(jrav.reporting_code,'CGST',jtlv.rounded_tax_amt_fun_curr)) cgst,
sum(decode(jrav.reporting_code,'SGST',jtlv.rounded_tax_amt_fun_curr)) sgst,
sum(decode(jrav.reporting_code,'CESS',jtlv.rounded_tax_amt_fun_curr)) cess_amount
from
jai_party_reg jpr,
jai_tax_det_factors jtdf,
jai_tax_lines_v jtlv,
jai_reporting_associations_v jrav,
jai_rgm_recovery_lines jrrl
where
2=2 and
to_char(trunc(jtdf.tax_invoice_date),'MONYYYY')=:p_period and
jtdf.det_factor_id=jtlv.det_factor_id and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
jtlv.first_party_primary_reg_num=jpr.registration_number and
jrrl.tax_line_id=jtlv.tax_line_id and
jtlv.tax_type_id=jrav.entity_id and
jrrl.liability_amount<>0 and
jrrl.status='CONFIRMED' and
jtlv.self_assessed_flag='Y'
group by
jtdf.det_factor_id,
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
jtdf.line_amt) tax_dtls
union all
-- 31e
select
'31e' section_code,
tax_dtls.registration_number gstin,
tax_dtls.party_name registered_person,
tax_dtls.operating_unit,
null pos,
null type,
tax_dtls.line_amt taxable_value,
null cgst,
null sgst,
null igst,
null cess_amount
from
(select distinct
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
jtdf.det_factor_id,
jtdf.line_amt
from
jai_party_reg jpr,
jai_tax_det_factors jtdf,
jai_tax_lines_v jtlv,
jai_rgm_recovery_lines jrrl
where
2=2 and
to_char(trunc(jtdf.tax_invoice_date),'MONYYYY')=:p_period and
jtdf.det_factor_id=jtlv.det_factor_id and
jtlv.first_party_primary_reg_num=jpr.registration_number and
jrrl.tax_line_id=jtlv.tax_line_id and
jrrl.liability_amount<>0 and
jrrl.status='CONFIRMED' and
not exists (select null
from
jai_tax_types_v jttv,
jai_reporting_associations_v jrav
where
jttv.tax_type_id=jtlv.tax_type_id and
jttv.tax_type_id=jrav.entity_id and
jrav.reporting_code in ('IGST','SGST','CGST','CESS'))) tax_dtls
union all
-- 32a
select
'32a' section_code,
y.registration_number gstin,
y.party_name registered_person,
y.operating_unit,
y.pos,
null type,
y.taxable_value,
null cgst,
null sgst,
y.igst,
null cess_amount
from
(select
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
jtdf.bill_to_state pos,
sum(jtdf.line_amt) taxable_value,
sum(jtlv.rounded_tax_amt_fun_curr) igst
from
jai_party_reg jpr,
jai_tax_det_factors jtdf,
jai_tax_lines_v jtlv,
jai_reporting_associations_v jrav,
jai_rgm_recovery_lines jrrl
where
2=2 and
to_char(trunc(jtdf.tax_invoice_date),'MONYYYY')=:p_period and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
jrav.reporting_code='IGST' and
jrav.entity_id=jtlv.tax_type_id and
jtdf.det_factor_id=jtlv.det_factor_id and
jtlv.first_party_primary_reg_num=jpr.registration_number and
jtlv.third_party_primary_reg_num is null and
jrrl.tax_line_id=jtlv.tax_line_id and
jrrl.liability_amount<>0 and
jrrl.status='CONFIRMED' and
jtdf.ship_from_state<>jtdf.bill_to_state
group by
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
jtdf.bill_to_state) y
union all
-- 4a1
select
'4a1' section_code,
y.registration_number gstin,
y.party_name registered_person,
y.operating_unit,
null pos,
y.type,
null taxable_value,
y.cgst,
y.sgst,
y.igst,
y.cess_amount
from
(select
'IMPG' type,
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
sum(decode(jrav.reporting_code,'IGST',jtlv.rounded_tax_amt_fun_curr)) igst,
sum(decode(jrav.reporting_code,'CGST',jtlv.rounded_tax_amt_fun_curr)) cgst,
sum(decode(jrav.reporting_code,'SGST',jtlv.rounded_tax_amt_fun_curr)) sgst,
sum(decode(jrav.reporting_code,'CESS',jtlv.rounded_tax_amt_fun_curr)) cess_amount
from
jai_party_reg jpr,
jai_reporting_associations_v jrav,
jai_tax_lines_v jtlv,
jai_tax_det_factors jtdf,
jai_rgm_recovery_lines jrrl
where
2=2 and
to_char(trunc(jtdf.tax_invoice_date),'MONYYYY')=:p_period and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
sysdate between nvl(jrav.effective_from,sysdate) and nvl(jrav.effective_to,'31-DEC-4017') and
jtlv.tax_type_id=jrav.entity_id and
jtlv.first_party_primary_reg_num=jpr.registration_number and
exists (select null from jai_tax_lines jtl where jtdf.trx_id=jtl.trx_id and jtdf.trx_line_id=jtl.trx_line_id and jtl.applied_to_entity_code='BILL_OF_ENTRY') and
jtdf.det_factor_id=jtlv.det_factor_id and
jrrl.tax_line_id=jtlv.tax_line_id and
jtdf.hsn_code_id is not null
group by
jpr.registration_number,
jpr.party_name,
jpr.operating_unit) y
union all
-- 4a2
select
'4a2' section_code,
y.registration_number gstin,
y.party_name registered_person,
y.operating_unit,
null pos,
y.type,
null taxable_value,
y.cgst,
y.sgst,
y.igst,
y.cess_amount
from
(select
'IMPS' type,
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
sum(decode(jrav.reporting_code,'IGST',jtlv.rounded_tax_amt_fun_curr)) igst,
sum(decode(jrav.reporting_code,'CGST',jtlv.rounded_tax_amt_fun_curr)) cgst,
sum(decode(jrav.reporting_code,'SGST',jtlv.rounded_tax_amt_fun_curr)) sgst,
sum(decode(jrav.reporting_code,'CESS',jtlv.rounded_tax_amt_fun_curr)) cess_amount
from
jai_party_reg jpr,
jai_reporting_associations_v jrav,
jai_tax_lines_v jtlv,
jai_tax_det_factors jtdf,
jai_rgm_recovery_lines jrrl
where
2=2 and
to_char(trunc(jtdf.tax_invoice_date),'MONYYYY')=:p_period and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
sysdate between nvl(jrav.effective_from,sysdate) and nvl(jrav.effective_to,'31-DEC-4017') and
jtlv.tax_type_id=jrav.entity_id and
jtlv.first_party_primary_reg_num=jpr.registration_number and
jtdf.ship_from_country<>'IN' and
jtdf.det_factor_id=jtlv.det_factor_id and
jrrl.tax_line_id=jtlv.tax_line_id and
jtdf.sac_code_id is not null
group by
jpr.registration_number,
jpr.party_name,
jpr.operating_unit) y
union all
-- 4a3
select
'4a3' section_code,
y.registration_number gstin,
y.party_name registered_person,
y.operating_unit,
null pos,
y.type,
null taxable_value,
y.cgst,
y.sgst,
y.igst,
y.cess_amount
from
(select
'ISRC' type,
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
sum(decode(jrav.reporting_code,'IGST',jtlv.rounded_tax_amt_fun_curr)) igst,
sum(decode(jrav.reporting_code,'CGST',jtlv.rounded_tax_amt_fun_curr)) cgst,
sum(decode(jrav.reporting_code,'SGST',jtlv.rounded_tax_amt_fun_curr)) sgst,
sum(decode(jrav.reporting_code,'CESS',jtlv.rounded_tax_amt_fun_curr)) cess_amount
from
jai_party_reg jpr,
jai_reporting_associations_v jrav,
jai_tax_lines_v jtlv,
jai_tax_det_factors jtdf,
jai_rgm_recovery_lines jrrl
where
2=2 and
to_char(trunc(jtdf.tax_invoice_date),'MONYYYY')=:p_period and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
sysdate between nvl(jrav.effective_from,sysdate) and nvl(jrav.effective_to,'31-DEC-4017') and
jtlv.tax_type_id=jrav.entity_id and
jtlv.first_party_primary_reg_num=jpr.registration_number and
jtdf.det_factor_id=jtlv.det_factor_id and
jrrl.tax_line_id=jtlv.tax_line_id and
jtlv.self_assessed_flag='Y' and
jrrl.status='RECOVERED' and
jrrl.recovered_amount<>0
group by
jpr.registration_number,
jpr.party_name,
jpr.operating_unit) y
union all
-- 4a5
select
'4a5' section_code,
y.registration_number gstin,
y.party_name registered_person,
y.operating_unit,
null pos,
y.type,
null taxable_value,
y.cgst,
y.sgst,
y.igst,
y.cess_amount
from
(select
'OTH' type,
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
sum(decode(jrav.reporting_code,'IGST',jtlv.rounded_tax_amt_fun_curr)) igst,
sum(decode(jrav.reporting_code,'CGST',jtlv.rounded_tax_amt_fun_curr)) cgst,
sum(decode(jrav.reporting_code,'SGST',jtlv.rounded_tax_amt_fun_curr)) sgst,
sum(decode(jrav.reporting_code,'CESS',jtlv.rounded_tax_amt_fun_curr)) cess_amount
from
jai_party_reg jpr,
jai_reporting_associations_v jrav,
jai_tax_lines_v jtlv,
jai_tax_det_factors jtdf,
jai_rgm_recovery_lines jrrl
where
2=2 and
to_char(trunc(jtdf.tax_invoice_date),'MONYYYY')=:p_period and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
sysdate between nvl(jrav.effective_from,sysdate) and nvl(jrav.effective_to,'31-DEC-4017') and
jtlv.tax_type_id=jrav.entity_id and
jtlv.first_party_primary_reg_num=jpr.registration_number and
jtdf.det_factor_id=jtlv.det_factor_id and
jrrl.tax_line_id=jtlv.tax_line_id and
(nvl(jtlv.applied_to_entity_code,'X')<>'BILL_OF_ENTRY' and (jtdf.hsn_code_id is null or jtdf.sac_code_id is null)) and
(jtlv.self_assessed_flag<>'Y' and jrrl.status='RECOVERED' and jrrl.recovered_amount<>0)
group by
jpr.registration_number,
jpr.party_name,
jpr.operating_unit) y
union all
-- 4b1
select
'4b1' section_code,
y.registration_number gstin,
y.party_name registered_person,
y.operating_unit,
null pos,
y.type,
null taxable_value,
y.cgst,
y.sgst,
y.igst,
y.cess_amount
from
(select
'RUL' type,
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
sum(decode(jrav.reporting_code,'IGST',jtlv.rounded_tax_amt_fun_curr)) igst,
sum(decode(jrav.reporting_code,'CGST',jtlv.rounded_tax_amt_fun_curr)) cgst,
sum(decode(jrav.reporting_code,'SGST',jtlv.rounded_tax_amt_fun_curr)) sgst,
sum(decode(jrav.reporting_code,'CESS',jtlv.rounded_tax_amt_fun_curr)) cess_amount
from
jai_party_reg jpr,
jai_reporting_associations_v jrav,
jai_tax_lines_v jtlv,
jai_tax_det_factors jtdf,
jai_rgm_recovery_lines jrrl
where
2=2 and
to_char(trunc(jtdf.tax_invoice_date),'MONYYYY')=:p_period and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
sysdate between nvl(jrav.effective_from,sysdate) and nvl(jrav.effective_to,'31-DEC-4017') and
jtlv.tax_type_id=jrav.entity_id and
jtlv.first_party_primary_reg_num=jpr.registration_number and
jtdf.det_factor_id=jtlv.det_factor_id and
jrrl.tax_line_id=jtlv.tax_line_id and
jrrl.status='REVERSED'
group by
jpr.registration_number,
jpr.party_name,
jpr.operating_unit) y
union all
-- 4d1
select
'4d1' section_code,
y.registration_number gstin,
y.party_name registered_person,
y.operating_unit,
null pos,
y.type,
null taxable_value,
y.cgst,
y.sgst,
y.igst,
y.cess_amount
from
(select
'RUL' type,
jpr.registration_number,
jpr.party_name,
jpr.operating_unit,
sum((select jtlv2.rounded_tax_amt_fun_curr
from jai_tax_lines_v jtlv2, jai_reporting_associations_v jrav2
where
jtlv2.tax_line_id=jtlv.tax_line_id and jrav.entity_id=jrav2.entity_id and jrav2.reporting_code='IGST')) igst,
sum((select jtlv2.rounded_tax_amt_fun_curr
from jai_tax_lines_v jtlv2, jai_reporting_associations_v jrav2
where
jtlv2.tax_line_id=jtlv.tax_line_id and jrav.entity_id=jrav2.entity_id and jrav2.reporting_code='CGST')) cgst,
sum((select jtlv2.rounded_tax_amt_fun_curr
from jai_tax_lines_v jtlv2, jai_reporting_associations_v jrav2
where
jtlv2.tax_line_id=jtlv.tax_line_id and jrav.entity_id=jrav2.entity_id and jrav2.reporting_code='SGST')) sgst,
sum((select jtlv2.rounded_tax_amt_fun_curr
from jai_tax_lines_v jtlv2, jai_reporting_associations_v jrav2
where
jtlv2.tax_line_id=jtlv.tax_line_id and jrav.entity_id=jrav2.entity_id and jrav2.reporting_code='CESS')) cess_amount
from
jai_party_reg jpr,
jai_reporting_associations_v jrav,
jai_tax_lines_v jtlv,
jai_tax_det_factors jtdf,
jai_rgm_recovery_lines jrrl
where
2=2 and
to_char(trunc(jtdf.tax_invoice_date),'MONYYYY')=:p_period and
jrav.entity_code='TAX_TYPE' and
jrav.reporting_type_code='TAX_TYPES_CLASSIFICATION' and
sysdate between nvl(jrav.effective_from,sysdate) and nvl(jrav.effective_to,'31-DEC-4017') and
jtlv.tax_type_id=jrav.entity_id and
jtlv.first_party_primary_reg_num=jpr.registration_number and
jtdf.det_factor_id=jtlv.det_factor_id and
jrrl.tax_line_id=jtlv.tax_line_id and
jrrl.status='INELIGIBLE'
group by
jpr.registration_number,
jpr.party_name,
jpr.operating_unit) y
union all
-- placeholder sections
select
y.section_code,
jpr.registration_number gstin,
jpr.party_name registered_person,
jpr.operating_unit,
null pos,
y.type,
null taxable_value,
null cgst,
null sgst,
null igst,
null cess_amount
from
jai_party_reg jpr,
(select '32b' section_code, null type from dual union all
select '32c', null from dual union all
select '4a4', 'ISD' from dual union all
select '4b2', 'OTH' from dual union all
select '4c', null from dual union all
select '4d2', 'OTH' from dual) y