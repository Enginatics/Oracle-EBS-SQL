/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Department Overhead Rates
-- Description: Report to show departmental overheads and rates

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
-- |  Program Name:  xxx_dept_ovhd_rates.sql
-- |
-- |  Parameters:
-- |  p_ledger	    -- Ledger you wish to report, enter a null or blank for all
-- |                   ledgers.
-- |  p_cost_type   -- Cost Type you wish to report, enter a null or blank for all
-- |                   cost types.
-- | 
-- |  Description:
-- |  Report to show departmental overheads and rates.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     17 Sep 2013 Douglas Volz   Initial Coding
-- |  1.1     18 Oct 2016 Douglas Volz   Added organization information
-- |  1.2      6 Sep 2019 Douglas Volz   Added last update date
-- |  1.3     27 Jan 2020 Douglas Volz   Added Operating Unit parameter
-- |  1.4     26 Apr 2020 Douglas Volz   Changed to multi-language views for 
-- |                                     operating units.+=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-department-overhead-rates/
-- Library Link: https://www.enginatics.com/reports/cac-department-overhead-rates/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou.name Operating_Unit,
 mp.organization_code Org_Code,
 cct.cost_type Cost_Type,
 bd.department_code Department,
 br.resource_code Overhead,
 ml_basis.meaning Overhead_Basis,
 cdo.rate_or_amount Overhead_Rate,
 &segment_columns
 cdo.last_update_date Last_Update_Date
from bom_departments bd,
 cst_department_overheads cdo,
 bom_resources br,
 cst_cost_types cct,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 mfg_lookups ml_basis
where mp.organization_id          = cdo.organization_id
and cdo.cost_type_id            = cct.cost_type_id
and cdo.department_id           = bd.department_id
and cdo.overhead_id             = br.resource_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and 1=1
and br.absorption_account       = gcc.code_combination_id
and ml_basis.lookup_code        = cdo.basis_type
and ml_basis.lookup_type        = 'CST_BASIS_SHORT'
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id -- this gets the organization name
and haou2.organization_id       = to_number (hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                = to_number (hoi.org_information1) -- get the ledger_id
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
order by
 nvl(gl.short_name, gl.name), -- Ledger
 haou.name, -- Operating_Unit
 mp.organization_code, -- Org_Code
 cct.cost_type, -- Cost_Type
 bd.department_code, -- Department
 br.resource_code -- Overhead