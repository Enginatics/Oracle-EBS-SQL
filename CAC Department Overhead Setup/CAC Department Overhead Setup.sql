/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Department Overhead Setup
-- Description: Report to show the departments and the overhead codes assigned to each department.  In addition, this report displays the corresponding overhead and resource rates.

Note:  if a resource does not have a cost, the Resource Rate column has a blank or empty value.

Parameters:
===========
Cost Type:  enter the cost type you wish to use to report.  If left blank, depending on your Costing Method, it defaults to your AvgRates or Frozen Cost Type (optional).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2016 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_dept_ovhd_setup.sql
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
-- |  1.5     22 Jan 2024 Douglas Volz   Add select statement for cst_resource_costs, overheads
-- |                                     were not reported if the resource cost was missing.
-- |                                     Added resource "Allow Costs" column.  Removed
-- |                                     tabs and added inventory access controls.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-department-overhead-setup/
-- Library Link: https://www.enginatics.com/reports/cac-department-overhead-setup/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou.name Operating_Unit,
        mp.organization_code Org_Code,
        cct.cost_type Cost_Type,        
        bd.department_code Department_Code,
        bro.resource_code Overhead,
        bro.unit_of_measure Overhead_UOM,
        cdo.rate_or_amount Overhead_Rate,
        ml1.meaning Overhead_Basis,
        brr.resource_code Resource_Code,
        brr.unit_of_measure Resource_UOM,
        crc.resource_rate Resource_Rate,
        -- Revision for version 1.5
        ml2.meaning Allow_Costs,
        &segment_columns
        cro.last_update_date Last_Rate_Update_Date
from    cst_department_overheads cdo,
        cst_resource_overheads cro,
        bom_departments bd,
        -- Revision for version 1.1
        bom_department_resources bdr,
        -- Revision for version 1.5
        -- cst_resource_costs crc,
        -- Possible to have an time-basis overhead
        -- associated to an uncosted resource which
        -- is not in cst_resource_costs.  Avoiding
        -- outer join issue with Release 12.1.3.
        (select crc2.cost_type_id,
                crc2.resource_id,
                crc2.resource_rate
         from   cst_resource_costs crc2,
                mtl_parameters mp,
                cst_cost_types cct,
                cst_cost_types cct2 -- Avg Rates Cost Type
         where  cct.cost_type_id            = crc2.cost_type_id (+)
         and    cct2.cost_type_id           = nvl(mp.avg_rates_cost_type_id, mp.primary_cost_method)
         and    mp.organization_id          = crc2.organization_id
         and    2=2                         -- p_org_code, p_cost_type
        ) crc,
        -- End revision for version 1.5
        bom_resources bro,
        bom_resources brr,
        cst_cost_types cct,
        -- Revision for version 1.5
        cst_cost_types cct2, -- Avg Rates Cost Type
        mtl_parameters mp,
        mfg_lookups ml1, -- Basis
        -- Revision for version 1.5
        mfg_lookups ml2, -- allow_costs
        gl_code_combinations gcc,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,
        hr_all_organization_units_vl haou2,
        gl_ledgers gl
where   brr.resource_id             = cro.resource_id
and     cct.cost_type_id            = cro.cost_type_id
-- Revision for version 1.5
and     cct2.cost_type_id           = nvl(mp.avg_rates_cost_type_id, mp.primary_cost_method)
and     cro.overhead_id             = cdo.overhead_id
and     bro.resource_id             = cdo.overhead_id
and     cct.cost_type_id            = cdo.cost_type_id
and     cdo.basis_type in (3, 4)
and     cdo.department_id           = bd.department_id
-- Revision for version 1.1
and     bd.department_id            = bdr.department_id
and     bdr.resource_id             = brr.resource_id 
-- End revision for version 1.1
-- Revision for version 1.5
and     brr.resource_id             = crc.resource_id (+)
-- and     cct.cost_type_id            = crc.cost_type_id
-- End revision for version 1.5
and     mp.organization_id          = brr.organization_id
and     brr.organization_id         = bro.organization_id
and     ml1.lookup_type             = 'CST_BASIS_SHORT'
and     ml1.lookup_code             = cdo.basis_type
-- Revision for version 1.5
and     ml2.lookup_type             = 'SYS_YES_NO'
and     ml2.lookup_code             = brr.allow_costs_flag
-- End revision for version 1.5
and     bro.absorption_account      = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and     hoi.org_information_context = 'Accounting Information'
and     hoi.organization_id         = mp.organization_id
and     hoi.organization_id         = haou.organization_id -- this gets the organization name
and     haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.5
and     mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     1=1                         -- p_operating_unit, p_ledger
and     2=2                         -- p_org_code, p_cost_type
-- Avoid selecting disabled inventory organizations
and     sysdate < nvl(haou.date_to, sysdate + 1)
-- Order by Ledger, Operating Unit, Org Code, Cost Type, Overhead Code and Resource Code
order by 
        nvl(gl.short_name, gl.name), -- Ledger
        haou.name, -- Operating_Unit
        mp.organization_code, -- Org_Code
        cct.cost_type, -- Cost_Type
        bro.resource_code, -- Overhead
        brr.resource_code -- Resource