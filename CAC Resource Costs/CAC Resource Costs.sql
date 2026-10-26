/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Resource Costs
-- Description: Report to show the resource and outside processing costs by organization and cost type.
-- Parameters:
-- Cost Type: enter the cost type you wish to report, defaults to your Costing Method (mandatory).
-- Include Non-Costed Resources: choose No to exclude non-costed resources, choose Yes to include them. You normally use non-costed resources for scheduling purposes (mandatory).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2006-2023 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxresourcecostsrept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 18 Nov 2010 Douglas Volz Initial Coding
-- -- | 1.1 15 Dec 2010 Douglas Volz Final Coding
-- -- | 1.2 28 Dec 2010 Douglas Volz Removed condition to omit Orgs 108, 109, 110
-- -- | and 331 as these may be used at any time
-- -- | 1.3 18 Nov 2015 Douglas Volz Removed organization restrictions
-- -- | 1.4 15 Nov 2016 Douglas Volz Added DFF for ResourceType, changed
-- -- | cancatenated segments to separate columns.
-- -- | 1.5 18 Nov 2016 Douglas Volz Added Activity to this report
-- -- | 1.6 16 Feb 2017 Douglas Volz Added CreationDate and Who Created
-- -- | 1.7 17 Feb 2017 Douglas Volz Add ResourceDescription
-- -- | 1.8 18 Sep 2019 Douglas Volz Added last update by and last update date
-- -- | 1.9 27 Jan 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, inventory orgs and operating units.
-- -- | 1.10 21 Jul 2021 Douglas Volz Add Basis Type, UOM Code and changed Allow
-- -- | Costs and Std Rate to lookup codes.
-- -- | 1.11 11 Oct 2023 Douglas Volz Modified for invalid created by, invalid
-- -- | last updated by and invalid codecombinationid
-- -- | values, to ensure resources are reported.
-- -- | Removed tabs and added inventory org access controls.
-- -- | Reversed revision 1.4, added back concatentated
-- -- | account number values.
-- -- | 1.12 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-resource-costs/
-- Library Link: https://www.enginatics.com/reports/cac-resource-costs/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
br.resource_code,
br.description resource_description,
cce.cost_element,
crc.cost_type,
gl.currency_code,
crc.resource_rate,
xxen_util.meaning(br.resource_type,'BOM_RESOURCE_TYPE',700) resource_type,
xxen_util.meaning(br.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) charge_type,
xxen_util.yes(decode(br.allow_costs_flag,1,'Y')) allow_costs,
br.unit_of_measure uom_code,
xxen_util.yes(decode(br.standard_rate_flag,1,'Y')) standard_rate,
msiv.concatenated_segments osp_item_number,
msiv.description osp_item_description,
(select ca.activity from cst_activities ca where br.default_activity_id=ca.activity_id) activity,
&segment_columns
gcc2.concatenated_segments absorption_account,
gcc1.concatenated_segments variance_account,
br.disable_date,
br.creation_date,
xxen_util.user_name(br.created_by) created_by,
br.last_update_date,
xxen_util.user_name(br.last_updated_by) last_updated_by
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
bom_resources br,
(
select
crc.resource_id,
cct.cost_type,
crc.resource_rate
from
cst_resource_costs crc,
cst_cost_types cct
where
1=1 and
crc.cost_type_id=cct.cost_type_id
) crc,
cst_cost_elements cce,
mtl_system_items_vl msiv,
gl_code_combinations_kfv gcc1,
gl_code_combinations_kfv gcc2
where
2=2 and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=br.organization_id and
br.resource_id=crc.resource_id(+) and
(br.allow_costs_flag=1 and crc.resource_id is not null or br.allow_costs_flag=2 and 3=3) and
br.cost_element_id=cce.cost_element_id(+) and
br.organization_id=msiv.organization_id(+) and
br.purchase_item_id=msiv.inventory_item_id(+) and
br.rate_variance_account=gcc1.code_combination_id(+) and
br.absorption_account=gcc2.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
br.resource_code
