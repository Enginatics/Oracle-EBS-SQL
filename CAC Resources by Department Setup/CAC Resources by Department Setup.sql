/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Resources by Department Setup
-- Description: Report to show which resources are assigned to which departments.  With the respective resource rates as well.

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
-- |  Program Name:  xxx_resources_by_dept.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_cost_type        -- Enter Pending or Frozen or AvgRates for the Cost Type.  
-- |                        Optional, defaults to your AvgRates or Frozen Cost Type,
-- |                        depending on your Costing Method.
-- |  Description:
-- |  Report to show which resources are assigned to which departments.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     21 Jan 2017 Douglas Volz   Initial Coding
-- |  1.1     20 Jan 2020 Douglas Volz   Add operating unit and org code parameters.
-- |  1.2     20 Apr 2020 Douglas Volz   Make Cost Type default work for all cost methods
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-resources-by-department-setup/
-- Library Link: https://www.enginatics.com/reports/cac-resources-by-department-setup/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou.name Operating_Unit,
	mp.organization_code Org_Code,
	cct.cost_type Cost_Type,
	bd.department_code Department,
	(select	ca.activity
	 from	cst_activities ca
	 where	ca.activity_id = br.default_activity_id) Activity,
	br.resource_code Resource_Code,
	cec.cost_element Cost_Element,
	br.description Description,
	gl.currency_code Currency_Code,
	nvl(crc.resource_rate,0) Resource_Rate,
	ml1.meaning Resource_Type
from	bom_departments bd,
	bom_resources br,
	bom_department_resources bdr,
	cst_resource_costs crc,
	cst_cost_types cct,
	-- Revision for version 1.2
	cst_cost_types cct2, -- Avg Rates Cost Type
	cst_cost_elements  cec,
	mtl_parameters mp,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	mfg_lookups ml1
where	mp.organization_id          = br.organization_id
and	bd.organization_id          = br.organization_id
and	bdr.department_id           = bd.department_id
and	bdr.resource_id             = br.resource_id
and	crc.resource_id             = br.resource_id
and	crc.organization_id         = mp.organization_id
and	crc.cost_type_id            = cct.cost_type_id
-- Revision for version 1.2
and	cct2.cost_type_id           = nvl(mp.avg_rates_cost_type_id, mp.primary_cost_method)
and	cct.cost_type               = nvl(:p_cost_type, cct2.cost_type)                                       -- p_cost_type
-- End revision for version 1.2  
and	br.cost_element_id          = cec.cost_element_id
and	br.allow_costs_flag         = 1 -- Yes
-- ===========================================
-- Joins for the lookup codes
-- ===========================================
and	ml1.lookup_type             = 'BOM_RESOURCE_TYPE'
and	ml1.lookup_code	            = br.resource_type
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                         -- p_org_code, p_operating_unit, p_ledger, p_cost_type
order by
	gl.short_name, -- Ledger
	haou.name, -- Operating Unit
	mp.organization_code, -- Org Code
	cct.cost_type, -- Cost Type
	bd.department_code -- Department