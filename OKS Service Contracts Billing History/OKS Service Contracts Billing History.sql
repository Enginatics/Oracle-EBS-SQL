/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OKS Service Contracts Billing History
-- Description: Service Contracts billing history with invoicing and accounting rules, bill action, billed period dates, amounts and counter reading details for usage billing.
When running service contracts billing, there is always a full set of records created in the following billing history tables: 

oks_bill_cont_lines obcl
oks_bill_sub_lines obsl
oks_bill_sub_line_dtls obsld
oks_bill_transactions obt
oks_bill_txn_lines obtl

This set of records is complete down to subline level obsl/obsld, regardless if the billed contract line type has a subline or not.
For subscription lines (lse_id=46, lty_code='SUBSCRIPTION') without a subline, for example, both obcl and obsl point their cle_id to the same line in okc_k_lines_b instead of different line and subline.

Unique identifier for the billing entry is obtl.bill_instance_number, which links to receivables line rctla.interface_line_attribute3.
When driving queries from the OKS side, make sure to include a to_char() conversion for the numeric obtl.bill_instance_number, to enable index use on character type rctla.interface_line_attribute3.

The OKS billing history does not have a link to the originating billing schedule record in oks_level_elements (see <a href="https://www.enginatics.com/reports/oks-service-contracts-billing-schedule/" rel="nofollow" target="_blank">https://www.enginatics.com/reports/oks-service-contracts-billing-schedule/</a>)

An overview of oracle service contracts and other line types can be found here: <a href="https://www.enginatics.com/reports/okc-contract-lines-summary/" rel="nofollow" target="_blank">https://www.enginatics.com/reports/okc-contract-lines-summary/</a>

oks_billing_history_v
-- Excel Examle Output: https://www.enginatics.com/example/oks-service-contracts-billing-history/
-- Library Link: https://www.enginatics.com/reports/oks-service-contracts-billing-history/
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
okslb2.base_reading subline_base_reading,
okslb1.usage_period,
rr.name invoice_rule,
rr2.name accounting_rule,
xxen_util.meaning(obcl.bill_action,'OKS_BILL_ACTIONS',0) bill_action,
obsl.date_billed_from,
obsl.date_billed_to,
obsl.amount,
obsl.manual_credit,
obcl.currency_code,
obsl.average,
obsld.unit_of_measure,
xxen_util.meaning(decode(obsld.amcv_yn,'Y','Y'),'YES_NO',0) amcv_yn,
&counter_cols
obsld.start_reading,
obsld.end_reading,
obsld.fixed,
obsld.actual,
obsld.default_default,
obsld.adjustment_level,
obsld.adjustment_minimum,
obsld.base_reading,
obsld.estimated_quantity,
obsld.result,
obcl.date_next_invoice,
obsl.date_to_interface,
rcta.trx_number,
rcta.trx_date,
xxen_util.meaning(rctta.type,'INV/CM/ADJ',222)||case when rctta.type='CM' and obcl.bill_action='TR' then ' termination' end trx_class,
rctta.name trx_type,
rctla.extended_amount trx_line_amount,
okhab.scs_code,
okslb1.usage_type,
olsb1.lty_code,
obcl.bill_action bill_action_code
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
ra_rules rr,
ra_rules rr2,
oks_bill_cont_lines obcl,
oks_bill_sub_lines obsl,
oks_bill_sub_line_dtls obsld,
&counter_tbls
oks_bill_transactions obt,
oks_bill_txn_lines obtl,
ra_customer_trx_lines_all rctla,
ra_customer_trx_all rcta,
ra_cust_trx_types_all rctta
where
1=1 and
okhab.authoring_org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
okhab.scs_code in (select osb.code from okc_subclasses_b osb where osb.cls_code='SERVICE') and
haouv.organization_id= okhab.authoring_org_id and
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
oklb1.inv_rule_id=rr.rule_id(+) and
okslb1.acct_rule_id=rr2.rule_id(+) and
nvl(oklb2.id,oklb1.id)=obsl.cle_id and
obsl.bcl_id=obcl.id(+) and
obsl.id=obsld.bsl_id(+) and
&counter_joins
obsl.id=obtl.bsl_id(+) and
obtl.btn_id=obt.id(+) and
to_char(obtl.bill_instance_number)=rctla.interface_line_attribute3(+) and
rctla.interface_line_context(+)='OKS CONTRACTS' and
rctla.customer_trx_id=rcta.customer_trx_id(+) and
rcta.cust_trx_type_id=rctta.cust_trx_type_id(+) and
rcta.org_id=rctta.org_id(+)
order by
haouv.name,
okhab.scs_code,
okhab.contract_number,
okhab.contract_number_modifier,
line_number,
to_number(oklb1.line_number),
to_number(oklb2.line_number),
obsl.date_billed_from desc,
obcl.bill_action desc