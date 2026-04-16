/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Flex Value Upload
-- Description: Upload to create or update flex values for Independent, Dependent, Translatable Independent, and Translatable Dependent value sets.

Supports:
- Value creation and update (auto-detects via fnd_flex_values_pkg.load_row upsert)
- Enabled flag, start/end dates
- Summary flag (parent/child designation)
- Rollup group assignment for parent values
- Compiled value attributes (qualifier values for KFF segments, e.g. GL Account Type, Allow Posting)
- Hierarchy level
- Attribute sort order
- DFF attributes (ATTRIBUTE1..50)
- Translatable value meaning and description (for Translatable Independent/Dependent value sets)

Note: After uploading parent values with hierarchy changes, run the 'Compile Value Hierarchy' concurrent program from the Value Sets form to update the compiled hierarchy.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-flex-value-upload/
-- Library Link: https://www.enginatics.com/reports/fnd-flex-value-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
ffvs.flex_value_set_name,
ffvs0.flex_value_set_name parent_flex_value_set,
ffv.parent_flex_value_low independent_value,
ffv.flex_value,
ffvt.flex_value_meaning translated_value,
ffvt.description,
xxen_util.yes(ffv.enabled_flag) enabled,
ffv.start_date_active,
ffv.end_date_active,
xxen_util.yes(ffv.summary_flag) parent,
ffhv.hierarchy_name rollup_group,
ffv.hierarchy_level,
ffv.compiled_value_attributes,
ffvnh.child_flex_value_low child_range_low,
ffvnh.child_flex_value_high child_range_high,
xxen_util.meaning(ffvnh.range_attribute,'RANGE_ATTRIBUTE',0) range_attribute,
ffv.attribute_sort_order,
xxen_util.display_flexfield_context(0,'FND_FLEX_VALUES',ffv.value_category) value_category,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE1',ffv.rowid,ffv.attribute1) attribute1,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE2',ffv.rowid,ffv.attribute2) attribute2,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE3',ffv.rowid,ffv.attribute3) attribute3,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE4',ffv.rowid,ffv.attribute4) attribute4,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE5',ffv.rowid,ffv.attribute5) attribute5,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE6',ffv.rowid,ffv.attribute6) attribute6,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE7',ffv.rowid,ffv.attribute7) attribute7,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE8',ffv.rowid,ffv.attribute8) attribute8,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE9',ffv.rowid,ffv.attribute9) attribute9,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE10',ffv.rowid,ffv.attribute10) attribute10,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE11',ffv.rowid,ffv.attribute11) attribute11,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE12',ffv.rowid,ffv.attribute12) attribute12,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE13',ffv.rowid,ffv.attribute13) attribute13,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE14',ffv.rowid,ffv.attribute14) attribute14,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE15',ffv.rowid,ffv.attribute15) attribute15,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE16',ffv.rowid,ffv.attribute16) attribute16,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE17',ffv.rowid,ffv.attribute17) attribute17,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE18',ffv.rowid,ffv.attribute18) attribute18,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE19',ffv.rowid,ffv.attribute19) attribute19,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE20',ffv.rowid,ffv.attribute20) attribute20,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE21',ffv.rowid,ffv.attribute21) attribute21,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE22',ffv.rowid,ffv.attribute22) attribute22,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE23',ffv.rowid,ffv.attribute23) attribute23,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE24',ffv.rowid,ffv.attribute24) attribute24,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE25',ffv.rowid,ffv.attribute25) attribute25,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE26',ffv.rowid,ffv.attribute26) attribute26,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE27',ffv.rowid,ffv.attribute27) attribute27,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE28',ffv.rowid,ffv.attribute28) attribute28,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE29',ffv.rowid,ffv.attribute29) attribute29,
xxen_util.display_flexfield_value(0,'FND_FLEX_VALUES',ffv.value_category,'ATTRIBUTE30',ffv.rowid,ffv.attribute30) attribute30,
ffv.attribute31,
ffv.attribute32,
ffv.attribute33,
ffv.attribute34,
ffv.attribute35,
ffv.attribute36,
ffv.attribute37,
ffv.attribute38,
ffv.attribute39,
ffv.attribute40,
ffv.attribute41,
ffv.attribute42,
ffv.attribute43,
ffv.attribute44,
ffv.attribute45,
ffv.attribute46,
ffv.attribute47,
ffv.attribute48,
ffv.attribute49,
ffv.attribute50,
to_char(null) delete_range,
null upload_row
from
fnd_flex_value_sets ffvs,
fnd_flex_value_sets ffvs0,
fnd_flex_values ffv,
fnd_flex_values_tl ffvt,
fnd_flex_hierarchies_vl ffhv,
fnd_flex_value_norm_hierarchy ffvnh
where
:p_upload_mode like '%'||xxen_upload.action_update and
1=1 and
ffvs.flex_value_set_name=:p_flex_value_set_name and
ffvs.parent_flex_value_set_id=ffvs0.flex_value_set_id(+) and
ffvs.flex_value_set_id=ffv.flex_value_set_id and
ffv.flex_value_id=ffvt.flex_value_id and
ffvt.language=userenv('lang') and
ffv.structured_hierarchy_level=ffhv.hierarchy_id(+) and
ffv.flex_value_set_id=ffvnh.flex_value_set_id(+) and
ffv.flex_value=ffvnh.parent_flex_value(+)