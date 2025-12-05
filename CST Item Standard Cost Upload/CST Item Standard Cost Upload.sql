/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Item Standard Cost Upload
-- Description: CST Item Standard Cost Upload
=============================

This upload can be used to 
- Upload New Item Costs
- Download the current Item Costs, Update, and Upload the amended item costs for a specified Cost Type
- Download the current item Costs from one Source cost type, update, and upload the amended item costs to a different Target Cost Type

NOTE: 
You can only upload costs to cost types that are not flagged as frozen and are flagged as updateable. Typically, this upload is used for updating cost types using the standard costing method.   

Optionally, the upload can perform a Cost Rollup after the Item Costs have been imported. The Cost Rollup can be performed for
- Specific Items - a cost rollup will be done for only those items for which costs have been uploaded
- All Items - in this mode the upload will submit the 'Supply Chain Cost Rollup - Print Report' concurrent request to rollup all items within each organization costs are uploaded to

NOTE: 
The Item Cost Interface only support importing ‘This Level’ costs. As such, this upload does not support the direct upload of rolled up costs

Parameters
==========
Target Cost Type (Required) - The Cost Type to which the Item Costs are to be uploaded to.

Mode (Required, Default: Remove and replace cost information) -
The Item Cost Update Mode
- Remove and replace cost information
- Insert new Cost Information Only

Auto Populate Upload Columns (Default: Yes) -
Applies to downloaded Item Cost Entries only. If set to Yes, the downloaded records will be flagged ready for upload, even if though no changes have been made. 
If left blank, the downloaded records will only be flagged for upload when the user amends any data against a record. 
In this case, it is important to remember where an Item Cost has multiple cost elements, then all the cost element records for that item would need to be amended to flag them for update. Only records flagged for update are uploaded. If all cost elements for an item are to be uploaded, even if some do not require any amendment, then the user must trigger the record to be uploaded by making a change against the record.

Source Cost Type
Optionally specify the source Cost Type from which to download the current Item Costs. For the scenarios where you want to amend the current items costs for a Cost Type or want to copy the current item costs for a Cost Type to a different Target Cost Type.

Rollup Costs - set to Yes to do a cost rollup after the costs are uploaded
Rollup Type - Rollup specific Items or All Items
Rollup Option - Single level rollup or Full cost rollup 
  
Organization Code - Optionally select the Organization(s) for which you want to download the Item Costs for
Additional Parameters - The additional parameters are used to optionally restrict the items to be downloaded.

Notes on the Upload
===================
The generated upload Excel contains one record per elemental item cost.

The following columns in the Excel are display only and are populated initially on download, and then refreshed in the results excel after the upload is performed as they calculated during the Item Cost Import

- Basis Factor                  
- Net Yield or Shrinkage Factor 
- Element Unit Cost             
- Item Material Cost - the summary Item Level Material Cost.
- Item Material Overhead Cost - the summary Item Level Material Overhead Cost.
- Item Resource Cost - the Summary Item Level Resource Cost.
- Item Outside Processing Cost - the summary Item Level Outside Processing Cost.
- Item Overhead Cost - the summary Item Level Overhead Cost.
- Item Cost - the summary Item Level Item Cost.
- Item Unburdened Cost - the summary Item Level Unburdened Cost.
- Item Burden Cost - the summary Item Level Burden Cost.

-- Excel Examle Output: https://www.enginatics.com/example/cst-item-standard-cost-upload/
-- Library Link: https://www.enginatics.com/reports/cst-item-standard-cost-upload/
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
(select misv.inventory_item_status_code_tl from mtl_item_status_vl misv where misv.inventory_item_status_code = msiv.inventory_item_status_code) item_status,
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
:p_upload_mode upload_mode,
:p_do_cost_rollup rollup_costs,
:p_rollup_range rollup_type,
:p_rollup_option rollup_option,
:p_rollup_inc_unimp_ecn_flag rollup_unimpl_ecos
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
cic.cost_type_id = cdcv.cost_type_id (+) and
cic.organization_id = cdcv.organization_id (+) and
cic.inventory_item_id = cdcv.inventory_item_id (+) and
cic.organization_id = mp.organization_id and
cic.organization_id = msiv.organization_id and
cic.inventory_item_id = msiv.inventory_item_id and
(cdcv.cost_source_type =  xxen_util.meaning('1','CST_SOURCE_TYPE',700) or
 (nvl(:p_exclude_no_cost_iterms,'N') != 'Y' and
  not exists
  (select 
   null 
   from 
   cst_detail_cost_view cdcv2 
   where
   cdcv2.cost_type_id = cic.cost_type_id and
   cdcv2.organization_id = cic.organization_id and
   cdcv2.inventory_item_id = cic.inventory_item_id
  )
 )
)