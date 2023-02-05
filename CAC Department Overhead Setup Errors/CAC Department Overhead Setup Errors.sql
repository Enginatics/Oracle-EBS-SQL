/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Department Overhead Setup Errors
-- Description: Report to show overheads which are not assigned to departments, but, have been assigned to resources and those resources have been assigned to these departments as well.

/* +=============================================================================+
-- | Copyright 2016 - 2020 Douglas Volz Consulting, Inc.                         |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_ovhd_dept_errors.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_cost_type        -- Enter Pending or Frozen or AvgRates for the Cost Type.  
-- |                        A required value.
-- | 
-- |  Description:
-- |  Report to show overheads which are not assigned to departments, but, have
-- |  been assigned to resources and those resources have been assigned to these
-- |  departments as well.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     07 Nov 2016 Douglas Volz   Initial Coding
-- |  1.1     08 Nov 2016 Douglas Volz   Added Cost Element
-- |  1.2     12 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters
-- |                                     and change to gl.short_name.
-- |  1.3     27 Apr 2020 Douglas Volz   Changed to multi-language views for the 
-- |                                     inventory orgs and operating units.
+=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-department-overhead-setup-errors/
-- Library Link: https://www.enginatics.com/reports/cac-department-overhead-setup-errors/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou.name Operating_Unit,
	mp.organization_code Org_Code,
	bd.department_code Department,
	bro.resource_code Missing_Overhead,
	brr.resource_code Resource_Code,
	ml_basis.meaning Overhead_Basis_Type,
	-- Revision for version 1.1
	cce.cost_element Resource_Cost_Element,
	cct.cost_type Cost_Type
from	cst_resource_overheads cro,
	bom_department_resources bdr,
	bom_departments bd,
	bom_resources brr,
	bom_resources bro,
	-- Revision for version 1.1
	cst_cost_elements cce,
	cst_cost_types cct,
	mfg_lookups ml_basis,
	mtl_parameters mp,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl
where	cro.overhead_id         = bro.resource_id
and	bro.cost_element_id     = 5 -- overhead
and	cro.resource_id         = brr.resource_id
and	cro.resource_id         = bdr.resource_id
and	cct.cost_type_id        = cro.cost_type_id
and	cct.organization_id is null
and	2=2                                                                  -- p_cost_type
-- Revision for version 1.1
and	cce.cost_element_id     = brr.cost_element_id
and	bd.department_id        = bdr.department_id
and	ml_basis.lookup_code    = bro.default_basis_type
and	ml_basis.lookup_type    = 'CST_BASIS_SHORT'
and not exists
	(select cdo.overhead_id
	 from	cst_department_overheads cdo,
		cst_cost_types cct
	 where	cdo.overhead_id    = cro.overhead_id
	 and	cdo.department_id  = bdr.department_id
	 and	cdo.basis_type in (3, 4)
	 and	cct.cost_type_id   = cdo.cost_type_id
	 and	2=2                                                           -- p_cost_type
	 and	cct.organization_id is null
	) 
and	mp.organization_id          = cro.organization_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                                                                  -- p_ledger, p_operating_unit, p_org_code
-- Revision for version 1.3
-- Avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
order by 
	nvl(gl.short_name, gl.name), -- Ledger
	haou.name, -- Operating_Unit
	mp.organization_code, -- Org_Code
	bd.department_code -- Department