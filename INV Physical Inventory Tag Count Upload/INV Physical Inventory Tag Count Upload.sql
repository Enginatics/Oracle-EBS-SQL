/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Physical Inventory Tag Count Upload
-- Description: INV Physical Inventory Tag Count Upload
=================================
This upload enables the user to upload counts against the Physical Inventory Tags defined against the specified Physical Inventory.

The upload supports
- the update of counts against existing Tags
- the generation of new tags.
  to generate a new tag leave the tag number blank. This will be automatically generated when the tag is created

For clients on R12.2 or later
- the upload will support the voiding/unvoiding of existing tags as well
   



-- Excel Examle Output: https://www.enginatics.com/example/inv-physical-inventory-tag-count-upload/
-- Library Link: https://www.enginatics.com/reports/inv-physical-inventory-tag-count-upload/
-- Run Report: https://demo.enginatics.com/

with mpit_qry as
(
select
 -- Physical Inventory
 mp.organization_code,
 mpiv.physical_inventory_name,
 mpiv.description,
 mpiv.physical_inventory_date,
 mpiv.snapshot_complete,
 mpiv.freeze_date snapshot_date,
 xxen_util.meaning(mpiv.adjustments_posted,'INV_YES_NO',3) adjustments_posted,
 mpiv.last_adjustment_date,
 mpiv.total_adjustment_value,
 xxen_util.meaning(mpiv.approval_required,'INV_CC_APPROVAL',700) approval_required,
 mpiv.approval_tolerance_pos quantity_tolerance_plus,
 mpiv.approval_tolerance_neg quantity_tolerance_minus,
 mpiv.cost_variance_pos value_tolerance_plus,
 mpiv.cost_variance_neg value_tolerance_minus,
 xxen_util.meaning(mpiv.all_subinventories_flag,'INV_YES_NO',3) all_subinventories,
 (select listagg(mps.subinventory,',') within group (order by mps.subinventory)
  from mtl_physical_subinventories mps
  where mps.physical_inventory_id = mpiv.physical_inventory_id
  and   mps.organization_Id = mpiv.organization_id
 ) subinventories,
 xxen_util.meaning(mpiv.exclude_zero_balance,'INV_YES_NO',3) exclude_zero_balance,
 xxen_util.meaning(mpiv.exclude_negative_balance,'INV_YES_NO',3) exclude_negative_balance,
 xxen_util.meaning(mpiv.dynamic_tag_entry_flag,'INV_YES_NO',3) dynamic_tag_entry_flag,
 mpiv.next_tag_number,
 mpiv.tag_number_increments,
 mpiv.number_of_skus,
 (select gcck.concatenated_segments
  from gl_code_combinations_kfv gcck
  where gcck.code_combination_id = mpiv.default_gl_adjust_account
 ) default_adjustment_account,
 -- Tags
 mpit.tag_number,
 msiv.concatenated_segments item,
 mpit.revision,
 msiv.description item_description,
 xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
 msiv.item_type item_type_code,
 msiv.primary_uom_code item_primary_uom,
 msiv.secondary_uom_code item_secondary_uom,
 mck.concatenated_segments item_category,
 mpit.subinventory,
 milk.concatenated_segments locator,
 mpit.lot_number,
 mpit.lot_expiration_date,
 mpit.serial_num serial_number,
 inv_invarptp_xmlp_pkg.cf_parent_lpnformula(mpit.parent_lpn_id) parent_lpn,
 inv_invarptp_xmlp_pkg.cf_outermost_lpnformula(mpit.outermost_lpn_id,mpit.parent_lpn_id) outermost_lpn,
 --
 mpit.tag_uom uom,
 mpit.tag_quantity quantity,
 mpit.tag_secondary_uom secondary_uom,
 mpit.tag_secondary_quantity secondary_quantity,
 (select papf.full_name
  from   per_all_people_f papf
  where  papf.person_id = mpit.counted_by_employee_id
  and    sysdate between papf.effective_start_date and papf.effective_end_date
 ) last_counted_by,
 xxen_util.meaning(decode(mpit.void_flag,1,mpit.void_flag,null),'INV_YES_NO',3) void,
 --
 mpa.system_quantity,
 mpa.secondary_system_qty secondary_system_quantity,
 --
 inv_invarptp_xmlp_pkg.cf_cost_groupformula(mpit.cost_group_id)cost_group_name,
 --
 mpit.attribute_category,
 mpit.attribute1,
 mpit.attribute2,
 mpit.attribute3,
 mpit.attribute4,
 mpit.attribute5,
 mpit.attribute6,
 mpit.attribute7,
 mpit.attribute8,
 mpit.attribute9,
 mpit.attribute10,
 mpit.attribute11,
 mpit.attribute12,
 mpit.attribute13,
 mpit.attribute14,
 mpit.attribute15,
 mpiv.physical_inventory_id,
 mpit.tag_id,
 mpit.last_update_date,
 mpit.last_updated_by
from
 mtl_physical_inventories_v mpiv,
 mtl_physical_inventory_tags mpit,
 mtl_physical_adjustments mpa,
 mtl_parameters mp,
 mtl_item_locations_kfv milk,
 mtl_system_items_vl msiv,
 mtl_item_categories mic,
 mtl_categories_kfv mck
where
 mpiv.physical_inventory_id = mpit.physical_inventory_id and
 mpiv.organization_id = mpit.organization_id and
 mpit.adjustment_id = mpa.adjustment_id (+) and
 mpiv.organization_id = mp.organization_id and
 mpit.organization_id = milk.organization_id (+) and
 mpit.locator_id = milk.inventory_location_id (+) and
 mpit.organization_id = msiv.organization_id (+) and
 mpit.inventory_item_id = msiv.inventory_item_id (+) and
 mpit.organization_id = mic.organization_id (+) and
 mpit.inventory_item_id = mic.inventory_item_id (+) and
 :p_category_set_id = mic.category_set_id (+) and
 mic.category_id = mck.category_id (+) and
 -- from INVADPPI (Physical Inventory Tag Counts) form
 inv_material_status_grp.is_status_applicable( null, null,8,null,null,mpit.organization_id,mpit.inventory_item_id,mpit.subinventory,mpit.locator_id,mpit.lot_number,mpit.serial_num,'A') = 'Y' and
 mpiv.adjustments_posted = 2 and
 -- from INV_PHY_INV_PUB.UPDATE_TAGS
 exists
 (select
   null
  from
   mtl_physical_adjustments mpa
  where
   mpit.organization_id = mpa.organization_id and
   mpit.physical_inventory_id= mpa.physical_inventory_id and
   mpit.adjustment_id = mpa.adjustment_id and
   mpit.inventory_item_id = mpa.inventory_item_id and
   nvl(mpa.approval_status,0) <> 3
 )
)
--
-- Main Query Starts Here
--
select
x.*
from
(
select /*+ push_pred(mpit) */
null action_,
null status_,
null message_,
null request_id_,
to_date(null) timestamp_,
null row_id,
:p_upload_mode upload_mode,
mpit.organization_code,
mpit.physical_inventory_name,
-- Tags
mpit.tag_number,
mpit.item,
mpit.revision,
mpit.item_description,
mpit.item_type,
mpit.item_category,
mpit.item_primary_uom,
mpit.item_secondary_uom,
mpit.subinventory,
mpit.locator,
mpit.lot_number,
mpit.lot_expiration_date,
mpit.serial_number,
mpit.parent_lpn,
mpit.outermost_lpn,
--
mpit.uom,
mpit.quantity,
mpit.secondary_uom,
mpit.secondary_quantity,
mpit.last_counted_by,
:p_counter_emp_name counted_by,
mpit.void,
--
mpit.system_quantity,
mpit.secondary_system_quantity,
--
mpit.cost_group_name,
--
mpit.attribute_category,
mpit.attribute1,
mpit.attribute2,
mpit.attribute3,
mpit.attribute4,
mpit.attribute5,
mpit.attribute6,
mpit.attribute7,
mpit.attribute8,
mpit.attribute9,
mpit.attribute10,
mpit.attribute11,
mpit.attribute12,
mpit.attribute13,
mpit.attribute14,
mpit.attribute15,
-- ids
mpit.tag_id
from
mpit_qry mpit
where
mpit.organization_code = :p_organization_code  and
mpit.physical_inventory_name = :p_physical_inv_name and
1=1
&not_use_first_block
&report_table_select
&report_table_name &report_table_where_clause
&processed_run
) x
order by
 x.tag_number,
 x.item,
 x.revision,
 x.subinventory,
 x.locator,
 x.lot_number,
 x.serial_number,
 x.uom,
 x.quantity