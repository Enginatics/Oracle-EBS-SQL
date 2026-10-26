/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item Cost Break-Out by Activity
-- Description: Report to show item costs by cost element, by activity. Using up to five entered activities. In order for this report to show your activity costs you must first define your activities and then associate your sub-elements by activity.
-- / +=============================================================================+
-- -- | Copyright 2009-2022 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxitemcostbreakoutbyactivityrept.sql
-- -- |
-- -- | Parameters:
-- - | pcosttype -- The cost type you wish to report
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- | pitemnumber -- Enter the specific item number you wish to report
-- -- | pactivity1 -- First activity to report
-- -- | pactivity2 -- Second activity to report
-- -- | pactivity3 -- Third activity to report
-- -- | pactivity4 -- Fourth activity to report
-- -- | pactivity5 -- Fifth activity to report
-- -- | pcategoryset1 -- The first item category set to report, typically the
-- -- | Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the
-- -- | Inventory Category Set
-- -- |
-- -- | Description:
-- -- | Report to show Frozen costs in the Frozen cost type, by activity. Using
-- -- | up to six parameters activities.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ====== =========== ============== =========================================
-- -- | 1.0 08 Nov 2016 Douglas Volz Initial Coding based on XXXITEMCOSTREPT.sql\
-- -- | Hard-coded for activities starting with S (Sort),
-- -- | A (Assembly), T (Test), BE (Back-End) or UNASSIGNED.
-- -- | 1.1 09 Nov 2016 Douglas Volz Added PL item costs with no sub-element (resourceid)
-- -- | 1.2 10 Nov 2016 Douglas Volz Added Business Code, Product Family and
-- -- | Product Type item categories
-- -- | 1.3 18 Nov 2016 Douglas Volz Modified to use the Resource Activity assignments
-- -- | 1.4 21 Jan 2017 Douglas Volz Changed the report to assume that all
-- -- | resources have been assigned to an activity
-- -- | 1.5 07 Sep 2019 Douglas Volz Reported activities are now parameters.
-- -- | Up to five activity parameters.
-- -- | 1.6 09 Sep 2019 Douglas Volz Added a max(mc.segment1) for the category
-- -- | column select statements due to having
-- -- | multiple category values for the same org,
-- -- | item and category set id (Inventory).
-- -- | 1.7 27 Jan 2020 Douglas Volz Added Operating Unit and Org Code parameters.
-- -- | 1.8 02 Jul 2022 Douglas Volz Change for multi-language and lookup types.
-- -- | 1.9 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-item-cost-break-out-by-activity/
-- Library Link: https://www.enginatics.com/reports/cac-item-cost-break-out-by-activity/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
cct.cost_type,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.primary_uom_code uom_code,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
xxen_util.yes(msiv.costing_enabled_flag) allow_costs,
xxen_util.yes(decode(cic.inventory_asset_flag,1,'Y')) inventory_asset,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
cic.shrinkage_rate,
gl.currency_code,
nvl(cic.material_cost,0) material_cost,
round(nvl(x.resource1,0),5) "Resource &p_activity1 Amount",
round(nvl(x.osp1,0),5) "OSP &p_activity1 Amount",
round(nvl(x.overhead1,0),5) "Overhead &p_activity1 Amount",
round(nvl(x.resource2,0),5) "Resource &p_activity2 Amount",
round(nvl(x.osp2,0),5) "OSP &p_activity2 Amount",
round(nvl(x.overhead2,0),5) "Overhead &p_activity2 Amount",
round(nvl(x.resource3,0),5) "Resource &p_activity3 Amount",
round(nvl(x.osp3,0),5) "OSP &p_activity3 Amount",
round(nvl(x.overhead3,0),5) "Overhead &p_activity3 Amount",
round(nvl(x.resource4,0),5) "Resource &p_activity4 Amount",
round(nvl(x.osp4,0),5) "OSP &p_activity4 Amount",
round(nvl(x.overhead4,0),5) "Overhead &p_activity4 Amount",
round(nvl(x.resource5,0),5) "Resource &p_activity5 Amount",
round(nvl(x.osp5,0),5) "OSP &p_activity5 Amount",
round(nvl(x.overhead5,0),5) "Overhead &p_activity5 Amount",
round(nvl(x.other_overhead,0),5) other_overhead_amounts,
round(nvl(x.unassigned_resource,0),5) unassigned_resource_amount,
round(nvl(x.unassigned_osp,0),5) unassigned_osp_amount,
round(nvl(x.tl_material_overhead,0),5) tl_material_overhead,
round(nvl(x.pl_material_overhead,0),5) pl_material_overhead,
round(nvl(x.tl_resource_no_subelement,0),5) tl_resource_no_subelement,
round(nvl(x.pl_resource_no_subelement,0),5) pl_resource_no_subelement,
round(nvl(x.tl_osp_no_subelement,0),5) tl_osp_no_subelement,
round(nvl(x.pl_osp_no_subelement,0),5) pl_osp_no_subelement,
round(nvl(x.tl_overhead_no_subelement,0),5) tl_overhead_no_subelement,
round(nvl(x.pl_overhead_no_subelement,0),5) pl_overhead_no_subelement,
nvl(cic.material_cost,0) material_cost,
nvl(cic.material_overhead_cost,0) material_overhead_cost,
nvl(cic.resource_cost,0) resource_cost,
nvl(cic.outside_processing_cost,0) outside_processing_cost,
nvl(cic.overhead_cost,0) overhead_cost,
nvl(cic.item_cost,0) item_cost,
cic.creation_date cost_creation_date,
cic.last_update_date last_cost_update_date
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_item_costs cic,
cst_cost_types cct,
mtl_system_items_vl msiv,
(
select
cicd.organization_id,
cicd.inventory_item_id,
cicd.cost_type_id,
sum(case when br.cost_element_id=3 and ca.activity_id is not null and 1=1 then cicd.item_cost end) resource1,
sum(case when br.cost_element_id=4 and ca.activity_id is not null and 1=1 then cicd.item_cost end) osp1,
sum(case when br.cost_element_id=5 and ca.activity_id is not null and 1=1 then cicd.item_cost end) overhead1,
sum(case when br.cost_element_id=3 and ca.activity_id is not null and 2=2 then cicd.item_cost end) resource2,
sum(case when br.cost_element_id=4 and ca.activity_id is not null and 2=2 then cicd.item_cost end) osp2,
sum(case when br.cost_element_id=5 and ca.activity_id is not null and 2=2 then cicd.item_cost end) overhead2,
sum(case when br.cost_element_id=3 and ca.activity_id is not null and 3=3 then cicd.item_cost end) resource3,
sum(case when br.cost_element_id=4 and ca.activity_id is not null and 3=3 then cicd.item_cost end) osp3,
sum(case when br.cost_element_id=5 and ca.activity_id is not null and 3=3 then cicd.item_cost end) overhead3,
sum(case when br.cost_element_id=3 and ca.activity_id is not null and 4=4 then cicd.item_cost end) resource4,
sum(case when br.cost_element_id=4 and ca.activity_id is not null and 4=4 then cicd.item_cost end) osp4,
sum(case when br.cost_element_id=5 and ca.activity_id is not null and 4=4 then cicd.item_cost end) overhead4,
sum(case when br.cost_element_id=3 and ca.activity_id is not null and 5=5 then cicd.item_cost end) resource5,
sum(case when br.cost_element_id=4 and ca.activity_id is not null and 5=5 then cicd.item_cost end) osp5,
sum(case when br.cost_element_id=5 and ca.activity_id is not null and 5=5 then cicd.item_cost end) overhead5,
sum(case when br.cost_element_id=5 and br.resource_code not in ('PII','ICP') and (ca.activity is null or ca.activity not in (nvl(:p_activity1,'~'),nvl(:p_activity2,'~'),nvl(:p_activity3,'~'),nvl(:p_activity4,'~'),nvl(:p_activity5,'~'))) then cicd.item_cost end) other_overhead,
sum(case when br.cost_element_id=3 and nvl(ca.activity,'UNASSIGNED')='UNASSIGNED' then cicd.item_cost end) unassigned_resource,
sum(case when br.cost_element_id=4 and nvl(ca.activity,'UNASSIGNED')='UNASSIGNED' then cicd.item_cost end) unassigned_osp,
sum(case when cicd.cost_element_id=2 and cicd.level_type=1 then cicd.item_cost end) tl_material_overhead,
sum(case when cicd.cost_element_id=2 and cicd.level_type=2 then cicd.item_cost end) pl_material_overhead,
sum(case when cicd.cost_element_id=3 and cicd.level_type=1 and cicd.resource_id is null then cicd.item_cost end) tl_resource_no_subelement,
sum(case when cicd.cost_element_id=3 and cicd.level_type=2 and cicd.resource_id is null then cicd.item_cost end) pl_resource_no_subelement,
sum(case when cicd.cost_element_id=4 and cicd.level_type=1 and cicd.resource_id is null then cicd.item_cost end) tl_osp_no_subelement,
sum(case when cicd.cost_element_id=4 and cicd.level_type=2 and cicd.resource_id is null then cicd.item_cost end) pl_osp_no_subelement,
sum(case when cicd.cost_element_id=5 and cicd.level_type=1 and cicd.resource_id is null then cicd.item_cost end) tl_overhead_no_subelement,
sum(case when cicd.cost_element_id=5 and cicd.level_type=2 and cicd.resource_id is null then cicd.item_cost end) pl_overhead_no_subelement
from
cst_cost_types cct,
cst_item_cost_details cicd,
bom_resources br,
cst_activities ca
where
6=6 and
cct.cost_type_id=cicd.cost_type_id and
cicd.resource_id=br.resource_id(+) and
br.default_activity_id=ca.activity_id(+)
group by
cicd.organization_id,
cicd.inventory_item_id,
cicd.cost_type_id
) x
where
6=6 and
7=7 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=cic.organization_id and
cic.cost_type_id=cct.cost_type_id and
cic.organization_id=msiv.organization_id and
cic.inventory_item_id=msiv.inventory_item_id and
cic.organization_id=x.organization_id(+) and
cic.inventory_item_id=x.inventory_item_id(+) and
cic.cost_type_id=x.cost_type_id(+)
order by
ledger,
operating_unit,
org_code,
cct.cost_type,
item_number
