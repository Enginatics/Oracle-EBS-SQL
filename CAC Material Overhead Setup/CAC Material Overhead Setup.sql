/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Material Overhead Setup
-- Description: Report to show the material overhead sub-element definition and the default material overheads, if any.
-- / +=============================================================================+
-- -- | Copyright 2011 - 2020 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxmtlovhdsetuprept.sql
-- -- |
-- -- | Parameters:
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- | ponlyactive -- include only active material overhead codes. Enter
-- -- | Yes (Yes) to return only active (non-disabled) material
-- -- | overhead codes. Enter No (No) to get all material
-- -- | overhead codes.
-- -- |
-- -- | Description:
-- -- | Report to show the material overhead sub-element definition and the default
-- -- | material overheads, if any.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 05 Apr 2011 Douglas Volz Initial Coding
-- -- | 1.1 21 Feb 2016 Douglas Volz Modified Chart of Accounts to match client's COA
-- -- | 1.2 17 Jul 2018 Douglas Volz Modified Chart of Accounts to match client's COA
-- -- | 1.3 16 Jan 2020 Douglas Volz Add inventory org and operating unit parameters.
-- -- | 1.4 8 Apr 2020 Douglas Volz Fix for ponlyactive parameter conditions and
-- -- | changed from fndlookupvalues to mfglookups
-- -- | sysyesno for the Functional Currency column.
-- -- | Was duplicating rows.
-- -- | 1.5 28 Apr 2020 Douglas Volz Changed to multi-language views for the
-- -- | inventory orgs and operating units.
-- -- | 1.6 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-material-overhead-setup/
-- Library Link: https://www.enginatics.com/reports/cac-material-overhead-setup/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
br.resource_code material_overhead_code,
xxen_util.yes(decode(br.functional_currency_flag,1,'Y')) functional_currency,
br.unit_of_measure uom_code,
xxen_util.meaning(br.default_basis_type,'CST_BASIS',700) default_basis_type,
&column_segments
br.disable_date,
decode(ciod.material_overhead_id,null,null,decode(ciod.category_set_id,null,'Org','Category')) default_level,
xxen_util.meaning(ciod.item_type,'CST_MTL_ITEM_TYPE',700) default_item_type,
mcsv.category_set_name default_category_set,
mcbk.concatenated_segments default_category_name,
xxen_util.meaning(ciod.basis_type,'CST_BASIS',700) basis_type,
ciod.usage_rate_or_amount default_rate_or_amount
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
bom_resources br,
gl_code_combinations gcc,
cst_item_overhead_defaults ciod,
mtl_category_sets_vl mcsv,
mtl_categories_b_kfv mcbk
where
1=1 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=br.organization_id and
br.cost_element_id=2 and
(:p_only_active='N' or nvl(br.disable_date,sysdate)>=trunc(sysdate)) and
br.absorption_account=gcc.code_combination_id(+) and
br.resource_id=ciod.material_overhead_id(+) and
br.organization_id=ciod.organization_id(+) and
ciod.category_set_id=mcsv.category_set_id(+) and
ciod.category_id=mcbk.category_id(+)
order by
ledger,
operating_unit,
org_code,
material_overhead_code,
default_category_set,
default_category_name,
basis_type
