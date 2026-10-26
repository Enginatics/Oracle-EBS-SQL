/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Organization Summary
-- Description: Report to show inventory org names, summary org controls, org hierarchy, operating unit and Ledger, and whether or not the Org should be rolled up for costing, based on the existence of BOMs, routings or org-level sourcing rules.
-- Note: this report automatically looks for hierarchies which might be used with the Open Period Control and the Close Period Control Oracle programs. Looking for the translated values of "Close", "Open" and "Period" in the Hierarchy Name.
-- Parameters:
-- ==========
-- Assignment Set: choose the Assignment Set to report for sourcing rules. You may leave this value null and the report still works (optional).
-- Hierarchy Name: select the organization hierarchy used to open and close your inventory organizations (optional). If you leave this field blank the report automatically looks for hierarchies which might be used with the Open Period Control and the Close Period Control Oracle programs. Looking for the translated values of "Close", "Open" and "Period" in the Hierarchy Name.
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2010-2025 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- | 1.31 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 14 Apr 2010 Douglas Volz Initial Coding
-- -- | 1.19 09 Jul 2019 Douglas Volz Changed Org Hierarchy logic to look only for Hierarchy
-- -- | Names with "Open" or "Close" or "Period" in it.
-- -- | For the 2nd union all, added an Outer Join to OU:
-- -- | and haou2.organizationid (+) = tonumber(hoi.orginformation3)
-- -- | ... found an inventory org in Vision with no OU
-- -- | 1.20 16 Jan 2020 Douglas Volz Added Ledger, Operating Unit and Org Code parameters.
-- -- | 1.21 02 Feb 2020 Douglas Volz Added max material and WIP transaction dates and removed
-- -- | flv.sourcelang joins, not needed.
-- -- | 1.22 08 Mar 2020 Douglas Volz Checking for a routing for the parent org
-- -- | 1.23 07 Apr 2020 Douglas Volz Consolidated two (union all) statements into one.
-- -- | 1.24 27 Apr 2020 Douglas Volz Changed to multi-language views for the
-- -- | inventory orgs and operating units.
-- -- | 1.25 29 Jun 2022 Douglas Volz Fixed indicator for category accounts.
-- -- | 1.26 09 Sep 2022 Douglas Volz Added indicator for PAC Enabled.
-- -- | 1.27 13 Jul 2023 Douglas Volz Added condition to avoid SQL error, single-row subquery
-- -- | returns more than one row.
-- -- | 1.28 01 Nov 2024 Douglas Volz Added BOM Parameters, Use Phantom Routing column.
-- -- | 1.29 01 Jan 2025 Douglas Volz Added WIP Parameters, Record Scrap column.
-- -- | 1.30 15 Feb 2025 Douglas Volz Added Oracle Release Number.
-- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-inventory-organization-summary/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-organization-summary/
-- Run Report: https://demo.enginatics.com/

select
(select max(fpg.release_name) from fnd_product_groups fpg) oracle_release,
nvl(gl.short_name,gl.name) ledger,
gl.currency_code curr_code,
haouv_ou.name operating_unit,
mp.organization_code org_code,
haouv.name organization_name,
xxen_util.yes(hoi_class.org_information2) inv_org,
mp.organization_id org_id,
h.hierarchy_origin,
h.parent_org_code,
h.hierarchy_name,
haouv.date_to disable_date,
xxen_util.yes(case when mp.organization_id in (select oa.organization_id from org_access oa, fnd_responsibility fr where nvl(oa.disable_date,sysdate+1)>=sysdate and oa.resp_application_id=fr.application_id and oa.responsibility_id=fr.responsibility_id) then 'Y' end) on_org_access,
xxen_util.yes(case when (mp.organization_id,haouv_ou.organization_id) in (select ospa.master_organization_id, ospa.org_id from oe_system_parameters_all ospa) then 'Y' end) val_org,
xxen_util.yes(mp.process_enabled_flag) process_costing,
xxen_util.yes(case when mp.organization_id in (select ccga.organization_id from cst_cost_group_assignments ccga, cst_cost_groups ccg where ccga.cost_group_id=ccg.cost_group_id and ccg.legal_entity is not null) then 'Y' end) pac_enabled,
mp.cost_cutoff_date cost_cut_off_date,
(select br.resource_code from bom_resources br where mp.default_material_cost_id=br.resource_id) default_matl_sub_element,
(select br.resource_code from bom_resources br where mp.mat_ovhd_cost_type_id=br.resource_id) default_moh_sub_element,
xxen_util.yes(
case
when mp.process_enabled_flag='Y' and mp.organization_id in (select grb.owner_organization_id from gmd_recipes_b grb) then 'Y'
when nvl(mp.process_enabled_flag,'N')='N' and mp.organization_id in (select bsb.organization_id from bom_structures_b bsb where bsb.alternate_bom_designator is null) then 'Y'
end) bom_or_recipe,
xxen_util.yes(
case
when mp.process_enabled_flag='Y' and mp.organization_id in (select grb.owner_organization_id from gmd_recipes_b grb where grb.routing_id is not null) then 'Y'
when nvl(mp.process_enabled_flag,'N')='N' and mp.organization_id in (select bor.organization_id from bom_operational_routings bor) then 'Y'
end) routing,
xxen_util.yes(case when mp.organization_id in (select bp.organization_id from bom_parameters bp where bp.use_phantom_routings=1) then 'Y' end) use_phantom_routings,
xxen_util.yes(case when mp.organization_id in (select msa.organization_id from mrp_assignment_sets mas, mrp_sr_assignments msa, mrp_sr_receipt_org msro, mrp_sr_source_org msso where 2=2 and mas.assignment_set_id=msa.assignment_set_id and msa.sourcing_rule_id=msro.sourcing_rule_id and msro.sr_receipt_id=msso.sr_receipt_id and msso.source_organization_id is not null) then 'Y' end) sourcing_rule,
xxen_util.yes(
case
when mp.process_enabled_flag='Y' and mp.organization_id in (select gic.organization_id from gl_item_cst gic, cm_mthd_mst cmm where gic.cost_type_id=cmm.cost_type_id and cmm.cost_mthd_code in ('FROZEN','STANDARD','STD','STND','PWAC','PPAC','PMAC') and cmm.cost_type_id in (select gfp.cost_type_id from gmf_fiscal_policies gfp) and gic.acctg_cost<>0) then 'Y'
when nvl(mp.process_enabled_flag,'N')='N' and (mp.organization_id,mp.primary_cost_method) in (select cic.organization_id, cic.cost_type_id from cst_item_costs cic where cic.item_cost<>0) then 'Y'
end) has_frozen_or_avg_costs,
xxen_util.yes(
case
when mp.process_enabled_flag='Y' and mp.organization_id in (select gic.organization_id from gl_item_cst gic, cm_mthd_mst cmm where gic.cost_type_id=cmm.cost_type_id and cmm.cost_mthd_code='PENDING' and cmm.cost_type_id in (select gfp.cost_type_id from gmf_fiscal_policies gfp) and gic.acctg_cost<>0) then 'Y'
when nvl(mp.process_enabled_flag,'N')='N' and mp.organization_id in (select cic.organization_id from cst_item_costs cic where cic.cost_type_id=3 and cic.item_cost<>0) then 'Y'
end) has_pending_costs,
xxen_util.yes(case when mp.organization_id in (select moqd.organization_id from mtl_onhand_quantities_detail moqd) then 'Y' end) has_onhand,
(select max(mmt.transaction_date) from mtl_material_transactions mmt where mp.organization_id=mmt.organization_id) last_material_txn_date,
(select max(wta.transaction_date) from wip_transaction_accounts wta where mp.organization_id=wta.organization_id and nvl(mp.process_enabled_flag,'N')='N') last_wip_txn_date,
xxen_util.yes(case when mp.organization_id in (select wp.organization_id from wip_parameters wp where wp.mandatory_scrap_flag=1) then 'Y' end) mandatory_scrap,
mp_master.organization_code item_master_org,
xxen_util.meaning(mp.primary_cost_method,'MTL_PRIMARY_COST',700) costing_method,
xxen_util.yes(decode(mp.negative_inv_receipt_code,1,'Y')) allow_negatives,
xxen_util.yes(decode(mp.cost_group_accounting,1,'Y')) cost_group_accounting,
xxen_util.yes(case when mp.enable_costing_by_category='Y' or mp.organization_id in (select mca.organization_id from mtl_category_accounts mca) then 'Y' end) cost_by_category_enabled,
xxen_util.yes(case when mp.organization_id in (select pop.organization_id from pjm_org_parameters pop) then 'Y' end) project_mfg_enabled,
xxen_util.yes(mp.lcm_enabled_flag) lcm_enabled,
xxen_util.yes(mp.eam_enabled_flag) eam_enabled,
xxen_util.yes(mp.wms_enabled_flag) wms_enabled,
xxen_util.yes(case when mp.organization_id in (select wp.organization_id from wsm_parameters wp) then 'Y' end) wsm_shopfloor_enabled,
decode(mp.general_ledger_update_code,1,'Detail',2,'Summary') transfer_to_gl,
xxen_util.meaning(pspa.inventory_accrual_code,'INVENTORY ACCRUAL OPTION',201) accrue_inventory,
xxen_util.meaning(pspa.expense_accrual_code,'EXPENSE ACCRUAL OPTION',201) accrue_expense,
xxen_util.yes(case when mp.organization_id in (select capr.inventory_organization_id from cst_ap_po_reconciliation capr) then 'Y' end) use_payables_accruals,
xxen_util.yes(case when mp.organization_id in (select cms.organization_id from cst_margin_summary cms) then 'Y' end) use_margin_reports,
mp.creation_date,
mp.last_update_date,
xxen_util.user_name(mp.last_updated_by) last_updated_by
from
mtl_parameters mp,
mtl_parameters mp_master,
hr_organization_information hoi,
hr_organization_information hoi_class,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
po_system_parameters_all pspa,
(
select
hoh.child_organization_id organization_id,
max(hoh.parent_organization_name) keep (dense_rank first order by hoh.organization_hierarchy_name,mp.organization_code) hierarchy_origin,
max(mp.organization_code) keep (dense_rank first order by hoh.organization_hierarchy_name,mp.organization_code) parent_org_code,
min(hoh.organization_hierarchy_name) hierarchy_name
from
hrfv_organization_hierarchies hoh,
mtl_parameters mp
where
(regexp_like(hoh.organization_hierarchy_name,'&p_name_open|&p_name_close|&p_name_period','i') or hoh.organization_hierarchy_name='&p_org_hierarchy_name') and
hoh.parent_organization_id=mp.organization_id
group by
hoh.child_organization_id
) h
where
1=1 and
mp.master_organization_id=mp_master.organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
mp.organization_id=hoi_class.organization_id and
hoi_class.org_information_context='CLASS' and
hoi_class.org_information1='INV' and
hoi.organization_id=haouv.organization_id and
to_number(hoi.org_information3)=haouv_ou.organization_id(+) and
to_number(hoi.org_information1)=gl.ledger_id and
haouv_ou.organization_id=pspa.org_id(+) and
mp.organization_id=h.organization_id(+)
order by
oracle_release,
curr_code,
operating_unit,
org_id
