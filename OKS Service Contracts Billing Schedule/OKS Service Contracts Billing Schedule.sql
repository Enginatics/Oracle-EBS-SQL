/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OKS Service Contracts Billing Schedule
-- Description: Service Contracts billing schedule with invoicing and accounting rules, and detailed to be billed period dates and amounts from the stream level elements table oks_level_elements.

Column date_competed is used to identify open or already billed records and date_to_interface is used by the service contracts billing program to identify the records to be billed at any given date.
For advance billing, date_to_interface is set to the beginning of the billing period and for arrears, it is set to the end. When creating new billing schedule record for past periods (that should have been billed already), date_to_interface is set to the current date.

An overview of oracle service contracts and other line types can be found here: <a href="https://www.enginatics.com/reports/okc-contract-lines-summary/" rel="nofollow" target="_blank">https://www.enginatics.com/reports/okc-contract-lines-summary/</a>
-- Excel Examle Output: https://www.enginatics.com/example/oks-service-contracts-billing-schedule/
-- Library Link: https://www.enginatics.com/reports/oks-service-contracts-billing-schedule/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ocv.meaning class,
osclv.meaning category,
okhab.contract_number,
okhab.contract_number_modifier modifier,
osv0.meaning contract_status,
osv1.meaning line_status,
osv2.meaning subline_status,
oklb1.line_number||nvl2(oklb2.line_number,'.'||oklb2.line_number,null) line_number,
xxen_util.meaning(nvl(olsb2.lty_code,olsb1.lty_code),'OKC_LINE_TYPE',0)||' '||xxen_util.meaning(okslb1.usage_type,'OKS_USAGE_TYPES',0) contract_line_type,
okslb2.base_reading,
okslb1.usage_period,
rr.name invoice_rule,
rr2.name accounting_rule,
oslb.sequence_no,
oslb.level_periods,
oslb.uom_per_period,
oslb.uom_code,
oslb.start_date,
oslb.end_date,
ole.sequence_number,
ole.date_start,
ole.date_end,
ole.date_completed,
ole.amount,
ole.date_to_interface,
okhab.scs_code,
okslb1.usage_type,
olsb1.lty_code
from
hr_all_organization_units_vl haouv,
okc_k_headers_all_b okhab,
okc_subclasses_v osclv,
okc_classes_v ocv,
okc_statuses_v osv0,
okc_statuses_v osv1,
okc_statuses_v osv2,
okc_k_lines_b oklb1,
okc_k_lines_b oklb2,
oks_k_lines_b okslb1,
oks_k_lines_b okslb2,
okc_line_styles_b olsb1,
okc_line_styles_b olsb2,
oks_stream_levels_b oslb,
oks_level_elements ole,
ra_rules rr,
ra_rules rr2
where
1=1 and
haouv.organization_id=okhab.authoring_org_id and
okhab.scs_code=osclv.code(+) and
osclv.cls_code=ocv.code(+) and
okhab.sts_code=osv0.code(+) and
oklb1.sts_code=osv1.code(+) and
oklb2.sts_code=osv2.code(+) and
okhab.id=oklb1.chr_id and
oklb1.id=oklb2.cle_id(+) and
oklb1.id=okslb1.cle_id and
oklb2.id=okslb2.cle_id(+) and
oklb1.lse_id=olsb1.id and
oklb2.lse_id=olsb2.id(+) and
oklb1.id=oslb.cle_id and
oslb.id=ole.rul_id and
oklb1.inv_rule_id=rr.rule_id(+) and
okslb1.acct_rule_id=rr2.rule_id(+) and
okhab.authoring_org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual)
order by
haouv.name,
okhab.scs_code,
okhab.contract_number,
okhab.contract_number_modifier,
line_number,
oslb.start_date desc,
ole.sequence_number desc