/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Department Overhead Setup Errors
-- Description: This report displays two types of department overhead setup errors.  First, show overheads which are not assigned to departments, but, have been assigned to resources and those resources have been assigned to these departments as well.  This error is called "Overhead Rates Not In Department".  The second error is when resources which have been assigned to departments but these resources have not been assigned to the overheads which also have been assigned to these departments.  This error is "Overheads Not Set Up with Resources".  When either error you will not earn these overheads when you roll up or charge these resources.

To fix the "Overhead Rates Not In Department" error, go to the Overhead Define Form, click on the Rates button and enter a department overhead rate for that overhead.  To fix the  "Overheads Not Set Up with Resources" error, again go to the Overhead Define Form, click on the Resources button and enter the missing resource for that overhead.  

Parameters:
===========
Cost Type:  enter Pending or Frozen or other cost type name. 
Exclude Outside Processing:  enter Yes to exclude outside processing resources from this report.  Enter No to include outside processing resources.  Defaults to Yes (mandatory). 
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional).
Ledger:  specific ledger (optional).

/* +=============================================================================+
-- | Copyright 2016 - 2023 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_ovhd_dept_errors.sql
-- | 
-- |  Description:
-- |  Report to show department overheads setup errors.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     07 Nov 2016 Douglas Volz   Initial Coding
-- |  1.1     08 Nov 2016 Douglas Volz   Added Cost Element
-- |  1.2     12 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters
-- |                                     and change to gl.short_name.
-- |  1.3     27 Apr 2020 Douglas Volz   Changed to multi-language views for the 
-- |                                     inventory orgs and operating units.
-- |  1.4     09 Sep 2023 Douglas Volz   Added new report for missing resource/overhead
-- |                                     associations.  Removed tabs and restrict to only
-- |                                     orgs you have access to, using the org access view.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-department-overhead-setup-errors/
-- Library Link: https://www.enginatics.com/reports/cac-department-overhead-setup-errors/
-- Run Report: https://demo.enginatics.com/

select  'Overhead Rates Not In Department' Error_Type,
-- Revision for version 1.4
        cct.cost_type Cost_Type,
        nvl(gl.short_name, gl.name) Ledger,
        haou.name Operating_Unit,
        mp.organization_code Org_Code,
        bd.department_code Department,
        -- Revision for version 1.4
        bd.department_class_code Department_Class_Code,
        bro.resource_code Missing_Overhead,
        brr.resource_code Resource_Code,
        ml_basis.meaning Overhead_Basis_Type,
        -- Revision for version 1.1
        cce.cost_element Resource_Cost_Element
from    cst_resource_overheads cro,
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
where   cro.overhead_id             = bro.resource_id
and     bro.cost_element_id         = 5 -- overhead
and     cro.resource_id             = brr.resource_id
and     cro.resource_id             = bdr.resource_id
and     cct.cost_type_id            = cro.cost_type_id
and     cct.organization_id is null
and     2=2                         -- p_cost_type
and     3=3                         -- p_include_osp
-- Revision for version 1.1
and     cce.cost_element_id         = brr.cost_element_id
and     bd.department_id            = bdr.department_id
and     ml_basis.lookup_code        = bro.default_basis_type
and     ml_basis.lookup_type        = 'CST_BASIS_SHORT'
and not exists
        (select cdo.overhead_id
         from  cst_department_overheads cdo,
               cst_cost_types cct
         where   cdo.overhead_id    = cro.overhead_id
         and     cdo.department_id  = bdr.department_id
         and     cct.cost_type_id   = cdo.cost_type_id
         and     2=2                -- p_cost_type
         and     cct.organization_id is null
        ) 
and     mp.organization_id          = cro.organization_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and     hoi.org_information_context = 'Accounting Information'
and     hoi.organization_id         = mp.organization_id
and     hoi.organization_id         = haou.organization_id -- this gets the organization name
and     haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
and     mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                         -- p_ledger, p_operating_unit, p_org_code
-- Revision for version 1.2
-- Avoid selecting disabled inventory organizations
and     sysdate < nvl(haou.date_to, sysdate + 1)
union all
-- Revision for version 1.4
select  'Overheads Not Set Up with Resources' Error_Type,
        cct.cost_type Cost_Type,
        nvl(gl.short_name, gl.name) Ledger,
        haou.name Operating_Unit,
        mp.organization_code Org_Code,
        bd.department_code Department,
        bd.department_class_code Department_Class_Code,
        bro.resource_code Missing_Overhead,
        brr.resource_code Resource_Code,
        ml_basis.meaning Overhead_Basis_Type,
        cce.cost_element Resource_Cost_Element
from    cst_department_overheads cdo,
        bom_department_resources bdr,
        bom_departments bd,
        bom_resources brr,
        bom_resources bro,
        cst_cost_elements cce,
        cst_cost_types cct,
        mfg_lookups ml_basis,
        mtl_parameters mp,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,
        hr_all_organization_units_vl haou2,
        gl_ledgers gl
where   cdo.overhead_id             = bro.resource_id
and     cdo.department_id           = bdr.department_id
and     cdo.basis_type in (3, 4) -- resource units, resource value
and     bro.cost_element_id         = 5 -- overhead
and     bdr.resource_id             = brr.resource_id
and     brr.cost_element_id in (3,4) -- resource, outside processing
and     cct.cost_type_id            = cdo.cost_type_id
and     cct.organization_id is null
and     2=2                         -- p_cost_type
and     3=3                         -- p_include_osp
-- Revision for version 1.1
and     cce.cost_element_id         = brr.cost_element_id
and     bd.department_id            = bdr.department_id
and     ml_basis.lookup_code        = bro.default_basis_type
and     ml_basis.lookup_type        = 'CST_BASIS_SHORT'
and not exists
        (select cro.overhead_id
         from   cst_resource_overheads cro,
                cst_cost_types cct
         where  cdo.overhead_id    = cro.overhead_id
         and    cro.resource_id    = bdr.resource_id
         and    cct.cost_type_id   = cro.cost_type_id
         and    2=2                -- p_cost_type
         and    cct.organization_id is null
        )
and     mp.organization_id          = cdo.organization_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and     hoi.org_information_context = 'Accounting Information'
and     hoi.organization_id         = mp.organization_id
and     hoi.organization_id         = haou.organization_id -- this gets the organization name
and     haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
and     mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                         -- p_ledger, p_operating_unit, p_org_code
-- Avoid selecting disabled inventory organizations
and     sysdate < nvl(haou.date_to, sysdate + 1)
-- order by report type, cost type, ledger, operating unit, organization code, department, missing overhead, and resource code
order by 1,2,3,4,5,6,8,9