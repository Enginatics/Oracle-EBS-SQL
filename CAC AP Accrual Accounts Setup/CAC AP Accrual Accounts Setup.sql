/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC AP Accrual Accounts Setup
-- Description: Report to show the valid A/P Accrual Accounts which have been set up in the Select Accrual Accounts Form.  Showing the Ledger, Operating Unit, Accrual Accounts, Creation Date, Created By and Last Updated By.  The A/P Accrual Load Program uses these accounts to find the Payables, Receiving and Inventory accounting accrual entries for the A/P Accrual Load results.

Parameters:
===========
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2008 - 2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     10 Nov 2008 Douglas Volz   Initial Coding
-- |  1.1     08 Nov 2011 Douglas Volz   Modified for Release 12
-- |  1.2     15 Feb 2025 Douglas Volz   Added Ledger and Operating Unit parameters,
-- |					                 and added G/L and Operating Unit Security Controls.
-- +=============================================================================+*/


-- Excel Examle Output: https://www.enginatics.com/example/cac-ap-accrual-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-ap-accrual-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou.name Operating_Unit,
        &segment_columns
        cap.creation_date Creation_Date,
        cap.last_update_date Last_Update_Date,
        fu_created.user_name Created_By,
        fu_last_updated.user_name Last_Updated_By
from    cst_accrual_accounts cap,
        gl_code_combinations gcc,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- operating unit
        gl_ledgers gl,
        fnd_user fu_created,
        fnd_user fu_last_updated
where   hoi.org_information_context = 'Operating Unit Information'
and     hoi.organization_id         = haou.organization_id -- this gets the operating unit id
and     cap.operating_unit_id       = haou.organization_id
and     cap.accrual_account_id      = gcc.code_combination_id
and     gl.ledger_id                = to_number(hoi.org_information3) -- this joins OU to GL
and     fu_created.user_id          = cap.created_by
and     fu_last_updated.user_id     = cap.last_updated_by
-- Revision for version 1.2, Operating Unit and Ledger Controls and Parameters
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
and     1=1                         -- p_operating_unit, p_ledger
-- Order by Ledger, Operating Unit and Accounts
order by 1,2,3,4,5,6,7