/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: WSH Container Items Upload
-- Description: Creates, updates and deletes container-item relationships - the Container-Item Relationships form (Shipping > Setup > Container Load Details). A relationship states the maximum quantity of a load item that fits into a container item in one inventory organization; auto-pack uses the load item's preferred container.
-- Setting Preferred Flag to Yes removes the flag from the load item's current preferred container, as the form does after asking, and the Message names that container. When several rows of one file make different containers preferred for the same load item, the last row wins.
-- Maximum Quantity is rounded to five decimals and must be a whole number for serial controlled and indivisible load items.
-- Changing the Container Item or Load Item of a downloaded row moves that relationship. To remove a relationship, enter Yes in Delete Relationship.
-- Excel Example Output: https://www.enginatics.com/example/wsh-container-items-upload/
-- Library Link: https://www.enginatics.com/reports/wsh-container-items-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
wci.container_item_id orig_container_item_id,
wci.load_item_id orig_load_item_id,
mp.organization_code,
msiv_c.concatenated_segments container_item,
xxen_util.meaning(msiv_c.container_type_code,'CONTAINER_TYPE',3) container_type,
msiv_l.concatenated_segments load_item,
msiv_l.primary_uom_code uom,
wci.max_load_quantity maximum_quantity,
xxen_util.yes(wci.preferred_flag) preferred_flag,
null delete_relationship,
msiv_c.description container_description,
msiv_l.description load_description,
xxen_util.display_flexfield_context(665,'WSH_CONTAINER_ITEMS',wci.attribute_category) attribute_category,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE1',wci.rowid,wci.attribute1) ci_attribute1,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE2',wci.rowid,wci.attribute2) ci_attribute2,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE3',wci.rowid,wci.attribute3) ci_attribute3,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE4',wci.rowid,wci.attribute4) ci_attribute4,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE5',wci.rowid,wci.attribute5) ci_attribute5,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE6',wci.rowid,wci.attribute6) ci_attribute6,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE7',wci.rowid,wci.attribute7) ci_attribute7,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE8',wci.rowid,wci.attribute8) ci_attribute8,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE9',wci.rowid,wci.attribute9) ci_attribute9,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE10',wci.rowid,wci.attribute10) ci_attribute10,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE11',wci.rowid,wci.attribute11) ci_attribute11,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE12',wci.rowid,wci.attribute12) ci_attribute12,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE13',wci.rowid,wci.attribute13) ci_attribute13,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE14',wci.rowid,wci.attribute14) ci_attribute14,
xxen_util.display_flexfield_value(665,'WSH_CONTAINER_ITEMS',wci.attribute_category,'ATTRIBUTE15',wci.rowid,wci.attribute15) ci_attribute15,
to_number(null) upload_row
from
wsh_container_items wci,
mtl_parameters mp,
mtl_system_items_vl msiv_c,
mtl_system_items_vl msiv_l
where
1=1 and
wci.master_organization_id=mp.organization_id and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
wci.master_organization_id=msiv_c.organization_id and
wci.container_item_id=msiv_c.inventory_item_id and
wci.master_organization_id=msiv_l.organization_id and
wci.load_item_id=msiv_l.inventory_item_id
