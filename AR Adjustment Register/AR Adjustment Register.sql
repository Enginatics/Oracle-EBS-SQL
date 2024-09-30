/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Adjustment Register
-- Description: Application: Receivables
Source: Adjustment Register
Short Name: ARRXARPB

The report has now been enhanced to allow multiple accessible Ledgers or Operating Units to be selected in the Reporting Context parameter. Additionally, the Reporting Context parameter has been made optional. Leaving it null will allow the report to be run across all accessible Ledgers or Operating Units.
-- Excel Examle Output: https://www.enginatics.com/example/ar-adjustment-register/
-- Library Link: https://www.enginatics.com/reports/ar-adjustment-register/
-- Run Report: https://demo.enginatics.com/

select
  rx.organization_name ledger,
  rx.functional_currency_code functional_currency,
  rx.debit_balancing "&bal_segment_p",
  rx.debit_balancing_desc "&bal_segment_d",
  rx.postable,
  rx.adj_currency_code currency,
  rx.adj_class adjustment_class,
  rx.trx_number invoice_number,
  rx.adj_name "Type",
  rx.customer_name,
  rx.customer_number,
  rx.trx_date invoice_date,
  rx.gl_date,
  rx.due_date,
  rx.adj_number adjustment_number,
  rx.adj_type_meaning adjustment_type,
  rx.adj_amount entered_adjustment_amount,
  rx.acctd_adj_amount functional_adjustment_amount,
  rx.d_or_i "D/I",
  rx.doc_sequence_name,
  rx.doc_sequence_value
from
  ar_adjustments_rep_itf rx
where
    1=1
and rx.request_id = fnd_global.conc_request_id 
order by
  rx.organization_name,
  rx.functional_currency_code,
  rx.debit_balancing,
  rx.postable,
  rx.adj_currency_code,
  rx.adj_class,
  rx.customer_name