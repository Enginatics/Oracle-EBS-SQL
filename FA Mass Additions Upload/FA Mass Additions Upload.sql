/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Mass Additions Upload
-- Description: Maintains Oracle Assets Prepare Mass Additions queue lines.
-- Use the Operation column to choose what each row does: Update (change fields and/or Queue), Create (add a new mass addition line), Merge, Split, Unsplit, Add to Asset or Undo Add to Asset.
-- Queue (Post, On Hold, Delete, On-Review) sets the posting status of the line on an Update.
-- Merge combines the lines that share a Merge Group label into the one row marked Primary Line = Yes; that line is kept as the asset and accumulates the cost of the other lines (and their units when Sum Units = Yes), and is set to On Hold.
-- The Attribute columns are the asset descriptive flexfield. Its context is the asset category, as in Oracle Assets, so the context column follows Category and only the attributes of that category can be entered.
-- After uploading, run the standard Post Mass Additions program to create the assets, exactly as today. Existing lines are matched on Book plus Invoice Number, Distribution Line and Invoice Line.
-- Supplier, PO Number, Project, Task, Creation Date and Created By show the source of a line and are not uploaded.
-- Excel Example Output: https://www.enginatics.com/example/fa-mass-additions-upload/
-- Library Link: https://www.enginatics.com/reports/fa-mass-additions-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
'Update' operation,
xma.book_type_code book,
xma.invoice_number,
xma.ap_distribution_line_number distribution_line,
xma.invoice_line_number invoice_line,
(select falu.meaning from fa_lookups falu where falu.lookup_type='QUEUE NAME' and falu.lookup_code=xma.queue_name) queue,
xma.description,
(select falu.meaning from fa_lookups falu where falu.lookup_type='ASSET TYPE' and falu.lookup_code=xma.asset_type) asset_type,
(select fcbk.concatenated_segments from fa_categories_b_kfv fcbk where fcbk.category_id=xma.asset_category_id) category,
xma.asset_number,
xma.tag_number,
xma.serial_number,
xma.fixed_assets_units units,
xma.fixed_assets_cost cost,
xma.date_placed_in_service,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id=xma.expense_code_combination_id) expense_account,
(select flk.concatenated_segments from fa_locations_kfv flk where flk.location_id=xma.location_id) location,
(select papf.employee_number from per_all_people_f papf where papf.person_id=xma.assigned_to and trunc(sysdate) between papf.effective_start_date and papf.effective_end_date) employee_number,
(select falu.meaning from fa_lookups falu where falu.lookup_type='YESNO' and falu.lookup_code=xma.depreciate_flag) depreciate,
to_char(null) merge_group,
to_char(null) primary_line,
to_char(null) sum_units,
(select fab.asset_number from fa_additions_b fab where fab.asset_id=xma.add_to_asset_id) add_to_asset_number,
(select falu.meaning from fa_lookups falu where falu.lookup_type='YESNO' and falu.lookup_code=xma.amortize_flag) amortize,
coalesce(xxen_util.display_flexfield_context(140,'FA_ADDITIONS',xma.attribute_category_code),(select fdfcv.descriptive_flex_context_name from fa_categories_b_kfv fcbk, fnd_descr_flex_contexts_vl fdfcv where fcbk.category_id=xma.asset_category_id and fcbk.concatenated_segments=fdfcv.descriptive_flex_context_code and fdfcv.application_id=140 and fdfcv.descriptive_flexfield_name='FA_ADDITIONS' and fdfcv.enabled_flag='Y')) attribute_category,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE1',null,xma.attribute1) attribute1,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE2',null,xma.attribute2) attribute2,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE3',null,xma.attribute3) attribute3,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE4',null,xma.attribute4) attribute4,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE5',null,xma.attribute5) attribute5,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE6',null,xma.attribute6) attribute6,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE7',null,xma.attribute7) attribute7,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE8',null,xma.attribute8) attribute8,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE9',null,xma.attribute9) attribute9,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE10',null,xma.attribute10) attribute10,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE11',null,xma.attribute11) attribute11,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE12',null,xma.attribute12) attribute12,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE13',null,xma.attribute13) attribute13,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE14',null,xma.attribute14) attribute14,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE15',null,xma.attribute15) attribute15,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE16',null,xma.attribute16) attribute16,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE17',null,xma.attribute17) attribute17,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE18',null,xma.attribute18) attribute18,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE19',null,xma.attribute19) attribute19,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE20',null,xma.attribute20) attribute20,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE21',null,xma.attribute21) attribute21,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE22',null,xma.attribute22) attribute22,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE23',null,xma.attribute23) attribute23,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE24',null,xma.attribute24) attribute24,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE25',null,xma.attribute25) attribute25,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE26',null,xma.attribute26) attribute26,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE27',null,xma.attribute27) attribute27,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE28',null,xma.attribute28) attribute28,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE29',null,xma.attribute29) attribute29,
xxen_util.display_flexfield_value(140,'FA_ADDITIONS',xma.attribute_category_code,'ATTRIBUTE30',null,xma.attribute30) attribute30,
(select aps.vendor_name from ap_suppliers aps where xma.po_vendor_id=aps.vendor_id) supplier,
(select aps.segment1 from ap_suppliers aps where xma.po_vendor_id=aps.vendor_id) supplier_number,
xma.po_number,
(select ppa.segment1 from pa_projects_all ppa where xma.project_id=ppa.project_id) project,
(select pt.task_number from pa_tasks pt where xma.task_id=pt.task_id) task,
xma.creation_date,
xxen_util.user_name(xma.created_by) created_by,
xma.mass_addition_id,
xma.mass_addition_id upload_row
from
fa_mass_additions xma
where
xma.posting_status not in ('POSTED','MERGED','SPLIT') and
1=1
