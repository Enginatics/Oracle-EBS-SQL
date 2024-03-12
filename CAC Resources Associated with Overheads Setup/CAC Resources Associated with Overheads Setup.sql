/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Resources Associated with Overheads Setup
-- Description: Report to show which resources are associated with which overheads and which resources are associated with which departments.  And find any resources which do not have any overhead associations.  If there are no overhead associations the first report column will say "Missing".
If the resource/overhead association exists, the first column of the report will say "Set Up".

Note:  if a resource does not have a cost, the Resource Rate column has a blank or empty value.

Parameters:
===========
Resource/Overhead Cost Type:  enter the cost type you wish to report for your resources and overheads.  If left blank, depending on your Costing Method, it defaults to your AvgRates or Frozen Cost Type (optional).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2016 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_res_ovhd_setup.sql
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
-- |  1.6     22 Jan 2024 Douglas Volz   Add with statement for cst_resource_costs, overheads
-- |                                     were not reported if the resource cost was missing.
-- |                                     Added resource "Allow Costs" column.  Removed
-- |                                     tabs and added inventory access controls.
-- |  1.7     31 Jan 2024 Douglas Volz   Add Currency Code, Resource Type and Charge Type columns.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-resources-associated-with-overheads-setup/
-- Library Link: https://www.enginatics.com/reports/cac-resources-associated-with-overheads-setup/
-- Run Report: https://demo.enginatics.com/

with crc as
        -- Revision for version 1.6
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
         and    cct.cost_type               = nvl(:p_cost_type, cct2.cost_type)                                     -- p_cost_type
         and    cct2.cost_type_id           = nvl(mp.avg_rates_cost_type_id, mp.primary_cost_method)
         and    mp.organization_id          = crc2.organization_id
         and    2=2                         -- p_org_code, p_cost_type
        ) -- crc
        -- End revision for version 1.6

----------------main query starts here--------------

select  flv.meaning Status, -- Set Up
        nvl(gl.short_name, gl.name) Ledger,
        haou.name Operating_Unit,
        mp.organization_code Org_Code,
        cct.cost_type Cost_Type,
        brr.resource_code Resource_Code,
        brr.unit_of_measure Resource_UOM,
        -- Revision for version 1.1
        cce.cost_element Cost_Element,
        -- Revision for version 1.7
        gl.currency_code Currency_Code,
        crc.resource_rate Resource_Rate,
        -- Revision for version 1.7
 ml3.meaning Resource_Type,
 ml4.meaning Charge_Type,
        ml1.meaning Resource_Basis,
        -- End revision for version 1.7
        -- Revision for version 1.6
        ml2.meaning Allow_Costs,
        bd.department_code Department,
        bro.resource_code Overhead_Code,
        bro.unit_of_measure Overhead_UOM
from    cst_resource_overheads cro,
        bom_department_resources bdr,
        bom_departments bd,
        -- Revision for version 1.6
        -- cst_resource_costs crc,
        crc,
        -- End revision for version 1.6
        bom_resources bro, -- Overhead Sub-Elements
        bom_resources brr, -- Resource and OSP Sub-Elements
        cst_cost_types cct,
        -- Revision for version 1.4
        cst_cost_types cct2, -- Avg Rates Cost Type
        cst_cost_elements cce,
        mtl_parameters mp,
        mfg_lookups ml1, -- Basis
        -- Revision for version 1.6
        mfg_lookups ml2, -- Allow Costs
        -- Revision for version 1.7
 mfg_lookups ml3, -- Resource Type
 mfg_lookups ml4, -- Charge Type
         -- End revision for version 1.7
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,
        hr_all_organization_units_vl haou2,
        gl_ledgers gl,
        -- Revision for version 1.5
        fnd_lookup_values flv
where   brr.resource_id             = cro.resource_id
and     bro.resource_id             = cro.overhead_id
and     brr.resource_id             = bdr.resource_id
and     bdr.department_id           = bd.department_id
and     brr.resource_id             = crc.resource_id (+)
and     cct.cost_type_id            = cro.cost_type_id
-- Revision for version 1.6
-- and     cct.cost_type_id            = crc.cost_type_id
-- Revision for version 1.4
and     cct2.cost_type_id           = nvl(mp.avg_rates_cost_type_id, mp.primary_cost_method)
and     cct.cost_type               = nvl(:p_cost_type, cct2.cost_type)                                     -- p_cost_type
-- End revision for version 1.4
and     mp.organization_id          = brr.organization_id
and     brr.organization_id         = bro.organization_id
and     ml1.lookup_type             = 'CST_BASIS_SHORT'
and     ml1.lookup_code             = brr.default_basis_type
-- Revision for version 1.6
and     ml2.lookup_type             = 'SYS_YES_NO'
and     ml2.lookup_code             = brr.allow_costs_flag
-- End revision for version 1.6
-- Revision for version 1.7
and ml3.lookup_type             = 'BOM_RESOURCE_TYPE'
and ml3.lookup_code             = brr.resource_type
and ml4.lookup_type             = 'BOM_AUTOCHARGE_TYPE'
and ml4.lookup_code             = brr.autocharge_type
-- End revision for version 1.7
-- Revision for version 1.5
and     flv.lookup_type             = 'CHECK RANGE STATUS'
and     flv.lookup_code             = 'SET UP'
and     flv.language                = userenv('lang')
-- Revision for version 1.1
and     cce.cost_element_id         = brr.cost_element_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and     hoi.org_information_context = 'Accounting Information'
and     hoi.organization_id         = mp.organization_id
and     hoi.organization_id         = haou.organization_id -- this gets the organization name
and     haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.6
and     mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     1=1                         -- p_operating_unit, p_ledger
and     2=2                         -- p_org_code, p_cost_type
-- Revision for version 1.1
-- Add check for resources which are not associated with overheads
union all
select  fcl.meaning Status, -- Missing
        nvl(gl.short_name, gl.name) Ledger,
        haou.name Operating_Unit,
        mp.organization_code Org_Code,
        cct.cost_type Cost_Type,
        brr.resource_code Resource_Code,
        brr.unit_of_measure Resource_UOM,
        -- Revision for version 1.1
        cce.cost_element Cost_Element,
        -- Revision for version 1.7
        gl.currency_code Currency_Code,
        crc.resource_rate Resource_Rate,
        -- Revision for version 1.7
 ml3.meaning Resource_Type,
 ml4.meaning Charge_Type,
        ml1.meaning Resource_Basis,
        -- End revision for version 1.7
        -- Revision for version 1.6
        ml2.meaning Allow_Costs,
        bd.department_code Department,
        fcl.meaning Overhead_Code, -- Missing
        null Overhead_UOM
from    bom_department_resources bdr,
        bom_departments bd,
        -- Revision for version 1.6
        -- cst_resource_costs crc,
        crc,
        -- End revision for version 1.6
        bom_resources brr, -- Resource and OSP Sub-Elements
        cst_cost_types cct,
        -- Revision for version 1.4
        cst_cost_types cct2,
        -- Revision for version 1.1
        cst_cost_elements cce,
        mtl_parameters mp,
        mfg_lookups ml1, -- Basis
        -- Revision for version 1.6
        mfg_lookups ml2, -- Allow Costs
        -- Revision for version 1.7
 mfg_lookups ml3, -- Resource Type
 mfg_lookups ml4, -- Charge Type
         -- End revision for version 1.7
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,
        hr_all_organization_units_vl haou2,
        gl_ledgers gl,
        fnd_common_lookups fcl
where   brr.resource_id             = bdr.resource_id
and     bdr.department_id           = bd.department_id
and     brr.resource_id             = crc.resource_id (+)
-- Revision for version 1.6
-- and     cct.cost_type_id            = crc.cost_type_id
-- Revision for version 1.4
and     cct2.cost_type_id           = nvl(mp.avg_rates_cost_type_id, mp.primary_cost_method)
and     cct.cost_type               = nvl(:p_cost_type, cct2.cost_type)                                     -- p_cost_type
-- End revision for version 1.4   
and     mp.organization_id          = brr.organization_id
and     ml1.lookup_type             = 'CST_BASIS_SHORT'
and     ml1.lookup_code             = brr.default_basis_type
-- Revision for version 1.6
and     ml2.lookup_type             = 'SYS_YES_NO'
and     ml2.lookup_code             = brr.allow_costs_flag
-- End revision for version 1.6
-- Revision for version 1.7
and ml3.lookup_type             = 'BOM_RESOURCE_TYPE'
and ml3.lookup_code             = brr.resource_type
and ml4.lookup_type             = 'BOM_AUTOCHARGE_TYPE'
and ml4.lookup_code             = brr.autocharge_type
-- End revision for version 1.7
-- Revision for version 1.5
and     fcl.lookup_type             = 'NL_IZA_REJECT_REASON'
and     fcl.lookup_code             = 'MISSING'
-- Revision for version 1.1
and     cce.cost_element_id         = brr.cost_element_id
and     brr.resource_id not in 
                (select cro.resource_id
                 from   cst_resource_overheads cro
                 where  cro.resource_id             = brr.resource_id
                 and    cro.organization_id         = brr.organization_id
                 and    cct.cost_type_id            = cro.cost_type_id)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and     hoi.org_information_context = 'Accounting Information'
and     hoi.organization_id         = mp.organization_id
and     hoi.organization_id         = haou.organization_id -- this gets the organization name
and     haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.6
and     mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     1=1                         -- p_operating_unit, p_ledger
and     2=2                         -- p_org_code, p_cost_type
-- Order by Status, Ledger, Operating_Unit, Org_Code, Cost_Type, Resource_Code, Res Basis, Department and Overhead Code
order by 
        1,2,3,4,5,6,8,14,15