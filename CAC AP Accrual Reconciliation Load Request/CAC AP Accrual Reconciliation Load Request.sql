/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC AP Accrual Reconciliation Load Request
-- Description: Report to show when the A/P Accrual Reconciliation Load program was run and by whom, including the Ledger, Operating Unit, Build Id, Request Id, Creation Date and Last Updated By.

Parameters:
===========
Beginning Creation Date:  enter the starting creation date to report, based on the operating unit for your session's inventory organization (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2019 - 2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     31 Oct 2019 Douglas Volz   Initial Coding
-- |  1.1     28 Jan 2025 Douglas Volz   Added creation date parameter
-- |  1.2     15 Feb 2025 Douglas Volz   Added Operating Unit and Ledger Security
-- |                                     Profile Controls and parameters.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-ap-accrual-reconciliation-load-request/
-- Library Link: https://www.enginatics.com/reports/cac-ap-accrual-reconciliation-load-request/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou.name Operating_Unit,
        crb.build_id Build_Id,
        crb.to_date Run_To_Date,
        crb.creation_date Creation_Date,
        crb.last_update_date Last_Update_Date,
        fu_created.user_name Created_By,
        fu_last_updated.user_name Last_Updated_By,
        crb.request_id Request_Id
from    cst_reconciliation_build crb,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- operating unit
        -- Revision for version 1.2
        gl_ledgers gl,
        fnd_user fu_created,
        fnd_user fu_last_updated
where   hoi.org_information_context = 'Operating Unit Information'
and     hoi.organization_id         = haou.organization_id -- this gets the operating unit id
and     crb.operating_unit_id       = haou.organization_id
-- Revision for version 1.2
and     gl.ledger_id                = to_number(hoi.org_information3) -- this joins OU to GL
and     fu_created.user_id          = crb.created_by
and     fu_last_updated.user_id     = crb.last_updated_by
-- Revision for version 1.2
-- Revision for version 1.2, Operating Unit and Ledger Controls and Parameters
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
and     1=1                         -- p_beg_creation_date, p_operating_unit, p_ledger
order by 1,2,3