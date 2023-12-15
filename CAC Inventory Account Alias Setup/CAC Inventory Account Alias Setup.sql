/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Account Alias Setup
-- Description: Report to show accounts assigned for inventory account aliases

/* +=============================================================================+
-- |  Copyright 2011 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_acct_alias_setup_rept.sql
-- |
-- |  Parameters:
-- |  p_ledger		-- Ledger you wish to report, enter a null for all
-- |                       ledgers. (optional)
-- | 
-- |  Description:
-- |  Report to show accounts used for account aliases
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     03 Feb 2011 Douglas Volz   Initial Coding
-- |  1.1     28 Mar 2011 Douglas Volz   Added Ledger parameter, effective date
-- |					 and disable date
-- |  1.2     07 Oct 2015 Douglas Volz   Removed prior client's org restrictions.
-- |  1.3     27 Apr 2020 Douglas Volz   Changed to multi-language views for the 
-- |                                     inventory orgs and operating units.
-- Excel Examle Output: https://www.enginatics.com/example/cac-inventory-account-alias-setup/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-account-alias-setup/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 mgd.segment1 Account_Alias,
 mgd.description Description,
 &segment_columns
 mgd.effective_date Effective_Date,
 mgd.disable_date Disable_Date,
 mgd.disposition_id Alias_Id
from mtl_generic_dispositions mgd,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mgd.distribution_account    = gcc.code_combination_id
and mgd.organization_id         = mp.organization_id
-- ===========================================
-- Organization joins for the HR org model
-- ===========================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id -- this gets the organization name
and haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.1
-- Avoid selecting disabled inventory organizations
and sysdate                    < nvl(haou.date_to, sysdate + 1)
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1 -- p_ledger, p_operating_unit, p_org_code
-- End revision for version 1.1
order by
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, -- Operating_Unit
 mp.organization_code, -- Org_Code
 haou.name, -- Organization_Name
 mgd.segment1 -- Account_Alias