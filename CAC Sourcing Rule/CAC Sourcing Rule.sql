/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Sourcing Rule
-- Description: Report the sourcing rules for all or a selected assignment set, along with with the item's make / buy flag and based on rollup flag for costing.  You can either choose Organization or Vendor (Supplier) sourcing rules or get all sourcing rules by not selecting a sourcing rule type.

/* +=============================================================================+
-- |  Copyright 2010 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_sourcing_rule_rept.sql
-- |
-- |  Parameters:
-- |  
-- |  p_assignment_set       - Name of the assignment set to report (mandatory)
-- |                           You can enter a null or valid assignment set name.
-- |  p_sourcing_rule_type   - Organization, Vendor or both types of sourcing rules.
-- |                         
-- |  Description:
-- |  Use the below SQL script to report the sourcing rules for all or a selected
-- |  assignment set, along with with the item's make / buy flag and based on 
-- |  rollup flag for costing.  You can either choose Organization or Supplier 
-- |  (Vendor) sourcing rules.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     31 Mar 2010 Douglas Volz   Initial Coding
-- |  1.1     31 Mar 2010 Douglas Volz   Excluding old CIS orgs and excluding
-- |                                     transfers from 2xx to 3xx orgs
-- |  1.2     14 Apr 2010 Douglas Volz   Added Ledger, Operating Unit to report
-- |  1.3     26 Jul 2010 Douglas Volz   Added creation date to this report
-- |  1.4     28 Oct 2010 Douglas Volz   Cleaned up the column headings, removed
-- |                                     item cost information, added parameter for
-- |                                     only active items.
-- |  1.5     27 May 2015 Douglas Volz   Retrofit to Release 11i
-- |  1.6     18 Jun 2015 Douglas Volz   Get product group from Cost category set
-- |  1.7     18 Oct 2018 Douglas Volz   Exclude item statuses for Inactive.
-- |  1.8     28 Nov 2018 Douglas Volz   Added changes for Vendor sourcing rules
-- |  1.9     19 Jun 2019 Douglas Volz   Added the Inventory category set, changed to
-- |                                     G/L short name, for brevity.  Added Assignment
-- |                                     Set and Sourcing Rule Type parameters.
-- |                                     Added Item Type column.
-- |  1.10    27 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- |  1.11    09 Jul 2022 Douglas Volz   Change to multi-language item UOM and status.
+=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-sourcing-rule/
-- Library Link: https://www.enginatics.com/reports/cac-sourcing-rule/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
 	haou2.name Operating_Unit,
	:p_sourcing_rule_type Sourcing_Rule_Type,
	mp_to_org.organization_code To_Org, 
	-- Revision for version 1.8
	-- mp_src_org.organization_code Src_Org,
	mp_src_org.organization_code From_Org_or_Supplier,
	mas.assignment_set_name Assignment_Set,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.11
	muomv.uom_code UOM_Code,
	-- Revision for version 1.9
&category_columns
	msr.sourcing_rule_name Sourcing_Rule,
	msr.creation_date Creation_Date,
	msro.effective_date Effective_Date,
	msro.disable_date Disable_Date,
	-- Revision for version 1.9
	fcl.meaning Item_Type,
	-- Revision for version 1.11
	misv.inventory_item_status_code Item_Status,
	ml.meaning Make_Buy_Code,
	ml2.meaning Based_on_Rollup
from	mrp_sr_source_org msso,
	mrp_sr_receipt_org msro,
	mrp_sourcing_rules msr,
	mrp_sr_assignments msa,
	mrp_assignment_sets mas,
	mtl_system_items_vl msiv,
	-- Revision for version 1.11
	mtl_item_status_vl misv,
	mtl_units_of_measure_vl muomv,
	-- End revision for version 1.11
	cst_item_costs cic_to_org,
	mtl_parameters mp_to_org,
	mtl_parameters mp_src_org,
	mfg_lookups ml, 
	mfg_lookups ml2,
	-- Revision for version 1.9
	fnd_common_lookups fcl,
	-- Revision for version 1.10
	(select	flv.meaning sourcing_rule_type
	 from	fnd_lookup_values flv
	 where	flv.lookup_type = 'MSC_CRITERIA_FIELD_PROMPT'
	 and	flv.lookup_code in ('ORGANIZATION_CODE', ' SUPPLIER_ID')
	 and	flv.language = 'US'
	 and	flv.lookup_code =
		(select	fl2.lookup_code
		 from	fnd_lookups fl2 -- Original language
		 where	fl2.lookup_type = 'MSC_CRITERIA_FIELD_PROMPT'
		 and	fl2.lookup_code in ('ORGANIZATION_CODE', ' SUPPLIER_ID')
		 and	fl2.meaning     = :p_sourcing_rule_type
		)
	) flv,
	-- End revision for version 1.10
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit 
	gl_ledgers gl
-- ====================================
-- Sourcing_Rule Joins
-- ====================================
where	msso.sr_receipt_id              = msro.sr_receipt_id
and	msr.sourcing_rule_id            = msro.sourcing_rule_id
and	msa.sourcing_rule_id            = msr.sourcing_rule_id
and	msa.assignment_set_id           = mas.assignment_set_id
and	msiv.organization_id            = msa.organization_id
and	msiv.inventory_item_id          = msa.inventory_item_id
and	msiv.inventory_item_status_code <> 'Inactive'
-- Revision for version 1.11
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.11
-- Revision for version 1.9
and	1=1                             -- p_item_number, p_to_org_code, p_operating_unit, p_ledger
and	decode(flv.sourcing_rule_type,
		'Supplier', -999,
		'Org', msso.source_organization_id,
		null, msso.source_organization_id) = msso.source_organization_id
-- End revision for version 1.9	
-- ====================================
-- Lookup Code Joins
-- ====================================
and	msiv.planning_make_buy_code     = ml.lookup_code
and	ml.lookup_type                  = 'MTL_PLANNING_MAKE_BUY'
and	ml2.lookup_code                 = cic_to_org.based_on_rollup_flag
and	ml2.lookup_type                 = 'SYS_YES_NO'
-- Revision for version 1.9
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ====================================
-- Joins for to_org
-- ====================================
and	msiv.organization_id            = cic_to_org.organization_id
and	msiv.inventory_item_id          = cic_to_org.inventory_item_id
and	cic_to_org.cost_type_id         = mp_to_org.primary_cost_method
and	msiv.organization_id            = mp_to_org.organization_id
and	mp_src_org.organization_id      = msso.source_organization_id
-- ========================================================
-- Organization joins to the HR org model
-- ========================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp_to_org.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
-- ====================================
-- Revision for version 1.8
-- Get the Vendor Sourcing_Rules
-- ====================================
union all
select	nvl(gl.short_name, gl.name) Ledger,
 	haou2.name Operating_Unit,
	:p_sourcing_rule_type Sourcing_Rule_Type,
	mp_to_org.organization_code To_Org, 
	pv.vendor_name From_Org_or_Supplier,
	mas.assignment_set_name Assignment_Set,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.11
	muomv.uom_code UOM_Code,
	-- Revision for version 1.9
&category_columns
	msr.sourcing_rule_name Sourcing_Rule,
	msr.creation_date Creation_Date,
	msro.effective_date Effective_Date,
	msro.disable_date Disable_Date,
	-- Revision for version 1.9
	fcl.meaning Item_Type,
	-- Revision for version 1.11
	misv.inventory_item_status_code Item_Status,
	ml.meaning Make_Buy_Code,
	ml2.meaning Based_on_Rollup
from	mrp_sr_source_org msso,
	mrp_sr_receipt_org msro,
	mrp_sourcing_rules msr,
	mrp_sr_assignments msa,
	mrp_assignment_sets mas,
	mtl_system_items_vl msiv,
	-- Revision for version 1.11
	mtl_item_status_vl misv,
	mtl_units_of_measure_vl muomv,
	-- End revision for version 1.11
	cst_item_costs cic_to_org,
	mtl_parameters mp_to_org,
	po_vendors pv,
	mfg_lookups ml, 
	mfg_lookups ml2,
	-- Revision for version 1.9
	fnd_common_lookups fcl,
	-- Revision for version 1.10
	(select	flv.meaning sourcing_rule_type
	 from	fnd_lookup_values flv
	 where	flv.lookup_type = 'MSC_CRITERIA_FIELD_PROMPT'
	 and	flv.lookup_code in ('ORGANIZATION_CODE', ' SUPPLIER_ID')
	 and	flv.language = 'US'
	 and	flv.lookup_code =
		(select	fl2.lookup_code
		 from	fnd_lookups fl2 -- Original language
		 where	fl2.lookup_type = 'MSC_CRITERIA_FIELD_PROMPT'
		 and	fl2.lookup_code in ('ORGANIZATION_CODE', ' SUPPLIER_ID')
		 and	fl2.meaning     = :p_sourcing_rule_type
		)
	) flv,
	-- End revision for version 1.10
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit 
	gl_ledgers gl
-- ====================================
-- Sourcing_Rule Joins
-- ====================================
where	msso.sr_receipt_id              = msro.sr_receipt_id
and	msr.sourcing_rule_id            = msro.sourcing_rule_id
and	msa.sourcing_rule_id            = msr.sourcing_rule_id
and	msa.assignment_set_id           = mas.assignment_set_id
and	msiv.organization_id            = msa.organization_id
and	msiv.inventory_item_id          = msa.inventory_item_id
and	msiv.inventory_item_status_code <> 'Inactive'
-- Revision for version 1.11
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.11
-- Revision for version 1.9
and	1=1                             -- p_item_number, p_to_org_code, p_operating_unit, p_ledger
and	decode(flv.sourcing_rule_type,
	'Supplier', -1000,
	'Org', -999,
	null, -1000) = nvl(msso.source_organization_id, -1000)
-- End revision for version 1.9
-- ====================================
-- Lookup Code Joins
-- ====================================
and	msiv.planning_make_buy_code     = ml.lookup_code
and	ml.lookup_type                  = 'MTL_PLANNING_MAKE_BUY'
and	ml2.lookup_code                 = cic_to_org.based_on_rollup_flag
and	ml2.lookup_type                 = 'SYS_YES_NO'
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- End revision for version 1.9
-- ====================================
-- Joins for to_org
-- ====================================
and	msiv.organization_id            = cic_to_org.organization_id
and	msiv.inventory_item_id          = cic_to_org.inventory_item_id
and	cic_to_org.cost_type_id         = mp_to_org.primary_cost_method
and	msiv.organization_id            = mp_to_org.organization_id
-- ====================================
-- Vendor joins
-- ====================================
and	pv.vendor_id                    = msso.vendor_id
and	msso.source_organization_id is null
-- End revision for version 1.8
-- ========================================================
-- Organization joins to the HR org model
-- ========================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp_to_org.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
-- Order by Ledger, Operating_Unit, Sourcing_Rule_Type, To_Org, From_Org_or_Supplier, Assignment_Set and Item_Number
order by 1,2,3,4,5,6,7