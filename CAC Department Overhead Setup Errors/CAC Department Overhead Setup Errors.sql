/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Department Overhead Setup Errors
-- Description: This report displays two types of department overhead setup errors. First, show overheads which are not assigned to departments, but, have been assigned to resources and those resources have been assigned to these departments as well. This error is called "Overhead Rates Not In Department". The second error is when resources which have been assigned to departments but these resources have not been assigned to the overheads which also have been assigned to these departments. This error is "Overheads Not Set Up with Resources". When either error you will not earn these overheads when you roll up or charge these resources.
-- To fix the "Overhead Rates Not In Department" error, go to the Overhead Define Form, click on the Rates button and enter a department overhead rate for that overhead. To fix the "Overheads Not Set Up with Resources" error, again go to the Overhead Define Form, click on the Resources button and enter the missing resource for that overhead.
-- Parameters:
-- ===========
-- Cost Type: enter Pending or Frozen or other cost type name.
-- Exclude Outside Processing: enter Yes to exclude outside processing resources from this report. Enter No to include outside processing resources. Defaults to Yes (mandatory).
-- Organization Code: any inventory organization, defaults to your session's inventory organization (optional).
-- Operating Unit: specific operating unit (optional).
-- Ledger: specific ledger (optional).
-- / +=============================================================================+
-- -- | Copyright 2016 - 2023 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxovhddepterrors.sql
-- -- |
-- -- | Description:
-- -- | Report to show department overheads setup errors.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 07 Nov 2016 Douglas Volz Initial Coding
-- -- | 1.1 08 Nov 2016 Douglas Volz Added Cost Element
-- -- | 1.2 12 Jan 2020 Douglas Volz Added Org Code and Operating Unit parameters
-- -- | and change to gl.shortname.
-- -- | 1.3 27 Apr 2020 Douglas Volz Changed to multi-language views for the
-- -- | inventory orgs and operating units.
-- -- | 1.4 09 Sep 2023 Douglas Volz Added new report for missing resource/overhead
-- -- | associations. Removed tabs and restrict to only
-- -- | orgs you have access to, using the org access view.
-- -- | 1.5 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-department-overhead-setup-errors/
-- Library Link: https://www.enginatics.com/reports/cac-department-overhead-setup-errors/
-- Run Report: https://demo.enginatics.com/

select
'Overhead Rates Not In Department' error_type,
cct.cost_type,
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
bd.department_code department,
bd.department_class_code,
br_ovh.resource_code missing_overhead,
br_res.resource_code,
xxen_util.meaning(br_ovh.default_basis_type,'CST_BASIS_SHORT',700) overhead_basis_type,
cce.cost_element resource_cost_element
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_resource_overheads cro,
cst_cost_types cct,
bom_resources br_ovh,
bom_resources br_res,
cst_cost_elements cce,
bom_department_resources bdr,
bom_departments bd
where
1=1 and
2=2 and
3=3 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
nvl(haou.date_to,sysdate+1)>sysdate and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=cro.organization_id and
cro.cost_type_id=cct.cost_type_id and
cct.organization_id is null and
cro.overhead_id=br_ovh.resource_id and
br_ovh.cost_element_id=5 and
cro.resource_id=br_res.resource_id and
br_res.cost_element_id=cce.cost_element_id and
cro.resource_id=bdr.resource_id and
bdr.department_id=bd.department_id and
not exists
(
select
null
from
cst_department_overheads cdo,
cst_cost_types cct
where
cro.overhead_id=cdo.overhead_id and
bdr.department_id=cdo.department_id and
cdo.cost_type_id=cct.cost_type_id and
cct.organization_id is null and
2=2
)
union all
select
'Overheads Not Set Up with Resources' error_type,
cct.cost_type,
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
bd.department_code department,
bd.department_class_code,
br_ovh.resource_code missing_overhead,
br_res.resource_code,
xxen_util.meaning(br_ovh.default_basis_type,'CST_BASIS_SHORT',700) overhead_basis_type,
cce.cost_element resource_cost_element
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_department_overheads cdo,
cst_cost_types cct,
bom_resources br_ovh,
bom_departments bd,
bom_department_resources bdr,
bom_resources br_res,
cst_cost_elements cce
where
1=1 and
2=2 and
3=3 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
nvl(haou.date_to,sysdate+1)>sysdate and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=cdo.organization_id and
cdo.basis_type in (3,4) and
cdo.cost_type_id=cct.cost_type_id and
cct.organization_id is null and
cdo.overhead_id=br_ovh.resource_id and
br_ovh.cost_element_id=5 and
cdo.department_id=bd.department_id and
bd.department_id=bdr.department_id and
bdr.resource_id=br_res.resource_id and
br_res.cost_element_id in (3,4) and
br_res.cost_element_id=cce.cost_element_id and
not exists
(
select
null
from
cst_resource_overheads cro,
cst_cost_types cct
where
cdo.overhead_id=cro.overhead_id and
bdr.resource_id=cro.resource_id and
cro.cost_type_id=cct.cost_type_id and
cct.organization_id is null and
2=2
)
order by
error_type,
cost_type,
ledger,
operating_unit,
org_code,
department,
missing_overhead,
resource_code
