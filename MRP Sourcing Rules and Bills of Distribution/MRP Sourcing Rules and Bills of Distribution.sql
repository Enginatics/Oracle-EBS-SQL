/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MRP Sourcing Rules and Bills of Distribution
-- Description: Sourcing rules for all or a selected assignment set, along with with the item's make / buy flag and based on rollup flag for costing. You can either choose Organization or Vendor (Supplier) sourcing rules or get all sourcing rules by not selecting a sourcing rule type.
-- Excel Examle Output: https://www.enginatics.com/example/mrp-sourcing-rules-and-bills-of-distribution/
-- Library Link: https://www.enginatics.com/reports/mrp-sourcing-rules-and-bills-of-distribution/
-- Run Report: https://demo.enginatics.com/

select
-- Assignment Set
mas.assignment_set_name,
mas.description assignment_set_description,
xxen_util.meaning(msav.assignment_type,'MRP_ASSIGNMENT_TYPE',700) assignment_type,
msav.organization_code assignment_organization,
msav.customer_name assignment_customer,
msav.ship_to_address assignment_customer_site,
mck.concatenated_segments assignment_category,
mck.description assignment_category_descriptn,
msiv.concatenated_segments assignment_item,
msiv.description assignment_item_descriptn,
muomv.unit_of_measure_tl primary_uom,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_or_buy,
xxen_util.meaning(decode(cic.based_on_rollup_flag,1,1),'SYS_YES_NO',700) based_on_rollup,
&category_columns
-- Sourcing Rule
xxen_util.meaning(msr.sourcing_rule_type,'MRP_SOURCING_RULE_TYPE',700) sourcing_rule_type,
msr.sourcing_rule_name sourcing_rule_name,
msr.description sourcing_rule_description,
xxen_util.meaning(nvl2(mp.organization_code,'2','1'),'INV_YES_NO',3) global_flag,
mp.organization_code sourcing_rule_organization,
xxen_util.meaning(decode(msr.planning_active,1,1),'SYS_YES_NO',700) planning_active,
-- Receiving Org
msrov.organization_code receipt_organization,
msrov.customer receipt_customer,
msrov.address receipt_customer_site,
msrov.effective_date receipt_effective_date_from,
msrov.disable_date receipt_effective_date_to,
-- Sourcing Org
xxen_util.meaning(mssov.source_type,'MRP_SOURCE_TYPE',700) source_type,
mssov.source_organization_code source_organization,
mssov.vendor_name source_supplier,
mssov.vendor_site source_supplier_site,
mssov.allocation_percent,
mssov.rank,
mssov.ship_method,
mssov.intransit_time,
-- Audit
xxen_util.user_name(msr.created_by) rule_created_by,
xxen_util.client_time(msr.creation_date) rule_creation_date,
xxen_util.user_name(msr.last_updated_by) rule_last_updated_by,
xxen_util.client_time(msr.last_update_date) rule_last_update_date,
xxen_util.user_name(mssov.created_by) source_created_by,
xxen_util.client_time(mssov.creation_date) source_creation_date,
xxen_util.user_name(mssov.last_updated_by) source_last_updated_by,
xxen_util.client_time(mssov.last_update_date) source_last_update_date,
xxen_util.user_name(msav.created_by) assignment_created_by,
xxen_util.client_time(msav.creation_date) assignment_creation_date,
xxen_util.user_name(msav.last_updated_by) assignment_last_updated_by,
xxen_util.client_time(msav.last_update_date) assignment_last_update_date
from
mrp_sourcing_rules msr,
mtl_parameters mp,
mrp_sr_receipt_org_v msrov,
mrp_sr_source_org_v mssov,
(
select
msav.*,
(select mp.primary_cost_method from mtl_parameters mp where msav.organization_id=mp.organization_id) primary_cost_method
from
(
select
(
select
max(mp.master_organization_id) master_organization_id
from
mtl_parameters mp
where
mp.organization_id=nvl(msav.organization_id,fnd_profile.value('MFG_ORGANIZATION_ID')) or
nvl(msav.organization_id,fnd_profile.value('MFG_ORGANIZATION_ID')) is null and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
) organization_id_,
msav.*
from
mrp_sr_assignments_v msav
) msav
where
 (msav.assignment_type in (1,2,4,5) or
  msav.organization_id is not null or
  (msav.assignment_type in (3,6) and
   msav.organization_id is null and
   exists (select null from mtl_system_items_vl msiv where msiv.inventory_item_id = msav.inventory_item_id and msiv.organization_id = msav.organization_id_)
  )
 )
) msav,
mrp_assignment_sets mas,
mtl_system_items_vl msiv,
mtl_units_of_measure_vl muomv,
mtl_item_status_vl misv,
cst_item_costs cic,
mtl_categories_kfv mck
where
1=1 and
msr.organization_id=mp.organization_id(+) and
msr.sourcing_rule_id=msrov.sourcing_rule_id(+) and
msrov.sr_receipt_id=mssov.sr_receipt_id(+) and
msr.sourcing_rule_id=msav.sourcing_rule_id(+) and
msav.assignment_set_id=mas.assignment_set_id(+) and
msav.organization_id_=msiv.organization_id(+) and
msav.inventory_item_id=msiv.inventory_item_id(+) and
msiv.primary_uom_code=muomv.uom_code(+) and
msiv.inventory_item_status_code=misv.inventory_item_status_code(+) and
msav.inventory_item_id=cic.inventory_item_id(+) and
msav.organization_id=cic.organization_id(+) and
msav.primary_cost_method=cic.cost_type_id(+) and
msav.category_id=mck.category_id(+)
order by
mas.assignment_set_name,
msav.assignment_type,
msav.organization_code,
mck.concatenated_segments,
msiv.concatenated_segments,
msav.customer_name,
msav.ship_to_address,
msr.sourcing_rule_type desc,
mp.organization_code nulls first,
msr.sourcing_rule_name,
msrov.organization_code,
mssov.allocation_percent desc,
mssov.rank