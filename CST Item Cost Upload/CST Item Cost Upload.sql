/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Item Cost Upload
-- Description: CST Item Cost Upload
==================
This upload can be used to 
- Upload New Item Costs
- Download the current Item Costs, Update, and Upload the amended item costs for a specified Cost Type
- Download the current item Costs from one Source cost type, update, and upload the amended item costs to a different Target Cost Type 

Parameters
==========

Target Cost Type (Required)
---------------------------
The Cost Type to which the Item Costs are to be uploaded to.

Mode (Required, Default: Remove and replace cost information)
-------------------------------------------------------------
The Item Cost Update Mode
- Remove and replace cost information
- Insert new Cost Information Only

Auto Populate Upload Columns (Default: Yes)
-------------------------------------------
Applies to downloaded Item Cost Entries only. If set to Yes, the downloaded records will be flagged ready for upload, even if though no changes have been made. 

If left blank, the downloaded records will only be flagged for upload when the user amends any data against a record. 

In this case, it is important to remember where an Item Cost has multiple cost elements, then all the cost element records for that item would need to be amended to flag them for update. Only records flagged for update are uploaded. If all cost elements for an item are to be uploaded, even if some do not require any amendment, then the user must trigger the record to be uploaded by making a change against the record.

Source Cost Type
----------------
Optionally specify the source Cost Type from which to download the current Item Costs. For the scenarios where you want to amend the current items costs for a Cost Type or want to copy the current item costs for a Cost Type to a different Target Cost Type.

Organization Code
-----------------
Optionally select the Organization(s) for which you want to download the Item Costs for

Item
----
Optionally select the Item(s) for which you want to download the Item Costs for

Exclude Rolled Up Items	(Required, Default: Yes)
------------------------------------------------
Specify Yes to exclude Items with Rolled Up Costs.
Specify No to include items with Rolled Up Costs.
Note: The Item Cost Interface only support importing ‘This Level’ costs.

Excluded Item Statuses (Default: Inactive)
------------------------------------------
Optionally specify the Item Statuses to be excluded in the download.


Notes on the Upload
===================
The generated upload Excel contains one record per elemental item cost.

The following columns in the Excel are display only and are populated initially on download, and then refreshed in the results excel after the upload is performed as they calculated during the Item Cost Import

- Basis Factor                  
- Net Yield Or Shrinkage Factor 
- Element Unit Cost             
- Item Material Cost            The summary Item Level Material Cost.
- Item Material Overhead Cost   The summary Item Level Material Overhead Cost.
- Item Resource Cost            The summary Item Level Resource Cost.
- Item Outside Processing Cost  The summary Item Level Outside Processing Cost.
- Item Overhead Cost            The summary Item Level Overhead Cost.
- Item Cost                     The summary Item Level Item Cost.
- Item Unburdened Cost          The summary Item Level Unburdened Cost.
- Item Burden Cost              The summary Item Level Burden Cost.
-- Excel Examle Output: https://www.enginatics.com/example/cst-item-cost-upload/
-- Library Link: https://www.enginatics.com/reports/cst-item-cost-upload/
-- Run Report: https://demo.enginatics.com/

select x.*
from
(
select
case when nvl2(:p_autopopulate_upload_status,'Y','N') = 'Y' then 'Update' else null end action_,
case when nvl2(:p_autopopulate_upload_status,'Y','N') = 'Y' then 'New' else null end status_,
case when nvl2(:p_autopopulate_upload_status,'Y','N') = 'Y' then 'Validation pending' else null end message_,
to_number(null)         request_id_,
null                    row_id,
-- Item
cct_t.cost_type target_cost_type,
mp.organization_code organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
-- cic.item_cost total_item_cost,
xxen_util.meaning(cic.inventory_asset_flag,'SYS_YES_NO',700) inventory_asset,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
cic.lot_size,
cic.shrinkage_rate,
-- Item Cost Element Details
cdcv.cost_element,
cdcv.resource_code sub_element,
cdcv.usage_rate_or_amount,
cdcv.basis,
cdcv.activity,
cdcv.activity_units,
cdcv.item_units,
cdcv.resource_rate,
-- other enterable fields
cdcv.operation_seq_num,
cdcv.department,
-- display only - calculated by Item Cost Import
cdcv.basis_factor,
cdcv.net_yield_or_shrinkage_factor,
cdcv.item_cost element_unit_cost,
-- Item Cost Summary Amounts
cic.material_cost item_material_cost,
cic.material_overhead_cost item_material_overhead_cost,
cic.resource_cost item_resource_cost,
cic.outside_processing_cost item_outside_processing_cost,
cic.overhead_cost item_overhead_cost,
cic.item_cost item_cost,
cic.unburdened_cost item_unburdened_cost,
cic.burden_cost item_burden_cost,
null last_update_date,
null last_updated_by,
null creation_date,
null created_by,
null last_update_login,
null group_id,
null level_type,
null rollup_source_type,
null process_flag,
null cost_type,
null upload_mode
--
from
cst_cost_types cct_s,
cst_cost_types cct_t,
cst_item_costs cic,
cst_detail_cost_view cdcv,
mtl_system_items_vl msiv,
mtl_parameters mp
where
1=1 and
:p_upload_mode = :p_upload_mode and
--
cct_s.cost_type = :p_source_cost_type and
cct_t.cost_type = :p_target_cost_type and
--
cct_s.cost_type_id = cic.cost_type_id and
cic.cost_type_id = cdcv.cost_type_id and
cic.organization_id = cdcv.organization_id and
cic.inventory_item_id = cdcv.inventory_item_id and
cic.organization_id = mp.organization_id and
cic.organization_id = msiv.organization_id and
cic.inventory_item_id = msiv.inventory_item_id and
cic.based_on_rollup_flag = decode(:p_exclude_rolled_up_items, 'N', cic.based_on_rollup_flag, 'Y', 2)
&not_use_first_block
&report_table_select
&report_table_name &report_table_where_clause
&success_records
&processed_run
) x
order by
x.target_cost_type,
x.organization_code,
x.item,
x.cost_element,
x.sub_element