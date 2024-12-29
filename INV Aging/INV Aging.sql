/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Aging
-- Description: The Inventory Aging Report indicates how long an inventory item has been in a FIFO warehouse. You can define bucket days to identify the period from when an item is in the inventory.
NOTES: 
This report will only run for clients running R12.2.8 or later.
This report requires the profile 'INV: FIFO for Original Receipt Date' to be set to Yes in order to return data.

For customers encountering an error running this Blitz report, please first verify the Oracle standard report Inventory Aging Report(XML) can be run in the same instance.
If the standard Oracle report does not complete successfully, or returns no data, then you will need apply a patch in order to use this report.

Please refer to the following My Oracle Support documents for the related patches:
Does the Inventory Aging Report Work for Process Manufacturing (OPM) Organizations? (Doc ID 2914438.1) refers to one off Patch 28858086:R12.INV.C in order to use the Inventory Aging Report.
Inventory Aging Report (XML) Does Not Show Correct Quantity In The Age Buckets For Few Items (Doc ID 2880403.1) refers to Patch 33663520:R12.INV.C for the latest bug fixes for the Inventory Aging Report.

Imported from BI Publisher
Application: Inventory
Source: Inventory Aging Report(XML)
Short Name: INVAGERP_XML
DB package: INV_AGERPXML_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-aging/
-- Library Link: https://www.enginatics.com/reports/inv-aging/
-- Run Report: https://demo.enginatics.com/

with
moqd as
(select
  msib.concatenated_segments item_code,
  --fnd_flex_xml_publisher_apis.process_kff_combination_1('cf_item' ,'INV' ,'MSTK' ,101 ,msib.organization_id ,msib.inventory_item_id ,'ALL' ,'Y' ,'VALUE') item_code,
  moqd.organization_id,
  moqd.subinventory_code,
  inv_utilities.get_conc_segments(moqd.organization_id ,moqd.locator_id) locator_code,
  moqd.inventory_item_id,
  mic.category_concat_segs item_category,
  --fnd_flex_xml_publisher_apis.process_kff_combination_1('cf_cat_field' ,'INV' ,'MCAT' ,mic.structure_id ,null ,mic.category_id ,'ALL' ,'Y' ,'VALUE') item_category,
  msib.description item_desc,
  xxen_util.meaning(msib.item_type,'ITEM_TYPE',3) user_item_type,
  decode(is_consigned
        ,1 ,decode(moqd.owning_tp_type
                  ,1 ,(select vendor_name || '-' || pvsa.vendor_site_code
                       from   po_vendors pv,
                              po_vendor_sites_all pvsa
                       where  pvsa.vendor_id = pv.vendor_id
                       and    pvsa.vendor_site_id = moqd.owning_organization_id
                      )
                  ,2 ,(select (substr(hout.name, 1, 60) || '-' || substr(mp.organization_code, 1, 3)) party
                       from   hr_organization_information hoi,
                              hr_all_organization_units_tl hout,
                              mtl_parameters mp
                       where  hoi.organization_id = hout.organization_id
                       and    hout.organization_id = mp.organization_id
                       and    hout.language = userenv('LANG')
                       and    hoi.org_information1 = 'OPERATING_UNIT'
                       and    hoi.org_information2 = 'Y'
                       and    hoi.org_information_context = 'CLASS'
                       and    hoi.organization_id = moqd.owning_organization_id
                       and    moqd.organization_id <> moqd.owning_organization_id
                      )
                  )
           ,null
        ) owning_party,
  case :p_age_level
   when '1' then max(moqd.last_update_date) over(partition by moqd.organization_id ,moqd.inventory_item_id ,moqd.is_consigned ,moqd.owning_tp_type ,decode(moqd.is_consigned ,1 ,moqd.owning_organization_id ,null))
   when '2' then max(moqd.last_update_date) over(partition by moqd.organization_id ,moqd.inventory_item_id ,moqd.subinventory_code ,moqd.is_consigned ,moqd.owning_tp_type ,decode(moqd.is_consigned ,1 ,moqd.owning_organization_id ,null))
   when '3' then max(moqd.last_update_date) over(partition by moqd.organization_id ,moqd.inventory_item_id ,moqd.subinventory_code ,moqd.locator_id ,moqd.is_consigned ,moqd.owning_tp_type ,decode(moqd.is_consigned ,1 ,moqd.owning_organization_id ,null))
  end last_trx_date,
  case :p_age_level
   when '1' then min(moqd.last_update_date) over(partition by moqd.organization_id ,moqd.inventory_item_id ,moqd.is_consigned ,moqd.owning_tp_type ,decode(moqd.is_consigned ,1 ,moqd.owning_organization_id ,null))
   when '2' then min(moqd.last_update_date) over(partition by moqd.organization_id ,moqd.inventory_item_id ,moqd.subinventory_code ,moqd.is_consigned ,moqd.owning_tp_type ,decode(moqd.is_consigned ,1 ,moqd.owning_organization_id ,null))
   when '3' then min(moqd.last_update_date) over(partition by moqd.organization_id ,moqd.inventory_item_id ,moqd.subinventory_code ,moqd.locator_id ,moqd.is_consigned ,moqd.owning_tp_type ,decode(moqd.is_consigned ,1 ,moqd.owning_organization_id ,null))
  end first_trx_date,
  moqd.primary_transaction_quantity on_hand,
  case :p_age_level
   when '1' then sum(moqd.primary_transaction_quantity) over(partition by moqd.organization_id ,moqd.inventory_item_id ,moqd.is_consigned ,moqd.owning_tp_type ,decode(moqd.is_consigned ,1 ,moqd.owning_organization_id ,null))
   when '2' then sum(moqd.primary_transaction_quantity) over(partition by moqd.organization_id ,moqd.inventory_item_id ,moqd.subinventory_code ,moqd.is_consigned ,moqd.owning_tp_type ,decode(moqd.is_consigned ,1 ,moqd.owning_organization_id ,null))
   when '3' then sum(moqd.primary_transaction_quantity) over(partition by moqd.organization_id ,moqd.inventory_item_id ,moqd.subinventory_code ,moqd.locator_id ,moqd.is_consigned ,moqd.owning_tp_type ,decode(moqd.is_consigned ,1 ,moqd.owning_organization_id ,null))
  end sum_on_hand,
  moqd.primary_transaction_quantity * inv_agerpxml_pkg.f_unit_cost(moqd.organization_id ,moqd.inventory_item_id ,moqd.locator_id ,moqd.cost_group_id ,nvl(moqd.orig_date_received ,moqd.creation_date)) value,
  case :p_age_level
   when '1' then sum(moqd.primary_transaction_quantity * inv_agerpxml_pkg.f_unit_cost(moqd.organization_id ,moqd.inventory_item_id ,moqd.locator_id ,moqd.cost_group_id ,nvl(moqd.orig_date_received ,moqd.creation_date)))
                 over(partition by moqd.organization_id ,moqd.inventory_item_id ,moqd.is_consigned ,moqd.owning_tp_type ,decode(moqd.is_consigned ,1 ,moqd.owning_organization_id ,null))
   when '2' then sum(moqd.primary_transaction_quantity * inv_agerpxml_pkg.f_unit_cost(moqd.organization_id ,moqd.inventory_item_id ,moqd.locator_id ,moqd.cost_group_id ,nvl(moqd.orig_date_received ,moqd.creation_date)))
                 over(partition by moqd.organization_id ,moqd.inventory_item_id ,moqd.subinventory_code ,moqd.is_consigned ,moqd.owning_tp_type ,decode(moqd.is_consigned ,1 ,moqd.owning_organization_id ,null))
   when '3' then sum(moqd.primary_transaction_quantity * inv_agerpxml_pkg.f_unit_cost(moqd.organization_id ,moqd.inventory_item_id ,moqd.locator_id ,moqd.cost_group_id ,nvl(moqd.orig_date_received ,moqd.creation_date)))
                 over(partition by moqd.organization_id ,moqd.inventory_item_id ,moqd.subinventory_code ,moqd.locator_id ,moqd.is_consigned ,moqd.owning_tp_type ,decode(moqd.is_consigned ,1 ,moqd.owning_organization_id ,null))
  end sum_value,
  msib.primary_uom_code uom_code,
  inv_agerpxml_pkg.f_bucket_days_heading(:p_buckets_id ,nvl(moqd.orig_date_received ,moqd.creation_date)) buckets_days_heading --p_buckets_day
  --moqd.orig_date_received
 from
  mtl_onhand_quantities_detail moqd,
  mtl_system_items_vl msib,
  mtl_secondary_inventories_fk_v msiv,
  mtl_item_categories_v mic,
  mtl_item_locations_kfv mil,
  cst_cost_groups ccg
 where
      moqd.organization_id = msib.organization_id
  and moqd.inventory_item_id = msib.inventory_item_id
  and moqd.organization_id = :p_org_id
  and msib.inventory_asset_flag = decode(:p_exp_item ,'2' ,'Y' ,msib.inventory_asset_flag)
  and msiv.organization_id = moqd.organization_id
  and msiv.secondary_inventory_name = moqd.subinventory_code
  and msiv.asset_inventory = decode(:p_exp_sub, '2', 1, msiv.asset_inventory)
  and moqd.cost_group_id = ccg.cost_group_id
  and ccg.cost_group between nvl(:p_cg_from, ccg.cost_group) and nvl(:p_cg_to, ccg.cost_group)
  and msib.organization_id = mic.organization_id
  and msib.inventory_item_id = mic.inventory_item_id
  and moqd.organization_id = mil.organization_id(+)
  and moqd.locator_id = mil.inventory_location_id(+)
  and mic.category_set_id = :p_category_set
  and 1=1
)
--
-- Main Query Starts Here
--
select
 x.organization_name,
 x.organization_code,
 decode(:p_age_level, 1, null, x.subinventory_code) subinventory_code,
 decode(:p_age_level, 3, x.locator_code, null) locator_code,
 x.item_code,
 x.item_category,
 x.item_desc,
 x.user_item_type,
 x.uom_code,
 x.owning_party,
 to_char(max(x.last_trx_date), 'DD-MON-YYYY') last_trx_date,
 max(x.sum_on_hand) total_onhand,
 max(x.sum_value) total_value,
 x.buckets_days_heading,
 sum(x.on_hand) on_hand,
 sum(round(x.value, 2)) value,
 trunc(sysdate) - min(x.first_trx_date) age,
 --
 x.organization_name || decode(:p_age_level, 1, null, ' : ' || x.subinventory_code) || decode(:p_age_level, 3, ' : ' || x.locator_code, null) report_level,
 '(' || ltrim(to_char(x.bucket_seq,'00')) || ') ' || x.buckets_days_heading bucket_label
 -- x.bucket_seq
from
 (
  -- Query 1
  select
   ood.organization_name,
   ood.organization_code,
   moqd.organization_id,
   moqd.subinventory_code,
   moqd.locator_code,
   moqd.inventory_item_id,
   moqd.item_code,
   moqd.item_category,
   moqd.item_desc,
   moqd.user_item_type,
   moqd.uom_code,
   moqd.owning_party,
   moqd.buckets_days_heading,
   inv_agerpxml_pkg.f_bucket_days_seq(:p_buckets_id ,moqd.buckets_days_heading) bucket_seq,
   trunc(max(moqd.last_trx_date)) last_trx_date,
   trunc(min(moqd.first_trx_date)) first_trx_date,
   sum(moqd.on_hand) on_hand,
   max(moqd.sum_on_hand) sum_on_hand,
   sum(moqd.value) value,
   max(moqd.sum_value) sum_value
  from
   moqd,
   org_organization_definitions ood
  where
   ood.organization_id = moqd.organization_id
  group by
   ood.organization_name,
   ood.organization_code,
   moqd.organization_id,
   moqd.subinventory_code,
   moqd.locator_code,
   moqd.inventory_item_id,
   moqd.item_code,
   moqd.item_category,
   moqd.item_desc,
   moqd.user_item_type,
   moqd.uom_code,
   moqd.owning_party,
   inv_agerpxml_pkg.f_bucket_days_seq(:p_buckets_id ,moqd.buckets_days_heading),
   moqd.buckets_days_heading
  union all
  -- Query 2
  --below is for heading all onhand and value is 0
  select
   ood.organization_name,
   ood.organization_code,
   moqd2.organization_id,
   moqd2.subinventory_code,
   moqd2.locator_code,
   moqd2.inventory_item_id,
   moqd2.item_code,
   moqd2.item_category,
   moqd2.item_desc,
   moqd2.user_item_type,
   moqd2.uom_code,
   moqd2.owning_party,
   aablt.report_heading1 || ' ' || aablt.report_heading2 buckets_days_heading,
   aabl.bucket_sequence_num bucket_seq,
   moqd2.last_trx_date,
   moqd2.first_trx_date,
   0 on_hand,
   moqd2.sum_on_hand,
   0 value,
   moqd2.sum_value sum_value
  from
   (select
     moqd.organization_id,
     moqd.subinventory_code,
     moqd.locator_code,
     moqd.inventory_item_id,
     moqd.item_code,
     moqd.item_category,
     moqd.item_desc,
     moqd.user_item_type,
     moqd.uom_code,
     moqd.owning_party,
     moqd.buckets_days_heading,
     inv_agerpxml_pkg.f_bucket_days_seq(:p_buckets_id ,moqd.buckets_days_heading) bucket_seq,
     trunc(max(moqd.last_trx_date)) last_trx_date,
     trunc(min(moqd.first_trx_date)) first_trx_date,
     sum(moqd.on_hand) on_hand,
     max(moqd.sum_on_hand) sum_on_hand,
     sum(moqd.value) value,
     max(moqd.sum_value) sum_value
    from
     moqd
    group by
     moqd.organization_id,
     moqd.subinventory_code,
     moqd.locator_code,
     moqd.inventory_item_id,
     moqd.item_code,
     moqd.item_category,
     moqd.item_desc,
     moqd.user_item_type,
     moqd.uom_code,
     moqd.owning_party,
     inv_agerpxml_pkg.f_bucket_days_seq(:p_buckets_id ,moqd.buckets_days_heading),
     moqd.buckets_days_heading
   ) moqd2,
   ar_aging_buckets aab,
   ar_aging_bucket_lines_b aabl, --ar_aging_bucket_lines_vl for language
   ar_aging_bucket_lines_tl aablt,
   org_organization_definitions ood
  where
       ood.organization_id = moqd2.organization_id
   and aab.aging_type = 'INVENTORYAGE'
   and aabl.aging_bucket_id = aab.aging_bucket_id
   and aab.status = 'A'
   and aablt.aging_bucket_line_id = aabl.aging_bucket_line_id
   and aablt.language = userenv('LANG')
   and aab.aging_bucket_id = :p_buckets_id
   and aabl.type = 'INVENTORYAGE'
 ) x
where
     :p_category_set_name = :p_category_set_name
 and :p_org_code = :p_org_code
 and x.bucket_seq not in (-99999, -99998)
 and inv_agerpxml_pkg.cf_profile = 'Y'
group by
 x.organization_name,
 x.organization_code,
 decode(:p_age_level, 1, null, x.subinventory_code),
 decode(:p_age_level, 3, x.locator_code, null),
 x.inventory_item_id,
 x.item_code,
 x.item_category,
 x.item_desc,
 x.user_item_type,
 x.uom_code,
 x.owning_party,
 x.buckets_days_heading,
 x.bucket_seq,
 x.organization_name || decode(:p_age_level, 1, null, ' : ' || x.subinventory_code) || decode(:p_age_level, 3, ' : ' || x.locator_code, null),
 '(' || ltrim(to_char(x.bucket_seq,'00')) || ') ' || x.buckets_days_heading
order by
 organization_name,
 decode(:p_age_level, 1, null, subinventory_code), -- x.subinventory_code,
 decode(:p_age_level, 3, locator_code, null), -- x.locator_code,
 -- 1 = Age, 2 = Value, 3 = Catgory
 decode(:p_order_by,1,age,null) desc,
 decode(:p_order_by,2,total_value,null) desc,
 decode(:p_order_by,3,item_category,null),
 --
 item_code,
 bucket_seq,
 owning_party