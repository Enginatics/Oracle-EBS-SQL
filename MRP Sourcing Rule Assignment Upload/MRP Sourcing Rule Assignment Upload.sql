/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MRP Sourcing Rule Assignment Upload
-- Description: MRP Sourcing Rule Assignment Upload
=============================
- Upload new Assignment Sets and Sourcing Rule Assignments
- Update Existing Assignment Sets and Sourcing Rule Assignments

Notes:
If an Assignment Organization is specified, then this determines the selecatable items. 
If an Assignment Organization is not specified, then the Master Organization determines the selectable Items.
The selectable Assignment Organizations is not restricted by the Master Organization. 
This is the same logic as used in the Sourcing Assignments form

-- Excel Examle Output: https://www.enginatics.com/example/mrp-sourcing-rule-assignment-upload/
-- Library Link: https://www.enginatics.com/reports/mrp-sourcing-rule-assignment-upload/
-- Run Report: https://demo.enginatics.com/

with sra_query as
(
select
 -- assignment set
 mas.assignment_set_name assignment_set,
 mas.description assignment_set_description,
 -- assignment
 case mrav.assignment_type
 when 1 then 'Global'
 when 2 then 'Category'
 when 3 then 'Item'
 when 4 then 'Organization'
 when 5 then 'Category-Organization'
 when 6 then 'Item-Organization'
 end assignment_type,
 mrav.organization_code organization,
 case when mrav.assignment_type in (3,6)
 then (select
        msiv.concatenated_segments
       from
        mtl_system_items_vl msiv
       where
        msiv.organization_id = nvl(mrav.organization_id,:p_master_org_id) and
        msiv.inventory_item_id = mrav.inventory_item_id
      )
 else null
 end item,
 case when mrav.assignment_type in (2,5)
 then mrav.entity_name
 else null
 end category,
 case when mrav.assignment_type in (3,6)
 then  (select
        msiv.description
       from
        mtl_system_items_vl msiv
       where
        msiv.organization_id = nvl(mrav.organization_id,:p_master_org_id) and
        msiv.inventory_item_id = mrav.inventory_item_id
      )
 else mrav.description
 end description,
 mrav.customer_name,
 hca.account_number customer_number,
 hcsua.location customer_site,
 xxen_util.meaning(hcsua.site_use_code,'SITE_USE_CODE',222) customer_site_use,
 mrav.ship_to_address,
 haouv.name customer_site_ou,
 mrav.sourcing_rule_type_text sourcing_rule_type,
 mrav.sourcing_rule_name,
 mp.organization_code sourcing_rule_org,
 -- attributes
 mas.attribute_category set_attribute_category,
 mas.attribute1 set_attribute1,
 mas.attribute2 set_attribute2,
 mas.attribute3 set_attribute3,
 mas.attribute4 set_attribute4,
 mas.attribute5 set_attribute5,
 mas.attribute6 set_attribute6,
 mas.attribute7 set_attribute7,
 mas.attribute8 set_attribute8,
 mas.attribute9 set_attribute9,
 mas.attribute10 set_attribute10,
 mas.attribute11 set_attribute11,
 mas.attribute12 set_attribute12,
 mas.attribute13 set_attribute13,
 mas.attribute14 set_attribute14,
 mas.attribute15 set_attribute15,
 --
 mrav.attribute_category assign_attribute_category,
 mrav.attribute1 assign_attribute1,
 mrav.attribute2 assign_attribute2,
 mrav.attribute3 assign_attribute3,
 mrav.attribute4 assign_attribute4,
 mrav.attribute5 assign_attribute5,
 mrav.attribute6 assign_attribute6,
 mrav.attribute7 assign_attribute7,
 mrav.attribute8 assign_attribute8,
 mrav.attribute9 assign_attribute9,
 mrav.attribute10 assign_attribute10,
 mrav.attribute11 assign_attribute11,
 mrav.attribute12 assign_attribute12,
 mrav.attribute13 assign_attribute13,
 mrav.attribute14 assign_attribute14,
 mrav.attribute15 assign_attribute15,
 -- ids
 mas.assignment_set_id,
 mrav.assignment_id,
 mrav.sourcing_rule_id,
 mrav.assignment_type assignment_type_id,
 --
 mrav.last_updated_by,
 mrav.last_update_date
from
 mrp_assignment_sets mas,
 mrp_sr_assignments_v mrav,
 mrp_sourcing_rules msr,
 mtl_parameters mp,
 hz_cust_accounts hca,
 hz_cust_site_uses_all hcsua,
 hr_all_organization_units_vl haouv
where
 mas.assignment_set_id = mrav.assignment_set_id and
 mrav.sourcing_rule_id = msr.sourcing_rule_id (+) and
 msr.organization_id = mp.organization_id (+) and
 mrav.customer_id = hca.cust_account_id (+) and
 mrav.ship_to_site_id = hcsua.site_use_id (+) and
 hcsua.org_id = haouv.organization_id (+) and
 (mrav.assignment_type in (1,2,4,5) or
  mrav.organization_id is not null or
  (mrav.assignment_type in (3,6) and
   mrav.organization_id is null and
   mrav.inventory_item_id in
    (select
      msiv.inventory_item_id
     from
      mtl_system_items_vl msiv
     where
       msiv.organization_id = :p_master_org_id
    )
  )
 )
)
--
-- Main Query Starts Here
--
select
x.*
from
(
select /*+ push_pred(sra) */
 null action_,
 null status_,
 null message_,
 null request_id_,
 null set_row_id,
 null ass_row_id,
 :p_upload_mode upload_mode,
 -- assignment set
 sra.assignment_set,
 sra.assignment_set_description,
 -- assignment
 sra.assignment_type,
 sra.organization,
 sra.item,
 sra.category,
 sra.description,
 sra.customer_name,
 sra.customer_number,
 sra.customer_site,
 sra.customer_site_use,
 sra.customer_site_ou,
 sra.ship_to_address,
 sra.sourcing_rule_type,
 sra.sourcing_rule_name,
 sra.sourcing_rule_org,
 -- attributes
 sra.set_attribute_category,
 sra.set_attribute1,
 sra.set_attribute2,
 sra.set_attribute3,
 sra.set_attribute4,
 sra.set_attribute5,
 sra.set_attribute6,
 sra.set_attribute7,
 sra.set_attribute8,
 sra.set_attribute9,
 sra.set_attribute10,
 sra.set_attribute11,
 sra.set_attribute12,
 sra.set_attribute13,
 sra.set_attribute14,
 sra.set_attribute15,
 --
 sra.assign_attribute_category,
 sra.assign_attribute1,
 sra.assign_attribute2,
 sra.assign_attribute3,
 sra.assign_attribute4,
 sra.assign_attribute5,
 sra.assign_attribute6,
 sra.assign_attribute7,
 sra.assign_attribute8,
 sra.assign_attribute9,
 sra.assign_attribute10,
 sra.assign_attribute11,
 sra.assign_attribute12,
 sra.assign_attribute13,
 sra.assign_attribute14,
 sra.assign_attribute15,
 --
 null delete_option,
 -- ids
 sra.assignment_set_id,
 sra.assignment_id,
 sra.sourcing_rule_id,
 sra.assignment_type_id,
 :p_master_org_id master_organization_id
from
 sra_query sra
where
 :p_master_org_code is not null and
 1=1
&not_use_first_block
&report_table_select
&report_table_name &report_table_where_clause
&processed_run
) x
order by
 x.assignment_set,
 x.assignment_type_id,
 x.organization,
 nvl(x.item,x.category),
 x.customer_name,
 x.customer_site,
 x.sourcing_rule_name