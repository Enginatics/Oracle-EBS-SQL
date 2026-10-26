/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Resources Associated with Overheads Setup
-- Description: Report to show which resources are associated with which overheads and which resources are associated with which departments. And find any resources which do not have any overhead associations. If there are no overhead associations the first report column will say "Missing".
-- If the resource/overhead association exists, the first column of the report will say "Set Up".
-- Note: if a resource does not have a cost, the Resource Rate column has a blank or empty value.
-- Parameters:
-- ===========
-- Resource/Overhead Cost Type: enter the cost type you wish to report for your resources and overheads. If left blank, depending on your Costing Method, it defaults to your AvgRates or Frozen Cost Type (optional).
-- Category Set 1: any item category you wish, typically the Cost or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Inventory category set (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2016 - 2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxresovhdsetup.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 11 Nov 2016 Douglas Volz Initial Coding
-- -- | 1.1 16 Jun 2017 Douglas Volz Add check for resources which are not
-- -- | associated with overheads and added the
-- -- | resource cost element.
-- -- | 1.2 17 Jul 2018 Douglas Volz Made Cost Type parameter optional
-- -- | 1.3 16 Jan 2020 Douglas Volz Added org code and operating unit parameters.
-- -- | 1.4 20 Apr 2020 Douglas Volz Make Cost Type default work for all cost methods
-- -- | 1.5 09 Jul 2022 Douglas Volz Changes for multi-language lookup values.
-- -- | 1.6 22 Jan 2024 Douglas Volz Add with statement for cstresourcecosts, overheads
-- -- | were not reported if the resource cost was missing.
-- -- | Added resource "Allow Costs" column. Removed
-- -- | tabs and added inventory access controls.
-- -- | 1.7 31 Jan 2024 Douglas Volz Add Currency Code, Resource Type and Charge Type columns.
-- -- | 1.8 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-resources-associated-with-overheads-setup/
-- Library Link: https://www.enginatics.com/reports/cac-resources-associated-with-overheads-setup/
-- Run Report: https://demo.enginatics.com/

select
nvl2(cro.overhead_id,xxen_util.meaning('SET UP','CHECK RANGE STATUS',200),xxen_util.meaning('MISSING','NL_IZA_REJECT_REASON',3)) status,
x.ledger,
x.operating_unit,
x.org_code,
x.cost_type,
x.resource_code,
x.resource_uom,
x.cost_element,
x.currency_code,
x.resource_rate,
x.resource_type,
x.charge_type,
x.resource_basis,
x.allow_costs,
x.department,
nvl(br_ovh.resource_code,xxen_util.meaning('MISSING','NL_IZA_REJECT_REASON',3)) overhead_code,
br_ovh.unit_of_measure overhead_uom
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
cct.cost_type_id,
cct.cost_type,
br.resource_id,
br.resource_code,
br.unit_of_measure resource_uom,
cce.cost_element,
gl.currency_code,
(select crc.resource_rate from cst_resource_costs crc where br.resource_id=crc.resource_id and cct.cost_type_id=crc.cost_type_id) resource_rate,
xxen_util.meaning(br.resource_type,'BOM_RESOURCE_TYPE',700) resource_type,
xxen_util.meaning(br.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) charge_type,
xxen_util.meaning(br.default_basis_type,'CST_BASIS_SHORT',700) resource_basis,
xxen_util.yes(decode(br.allow_costs_flag,1,'Y')) allow_costs,
bd.department_code department
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_cost_types cct,
bom_resources br,
cst_cost_elements cce,
bom_department_resources bdr,
bom_departments bd
where
1=1 and
2=2 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
(cct.cost_type=:p_cost_type or :p_cost_type is null and cct.cost_type_id=nvl(mp.avg_rates_cost_type_id,mp.primary_cost_method)) and
mp.organization_id=br.organization_id and
br.cost_element_id=cce.cost_element_id and
br.resource_id=bdr.resource_id and
bdr.department_id=bd.department_id
) x,
cst_resource_overheads cro,
bom_resources br_ovh
where
x.resource_id=cro.resource_id(+) and
x.cost_type_id=cro.cost_type_id(+) and
cro.overhead_id=br_ovh.resource_id(+)
order by
status,
x.ledger,
x.operating_unit,
x.org_code,
x.cost_type,
x.resource_code,
x.cost_element,
x.allow_costs,
x.department,
overhead_code
