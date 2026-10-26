/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Department Overhead Setup
-- Description: Report to show the departments and the overhead codes assigned to each department. In addition, this report displays the corresponding overhead and resource rates.
-- Note: if a resource does not have a cost, the Resource Rate column has a blank or empty value.
-- Parameters:
-- ===========
-- Cost Type: enter the cost type you wish to use to report. If left blank, depending on your Costing Method, it defaults to your AvgRates or Frozen Cost Type (optional).
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
-- -- | Program Name: xxxdeptovhdsetup.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 18 Oct 2016 Douglas Volz Initial Coding
-- -- | 1.1 07 Nov 2016 Douglas Volz Added Department / Resource relationships
-- -- | 1.2 17 Jul 2018 Douglas Volz Made Cost Type parameter optional
-- -- | 1.3 12 Jan 2020 Douglas Volz Added Org Code and Operating Unit parameters
-- -- | and change to gl.shortname. Added Last
-- -- | rate update column to report.
-- -- | 1.4 27 Apr 2020 Douglas Volz Changed to multi-language views for the
-- -- | inventory orgs and operating units.
-- -- | 1.5 22 Jan 2024 Douglas Volz Add select statement for cstresourcecosts, overheads
-- -- | were not reported if the resource cost was missing.
-- -- | Added resource "Allow Costs" column. Removed
-- -- | tabs and added inventory access controls.
-- -- | 1.6 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-department-overhead-setup/
-- Library Link: https://www.enginatics.com/reports/cac-department-overhead-setup/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
cct.cost_type,
bd.department_code,
br_ovh.resource_code overhead,
br_ovh.unit_of_measure overhead_uom,
cdo.rate_or_amount overhead_rate,
xxen_util.meaning(cdo.basis_type,'CST_BASIS_SHORT',700) overhead_basis,
br_res.resource_code,
br_res.unit_of_measure resource_uom,
(select crc.resource_rate from cst_resource_costs crc where br_res.resource_id=crc.resource_id and cct.cost_type_id=crc.cost_type_id) resource_rate,
xxen_util.yes(decode(br_res.allow_costs_flag,1,'Y')) allow_costs,
&segment_columns
cro.last_update_date last_rate_update_date
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_department_overheads cdo,
cst_cost_types cct,
bom_departments bd,
bom_resources br_ovh,
gl_code_combinations gcc,
bom_department_resources bdr,
bom_resources br_res,
cst_resource_overheads cro
where
1=1 and
2=2 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
nvl(haou.date_to,sysdate+1)>sysdate and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=bd.organization_id and
bd.department_id=cdo.department_id and
cdo.basis_type in (3,4) and
cdo.cost_type_id=cct.cost_type_id and
cdo.overhead_id=br_ovh.resource_id and
br_ovh.absorption_account=gcc.code_combination_id(+) and
bd.department_id=bdr.department_id and
bdr.resource_id=br_res.resource_id and
br_res.resource_id=cro.resource_id and
cdo.overhead_id=cro.overhead_id and
cdo.cost_type_id=cro.cost_type_id
order by
ledger,
operating_unit,
org_code,
cost_type,
overhead,
br_res.resource_code
