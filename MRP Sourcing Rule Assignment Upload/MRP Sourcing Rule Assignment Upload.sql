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

select
 null action_,
 null status_,
 null message_,
 null request_id_,
 null modified_columns_,
 null set_row_id,
 null ass_row_id,
 :p_upload_mode upload_mode,
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
 msiv.concatenated_segments item,
 case when mrav.assignment_type in (2,5)
 then mrav.entity_name
 else null
 end category,
 case when mrav.assignment_type in (3,6)
 then msiv.description
 else mrav.description
 end description,
 mrav.customer_name,
 hca.account_number customer_number,
 hcsua.location customer_site,
 xxen_util.meaning(hcsua.site_use_code,'SITE_USE_CODE',222) customer_site_use,
 haouv.name customer_site_ou,
 mrav.ship_to_address,
 mrav.sourcing_rule_type_text sourcing_rule_type,
 mrav.sourcing_rule_name,
 mp.organization_code sourcing_rule_org,
 -- attributes
 xxen_util.display_flexfield_context(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category) set_attribute_category,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE1',mas.rowid,mas.attribute1) sr_set_attribute1,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE2',mas.rowid,mas.attribute2) sr_set_attribute2,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE3',mas.rowid,mas.attribute3) sr_set_attribute3,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE4',mas.rowid,mas.attribute4) sr_set_attribute4,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE5',mas.rowid,mas.attribute5) sr_set_attribute5,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE6',mas.rowid,mas.attribute6) sr_set_attribute6,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE7',mas.rowid,mas.attribute7) sr_set_attribute7,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE8',mas.rowid,mas.attribute8) sr_set_attribute8,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE9',mas.rowid,mas.attribute9) sr_set_attribute9,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE10',mas.rowid,mas.attribute10) sr_set_attribute10,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE11',mas.rowid,mas.attribute11) sr_set_attribute11,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE12',mas.rowid,mas.attribute12) sr_set_attribute12,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE13',mas.rowid,mas.attribute13) sr_set_attribute13,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE14',mas.rowid,mas.attribute14) sr_set_attribute14,
 xxen_util.display_flexfield_value(704,'MRP_ASSIGNMENT_SETS',mas.attribute_category,'ATTRIBUTE15',mas.rowid,mas.attribute15) sr_set_attribute15,
 --
 xxen_util.display_flexfield_context(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category) assign_attribute_category,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE1',mrav.row_id,mrav.attribute1) sr_assign_attribute1,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE2',mrav.row_id,mrav.attribute2) sr_assign_attribute2,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE3',mrav.row_id,mrav.attribute3) sr_assign_attribute3,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE4',mrav.row_id,mrav.attribute4) sr_assign_attribute4,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE5',mrav.row_id,mrav.attribute5) sr_assign_attribute5,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE6',mrav.row_id,mrav.attribute6) sr_assign_attribute6,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE7',mrav.row_id,mrav.attribute7) sr_assign_attribute7,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE8',mrav.row_id,mrav.attribute8) sr_assign_attribute8,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE9',mrav.row_id,mrav.attribute9) sr_assign_attribute9,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE10',mrav.row_id,mrav.attribute10) sr_assign_attribute10,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE11',mrav.row_id,mrav.attribute11) sr_assign_attribute11,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE12',mrav.row_id,mrav.attribute12) sr_assign_attribute12,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE13',mrav.row_id,mrav.attribute13) sr_assign_attribute13,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE14',mrav.row_id,mrav.attribute14) sr_assign_attribute14,
 xxen_util.display_flexfield_value(704,'MRP_SR_ASSIGNMENTS',mrav.attribute_category,'ATTRIBUTE15',mrav.row_id,mrav.attribute15) sr_assign_attribute15,
 --
 null delete_option,
 -- ids
 mas.assignment_set_id,
 mrav.assignment_id,
 mrav.sourcing_rule_id,
 mrav.assignment_type assignment_type_id,
 :p_master_org_id master_organization_id
from
 mrp_assignment_sets mas,
 mrp_sr_assignments_v mrav,
 mrp_sourcing_rules msr,
 mtl_parameters mp,
 mtl_system_items_vl msiv,
 hz_cust_accounts hca,
 hz_cust_site_uses_all hcsua,
 hr_all_organization_units_vl haouv
where
 1=1 and
 :p_master_org_code is not null and
 mas.assignment_set_id = mrav.assignment_set_id and
 mrav.sourcing_rule_id = msr.sourcing_rule_id (+) and
 msr.organization_id = mp.organization_id (+) and
 case when mrav.assignment_type in (3,6) then nvl(mrav.organization_id,:p_master_org_id) else null end = msiv.organization_id (+) and
 case when mrav.assignment_type in (3,6) then mrav.inventory_item_id else null end = msiv.inventory_item_id (+) and
 mrav.customer_id = hca.cust_account_id (+) and
 mrav.ship_to_site_id = hcsua.site_use_id (+) and
 hcsua.org_id = haouv.organization_id (+) and
 (mrav.assignment_type in (1,2,4,5) or
  mrav.organization_id is not null or
  (mrav.assignment_type in (3,6) and
   mrav.organization_id is null and
   exists (select null from mtl_system_items_b msib where msib.organization_id = :p_master_org_id and msib.inventory_item_id = mrav.inventory_item_id)
  )
 )