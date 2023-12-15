/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR to GL Reconciliation
-- Description: Imported from Concurrent Program
Application: Receivables
Source: AR to GL Reconciliation Report
Short Name: ARGLRECR
DB package:
-- Excel Examle Output: https://www.enginatics.com/example/ar-to-gl-reconciliation/
-- Library Link: https://www.enginatics.com/reports/ar-to-gl-reconciliation/
-- Run Report: https://demo.enginatics.com/

select
 :p_period_name period,
 company,
 account_type,
 account,
 account_desc,
 --
 nvl(opening_balance_dr,0) begin_gl_balance_dr,
 nvl(opening_balance_cr,0) begin_gl_balance_cr,
 --
 nvl(subledger_not_ar_dr,0) subledgers_not_ar_dr,
 nvl(subledger_not_ar_cr,0) subledgers_not_ar_cr,
 --
 nvl(subledger_manual_dr,0) gl_source_manual_dr,
 nvl(subledger_manual_cr,0) gl_source_manual_cr,
 --
 nvl(gl_unposted_dr,0) + nvl(gl_interface_dr,0) unposted_in_gl_dr,
 nvl(gl_unposted_cr,0) + nvl(gl_interface_cr,0) unposted_in_gl_cr,
 --
 nvl(opening_balance_dr,0) +
 nvl(subledger_not_ar_dr,0) +
 nvl(subledger_manual_dr,0) +
 nvl(gl_unposted_dr,0) +
 nvl(gl_interface_dr,0) calculated_balance_excl_ar_dr,
 nvl(opening_balance_cr,0) +
 nvl(subledger_not_ar_cr,0) +
 nvl(subledger_manual_cr,0) +
 nvl(gl_unposted_cr,0) +
 nvl(gl_interface_cr,0) calculated_balance_excl_ar_cr,
 --
 nvl(opening_balance_dr,0)+nvl(period_activity_dr,0) actual_gl_balance_dr,
 nvl(opening_balance_cr,0)+nvl(period_activity_cr,0) actual_gl_balance_cr,
 --
 (nvl(opening_balance_dr,0)+nvl(period_activity_dr,0)) -
 (nvl(opening_balance_dr,0) +
  nvl(subledger_not_ar_dr,0) +
  nvl(subledger_manual_dr,0) +
  nvl(gl_unposted_dr,0) +
  nvl(gl_interface_dr,0)
 ) gl_actual_less_calculated_dr,
 (nvl(opening_balance_cr,0)+nvl(period_activity_cr,0)) -
 (nvl(opening_balance_cr,0) +
  nvl(subledger_not_ar_cr,0) +
  nvl(subledger_manual_cr,0) +
  nvl(gl_unposted_cr,0) +
  nvl(gl_interface_cr,0)
 ) gl_actual_less_calculated_cr,
 --
 nvl(subledger_rec_dr,0) gl_source_ar_dr,
 nvl(subledger_rec_cr,0) gl_source_ar_cr,
 --
 nvl(receivables_dr,0) receivables_posted_dr,
 nvl(receivables_cr,0) receivables_posted_cr,
 --
 nvl(receivables_dr,0) - nvl(subledger_rec_dr,0) differences_ar_dr,
 nvl(receivables_cr,0) - nvl(subledger_rec_cr,0) differences_ar_cr
from
 ar_gl_recon_gt
where
 'N' = arp_recon_rep.get_out_of_balance_only() or
 nvl(receivables_dr,0)- nvl(subledger_rec_dr,0) <> 0 or
 nvl(receivables_cr,0)- nvl(subledger_rec_cr,0) <> 0
order by
 decode(account_type_code,'A',1,'L',2,'R',3,'E',4),
 company,
 account