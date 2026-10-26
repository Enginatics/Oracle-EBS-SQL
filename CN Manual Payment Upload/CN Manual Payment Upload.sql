/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CN Manual Payment Upload
-- Description: Creates, updates and deletes Incentive Compensation manual payments - the Excel equivalent of the Manual Payments tab of the Paysheet Detail page (Payments, Payment Batches).
-- A manual payment adjusts a resource's paysheet in an unpaid payment batch for one plan element. The paysheet must already exist and must not be locked or submitted for approval. A recoverable payment is recovered from future earnings.
-- Each change writes the same system note on the paysheet as the Paysheet Detail page. Text entered in Reason is added as a user note on the paysheet, once per paysheet and text.
-- Existing manual payments are downloaded with Upload Mode Create, Update. Only the Payment Amount and Recoverable flag of an existing manual payment can be changed; to move it to another plan element, delete it and create a new one.
-- Excel Example Output: https://www.enginatics.com/example/cn-manual-payment-upload/
-- Library Link: https://www.enginatics.com/reports/cn-manual-payment-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
to_char(null) modified_columns_,
haouv.name operating_unit,
cpa.name payment_batch,
cpsa.period_name pay_period,
jrrev.resource_name,
jrs.salesrep_number employee_number,
cqa.name plan_element,
cn_api.get_pay_element_name(cpta.pay_element_type_id) pay_element,
xxen_util.yes(cpta.recoverable_flag) recoverable,
cpta.payment_amount,
to_char(null) reason,
to_char(null) delete_payment,
cpta.payment_transaction_id,
to_char(null) upload_row
from
cn_payment_transactions_all cpta,
cn_payruns_all cpa,
cn_period_statuses_all cpsa,
hr_all_organization_units_vl haouv,
jtf_rs_salesreps jrs,
jtf_rs_resource_extns_vl jrrev,
cn_quotas_all cqa
where
1=1 and
cpta.incentive_type_code='MANUAL_PAY_ADJ' and
cpta.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
cpta.payrun_id=cpa.payrun_id and
cpa.pay_period_id=cpsa.period_id and
cpa.org_id=cpsa.org_id and
cpa.org_id=haouv.organization_id and
cpta.credited_salesrep_id=jrs.salesrep_id and
cpta.org_id=jrs.org_id and
jrs.resource_id=jrrev.resource_id and
cpta.quota_id=cqa.quota_id(+)
