/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Customer Item Cross References
-- Description: Customer item cross references to the item master, as maintained in the Customer Item Cross References form.
-- One row per cross reference. A customer item without a cross reference shows with blank item columns.
-- Address category and site columns are populated for customer items defined at address category or address level.
-- Excel Example Output: https://www.enginatics.com/example/inv-customer-item-cross-references/
-- Library Link: https://www.enginatics.com/reports/inv-customer-item-cross-references/
-- Run Report: https://demo.enginatics.com/

select
hp.party_name customer_name,
hca.account_number customer_number,
xxen_util.meaning(mci.item_definition_level,'INV_ITEM_DEFINITION_LEVEL',700) definition_level,
xxen_util.meaning(mci.customer_category_code,'ADDRESS_CATEGORY',222,'Y') address_category,
hps.party_site_number site_number,
hz_format_pub.format_address(hps.location_id,null,null,' , ') site_address,
mci.customer_item_number customer_item,
mci.customer_item_desc customer_item_description,
mcc.commodity_code,
mci_m.customer_item_number model_customer_item,
msiv_mc.concatenated_segments master_container,
msiv_dc.concatenated_segments detail_container,
mci.min_fill_percentage,
xxen_util.yes(mci.dep_plan_required_flag) dependent_planning_required,
xxen_util.yes(mci.dep_plan_prior_bld_flag) dependent_planning_prior_build,
mci.demand_tolerance_positive,
mci.demand_tolerance_negative,
xxen_util.yes(decode(mci.inactive_flag,'N','Y')) customer_item_active,
mp.organization_code master_organization,
msiv.concatenated_segments item,
msiv.description item_description,
mcix.preference_number rank,
xxen_util.yes(decode(mcix.inactive_flag,'N','Y')) active,
xxen_util.user_name(mcix.created_by) created_by,
xxen_util.client_time(mcix.creation_date) creation_date,
xxen_util.user_name(mcix.last_updated_by) last_updated_by,
xxen_util.client_time(mcix.last_update_date) last_update_date
from
mtl_customer_items mci,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
mtl_commodity_codes mcc,
mtl_customer_items mci_m,
mtl_system_items_vl msiv_mc,
mtl_system_items_vl msiv_dc,
mtl_customer_item_xrefs mcix,
mtl_parameters mp,
mtl_system_items_vl msiv
where
1=1 and
mci.customer_id=hca.cust_account_id and
hca.party_id=hp.party_id and
mci.address_id=hcasa.cust_acct_site_id(+) and
hcasa.party_site_id=hps.party_site_id(+) and
mci.commodity_code_id=mcc.commodity_code_id(+) and
mci.model_customer_item_id=mci_m.customer_item_id(+) and
mci.master_container_item_id=msiv_mc.inventory_item_id(+) and
mci.container_item_org_id=msiv_mc.organization_id(+) and
mci.detail_container_item_id=msiv_dc.inventory_item_id(+) and
mci.container_item_org_id=msiv_dc.organization_id(+) and
mci.customer_item_id=mcix.customer_item_id(+) and
mcix.master_organization_id=mp.organization_id(+) and
mcix.inventory_item_id=msiv.inventory_item_id(+) and
mcix.master_organization_id=msiv.organization_id(+)
order by
hp.party_name,
mci.item_definition_level,
mci.customer_item_number,
mcix.preference_number
