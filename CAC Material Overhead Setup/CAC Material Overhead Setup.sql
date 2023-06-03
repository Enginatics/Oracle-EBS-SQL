/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Material Overhead Setup
-- Description: Report to show the material overhead sub-element definition and the default material overheads, if any.

/* +=============================================================================+
-- |  Copyright 2011 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_mtl_ovhd_setup_rept.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_only_active      -- include only active material overhead codes.  Enter
-- |                        Yes (Yes) to return only active (non-disabled) material 
-- |                        overhead codes.  Enter No (No) to get all material 
-- |                        overhead codes.
-- |
-- |  Description:
-- |  Report to show the material overhead sub-element definition and the default
-- |  material overheads, if any.
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     05 Apr 2011 Douglas Volz   Initial Coding 
-- |  1.1     21 Feb 2016 Douglas Volz   Modified Chart of Accounts to match client's COA
-- |  1.2     17 Jul 2018 Douglas Volz   Modified Chart of Accounts to match client's COA
-- |  1.3     16 Jan 2020 Douglas Volz   Add inventory org and operating unit parameters.
-- |  1.4      8 Apr 2020 Douglas Volz   Fix for p_only_active parameter conditions and
-- |                                     changed from fnd_lookup_values to mfg_lookups
-- |                                     sys_yes_no for the Functional Currency column.
-- |                                     Was duplicating rows.
-- |  1.5     28 Apr 2020 Douglas Volz   Changed to multi-language views for the
-- |                                     inventory orgs and operating units.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-material-overhead-setup/
-- Library Link: https://www.enginatics.com/reports/cac-material-overhead-setup/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 br_rept_sum.resource_code Material_Overhead_Code,
 ml.meaning Functional_Currency,
 br_rept_sum.unit_of_measure UOM_Code,
 flv1.meaning Default_Basis_Type,
 &column_segments
 br_rept_sum.disable_date Disable_Date,
 br_rept_sum.default_level Default_Level,
 br_rept_sum.default_item_type Default_Item_Type,
 br_rept_sum.default_category_set Default_Category_Set,
 br_rept_sum.default_category_name Default_Category_Name,
 br_rept_sum.basis_type Basis_Type,
 br_rept_sum.default_rate_or_amount Default_Rate_or_Amount
from gl_code_combinations gcc,
 fnd_lookup_values flv1,
 mfg_lookups ml,
 mtl_parameters mp,
 gl_ledgers gl,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 (select br_rept.resource_code,
  br_rept.resource_id,
  br_rept.organization_id,
  br_rept.unit_of_measure,
  br_rept.functional_currency_flag,
  br_rept.default_basis_type,
  br_rept.absorption_account,
  br_rept.disable_date,
  br_rept.default_level,
  br_rept.default_item_type,
  br_rept.default_category_set,
  br_rept.default_category_name,
  br_rept.basis_type,
  sum(br_rept.default_rate_or_amount) default_rate_or_amount
  from  -- ================================================
   -- Get the Resource Information for those resources
   -- with no default material overhead information
   -- ================================================
  (select br.resource_code,
   br.resource_id,
   br.organization_id,
   br.unit_of_measure,
   br.functional_currency_flag,
   br.default_basis_type,
   br.absorption_account,
   br.disable_date,
   null default_level,
   null default_item_type,
   null default_category_set,
   null default_category_name,
   null basis_type,
   null default_rate_or_amount
   from bom_resources br
   where br.cost_element_id          = 2 -- material overhead
   -- Revision for version 1.4
   -- Change to <= and use trunc(sysdate) as a comparison
   and decode(:p_only_active,                                                -- p_only_active
    'N',  nvl(br.disable_date, '01-jan-1961'),
    'Y',  trunc(sysdate)
         ) <=
   decode(:p_only_active,                                                -- p_only_active
    'N',   nvl(br.disable_date, '01-jan-1961'),
    'Y',   decode(br.disable_date, null, trunc(sysdate), br.disable_date)
         )
   -- ================================================
   -- Only get resources with no defaults
   -- ================================================
   and not exists (select 'x'
     from cst_item_overhead_defaults ciod
     where br.resource_id = ciod.material_overhead_id)
   union all
   -- ================================================
   -- Get the Resource Information for those resources
   -- with org level default material overheads
   -- ================================================
   select br.resource_code,
   br.resource_id,
   br.organization_id,
   br.unit_of_measure,
   br.functional_currency_flag,
   br.default_basis_type,
   br.absorption_account,
   br.disable_date,
   decode(ciod.category_set_id, null, 'Org', 'Category') default_level,
   flv1.meaning default_item_type,
   '' default_category_set,
   '' default_category_name,
   flv2.meaning basis_type,
   ciod.usage_rate_or_amount default_rate_or_amount
   from bom_resources br,
   cst_item_overhead_defaults ciod,
   fnd_lookup_values flv1,
   fnd_lookup_values flv2
   -- ================================================
   -- joins for the resources and organizations
   -- ================================================
   where br.resource_id              = ciod.material_overhead_id
   and br.organization_id          = ciod.organization_id
   and br.cost_element_id          = 2 -- material overhead
   -- Revision for version 1.4
   -- Change to <= and use trunc(sysdate) as a comparison
   and decode(:p_only_active,                                                -- p_only_active
    'N',   nvl(br.disable_date, '01-jan-1961'),
    'Y',  trunc(sysdate)
         ) <=
   decode(:p_only_active,                                                -- p_only_active
    'N',   nvl(br.disable_date, '01-jan-1961'),
    'Y',   decode(br.disable_date, null, trunc(sysdate), br.disable_date)
         )
   and ciod.category_set_id is null
   -- ================================================
   -- joins for the lookup codes
   -- ================================================
   and flv1.lookup_code            = ciod.item_type
   and flv1.lookup_type            = 'CST_MTL_ITEM_TYPE'
   and flv1.language               = userenv('lang')
   and flv2.lookup_type            = 'CST_BASIS'
   and flv2.lookup_code            = ciod.basis_type
   and flv2.language               = userenv('lang')
   union all
   -- ================================================
   -- Get the Resource Information for those resources
   -- with category level default material overheads
   -- ================================================
   select br.resource_code,
   br.resource_id,
   br.organization_id,
   br.unit_of_measure,
   br.functional_currency_flag,
   br.default_basis_type,
   br.absorption_account,
   br.disable_date,
   decode(ciod.category_set_id, null, 'Org', 'Category') default_level,
   flv1.meaning default_item_type,
   mcs_tl.category_set_name default_category_set,
   mc.concatenated_segments default_category_name,
   flv2.meaning basis_type ,
   ciod.usage_rate_or_amount default_rate_or_amount
   from bom_resources br,
   cst_item_overhead_defaults ciod,
   mtl_categories_b_kfv mc,
   mtl_category_sets_tl mcs_tl,
   fnd_lookup_values flv1,
   fnd_lookup_values flv2
   -- ================================================
   -- joins for the resources and organizations
   -- ================================================
   where br.resource_id              = ciod.material_overhead_id
   and br.organization_id          = ciod.organization_id
   and br.cost_element_id          = 2 -- material overhead
   -- Revision for version 1.4
   -- Change to <= and use trunc(sysdate) as a comparison
   and decode(:p_only_active,                                                -- p_only_active
    'N',  nvl(br.disable_date, '01-jan-1961'),
    'Y',  trunc(sysdate)
         ) <=
   decode(:p_only_active,                                                -- p_only_active
    'N',   nvl(br.disable_date, '01-jan-1961'),
    'Y',   decode(br.disable_date, null, trunc(sysdate), br.disable_date)
         )
   -- ================================================
   -- joins for the lookup codes
   -- ================================================
   and flv1.lookup_code            = ciod.item_type
   and flv1.lookup_type            = 'CST_MTL_ITEM_TYPE'
   and flv1.language               = userenv('lang')
   and flv2.lookup_type            = 'CST_BASIS'
   and flv2.lookup_code            = ciod.basis_type
   and flv2.language               = userenv('lang')
   -- ================================================
   -- joins for the Cost Category_Set
   -- ================================================
   and ciod.category_set_id is not null
   and mcs_tl.category_set_id      = ciod.category_set_id  
   and mc.category_id              = ciod.category_id
   and mcs_tl.language             = userenv('lang')  
  ) br_rept
 group by
  br_rept.resource_code,
  br_rept.resource_id,
  br_rept.organization_id,
  br_rept.unit_of_measure,
  br_rept.functional_currency_flag,
  br_rept.default_basis_type,
  br_rept.absorption_account,
  br_rept.disable_date,
  br_rept.default_level,
  br_rept.default_item_type,
  br_rept.default_category_set,
  br_rept.default_category_name,
  br_rept.basis_type,
  br_rept.default_rate_or_amount
 ) br_rept_sum   
where gcc.code_combination_id     = br_rept_sum.absorption_account
and flv1.lookup_code            = br_rept_sum.default_basis_type
and flv1.lookup_type            = 'CST_BASIS'
and flv1.language               = userenv('lang')
and ml.lookup_type              = 'SYS_YES_NO'
and ml.lookup_code              = br_rept_sum.functional_currency_flag
and mp.organization_id          = br_rept_sum.organization_id
-- ===========================================
-- Ledger, operating unit and org joins
-- ===========================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id            -- get the organization name
and haou2.organization_id       = to_number(hoi.org_information3) -- get the operating unit id
and gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id 
-- Avoid selecting disabled inventory organizations
and sysdate                    < nvl(haou.date_to, sysdate +1)
-- ===========================================
-- Add parameters
-- ===========================================
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and 1=1                                                      -- p_item number, p_org_code, p_operating Unit, p_ledger
-- Order by Ledger, Operating_Unit, Organization Code, 
order by
 nvl(gl.short_name, gl.name),
 haou2.name,
 mp.organization_code, 
 br_rept_sum.resource_code,
 br_rept_sum.default_category_set,
 br_rept_sum.default_category_name,
 br_rept_sum.basis_type