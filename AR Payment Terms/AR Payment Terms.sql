/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Payment Terms
-- Description: Master data report showing the payment terms codes with their respective profile options.
-- Excel Examle Output: https://www.enginatics.com/example/ar-payment-terms/
-- Library Link: https://www.enginatics.com/reports/ar-payment-terms/
-- Run Report: https://demo.enginatics.com/

select
rtt.name term_name,
rtt.description,
decode(rtb.partial_discount_flag,'Y','Yes') partial_payment_discount,
decode(rtb.prepayment_flag,'Y','Yes') prepayment,
decode(rtb.credit_check_flag,'Y','Yes') credit_check,
&billing_cycle_column
rtb.base_amount,
xxen_util.meaning(decode(rtb.calc_discount_on_lines_flag,'Y','L','N','I',rtb.calc_discount_on_lines_flag),'DISCOUNT_BASIS',222) discount_basis,
rtb.printing_lead_days,
xxen_util.meaning(rtb.first_installment_code,'INSTALLMENT_OPTION',222) installment_options,
rtl.relative_amount,
rtl.due_days,
rtl.due_day_of_month day_of_month,
rtl.due_months_forward months_ahead,
(select distinct listagg(rtld.discount_percent||'%/'||nvl(rtld.discount_days,nvl(rtld.discount_day_of_month,rtld.discount_months_forward)),', ') within group (order by rtld.discount_days) over (partition by rtld.term_id) from ra_terms_lines_discounts rtld where rtb.term_id=rtld.term_id) cash_discount,
xxen_util.user_name(rtb.created_by) created_by,
xxen_util.client_time(rtb.creation_date) creation_date,
xxen_util.user_name(rtb.last_updated_by) last_updated_by,
xxen_util.client_time(rtb.last_update_date) last_update_date
from
ra_terms_b rtb,
ra_terms_tl rtt,
&billing_cycle_table
ra_terms_lines rtl
where
1=1 and
rtb.term_id=rtt.term_id and
rtt.language=userenv('lang') and
&billing_cycle_joins
rtb.term_id=rtl.term_id
order by
rtt.name,
rtl.sequence_num