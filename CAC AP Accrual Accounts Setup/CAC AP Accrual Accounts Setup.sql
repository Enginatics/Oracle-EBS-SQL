/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC AP Accrual Accounts Setup
-- Description: Report to show the valid A/P Accrual Accounts which have been set up in the Select Accrual Accounts Form. Showing the Ledger, Operating Unit, Accrual Accounts, Creation Date, Created By and Last Updated By. The A/P Accrual Load Program uses these accounts to find the Payables, Receiving and Inventory accounting accrual entries for the A/P Accrual Load results.
-- Parameters:
-- ===========
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2008 - 2025 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 10 Nov 2008 Douglas Volz Initial Coding
-- -- | 1.1 08 Nov 2011 Douglas Volz Modified for Release 12
-- -- | 1.2 15 Feb 2025 Douglas Volz Added Ledger and Operating Unit parameters,
-- -- | and added G/L and Operating Unit Security Controls.
-- -- | 1.3 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-ap-accrual-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-ap-accrual-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv.name operating_unit,
&segment_columns
caa.creation_date,
caa.last_update_date,
xxen_util.user_name(caa.created_by) created_by,
xxen_util.user_name(caa.last_updated_by) last_updated_by
from
cst_accrual_accounts caa,
hr_all_organization_units_vl haouv,
hr_organization_information hoi,
gl_ledgers gl,
gl_code_combinations_kfv gcck
where
1=1 and
caa.operating_unit_id=haouv.organization_id and
haouv.organization_id=hoi.organization_id and
hoi.org_information_context='Operating Unit Information' and
to_number(hoi.org_information3)=gl.ledger_id and
caa.accrual_account_id=gcck.code_combination_id
order by
ledger,
operating_unit,
gcck.concatenated_segments,
caa.creation_date,
caa.last_update_date
