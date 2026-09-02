/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Mass Additions Upload
-- Description: Maintains Oracle Assets Prepare Mass Additions queue lines.

Use the Operation column to choose what each row does: Update (change fields and/or Queue), Create (add a new mass addition line), Merge, Split, Unsplit, Add to Asset or Undo Add to Asset.

Queue (Post, On Hold, Delete, On-Review) sets the posting status of the line on an Update.

Merge combines the lines that share a Merge Group label into the one row marked Primary Line = Yes; that line is kept as the asset and accumulates the cost of the other lines (and their units when Sum Units = Yes), and is set to On Hold.

After uploading, run the standard Post Mass Additions program to create the assets, exactly as today. Existing lines are matched on Book plus Invoice Number, Distribution Line and Invoice Line.
-- Excel Examle Output: https://www.enginatics.com/example/fa-mass-additions-upload/
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
xxen_util.meaning(xma.queue_name,'QUEUE NAME',140) queue,
xma.description,
(select falu.meaning from fa_lookups falu where falu.lookup_type='ASSET TYPE' and falu.lookup_code=xma.asset_type) asset_type,
(select fcbk.concatenated_segments from fa_categories_b_kfv fcbk where fcbk.category_id=xma.asset_category_id) category,
xma.asset_number,
xma.fixed_assets_units units,
xma.fixed_assets_cost cost,
xma.date_placed_in_service,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id=xma.expense_code_combination_id) expense_account,
(select flk.concatenated_segments from fa_locations_kfv flk where flk.location_id=xma.location_id) location,
(select papf.employee_number from per_all_people_f papf where papf.person_id=xma.assigned_to and trunc(sysdate) between papf.effective_start_date and papf.effective_end_date) employee_number,
xxen_util.meaning(xma.depreciate_flag,'YES_NO',0) depreciate,
to_char(null) merge_group,
to_char(null) primary_line,
to_char(null) sum_units,
(select fab.asset_number from fa_additions_b fab where fab.asset_id=xma.add_to_asset_id) add_to_asset_number,
xxen_util.meaning(xma.amortize_flag,'YES_NO',0) amortize,
xma.mass_addition_id,
xma.mass_addition_id upload_row
from
fa_mass_additions xma
where
xma.posting_status not in ('POSTED','MERGED','SPLIT') and
1=1