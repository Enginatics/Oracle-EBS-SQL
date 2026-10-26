/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Department Overhead Rates
-- Description: Report to show departmental overheads and rates
-- / +=============================================================================+
-- -- | Copyright 2016 - 2020 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- | 1.5 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxdeptovhdrates.sql
-- -- |
-- -- | Parameters:
-- -- | pledger -- Ledger you wish to report, enter a null or blank for all
-- -- | ledgers.
-- -- | pcosttype -- Cost Type you wish to report, enter a null or blank for all
-- -- | cost types.
-- -- |
-- -- | Description:
-- -- | Report to show departmental overheads and rates.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 17 Sep 2013 Douglas Volz Initial Coding
-- -- | 1.1 18 Oct 2016 Douglas Volz Added organization information
-- -- | 1.2 6 Sep 2019 Douglas Volz Added last update date
-- -- | 1.3 27 Jan 2020 Douglas Volz Added Operating Unit parameter
-- -- | 1.4 26 Apr 2020 Douglas Volz Changed to multi-language views for
-- -- | operating units.+=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-department-overhead-rates/
-- Library Link: https://www.enginatics.com/reports/cac-department-overhead-rates/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
cct.cost_type,
bd.department_code department,
br.resource_code overhead,
xxen_util.meaning(cdo.basis_type,'CST_BASIS_SHORT',700) overhead_basis,
cdo.rate_or_amount overhead_rate,
&segment_columns
cdo.last_update_date
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_department_overheads cdo,
cst_cost_types cct,
bom_departments bd,
bom_resources br,
gl_code_combinations gcc
where
1=1 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
nvl(haou.date_to,sysdate+1)>sysdate and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=cdo.organization_id and
cdo.cost_type_id=cct.cost_type_id and
cdo.department_id=bd.department_id and
cdo.overhead_id=br.resource_id and
br.absorption_account=gcc.code_combination_id
order by
ledger,
operating_unit,
org_code,
cost_type,
department,
overhead
