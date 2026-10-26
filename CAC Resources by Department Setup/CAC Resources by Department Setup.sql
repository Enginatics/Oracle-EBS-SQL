/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Resources by Department Setup
-- Description: Report to show which resources are assigned to which departments. With the respective resource rates as well.
-- / +=============================================================================+
-- -- | Copyright 2016 - 2022 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxresourcesbydept.sql
-- -- |
-- -- | Parameters:
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- | pcosttype -- Enter Pending or Frozen or AvgRates for the Cost Type.
-- -- | Optional, defaults to your AvgRates or Frozen Cost Type,
-- -- | depending on your Costing Method.
-- -- | Description:
-- -- | Report to show which resources are assigned to which departments.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 21 Jan 2017 Douglas Volz Initial Coding
-- -- | 1.1 20 Jan 2020 Douglas Volz Add operating unit and org code parameters.
-- -- | 1.2 20 Apr 2020 Douglas Volz Make Cost Type default work for all cost methods
-- -- | 1.3 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-resources-by-department-setup/
-- Library Link: https://www.enginatics.com/reports/cac-resources-by-department-setup/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
cct.cost_type,
bd.department_code department,
(select ca.activity from cst_activities ca where br.default_activity_id=ca.activity_id) activity,
br.resource_code,
cce.cost_element,
br.description,
gl.currency_code,
nvl(crc.resource_rate,0) resource_rate,
xxen_util.meaning(br.resource_type,'BOM_RESOURCE_TYPE',700) resource_type
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_cost_types cct_default,
bom_resources br,
cst_cost_elements cce,
bom_department_resources bdr,
bom_departments bd,
cst_resource_costs crc,
cst_cost_types cct
where
1=1 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
nvl(mp.avg_rates_cost_type_id,mp.primary_cost_method)=cct_default.cost_type_id and
mp.organization_id=br.organization_id and
br.allow_costs_flag=1 and
br.cost_element_id=cce.cost_element_id and
br.resource_id=bdr.resource_id and
bdr.department_id=bd.department_id and
br.organization_id=bd.organization_id and
br.resource_id=crc.resource_id and
mp.organization_id=crc.organization_id and
crc.cost_type_id=cct.cost_type_id and
cct.cost_type=nvl(:p_cost_type,cct_default.cost_type)
order by
ledger,
operating_unit,
org_code,
cost_type,
department
