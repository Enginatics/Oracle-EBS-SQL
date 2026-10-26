/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC AP Accrual Reconciliation Load Request
-- Description: Report to show when the A/P Accrual Reconciliation Load program was run and by whom, including the Ledger, Operating Unit, Build Id, Request Id, Creation Date and Last Updated By.
-- Parameters:
-- ===========
-- Beginning Creation Date: enter the starting creation date to report, based on the operating unit for your session's inventory organization (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2019 - 2025 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 31 Oct 2019 Douglas Volz Initial Coding
-- -- | 1.1 28 Jan 2025 Douglas Volz Added creation date parameter
-- -- | 1.2 15 Feb 2025 Douglas Volz Added Operating Unit and Ledger Security
-- -- | Profile Controls and parameters.
-- -- | 1.3 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-ap-accrual-reconciliation-load-request/
-- Library Link: https://www.enginatics.com/reports/cac-ap-accrual-reconciliation-load-request/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv.name operating_unit,
crb.build_id,
crb.to_date run_to_date,
crb.creation_date,
crb.last_update_date,
xxen_util.user_name(crb.created_by) created_by,
xxen_util.user_name(crb.last_updated_by) last_updated_by,
crb.request_id
from
cst_reconciliation_build crb,
hr_all_organization_units_vl haouv,
hr_organization_information hoi,
gl_ledgers gl
where
1=1 and
crb.operating_unit_id=haouv.organization_id and
haouv.organization_id=hoi.organization_id and
hoi.org_information_context='Operating Unit Information' and
to_number(hoi.org_information3)=gl.ledger_id
order by
ledger,
operating_unit,
crb.build_id
