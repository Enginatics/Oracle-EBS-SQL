/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Standard Cost Update Submissions
-- Description: Report to show the Standard Cost Update submissions, by Cost Update Date. Including the parameters used and the overall inventory and WIP adjustment values.
-- Parameters:
-- Cost Update Date From: starting cost update date, based on standard cost submission history (required).
-- Cost Update Date To: ending cost update date, based on standard cost submission history (required).
-- From Cost Type: enter the cost type implemented by the Standard Cost Update into the Frozen costs (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2023 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxcostupdatesubmissionsrept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 28 Sep 2023 Douglas Volz Initial coding
-- -- | 1.1 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-standard-cost-update-submissions/
-- Library Link: https://www.enginatics.com/reports/cac-standard-cost-update-submissions/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
ccu.update_date cost_update_date,
ccu.cost_update_id,
xxen_util.user_name(ccu.created_by) cost_update_created_by,
ccu.request_id cost_update_request_id,
cct.cost_type from_cost_type,
ccu.description cost_update_description,
xxen_util.meaning(ccu.status,'CST_COST_UPDATE_STATUS',700) cost_update_status,
xxen_util.meaning(ccu.range_option,'CST_ITEM_RANGE',700) cost_update_range,
msiv.concatenated_segments specific_item_number,
msiv.description specific_item_description,
ccu.item_range_low,
ccu.item_range_high,
(select mcsv.category_set_name from mtl_category_sets_vl mcsv where ccu.category_set_id=mcsv.category_set_id) category_set,
(select mcv.category_concat_segs from mtl_categories_v mcv where ccu.category_id=mcv.category_id) category_name,
gl.currency_code,
ccu.inventory_adjustment_value total_onhand_adjustments,
ccu.intransit_adjustment_value total_intransit_adjustments,
ccu.wip_adjustment_value total_wip_adjustments,
ccu.scrap_adjustment_value total_scrap_adjustments,
xxen_util.yes(decode(ccu.snapshot_saved_flag,1,'Y')) details_saved,
xxen_util.yes(decode(ccu.update_resource_ovhd_flag,1,'Y')) updated_resources_overheads,
xxen_util.yes(decode(ccu.update_activity_flag,1,'Y')) updated_activity_costs,
&segment_columns
gcc.concatenated_segments adjustment_account
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_cost_updates ccu,
cst_cost_types cct,
mtl_system_items_vl msiv,
gl_code_combinations_kfv gcc
where
1=1 and
2=2 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=ccu.organization_id and
ccu.cost_type_id=cct.cost_type_id and
ccu.single_item=msiv.inventory_item_id(+) and
ccu.organization_id=msiv.organization_id(+) and
ccu.inv_adjustment_account=gcc.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
cost_update_date,
ccu.cost_update_id
