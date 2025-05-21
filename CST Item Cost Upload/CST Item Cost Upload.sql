/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
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

Note: The Item Cost Interface only support importing ‘This Level’ costs, As such, this upload does not support the upload of rolled up costs. 

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
Source Cost Element
Exclude Source Cost Element
----------------
Optionally specify the source Cost Type from which to download the current Item Costs. For the scenarios where you want to amend the current items costs for a Cost Type or want to copy the current item costs for a Cost Type to a different Target Cost Type.

Additionally you can use the Source Cost Element  and Exclude Source Cost Element to restict the Cost Elements to be downloaded from the Source Cost Type.


Organization Code
-----------------
Optionally select the Organization(s) for which you want to download the Item Costs for

Item
----
Optionally select the Item(s) for which you want to download the Item Costs for

Make or Buy
----------------
Optionally restrict the items to be downloaded based on the Items Make or Buy status.


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

select
case when nvl2(:p_autopopulate_upload_status,'Y','N') = 'Y' then xxen_upload.action_meaning(xxen_upload.action_update) else null end action_,
case when nvl2(:p_autopopulate_upload_status,'Y','N') = 'Y' then xxen_upload.status_meaning(xxen_upload.status_new) else null end status_,
case when nvl2(:p_autopopulate_upload_status,'Y','N') = 'Y' then xxen_util.description('U_EXCEL_MSG_VALIDATION_PENDING','XXEN_REPORT_TRANSLATIONS',0) else null end message_,
to_number(null)         request_id_,
null modified_columns_,
null                    row_id,
-- Item
cct_t.cost_type target_cost_type,
mp.organization_code organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_or_buy,
xxen_util.meaning(cic.inventory_asset_flag,'SYS_YES_NO',700) inventory_asset,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
coalesce(cic.lot_size,msiv.std_lot_size,1) lot_size,
coalesce(cic.shrinkage_rate,msiv.shrinkage_rate,0) shrinkage_rate,
-- Item Cost Element Details
cdcv.cost_source_type,
cdcv.cost_element,
cdcv.resource_code sub_element,
cdcv.usage_rate_or_amount,
cdcv.basis,
cdcv.activity,
cdcv.activity_units,
cdcv.item_units,
-- other enterable fields
cdcv.operation_seq_num,
cdcv.department,
-- display only - calculated by Item Cost Import
cdcv.basis_factor,
cdcv.net_yield_or_shrinkage_factor,
cdcv.resource_rate,
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
to_number(null) group_id,
1 level_type,
1 rollup_source_type,
1 process_flag,
:p_upload_mode upload_mode
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
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
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
cdcv.cost_source_type =  xxen_util.meaning('1','CST_SOURCE_TYPE',700)