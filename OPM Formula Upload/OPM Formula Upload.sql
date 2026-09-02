/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Formula Upload
-- Description: OPM Formula Upload
==================
Create or update Oracle Process Manufacturing (OPM / GMD) Formulas via the public API GMD_FORMULA_PUB / GMD_FORMULA_DETAIL_PUB.

Row model
=========
One spreadsheet row per formula LINE. The header columns (Organization Code, Formula, Formula Version, Description, Class, Owner, Header Scale Type, Status, header attributes) repeat on every line of the same formula. Each line carries its Line Type (Ingredient / Product / By-Product) plus its item, quantity, UOM, scale, and line attributes. Rows of the same formula (Organization Code + Formula + Formula Version) must be contiguous.

Every formula must have at least one Ingredient AND at least one Product (OPM requirement) - a header-only formula is rejected.

Upload modes
============
Create - empty template for new formulas.
Create, Update - downloads existing formulas in the chosen organization for review/edit and allows adding new ones. Existing formulas are matched on Organization Code + Formula + Formula Version.

Notes
=====
- Items must be recipe-enabled in the owner organization. Detail UOM must be convertible from the item's primary UOM.
- New formulas are created in status New (100); status changes are a workflow operation and are not driven by this upload.
- On update, header description/class/owner and line quantities/attributes are updated; new lines are added. The owner organization and version are the key and cannot be changed.
-- Excel Examle Output: https://www.enginatics.com/example/opm-formula-upload/
-- Library Link: https://www.enginatics.com/reports/opm-formula-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
row_number() over (order by x.formula, x.formula_version, x.line_type_sort, x.line_no) upload_row,
x.organization_code,
x.formula,
x.formula_version,
x.formula_description,
x.formula_description_2,
x.formula_class,
x.owner,
x.header_scale_type,
x.calculate_product_quantity,
x.formula_status,
x.line_type,
x.line_no,
x.item,
x.item_description,
x.revision,
x.quantity,
x.detail_uom,
x.line_scale_type,
x.release_type,
x.scrap_factor,
x.phantom_type,
x.rework_type,
x.contribute_to_yield,
x.contribute_to_step_quantity,
x.cost_allocation,
x.product_percent,
x.by_product_type,
x.scale_multiple,
x.scale_rounding_variance,
x.rounding_direction,
x.ingredient_end_date,
x.delete_line,
x.fa_attribute_category,
x.fa_attribute1,
x.fa_attribute2,
x.fa_attribute3,
x.fa_attribute4,
x.fa_attribute5,
x.fa_attribute6,
x.fa_attribute7,
x.fa_attribute8,
x.fa_attribute9,
x.fa_attribute10,
x.fa_attribute11,
x.fa_attribute12,
x.fa_attribute13,
x.fa_attribute14,
x.fa_attribute15,
x.fa_attribute16,
x.fa_attribute17,
x.fa_attribute18,
x.fa_attribute19,
x.fa_attribute20,
x.fa_attribute21,
x.fa_attribute22,
x.fa_attribute23,
x.fa_attribute24,
x.fa_attribute25,
x.fa_attribute26,
x.fa_attribute27,
x.fa_attribute28,
x.fa_attribute29,
x.fa_attribute30,
x.ld_attribute_category,
x.ld_attribute1,
x.ld_attribute2,
x.ld_attribute3,
x.ld_attribute4,
x.ld_attribute5,
x.ld_attribute6,
x.ld_attribute7,
x.ld_attribute8,
x.ld_attribute9,
x.ld_attribute10,
x.ld_attribute11,
x.ld_attribute12,
x.ld_attribute13,
x.ld_attribute14,
x.ld_attribute15,
x.ld_attribute16,
x.ld_attribute17,
x.ld_attribute18,
x.ld_attribute19,
x.ld_attribute20,
x.ld_attribute21,
x.ld_attribute22,
x.ld_attribute23,
x.ld_attribute24,
x.ld_attribute25,
x.ld_attribute26,
x.ld_attribute27,
x.ld_attribute28,
x.ld_attribute29,
x.ld_attribute30,
x.formula_id,
x.formula_line_id
from (
select
mp.organization_code,
ffmv.formula_no formula,
ffmv.formula_vers formula_version,
ffmv.formula_desc1 formula_description,
ffmv.formula_desc2 formula_description_2,
ffmv.formula_class,
(select fu.user_name from fnd_user fu where fu.user_id=ffmv.owner_id) owner,
xxen_util.meaning(to_char(ffmv.scale_type),'SCALE_TYPE',552) header_scale_type,
xxen_util.meaning(ffmv.auto_product_calc,'YES_NO',552) calculate_product_quantity,
(select gsv.meaning from gmd_status_vl gsv where gsv.status_code=ffmv.formula_status) formula_status,
xxen_util.meaning(to_char(fmd.line_type),'GMD_FORMULA_ITEM_TYPE',552) line_type,
fmd.line_no,
msiv.concatenated_segments item,
msiv.description item_description,
fmd.revision,
fmd.qty quantity,
fmd.detail_uom,
xxen_util.meaning(to_char(fmd.scale_type),'SCALE_TYPE',552) line_scale_type,
xxen_util.meaning(to_char(fmd.release_type),'GMD_MATERIAL_RELEASE_TYPE',552) release_type,
fmd.scrap_factor,
decode(fmd.phantom_type,0,'Not Phantom',1,'Automatic Phantom',2,'Manual Phantom') phantom_type,
xxen_util.meaning(to_char(fmd.rework_type),'GMD_REWORK_TYPE',552) rework_type,
xxen_util.meaning(fmd.contribute_yield_ind,'YES_NO',552) contribute_to_yield,
xxen_util.meaning(fmd.contribute_step_qty_ind,'YES_NO',552) contribute_to_step_quantity,
fmd.cost_alloc cost_allocation,
fmd.prod_percent product_percent,
xxen_util.meaning(fmd.by_product_type,'GMD_BY_PRODUCT_TYPE',552) by_product_type,
fmd.scale_multiple,
fmd.scale_rounding_variance,
xxen_util.meaning(to_char(fmd.rounding_direction),'GMD_ROUNDING_DIRECTION',552) rounding_direction,
fmd.ingredient_end_date,
to_char(null) delete_line,
xxen_util.display_flexfield_context(552,'FORMULA_FLEX',ffmv.attribute_category) fa_attribute_category,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE1',ffmv.rowid,ffmv.attribute1) fa_attribute1,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE2',ffmv.rowid,ffmv.attribute2) fa_attribute2,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE3',ffmv.rowid,ffmv.attribute3) fa_attribute3,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE4',ffmv.rowid,ffmv.attribute4) fa_attribute4,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE5',ffmv.rowid,ffmv.attribute5) fa_attribute5,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE6',ffmv.rowid,ffmv.attribute6) fa_attribute6,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE7',ffmv.rowid,ffmv.attribute7) fa_attribute7,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE8',ffmv.rowid,ffmv.attribute8) fa_attribute8,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE9',ffmv.rowid,ffmv.attribute9) fa_attribute9,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE10',ffmv.rowid,ffmv.attribute10) fa_attribute10,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE11',ffmv.rowid,ffmv.attribute11) fa_attribute11,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE12',ffmv.rowid,ffmv.attribute12) fa_attribute12,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE13',ffmv.rowid,ffmv.attribute13) fa_attribute13,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE14',ffmv.rowid,ffmv.attribute14) fa_attribute14,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE15',ffmv.rowid,ffmv.attribute15) fa_attribute15,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE16',ffmv.rowid,ffmv.attribute16) fa_attribute16,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE17',ffmv.rowid,ffmv.attribute17) fa_attribute17,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE18',ffmv.rowid,ffmv.attribute18) fa_attribute18,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE19',ffmv.rowid,ffmv.attribute19) fa_attribute19,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE20',ffmv.rowid,ffmv.attribute20) fa_attribute20,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE21',ffmv.rowid,ffmv.attribute21) fa_attribute21,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE22',ffmv.rowid,ffmv.attribute22) fa_attribute22,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE23',ffmv.rowid,ffmv.attribute23) fa_attribute23,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE24',ffmv.rowid,ffmv.attribute24) fa_attribute24,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE25',ffmv.rowid,ffmv.attribute25) fa_attribute25,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE26',ffmv.rowid,ffmv.attribute26) fa_attribute26,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE27',ffmv.rowid,ffmv.attribute27) fa_attribute27,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE28',ffmv.rowid,ffmv.attribute28) fa_attribute28,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE29',ffmv.rowid,ffmv.attribute29) fa_attribute29,
xxen_util.display_flexfield_value(552,'FORMULA_FLEX',ffmv.attribute_category,'ATTRIBUTE30',ffmv.rowid,ffmv.attribute30) fa_attribute30,
xxen_util.display_flexfield_context(552,'FM_DETAIL_FLEX',fmd.attribute_category) ld_attribute_category,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE1',fmd.rowid,fmd.attribute1) ld_attribute1,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE2',fmd.rowid,fmd.attribute2) ld_attribute2,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE3',fmd.rowid,fmd.attribute3) ld_attribute3,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE4',fmd.rowid,fmd.attribute4) ld_attribute4,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE5',fmd.rowid,fmd.attribute5) ld_attribute5,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE6',fmd.rowid,fmd.attribute6) ld_attribute6,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE7',fmd.rowid,fmd.attribute7) ld_attribute7,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE8',fmd.rowid,fmd.attribute8) ld_attribute8,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE9',fmd.rowid,fmd.attribute9) ld_attribute9,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE10',fmd.rowid,fmd.attribute10) ld_attribute10,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE11',fmd.rowid,fmd.attribute11) ld_attribute11,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE12',fmd.rowid,fmd.attribute12) ld_attribute12,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE13',fmd.rowid,fmd.attribute13) ld_attribute13,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE14',fmd.rowid,fmd.attribute14) ld_attribute14,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE15',fmd.rowid,fmd.attribute15) ld_attribute15,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE16',fmd.rowid,fmd.attribute16) ld_attribute16,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE17',fmd.rowid,fmd.attribute17) ld_attribute17,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE18',fmd.rowid,fmd.attribute18) ld_attribute18,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE19',fmd.rowid,fmd.attribute19) ld_attribute19,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE20',fmd.rowid,fmd.attribute20) ld_attribute20,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE21',fmd.rowid,fmd.attribute21) ld_attribute21,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE22',fmd.rowid,fmd.attribute22) ld_attribute22,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE23',fmd.rowid,fmd.attribute23) ld_attribute23,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE24',fmd.rowid,fmd.attribute24) ld_attribute24,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE25',fmd.rowid,fmd.attribute25) ld_attribute25,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE26',fmd.rowid,fmd.attribute26) ld_attribute26,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE27',fmd.rowid,fmd.attribute27) ld_attribute27,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE28',fmd.rowid,fmd.attribute28) ld_attribute28,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE29',fmd.rowid,fmd.attribute29) ld_attribute29,
xxen_util.display_flexfield_value(552,'FM_DETAIL_FLEX',fmd.attribute_category,'ATTRIBUTE30',fmd.rowid,fmd.attribute30) ld_attribute30,
ffmv.formula_id,
fmd.formulaline_id formula_line_id,
decode(fmd.line_type,1,1,-1,2,2,3) line_type_sort
from
fm_form_mst_vl ffmv,
fm_matl_dtl fmd,
mtl_parameters mp,
mtl_system_items_vl msiv
where
ffmv.formula_id=fmd.formula_id and
ffmv.owner_organization_id=mp.organization_id and
fmd.inventory_item_id=msiv.inventory_item_id and
fmd.organization_id=msiv.organization_id and
ffmv.delete_mark=0 and
nvl(ffmv.inactive_ind,0)=0 and
ffmv.owner_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
:p_upload_mode like '%'||xxen_upload.action_update
) x
where
1=1