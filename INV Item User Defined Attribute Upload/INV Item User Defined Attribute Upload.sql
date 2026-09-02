/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item User Defined Attribute Upload
-- Description: Item user-defined attribute (UDA) values upload for Oracle Product Information Management (PIM / Advanced Product Catalog).

Creates, updates and deletes item user-defined attribute values (attribute groups defined in the item catalog) at the item, item organization and item revision data levels through the Oracle EGO user attributes API. Each upload row carries one attribute value; the rows of one attribute group row instance (same item, data level, attribute group and row number) are processed together.

For multi-row attribute groups, enter a Row Number to group the attribute values belonging to one row and include the group's unique key attributes on every row. Set Delete Row to Yes to delete a complete attribute group row.

Enter date attribute values in format DD-MON-YYYY, and enter a UOM for numeric attributes that have a unit of measure class. Users need PIM edit privileges on the items (for example through an item owner role); the upload enforces the same item and attribute group security as the PIM pages.

Only attribute groups associated to item catalog categories are included. The seeded Detailed Description and Images item features are not user-defined attribute groups and are excluded, and supplier association data levels (item supplier, item supplier site, item supplier site organization) are not supported.
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-user-defined-attribute-upload/
-- Library Link: https://www.enginatics.com/reports/inv-item-user-defined-attribute-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
to_char(null) modified_columns_,
x.organization_code,
x.item,
x.item_description,
x.data_level,
x.revision,
x.attribute_group,
x.row_number,
x.attribute,
xxen_ego_upload.attr_display_value(x.extension_id,x.attr_group_id,x.attr_name) value,
xxen_ego_upload.attr_uom_value(x.extension_id,x.attr_group_id,x.attr_name) uom,
to_char(null) delete_row,
x.extension_id,
row_number() over (order by x.organization_code, x.item, x.data_level_id, x.revision, x.attribute_group, x.row_number, x.attr_sequence) upload_row
from
(
select
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
edlv.user_data_level_name data_level,
mirb.revision,
eagv.attr_group_disp_name attribute_group,
case when eagv.multi_row_code='Y' then dense_rank() over (partition by emsieb.inventory_item_id, emsieb.organization_id, emsieb.data_level_id, emsieb.revision_id, emsieb.attr_group_id order by emsieb.extension_id) end row_number,
eav.attr_display_name attribute,
eav.attr_name,
eav.sequence attr_sequence,
emsieb.attr_group_id,
emsieb.extension_id,
emsieb.data_level_id
from
ego_mtl_sy_items_ext_b emsieb,
mtl_parameters mp,
mtl_system_items_vl msiv,
ego_data_level_vl edlv,
mtl_item_revisions_b mirb,
ego_attr_groups_v eagv,
ego_attrs_v eav
where
1=1 and
emsieb.organization_id=mp.organization_id and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
emsieb.inventory_item_id=msiv.inventory_item_id and
emsieb.organization_id=msiv.organization_id and
emsieb.data_level_id=edlv.data_level_id and
edlv.data_level_name in ('ITEM_LEVEL','ITEM_ORG','ITEM_REVISION_LEVEL') and
emsieb.revision_id=mirb.revision_id(+) and
emsieb.attr_group_id=eagv.attr_group_id and
exists (select null from ego_obj_ag_assocs_b eoaa, fnd_objects fo where fo.obj_name='EGO_ITEM' and eoaa.object_id=fo.object_id and eoaa.attr_group_id=emsieb.attr_group_id and eoaa.enabled_flag='Y') and
eav.attr_group_type=eagv.attr_group_type and
eav.attr_group_name=eagv.attr_group_name and
eav.application_id=eagv.application_id and
eav.enabled_flag='Y'
) x