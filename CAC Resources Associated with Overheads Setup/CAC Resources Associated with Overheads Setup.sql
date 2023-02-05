/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Resources Associated with Overheads Setup
-- Description: Report to show which resources are associated with which overheads and which resources are associated with which departments.  And find any resources which do not have any overhead associations.  If there are no overhead associations the first report column will say "Missing".
If the resource/overhead association exists, the first column of the report will say "Set Up".

/* +=============================================================================+
-- |  Copyright 2016 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_res_ovhd_setup.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_cost_type        -- Cost Type you wish to report.  Optional, if left blank
-- |                        it defaults to your AvgRates or Frozen Cost Type,
-- |                        depending on your Costing Method.
-- | 
-- |  Description:
-- |  Report to show which resources are associated with which overheads and
-- |  which resources are associated with which departments.  And find any
-- |  resources which do not have any overhead associations.  If there are 
-- |  no overhead associations the first report column will say "Missing".
-- |  If the resource/overhead association exists, the first column of the
-- |  report will say "Set Up".
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     11 Nov 2016 Douglas Volz   Initial Coding
-- |  1.1     16 Jun 2017 Douglas Volz   Add check for resources which are not
-- |                                     associated with overheads and added the
-- |                                     resource cost element.
-- |  1.2     17 Jul 2018 Douglas Volz   Made Cost Type parameter optional
-- |  1.3     16 Jan 2020 Douglas Volz   Added org code and operating unit parameters.
-- |  1.4     20 Apr 2020 Douglas Volz   Make Cost Type default work for all cost methods
-- |  1.5     09 Jul 2022 Douglas Volz   Changes for multi-language lookup values.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-resources-associated-with-overheads-setup/
-- Library Link: https://www.enginatics.com/reports/cac-resources-associated-with-overheads-setup/
-- Run Report: https://demo.enginatics.com/

select	flv.meaning Status, -- Set Up
	nvl(gl.short_name, gl.name) Ledger,
	haou.name Operating_Unit,
	mp.organization_code Org_Code,
	cct.cost_type Cost_Type,	
	brr.resource_code Resource_Code,
	brr.unit_of_measure Resource_UOM,
	-- Revision for version 1.1
	cce.cost_element Cost_Element,
	ml_basis.meaning Resource_Basis,
	crc.resource_rate Resource_Rate,
	bd.department_code Department,
	bro.resource_code Overhead_Code,
	bro.unit_of_measure Overhead_UOM
from	cst_resource_overheads cro,
	bom_department_resources bdr,
	bom_departments bd,
	cst_resource_costs crc,
	bom_resources bro, -- Overhead Sub-Elements
	bom_resources brr, -- Resource and OSP Sub-Elements
	cst_cost_types cct,
	-- Revision for version 1.4
	cst_cost_types cct2, -- Avg Rates Cost_Type
	-- Revision for version 1.1
	cst_cost_elements cce,
	mtl_parameters mp,
	mfg_lookups ml_basis,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	-- Revision for version 1.5
	fnd_lookup_values flv
where	brr.resource_id             = cro.resource_id
and	bro.resource_id             = cro.overhead_id
and	brr.resource_id             = bdr.resource_id
and	bdr.department_id           = bd.department_id
and	brr.resource_id             = crc.resource_id(+)
and	cct.cost_type_id            = cro.cost_type_id
and	cro.resource_id             = brr.resource_id 
and	cct.cost_type_id            = crc.cost_type_id
-- Revision for version 1.4
and	cct2.cost_type_id           = nvl(mp.avg_rates_cost_type_id, mp.primary_cost_method)
and	cct.cost_type               = nvl(:p_cost_type, cct2.cost_type)                                     -- p_cost_type
-- End revision for version 1.4
and	mp.organization_id          = brr.organization_id
and	brr.organization_id         = bro.organization_id
and	ml_basis.lookup_code        = brr.default_basis_type
and	ml_basis.lookup_type        = 'CST_BASIS_SHORT'
-- Revision for version 1.5
and	flv.lookup_type             = 'CHECK RANGE STATUS'
and	flv.lookup_code             = 'SET UP'
and	flv.language                = userenv('lang')
-- Revision for version 1.1
and	cce.cost_element_id         = brr.cost_element_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                         -- p_org_code, p_operating_unit, p_ledger, p_cost_type
-- Revision for version 1.1
-- Add check for resources which are not associated with overheads
union all
select	fcl.meaning Status, -- Missing
	nvl(gl.short_name, gl.name) Ledger,
	haou.name Operating_Unit,
	mp.organization_code Org_Code,
	cct.cost_type Cost_Type,	
	brr.resource_code Resource_Code,
	brr.unit_of_measure Resource_UOM,
	-- Revision for version 1.1
	cce.cost_element Cost_Element,
	ml_basis.meaning Resource_Basis,
	crc.resource_rate Resource_Rate,
	bd.department_code Department,
	fcl.meaning Overhead_Code, -- Missing
	null Overhead_UOM
from	bom_department_resources bdr,
	bom_departments bd,
	cst_resource_costs crc,
	bom_resources brr, -- Resource and OSP Sub-Elements
	cst_cost_types cct,
	-- Revision for version 1.4
	cst_cost_types cct2,
	-- Revision for version 1.1
	cst_cost_elements cce,
	mtl_parameters mp,
	mfg_lookups ml_basis,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	fnd_common_lookups fcl
where	brr.resource_id             = bdr.resource_id
and	bdr.department_id           = bd.department_id
and	brr.resource_id             = crc.resource_id(+)
and	cct.cost_type_id            = crc.cost_type_id
-- Revision for version 1.4
and	cct2.cost_type_id           = nvl(mp.avg_rates_cost_type_id, mp.primary_cost_method)
and	cct.cost_type               = nvl(:p_cost_type, cct2.cost_type)                                     -- p_cost_type
-- End revision for version 1.4   
and	mp.organization_id          = brr.organization_id
and	ml_basis.lookup_code        = brr.default_basis_type
and	ml_basis.lookup_type        = 'CST_BASIS_SHORT'
-- Revision for version 1.5
and	fcl.lookup_type             = 'NL_IZA_REJECT_REASON'
and	fcl.lookup_code             = 'MISSING'
-- Revision for version 1.1
and	cce.cost_element_id         = brr.cost_element_id
and	brr.resource_id not in 
		(select cro.resource_id
		 from	cst_resource_overheads cro
		 where	cro.resource_id             = brr.resource_id
		 and	cro.organization_id         = brr.organization_id
		 and	cct.cost_type_id            = cro.cost_type_id)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                         -- p_org_code, p_operating_unit, p_ledger, p_cost_type
-- Order by Status, Ledger, Operating_Unit, Org_Code, Cost_Type, Resource_Code, Res Basis, Department and Overhead Code
order by 
	1,2,3,4,5,6,9,11,12