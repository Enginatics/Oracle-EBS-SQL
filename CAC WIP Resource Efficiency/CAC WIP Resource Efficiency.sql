/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Resource Efficiency
-- Description: Report your resource efficiency variances for your open and closed WIP jobs.  Resource efficiency measures the WIP routing requirements against the actual applied resources.  This report replicates the Resource Section for the Oracle Discrete Job Value Report - Standard Costing.

If you leave the Cost Type parameter blank the report uses either your Costing Method Cost Type (Standard) or your Costing Method "Avg Rates" Cost Type (Average, FIFO, LIFO) for your resource rates.  If the WIP job is open the Report Type column displays "Valuation", as this WIP job and potential material usage variance is still in your WIP inventory balances.  If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction during the reporting period.  Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities.  All other WIP jobs use the parameter "Use Completion Quantities" to determine if completion or planned quantities are used for requirements.  If you choose Yes for including scrap, this report will automatically include the scrapped quantities as part of the resource quantity requirements.  And this report automatically includes WIP jobs which were either open during the reported accounting period or if closed, were closed doing the reporting period.

Parameters:
=========
Report Option:  You can choose to limit the report size with this parameter.  The choices are:  Open jobs, All jobs or Closed jobs. (mandatory)
Period Name:  Enter the Period_Name you wish to report for WIP Jobs (mandatory)
Cost Type:  Enter the resource rates cost type.  If left blank, the report uses the Costing Method rates cost type. (optional)
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

/* +=============================================================================+
-- |  Copyright 2009 - 2021 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged                                                               |
-- +=============================================================================+
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     28 Jan 2010 Douglas Volz   Initial Coding
-- |  1.25    12 Dec 2021 Douglas Volz   Added auto-charge, std rate and PO Currency Code columns.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-resource-efficiency/
-- Library Link: https://www.enginatics.com/reports/cac-wip-resource-efficiency/
-- Run Report: https://demo.enginatics.com/

with wdj00 as
( select /*+ materialize */ wdj.wip_entity_id,min(wt.transaction_date) transaction_date
  from wip_discrete_jobs wdj,
  org_acct_periods oap,
  mtl_parameters mp,
  wip_accounting_classes wac,
  wip_transactions wt
  where wdj.class_code = wac.class_code
  and wdj.organization_id = wac.organization_id
  and wac.class_type in (1,3,5)
  and oap.organization_id             = wdj.organization_id
  and mp.organization_id              = wdj.organization_id
  and wt.wip_entity_id=wdj.wip_entity_id 
  and wt.resource_id is not null
  and wt.transaction_date < oap.schedule_close_date + 1
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code
  and 3=3                             -- p_assembly_number
  and 4=4                             -- p_period_name, p_wip_job, wip_status, p_wip_class_code
  group by wdj.wip_entity_id
),
 wdj0 as
 (select /*+ materialize */ wdj.wip_entity_id,
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
  wip_accounting_classes wac,
  wdj00
  where wdj.class_code = wac.class_code
  and wdj.organization_id = wac.organization_id
  and wac.class_type in (1,3,5)
  and wdj.wip_entity_id=wdj00.wip_entity_id(+)
  and oap.organization_id             = wdj.organization_id
  and mp.organization_id              = wdj.organization_id
  -- find jobs that were open or closed during or after the report period
  -- the job is open or opened before the period close date
  and ( (wdj.date_closed is null -- the job is open
     and((wdj.creation_date <  oap.schedule_close_date + 1 and not exists (select null from wip_transactions wt where wt.wip_entity_id=wdj.wip_entity_id and wt.resource_id is not null))
      or(wdj00.transaction_date<oap.schedule_close_date + 1)
     )
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
 xxen_util.meaning(res_sum.transaction_type,'WIP_TRANSACTION_TYPE',700) transaction_type_name,
 -- Revision for version 1.25
 ml5.meaning Auto_Charge,
 ml6.meaning Std_Rate,
 -- End revision for version 1.25
 ml3.meaning Basis_Type,
 -- Revision for version 1.25
 res_sum.po_currency_code PO_Currency_Code,
 -- Revision for version 1.17
 decode(res_sum.line_num, 0, null, res_sum.po_unit_price) PO_Unit_Price,
 res_sum.cost_type Resource_Cost_Type,
 -- Revision for version 1.21
 gl.currency_code Currency_Code,
 res_sum.resource_rate Resource_Rate,
 res_sum.res_unit_of_measure Resource_UOM_Code, 
 res_sum.usage_rate_or_amount Quantity_Per_Assembly,
 res_sum.total_req_quantity  Total_Required_Quantity,
 res_sum.applied_resource_units Total_Units_Applied,
 -- Revision for version 1.17
 -- res_sum.qty_variance Quantity_Variance,
 round(res_sum.applied_resource_units - res_sum.total_req_quantity,6) Quantity_Variance,
 res_sum.std_resource_value Standard_Resource_Value,
 round(res_sum.applied_resource_value,2) Applied_Resource_Value,
 -- res_sum.res_efficiency_variance Resource_Efficiency_Variance,
 round(res_sum.applied_resource_value - res_sum.std_resource_value,2) Resource_Efficiency_Variance
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
  min(res.transaction_type)transaction_type,
  res.department_id,
  -- Revision for version 1.22
  1 level_num,
  res.operation_seq_num,
  -- Revision for version 1.25
  res.autocharge_type,
  res.standard_rate_flag,
  res.po_currency_code,
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
  sum(res.applied_resource_value) applied_resource_value
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
    wt.transaction_type,
    poh.currency_code po_currency_code,
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
         -- Use the logic in wip_operation_resources_v as the same is used in Oracle forms to derive total_required_quantity
         * decode(wor.repetitive_schedule_id,
           null,
           wdj.start_quantity - decode(:p_include_scrap, 'N', 0, null, 0, nvl(wo.cumulative_scrap_quantity, 0)),
           wrs.daily_production_rate * wrs.processing_work_days
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
           nvl(wor.usage_rate_or_amount,0)                                                      -- Any other basis
           -- Use the logic in wip_operation_resources_v as the same is used in Oracle forms to derive total_required_quantity
           * decode(wor.repetitive_schedule_id,
             null,
             wdj.start_quantity - decode(:p_include_scrap, 'N', 0, null, 0, nvl(wo.cumulative_scrap_quantity, 0)),
             wrs.daily_production_rate * wrs.processing_work_days
             )
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
         -- Use the logic in wip_operation_resources_v as the same is used in Oracle forms to derive total_required_quantity
         * decode(wor.repetitive_schedule_id,
           null,
           wdj.start_quantity - decode(:p_include_scrap, 'N', 0, null, 0, nvl(wo.cumulative_scrap_quantity, 0)),
           wrs.daily_production_rate * wrs.processing_work_days
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
           nvl(wor.usage_rate_or_amount,0)                                                      -- Any other basis
           -- Use the logic in wip_operation_resources_v as the same is used in Oracle forms to derive total_required_quantity
           * decode(wor.repetitive_schedule_id,
             null,
             wdj.start_quantity - decode(:p_include_scrap, 'N', 0, null, 0, nvl(wo.cumulative_scrap_quantity, 0)),
             wrs.daily_production_rate * wrs.processing_work_days
             )
          )
           ) end
       ,6),0) -- total_req_quantity
     -- And multiply by the AvgRate or Frozen standard costs
     *  nvl(crc.resource_rate,0) std_resource_value,
    -- End revision for version 1.17
    nvl(wor.applied_resource_value,0) applied_resource_value
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
    wip_repetitive_schedules wrs,
    bom_resources br,
    wip_transactions wt,
    po_headers_all poh,
    po_lines_all pol,
    po_line_locations_all pll,
    po_releases_all pr,
    po_distributions_all pod,
    -- Revision for version 1.22
    -- Get the Resource Cost Type, Cost Basis Type and Resource Rates
    (select crc.resource_id,
     crc.organization_id,
     crc.last_update_date,
     crc.cost_type_id,
     cct.cost_type,
     crc.resource_rate resource_rate
     from cst_resource_costs crc,
     cst_cost_types cct,
     mtl_parameters mp
     where crc.cost_type_id             = decode(cct.cost_type_id, 
          2, mp.avg_rates_cost_type_id, -- Average Costing
          5, mp.avg_rates_cost_type_id, -- FIFO Costing
          6, mp.avg_rates_cost_type_id, -- LIFO Costing
          cct.cost_type_id)
     and crc.organization_id          = mp.organization_id
     and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                          -- p_org_code
     and cct.cost_type                = decode(:p_cost_type,
          null, (select cct.cost_type 
                 from   dual 
                 where  cct.cost_type_id = mp.primary_cost_method
                ), 
          :p_cost_type
               )  
     group by
     crc.resource_id,
     crc.organization_id,
     crc.last_update_date,
     crc.cost_type_id,
     cct.cost_type,
     crc.resource_rate
     union all
     -- If missing from the above query, get the Frozen or AvgRates Resource Costs
     select crc.resource_id,
     crc.organization_id,
     crc.last_update_date,
     crc.cost_type_id,
     cct.cost_type,
     crc.resource_rate resource_rate
     from cst_resource_costs crc,
     cst_cost_types cct,
     mtl_parameters mp
     where crc.organization_id          = mp.organization_id
     and crc.cost_type_id             = decode(mp.primary_cost_method,
          1, 1, -- Standard Costing, Frozen Cost Type
          2, mp.avg_rates_cost_type_id, -- Average Costing
          3, -99,                       -- Periodic Average
          4, -99,                       -- Periodic Incremental LIFO
          5, mp.avg_rates_cost_type_id, -- FIFO Costing
          6, mp.avg_rates_cost_type_id  -- LIFO Costing
              )
     -- Don't get the Frozen or AvgRates resource costs twice
     and cct.cost_type_id            <> decode(mp.primary_cost_method,
          1, 1, -- Standard Costing, Frozen Cost Type
          2, mp.avg_rates_cost_type_id, -- Average Costing
          3, -99,                       -- Periodic Average
          4, -99,                       -- Periodic Incremental LIFO
          5, mp.avg_rates_cost_type_id, -- FIFO Costing
          6, mp.avg_rates_cost_type_id  -- LIFO Costing
              )
     and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                          -- p_org_code
     and cct.cost_type                = decode(:p_cost_type,
          null, (select cct.cost_type 
                 from   dual 
                 where  cct.cost_type_id = mp.primary_cost_method
                ), 
          :p_cost_type
               )  
     -- ====================================
     -- Find all the resource costs not in the
     -- Pending or unimplemented cost type
     -- ====================================
     and not exists
      (select 'x'
       from cst_resource_costs crc2
       where crc2.organization_id   = crc.organization_id
       and crc2.resource_id       = crc.resource_id
       and crc2.cost_type_id      = case
             when mp.primary_cost_method = 1 then cct.cost_type_id
             when mp.primary_cost_method = 2 and cct.cost_type_id <> 2 then cct.cost_type_id
             when mp.primary_cost_method = 2 and cct.cost_type_id = 2 then mp.avg_rates_cost_type_id
             when mp.primary_cost_method = 3 then -99
             when mp.primary_cost_method = 4 then -99
             when mp.primary_cost_method = 5 and cct.cost_type_id <> 5 then cct.cost_type_id
             when mp.primary_cost_method = 5 and cct.cost_type_id = 5 then mp.avg_rates_cost_type_id
             when mp.primary_cost_method = 6 and cct.cost_type_id <> 6 then cct.cost_type_id
             when mp.primary_cost_method = 6 and cct.cost_type_id = 6 then mp.avg_rates_cost_type_id
             else cct.cost_type_id
           end
      )
     group by
     crc.resource_id,
     crc.organization_id,
     crc.last_update_date,
     crc.cost_type_id,
     cct.cost_type,
     crc.resource_rate
    ) crc
    -- End revision for version 1.22
    -- ===========================================
    -- WIP_Job Entity, Class and Period joins
    -- ===========================================
    where wo.wip_entity_id          = wdj.wip_entity_id
    and wo.organization_id        = wdj.organization_id
    and wo.wip_entity_id          = wor.wip_entity_id
    and wo.organization_id        = wor.organization_id
    and wo.operation_seq_num      = wor.operation_seq_num
    and wor.resource_id           = br.resource_id
    -- Revision for version 1.22
    -- and cct.cost_type_id          = wdj.primary_cost_method
    -- ===========================================
    -- PO Table Joins for version 1.8
    -- ===========================================
    and poh.po_header_id          = pod.po_header_id
    and pol.po_line_id            = pod.po_line_id
    and pll.line_location_id      = pod.line_location_id
    and pod.po_release_id         = pr.po_release_id (+)
    and wor.wip_entity_id         = pod.wip_entity_id
    and wor.resource_id           = pod.bom_resource_id
    and wor.resource_seq_num      = pod.wip_resource_seq_num
    and wor.operation_seq_num     = pod.wip_operation_seq_num
    and wor.organization_id       = pod.destination_organization_id
    -- ===========================================
    -- Cost Table Joins for version 1.22
    -- ===========================================
    and wor.resource_id           = crc.resource_id (+) 
    and wor.organization_id       = crc.organization_id (+) 
    -- ===========================================
    -- Use the joins in wip_operation_resources_v as the same is used in Oracle forms
    -- ===========================================
    and wrs.organization_id(+)= wor.organization_id
    and wrs.wip_entity_id(+)= wor.wip_entity_id
    and wrs.repetitive_schedule_id(+)= wor.repetitive_schedule_id
    and wor.wip_entity_id=wt.wip_entity_id(+)
    and wor.resource_id=wt.resource_id(+)
    and wor.operation_seq_num=wt.operation_seq_num(+)
    and wor.resource_seq_num=wt.resource_seq_num(+)
    and 8=8                       -- p_resource_code
    union all
    -- =======================================================
    -- Section II.B. Non-OSP
    -- Now get the non-OSP resource information
    -- =======================================================
   -- Revision for version 1.22
    select 'II.B' section,
    wdj.report_type,
    wdj.period_name,
    wdj.organization_code,
    wdj.organization_id,
    -- Revision for version 1.22
    -- cct.cost_type primary_cost_type,
    wdj.primary_cost_method,
    -- End revision for version 1.22
    wdj.resource_account account,
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
    0 purchase_item_id,
    0 po_header_id,
    0 line_num,
    0 release_num,
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
    wt.transaction_type,
    null po_currency_code,
    -- End revision for version 1.25
    br.unit_of_measure res_unit_of_measure,
    0 po_unit_price,
    -- Revision for version 1.22
    crc.cost_type,
    nvl(crc.resource_rate,