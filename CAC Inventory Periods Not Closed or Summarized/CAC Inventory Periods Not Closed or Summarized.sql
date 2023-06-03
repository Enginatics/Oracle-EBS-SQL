/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Periods Not Closed or Summarized
-- Description: Report to find all inventory accounting periods which are either still open or closed but not summarized.  When you close the inventory accounting period, the Period Close Reconciliation Report creates a very useful month-end summary of your inventory quantities and balances, by item, subinventory or intransit, cost group and inventory organization.  You can use this information to create a efficient month-end inventory value report.
Note:  this report automatically looks for hierarchies which might be used with the Open Period Control and the Close Period Control Oracle programs.  Looking for the translated values of "Close", "Open" and "Period" in the Hierarchy Name.

/* +=============================================================================+
-- | Copyright 2018 - 2020 Douglas Volz Consulting, Inc.                         |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_inv_periods_not_closed_rept.sql
-- |
-- |  Parameters:
-- |  p_org_hierarchy_name   -- select the organization hierarchy used to open and
-- |                            close your inventory organizations (optional)
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |
-- |  Description:
-- |  Report to find all inventory accounting periods which are either still open,
-- |  or closed but not summarized.  When you close the inventory accounting period,
-- |  the Period Close Reconciliation Report creates a very useful month-end
-- |  summary of your inventory quantities and balances, by item, subinventory or
-- |  intransit, cost group and inventory organization.  You can use this 
-- |  information to create a efficient month-end inventory value report.
-- | 
-- |  History for xxx_inv_periods_not_closed_rept.sql
-- |
-- |  Version Modified on Modified  by    Description
-- |  ======= =========== =============== =========================================
-- |  1.0     06 Dec 2018 Douglas Volz    Report created based on Period Status Report
-- |  1.1     09 Feb 2020 Douglas Volz    Added Org, Ledger and Operating Unit parameters
-- |  1.2     08 Mar 2020 Douglas Volz    Improvements to finding the Hierarchy Name,
-- |                                      looking for the words Open, Close or Period.
-- |  1.3     27 Apr 2020 Douglas Volz    Changed to multi-language views for the
-- |                                      inventory orgs and operating units.
-- |  1.4     16 Aug 2020 Douglas Volz    Fix for revision 1.2 for Organization Hierarchy.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-inventory-periods-not-closed-or-summarized/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-periods-not-closed-or-summarized/
-- Run Report: https://demo.enginatics.com/

select fav.application_name Functional_Area,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 oap.period_name Period_Name,
 oap.period_num Period_Number,
 oap.period_year Period_Year,
 ml.meaning Inventory_Period_Status,
 fl2.meaning Summarized_Flag,
 -- Revision for version 1.2 and 1.4
 coalesce(
 (select max(hoh.organization_hierarchy_name) organization_hierarchy_name
  from hrfv_organization_hierarchies hoh
  where hoh.organization_hierarchy_name= '&p_hierarchy_name'
  and (mp.organization_id = hoh.child_organization_id or mp.organization_id = hoh.parent_organization_id)
 ),
 (select max(hoh.organization_hierarchy_name) organization_hierarchy_name
  from hrfv_organization_hierarchies hoh
  where regexp_like(hoh.organization_hierarchy_name,'&p_name_open|&p_name_close|&p_name_period','i')
  and (mp.organization_id = hoh.child_organization_id or mp.organization_id = hoh.parent_organization_id)
 )
  ) Hierarchy_Name
from org_acct_periods oap,
 mtl_parameters mp,
 mfg_lookups ml,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 -- Revision for version 1.3
 fnd_application_vl fav,
 fnd_lookups fl2
where mp.organization_id = oap.organization_id
-- ===================================================================
-- Show accounting periods which are open
-- ===================================================================
-- Report Option Logic
-- If from an upgrade, the original R11i period close rows were never
-- upgraded after Oracle put in the summarization feature (in 11.5.10)
-- So earlier periods which existed before summarization have a null value
and (oap.open_flag = 'Y'
  or 
  nvl(oap.summarized_flag,'Y') = 'N'
 )
and fl2.lookup_type             = 'YES_NO'
and fl2.lookup_code             = nvl(oap.summarized_flag, 'N')
and ml.lookup_type              = 'MTL_ACCT_PERIOD_STATUS'
and ml.lookup_code              = 
  decode((oap.open_flag||'-'||nvl(oap.summarized_flag,'N')),
   'N'||'-'||'N', 65, -- Closed not Summarized
   'N'||'-'||'Y', 66, -- Closed
   'P'||'-'||'N',  2, -- Processing
   'P'||'-'||'Y',  2, -- Processing
   'Y'||'-'||'N',  3, -- Open
   'Y'||'-'||'Y',  3, -- Open
   'N'||'-'||'E',  4, -- Error
   'Y'||'-'||'E',  4, -- Error
   3)
-- Revision for version 1.3
and fav.application_id          = 401 -- Inventory
-- ===================================================================
-- Using base tables to avoid org_organization_definitions and
-- hr_operating_units
-- ===================================================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id -- this gets the organization name
and haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
-- avoid selecting disabled inventory organizations
and sysdate                     < nvl(haou.date_to, sysdate + 1)
and gl.ledger_id                = to_number(hoi.org_information1) -- this gets the ledger id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
-- ===================================================================
-- avoid selecting item master orgs
and mp.master_organization_id  <> mp.organization_id
order by
 fav.application_name, -- Functional Area
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, -- Operating Unit
 mp.organization_code, -- Org Code
 oap.period_year asc, -- Period Year
 oap.period_num asc, -- Period Number
 oap.period_name -- Period Name