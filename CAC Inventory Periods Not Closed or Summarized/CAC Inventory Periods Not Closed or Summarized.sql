/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Periods Not Closed or Summarized
-- Description: Report to find all inventory accounting periods which are either still open or closed but not summarized. When you close the inventory accounting period, the Period Close Reconciliation Report creates a very useful month-end summary of your inventory quantities and balances, by item, subinventory or intransit, cost group and inventory organization. You can use this information to create a efficient month-end inventory value report.
-- Note: this report automatically looks for hierarchies which might be used with the Open Period Control and the Close Period Control Oracle programs. Looking for the translated values of "Close", "Open" and "Period" in the Hierarchy Name.
-- / +=============================================================================+
-- -- | Copyright 2018 - 2020 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxinvperiodsnotclosedrept.sql
-- -- |
-- -- | Parameters:
-- -- | porghierarchyname -- select the organization hierarchy used to open and
-- -- | close your inventory organizations (optional)
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- |
-- -- | Description:
-- -- | Report to find all inventory accounting periods which are either still open,
-- -- | or closed but not summarized. When you close the inventory accounting period,
-- -- | the Period Close Reconciliation Report creates a very useful month-end
-- -- | summary of your inventory quantities and balances, by item, subinventory or
-- -- | intransit, cost group and inventory organization. You can use this
-- -- | information to create a efficient month-end inventory value report.
-- -- |
-- -- | History for xxxinvperiodsnotclosedrept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== =============== =========================================
-- -- | 1.0 06 Dec 2018 Douglas Volz Report created based on Period Status Report
-- -- | 1.1 09 Feb 2020 Douglas Volz Added Org, Ledger and Operating Unit parameters
-- -- | 1.2 08 Mar 2020 Douglas Volz Improvements to finding the Hierarchy Name,
-- -- | looking for the words Open, Close or Period.
-- -- | 1.3 27 Apr 2020 Douglas Volz Changed to multi-language views for the
-- -- | inventory orgs and operating units.
-- -- | 1.4 16 Aug 2020 Douglas Volz Fix for revision 1.2 for Organization Hierarchy.
-- -- | 1.5 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-inventory-periods-not-closed-or-summarized/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-periods-not-closed-or-summarized/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name functional_area,
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
haouv.name organization_name,
oap.period_name,
oap.period_num period_number,
oap.period_year,
xxen_util.meaning(decode(oap.open_flag||'-'||nvl(oap.summarized_flag,'N'),'N-N',65,'N-Y',66,'P-N',2,'P-Y',2,'Y-N',3,'Y-Y',3,'N-E',4,'Y-E',4,3),'MTL_ACCT_PERIOD_STATUS',700) inventory_period_status,
xxen_util.yes(oap.summarized_flag) summarized_flag,
coalesce(
(
select
max(hoh.organization_hierarchy_name)
from
hrfv_organization_hierarchies hoh
where
hoh.organization_hierarchy_name='&p_org_hierarchy_name' and
(mp.organization_id=hoh.child_organization_id or mp.organization_id=hoh.parent_organization_id)
),
(
select
max(hoh.organization_hierarchy_name)
from
hrfv_organization_hierarchies hoh
where
regexp_like(hoh.organization_hierarchy_name,'&p_name_open|&p_name_close|&p_name_period','i') and
(mp.organization_id=hoh.child_organization_id or mp.organization_id=hoh.parent_organization_id)
)
) hierarchy_name
from
fnd_application_vl fav,
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
org_acct_periods oap
where
1=1 and
fav.application_id=401 and
mp.master_organization_id<>mp.organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
nvl(haouv.date_to,sysdate+1)>sysdate and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=oap.organization_id and
(oap.open_flag='Y' or oap.summarized_flag='N')
order by
functional_area,
ledger,
operating_unit,
org_code,
oap.period_year,
oap.period_num,
oap.period_name
