/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Department Overhead Setup
-- Description: Report to show the departments and the overhead codes assigned to each department.

/* +=============================================================================+
-- |  Copyright 2016 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_dept_ovhd_setup.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_cost_type        -- Enter Pending or Frozen or AvgRates for the Cost Type.  
-- |                        A required value.
-- |  Description:
-- |  Report to show the departments and the overhead codes assigned to each department
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     18 Oct 2016 Douglas Volz   Initial Coding
-- |  1.1     07 Nov 2016 Douglas Volz   Added Department / Resource relationships
-- |  1.2     17 Jul 2018 Douglas Volz   Made Cost Type parameter optional
-- |  1.3     12 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters
-- |                                     and change to gl.short_name.  Added Last
-- |                                     rate update column to report.
-- |  1.4     27 Apr 2020 Douglas Volz   Changed to multi-language views for the 
-- |                                     inventory orgs and operating units.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-department-overhead-setup/
-- Library Link: https://www.enginatics.com/reports/cac-department-overhead-setup/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou.name Operating_Unit,
 mp.organization_code Org_Code,
 cct.cost_type Cost_Type, 
 bd.department_code Department_Code,
 bro.resource_code Overhead,
 bro.unit_of_measure Overhead_UOM,
 cdo.rate_or_amount Overhead_Rate,
 ml_basis.meaning Overhead_Basis,
 brr.resource_code Resource_Code,
 brr.unit_of_measure Resource_UOM,
 crc.resource_rate Resource_Rate,
 &segment_columns
 cro.last_update_date Last_Rate_Update_Date
from cst_department_overheads cdo,
 cst_resource_overheads cro,
 bom_departments bd,
 -- Revision for version 1.1
 bom_department_resources bdr,
 cst_resource_costs crc,
 bom_resources bro,
 bom_resources brr,
 cst_cost_types cct,
 mtl_parameters mp,
 mfg_lookups ml_basis,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where brr.resource_id             = cro.resource_id
and cct.cost_type_id            = cro.cost_type_id
and cro.overhead_id             = cdo.overhead_id
and bro.resource_id             = cdo.overhead_id
and cct.cost_type_id            = cdo.cost_type_id
and cdo.basis_type in (3, 4)
and cdo.department_id           = bd.department_id
-- Revision for version 1.1
and bd.department_id            = bdr.department_id
and bdr.resource_id             = brr.resource_id 
-- End revision for version 1.1
and brr.resource_id             = crc.resource_id
and cct.cost_type_id            = crc.cost_type_id
and 2=2                         -- p_cost_type     
and mp.organization_id          = brr.organization_id
and brr.organization_id         = bro.organization_id
and ml_basis.lookup_code        = cdo.basis_type
and ml_basis.lookup_type        = 'CST_BASIS_SHORT'
and bro.absorption_account      = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id -- this gets the organization name
and haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                         -- p_ledger, p_operating_unit, p_org_code
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- Order by Ledger, Operating_Unit, Org_Code and Cost_Type
order by 
 nvl(gl.short_name, gl.name), -- Ledger
 haou.name, -- Operating_Unit
 mp.organization_code, -- Org_Code
 cct.cost_type -- Cost_Type