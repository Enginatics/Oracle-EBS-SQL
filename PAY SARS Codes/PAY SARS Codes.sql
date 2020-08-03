/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY SARS Codes
-- Excel Examle Output: https://www.enginatics.com/example/pay-sars-codes/
-- Library Link: https://www.enginatics.com/reports/pay-sars-codes/
-- Run Report: https://demo.enginatics.com/

select distinct b.element_name, e. full_balance_name, e.code
from
pay_balance_feeds_f d,
pay_balance_types c,
pay_input_values_f a,
pay_element_types_f b,
pay_za_irp5_bal_codes e
where
a. element_type_id = b.element_type_id
and d.balance_type_id = d. balance_type_id
and a.input_value_id = d.input_value_id
and e.balance_type_id = d.balance_type_id