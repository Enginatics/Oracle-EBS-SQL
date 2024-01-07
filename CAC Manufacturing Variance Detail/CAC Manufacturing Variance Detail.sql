/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Manufacturing Variance Detail
-- Description: Report your detailed manufacturing variances for your open and closed WIP jobs.  If the job is open the Report Type column displays "Valuation", as this WIP job and potential variances are still in your WIP inventory balances.  If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction.  You can report prior periods and this report will automatically adjust the assembly completion quantities and component issue quantities to reflect the quantities for the specified accounting period, as well as report only jobs which were open or closed during that prior period.

Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities.  All other WIP jobs use the parameter "Use Completion Quantities".  And if you use Standard Costing, for standard discrete jobs this report also shows your configuration and method variances; the difference between your WIP BOM/routing and your primary or standard BOM/routing.  Non-standard jobs usually do not have configuration variances, as they are "non-standard" without standard BOM or routing requirements.

Parameters:
==========
Report Option:  Open jobs, Closed jobs or All jobs.  Use this to limit the size of the report.  (mandatory)
Period Name:  the accounting period you wish to report.  (mandatory)
Cost Type:  defaults to your Costing Method; if the cost type is missing component costs the report will find any missing item costs from your Costing Method cost type.
Include Scrap Quantities:  for calculating your completion quantities and component quantity requirements, include or exclude any scrapped assembly quantities.  (mandatory)
Include Unreleased Jobs:  include jobs which have not been released and are not started.  (mandatory)
Include Bulk Supply Items:  include Bulk items to match the results from the Oracle Discrete Job Value Report; exclude knowing that Bulk items are usually not issued to the WIP job.  (mandatory)
Use Completion Qtys:  for jobs in a released status, use the completion quantities for the material usage and configuration variance calculations.  Useful if you backflush your materials based on your completion quantities.  Complete, Complete - No Charges, Cancelled, Closed, Pending Close or Failed Close alway use the completion quantities in the variance calculations.  (mandatory)
Config/Lot Variances for Non-Std:  calculate configuration and lot variances for non-standard jobs.
Include Unimplemented ECOs:  include future BOMs changes.
Alternate BOM Designator:  if you save your BOMs during your Cost Rollups (based on your Cost Type step ups), use this parameter to get the correct BOMs for the configuration variance calculations.  If you leave this field blank the report uses the latest BOM component effectivity date up to the period close date.  (optional)
Category Set 1:  any item category you wish (optional).
Category Set 2:  any item category you wish (optional).
Class Code:  specific type of WIP class to report (optional).
Job Status:  specific WIP job status (optional).
WIP Job:  specific WIP job (optional).
Assembly Number:  specific assembly number you wish to report (optional)
Component Number:   specific component item you wish to report (optional)
Outside Processing Item:  Specific outside processing component to report (optional).
Resource Code:  Specific resource code to report (optional).
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).

-- |  Copyright 2011-22 Douglas Volz Consulting, Inc. 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== =============== =========================================
-- |  1.33     13 Oct 2022 Douglas Volz   Fix divide by zero error with the start quantity and
-- |                                      fix single-row subquery returns more than one row error..
-- Excel Examle Output: https://www.enginatics.com/example/cac-manufacturing-variance-detail/
-- Library Link: https://www.enginatics.com/reports/cac-manufacturing-variance-detail/
-- Run Report: https://demo.enginatics.com/

with wdj0 as
 (select wdj.wip_entity_id,
  wdj.organization_id,
  wdj.class_code,
  wdj.creation_date,
  wdj.scheduled_start_date,
  wdj.date_released,
  wdj.date_completed,
  -- Revision for version 1.24
  trunc(wdj.date_closed) date_closed,
  wdj.last_update_date,
  wdj.primary_item_id,
  msiv.concatenated_segments assembly_number,
  msiv.description assy_description,
  msiv.item_type assy_item_type,
  msiv.inventory_item_status_code assy_item_status_code,
  msiv.primary_uom_code assy_uom_code,
  msiv.planning_make_buy_code,
  msiv.std_lot_size,
  wdj.lot_number,
  wdj.status_type,
  wdj.start_quantity,
  wdj.net_quantity,
  wdj.project_id,
  wdj.material_account,
  wdj.resource_account,
  wdj.outside_processing_account,
  wdj.overhead_account,
  wdj.quantity_completed,
  wdj.quantity_scrapped,
  oap.period_start_date,
  oap.schedule_close_date,
  oap.period_name,
  (case
     when wdj.date_closed >= oap.period_start_date then 'Variance'
     -- the job is open
     when wdj.date_closed is null and wdj.creation_date < oap.schedule_close_date + 1 then 'Valuation'
     -- the job is closed and ...the job was closed after the accounting period
     when wdj.date_closed is not null and wdj.date_closed >= oap.schedule_close_date + 1 then 'Valuation'
   end
  ) Report_Type,
  oap.acct_period_id,
  mp.primary_cost_method,
  mp.organization_code,
  wac.class_type
  from wip_discrete_jobs wdj,
  org_acct_periods oap,
  mtl_parameters mp,
  wip_accounting_classes wac,
  mtl_system_items_vl msiv
  where wdj.class_code = wac.class_code
  and wdj.organization_id = wac.organization_id
  and wac.class_type in (1,3,5)
  and oap.organization_id             = wdj.organization_id
  and mp.organization_id              = wdj.organization_id
  and msiv.organization_id            = wdj.organization_id
  and msiv.inventory_item_id          = wdj.primary_item_id
  -- find jobs that were open or closed during or after the report period
  -- the job is open or opened before the period close date
  and (wdj.date_closed is null -- the job is open
   and wdj.creation_date <  oap.schedule_close_date + 1
   and :p_report_option in ('Open jobs', 'All jobs')    -- p_report_option
    or -- the job is closed and ...the job was closed after the accounting period 
   wdj.date_closed is not null
   and wdj.date_closed >= oap.schedule_close_date + 1
   and :p_report_option in ('Open jobs', 'All jobs')    -- p_report_option
    or -- find jobs that were closed during the report period
   wdj.date_closed >= oap.period_start_date
   and wdj.date_closed < oap.schedule_close_date + 1
   and :p_report_option in ('Closed jobs', 'All jobs')  -- p_report_option
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
  wdjsum.assembly_number,
  wdjsum.assy_description,
  wdjsum.assy_item_type,
  wdjsum.assy_item_status_code,
  wdjsum.assy_uom_code,
  wdjsum.planning_make_buy_code,
  wdjsum.std_lot_size,
  wdjsum.lot_number,
  wdjsum.status_type,
  wdjsum.start_quantity,
  wdjsum.net_quantity,
  wdjsum.project_id,
  wdjsum.material_account,
  wdjsum.resource_account,
  wdjsum.outside_processing_account,
  wdjsum.overhead_account,
  wdjsum.period_start_date,
  wdjsum.schedule_close_date,
  wdjsum.period_name,
  wdjsum.report_type,
  wdjsum.acct_period_id,
  wdjsum.primary_cost_method,
  wdjsum.organization_code,
  wdjsum.class_type,
  sum (wdjsum.quantity_completed) quantity_completed,
  sum (wdjsum.quantity_scrapped) quantity_scrapped,
  -- If scrap is not financially recorded do not include in component requirements
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
   wdj0.assembly_number,
   wdj0.assy_description,
   wdj0.assy_item_type,
   wdj0.assy_item_status_code,
   wdj0.assy_uom_code,
   wdj0.planning_make_buy_code,
   wdj0.std_lot_size,
   wdj0.lot_number,
   wdj0.status_type,
   wdj0.start_quantity,
   wdj0.net_quantity,
   wdj0.project_id,
   wdj0.material_account,
   wdj0.resource_account,
   wdj0.outside_processing_account,
   wdj0.overhead_account,
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
   wdj0.report_type,
   wdj0.acct_period_id,
   wdj0.primary_cost_method,
   wdj0.organization_code,
   wdj0.class_type
   from wdj0,
   mtl_material_transactions mmt
   where mmt.transaction_source_type_id  = 5
   -- Revision for version 1.24
   and mmt.transaction_type_id in (17, 44, 90, 91)
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
  wdjsum.assembly_number,
  wdjsum.assy_description,
  wdjsum.assy_item_type,
  wdjsum.assy_item_status_code,
  wdjsum.assy_uom_code,
  wdjsum.planning_make_buy_code,
  wdjsum.std_lot_size,
  wdjsum.lot_number,
  wdjsum.status_type,
  wdjsum.start_quantity,
  wdjsum.net_quantity,
  wdjsum.project_id,
  wdjsum.material_account,
  wdjsum.resource_account,
  wdjsum.outside_processing_account,
  wdjsum.overhead_account,
  wdjsum.period_start_date,
  wdjsum.schedule_close_date,
  wdjsum.period_name,
  wdjsum.report_type,
  wdjsum.acct_period_id,
  wdjsum.primary_cost_method,
  wdjsum.organization_code,
  wdjsum.class_type
 ),
wdj_assys as
 (select distinct wdj.primary_item_id,
  wdj.organization_id,
  wdj.primary_cost_method,
  wdj.assembly_number,
  wdj.assy_description,
  wdj.assy_item_type,
  wdj.assy_item_status_code,
  wdj.assy_uom_code,
  wdj.planning_make_buy_code,
  wdj.std_lot_size,
  -- Revision for version 1.20
  wdj.schedule_close_date
  from wdj),
-- Revision for version 1.19
-- Assembly cost type and lot information
cic_assys as
 (select cic.organization_id,
  cic.inventory_item_id,
  cct.cost_type,
  cic.cost_type_id,
  nvl(cic.lot_size,1) lot_size,
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
  and cct.cost_type                = decode(:p_cost_type,                                                -- p_cost_type
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
  nvl(cic.lot_size,1)
  union all
  select cic.organization_id,
  cic.inventory_item_id,
  cct.cost_type,
  cic.cost_type_id,
  nvl(cic.lot_size,1) lot_size,
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
  -- wdj
  wdj_assys
  where cic.cost_type_id             = cicd.cost_type_id (+)
  and cic.inventory_item_id        = cicd.inventory_item_id (+)
  and cic.organization_id          = cicd.organization_id (+)
  and cic.inventory_item_id        = wdj_assys.primary_item_id
  and cic.organization_id          = wdj_assys.organization_id
  and cic.cost_type_id             = wdj_assys.primary_cost_method  -- this gets the Frozen Costs
  and cct.cost_type_id            <> wdj_assys.primary_cost_method  -- this avoids getting the Frozen costs twice
  and cct.cost_type                = decode(:p_cost_type,                                                -- p_cost_type
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
  and not exists
   (select 'x'
    from cst_item_costs cic2
    where cic2.organization_id   = cic.organization_id
    and cic2.inventory_item_id = cic.inventory_item_id
    and cic2.cost_type_id      = cct.cost_type_id
   )
  group by
  cic.organization_id,
  cic.inventory_item_id,
  cct.cost_type,
  cic.cost_type_id,
  nvl(cic.lot_size,1)
 ),
-- Get the Component Cost Basis Type and Item Costs
cic_comp as
 (select cic.inventory_item_id,
  cic.organization_id,
  cic.last_update_date,
  cct.cost_type_id,
  cct.cost_type,
  sum(case
   when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then 1 -- material lot basis type
   when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then 1 -- moh lot basis type
   when cicd.level_type = 2 and cicd.basis_type = 2 then 1 -- previous level lot basis type
   else 0
      end) lot_basis_type,
  sum(case
   when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then cicd.item_cost -- material lot basis cost
   when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then cicd.item_cost -- moh lot basis cost
   when cicd.level_type = 2 and cicd.basis_type = 2 then cicd.item_cost -- previous level lot basis cost
   else 0
      end) lot_basis_cost,
  -- Revision for version 1.28
  -- sum(case
  --  when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then 0 -- material item basis type
  --  when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then 0 -- moh item basis type
  --  when cicd.level_type = 2 and cicd.basis_type = 2 then 0 -- previous level item basis type
  --  else 1
  --     end) item_basis_type,
  -- End revision for version 1.28
  sum(case
   when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then 0 -- material item basis cost
   when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then 0 -- moh item basis cost
   when cicd.level_type = 2 and cicd.basis_type = 2 then 0 -- previous level item basis cost
   else cicd.item_cost
      end) item_basis_cost,
  -- Revision for version 1.28
  nvl(cic.lot_size,1) lot_size,
  nvl(cic.item_cost,0) item_cost
  from cst_item_cost_details cicd,
  cst_item_costs cic,
  cst_cost_types cct,
  mtl_parameters mp
  where mp.organization_id           = cic.organization_id
  and cic.cost_type_id             = cct.cost_type_id
  and cic.cost_type_id             = cicd.cost_type_id (+)
  and cic.inventory_item_id        = cicd.inventory_item_id (+)
  and cic.organization_id          = cicd.organization_id (+)
  and cct.cost_type                = decode(:p_cost_type,                                                -- p_cost_type
       null, (select cct.cost_type 
              from   dual 
              where  cct.cost_type_id = mp.primary_cost_method
             ), 
       :p_cost_type
           )
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                          -- p_org_code
  group by
  cic.inventory_item_id,
  cic.organization_id,
  cic.last_update_date,
  cct.cost_type_id,
  cct.cost_type,
  -- Revision for version 1.28
  nvl(cic.lot_size,1),
  nvl(cic.item_cost,0)
  union all
  select cic.inventory_item_id,
  cic.organization_id,
  cic.last_update_date,
  cct.cost_type_id,
  cct.cost_type,
  sum(case
   when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then 1 -- material lot basis type
   when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then 1 -- moh lot basis type
   when cicd.level_type = 2 and cicd.basis_type = 2 then 1 -- previous level lot basis type
   else 0
      end) lot_basis_type,
  sum(case
   when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then cicd.item_cost -- material lot basis cost
   when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then cicd.item_cost -- moh lot basis cost
   when cicd.level_type = 2 and cicd.basis_type = 2 then cicd.item_cost -- previous level lot basis cost
   else 0
      end) lot_basis_cost,
  -- Revision for version 1.28
  -- sum(case
  --  when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then 0 -- material item basis type
  --  when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then 0 -- moh item basis type
  --  when cicd.level_type = 2 and cicd.basis_type = 2 then 0 -- previous level item basis type
  --  else 1
  --     end) item_basis_type,
  -- End revision for version 1.28
  sum(case
   when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then 0 -- material item basis cost
   when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then 0 -- moh item basis cost
   when cicd.level_type = 2 and cicd.basis_type = 2 then 0 -- previous level item basis cost
   else cicd.item_cost
      end) item_basis_cost,
  -- Revision for version 1.28
  nvl(cic.lot_size,1) lot_size,
  nvl(cic.item_cost,0) item_cost
  from cst_item_cost_details cicd,
  cst_item_costs cic,
  cst_cost_types cct,
  mtl_parameters mp
  where mp.organization_id           = cic.organization_id
  and cic.cost_type_id             = mp.primary_cost_method  -- this gets the Frozen Costs
  and cic.cost_type_id             = cicd.cost_type_id (+)
  and cic.inventory_item_id        = cicd.inventory_item_id (+)
  and cic.organization_id          = cicd.organization_id (+)
  and cct.cost_type_id            <> mp.primary_cost_method  -- this avoids getting the Frozen costs twice
  and cct.cost_type                = decode(:p_cost_type,                                                -- p_cost_type
       null, (select cct.cost_type 
              from   dual 
              where  cct.cost_type_id = mp.primary_cost_method
             ), 
       :p_cost_type
           )
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                          -- p_org_code
  -- ====================================
  -- Find all the Frozen costs not in the
  -- Pending or unimplemented cost type
  -- ====================================
  and not exists 
   (select 'x'
    from cst_item_costs cic2
    where cic2.organization_id   = cic.organization_id
    and cic2.inventory_item_id = cic.inventory_item_id
    and cic2.cost_type_id      = cct.cost_type_id
   )
  group by
  cic.inventory_item_id,
  cic.organization_id,
  cic.last_update_date,
  cct.cost_type_id,
  cct.cost_type,
  -- Revision for version 1.28
  nvl(cic.lot_size,1),
  nvl(cic.item_cost,0)
 ),
-- Get the Resource Cost Type, Cost Basis Type and Resource Rates
crc as
 (select crc.resource_id,
  crc.organization_id,
  crc.last_update_date,
  crc.cost_type_id,
  cct.cost_type,
  crc.resource_rate
  from cst_resource_costs crc,
  cst_cost_types cct,
  mtl_parameters mp
  where crc.cost_type_id             = decode(cct.cost_type_id, 
       2, mp.avg_rates_cost_type_id, -- Average Costing
       5, mp.avg_rates_cost_type_id, -- FIFO Costing
       6, mp.avg_rates_cost_type_id, -- LIFO Costing
       cct.cost_type_id)
  and crc.organization_id          = mp.organization_id
  and cct.cost_type                = decode(:p_cost_type,
       null, (select cct.cost_type 
           from   dual 
           where  cct.cost_type_id = mp.primary_cost_method
             ), 
       :p_cost_type
           )                                                               -- p_cost_type
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                          -- p_org_code
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
  and cct.cost_type                = decode(:p_cost_type,
       null, (select cct.cost_type 
           from   dual 
           where  cct.cost_type_id = mp.primary_cost_method
             ), 
       :p_cost_type
           )                                                               -- p_cost_type
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                          -- p_org_code
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
 ),
-- Get the departmental overhead rates
cdo as
 (select cdo.overhead_id,
  cdo.department_id,
  cdo.organization_id,
  cdo.last_update_date,
  cdo.cost_type_id,
  cct.cost_type,
  cdo.basis_type,
  cdo.rate_or_amount
  from cst_department_overheads cdo,
  cst_cost_types cct,
  mtl_parameters mp
  where cdo.cost_type_id             = decode(cct.cost_type_id, 
  2, mp.avg_rates_cost_type_id, -- Average Costing
  5, mp.avg_rates_cost_type_id, -- FIFO Costing
  6, mp.avg_rates_cost_type_id, -- LIFO Costing
  cct.cost_type_id)
  and cdo.organization_id          = mp.organization_id
  and cct.cost_type                = decode(:p_cost_type,
       null, (select cct.cost_type 
           from   dual 
           where  cct.cost_type_id = mp.primary_cost_method
          ), 
       :p_cost_type
           )                                                               -- p_cost_type
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                          -- p_org_code
  group by
  cdo.overhead_id,
  cdo.department_id,
  cdo.organization_id,
  cdo.last_update_date,
  cdo.cost_type_id,
  cct.cost_type,
  cdo.basis_type,
  cdo.rate_or_amount
  union all
  -- If missing from the above query, get the Frozen or AvgRates Resource Costs
  select cdo.overhead_id,
  cdo.department_id,
  cdo.organization_id,
  cdo.last_update_date,
  cdo.cost_type_id,
  cct.cost_type,
  cdo.basis_type,
  cdo.rate_or_amount
  from cst_department_overheads cdo,
  cst_cost_types cct,
  mtl_parameters mp
  where cdo.organization_id          = mp.organization_id
  and cdo.cost_type_id             = decode(mp.primary_cost_method,
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
  and cct.cost_type                = decode(:p_cost_type,
       null, (select cct.cost_type 
           from   dual 
           where  cct.cost_type_id = mp.primary_cost_method
          ), 
       :p_cost_type
           )                                                               -- p_cost_type
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                          -- p_org_code
  -- ====================================
  -- Find all the resource costs not in the
  -- Pending or unimplemented cost type
  -- ====================================
  and not exists
   (select 'x'
    from cst_department_overheads cdo2
    where cdo2.organization_id   = cdo.organization_id
    and cdo2.overhead_id       = cdo.overhead_id
    and cdo2.cost_type_id      = case
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
  cdo.overhead_id,
  cdo.department_id,
  cdo.organization_id,
  cdo.last_update_date,
  cdo.cost_type_id,
  cct.cost_type,
  cdo.basis_type,
  cdo.rate_or_amount
 ),
-- Get the resource overhead associations
cro as
 (select cro.overhead_id,
  cro.resource_id,
  cro.organization_id,
  cro.last_update_date,
  cro.cost_type_id,
  cct.cost_type
  from cst_resource_overheads cro,
  cst_cost_types cct,
  mtl_parameters mp
  where cro.cost_type_id             = decode(cct.cost_type_id, 
       2, mp.avg_rates_cost_type_id, -- Average Costing
       5, mp.avg_rates_cost_type_id, -- FIFO Costing
       6, mp.avg_rates_cost_type_id, -- LIFO Costing
       cct.cost_type_id)
  and cro.organization_id          = mp.organization_id
  and cct.cost_type                = decode(:p_cost_type,
       null, (select cct.cost_type 
           from   dual 
           where  cct.cost_type_id = mp.primary_cost_method
             ), 
       :p_cost_type
            )                                                              -- p_cost_type
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                          -- p_org_code
  group by
  cro.overhead_id,
  cro.resource_id,
  cro.organization_id,
  cro.last_update_date,
  cro.cost_type_id,
  cct.cost_type
  union all
  -- If missing from the above query, get the Frozen or AvgRates Resource Costs
  select cro.overhead_id,
  cro.resource_id,
  cro.organization_id,
  cro.last_update_date,
  cro.cost_type_id,
  cct.cost_type
  from cst_resource_overheads cro,
  cst_cost_types cct,
  mtl_parameters mp
  where cro.organization_id          = mp.organization_id
  and cro.cost_type_id             = decode(mp.primary_cost_method,
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
  and cct.cost_type                = decode(:p_cost_type,
       null, (select cct.cost_type 
           from   dual 
           where  cct.cost_type_id = mp.primary_cost_method
             ), 
       :p_cost_type
           )                                                              -- p_cost_type
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                          -- p_org_code
  -- ====================================
  -- Find all the resource costs not in the
  -- Pending or unimplemented cost type
  -- ====================================
  and not exists
   (select 'x'
    from cst_resource_overheads cro2
    where cro2.organization_id   = cro.organization_id
    and cro2.overhead_id       = cro.overhead_id
    and cro2.resource_id       = cro.resource_id
    and cro2.cost_type_id      = case
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
  cro.overhead_id,
  cro.resource_id,
  cro.organization_id,
  cro.last_update_date,
  cro.cost_type_id,
  cct.cost_type
 ),
-- End revision for version 1.19
-- Revision for version 1.30
-- Get the list of primary and/or alternate BOMs, to enable joining to phantom subassemblies
bom_list as
  -- Get the alternate BOM if the alternate BOM is not null
 (select bsb1.bill_sequence_id,
  bsb1.assembly_item_id,
  bsb1.organization_id,
  bsb1.alternate_bom_designator
  from bom_structures_b bsb1,
  mtl_parameters mp
  where bsb1.organization_id            = mp.organization_id
  and bsb1.assembly_type              = 1   -- Manufacturing
  and bsb1.common_assembly_item_id is null
  and bsb1.alternate_bom_designator   = '&p_alt_bom_designator'
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code
  and '&p_alt_bom_designator' is not null
  union all
  -- Get the primary BOM if the alternate BOM does not exist
  select bsb2.bill_sequence_id,
  bsb2.assembly_item_id,
  bsb2.organization_id,
  bsb2.alternate_bom_designator
  from bom_structures_b bsb2,
  mtl_parameters mp
  where bsb2.alternate_bom_designator is null -- get the primary BOM
  and '&p_alt_bom_designator' is not null
  and bsb2.organization_id            = mp.organization_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code
  -- Check to see if the BOM structures exist as an alternate BOM
  and not exists
  (
   select 'x'
   from bom_structures_b bsb
   where bsb.assembly_item_id            = bsb2.assembly_item_id
   and bsb.organization_id             = mp.organization_id
   and bsb.alternate_bom_designator    = '&p_alt_bom_designator'
  )
  union all
  -- Get the primary BOM if the alternate BOM is null
  select bsb3.bill_sequence_id,
  bsb3.assembly_item_id,
  bsb3.organization_id,
  bsb3.alternate_bom_designator
  from bom_structures_b bsb3,
  mtl_parameters mp
  where bsb3.organization_id            = mp.organization_id
  and bsb3.alternate_bom_designator is null
  and '&p_alt_bom_designator' is null
  and mp.organization_id in (select oav.organization_id fr