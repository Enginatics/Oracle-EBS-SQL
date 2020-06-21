/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Accounting Period Status (Doug's version)
-- Description: /* +=============================================================================+
-- | SQL Code Copyright 2011-2020 Douglas Volz Consulting, Inc.                  |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_period_status_rept.sql
-- |
-- |  Parameters:
-- |  p_functional_area  -- functional area you wish to report, works with null,
-- |                        or valid functional areas.  The names of the
-- |                        functional areas are:  General Ledger, Inventory, Lease
-- |                        Management, Payables, Projects, Purchasing and Receivables.
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_period_name      -- The desired accounting period you wish to report
-- |  p_report_option    -- Parameter used to combine the Period Open and Period Close
-- |                        reports.  The list of value choices are:
-- |                    'Periods Not Opened'  (similar to 'Only Missing Periods') 
-- |                    'Open Periods'
-- |                    'Closed Periods'
-- |                    'All Period Statuses'
-- |  Description:
-- |  Report to show the inventory accounting period status, whether open or closed,
-- |  showing inventory organizations that are not open that should be open or 
-- |  inventory organizations which are closed but should be open. Also shows the
-- |  open/close status for the General Ledger, Lease Management, Payables, Projects, 
-- |  Purchasing and Receivables.  And this report will show open process organizations
-- |  even if the respective inventory accounting period is closed for the same period name.
-- | 
-- |  History for xxx_period_status_rept.sql
-- |
-- |  Version Modified on Modified  by    Description
-- |  ======= =========== =============== =========================================
-- |  1.0     19 Jan 2015 Douglas Volz    Combined the xxx_period_open_status_rept.sql
-- |                      Apps Associates and xxx_period_close_status_rept.sql into
-- |                                      one report.  Originally written in 2006 and 2011.
-- |  1.1     19 Jan 2015 Douglas Volz    Added OPM Cost Calendar status and Projects.
-- |  1.2     19 Dec 2016 Douglas Volz    Fixed list of value choices, was preventing
-- |                                      purchasing operating units from being reported.
-- |                                      Changed to: 
-- |                        'Periods Not Opened'  (similar to 'Only Missing Periods') 
-- |                        'Open Periods'
-- |                        'Closed Periods'
-- |                        'All Period Statuses' 
-- |  1.3     18 May 2016 Douglas Volz    Minor fix for reporting the Organization Hierarchy
-- |  1.4     03 Dec 2018 Douglas Volz    Open Periods option now checks for Summarized Flag.
-- |  1.5     27 Oct 2019 Douglas Volz    Condense A/R, A/P, Projects, Purchasing SQL logic
-- |  1.6     16 Jan 2020 Douglas Volz    Add operating unit parameter
-- +=============================================================================+*/

-- =====================================================================
-- Inventory Calendar Periods Not Closed
-- =====================================================================
-- Excel Examle Output: https://www.enginatics.com/example/cac-accounting-period-status-doug-s-version/
-- Library Link: https://www.enginatics.com/reports/cac-accounting-period-status-doug-s-version/
-- Run Report: https://demo.enginatics.com/

select    'Inventory' "Functional Area",
    oap.period_name "Period Name",
    gl.short_name "Ledger",
    haou2.name "Operating Unit",
    mp.organization_code "Org Code",
    haou.name "Organization Name",
    decode(oap.open_flag,
        'N', 'Closed',
        'Y', 'Open',
        'P', 'Processing',
        oap.open_flag) "Period Status",
    fl2.meaning "Summarized Flag",
    -- Revision for version 1.1
    decode(opm_status.period_status,
        'N', 'Never Opened',
        'O', 'Open',
        'F', 'Frozen',
        'C', 'Closed') "OPM Period Status",
    nvl((select    max(hoh.organization_hierarchy_name)
         from    hrfv_organization_hierarchies hoh
         where    hoh.organization_hierarchy_name IN
                (select    distinct pos.name name
                 from    per_organization_structures pos
                 -- Revision for version 1.3
                 -- where  (upper(pos.name) like ('%CLOSE%'))
                 -- Revision for version 1.6
                 where    (upper(pos.name) like ('%CLOSE%')
                     or upper(pos.name) like ('%OPEN%')
                     or upper(pos.name) like ('%PERIOD%')
                    )
                 -- End revision for version 1.6
                )
         and    (mp.organization_id = hoh.child_organization_id
             -- Revision for version 1.3
             OR
             mp.organization_id = hoh.parent_organization_id)),'None') "Hierarchy Name"
from    org_acct_periods oap,
    mtl_parameters mp,
    hr_organization_information hoi,
    hr_all_organization_units haou,
    hr_all_organization_units haou2,
    gl_ledgers gl,
    fnd_lookups fl2,
    (select    hoi.organization_id,
        gps.period_code,
        gps.start_date,
        gps.period_status
     from    mtl_parameters mp1,
        gmf_fiscal_policies gfp,
        gmf_period_statuses gps,
        hr_organization_information hoi,
        hr_all_organization_units haou        -- inv_organization_id
     where    hoi.org_information_context = 'Accounting Information'
     and    hoi.organization_id = haou.organization_id -- this gets the organization name
     and    gfp.legal_entity_id = to_number(hoi.org_information2)
     and    gps.legal_entity_id = gfp.legal_entity_id
     and    gps.cost_type_id = gfp.cost_type_id
     and    hoi.organization_id = mp1.organization_id
     and    mp1.process_enabled_flag = 'Y') opm_status
where    mp.organization_id = oap.organization_id
and    oap.period_name = '&p_period_name'                                    -- p_period_name
-- ===================================================================
-- Show accounting periods which are open
-- ===================================================================
and    fl2.lookup_type             = 'YES_NO'
and    fl2.lookup_code             = nvl(oap.summarized_flag, 'N')
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and    hoi.org_information_context = 'Accounting Information'
and    hoi.organization_id         = mp.organization_id
and    hoi.organization_id         = haou.organization_id -- this gets the organization name
-- avoid selecting disabled inventory organizations
and    sysdate < nvl(haou.date_to, sysdate + 1)
-- avoid selecting item master orgs
and    mp.master_organization_id  <> mp.organization_id
and    haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and    gl.ledger_id                = to_number(hoi.org_information1) -- this gets the ledger id
and    gl.name                     = decode('&p_ledger', null, gl.name, '&p_ledger')                -- p_ledger
and    haou2.name                  = decode('&p_operating_unit', null, haou2.name, '&p_operating_unit')    -- p_operating_unit
and    'Inventory'                 = decode('&p_functional_area', null, 'Inventory', '&p_functional_area')                        -- p_functional_area
and    oap.organization_id         = opm_status.organization_id(+)
and    oap.period_start_date       = opm_status.start_date(+)
--Report Option Logic
and    ((oap.open_flag                      = decode('&p_report_option',
                        'Open Periods', 'Y',
                        'Closed Periods', 'N',
                        'Periods Not Opened', 'X',
                        oap.open_flag))
      OR
     (nvl(opm_status.period_status, 'Z') = decode('&p_report_option',
                        'Open Periods', 'Y',
                        'Closed Periods', 'C',
                        'Periods Not Opened', 'X',
                         opm_status.period_status))
      OR
     (nvl(opm_status.period_status, 'Z') = decode('&p_report_option',
                        'Open Periods', 'F',
                        'X'))
      -- Revision for version 1.4
      OR
     (nvl(oap.summarized_flag,'N')       = decode('&p_report_option',
                        'Open Periods', 'N',
                        'Closed Periods', 'Y',
                        'Periods Not Opened', 'X',
                        nvl(oap.summarized_flag,'N')))
    )
-- =====================================================================
-- Show accounting periods which should be open but are not
-- If an accounting period is not opened it will not exist in the
-- inventory period calendar, will not be in org_acct_periods
-- =====================================================================
union all
select    'Inventory' "Functional Area",
    gp.period_name "Period Name",
    gl.short_name "Ledger",
    haou2.name "Operating Unit",
    mp.organization_code "Org Code",
    haou.name "Organization Name",
    'Never Opened' "Period Status",
    'N/A' "Summarized Flag", 
    -- Revision for version 1.1
    'N/A' "OPM Period Status",
    nvl((select    max (hoh.organization_hierarchy_name)
         from    hrfv_organization_hierarchies hoh
         where    hoh.organization_hierarchy_name IN
                (select distinct pos.name name
                 from per_organization_structures pos
                 where
                 (upper(pos.name) like ('%CLOSE%') or upper(pos.name) like ('%OPEN%') or upper(pos.name) like ('%PERIOD%')) and
                 (mp.organization_id = hoh.child_organization_id or mp.organization_id = hoh.parent_organization_id)
        )),'None') "Hierarchy Name"
from    gl.gl_periods gp,
    mtl_parameters mp,
    hr_organization_information hoi,
    hr_all_organization_units haou,
    hr_all_organization_units haou2,
    gl_ledgers gl
where    gp.period_set_name          = gl.period_set_name
and    gp.period_name              = '&p_period_name'                                -- p_period_name
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and    hoi.org_information_context = 'Accounting Information'
and    hoi.organization_id         = mp.organization_id
and    hoi.organization_id         = haou.organization_id -- this gets the organization name
-- avoid selecting disabled inventory organizations
and    sysdate < nvl(haou.date_to, sysdate + 1)
-- avoid selecting item master orgs
and    mp.master_organization_id  <> mp.organization_id
-- avoid selecting inventory orgs created after the period end date
-- for reporting against prior accounting periods
and    gp.end_date                >= mp.creation_date
and    haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and    gl.ledger_id                = to_number(hoi.org_information1) -- this gets the ledger id
and    gl.name                     = decode('&p_ledger', null, gl.name, '&p_ledger')                -- p_ledger
and    haou2.name                  = decode('&p_operating_unit', null, haou2.name, '&p_operating_unit')    -- p_operating_unit
-- ===================================================================
-- Check to see if the accounting period already exists in the
-- inventory calendar, in org_acct_periods
-- ===================================================================
and    not exists
    (select    'x'
     from    org_acct_periods oap
     where    oap.organization_id = mp.organization_id
     and    oap.period_name     = '&p_period_name') -- p_period_name
-- Revision for version 1.1
and    'Inventory'                 = decode('&p_functional_area',
                        null, 'Inventory',
                        '&p_functional_area')                        -- p_functional_area
--Report Option Logic
and    'Y'                         = decode('&p_report_option', 'Periods Not Opened', 'Y', 'N')
-- =====================================================================
-- General Ledger, Lease Management, Payables, Projects, Purchasing, Receivables 
-- =====================================================================
union all
select    decode(fa.application_short_name,
        'SQLAP', 'Payables',
        'SQLGL', 'General Ledger',
        'AR', 'Receivables',
        --'OFA', 'Fixed Assets',
        'OKL', 'Lease Management',
        'PO', 'Purchasing',
        'IPA', 'Projects') "Functional Area",
    gps.period_name "Period Name",
    gl.short_name "Ledger",
    haou.name "Operating Unit",
    'N/A' "Org Code",
    'N/A' "Organization Name",
    -- Fix for version 1.2, change closing_status to 'Never Opened'
    decode(gps.closing_status,
        'C', 'Closed',
        'F', 'Future',
        'N', 'Never Opened',
        'O', 'Open',
        'W', 'Pending Close',
        'P', 'Perm Closed',
        gps.closing_status) "Period Status",
    '' "Summarized Flag",
    -- Revision for version 1.1
    '' "OPM Period Status",
    'N/A' "Hierarchy Name"
from    gl_period_statuses gps,
    fnd_application fa,
    hr_organization_information hoi,
    hr_all_organization_units haou,
    gl_ledgers gl
where    gps.application_id          = fa.application_id
and    gps.period_name             = '&p_period_name'                                -- p_period_name
and    fa.application_short_name in ('SQLAP','SQLGL','AR','OFA','OKL','PO','IPA')
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and    gl.ledger_id                = gps.ledger_id
and    hoi.org_information_context = 'Operating Unit Information'
and    hoi.organization_id         = haou.organization_id -- this gets the operating unit id
and    gl.ledger_id                = to_number(hoi.org_information3) -- this joins OU to GL
and    gl.name                     = decode('&p_ledger', null, gl.name, '&p_ledger')                -- p_ledger
and    haou.name                  = decode('&p_operating_unit', null, haou.name, '&p_operating_unit')    -- p_operating_unit
-- Revision for version 1.5
and    fa.application_short_name   =
        (case
         when '&p_functional_area' = 'Payables'         then 'SQLAP'
         when '&p_functional_area' = 'General Ledger'   then 'SQLGL'
         when '&p_functional_area' = 'Receivables'      then 'AR'
         -- when '&p_functional_area' = 'Fixed Assets'     then 'OFA'
         when '&p_functional_area' = 'Lease Management' then 'OKL'
         when '&p_functional_area' = 'Projects'         then 'IPA'
         when '&p_functional_area' = 'Purchasing'       then 'PO'
         else fa.application_short_name
         end
        )
and    ((gps.closing_status = decode('&p_report_option',
                    'Open Periods', 'O',
                    'Closed Periods', 'C',
                    'Periods Not Opened', 'N',
                    'All Period Statuses', 'C',
                    'X'))
     or (gps.closing_status = decode('&p_report_option', 'Periods Not Opened', 'F', 'X'))
     or (gps.closing_status = decode('&p_report_option', 'All Period Statuses', 'O', 'X'))
     or (gps.closing_status = decode('&p_report_option', 'All Period Statuses', 'W', 'X'))
    )
-- order by Functional Area, Period, Ledger, Operating Unit, Org Code
order by 1,2,3,4,5