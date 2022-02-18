/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Accounting Period Status
-- Description: Report to show the accounting period status for General Ledger, Inventory, Lease Management, Payables, Projects, Purchasing and Receivables.  You can choose All Statuses (open or closed or never opened), Closed, Open or Never Opened periods.  And this report will also display the process manufacturing cost calendar status.
Note:  this report automatically looks for hierarchies which might be used with the Open Period Control and the Close Period Control Oracle programs.  Looking for the translated values of "Close", "Open" and "Period" in the Hierarchy Name.

/* +=============================================================================+
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
-- |  p_functional_area       -- functional area you wish to report, works with null,
-- |                             or valid functional areas.  The names of the
-- |                             functional areas are:  General Ledger, Inventory, Lease
-- |                             Management, Payables, Projects, Purchasing and Receivables.
-- |  p_operating_unit        -- Operating Unit you wish to report, leave blank for all
-- |                             operating units (optional) 
-- |  p_ledger                -- general ledger you wish to report, leave blank for all
-- |                             ledgers (optional)
-- |  p_period_name           -- The desired accounting period you wish to report
-- |  p_report_period_option  -- Parameter used to combine the Period Open and Period Close
-- |                             reports.  For English, the list of value choices are:
-- |					Closed, Open, Never Opened or All Statuses
-- |  Version Modified on Modified  by    Description
-- |  ======= =========== =============== =========================================
-- |  1.0     19 Jan 2015 Douglas Volz    Combined the xxx_period_open_status_rept.sql
-- |                      Apps Associates and xxx_period_close_status_rept.sql into
-- |                                      one report.  Originally written in 2006 and 2011.
-- |  1.7     10 Apr 2020 Douglas Volz    Made the following multi-language changes:
-- |                                      Changed fnd_application to fnd_application_vl
-- |                                      Changed hr_all_organization_units to hr_all_organization_units_vl
-- |  1.8      7 May 2020 Douglas Volz    Added fnd_product_installations to only report
-- |                                      installed applications.
-- |  1.9     26 May 2020 Douglas Volz    Added lookup values and parameters for the
-- |                                      organization_hierarchy_name subquery.
-- |  1.10    28 May 2020 Douglas Volz    For language translation, replaced custom Report 
-- |                                      Options LOV with compound Oracle lookup values.
-- +=============================================================================+*/


-- Excel Examle Output: https://www.enginatics.com/example/cac-accounting-period-status/
-- Library Link: https://www.enginatics.com/reports/cac-accounting-period-status/
-- Run Report: https://demo.enginatics.com/

select	fav.application_name Functional_Area,
-- =====================================================================
-- Inventory Calendar Periods which are open or closed
-- =====================================================================
	oap.period_name Period_Name,
	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	haou.name Organization_Name,
	-- Revision for version 1.7
	ml.meaning Period_Status,
	fl2.meaning Summarized_Flag,
	-- Revision for version 1.1
	opm_status.period_status_tl OPM_Period_Status,
coalesce(
	(select	max(hoh.organization_hierarchy_name) organization_hierarchy_name
	 from	hrfv_organization_hierarchies hoh
	 where	hoh.organization_hierarchy_name= '&p_hierarchy_name'
	 and	(mp.organization_id = hoh.child_organization_id or mp.organization_id = hoh.parent_organization_id)
	),
	(select	max(hoh.organization_hierarchy_name) organization_hierarchy_name
	 from	hrfv_organization_hierarchies hoh
	 where	regexp_like(hoh.organization_hierarchy_name,'&p_name_open|&p_name_close|&p_name_period','i')
	 and	(mp.organization_id = hoh.child_organization_id or mp.organization_id = hoh.parent_organization_id)
	)
) hierarchy_name,
 xxen_util.user_name(oap.created_by) created_by,
 xxen_util.client_time(oap.creation_date) creation_date,
 xxen_util.user_name(oap.last_updated_by) last_updated_by,
 xxen_util.client_time(oap.last_update_date) last_update_date
from	org_acct_periods oap,
	mtl_parameters mp,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	-- Revision for version 1.7
	mfg_lookups ml,
	fnd_application_vl fav,
	-- Revision for version 1.8
	fnd_product_installations fpi,
	fnd_lookups fl2,
	-- Revision for version 1.10
	(select flvv.lookup_code,
		flvv.meaning
	 from	fnd_lookup_values_vl flvv
	 where	flvv.lookup_type  = 'CLOSING_STATUS'
	 and	flvv.lookup_code in ('C','N','O')
	 and	flvv.view_application_id = 101
	 union
	 select flvv2.lookup_code,
		flvv2.meaning
	 from	fnd_lookup_values_vl flvv2
	 where	flvv2.lookup_type  = 'AUTHORIZATION STATUS'
	 and	flvv2.lookup_code  = 'ALL'
	 and	flvv2.view_application_id = 201
	) period_status,
	(select	hoi.organization_id,
		gps.period_code,
		gps.start_date,
		gps.period_status,
		flvv.meaning period_status_tl
	 from	mtl_parameters mp2,
		gmf_fiscal_policies gfp,
		gmf_period_statuses gps,
		-- Revision for version 1.7 and 1.10
		fnd_lookup_values_vl flvv,
		hr_organization_information hoi,
		hr_all_organization_units haou        -- inv_organization_id
	 where	hoi.org_information_context = 'Accounting Information'
	 and	hoi.organization_id         = haou.organization_id -- this gets the organization name
	 and	gfp.legal_entity_id         = to_number(hoi.org_information2)
	 and	gps.legal_entity_id         = gfp.legal_entity_id
	 and	gps.cost_type_id            = gfp.cost_type_id
	 and	hoi.organization_id         = mp2.organization_id
	 and	flvv.lookup_type             = 'CLOSING_STATUS'
	 and	flvv.view_application_id     = 101 -- don't want duplicate rows
	 and	flvv.lookup_code             = gps.period_status
	 and	mp2.process_enabled_flag = 'Y') opm_status
where	mp.organization_id          = oap.organization_id									   -- p_period_name
-- Revision for version 1.7
and	fav.application_id          = 401 -- Inventory
-- Revision for version 1.8, only report installed applications
and	fav.application_id          = fpi.application_id
and	fpi.status                 <> 'N' -- Inactive
-- ===================================================================
-- Lookup values
-- ===================================================================
and	5=5			-- p_report_period_option
and	fl2.lookup_type             = 'YES_NO'
and	fl2.lookup_code             = nvl(oap.summarized_flag, 'N')
and	ml.lookup_type              = 'MTL_ACCT_PERIOD_STATUS'
and	ml.lookup_code              = 
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
-- ===================================================================
-- Using the base tables to avoid org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id -- this gets the organization name
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
-- avoid selecting item master orgs
and	mp.master_organization_id  <> mp.organization_id
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- this gets the ledger id
and	1=1				-- p_ledger, p_operating_unit, p_functional_area, p_period_name
and	oap.organization_id         = opm_status.organization_id(+)
and	oap.period_start_date       = opm_status.start_date(+)
--Report Option Logic
-- Revision for version 1.10
and	((oap.open_flag                      = decode(period_status.lookup_code,
						'O', 'Y',
						'C', 'N',
						'N', 'X',
						oap.open_flag))
	  or
	 (nvl(opm_status.period_status, 'Z') = decode(period_status.lookup_code,
						'O', 'Y',
						'C', 'C',
						'N', 'X',
						 opm_status.period_status))
	  or
	 (nvl(opm_status.period_status, 'Z') = decode(period_status.lookup_code,
						'O', 'F',
						'X'))
	  -- Revision for version 1.4
	  or
	 (nvl(oap.summarized_flag,'N')       = decode(period_status.lookup_code,
						'O', 'N',
						'C', 'Y',
						'N', 'X',
						nvl(oap.summarized_flag,'N')))
	)
	-- Period Statuses
	-- 0   - Open
	-- C   - Closed
	-- N   - Never Opened
	-- ALL - All Period Statuses
-- =====================================================================
-- Show accounting periods which should be open but was never opened.
-- If an inventory accounting period was never opened it will not exist
-- in the inventory period calendar, will not be in org_acct_periods.
-- =====================================================================
union all
select	fav.application_name Functional_Area,
	gp.period_name Period_Name,
	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	haou.name Organization_Name,
	-- Revision for version 1.7
	flvv.meaning Period_Status, -- 'Never Opened'
	'' Summarized_Flag, 
	-- Revision for version 1.1
	'' OPM_Period_Status,
coalesce(
	(select	max(hoh.organization_hierarchy_name) organization_hierarchy_name
	 from	hrfv_organization_hierarchies hoh
	 where	hoh.organization_hierarchy_name= '&p_hierarchy_name'
	 and	(mp.organization_id = hoh.child_organization_id or mp.organization_id = hoh.parent_organization_id)
	),
	(select	max(hoh.organization_hierarchy_name) organization_hierarchy_name
	 from	hrfv_organization_hierarchies hoh
	 where	regexp_like(hoh.organization_hierarchy_name,'&p_name_open|&p_name_close|&p_name_period','i')
	 and	(mp.organization_id = hoh.child_organization_id or mp.organization_id = hoh.parent_organization_id)
	)
) hierarchy_name,
 to_number(null) created_by,
 to_date(null) creation_date,
 to_number(null) last_updated_by,
 to_date(null) last_update_date
from	gl_periods gp,
	mtl_parameters mp,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	-- Revision for version 1.7 and 1.10
	fnd_lookup_values_vl flvv,
	(select flvv.lookup_code,
		flvv.meaning
	 from	fnd_lookup_values_vl flvv
	 where	flvv.lookup_type  = 'CLOSING_STATUS'
	 and	flvv.lookup_code in ('C','N','O')
	 and	flvv.view_application_id = 101
	 union
	 select flvv2.lookup_code,
		flvv2.meaning
	 from	fnd_lookup_values_vl flvv2
	 where	flvv2.lookup_type  = 'AUTHORIZATION STATUS'
	 and	flvv2.lookup_code  = 'ALL'
	 and	flvv2.view_application_id = 201
	) period_status,
	fnd_application_vl fav,
	-- Revision for version 1.8
	fnd_product_installations fpi
where	gp.period_set_name          = gl.period_set_name
-- Revision for version 1.7
and	fav.application_id          = 401 -- Inventory
-- Revision for version 1.8, only report installed applications
and	fav.application_id          = fpi.application_id
and	fpi.status                 <> 'N' -- Inactive
-- ===================================================================
-- Using base tables to avoid org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id -- this gets the organization name
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
-- avoid selecting item master orgs
and	mp.master_organization_id  <> mp.organization_id
-- avoid selecting inventory orgs created after the period end date
-- for reporting against prior accounting periods
and	gp.end_date                >= mp.creation_date
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- this gets the ledger id
and	2=2                         -- p_ledger, p_operating_unit, p_functional_area, p_period_name
-- ===================================================================
-- Lookup values
-- ===================================================================
and	5=5			-- p_report_period_option
and	flvv.lookup_type            = 'CLOSING_STATUS'
and	flvv.view_application_id    = 101 -- don't want duplicate rows
and	flvv.lookup_code            = 'N' -- Never Opened
-- ===================================================================
-- Check to see if the accounting period already exists in the
-- inventory calendar, in org_acct_periods
-- ===================================================================
and	not exists
	(select	'x'
	 from	org_acct_periods oap
	 where	oap.organization_id = mp.organization_id
	 and	3=3) -- p_period_name
--Report Option Logic
-- Revision for version 1.10
and	'Y'                         = decode(period_status.lookup_code, 'N','Y','ALL','Y','N')
	-- Period Statuses
	-- 0   - Open
	-- C   - Closed
	-- N   - Never Opened
	-- ALL - All Period Statuses
-- =====================================================================
-- General Ledger, Lease Management, Payables, Projects, Purchasing, Receivables 
-- =====================================================================
union all
select	fav.application_name Functional_Area,
	gps.period_name Period_Name,
	nvl(gl.short_name, gl.name) Ledger,
	haou.name Operating_Unit,
	'' Org_Code,
	'' Organization_Name,
	-- Revision for version 1.7
	flvv.meaning Period_Status, 
	'' Summarized_Flag,
	-- Revision for version 1.1
	'' OPM_Period_Status,
	'' Hierarchy_Name,
 xxen_util.user_name(gps.created_by) created_by,
 xxen_util.client_time(gps.creation_date) creation_date,
 xxen_util.user_name(gps.last_updated_by) last_updated_by,
 xxen_util.client_time(gps.last_update_date) last_update_date
from	gl_period_statuses gps,
	-- Revision for version 1.7 and 1.10
	fnd_lookup_values_vl flvv,
	(select flvv.lookup_code,
		flvv.meaning
	 from	fnd_lookup_values_vl flvv
	 where	flvv.lookup_type  = 'CLOSING_STATUS'
	 and	flvv.lookup_code in ('C','N','O')
	 and	flvv.view_application_id = 101
	 union
	 select flvv2.lookup_code,
		flvv2.meaning
	 from	fnd_lookup_values_vl flvv2
	 where	flvv2.lookup_type  = 'AUTHORIZATION STATUS'
	 and	flvv2.lookup_code  = 'ALL'
	 and	flvv2.view_application_id = 201
	) period_status,
	fnd_application_vl fav,
	-- Revision for version 1.8
	fnd_product_installations fpi,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	gl_ledgers gl
where	gps.application_id          = fav.application_id
and	fav.application_short_name in ('SQLAP','SQLGL','AR','OKL','PO','PA')
-- Revision for version 1.8, only report installed applications
and	fav.application_id          = fpi.application_id
and	fpi.status                 <> 'N' -- Inactive
-- ===================================================================
-- Lookup values
-- ===================================================================
and	5=5			-- p_report_period_option
and	flvv.lookup_type            = 'CLOSING_STATUS'
and	flvv.lookup_code            = gps.closing_status
and	flvv.view_application_id    = 101 -- don't want duplicate rows
-- ===================================================================
-- Using the base hr organization tables
-- ===================================================================
and	gl.ledger_id                = gps.ledger_id
and	hoi.org_information_context = 'Operating Unit Information'
and	hoi.organization_id         = haou.organization_id -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information3) -- this joins OU to GL
and	4=4                         -- p_ledger, p_operating_unit, p_functional_area, p_period_name
--Report Option Logic
-- Revision for version 1.10
and	gps.closing_status = decode(period_status.lookup_code,
					'O', 'O',
					'C', 'C',
					'N', 'N',
					'ALL', gps.closing_status,
					'X')
-- order by Functional_Area, Period, Ledger, Operating_Unit, Org_Code
order by 1,2,3,4,5