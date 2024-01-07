/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Resource Efficiency with Method and Lot Variances
-- Description: Report your resource efficiency, method and lot size variances for your open and closed WIP jobs.  Resource efficiency measures the WIP routing requirements against the actual applied resources.  Methods variances measure the difference between the WIP routing and the primary routing (for routing operations effective per the schedule end date of your accounting period, or for Standard Costing, the Frozen item cost resource details).  And for Standard Costing, lot variances measure the lot-based resource cost variances due to differences between the planned WIP units or completed work order units and the standard costing lot size.  If the WIP job has a larger planned or completed number of units, the WIP Assembly CompIetion transaction will relieve a lower amount of lot charges than charged to the WIP job.  If the WIP job has a smaller planned or completed number of units, the WIP Assembly CompIetion transaction will relieve more lot values than charged to the job.  

If you leave the Cost Type parameter blank the report uses either your Costing Method Cost Type (Standard) or your Costing Method "Avg Rates" Cost Type (Average, FIFO, LIFO) for your resource rates.  If the WIP job is open the Report Type column displays "Valuation", as this WIP job and potential material usage variance is still in your WIP inventory balances.  If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction during the reporting period.  Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities.  All other WIP jobs use the parameter "Use Completion Quantities" to determine if completion or planned quantities are used for requirements.  If you choose Yes for including scrap, this report will automatically include the scrapped quantities as part of the resource quantity requirements.  And this report automatically includes WIP jobs which were either open during the reported accounting period or if closed, were closed doing the reporting period.

Parameters:
=========
Report Option:  You can choose to limit the report size with this parameter.  The choices are:  Open jobs, All jobs or Closed jobs. (mandatory)
Period Name:  Enter the Period_Name you wish to report for WIP Jobs (mandatory)
Cost Type:  Enter the resource rates cost type.  If left blank, the report uses the Costing Method rates cost type.
Include Scrap Quantities:  Include scrap for quantity requirements.  (mandatory)
Include Unreleased Jobs:  Include jobs which have not been released and are not started.  (mandatory)
Use Completion Quantities:  For Released jobs, use the completion quantities for resource variance calculations else use the planned start quantities (mandatory).
Category Set 1:  Choose any item category to report.  Does not limit what is reported.
Category Set 2:  Choose any item category to report.  Does not limit what is reported.
Class Code:  Specific WIP class code to report (optional).
Job Status:  Specific WIP job status to report (optional).
WIP Job:  Specific WIP job number to report (optional).
Resource Code:  Specific resource code to report (optional).
Outside Processing Item:  Specific outside processing component to report (optional).
Assembly Number:  Specific assembly to report (optional).
Organization Code:  Specific inventory organization you wish to report (optional)
Operating Unit:  Specific operating unit you wish to report (optional)
Ledger:  Specific ledger you wish to report (optional)

-- |   ======= =========== ============== =========================================
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     28 Jan 2010 Douglas Volz   Initial Coding
-- |  1.26    12 Oct 2022 Douglas Volz   Fix divide by zero error with the start quantity.
-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-resource-efficiency-with-method-and-lot-variances/
-- Library Link: https://www.enginatics.com/reports/cac-wip-resource-efficiency-with-method-and-lot-variances/
-- Run Report: https://demo.enginatics.com/

with wdj0 as
 (select wdj.wip_entity_id,
  wdj.organization_id,
  wdj.class_code,
  wdj.creation_date,
  wdj.scheduled_start_date,
  wdj.date_released,
  wdj.date_completed,
  wdj.date_closed,
  wdj.last_update_date,
  wdj.primary_item_id,
  wdj.lot_number,
  wdj.status_type,
  wdj.start_quantity,
  wdj.net_quantity,
  wdj.project_id,
  wdj.material_account,
  -- Revision for version 1.22
  wdj.resource_account,
  wdj.outside_processing_account,
  -- End revision for version 1.22
  wdj.quantity_completed,
  wdj.quantity_scrapped,
  oap.period_start_date,
  oap.schedule_close_date,
  oap.period_name,
  -- Revision for version 1.22
  (case
     when wdj.date_closed >= oap.period_start_date then 'Variance'
     -- the job is open
     when wdj.date_closed is null and wdj.creation_date < oap.schedule_close_date + 1 then 'Valuation'
     -- the job is closed and ...the job was closed after the accounting period
     when wdj.date_closed is not null and wdj.date_closed >= oap.schedule_close_date + 1 then 'Valuation'
   end
  ) Report_Type,
  -- End revision for version 1.22
  -- Revision for version 1.10
  oap.acct_period_id,
  mp.primary_cost_method,
  mp.organization_code,
  wac.class_type
  from wip_discrete_jobs wdj,
  org_acct_periods oap,
  mtl_parameters mp,
  wip_accounting_classes wac
  where wdj.class_code = wac.class_code
  and wdj.organization_id = wac.organization_id
  and wac.class_type in (1,3,5)
  and oap.organization_id             = wdj.organization_id
  and mp.organization_id              = wdj.organization_id
  -- find jobs that were open or closed during or after the report period
  -- the job is open or opened before the period close date
  and ( (wdj.date_closed is null -- the job is open
     and wdj.creation_date <  oap.schedule_close_date + 1
     and :p_report_option in ('Open jobs', 'All jobs')    -- p_report_option
    )
    or -- the job is closed and ...the job was closed after the accounting period 
    (wdj.date_closed is not null
     and wdj.date_closed >= oap.schedule_close_date + 1
     and :p_report_option in ('Open jobs', 'All jobs')    -- p_report_option
    )
    or -- find jobs that were closed during the report period
    (wdj.date_closed >= oap.period_start_date
     and wdj.date_closed < oap.schedule_close_date + 1
     and :p_report_option in ('Closed jobs', 'All jobs')  -- p_report_option
    )
  )
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code
  and 3=3                             -- p_assembly_number
  and 4=4                             -- p_period_name, p_wip_job, wip_status, p_wip_class_code 
 ),
wdj as
 (select wdjsum.wip_entity_id,
  wdjsum.organization_id,
  wdjsum.class_code,
  wdjsum.creation_date,
  wdjsum.scheduled_start_date,
  wdjsum.date_released,
  wdjsum.date_closed,
  wdjsum.date_completed,
  wdjsum.last_update_date,
  wdjsum.primary_item_id,
  wdjsum.lot_number,
  wdjsum.status_type,
  wdjsum.start_quantity,
  wdjsum.net_quantity,
  wdjsum.project_id,
  wdjsum.material_account,
  -- Revision for version 1.22
  wdjsum.resource_account,
  wdjsum.outside_processing_account,
  -- End revision for version 1.22
  wdjsum.period_start_date,
  wdjsum.schedule_close_date,
  wdjsum.period_name,
  -- Revision for version 1.22
  wdjsum.report_type,
  -- Revision for version 1.10
  wdjsum.acct_period_id,
  wdjsum.primary_cost_method,
  wdjsum.organization_code,
  wdjsum.class_type,
  sum (wdjsum.quantity_completed) quantity_completed,
  sum (wdjsum.quantity_scrapped) quantity_scrapped,
  -- Revision for version 1.1, if scrap is not financially recorded do not include in component requirements
  sum(decode(:p_include_scrap, 'N', 0, wdjsum.quantity_scrapped)) adj_quantity_scrapped
  from (select wdj0.*
   from wdj0
   union all
   select wdj0.wip_entity_id,
   wdj0.organization_id,
   wdj0.class_code,
   wdj0.creation_date,
   wdj0.scheduled_start_date,
   wdj0.date_released,
   wdj0.date_completed,
   wdj0.date_closed,
   wdj0.last_update_date,
   wdj0.primary_item_id,
   wdj0.lot_number,
   wdj0.status_type,
   wdj0.start_quantity,
   wdj0.net_quantity,
   wdj0.project_id,
   wdj0.material_account,
   -- Revision for version 1.22
   wdj0.resource_account,
   wdj0.outside_processing_account,
   -- End revision for version 1.22
   decode(mmt.transaction_type_id,
    90, 0,                         -- scrap assemblies from wip
    91, 0,                         -- return assemblies scrapped from wip
    44, -1 * mmt.primary_quantity, -- wip completion
    17, mmt.primary_quantity       -- wip completion return
         ) quantity_completed,
   decode(mmt.transaction_type_id,
    90, mmt.primary_quantity,      -- scrap assemblies from wip
    91, -1 * mmt.primary_quantity, -- return assemblies scrapped from wip
    44, 0,                         -- wip completion
    17, 0                          -- wip completion return
         ) quantity_scrapped,
   wdj0.period_start_date,
   wdj0.schedule_close_date,
   wdj0.period_name,
   -- Revision for version 1.22
   wdj0.report_type,
   -- Revision for version 1.10
   wdj0.acct_period_id,
   wdj0.primary_cost_method,
   wdj0.organization_code,
   wdj0.class_type
   from wdj0,
   mtl_material_transactions mmt
   where mmt.transaction_source_type_id  = 5
   and mmt.transaction_source_id       = wdj0.wip_entity_id
   and mmt.transaction_date           >= wdj0.schedule_close_date + 1
   and wdj0.organization_id             = mmt.organization_id
  ) wdjsum
 group by
  wdjsum.wip_entity_id,
  wdjsum.organization_id,
  wdjsum.class_code,
  wdjsum.creation_date,
  wdjsum.scheduled_start_date,
  wdjsum.date_released,
  wdjsum.date_completed,
  wdjsum.date_closed,
  wdjsum.last_update_date,
  wdjsum.primary_item_id,
  wdjsum.lot_number,
  wdjsum.status_type,
  wdjsum.start_quantity,
  wdjsum.net_quantity,
  wdjsum.project_id,
  wdjsum.material_account,
  -- Revision for version 1.22
  wdjsum.resource_account,
  wdjsum.outside_processing_account,
  -- End revision for version 1.22
  wdjsum.period_start_date,
  wdjsum.schedule_close_date,
  wdjsum.period_name,
  -- Revision for version 1.22
  wdjsum.report_type,
  -- Revision for version 1.10
  wdjsum.acct_period_id,
  wdjsum.primary_cost_method,
  wdjsum.organization_code,
  wdjsum.class_type
 ),
-- Revision for version 1.22
wdj_assys as (select distinct wdj.primary_item_id, wdj.organization_id, wdj.primary_cost_method from wdj) 
----------------main query starts here--------------

select res_sum.report_type Report_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 res_sum.organization_code Org_Code,
 res_sum.period_name Period_Name,
 &segment_columns
 res_sum.class_code WIP_Class,
 ml1.meaning Class_Type,
 we.wip_entity_name WIP_Job,
 (select ppa.segment1
  from pa_projects_all ppa
  where ppa.project_id = res_sum.project_id) Project_Number,
 ml2.meaning Job_Status,
 -- Revision for version 1.21
 res_sum.creation_date Creation_Date,
 res_sum.scheduled_start_date Scheduled_Start_Date,
 -- End revision for version 1.21
 res_sum.date_released Date_Released,
 res_sum.date_completed Date_Completed,
 res_sum.date_closed Date_Closed,
 res_sum.last_update_date Last_Update_Date,
 muomv.uom_code UOM_Code,
 msiv_fg.std_lot_size Item_Std_Lot_Size,
 -- Revision for version 1.22
 cic.cost_type Lot_Size_Cost_Type,
 nvl(cic.lot_size, 1) Costing_Lot_Size, 
 res_sum.start_quantity Start_Quantity,
 res_sum.quantity_completed Assembly_Quantity_Completed,
 res_sum.quantity_scrapped Assembly_Quantity_Scrapped,
 res_sum.fg_total_qty Total_Assembly_Quantity,
 msiv_fg.concatenated_segments Assembly,
 msiv_fg.description Assembly_Description,
 -- Revision for version 1.22
 fl.meaning Rolled_Up,
 cic.last_rollup_date Last_Cost_Rollup,
 -- End revision for version 1.22
 fcl.meaning Item_Type,
 misv.inventory_item_status_code Item_Status,
 ml4.meaning Make_Buy_Code,
&category_columns
 -- Revision for version 1.22
 res_sum.lot_number Lot_Number,
 msiv_osp.concatenated_segments  Outside_Processing_Item,
 msiv_osp.description OSP_Description,
 (select poh.segment1
  from po_headers_all poh
  where poh.po_header_id = res_sum.po_header_id) PO_Number,
 decode(res_sum.line_num, 0, null, res_sum.line_num) Line_Number,
 decode(res_sum.release_num, 0, null, res_sum.release_num) PO_Release,
 bd.department_code Department,
 res_sum.operation_seq_num Operation_Seq_Number,
 res_sum.resource_seq_num Resource_Seq_Number,
 res_sum.resource_code Resource_Code,
 -- Revision for version 1.22
 res_sum.description Resource_Description,
 -- Revision for version 1.25
 ml5.meaning Auto_Charge,
 ml6.meaning Std_Rate,
 -- End revision for version 1.25
 ml3.meaning Basis_Type,
 -- Revision for version 1.25
 (select poh.currency_code
  from po_headers_all poh
  where poh.po_header_id = res_sum.po_header_id) PO_Currency_Code,
 -- End revision for version 1.25
 -- Revision for version 1.17
 decode(res_sum.line_num, 0, null, res_sum.po_unit_price) PO_Unit_Price,
 res_sum.cost_type Resource_Cost_Type,
 -- Revision for version 1.21
 gl.currency_code Currency_Code,
 res_sum.resource_rate Resource_Rate,
 res_sum.res_unit_of_measure Resource_UOM_Code, 
 res_sum.usage_rate_or_amount Quantity_Per_Assembly,
 round(res_sum.total_req_quantity,3)  Total_Required_Quantity,
 round(res_sum.applied_resource_units,3) Total_Units_Applied,
 -- Revision for version 1.17
 -- res_sum.qty_variance Quantity_Variance,
 round(res_sum.applied_resource_units - res_sum.total_req_quantity,3) Quantity_Variance,
 res_sum.std_resource_value Standard_Resource_Value,
 round(res_sum.applied_resource_value,2) Applied_Resource_Value,
 -- res_sum.res_efficiency_variance Resource_Efficiency_Variance,
 round(res_sum.applied_resource_value - res_sum.std_resource_value,2) Resource_Efficiency_Variance,
 round(res_sum.std_usage_rate_or_amount,3) Std_Quantity_Per_Assembly,
 round(res_sum.std_total_req_quantity,3) Total_Std_Required_Quantity,
 -- Revision for version 1.18
 -- round(nvl(res_sum.std_total_req_quantity,0) - nvl(res_sum.total_req_quantity,0),3) Methods_Quantity_Variance,
 -- round((nvl(res_sum.total_req_quantity,0) - nvl(res_sum.std_total_req_quantity,0)) * res_sum.resource_rate,2) Resource_Methods_Variance,
 -- Revision for version 1.19
 -- round(nvl(res_sum.total_req_quantity,0) - nvl(res_sum.std_total_req_quantity,0),3)  Methods_Quantity_Variance,
 -- round((nvl(res_sum.total_req_quantity,0) - nvl(res_sum.std_total_req_quantity,0)) * res_sum.resource_rate,2) Resource_Methods_Variance,
 case
    when nvl(res_sum.basis_type, 1) <> 1 then 0
    -- Revision for version 1.20
    -- when nvl(res_sum.total_req_quantity,0) = 0 then 0
    -- Revision for version 1.21
    -- when nvl(res_sum.std_total_req_quantity,0) = 0 then 0
    -- Revision for version 1.22
    -- when res_sum.class_type = 3 then 0 -- 3 - non-standard job
    when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
    when cic.rolled_up = 'N' then 0
    -- End revision for version 1.22
    when nvl(res_sum.std_total_req_quantity,0) = 0 and nvl(res_sum.total_req_quantity,0) = 0 then 0
    else round(nvl(res_sum.total_req_quantity,0) - nvl(res_sum.std_total_req_quantity,0),3)
    -- End revision for version 1.21
 end  Methods_Quantity_Variance,
 case
    when nvl(res_sum.basis_type, 1) <> 1 then 0
    -- Revision for version 1.20
    -- when nvl(res_sum.total_req_quantity,0) = 0 then 0
    -- Revision for version 1.21
    -- when nvl(res_sum.std_total_req_quantity,0) = 0 then 0
    -- Revision for version 1.22
    -- Add parameter for non-standard jobs.
    -- when res_sum.class_type = 3 then 0 -- 3 - non-standard job
    when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
    -- Zero out the resource efficiency calculation when there are no completions and no applied quantities.
    when res_sum.fg_total_qty = 0 and round(res_sum.applied_resource_value,2) = 0
  then -1 * (round(res_sum.applied_resource_value - res_sum.std_resource_value,2))
    when cic.rolled_up = 'N' then 0
    -- End revision for version 1.22    
    when nvl(res_sum.std_total_req_quantity,0) = 0 and nvl(res_sum.total_req_quantity,0) = 0 then 0
    -- End revision for version 1.21
    else round((nvl(res_sum.total_req_quantity,0) - nvl(res_sum.std_total_req_quantity,0)) * res_sum.resource_rate,2)
 end  Resource_Methods_Variance,
 -- End revision for version 1.17
 -- End revision for version 1.18
 -- End revision for version 1.19
 -- WIP Setup Charges Per Unit
 case
    when nvl(res_sum.basis_type, 1) <> 2 then 0
    -- Revision for version 1.22
    when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
    when cic.rolled_up = 'N' then 0
    -- End revision for version 1.22
    when res_sum.usage_rate_or_amount = 0 then 0
    -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
    -- Revision for version 1.22
    when res_sum.status_type in (4,5,7,12,14,15)
  then round(res_sum.usage_rate_or_amount * res_sum.resource_rate / (decode(res_sum.quantity_completed, 0, 1, res_sum.quantity_completed) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),5)
    -- Revision for version 1.21
    when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'Y' -- Released but has completion quantities
  then round(res_sum.usage_rate_or_amount * res_sum.resource_rate / (decode(res_sum.quantity_completed, 0, 1, res_sum.quantity_completed) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),5)
    when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'N' -- Released but does not has completion quantities 
  -- Revision for version 1.26
  -- then round(res_sum.usage_rate_or_amount * res_sum.resource_rate / res_sum.start_quantity,5)
  then round(res_sum.usage_rate_or_amount * res_sum.resource_rate / decode(res_sum.start_quantity,0,1,res_sum.start_quantity),5)
    -- End revision for version 1.21
    -- Revision for version 1.26
    -- else round(res_sum.usage_rate_or_amount * res_sum.resource_rate / res_sum.start_quantity,5)
    else round(res_sum.usage_rate_or_amount * res_sum.resource_rate / decode(res_sum.start_quantity,0,1,res_sum.start_quantity),5)
    -- End revision for version 1.26
 end WIP_Lot_Charges_Per_Unit,
 -- Standard Setup Charges Per Unit
 case
    when nvl(res_sum.basis_type, 1) <> 2 then 0
    -- Revision for version 1.22
    when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
    when cic.rolled_up = 'N' then 0
    -- End revision for version 1.22
    when res_sum.std_usage_rate_or_amount = 0 then 0
    else round(res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1),5)
 end Std_Lot_Charges_Per_Unit, 
 -- WIP Setup Charges per unit - Std Setup Charges per unit = Lot_Size_Variance
 --   when primary_cost_method is not Frozen (1) then zero
 --   when standard lot size is null then zero
 --   when res_sum.basis_type is null then zero
 --   when res_sum.basis_type <> lot (2) then zero
 case
    when res_sum.primary_cost_method <> 1 then 0
    when cic.lot_size is null then 0
    when nvl(res_sum.basis_type, 1) <> 2 then 0
    -- Revision for version 1.22
    when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
    when cic.rolled_up = 'N' then 0
    -- End revision for version 1.22
    -- Revision for version 1.20
    -- when res_sum.usage_rate_or_amount = 0 then 0
    when res_sum.std_usage_rate_or_amount = 0 then 0
    -- Revision for version 1.22
    when res_sum.status_type in (4,5,7,12,14,15)
  then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1) * 
   (nvl(res_sum.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),2)
    -- Revision for version 1.21
    when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'Y' -- Released but has completion quantities
  then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1) * 
   (nvl(res_sum.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),2)
    when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'N' -- Released but has no completion quantities 
  -- Revision for version 1.26
  -- then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1) * res_sum.start_quantity),2)
  then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1) * decode(res_sum.start_quantity,0,1,res_sum.start_quantity)),2)
    -- End revision for version 1.21
    -- else round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1) * res_sum.start_quantity),2)
    else round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1) * decode(res_sum.start_quantity,0,1,res_sum.start_quantity)),2)
    -- End revision for version 1.26
 end Lot_Size_Variance,
 -- Revision for version 1.20, total all resource variances
 -- Total Resource Variance = Resource_Efficiency_Variance + Resource_Methods_Variance + Lot_Size_Variance
 -- Resource_Efficiency_Variance
 round(res_sum.applied_resource_value - res_sum.std_resource_value,2) +
 -- Resource_Methods_Variance
 case
    when nvl(res_sum.basis_type, 1) <> 1 then 0
    -- Revision for version 1.21
    -- when nvl(res_sum.std_total_req_quantity,0) = 0 then 0
    -- Revision for version 1.22
    -- when res_sum.class_type = 3 then 0 -- 3 - non-standard job
    when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
    when cic.rolled_up = 'N' then 0
    -- End revision for version 1.22
    when nvl(res_sum.std_total_req_quantity,0) = 0 and nvl(res_sum.total_req_quantity,0) = 0 then 0
    -- End revision for version 1.21
    else round((nvl(res_sum.total_req_quantity,0) - nvl(res_sum.std_total_req_quantity,0)) * res_sum.resource_rate,2)
 end  +
 -- Lot_Size_Variance
 case
    when res_sum.primary_cost_method <> 1 then 0
    when cic.lot_size is null then 0
    when nvl(res_sum.basis_type, 1) <> 2 then 0
    -- Revision for version 1.22
    when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
    when cic.rolled_up = 'N' then 0
    -- End revision for version 1.22
    when res_sum.std_usage_rate_or_amount = 0 then 0
    -- Revision for version 1.22
    when res_sum.status_type in (4,5,7,12,14,15)
  then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1) * 
   (nvl(res_sum.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),2)
    -- Revision for version 1.21
    when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'Y' -- Released but has completion quantities
  then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1) * 
   (nvl(res_sum.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),2)
    when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'N' -- Released but has completion quantities 
  -- Revision for version 1.26
  -- then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1) * res_sum.start_quantity),2)
  then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1) * decode(res_sum.start_quantity,0,1,res_sum.start_quantity)),2)
    -- End revision for version 1.21
    -- else round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1) * res_sum.start_quantity),2)
    else round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic.lot_size,1) * decode(res_sum.start_quantity,0,1,res_sum.start_quantity)),2)
    -- End revision for version 1.26
 end Total_Resource_Variance
from mtl_system_items_vl msiv_fg,
 mtl_system_items_vl msiv_osp,
 mtl_units_of_measure_vl muomv,
 mtl_item_status_vl misv,
 bom_departments bd,
 wip_entities we,
 mfg_lookups ml1, -- WIP Class
 mfg_lookups ml2, -- WIP Status
 mfg_lookups ml3, -- Basis Type
 mfg_lookups ml4, -- Planning Make Buy
 -- Revision for version 1.25
 mfg_lookups ml5, -- Autocharge Type
 mfg_lookups ml6, -- Standard Rate
 -- End revision for version 1.25
 -- Revision for version 1.22
 fnd_lookups fl, -- Rolled Up
 fnd_common_lookups fcl, -- Item Type
 gl_code_combinations gcc,  -- wip job accounts
 hr_organization_information hoi,
 hr_all_organization_units haou,
 hr_all_organization_units haou2,
 gl_ledgers gl,
 -- Revision for version 1.22
 -- cst_item_costs cic,
 -- Get the assembly cost type, lot size and cost rollup status
 (select cic.organization_id,
  cic.inventory_item_id,
  cct.cost_type,
  cic.lot_size,
  case
     when sum(case
    when cic.based_on_rollup_flag = 1 and cicd.rollup_source_type = 3 and cicd.attribute15 is null then 1
    else 0
       end) > 0 then 'Y'
     else 'N'
  end rolled_up,
  max(case
   when cic.based_on_rollup_flag = 1 and cicd.rollup_source_type = 3 and cicd.attribute15 is null then cicd.creation_date
   else null
      end) last_rollup_date
  from cst_item_costs cic,
  cst_item_cost_details cicd,
  cst_cost_types cct,
  -- Limit to assemblies on WIP jobs
  wdj_assys
  where cic.organization_id          = cicd.organization_id (+)
  and cic.inventory_item_id        = cicd.inventory_item_id (+)
  and cic.cost_type_id             = cicd.cost_type_id (+)
  and cic.inventory_item_id        = wdj_assys.primary_item_id
  and cic.organization_id          = wdj_assys.organization_id
  and cct.cost_type_id             = cic.cost_type_id
  -- Revision for version 1.22 and 1.23
  and cct.cost_type                = decode(:p_cost_type,
       null, (select cct.cost_type 
              from   dual 
              where  cct.cost_type_id = wdj_assys.primary_cost_method
             ), 
       :p_cost_type
            )
  group by
  cic.organization_id,
  cic.inventory_item_id,
  cct.cost_type,
  cic.cost_type_id,
  cic.lot_size
  union all
  select cic.organization_id,
  cic.inventory_item_id,
  cct.cost_type,
  cic.lot_size,
  case
     when sum(case
    when cic.based_on_rollup_flag = 1 and cicd.rollup_source_type = 3 and cicd.attribute15 is null then 1
    else 0
       end) > 0 then 'Y'
     else 'N'
  end rolled_up,
  max(case
   when cic.based_on_rollup_flag = 1 and cicd.rollup_source_type = 3 and cicd.attribute15 is null then cicd.creation_date
   else null
      end) last_rollup_date
  from cst_item_costs cic,
  cst_item_cost_details cicd,
  cst_cost_types cct,
  -- Limit to assemblies on WIP jobs
  wdj_assys
  where cic.cost_type_id             = cicd.cost_type_id (+)
  and cic.inventory_item_id        = cicd.inventory_item_id (+)
  and cic.organization_id          = cicd.organization_id (+)
  and cic.inventory_item_id        = wdj_assys.primary_item_id
  and cic.organization_id          = wdj_assys.organization_id
  and cic.cost_type_id             = wdj_assys.primary_cost_method  -- this gets the Frozen Costs
  and cct.cost_type_id            <> wdj_assys.primary_cost_method  -- this avoids getting the Frozen costs twice
  -- Revision for version 1.22 and 1.23
  and cct.cost_type                = decode(:p_cost_type,
       null, (select cct.cost_type 
              from   dual 
              where  cct.cost_type_id = wdj_assys.primary_cost_method
             ), 
       :p_cost_type
            )
  -- ====================================
  -- Find all the Frozen costs not in the
  -- Pending or unimplemented cost type
  -- ====================================
  and not exists (
   select 'x'
   from cst_item_costs cic2
   where cic2.organization_id   = cic.organization_id
   and cic2.inventory_item_id = cic.inventory_item_id
   and cic2.cost_type_id      = cct.cost_type_id)
  group by
  cic.organization_id,
  cic.inventory_item_id,
  cct.cost_type,
  cic.cost_type_id,
  cic.lot_size
 ) cic,
 -- End revision for version 1.22
 -- ========================================================
 -- Get the WIP Resource Information in a three part union
 -- which is then condensed into a summary data set
 -- ========================================================
 -- ========================================================
 -- Section I  Condense into a summary data set.
 -- =======================================================
 (select res.report_type,
  res.period_name,
  res.organization_code,
  res.organization_id,
  res.primary_cost_method,
  res.account,
  res.class_code,
  res.class_type,
  res.wip_entity_id,
  res.project_id,
  res.status_type,
  res.primary_item_id,
  -- Revision for version 1.22
  res.lot_number,
  -- Revision for version 1.21
  res.creation_date,
  res.scheduled_start_date,
  -- End revision for version 1.21
  res.date_released,
  res.date_completed,
  res.date_closed,
  res.last_update_date,
  res.start_quantity,
  res.quantity_completed,
  res.quantity_scrapped,
  res.fg_total_qty,
  max(res.po_header_id) po_header_id,
  max(res.line_num) line_num,
  max(res.release_num) release_num,
  max(res.purchase_item_id) purchase_item_id,
  res.department_id,
  -- Revision for version 1.22
  1 level_num,
  res.operation_seq_num,
  -- Revision for version 1.25
  res.autocharge_type,
  res.standard_rate_flag,
  -- End revision for version 1.25
  res.resource_seq_num,
  res.resource_code,
  -- Revision for version 1.22
  res.description,
  res.basis_type,
  res.res_unit_of_measure,
  max(res.po_unit_price) po_unit_price,
  res.cost_type,
  res.resource_rate,
  sum(res.usage_rate_or_amount) usage_rate_or_amount,
  sum(res.total_req_quantity) total_req_quantity,
  sum(res.applied_resource_units) applied_resource_units,
  -- Revision for version 1.17
  -- sum(res.qty_variance) qty_variance,
  -- Revision for version 1.17
  sum(res.std_resource_value) std_resource_value,
  sum(res.applied_resource_value) applied_resource_value,
  -- sum(res.res_efficiency_variance) res_efficiency_variance,
  -- End revision for version 1.17
  sum(res.std_usage_rate_or_amount) std_usage_rate_or_amount,
  sum(res.std_total_req_quantity) std_total_req_quantity
  from -- ========================================================
   -- Section II.A.OSP
   -- First get the OSP resource information with the related
   -- PO number and unit price information
   -- =======================================================
   -- Revision for version 1.22
   (select 'II.A' section,
    wdj.report_type,
    wdj.period_name,
    wdj.organization_code,
    wdj.organization_id,
    -- Revision for version 1.22
    -- cct.cost_type primary_cost_type,
    wdj.primary_cost_method,
    -- End revision for version 1.22
    wdj.outside_processing_account account,
    wdj.class_code,
    wdj.class_type,
    wdj.wip_entity_id,
    wdj.project_id,
    wdj.status_type,
    wdj.primary_item_id,
    -- Revision for version 1.22
    wdj.lot_number,
    -- Revision for version 1.21
    wdj.creation_date,
    wdj.scheduled_start_date,
    -- End revision for version 1.21
    wdj.date_released,
    wdj.date_completed,
    wdj.date_closed,
    wdj.last_update_date,
    wdj.start_quantity,
    wdj.quantity_completed,
    wdj.quantity_scrapped,
    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
    poh.po_header_id,
    pol.line_num,
    pr.release_num,
    br.purchase_item_id,
    wo.department_id,
    wo.operation_seq_num,
    wor.resource_seq_num,
    br.resource_code,
    -- Revision for version 1.22
    br.description,
    wor.basis_type,
    -- Revision for version 1.25
    wor.autocharge_type,
    wor.standard_rate_flag,
    -- End revision for version 1.25
    br.unit_of_measure res_unit_of_measure,
    nvl(pll.price_override, pol.unit_price) po_unit_price,
    crc.cost_type cost_type,
    nvl(crc.resource_rate,0) resource_rate,
    nvl(wor.usage_rate_or_amount,0) usage_rate_or_amount,
    -- Revision for version 1.22
    -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
    -- use the completions plus scrap quantities unless for lot-based jobs
    nvl(round(case when wdj.status_type in (4,5,7,12,14,15) then
     decode(wor.basis_type,
      2, nvl(wor.usage_rate_or_amount,0),                                                     -- Lot
         nvl(wor.usage_rate_or_amount,0)                                                      -- Any other basis
       * decode(wdj.class_type,
         5, nvl(wdj.quantity_completed, 0),
            nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
        )
            ) else
     -- else use the start quantity times the usage rate or amount
     decode(:p_use_completion_qtys,
      'Y', decode(wor.basis_type,
        2, nvl(wor.usage_rate_or_amount,0),                                                     -- Lot
           nvl(wor.usage_rate_or_amount,0)                                                      -- Any other basis
         * decode(wdj.class_type,
           5, nvl(wdj.quantity_completed, 0),
              nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
          )
          ),
      -- Revision for version 1.24
      'N', decode(wor.basis_type,
        2, nvl(wor.usage_rate_or_amount,0),                                                     -- Lot
           nvl(wor.usage_rate_or_amount,0) * nvl(wdj.start_quantity, 0)                         -- Any other basis
          )
           ) end
       ,6),0) total_req_quantity,
    nvl(applied_resource_units,0) applied_resource_units,
    -- Revision for version 1.17 and 1.22
    -- If the job status is "Complete" then use the completions plus
    -- scrap quantities else use the planned required quantities; and
    -- use the completions plus scrap quantities unless for lot-based jobs
    -- Get the total required quantity
    nvl(round(case when wdj.status_type in (4,5,7,12,14,15) then
     decode(wor.basis_type,
      2, nvl(wor.usage_rate_or_amount,0),                                                     -- Lot
         nvl(wor.usage_rate_or_amount,0)                                                      -- Any other basis
       * decode(wdj.class_type,
         5, nvl(wdj.quantity_completed, 0),
            nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
        )
            ) else
     -- else use the start quantity times the usage rate or amount
     decode(:p_use_completion_qtys,
      'Y', decode(wor.basis_type,
        2, nvl(wor.usage_rate_or_amount,0),                                                     -- Lot
           nvl(wor.usage_rate_or_amount,0)                                                      -- Any other basis
         * decode(wdj.class_type,
           5, nvl(wdj.quantity_completed, 0),
              nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
          )
          ),
      -- Revision for version 1.24
      'N', decode(wor.basis_type,
        2, nvl(wor.usage_rate_or_amount,0),                                                     -- Lot
           nvl(wor.usage_rate_or_amount,0) * nvl(wdj.start_quantity, 0)                         -- Any other basis
          )
           ) end
       ,6),0) -- total_req_quantity
     -- And multiply by the AvgRate or Frozen standard costs
     *  nvl(crc.resource_rate,0) std_resource_value,
    -- End revision for version 1.17
    nvl(wor.applied_resource_value,0) applied_resource_value,
    0 std_usage_rate_or_amount,
    0 std_total_req_quantity
    from 
    -- Revision for version 1.22
    -- wip_accounting_classes wac,
    -- org_acct_periods oap
    -- mtl_parameters mp,
    -- cst_cost_types cct,
    wdj,
    -- End revision for version 1.22
    wip_operations wo,
    wip_operation_resources wor,
    bom_resources br,
    po_headers_all poh,
    po_lines_all pol,
    po_line_locations_all pll,
    po_releases_