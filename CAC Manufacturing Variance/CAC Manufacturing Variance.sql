/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Manufacturing Variance
-- Description: Report your summary or detail manufacturing variances for open and closed WIP jobs.  If the job is open the Report Type column displays "Valuation", as this WIP job and potential variances are still in your WIP inventory balances.  If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction.  You can report prior periods and the report will automatically adjust the assembly completion, assembly scrap, component issue and resource quantities to reflect the reported accounting period, as well as report only jobs which were open or closed during that prior period.

Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities.  All other WIP jobs use the parameter "Use Completion Quantities".  And if you use Standard Costing, for standard discrete jobs this report also shows your configuration and method variances; the difference between your WIP BOM/routing and your standard BOM/routing.  Non-standard jobs usually do not have configuration variances, as they are "non-standard" without standard BOM or routing requirements.

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
Include Unimplemented ECOs:  include future BOM changes.
Alternate BOM Designator:  if you save your BOMs during your Cost Rollups (based on your Cost Type setups), use this parameter to get the correct BOMs for the configuration variance calculations.  If you leave this field blank the report uses the latest BOM component effectivity date up to the period close date.  (optional)
Category Set 1, 2, 3:  any item category to report (optional).
Class Code:  specific type of WIP class to report (optional).
Job Status:  specific WIP job status (optional).
WIP Job:  specific WIP job (optional).
Assembly Number:  specific assembly number to report (optional)
Component Number:   specific component item to report (optional)
Outside Processing Item:  Specific outside processing component to report (optional).
Resource Code:  Specific resource code to report (optional).
Organization Code:  any inventory organization, defaults to your session's inventory org (optional).

-- |  Copyright 2011-25 Douglas Volz Consulting, Inc. 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== =============== =========================================
-- |  1.36    21 Dec 2024 Douglas Volz   Fixes for Configuration and Method Variances.
-- |  1.37    02 Jan 2025 Douglas Volz    Add Scrap Variance column, to avoid double-counting assy scrap.
-- |  1.38    04 Feb 2025 Douglas Volz   Consolidate Summary and Detail reports into one report.

-- Excel Examle Output: https://www.enginatics.com/example/cac-manufacturing-variance/
-- Library Link: https://www.enginatics.com/reports/cac-manufacturing-variance/
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
                -- Revision for version 1.37
                wp.mandatory_scrap_flag,
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
         from   wip_discrete_jobs wdj,
                org_acct_periods oap,
                mtl_parameters mp,
                -- Revision for version 1.37
                wip_parameters wp,
                wip_accounting_classes wac,
                mtl_system_items_vl msiv
         where  wdj.class_code                  = wac.class_code
         and    wdj.organization_id             = wac.organization_id
         and    wac.class_type in (1,3,5)
         -- Revision for version 1.37
         and    wp.organization_id              = wac.organization_id
         and    oap.organization_id             = wdj.organization_id
         and    mp.organization_id              = wdj.organization_id
         and    msiv.organization_id            = wdj.organization_id
         and    msiv.inventory_item_id          = wdj.primary_item_id
         -- find jobs that were open or closed during or after the report period
                -- the job is open or opened before the period close date
         and    (wdj.date_closed is null -- the job is open
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
         and    2=2                             -- p_org_code
         and    3=3                             -- p_assembly_number
         and    4=4                             -- p_period_name, p_wip_job, wip_status, p_wip_class_code
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
                wdjsum.schedule_close_date, -- Period Close Date
                wdjsum.period_name,
                wdjsum.report_type,
                wdjsum.acct_period_id,
                wdjsum.primary_cost_method,
                wdjsum.organization_code,
                wdjsum.class_type,
                sum(wdjsum.quantity_completed) quantity_completed,
                sum(wdjsum.quantity_scrapped) quantity_scrapped,
                -- Revision for version 1.37
                wdjsum.mandatory_scrap_flag
         from   (select wdj0.*
                 from   wdj0
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
                                -- Revision for version 1.36
                                -- 90, mmt.primary_quantity,      -- scrap assemblies from wip
                                -- 91, -1 * mmt.primary_quantity, -- return assemblies scrapped from wip
                                90, -1 * mmt.primary_quantity,      -- scrap assemblies from wip
                                91, mmt.primary_quantity, -- return assemblies scrapped from wip
                                -- End revision for version 1.36
                                44, 0,                         -- wip completion
                                17, 0                          -- wip completion return
                              ) quantity_scrapped,
                        -- Revision for version 1.37
                        wdj0.mandatory_scrap_flag,
                        wdj0.period_start_date,
                        wdj0.schedule_close_date,
                        wdj0.period_name,
                        wdj0.report_type,
                        wdj0.acct_period_id,
                        wdj0.primary_cost_method,
                        wdj0.organization_code,
                        wdj0.class_type
                 from   wdj0,
                        mtl_material_transactions mmt
                 where  mmt.transaction_source_type_id  = 5
                 -- Revision for version 1.24
                 and    mmt.transaction_type_id in (17, 44, 90, 91)
                 and    mmt.transaction_source_id       = wdj0.wip_entity_id
                 and    mmt.transaction_date           >= wdj0.schedule_close_date + 1
                 and    wdj0.organization_id            = mmt.organization_id
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
                wdjsum.class_type,
                -- Revision for version 1.37
                wdjsum.mandatory_scrap_flag
        ), -- wdj
-- Revision for version 1.34, commented this out
/* wdj_assys as
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
                wdj.schedule_close_date, -- Period Close Date
                -- Revision for version 1.34
                wdj.acct_period_id,
                wdj.date_closed
                -- End revision for version 1.34
         from wdj), */
-- End revision for version 1.34
-- Get the WIP components
wdj_comp as
    (select wrosum.level_num,
            -- Revision for version 1.22
            wrosum.report_type,
            wrosum.period_name,
            wrosum.organization_code,
            wrosum.organization_id,
            wrosum.primary_cost_method,
            wrosum.account,
            wrosum.class_code,
            wrosum.class_type,
            wrosum.wip_entity_id,
            wrosum.project_id,
            wrosum.status_type,
            wrosum.primary_item_id,
            wrosum.assembly_number,
            wrosum.assy_description,
            wrosum.assy_item_type,
            wrosum.assy_item_status_code,
            wrosum.assy_uom_code,
            wrosum.planning_make_buy_code,
            wrosum.std_lot_size,
            wrosum.lot_number,
            wrosum.creation_date,
            wrosum.scheduled_start_date,
            wrosum.date_released,
            wrosum.date_completed,
            wrosum.date_closed,
            wrosum.schedule_close_date,
            wrosum.last_update_date,
            wrosum.start_quantity,
            wrosum.quantity_completed,
            wrosum.quantity_scrapped,
            wrosum.quantity_completed + wrosum.quantity_scrapped fg_total_qty,
            -- Revision for version 1.37
            wrosum.mandatory_scrap_flag,
            -- wrosum.wip_entity_id,
            -- wrosum.organization_id,
            -- End revision for version 1.22
            wrosum.inventory_item_id,
            wrosum.operation_seq_num,
            wrosum.component_sequence_id,
            -- Revision for version 1.27
            wrosum.item_num,
            wrosum.quantity_per_assembly,
            sum(wrosum.required_quantity) required_quantity,
            wrosum.component_yield_factor,
            sum(wrosum.quantity_issued) quantity_issued,
            wrosum.basis_type basis_type,
            wrosum.wip_supply_type,
            -- Revision for version 1.22
            msiv_comp.concatenated_segments component_number,
            msiv_comp.description component_description,
            msiv_comp.item_type component_item_type,
            msiv_comp.planning_make_buy_code comp_planning_make_buy_code,
            msiv_comp.inventory_item_status_code component_item_status_code,
            msiv_comp.primary_uom_code component_uom_code,
            -- End revision for version 1.22
            -- Revision for version 1.6 and 1.21
            -- sum(wrosum.phantom_parent) phantom_parent,
            -- Revision for version 1.2
            wrosum.comments
            -- Revision for version 1.6 and 1.14
            -- Get the WIP material requirements
     -- Revision for version 1.22
     -- from   (select 1 level_num,
     from   mtl_system_items_vl msiv_comp,
            (select 1 level_num,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    -- Revision for version 1.37
                    wdj.mandatory_scrap_flag,
                    -- wdj.primary_item_id level_1_parent_assy_id,
                    -- End revision for version 1.22
                    0 level_2_parent_assy_id,
                    0 level_3_parent_assy_id,
                    0 level_4_parent_assy_id,
                    0 level_1_comp_is_phantom,
                    0 level_2_comp_is_phantom,
                    0 level_3_comp_is_phantom,
                    0 level_4_comp_is_phantom,
                    -- Revision for version 1.6 and 1.22
                    -- wro.wip_entity_id,
                    -- wro.organization_id,
                    -- End revision for version 1.22
                    wro.inventory_item_id,
                    wro.operation_seq_num,
                    wro.component_sequence_id,
                    -- Revision for version 1.27
                    -- based on the standard BOM, get the BOM component item_num
                    nvl((select min(comp.item_num)
                         from   bom_components_b comp
                         where  wro.inventory_item_id     = comp.component_item_id
                         and    wro.wip_entity_id         = wdj.wip_entity_id
                         and    wro.component_sequence_id = comp.component_sequence_id
                         and    wro.organization_id       = wdj.organization_id
                         -- Revision for version 1.33
                         and    rownum                    = 1
                    ), '') item_num,
                    -- End revision for version 1.27
                    wro.quantity_per_assembly,
                    wro.required_quantity,
                    wro.component_yield_factor,
                    wro.quantity_issued,
                    wro.basis_type,
                    wro.wip_supply_type,
                    -- Revision for version 1.6 and 1.21
                    -- 0 phantom_parent, -- 0 is no
                    -- Revision for version 1.2
                    regexp_replace(wro.comments,'[^[:alnum:]'' '']', null) comments
             from   wip_requirement_operations wro,
                    wdj
             where  wdj.wip_entity_id               = wro.wip_entity_id
             and    wdj.organization_id             = wro.organization_id
             -- Revision for version 1.14
             -- Do not select phantom WIP supply types, not issued to WIP
             and    wro.wip_supply_type            <> 6 -- Phantom
             union all
             -- Subtract away the transactions which happened after the reported period
             -- Revision for version 1.6
             select 1 level_num,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    -- Revision for version 1.37
                    wdj.mandatory_scrap_flag,
                    -- wdj.primary_item_id level_1_parent_assy_id,
                    -- End revision for version 1.22
                    0 level_2_parent_assy_id,
                    0 level_3_parent_assy_id,
                    0 level_4_parent_assy_id,
                    0 level_1_comp_is_phantom,
                    0 level_2_comp_is_phantom,
                    0 level_3_comp_is_phantom,
                    0 level_4_comp_is_phantom,
                    -- Revision for version 1.6
                    -- Revision for version 1.22
                    -- mmt.transaction_source_id,
                    -- wro.organization_id,
                    -- End revision for version 1.22
                    mmt.inventory_item_id,
                    mmt.operation_seq_num,
                    wro.component_sequence_id,
                    -- Revision for version 1.27
                    -- Based on the standard BOM, get the BOM component item_num
                    nvl((select min(comp.item_num)
                         from   bom_components_b comp
                         where  wro.inventory_item_id     = comp.component_item_id
                         and    wro.wip_entity_id         = wdj.wip_entity_id
                         and    wro.component_sequence_id = comp.component_sequence_id
                         and    wro.organization_id       = wdj.organization_id
                         -- Revision for version 1.33
                         and    rownum                    = 1
                    ), '') item_num,
                    -- End revision for version 1.27
                    wro.quantity_per_assembly,
                    wro.required_quantity,
                    wro.component_yield_factor,
                    decode(mmt.transaction_type_id,
                            35, mmt.primary_quantity,     -- wip component issue
                            43, -1 * mmt.primary_quantity -- wip component return
                          ) quantity_issued,
                    wro.basis_type,
                    wro.wip_supply_type,
                    -- Revision for version 1.6 and 1.21
                    -- 0 phantom_parent, -- 0 is no
                    -- Revision for version 1.2
                    regexp_replace(wro.comments,'[^[:alnum:]'' '']', null) comments
             from   mtl_material_transactions mmt,
                    wdj,
                    -- Revision for version 1.10
                    -- oap.org_acct_periods oap,
                    wip_requirement_operations wro
             -- Revision for version 1.23
             where  mmt.transaction_source_type_id  = 5 -- WIP
             and    mmt.transaction_source_id       = wro.wip_entity_id
             and    mmt.organization_id             = wro.organization_id
             and    mmt.operation_seq_num           = wro.operation_seq_num
             and    mmt.inventory_item_id           = wro.inventory_item_id
             and    wro.wip_entity_id               = wdj.wip_entity_id
             and    wro.organization_id             = wdj.organization_id
             -- and    wdj.acct_period_id              = mmt.acct_period_id
             -- and    wdj.organization_id             = mmt.organization_id
             -- Revision for version 1.10
             -- and    oap.acct_period_id              = mmt.acct_period_id
             -- and    wdj.organization_id             = oap.organization_id
             -- and    mmt.transaction_date           >= oap.schedule_close_date + 1
             and    mmt.transaction_date           >= wdj.schedule_close_date + 1
             -- End revision for version 1.10
             -- End revision for version 1.23
             union all
             -- Revision for version 1.6
             -- Get components from the WIP BOM where the Supply Type is not "Phantom" (6) but
             -- the standard BOM or item master has the component as a phantom.  By doing so
             -- you can compare the standard BOM with the WIP BOM and eliminate these
             -- "phantom components" as a configuration variance.
             select 2 level_num,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    -- Revision for version 1.37
                    wdj.mandatory_scrap_flag,
                    -- wdj.primary_item_id level_1_parent_assy_id,
                    -- End revision for version 1.22
                    wro.inventory_item_id level_2_parent_assy_id,
                    0 level_3_parent_assy_id,
                    0 level_4_parent_assy_id,
                    1 level_1_comp_is_phantom,
                    0 level_2_comp_is_phantom,
                    0 level_3_comp_is_phantom,
                    0 level_4_comp_is_phantom,
                    -- Revision for version 1.22
                    -- wro.wip_entity_id,
                    -- wro.organization_id,
                    -- End revision for version 1.22
                    comp.component_item_id inventory_item_id,
                    wro.operation_seq_num,
                    wro.component_sequence_id,
                    -- Revision for version 1.27
                    comp.item_num,
                    -- Revision for version 1.8
                    -- Multiply the comp.component_quantity by the parent phantom sub-assembly quantity, wro.quantity_per_assembly
                    -- a basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
                    decode(nvl(comp.basis_type, 1),
                            1, nvl(comp.component_quantity,0) * wro.quantity_per_assembly * 1/nvl(comp.component_yield_factor,1),     -- Item basis
                            2, nvl(comp.component_quantity,1) * wro.quantity_per_assembly,                                            -- Lot
                            nvl(comp.component_quantity,0) * wro.quantity_per_assembly * 1/nvl(comp.component_yield_factor,1)         -- Any other basis
                          ) quantity_per_assembly,
                    round(case
                             when wdj.status_type in (4,5,7,12,14,15) then
                                    decode(nvl(comp.basis_type, 1),
                                            -- use the completions plus scrap quantities unless for lot-based jobs
                                            2, nvl(comp.component_quantity,0) * wro.quantity_per_assembly,                                       -- Lot
                                            nvl(comp.component_quantity,0) * wro.quantity_per_assembly * 1/nvl(comp.component_yield_factor,1)    -- Any other basis
                                                * decode(wdj.class_type,
                                                            5, nvl(wdj.quantity_completed, 0),
                                                            nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                        )
                                          )
                             -- else use the start quantity times the usage rate or amount
                             else
                                    -- Revision for version 1.5
                                    decode('&p_use_completion_qtys',
                                            'Y', decode(nvl(comp.basis_type, 1),
                                                            -- use the completions plus scrap quantities unless for lot-based jobs
                                                            2, nvl(comp.component_quantity,0) * wro.quantity_per_assembly,                                    -- Lot
                                                            nvl(comp.component_quantity,0) * wro.quantity_per_assembly * 1/nvl(comp.component_yield_factor,1) -- Any other basis
                                                                    * decode(wdj.class_type,
                                                                                    5, nvl(wdj.quantity_completed, 0),
                                                                                    nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                             )
                                                       ),
                                            -- else use the start quantity times the usage rate or amount
                                            'N', decode(nvl(comp.basis_type, 1),
                                                            2, nvl(comp.component_quantity,0) * wro.quantity_per_assembly,                                                         -- Lot
                                                            nvl(comp.component_quantity,0) * wro.quantity_per_assembly * wdj.start_quantity * 1/nvl(comp.component_yield_factor,1) -- Any other basis
                                                           )
                          ) end
                      ,6) required_quantity,
                    -- End revision for version 1.8, multiply the comp.component_quantity by wro.quantity_per_assembly
                    comp.component_yield_factor,
                    -- Issued Quantity = Quantity Per Assembly X Quantity Issued for the Parent Phantom
                    -- a basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
                    round(decode(nvl(comp.basis_type, 1),
                                    1, nvl(comp.component_quantity,0) * 1/nvl(comp.component_yield_factor,1),                   -- Item basis
                                    2, nvl(comp.component_quantity,1),                                                          -- Lot
                                    nvl(comp.component_quantity,0) * 1/nvl(comp.component_yield_factor,1)                       -- Any other basis
                                ) * wro.quantity_issued
                       ,6) quantity_issued,
                    nvl(comp.basis_type,1) basis_type,
                    -- Revision for version 1.17
                    -- nvl(comp.wip_supply_type, wro.wip_supply_type) wip_supply_type,
                    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, wro.wip_supply_type) wip_supply_type,
                    -- Revision for version 1.6 and 1.21
                    -- 1 phantom_parent, -- 1 is yes
                    -- Revision for version 1.2
                    regexp_replace(wro.comments,'[^[:alnum:]'' '']', null) comments
             from   wip_requirement_operations wro, -- Level 1 components
                    mtl_system_items_vl msiv_comp,  -- Level 1 components
                    bom_structures_b bom,           -- Get the assemblies based on WIP, at level 1
                    bom_components_b comp,          -- Level 2 components
                    wdj                             -- List of WIP Jobs
             -- ======================================================
             -- Get WIP components which are phantoms (level 1)
             -- ======================================================
             where  wdj.wip_entity_id               = wro.wip_entity_id
             and    wdj.organization_id             = wro.organization_id
             -- The WIP supply type is not "phantom" but the component bom is phantom.
             and    wro.wip_supply_type            <> 6 -- Phantom
             -- Revision for version 1.17
                 -- and    nvl(msiv_comp.item_type,'X')    = 'PH'
             and    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0) = 6
             and    msiv_comp.inventory_item_id     = wro.inventory_item_id
             and    msiv_comp.organization_id       = wro.organization_id
             -- ======================================================
             -- Get BOM components which report to phantoms (level 2)
             -- ======================================================
             and    bom.organization_id             = wdj.organization_id
             and    bom.assembly_item_id            = wro.inventory_item_id
             and    bom.bill_sequence_id            = comp.bill_sequence_id
             -- Revision for version 1.16
                 -- and    comp.effectivity_date          <= sysdate
                 -- and    nvl(comp.disable_date, sysdate+1) >  sysdate
             and    comp.effectivity_date          <
                case
                   -- Revision for version 1.21 and 1.24
                   -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                   -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                   when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                   when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                   -- End revision for version 1.21 and 1.24
                   else sysdate
                end
             and    nvl(comp.disable_date, sysdate+1) >
                case
                   when comp.disable_date is null then sysdate
                   when comp.disable_date >= sysdate then sysdate
                   when comp.disable_date < sysdate then wdj.date_closed
                   else sysdate
                end
             -- End revision for version 1.16
             and    bom.common_assembly_item_id is null
             and    bom.assembly_type               = 1   -- Manufacturing
             and    comp.component_quantity        <> 0
             and    nvl(comp.implementation_date,sysdate) =
                    decode(:p_include_unimplemented_ECOs,                                           -- p_include_unimplemented_ECOs
                        'N', nvl(comp.implementation_date,sysdate+1),
                        'Y', nvl(comp.implementation_date,sysdate))
             -- End revision for version 1.6
        ) wrosum
     where  msiv_comp.organization_id   = wrosum.organization_id
     and    msiv_comp.inventory_item_id = wrosum.inventory_item_id
     group by
            -- Revision for version 1.6
            wrosum.level_num,
            -- Revision for version 1.22
            wrosum.report_type,
            wrosum.period_name,
            wrosum.organization_code,
            wrosum.organization_id,
            wrosum.primary_cost_method,
            wrosum.account,
            wrosum.class_code,
            wrosum.class_type,
            wrosum.wip_entity_id,
            wrosum.project_id,
            wrosum.status_type,
            wrosum.primary_item_id,
            wrosum.assembly_number,
            wrosum.assy_description,
            wrosum.assy_item_type,
            wrosum.assy_item_status_code,
            wrosum.assy_uom_code,
            wrosum.planning_make_buy_code,
            wrosum.std_lot_size,
            wrosum.lot_number,
            wrosum.creation_date,
            wrosum.scheduled_start_date,
            wrosum.date_released,
            wrosum.date_completed,
            wrosum.date_closed,
            wrosum.schedule_close_date,
            wrosum.last_update_date,
            wrosum.start_quantity,
            wrosum.quantity_completed,
            wrosum.quantity_scrapped,
            wrosum.quantity_completed + wrosum.quantity_scrapped, -- wrosum.fg_total_qty
            -- Revision for version 1.37
            wrosum.mandatory_scrap_flag,
            -- wrosum.wip_entity_id,
            -- wrosum.organization_id,
            -- End revision for version 1.22
            wrosum.inventory_item_id,
            wrosum.operation_seq_num,
            wrosum.component_sequence_id,
            -- Revision for version 1.27
            wrosum.item_num,
            wrosum.quantity_per_assembly,
            wrosum.component_yield_factor,
            wrosum.basis_type,
            wrosum.wip_supply_type,
            -- Revision for version 1.22
            msiv_comp.concatenated_segments, -- component_number
            msiv_comp.description, -- component_description
            msiv_comp.item_type, -- component_item_type
            msiv_comp.planning_make_buy_code, -- comp_planning_make_buy_code
            msiv_comp.inventory_item_status_code, --  component_item_status_code
            msiv_comp.primary_uom_code, --  component_uom_code
            -- End revision for version 1.22
            -- Revision for version 1.2
            wrosum.comments
        ), -- wdj_comp
-- Revision for version 1.34
-- Get the standard BOM components
-- Include phantom components, for phantom routings
std_bom_comp as
    (select comp2.bill_sequence_id,
            -- Revision for version 1.22
            comp2.report_type,
            comp2.period_name,
            comp2.organization_code,
            comp2.organization_id,
            comp2.primary_cost_method,
            comp2.account,
            comp2.class_code,
            comp2.class_type,
            comp2.wip_entity_id,
            comp2.project_id,
            comp2.status_type,
            comp2.primary_item_id,
            comp2.assembly_number,
            comp2.assy_description,
            comp2.assy_item_type,
            comp2.assy_item_status_code,
            comp2.assy_uom_code,
            comp2.planning_make_buy_code,
            comp2.std_lot_size,
            comp2.lot_number,
            comp2.creation_date,
            comp2.scheduled_start_date,
            comp2.date_released,
            comp2.date_completed,
            comp2.date_closed,
            comp2.schedule_close_date,
            comp2.last_update_date,
            comp2.start_quantity,
            comp2.quantity_completed,
            comp2.quantity_scrapped,
            comp2.fg_total_qty,
            -- End revision for version 1.22
            comp2.level_num,
            -- Revision for version 1.36, uncomment and add in columns
            comp2.level_1_parent_assy_id,
            comp2.level_2_parent_assy_id,
            comp2.level_3_parent_assy_id,
            comp2.level_4_parent_assy_id,
            comp2.level_1_comp_is_phantom, -- 0 is no
            comp2.level_2_comp_is_phantom, -- 0 is no
            comp2.level_3_comp_is_phantom, -- 0 is no
            comp2.level_4_comp_is_phantom, -- 0 is no
            comp2.level_1_component,
            comp2.level_2_component,
            comp2.level_3_component,
            comp2.level_4_component,
            -- End revision for version 1.36
            comp2.operation_seq_num,
            -- Revision for version 1.14
            comp2.component_sequence_id,
            -- Revision for version 1.27
            comp2.item_num,
            comp2.component_item_id,
            comp2.component_quantity,
            comp2.effectivity_date,
            -- Revision for version 1.22
            -- comp2.last_update_date,
            comp2.disable_date,
            comp2.planning_factor,
            comp2.component_yield_factor,
            comp2.include_in_cost_rollup,
            comp2.basis_type,
            comp2.wip_supply_type,
            -- Revision for version 1.22
            comp2.component_number,
            comp2.component_description,
            comp2.item_type component_item_type,
            comp2.comp_planning_make_buy_code,
            comp2.component_item_status_code,
            comp2.component_uom_code,
            -- End revision for version 1.22
            -- Revision for version 1.21
            -- comp2.phantom_parent,
            comp2.supply_subinventory,
            comp2.supply_locator_id
     from   -- First BOM Explosion
            -- =================================================
            -- Get the primary (non-alternate) bills of material
            -- =================================================
            -- Get the components (level 1) from the BOM
            -- Revision for version 1.10, add hint
            (select /*+ leading(wdj) */ comp.bill_sequence_id,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                    -- End revision for version 1.22
                    1 level_num,
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id level_1_parent_assy_id,
                    -999 level_2_parent_assy_id,
                    -999 level_3_parent_assy_id,
                    -999 level_4_parent_assy_id,
                    -- Revision for version 1.36
                    -- 0 level_1_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0) level_1_comp_is_phantom, -- 0 is no
                    -- End revision for version 1.36
                    0 level_2_comp_is_phantom, -- 0 is no
                    0 level_3_comp_is_phantom, -- 0 is no
                    0 level_4_comp_is_phantom, -- 0 is no
                    msiv_comp.concatenated_segments level_1_component,
                    null level_2_component,
                    null level_3_component,
                    null level_4_component,
                    comp.operation_seq_num,
                    -- Revision for version 1.14
                    comp.component_sequence_id,
                    -- Revision for version 1.27
                    comp.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp.component_item_id,
                    comp.component_quantity,
                    max(comp.effectivity_date) effectivity_date,
                    -- Revision for version 1.22
                    -- comp.last_update_date,
                    comp.disable_date,
                    comp.planning_factor,
                    comp.component_yield_factor,
                    comp.include_in_cost_rollup,
                    comp.basis_type,
                    -- Revision for version 1.17
                    -- comp.wip_supply_type,
                    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0) wip_supply_type,
                    -- Revision for version 1.22
                    msiv_comp.concatenated_segments component_number,
                    msiv_comp.description component_description,
                    nvl(msiv_comp.item_type,'X') item_type,
                    msiv_comp.planning_make_buy_code comp_planning_make_buy_code,
                    msiv_comp.inventory_item_status_code component_item_status_code,
                    msiv_comp.primary_uom_code component_uom_code,
                    -- End revision for version 1.22
                    comp.supply_subinventory,
                    comp.supply_locator_id
             from   bom_structures_b bom,          -- Get the assemblies based on WIP, at level 0
                    bom_components_b comp,         -- Get the components on the assemblies, at level 1
                    mtl_system_items_vl msiv_comp, -- Only select components which are not phantoms
                    -- Revision for version 1.16
                    -- wdj_assys -- Limit to assemblies on WIP jobs
                    wdj                            -- List of WIP Jobs
             -- ======================================================
             -- Get assemblies and components based on WIP jobs
             -- ======================================================
             -- Revision for version 1.22, outer join BOMs to wdj
             where  bom.assembly_item_id            = wdj.primary_item_id (+)
             and    bom.organization_id             = wdj.organization_id (+)
             and    bom.bill_sequence_id            = comp.bill_sequence_id
             and    msiv_comp.inventory_item_id     = comp.component_item_id
             and    msiv_comp.organization_id       = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp.item_type,'X')   <> 'PH' -- phantom
             -- Revision for version 1.17, comment this out, version 1.34
             -- and    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0) <> 6 -- Not Phantom
             -- Revision for version 1.16
             -- and    comp.effectivity_date          <= sysdate
             -- and    nvl(comp.disable_date, sysdate+1) >  sysdate
             and    comp.effectivity_date          <
             case
                -- Revision for version 1.21 and 1.24
                -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                -- End revision for version 1.21 and 1.24
                else sysdate
             end
             and    nvl(comp.disable_date, sysdate+1) >
                        case
                           when comp.disable_date is null then sysdate
                           when comp.disable_date >= sysdate then sysdate
                           when comp.disable_date < sysdate then wdj.date_closed
                           else sysdate
                        end
             -- End revision for version 1.16
             -- Revision for version 1.27 and 1.30
             and    bom.alternate_bom_designator is null
             and    not exists
                        (select 'x'
                         from   bom_structures_b bom2
                         where  bom2.assembly_item_id         = bom.assembly_item_id
                         and    bom2.organization_id          = bom.organization_id
                         and    bom2.alternate_bom_designator = '&p_alt_bom_designator'
                         and    '&p_alt_bom_designator' is not null
                        )
             -- End revision for version 1.27 and 1.30
             and    bom.common_assembly_item_id is null
             and    bom.assembly_type               = 1   -- Manufacturing
             and    comp.component_quantity        <> 0
             and    nvl(comp.implementation_date,sysdate) =
                                decode(:p_include_unimplemented_ECOs,                                           -- p_include_unimplemented_ECOs
                                        'N', nvl(comp.implementation_date,sysdate+1),
                                        'Y', nvl(comp.implementation_date,sysdate))
             group by
                    comp.bill_sequence_id,
                    1, -- level_num
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0), -- fg_total_qty
                    -- End revision for version 1.22
                    1, -- level_num
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id, -- level_1_parent_assy_id
                    -999, -- level_2_parent_assy_id
                    -999, -- level_3_parent_assy_id
                    -999, -- level_4_parent_assy_id
                    -- Revision for version 1.36
                    -- 0 level_1_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0), -- level_1_comp_is_phantom -- 0 is no
                    -- End revision for version 1.36
                    0, -- level_2_comp_is_phantom -- 0 is no
                    0, -- level_3_comp_is_phantom -- 0 is no
                    0, -- level_4_comp_is_phantom -- 0 is no
                    msiv_comp.concatenated_segments, -- level_1_component
                    null, -- level_2_component
                    null, -- level_3_component
                    null, -- level_4_component
                    -- End revision for version 1.6
                    comp.operation_seq_num,
                    -- Revision for version 1.14
                    comp.component_sequence_id,
                    -- Revision for version 1.27
                    comp.item_num,
                    -- Revision for version 1.21
                    -- wdj.organization_id,
                    comp.component_item_id,
                    comp.component_quantity,
                    -- Revision for version 1.22
                    -- comp.last_update_date,
                    comp.disable_date,
                    comp.planning_factor,
                    comp.component_yield_factor,
                    comp.include_in_cost_rollup,
                    comp.basis_type,
                    -- Revision for version 1.17
                    -- comp.wip_supply_type,
                    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), -- wip_supply_type
                    -- Revision for version 1.6 and 1.22
                    msiv_comp.concatenated_segments, -- component_number
                    msiv_comp.description, -- component_description
                    nvl(msiv_comp.item_type,'X'), -- item_type
                    msiv_comp.planning_make_buy_code, -- comp_planning_make_buy_code
                    msiv_comp.inventory_item_status_code, -- component_item_status_code
                    msiv_comp.primary_uom_code, -- component_uom_code
                    comp.supply_subinventory,
                    comp.supply_locator_id
             union all
             -- Second BOM Explosion
             -- Get the components (level 2) from the phantoms from level 1 on the BOM
             -- Revision for version 1.10, add hint
             select /*+ leading(wdj) */ comp.bill_sequence_id,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                    -- End revision for version 1.22
                    2 level_num,
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id level_1_parent_assy_id,
                    bom_phtm.assembly_item_id level_2_parent_assy_id,
                    -999 level_3_parent_assy_id,
                    -999 level_4_parent_assy_id,
                    -- Revision for version 1.36
                    -- 1 level_1_comp_is_phantom, -- 0 is no
                    -- 0 level_2_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0) level_1_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), 6, 1, 0) level_2_comp_is_phantom, -- 0 is no
                    -- End revision for version 1.36
                    0 level_3_comp_is_phantom, -- 0 is no
                    0 level_4_comp_is_phantom, -- 0 is no
                    msiv_comp.concatenated_segments level_1_component,
                    msiv_comp2.concatenated_segments level_2_component,
                    null level_3_component,
                    null level_4_component,
                    comp_phtm.operation_seq_num,
                    -- Revision for version 1.14
                    comp_phtm.component_sequence_id,
                    -- Revision for version 1.27
                    comp_phtm.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp_phtm.component_item_id,
                    -- Revision for version 1.8
                    -- The parent sub-assembly may have a quantity required greater than one
                    -- comp_phtm.component_quantity,
                    comp_phtm.component_quantity * comp.component_quantity component_quantity,
                    -- End revision for version 1.8
                    max(comp_phtm.effectivity_date) effectivity_date,
                    -- Revision for version 1.22
                    -- comp_phtm.last_update_date,
                    comp_phtm.disable_date,
                    comp_phtm.planning_factor,
                    comp_phtm.component_yield_factor,
                    comp_phtm.include_in_cost_rollup,
                    comp_phtm.basis_type,
                    -- Revision for version 1.17
                    -- comp_phtm.wip_supply_type,
                    coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0) wip_supply_type,
                    -- Revision for version 1.22
                    msiv_comp2.concatenated_segments component_number,
                    msiv_comp2.description component_description,
                    nvl(msiv_comp2.item_type,'X') item_type,
                    msiv_comp2.planning_make_buy_code comp_planning_make_buy_code,
                    msiv_comp2.inventory_item_status_code component_item_status_code,
                    msiv_comp2.primary_uom_code component_uom_code,
                    -- End revision for version 1.22
                    -- Revision for version 1.21
                    -- 1 phantom_parent, -- 1 is yes
                    comp_phtm.supply_subinventory,
                    comp_phtm.supply_locator_id
             from   bom_structures_b bom,           -- Get the assemblies based on WIP
                    bom_components_b comp,          -- Get the components on the assemblies, at level 1
                    mtl_system_items_vl msiv_comp,  -- Restrict to components which are phantoms, at level 1
                    bom_structures_b bom_phtm,      -- Get the boms for the phantoms, at level 1
                    bom_components_b comp_phtm,     -- Get the components on phantom assemblies at level 2
                    mtl_system_items_vl msiv_comp2, -- Only select components which are not phantoms, at level 2
                    -- Revision for version 1.16
                    -- wdj_assys -- Limit to assemblies on WIP jobs
                    wdj                             -- List of WIP Jobs
             -- ======================================================
             -- Get assemblies and components based on WIP jobs
             -- ======================================================
             where  bom.assembly_item_id            = wdj.primary_item_id
             and    bom.organization_id             = wdj.organization_id
             and    bom.bill_sequence_id            = comp.bill_sequence_id
             and    msiv_comp.inventory_item_id     = comp.component_item_id
             and    msiv_comp.organization_id       = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp.item_type,'X')    = 'PH' -- phantom
             -- Revision for version 1.17 and version 1.34, comment this out
             -- and    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0) = 6 -- Phantom
             -- Revision for version 1.16
             -- and    comp.effectivity_date          <= sysdate
             -- and    nvl(comp.disable_date, sysdate+1) >  sysdate
             and    comp.effectivity_date          <
                                case
                                   -- Revision for version 1.21 and 1.24
                                   -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                   -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                   when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                   when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                   -- End revision for version 1.21 and 1.24
                                   else sysdate
                                end
                                 and    nvl(comp.disable_date, sysdate+1) >
                                case
                                   when comp.disable_date is null then sysdate
                                   when comp.disable_date >= sysdate then sysdate
                                   when comp.disable_date < sysdate then wdj.date_closed
                                   else sysdate
                                end
             -- End revision for version 1.16
             -- Revision for version 1.27 and 1.30
             and    bom.alternate_bom_designator is null
             and    not exists
                        (select 'x'
                         from   bom_structures_b bom2
                         where  bom2.assembly_item_id         = bom.assembly_item_id
                         and    bom2.organization_id          = bom.organization_id
                         and    bom2.alternate_bom_designator = '&p_alt_bom_designator'
                         and    '&p_alt_bom_designator' is not null
                        )
             -- End revision for version 1.27 and 1.30
             and    bom.common_assembly_item_id is null
             and    bom.assembly_type               = 1   -- Manufacturing
             and    comp.component_quantity        <> 0
             and    nvl(comp.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                'N', nvl(comp.implementation_date,sysdate+1),
                                                'Y', nvl(comp.implementation_date,sysdate))
             -- ======================================================
             -- Get phantom assemblies and their components
             -- ======================================================
             and    bom_phtm.assembly_item_id       = comp.component_item_id
             and    bom_phtm.organization_id        = wdj.organization_id
             and    comp_phtm.bill_sequence_id      = bom_phtm.bill_sequence_id
             and    msiv_comp2.inventory_item_id    = comp_phtm.component_item_id
             and    msiv_comp2.organization_id      = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp2.item_type,'X')  <> 'PH' -- phantom
             -- Revision for version 1.17 and version 1.34, comment this out
             -- and    coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0) <> 6 -- Not Phantom
             -- Revision for version 1.16
             -- and    comp_phtm.effectivity_date          <= sysdate
             -- and    nvl(comp_phtm.disable_date, sysdate+1) >  sysdate
             and    comp_phtm.effectivity_date     <
                                 case
                                    -- Revision for version 1.21 and 1.24
                                    -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                    -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                    when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                    when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                    -- End revision for version 1.21 and 1.24
                                    else sysdate
                                 end
             and    nvl(comp_phtm.disable_date, sysdate+1) >
                                 case
                                    when comp_phtm.disable_date is null then sysdate
                                    when comp_phtm.disable_date >= sysdate then sysdate
                                    when comp_phtm.disable_date < sysdate then wdj.date_closed
                                    else sysdate
                                 end
             -- End revision for version 1.16
             -- Revision for version 1.27 and 1.30
             and    bom_phtm.alternate_bom_designator is null
             and    not exists
                         (select 'x'
                          from   bom_structures_b bom2
                          where  bom2.assembly_item_id         = bom_phtm.assembly_item_id
                          and    bom2.organization_id          = bom_phtm.organization_id
                          and    bom2.alternate_bom_designator = '&p_alt_bom_designator'
                          and    '&p_alt_bom_designator' is not null
                         )
             -- End revision for version 1.27 and 1.30
             and    bom_phtm.common_assembly_item_id is null
             and    bom_phtm.assembly_type          = 1   -- Manufacturing
             and    comp_phtm.component_quantity   <> 0
             and    nvl(comp_phtm.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                 'N', nvl(comp_phtm.implementation_date,sysdate+1),
                                                 'Y', nvl(comp_phtm.implementation_date,sysdate))
             -- Revision for version 1.30
             -- Only include components included in the cost rollup
             and    comp.include_in_cost_rollup     = 1
             and    comp_phtm.include_in_cost_rollup = 1
             group by
                    comp.bill_sequence_id,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0), -- fg_total_qty
                    -- End revision for version 1.22
                    2, -- level_num
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id, -- level_1_parent_assy_id
                    bom_phtm.assembly_item_id, -- level_2_parent_assy_id
                    -999, -- level_3_parent_assy_id
                    -999, -- level_4_parent_assy_id
                    -- Revision for version 1.36
                    -- 1, level_1_comp_is_phantom -- 0 is no
                    -- 0, level_2_comp_is_phantom -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0), -- level_1_comp_is_phantom -- 0 is no
                    decode(coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), 6, 1, 0), -- level_2_comp_is_phantom -- 0 is no
                    -- End revision for version 1.36
                    0, -- level_3_comp_is_phantom -- 0 is no
                    0, -- level_4_comp_is_phantom -- 0 is no
                    msiv_comp.concatenated_segments, -- level_1_component
                    msiv_comp2.concatenated_segments, -- level_2_component
                    null, -- level_3_component
                    null, -- level_4_component
                    -- End revision for version 1.6
                    comp_phtm.operation_seq_num,
                    -- Revision for version 1.14
                    comp_phtm.component_sequence_id,
                    -- Revision for version 1.27
                    comp_phtm.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp_phtm.component_item_id,
                    -- Revision for version 1.8
                    -- The parent sub-assembly may have a quantity required greater than one
                    -- comp_phtm.component_quantity,
                    comp_phtm.component_quantity * comp.component_quantity,
                    -- End revision for version 1.8
                    -- Revision for version 1.22
                    -- comp_phtm.last_update_date,
                    comp_phtm.disable_date,
                    comp_phtm.planning_factor,
                    comp_phtm.component_yield_factor,
                    comp_phtm.include_in_cost_rollup,
                    comp_phtm.basis_type,
                    -- Revision for version 1.17
                    -- comp_phtm.wip_supply_type,
                    coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), -- wip_supply_type
                    -- Revision for version 1.6 and 1.22
                    msiv_comp2.concatenated_segments, -- component_number
                    msiv_comp2.description, -- component_description
                    nvl(msiv_comp2.item_type,'X'), -- item_type
                    msiv_comp2.planning_make_buy_code, -- comp_planning_make_buy_code
                    msiv_comp2.inventory_item_status_code, -- component_item_status_code
                    msiv_comp2.primary_uom_code, -- component_uom_code
                    -- End revision for version 1.22
                    -- Revision for version 1.21
                    -- 1, -- phantom_parent
                    -- End revision for version 1.6
                    comp_phtm.supply_subinventory,
                    comp_phtm.supply_locator_id
             union all
             -- Third BOM Explosion
             -- Get the components (level 3) from the phantoms which report to phantoms
             -- Revision for version 1.10, add hint
             select /*+ leading(wdj) */ comp.bill_sequence_id,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                    -- End revision for version 1.22
                    3 level_num,
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id level_1_parent_assy_id,
                    bom_phtm.assembly_item_id level_2_parent_assy_id,
                    bom_phtm2.assembly_item_id level_3_parent_assy_id,
                    -999 level_4_parent_assy_id,
                    -- Revision for version 1.36
                    -- 1 level_1_comp_is_phantom, -- 0 is no
                    -- 1 level_2_comp_is_phantom, -- 0 is no
                    -- 0 level_3_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0) level_1_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), 6, 1 , 0) level_2_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0), 6, 1 , 0) level_3_comp_is_phantom, -- 0 is no
                    -- End revision for version 1.36
                    0 level_4_comp_is_phantom, -- 0 is no
                    msiv_comp.concatenated_segments level_1_component,
                    msiv_comp2.concatenated_segments level_2_component,
                    msiv_comp3.concatenated_segments level_3_component,
                    null level_4_component,
                    -- End revision for version 1.6
                    comp_phtm2.operation_seq_num,
                    -- Revision for version 1.14
                    comp_phtm2.component_sequence_id,
                    -- Revision for version 1.27
                    comp_phtm2.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp_phtm2.component_item_id,
                    -- Revision for version 1.8
                    -- The parent sub-assembly may have a quantity required greater than one
                    -- comp_phtm2.component_quantity,
                    comp_phtm2.component_quantity * comp_phtm.component_quantity * comp.component_quantity,
                    -- End revision for version 1.8
                    max(comp_phtm2.effectivity_date) effectivity_date,
                    -- Revision for version 1.22
                    -- comp_phtm2.last_update_date,
                    comp_phtm2.disable_date,
                    comp_phtm2.planning_factor,
                    comp_phtm2.component_yield_factor,
                    comp_phtm2.include_in_cost_rollup,
                    comp_phtm2.basis_type,
                    -- Revision for version 1.17
                    -- comp_phtm2.wip_supply_type,
                    coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0) wip_supply_type,
                    -- Revision for version 1.22
                    msiv_comp3.concatenated_segments component_number,
                    msiv_comp3.description component_description,
                    nvl(msiv_comp3.item_type,'X') item_type,
                    msiv_comp3.planning_make_buy_code comp_planning_make_buy_code,
                    msiv_comp3.inventory_item_status_code component_item_status_code,
                    msiv_comp3.primary_uom_code component_uom_code,
                    -- End revision for version 1.22
                    -- Revision for version 1.21
                    -- 1 phantom_parent, -- 1 is yes
                    comp_phtm2.supply_subinventory,
                    comp_phtm2.supply_locator_id
             from   bom_structures_b bom,           -- Get the assemblies based on WIP, at level 1
                    bom_components_b comp,          -- Get the components on the assemblies, at level 1
                    mtl_system_items_vl msiv_comp,  -- Restrict to components which are phantoms, at level 1
                    bom_structures_b bom_phtm,      -- Get the boms for the phantoms, at level 1
                    bom_components_b comp_phtm,     -- Get the components on phantom assemblies, at level 2
                    mtl_system_items_vl msiv_comp2, -- Restrict to components which are phantoms, at level 2
                    bom_structures_b bom_phtm2,     -- Get the boms for the phantom assembles, at level 2
                    bom_components_b comp_phtm2,    -- Get the components on phantom assemblies, at level 3
                    mtl_system_items_vl msiv_comp3, -- Only select components which are not phantoms, at level 3
                    -- Revision for version 1.16
                    -- wdj_assys -- Limit to assemblies on WIP jobs
                    wdj                             -- List of WIP Jobs
             -- ======================================================
             -- Get the assemblies and components based on WIP jobs
             -- ======================================================
             where  bom.assembly_item_id            = wdj.primary_item_id
             and    bom.organization_id             = wdj.organization_id
             and    comp.bill_sequence_id           = bom.bill_sequence_id
             and    msiv_comp.inventory_item_id     = comp.component_item_id
             and    msiv_comp.organization_id       = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp.item_type,'X')    = 'PH' -- phantom
             -- Revision for version 1.17 and version 1.34, comment this out
             -- and    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 1) = 6 -- Phantom
             -- Revision for version 1.16
             -- and    comp.effectivity_date          <= sysdate
             -- and    nvl(comp.disable_date, sysdate+1) >  sysdate
             and    comp.effectivity_date          <
                                 case
                                    -- Revision for version 1.21 and 1.24
                                    -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                    -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                    when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                    when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                    -- End revision for version 1.21 and 1.24
                                    else sysdate
                                 end
             and    nvl(comp.disable_date, sysdate+1) >
                                 case
                                    when comp.disable_date is null then sysdate
                                    when comp.disable_date >= sysdate then sysdate
                                    when comp.disable_date < sysdate then wdj.date_closed
                                    else sysdate
                                 end
             and    nvl(comp_phtm.disable_date, sysdate+1) >
                                case
                                   when comp_phtm.disable_date is null then sysdate
                                   when comp_phtm.disable_date >= sysdate then sysdate
                                   when comp_phtm.disable_date < sysdate then wdj.date_closed
                                   else sysdate
                                end
             -- End revision for version 1.16
             -- Revision for version 1.27 and 1.30
             and    bom_phtm.alternate_bom_designator is null
             and    not exists
                            (select 'x'
                             from   bom_structures_b bom2
                             where  bom2.assembly_item_id         = bom_phtm.assembly_item_id
                             and    bom2.organization_id          = bom_phtm.organization_id
                             and    bom2.alternate_bom_designator = '&p_alt_bom_designator'
                             and    '&p_alt_bom_designator' is not null
                            )
             -- End revision for version 1.27 and 1.30
             and    bom_phtm.common_assembly_item_id is null
             and    bom_phtm.assembly_type          = 1   -- Manufacturing
             and    comp_phtm.component_quantity   <> 0
             and    nvl(comp_phtm.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                 'N', nvl(comp_phtm.implementation_date,sysdate+1),
                                                 'Y', nvl(comp_phtm.implementation_date,sysdate))
            -- ======================================================
            -- Get phantom assemblies and their components at level 2
            -- ======================================================
            and    bom_phtm.assembly_item_id       = comp.component_item_id
            and    bom_phtm.organization_id        = wdj.organization_id
            and    comp_phtm.bill_sequence_id      = bom_phtm.bill_sequence_id
            and    msiv_comp2.inventory_item_id    = comp_phtm.component_item_id
            and    msiv_comp2.organization_id      = wdj.organization_id
            -- Revision for version 1.13 and 1.17
            -- and    nvl(msiv_comp2.item_type,'X')   = 'PH' -- phantom
            -- Revision for version 1.17
            and    coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0) = 6 -- Phantom
            -- Revision for version 1.16
            -- and    comp_phtm.effectivity_date          <= sysdate
            -- and    nvl(comp_phtm.disable_date, sysdate+1) >  sysdate
            and    comp_phtm.effectivity_date     <
                                case
                                   -- Revision for version 1.21 and 1.24
                                   -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                   -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                   when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                   when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                   -- End revision for version 1.21 and 1.24
                                   else sysdate
                                end
            and    nvl(comp_phtm.disable_date, sysdate+1) >
                                case
                                   when comp_phtm.disable_date is null then sysdate
                                   when comp_phtm.disable_date >= sysdate then sysdate
                                   when comp_phtm.disable_date < sysdate then wdj.date_closed
                                   else sysdate
                                end
            -- End revision for version 1.16
            -- Revision for version 1.27 and 1.30
            and    bom_phtm.alternate_bom_designator is null
            and    not exists
                           (select 'x'
                            from   bom_structures_b bom2
                            where  bom2.assembly_item_id         = bom_phtm.assembly_item_id
                            and    bom2.organization_id          = bom_phtm.organization_id
                            and    bom2.alternate_bom_designator = '&p_alt_bom_designator'
                            and    '&p_alt_bom_designator' is not null
                           )
                         -- End revision for version 1.27 and 1.30
            and    bom_phtm.common_assembly_item_id is null
            and    bom_phtm.assembly_type          = 1   -- Manufacturing
            and    comp_phtm.component_quantity   <> 0
            and    nvl(comp_phtm.implementation_date,sysdate) =
                                        decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                'N', nvl(comp_phtm.implementation_date,sysdate+1),
                                                'Y', nvl(comp_phtm.implementation_date,sysdate))
            -- ======================================================
            -- Get the phantom assemblies and their components at level 3
            -- ======================================================
            and    bom_phtm2.assembly_item_id      = comp_phtm.component_item_id
            and    bom_phtm2.organization_id       = wdj.organization_id
            and    comp_phtm2.bill_sequence_id     = bom_phtm2.bill_sequence_id
            and    msiv_comp3.inventory_item_id    = comp_phtm2.component_item_id
            and    msiv_comp3.organization_id      = wdj.organization_id
            -- Revision for version 1.13 and 1.17
            -- and    nvl(msiv_comp3.item_type,'X')  <> 'PH' -- phantom
            -- Revision for version 1.17
            and    coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0) <> 6 -- Not Phantom
            -- Revision for version 1.16
            -- and    comp_phtm2.effectivity_date          <= sysdate
            -- and    nvl(comp_phtm2.disable_date, sysdate+1) >  sysdate
            and    comp_phtm2.effectivity_date     <
                                case
                                   -- Revision for version 1.21 and 1.24
                                   -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                   -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                   when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                   when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                   -- End revision for version 1.21 and 1.24
                                   else sysdate
                                end
            and    nvl(comp_phtm2.disable_date, sysdate+1) >
                                case
                                   when comp_phtm2.disable_date is null then sysdate
                                   when comp_phtm2.disable_date >= sysdate then sysdate
                                   when comp_phtm2.disable_date < sysdate then wdj.date_closed
                                   else sysdate
                                end
                        -- End revision for version 1.16
            -- Revision for version 1.27 and 1.30
            and    bom_phtm2.alternate_bom_designator is null
            and    not exists
                           (select 'x'
                            from   bom_structures_b bom2
                            where  bom2.assembly_item_id         = bom_phtm2.assembly_item_id
                            and    bom2.organization_id          = bom_phtm2.organization_id
                            and    bom2.alternate_bom_designator = '&p_alt_bom_designator'
                            and    '&p_alt_bom_designator' is not null
                           )
            -- End revision for version 1.27 and 1.30
            and    bom_phtm2.common_assembly_item_id is null
            and    bom_phtm2.assembly_type         = 1   -- Manufacturing
            and    comp_phtm2.component_quantity  <> 0
            and    nvl(comp_phtm2.implementation_date,sysdate) =
                                        decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                'N', nvl(comp_phtm2.implementation_date,sysdate+1),
                                                'Y', nvl(comp_phtm2.implementation_date,sysdate))
            -- Revision for version 1.30
            -- Only include components included in the cost rollup
            and    comp.include_in_cost_rollup     = 1
            and    comp_phtm.include_in_cost_rollup = 1
            and    comp_phtm2.include_in_cost_rollup = 1
             group by
                    comp.bill_sequence_id,
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account, -- account
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0), -- fg_total_qty
                    -- End revision for version 1.22
                    3, -- level_num
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id, -- level_1_parent_assy_id
                    bom_phtm.assembly_item_id, -- level_2_parent_assy_id
                    bom_phtm2.assembly_item_id, -- level_3_parent_assy_id
                    -999, -- level_4_parent_assy_id
                    -- Revision for version 1.36
                    -- 1, -- level_1_comp_is_phantom -- 0 is no
                    -- 1, -- level_2_comp_is_phantom -- 0 is no
                    -- 0, -- level_3_comp_is_phantom -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0), -- level_1_comp_is_phantom -- 0 is no
                    decode(coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), 6, 1 , 0), -- level_2_comp_is_phantom -- 0 is no
                    decode(coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0), 6, 1 , 0), -- level_3_comp_is_phantom -- 0 is no
                    -- End revision for version 1.36
                    0, -- level_4_comp_is_phantom -- 0 is no
                    msiv_comp.concatenated_segments, -- level_1_component
                    msiv_comp2.concatenated_segments, -- level_2_component
                    msiv_comp3.concatenated_segments, -- level_3_component
                    null, -- level_4_component
                    -- End revision for version 1.6
                    comp_phtm2.operation_seq_num,
                    -- Revision for version 1.14
                    comp_phtm2.component_sequence_id,
                    -- Revision for version 1.27
                    comp_phtm2.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp_phtm2.component_item_id,
                    -- Revision for version 1.8
                    -- The parent sub-assembly may have a quantity required greater than one
                    -- comp_phtm2.component_quantity,
                    comp_phtm2.component_quantity * comp_phtm.component_quantity * comp.component_quantity,
                    -- End revision for version 1.8
                    -- Revision for version 1.22
                    -- comp_phtm2.last_update_date,
                    comp_phtm2.disable_date,
                    comp_phtm2.planning_factor,
                    comp_phtm2.component_yield_factor,
                    comp_phtm2.include_in_cost_rollup,
                    comp_phtm2.basis_type,
                    -- Revision for version 1.17
                    -- comp_phtm2.wip_supply_type,
                    coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0), -- wip_supply_type
                    -- Revision for version 1.22
                    msiv_comp3.concatenated_segments, -- component_number
                    msiv_comp3.description, -- component_description
                    nvl(msiv_comp3.item_type,'X'), -- item_type
                    msiv_comp3.planning_make_buy_code, -- comp_planning_make_buy_code
                    msiv_comp3.inventory_item_status_code, -- component_item_status_code
                    msiv_comp3.primary_uom_code, -- component_uom_code
                    -- End revision for version 1.22
                    -- Revision for version 1.21
                    -- 1 phantom_parent, -- 1 is yes
                    comp_phtm2.supply_subinventory,
                    comp_phtm2.supply_locator_id
             union all
             -- Fourth BOM Explosion
             -- Get the components (level 4) from the phantoms which report to phantoms which report to phantoms
             -- Revision for version 1.10, add hint
             select /*+ leading(wdj) */ comp.bill_sequence_id,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                    -- End revision for version 1.22
                    4 level_num,
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id level_1_parent_assy_id,
                    bom_phtm.assembly_item_id level_2_parent_assy_id,
                    bom_phtm2.assembly_item_id level_3_parent_assy_id,
                    bom_phtm3.assembly_item_id level_4_parent_assy_id,
                    -- Revision for version 1.36
                    -- 1 level_1_comp_is_phantom,
                    -- 1 level_2_comp_is_phantom,
                    -- 1 level_3_comp_is_phantom,
                    -- 0 level_4_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0) level_1_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), 6, 1 , 0) level_2_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0), 6, 1 , 0) level_3_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp_phtm3.wip_supply_type, msiv_comp4.wip_supply_type, 0), 6, 1 , 0) level_4_comp_is_phantom, -- 0 is no
                    -- End revision for version 1.36
                    msiv_comp.concatenated_segments level_1_component,
                    msiv_comp2.concatenated_segments level_2_component,
                    msiv_comp3.concatenated_segments level_3_component,
                    msiv_comp4.concatenated_segments level_4_component,
                    comp_phtm3.operation_seq_num,
                    -- Revision for version 1.14
                    comp_phtm3.component_sequence_id,
                    -- Revision for version 1.27
                    comp_phtm3.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp_phtm3.component_item_id,
                    -- Revision for version 1.8
                    -- The parent sub-assembly may have a quantity required greater than one
                    -- comp_phtm3.component_quantity,
                    comp_phtm3.component_quantity * comp_phtm2.component_quantity * comp_phtm.component_quantity * comp.component_quantity,
                    -- End revision for version 1.8
                    max(comp_phtm3.effectivity_date) effectivity_date,
                    -- Revision for version 1.22
                    -- comp_phtm3.last_update_date,
                    comp_phtm3.disable_date,
                    comp_phtm3.planning_factor,
                    comp_phtm3.component_yield_factor,
                    comp_phtm3.include_in_cost_rollup,
                    comp_phtm3.basis_type,
                    -- Revision for version 1.17
                    -- comp_phtm3.wip_supply_type,
                    coalesce(comp_phtm3.wip_supply_type, msiv_comp4.wip_supply_type, 0) wip_supply_type,
                    -- Revision for version 1.22
                    msiv_comp4.concatenated_segments component_number,
                    msiv_comp4.description component_description,
                    nvl(msiv_comp4.item_type,'X') item_type,
                    msiv_comp4.planning_make_buy_code comp_planning_make_buy_code,
                    msiv_comp4.inventory_item_status_code component_item_status_code,
                    msiv_comp4.primary_uom_code component_uom_code,
                    -- End revision for version 1.22
                    -- Revision for version 1.21
                    -- 1 phantom_parent, -- 1 is yes
                    comp_phtm3.supply_subinventory,
                    comp_phtm3.supply_locator_id
             from   bom_structures_b bom,       -- Get the assemblies based on WIP, at level 1
                    bom_components_b comp,          -- Get the components on the assemblies, at level 1
                    mtl_system_items_vl msiv_comp,  -- Restrict to components which are phantoms, at level 1
                    bom_structures_b bom_phtm,      -- Get the boms for the phantoms, at level 1
                    bom_components_b comp_phtm,     -- Get the components on phantom assemblies, at level 2
                    mtl_system_items_vl msiv_comp2, -- Restrict to components which are phantoms, at level 2
                    bom_structures_b bom_phtm2,     -- Get the boms for the phantom assembles, at level 2
                    bom_components_b comp_phtm2,    -- Get the components on phantom assemblies, at level 3
                    mtl_system_items_vl msiv_comp3, -- Restrict to components which are phantoms, at level 3
                    bom_structures_b bom_phtm3,     -- Get the boms for the phantom assembles, at level 3
                    bom_components_b comp_phtm3,    -- Get the components on phantom assemblies, at level 4
                    mtl_system_items_vl msiv_comp4, -- Only select components which are not phantoms, at level 4
                    -- Revision for version 1.16
                    -- wdj_assys -- Limit to assemblies on WIP jobs
                    wdj                             -- List of WIP Jobs
             -- ======================================================
             -- Get the assemblies and components based on WIP jobs
             -- ======================================================
             where  bom.assembly_item_id            = wdj.primary_item_id
             and    bom.organization_id             = wdj.organization_id
             and    comp.bill_sequence_id           = bom.bill_sequence_id
             and    msiv_comp.inventory_item_id     = comp.component_item_id
             and    msiv_comp.organization_id       = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp.item_type,'X')    = 'PH' -- phantom
             -- Revision for version 1.17 and version 1.34, comment this out
             -- and    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0) = 6 -- Phantom
             -- Revision for version 1.16
             -- and    comp.effectivity_date          <= sysdate
             -- and    nvl(comp.disable_date, sysdate+1) >  sysdate
             and    comp.effectivity_date          <
                                 case
                                    -- Revision for version 1.21 and 1.24
                                    -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                    -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                    when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                    when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                    -- End revision for version 1.21 and 1.24
                                    else sysdate
                                 end
             and    nvl(comp.disable_date, sysdate+1) >
                                 case
                                    when comp.disable_date is null then sysdate
                                    when comp.disable_date >= sysdate then sysdate
                                    when comp.disable_date < sysdate then wdj.date_closed
                                    else sysdate
                                 end
             -- End revision for version 1.16
             -- Revision for version 1.27 and 1.30
             and    bom.alternate_bom_designator is null
             and    not exists
                            (select 'x'
                             from   bom_structures_b bom2
                             where  bom2.assembly_item_id         = bom.assembly_item_id
                             and    bom2.organization_id          = bom.organization_id
                             and    bom2.alternate_bom_designator = '&p_alt_bom_designator'
                             and    '&p_alt_bom_designator' is not null
                            )
             -- End revision for version 1.27 and 1.30
             and    bom.common_assembly_item_id is null
             and    bom.assembly_type               = 1   -- Manufacturing
             and    comp.component_quantity        <> 0
             and    nvl(comp.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                'N', nvl(comp.implementation_date,sysdate+1),
                                                'Y', nvl(comp.implementation_date,sysdate))
             -- ======================================================
             -- Get phantom assemblies and their components at level 2
             -- ======================================================
             and    bom_phtm.assembly_item_id       = comp.component_item_id
             and    bom_phtm.organization_id        = wdj.organization_id
             and    comp_phtm.bill_sequence_id      = bom_phtm.bill_sequence_id
             and    msiv_comp2.inventory_item_id    = comp_phtm.component_item_id
             and    msiv_comp2.organization_id      = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp2.item_type,'X')   = 'PH' -- phantom
             -- Revision for version 1.17 and version 1.34, comment this out
             -- and    coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0) = 6 -- Phantom
             -- Revision for version 1.16
             -- and    comp_phtm.effectivity_date          <= sysdate
             -- and    nvl(comp_phtm.disable_date, sysdate+1) >  sysdate
             and    comp_phtm.effectivity_date     <
                                 case
                                    -- Revision for version 1.21 and 1.24
                                    -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                    -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                    when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                    when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                    -- End revision for version 1.21 and 1.24
                                    else sysdate
                                 end
             and    nvl(comp_phtm.disable_date, sysdate+1) >
                                 case
                                    when comp_phtm.disable_date is null then sysdate
                                    when comp_phtm.disable_date >= sysdate then sysdate
                                    when comp_phtm.disable_date < sysdate then wdj.date_closed
                                    else sysdate
                                 end
             --End revision for version 1.16
             --Revision for version 1.27 and 1.30
             and    bom_phtm.alternate_bom_designator is null
             and    not exists
                            (select 'x'
                             from   bom_structures_b bom2
                             where  bom2.assembly_item_id         = bom_phtm.assembly_item_id
                             and    bom2.organization_id          = bom_phtm.organization_id
                             and    bom2.alternate_bom_designator = '&p_alt_bom_designator'
                             and    '&p_alt_bom_designator' is not null
                            )
             --End revision for version 1.27 and 1.30
             and    bom_phtm.common_assembly_item_id is null
             and    bom_phtm.assembly_type          = 1   -- Manufacturing
             and    comp_phtm.component_quantity   <> 0
             and    nvl(comp_phtm.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                 'N', nvl(comp_phtm.implementation_date,sysdate+1),
                                                 'Y', nvl(comp_phtm.implementation_date,sysdate))
             --======================================================
             --Get the phantom assemblies and their components at level 3
             --======================================================
             and    bom_phtm2.assembly_item_id      = comp_phtm.component_item_id
             and    bom_phtm2.organization_id       = wdj.organization_id
             and    comp_phtm2.bill_sequence_id     = bom_phtm2.bill_sequence_id
             and    msiv_comp3.inventory_item_id    = comp_phtm2.component_item_id
             and    msiv_comp3.organization_id      = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp3.item_type,'X')   = 'PH' -- phantom
             -- Revision for version 1.17 and version 1.34, comment this out
             -- and    coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0) = 6 -- Phantom
             -- Revision for version 1.16
             -- and    comp_phtm2.effectivity_date          <= sysdate
             -- and    nvl(comp_phtm2.disable_date, sysdate+1) >  sysdate
             and    comp_phtm2.effectivity_date     <
                                 case
                                    -- Revision for version 1.21 and 1.24
                                    -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                    -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                    when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                    when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                    -- End revision for version 1.21 and 1.24
                                    else sysdate
                                 end
             and    nvl(comp_phtm2.disable_date, sysdate+1) >
                                 case
                                    when comp_phtm2.disable_date is null then sysdate
                                    when comp_phtm2.disable_date >= sysdate then sysdate
                                    when comp_phtm2.disable_date < sysdate then wdj.date_closed
                                    else sysdate
                                 end
             -- End revision for version 1.16
             -- Revision for version 1.27 and 1.30
             and    bom_phtm2.alternate_bom_designator is null
             and    not exists
                            (select 'x'
                             from   bom_structures_b bom2
                             where  bom2.assembly_item_id         = bom_phtm2.assembly_item_id
                             and    bom2.organization_id          = bom_phtm2.organization_id
                             and    bom2.alternate_bom_designator = '&p_alt_bom_designator'
                             and    '&p_alt_bom_designator' is not null
                            )
             -- End revision for version 1.27 and 1.30
             and    bom_phtm2.common_assembly_item_id is null
             and    bom_phtm2.assembly_type         = 1   -- Manufacturing
             and    comp_phtm2.component_quantity  <> 0
             and    nvl(comp_phtm2.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                'N', nvl(comp_phtm2.implementation_date,sysdate+1),
                                                'Y', nvl(comp_phtm2.implementation_date,sysdate))
             --======================================================
             --Get the phantom assemblies and their components at level 4
             --======================================================
             and    bom_phtm3.assembly_item_id      = comp_phtm2.component_item_id
             and    bom_phtm3.organization_id       = wdj.organization_id
             and    comp_phtm3.bill_sequence_id     = bom_phtm3.bill_sequence_id
             and    msiv_comp4.inventory_item_id    = comp_phtm3.component_item_id
             and    msiv_comp4.organization_id      = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- nvl(msiv_comp4.item_type,'X')  <> 'PH' -- phantom
             -- Revision for version 1.17, the fourth level component should not be a phantom
             and    coalesce(comp_phtm3.wip_supply_type, msiv_comp4.wip_supply_type, 0) <> 6 -- Not Phantom
             -- Revision for version 1.16
             -- and    comp_phtm3.effectivity_date          <= sysdate
             -- and    nvl(comp_phtm3.disable_date, sysdate+1) >  sysdate
             and    comp_phtm3.effectivity_date    <
                                 case
                                    -- Revision for version 1.21 and 1.24
                                    -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                    -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                    when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                    when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                    -- End revision for version 1.21 and 1.24
                                    else sysdate
                                 end
             and    nvl(comp_phtm3.disable_date, sysdate+1) >
                                 case
                                    when comp_phtm3.disable_date is null then sysdate
                                    when comp_phtm3.disable_date >= sysdate then sysdate
                                    when comp_phtm3.disable_date < sysdate then wdj.date_closed
                                    else sysdate
                                 end
             -- End revision for version 1.16
             -- Revision for version 1.27 and 1.30
             and    bom_phtm3.alternate_bom_designator is null
             and    not exists
                           (select 'x'
                            from   bom_structures_b bom2
                            where  bom2.assembly_item_id         = bom_phtm3.assembly_item_id
                            and    bom2.organization_id          = bom_phtm3.organization_id
                            and    bom2.alternate_bom_designator = '&p_alt_bom_designator'
                            and    '&p_alt_bom_designator' is not null
                           )
             -- End revision for version 1.27 and 1.30
             and    bom_phtm3.common_assembly_item_id is null
             and    bom_phtm3.assembly_type         = 1   -- Manufacturing
             and    comp_phtm3.component_quantity  <> 0
             and    nvl(comp_phtm3.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                'N', nvl(comp_phtm3.implementation_date,sysdate+1),
                                                'Y', nvl(comp_phtm3.implementation_date,sysdate))
             -- Revision for version 1.30
             -- Only include components included in the cost rollup
             and    comp.include_in_cost_rollup     = 1
             and    comp_phtm.include_in_cost_rollup = 1
             and    comp_phtm2.include_in_cost_rollup = 1
             and    comp_phtm3.include_in_cost_rollup = 1
             group by
                    comp.bill_sequence_id,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0), -- fg_total_qty
                    -- End revision for version 1.22
                    4, -- level_num
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id, -- level_1_parent_assy_id
                    bom_phtm.assembly_item_id, -- level_2_parent_assy_id
                    bom_phtm2.assembly_item_id, -- level_3_parent_assy_id
                    bom_phtm3.assembly_item_id, -- level_4_parent_assy_id
                    -- Revision for version 1.36
                    -- 1, -- level_1_comp_is_phantom
                    -- 1, -- level_2_comp_is_phantom
                    -- 1, -- level_3_comp_is_phantom
                    -- 0, -- level_4_comp_is_phantom
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0), -- level_1_comp_is_phantom -- 0 is no
                    decode(coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), 6, 1 , 0), -- level_2_comp_is_phantom -- 0 is no
                    decode(coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0), 6, 1 , 0), -- level_3_comp_is_phantom -- 0 is no
                    decode(coalesce(comp_phtm3.wip_supply_type, msiv_comp4.wip_supply_type, 0), 6, 1 , 0), -- level_4_comp_is_phantom -- 0 is no
                    -- End revision for version 1.36
                    msiv_comp.concatenated_segments, -- level_1_component
                    msiv_comp2.concatenated_segments, -- level_2_component
                    msiv_comp3.concatenated_segments, -- level_3_component
                    msiv_comp4.concatenated_segments, -- level_4_component
                    -- End revision for version 1.6
                    comp_phtm3.operation_seq_num,
                    -- Revision for version 1.14
                    comp_phtm3.component_sequence_id,
                    -- Revision for version 1.27
                    comp_phtm3.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp_phtm3.component_item_id,
                    -- Revision for version 1.8
                    -- The parent sub-assembly may have a quantity required greater than one
                    -- comp_phtm3.component_quantity,
                    comp_phtm3.component_quantity * comp_phtm2.component_quantity * comp_phtm.component_quantity * comp.component_quantity,
                    -- End revision for version 1.8
                    -- Revision for version 1.22
                    -- comp_phtm3.last_update_date,
                    comp_phtm3.disable_date,
                    comp_phtm3.planning_factor,
                    comp_phtm3.component_yield_factor,
                    comp_phtm3.include_in_cost_rollup,
                    comp_phtm3.basis_type,
                    -- Revision for version 1.17
                    -- comp_phtm3.wip_supply_type,
                    coalesce(comp_phtm3.wip_supply_type, msiv_comp4.wip_supply_type, 0), -- wip_supply_type
                    -- Revision for version 1.6 and 1.22
                    msiv_comp4.concatenated_segments, -- component_number
                    msiv_comp4.description, -- component_description
                    nvl(msiv_comp4.item_type,'X'), -- item_type
                    msiv_comp4.planning_make_buy_code, -- comp_planning_make_buy_code
                    msiv_comp4.inventory_item_status_code, -- component_item_status_code
                    msiv_comp4.primary_uom_code, -- component_uom_code
                    -- End revision for version 1.22
                    -- Revision for version 1.21
                    -- 1, -- phantom_parent
                    -- End revision for version 1.6
                    comp_phtm3.supply_subinventory,
                    comp_phtm3.supply_locator_id
             union all
             -- ======================================
             -- Get the alternate bills of material
             -- ======================================
             -- Get the non-phantom components (level 1) from the BOM
             -- Revision for version 1.10, add hint
             select /*+ leading(wdj) */ comp.bill_sequence_id,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                    -- End revision for version 1.22
                    1 level_num,
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id level_1_parent_assy_id,
                    -999 level_2_parent_assy_id,
                    -999 level_3_parent_assy_id,
                    -999 level_4_parent_assy_id,
                    -- Revision for version 1.36
                    -- 0 level_1_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0) level_1_comp_is_phantom, -- 0 is no
                    -- End revision for version 1.36
                    0 level_2_comp_is_phantom, -- 0 is no
                    0 level_3_comp_is_phantom, -- 0 is no
                    0 level_4_comp_is_phantom, -- 0 is no
                    -- End revision for version 1.22
                    msiv_comp.concatenated_segments level_1_component,
                    null level_2_component,
                    null level_3_component,
                    null level_4_component,
                    comp.operation_seq_num,
                    -- Revision for version 1.14
                    comp.component_sequence_id,
                    -- Revision for version 1.27
                    comp.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp.component_item_id,
                    comp.component_quantity,
                    max(comp.effectivity_date) effectivity_date,
                    -- Revision for version 1.22
                    -- comp.last_update_date,
                    comp.disable_date,
                    comp.planning_factor,
                    comp.component_yield_factor,
                    comp.include_in_cost_rollup,
                    comp.basis_type,
                    -- Revision for version 1.17
                    -- comp.wip_supply_type,
                    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0) wip_supply_type,
                    -- Revision for version 1.22
                    msiv_comp.concatenated_segments component_number,
                    msiv_comp.description component_description,
                    nvl(msiv_comp.item_type,'X') item_type,
                    msiv_comp.planning_make_buy_code comp_planning_make_buy_code,
                    msiv_comp.inventory_item_status_code component_item_status_code,
                    msiv_comp.primary_uom_code component_uom_code,
                    -- End revision for version 1.22
                    comp.supply_subinventory,
                    comp.supply_locator_id
             from   bom_structures_b bom,          -- Get the assemblies based on WIP, at level 0
                    bom_components_b comp,         -- Get the components on the assemblies, at level 1
                    mtl_system_items_vl msiv_comp, -- Only select components which are not phantoms
                    -- Revision for version 1.16
                    -- wdj_assys -- Limit to assemblies on WIP jobs
                    wdj                            -- List of WIP Jobs
             -- ======================================================
             -- Get assemblies and components based on WIP jobs
             -- ======================================================
             -- Revision for version 1.22, outer join BOMs to wdj
             where  bom.assembly_item_id            = wdj.primary_item_id (+)
             and    bom.organization_id             = wdj.organization_id (+)
             and    bom.bill_sequence_id            = comp.bill_sequence_id
             and    msiv_comp.inventory_item_id     = comp.component_item_id
             and    msiv_comp.organization_id       = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp.item_type,'X')   <> 'PH' -- phantom
             -- Revision for version 1.17 and version 1.34, comment this out
             -- and    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0) <> 6 -- Not Phantom
             -- Revision for version 1.16
             -- and    comp.effectivity_date          <= sysdate
             -- and    nvl(comp.disable_date, sysdate+1) >  sysdate
             and    comp.effectivity_date          <
                                 case
                                    -- Revision for version 1.21 and 1.24
                                    -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                    -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                    when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                    when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                    -- End revision for version 1.21 and 1.24
                                    else sysdate
                                 end
             and    nvl(comp.disable_date, sysdate+1) >
                                 case
                                    when comp.disable_date is null then sysdate
                                    when comp.disable_date >= sysdate then sysdate
                                    when comp.disable_date < sysdate then wdj.date_closed
                                    else sysdate
                                 end
             -- End revision for version 1.16
             -- Revision for version 1.27
             and    bom.alternate_bom_designator    = '&p_alt_bom_designator'
             and    '&p_alt_bom_designator' is not null
             -- End revision for version 1.27
             and    bom.common_assembly_item_id is null
             and    bom.assembly_type               = 1   -- Manufacturing
             and    comp.component_quantity        <> 0
             and    nvl(comp.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                 'N', nvl(comp.implementation_date,sysdate+1),
                                                 'Y', nvl(comp.implementation_date,sysdate))
             -- Revision for version 1.30
             -- Only include components included in the cost rollup
             and    comp.include_in_cost_rollup     = 1
             group by
                    comp.bill_sequence_id,
                    1, -- level_num
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0), -- fg_total_qty
                    -- End revision for version 1.22
                    1, -- level_num
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id, -- level_1_parent_assy_id
                    -999, -- level_2_parent_assy_id
                    -999, -- level_3_parent_assy_id
                    -999, -- level_4_parent_assy_id
                    -- Revision for version 1.36
                    -- 0, -- level_1_comp_is_phantom
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0), -- level_1_comp_is_phantom -- 0 is no
                    -- End revision for version 1.36
                    0, -- level_2_comp_is_phantom
                    0, -- level_3_comp_is_phantom
                    0, -- level_4_comp_is_phantom
                    msiv_comp.concatenated_segments, -- level_1_component
                    null, -- level_2_component
                    null, -- level_3_component
                    null, -- level_4_component
                    -- End revision for version 1.6
                    comp.operation_seq_num,
                    -- Revision for version 1.14
                    comp.component_sequence_id,
                    -- Revision for version 1.27
                    comp.item_num,
                    -- Revision for version 1.21
                    -- wdj.organization_id,
                    comp.component_item_id,
                    comp.component_quantity,
                    -- Revision for version 1.22
                    -- comp.last_update_date,
                    comp.disable_date,
                    comp.planning_factor,
                    comp.component_yield_factor,
                    comp.include_in_cost_rollup,
                    comp.basis_type,
                    -- Revision for version 1.17
                    -- comp.wip_supply_type,
                    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), -- wip_supply_type
                    -- Revision for version 1.6 and 1.22
                    msiv_comp.concatenated_segments, -- component_number
                    msiv_comp.description, -- component_description
                    nvl(msiv_comp.item_type,'X'), -- item_type
                    msiv_comp.planning_make_buy_code, -- comp_planning_make_buy_code
                    msiv_comp.inventory_item_status_code, -- component_item_status_code
                    msiv_comp.primary_uom_code, -- component_uom_code
                    -- End revision for version  1.6 and 1.22
                    comp.supply_subinventory,
                    comp.supply_locator_id
             union all
             -- Second BOM Explosion
             -- Get the components (level 2) from the phantoms from level 1 on the BOM
             -- Revision for version 1.10, add hint
             select /*+ leading(wdj) */ comp.bill_sequence_id,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                    -- End revision for version 1.22
                    2 level_num,
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id level_1_parent_assy_id,
                    bom_phtm.assembly_item_id level_2_parent_assy_id,
                    -999 level_3_parent_assy_id,
                    -999 level_4_parent_assy_id,
                    -- Revision for version 1.36
                    -- 1 level_1_comp_is_phantom, -- 0 is no
                    -- 0 level_2_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0) level_1_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), 6, 1, 0) level_2_comp_is_phantom, -- 0 is no
                    -- End revision for version 1.36
                    0 level_3_comp_is_phantom, -- 0 is no
                    0 level_4_comp_is_phantom, -- 0 is no
                    msiv_comp.concatenated_segments level_1_component,
                    msiv_comp2.concatenated_segments level_2_component,
                    null level_3_component,
                    null level_4_component,
                    comp_phtm.operation_seq_num,
                    -- Revision for version 1.14
                    comp_phtm.component_sequence_id,
                    -- Revision for version 1.27
                    comp_phtm.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp_phtm.component_item_id,
                    -- Revision for version 1.8
                    -- The parent sub-assembly may have a quantity required greater than one
                    -- comp_phtm.component_quantity,
                    comp_phtm.component_quantity * comp.component_quantity component_quantity,
                    -- End revision for version 1.8
                    max(comp_phtm.effectivity_date) effectivity_date,
                    -- Revision for version 1.22
                    -- comp_phtm.last_update_date,
                    comp_phtm.disable_date,
                    comp_phtm.planning_factor,
                    comp_phtm.component_yield_factor,
                    comp_phtm.include_in_cost_rollup,
                    comp_phtm.basis_type,
                    -- Revision for version 1.17
                    -- comp_phtm.wip_supply_type,
                    coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0) wip_supply_type,
                    -- Revision for version 1.22
                    msiv_comp2.concatenated_segments component_number,
                    msiv_comp2.description component_description,
                    nvl(msiv_comp2.item_type,'X') item_type,
                    msiv_comp2.planning_make_buy_code comp_planning_make_buy_code,
                    msiv_comp2.inventory_item_status_code component_item_status_code,
                    msiv_comp2.primary_uom_code component_uom_code,
                    -- End revision for version 1.22
                    -- Revision for version 1.21
                    -- 1 phantom_parent, -- 1 is yes
                    comp_phtm.supply_subinventory,
                    comp_phtm.supply_locator_id
             from   bom_structures_b bom,       -- Get the assemblies based on WIP
                    bom_components_b comp,          -- Get the components on the assemblies, at level 1
                    mtl_system_items_vl msiv_comp,  -- Restrict to components which are phantoms, at level 1
                    bom_structures_b bom_phtm,      -- Get the boms for the phantoms, at level 1
                    bom_components_b comp_phtm,     -- Get the components on phantom assemblies at level 2
                    mtl_system_items_vl msiv_comp2, -- Only select components which are not phantoms, at level 2
                    -- Revision for version 1.16
                    -- wdj_assys -- Limit to assemblies on WIP jobs
                    wdj                             -- List of WIP Jobs
             -- ======================================================
             -- Get assemblies and components based on WIP jobs
             -- ======================================================
             where  bom.assembly_item_id            = wdj.primary_item_id
             and    bom.organization_id             = wdj.organization_id
             and    bom.bill_sequence_id            = comp.bill_sequence_id
             and    msiv_comp.inventory_item_id     = comp.component_item_id
             and    msiv_comp.organization_id       = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp.item_type,'X')    = 'PH' -- phantom
             -- Revision for version 1.17 and version 1.34, comment this out
             -- and    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0) = 6 -- Phantom
             -- Revision for version 1.16
             -- and    comp.effectivity_date          <= sysdate
             -- and    nvl(comp.disable_date, sysdate+1) >  sysdate
             and    comp.effectivity_date          <
                                 case
                                    -- Revision for version 1.21 and 1.24
                                    -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                    -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                    when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                    when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                    -- End revision for version 1.21 and 1.24
                                    else sysdate
                                 end
             and    nvl(comp.disable_date, sysdate+1) >
                                 case
                                    when comp.disable_date is null then sysdate
                                    when comp.disable_date >= sysdate then sysdate
                                    when comp.disable_date < sysdate then wdj.date_closed
                                    else sysdate
                                 end
             -- End revision for version 1.16
             -- Revision for version 1.27
             and    bom.alternate_bom_designator    = '&p_alt_bom_designator'
             and    '&p_alt_bom_designator' is not null
             -- End revision for version 1.27
             and    bom.common_assembly_item_id is null
             and    bom.assembly_type               = 1   -- Manufacturing
             and    comp.component_quantity        <> 0
             and    nvl(comp.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                 'N', nvl(comp.implementation_date,sysdate+1),
                                                 'Y', nvl(comp.implementation_date,sysdate))
             -- ======================================================
             -- Get phantom assemblies and their components
             -- ======================================================
             and    bom_phtm.assembly_item_id       = comp.component_item_id
             and    bom_phtm.organization_id        = wdj.organization_id
             and    comp_phtm.bill_sequence_id      = bom_phtm.bill_sequence_id
             and    msiv_comp2.inventory_item_id    = comp_phtm.component_item_id
             and    msiv_comp2.organization_id      = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp2.item_type,'X')  <> 'PH' -- phantom
             -- Revision for version 1.17 and version 1.34, comment this out
             -- and    coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0) <> 6 -- Not Phantom
             -- Revision for version 1.16
             -- and    comp_phtm.effectivity_date          <= sysdate
             -- and    nvl(comp_phtm.disable_date, sysdate+1) >  sysdate
             and    comp_phtm.effectivity_date     <
                                 case
                                    -- Revision for version 1.21 and 1.24
                                    -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                    -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                    when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                    when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                    -- End revision for version 1.21 and 1.24
                                    else sysdate
                                 end
             and    nvl(comp_phtm.disable_date, sysdate+1) >
                                 case
                                    when comp_phtm.disable_date is null then sysdate
                                    when comp_phtm.disable_date >= sysdate then sysdate
                                    when comp_phtm.disable_date < sysdate then wdj.date_closed
                                    else sysdate
                                 end
             -- End revision for version 1.16
             -- Revision for version 1.27
             and    bom_phtm.alternate_bom_designator = '&p_alt_bom_designator'
             and    '&p_alt_bom_designator' is not null
             -- End revision for version 1.27
             and    bom_phtm.common_assembly_item_id is null
             and    bom_phtm.assembly_type          = 1   -- Manufacturing
             and    comp_phtm.component_quantity   <> 0
             and    nvl(comp_phtm.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                 'N', nvl(comp_phtm.implementation_date,sysdate+1),
                                                 'Y', nvl(comp_phtm.implementation_date,sysdate))
             -- Revision for version 1.30
             -- Only include components included in the cost rollup
             and    comp.include_in_cost_rollup     = 1
             and    comp_phtm.include_in_cost_rollup = 1
             group by
                    comp.bill_sequence_id,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0), -- fg_total_qty
                    -- End revision for version 1.22
                    2, -- level_num
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id, -- level_1_parent_assy_id
                    bom_phtm.assembly_item_id, -- level_2_parent_assy_id
                    -999, -- level_3_parent_assy_id
                    -999, -- level_4_parent_assy_id
                    -- Revision for version 1.36
                    -- 1, level_1_comp_is_phantom -- 0 is no
                    -- 0, level_2_comp_is_phantom -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0), -- level_1_comp_is_phantom -- 0 is no
                    decode(coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), 6, 1, 0), -- level_2_comp_is_phantom -- 0 is no
                    -- End revision for version 1.36
                    0, -- level_3_comp_is_phantom
                    0, -- level_4_comp_is_phantom
                    msiv_comp.concatenated_segments, -- level_1_component
                    msiv_comp2.concatenated_segments, -- level_2_component
                    null, -- level_3_component
                    null, -- level_4_component
                    -- End revision for version 1.6
                    comp_phtm.operation_seq_num,
                    -- Revision for version 1.14
                    comp_phtm.component_sequence_id,
                    -- Revision for version 1.27
                    comp_phtm.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp_phtm.component_item_id,
                    -- Revision for version 1.8
                    -- The parent sub-assembly may have a quantity required greater than one
                    -- comp_phtm.component_quantity,
                    comp_phtm.component_quantity * comp.component_quantity,
                    -- End revision for version 1.8
                    -- Revision for version 1.22
                    -- comp_phtm.last_update_date,
                    comp_phtm.disable_date,
                    comp_phtm.planning_factor,
                    comp_phtm.component_yield_factor,
                    comp_phtm.include_in_cost_rollup,
                    comp_phtm.basis_type,
                    -- Revision for version 1.17
                    -- comp_phtm.wip_supply_type,
                    coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), -- wip_supply_type
                    -- Revision for version 1.6 and 1.22
                    msiv_comp2.concatenated_segments, -- component_number
                    msiv_comp2.description, -- component_description
                    nvl(msiv_comp2.item_type,'X'), -- item_type
                    msiv_comp2.planning_make_buy_code, -- comp_planning_make_buy_code
                    msiv_comp2.inventory_item_status_code, -- component_item_status_code
                    msiv_comp2.primary_uom_code, -- component_uom_code
                    -- End revision for version 1.22
                    -- Revision for version 1.21
                    -- 1, -- phantom_parent
                    -- End revision for version 1.6
                    comp_phtm.supply_subinventory,
                    comp_phtm.supply_locator_id
             union all
             -- Third BOM Explosion
             -- Get the components (level 3) from the phantoms which report to phantoms
             -- Revision for version 1.10, add hint
             select /*+ leading(wdj) */ comp.bill_sequence_id,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                    -- End revision for version 1.22
                    3 level_num,
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id level_1_parent_assy_id,
                    bom_phtm.assembly_item_id level_2_parent_assy_id,
                    bom_phtm2.assembly_item_id level_3_parent_assy_id,
                    -999 level_4_parent_assy_id,
                    -- Revision for version 1.36
                    -- 1 level_1_comp_is_phantom, -- 0 is no
                    -- 1 level_2_comp_is_phantom, -- 0 is no
                    -- 0 level_3_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0) level_1_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), 6, 1 , 0) level_2_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0), 6, 1 , 0) level_3_comp_is_phantom, -- 0 is no
                    -- End revision for version 1.36
                    0 level_4_comp_is_phantom, -- 0 is no
                    msiv_comp.concatenated_segments level_1_component,
                    msiv_comp2.concatenated_segments level_2_component,
                    msiv_comp3.concatenated_segments level_3_component,
                    null level_4_component,
                    -- End revision for version 1.6
                    comp_phtm2.operation_seq_num,
                    -- Revision for version 1.14
                    comp_phtm2.component_sequence_id,
                    -- Revision for version 1.27
                    comp_phtm2.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp_phtm2.component_item_id,
                    -- Revision for version 1.8
                    -- The parent sub-assembly may have a quantity required greater than one
                    -- comp_phtm2.component_quantity,
                    comp_phtm2.component_quantity * comp_phtm.component_quantity * comp.component_quantity,
                    -- End revision for version 1.8
                    max(comp_phtm2.effectivity_date) effectivity_date,
                    -- Revision for version 1.22
                    -- comp_phtm2.last_update_date,
                    comp_phtm2.disable_date,
                    comp_phtm2.planning_factor,
                    comp_phtm2.component_yield_factor,
                    comp_phtm2.include_in_cost_rollup,
                    comp_phtm2.basis_type,
                    -- Revision for version 1.17
                    -- comp_phtm2.wip_supply_type,
                    coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0) wip_supply_type,
                    -- Revision for version 1.22
                    msiv_comp3.concatenated_segments component_number,
                    msiv_comp3.description component_description,
                    nvl(msiv_comp3.item_type,'X') item_type,
                    msiv_comp3.planning_make_buy_code comp_planning_make_buy_code,
                    msiv_comp3.inventory_item_status_code component_item_status_code,
                    msiv_comp3.primary_uom_code component_uom_code,
                    -- End revision for version 1.22
                    -- Revision for version 1.21
                    -- 1 phantom_parent, -- 1 is yes
                    comp_phtm2.supply_subinventory,
                    comp_phtm2.supply_locator_id
             from   bom_structures_b bom,       -- Get the assemblies based on WIP, at level 1
                    bom_components_b comp,          -- Get the components on the assemblies, at level 1
                    mtl_system_items_vl msiv_comp,  -- Restrict to components which are phantoms, at level 1
                    bom_structures_b bom_phtm,      -- Get the boms for the phantoms, at level 1
                    bom_components_b comp_phtm,     -- Get the components on phantom assemblies, at level 2
                    mtl_system_items_vl msiv_comp2, -- Restrict to components which are phantoms, at level 2
                    bom_structures_b bom_phtm2,     -- Get the boms for the phantom assembles, at level 2
                    bom_components_b comp_phtm2,    -- Get the components on phantom assemblies, at level 3
                    mtl_system_items_vl msiv_comp3, -- Only select components which are not phantoms, at level 3
                    -- Revision for version 1.16
                    -- wdj_assys -- Limit to assemblies on WIP jobs
                    wdj                             -- List of WIP Jobs
             -- ======================================================
             -- Get the assemblies and components based on WIP jobs
             -- ======================================================
             where  bom.assembly_item_id            = wdj.primary_item_id
             and    bom.organization_id             = wdj.organization_id
             and    comp.bill_sequence_id           = bom.bill_sequence_id
             and    msiv_comp.inventory_item_id     = comp.component_item_id
             and    msiv_comp.organization_id       = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp.item_type,'X')    = 'PH' -- phantom
             -- Revision for version 1.17 and version 1.34, comment this out
             -- and    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 1) = 6 -- Phantom
             -- Revision for version 1.16
             -- and    comp.effectivity_date          <= sysdate
             -- and    nvl(comp.disable_date, sysdate+1) >  sysdate
             and    comp.effectivity_date          <
                                 case
                                    -- Revision for version 1.21 and 1.24
                                    -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                    -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                    when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                    when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                    -- End revision for version 1.21 and 1.24
                                    else sysdate
                                 end
             and    nvl(comp.disable_date, sysdate+1) >
                                 case
                                    when comp.disable_date is null then sysdate
                                    when comp.disable_date >= sysdate then sysdate
                                    when comp.disable_date < sysdate then wdj.date_closed
                                    else sysdate
                                 end
             -- End revision for version 1.16
             -- Revision for version 1.27
             and    bom.alternate_bom_designator    = '&p_alt_bom_designator'
             and    '&p_alt_bom_designator' is not null
             -- End revision for version 1.27
             and    bom.common_assembly_item_id is null
             and    bom.assembly_type               = 1   -- Manufacturing
             and    comp.component_quantity        <> 0
             and    nvl(comp.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                 'N', nvl(comp.implementation_date,sysdate+1),
                                                 'Y', nvl(comp.implementation_date,sysdate))
             -- ======================================================
             -- Get phantom assemblies and their components at level 2
             -- ======================================================
             and    bom_phtm.assembly_item_id       = comp.component_item_id
             and    bom_phtm.organization_id        = wdj.organization_id
             and    comp_phtm.bill_sequence_id      = bom_phtm.bill_sequence_id
             and    msiv_comp2.inventory_item_id    = comp_phtm.component_item_id
             and    msiv_comp2.organization_id      = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp2.item_type,'X')   = 'PH' -- phantom
             -- Revision for version 1.17 and version 1.34, comment this out
             -- and    coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0) = 6 -- Phantom
             -- Revision for version 1.16
             -- and    comp_phtm.effectivity_date          <= sysdate
             -- and    nvl(comp_phtm.disable_date, sysdate+1) >  sysdate
             and    comp_phtm.effectivity_date     <
                                 case
                                    -- Revision for version 1.21 and 1.24
                                    -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                    -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                    when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                    when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                    -- End revision for version 1.21 and 1.24
                                    else sysdate
                                 end
             and    nvl(comp_phtm.disable_date, sysdate+1) >
                                 case
                                    when comp_phtm.disable_date is null then sysdate
                                    when comp_phtm.disable_date >= sysdate then sysdate
                                    when comp_phtm.disable_date < sysdate then wdj.date_closed
                                    else sysdate
                                 end
             -- End revision for version 1.16
             -- Revision for version 1.27
             and    bom_phtm.alternate_bom_designator = '&p_alt_bom_designator'
             and    '&p_alt_bom_designator' is not null
             -- End revision for version 1.27
             and    bom_phtm.common_assembly_item_id is null
             and    bom_phtm.assembly_type          = 1   -- Manufacturing
             and    comp_phtm.component_quantity   <> 0
             and    nvl(comp_phtm.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                 'N', nvl(comp_phtm.implementation_date,sysdate+1),
                                                 'Y', nvl(comp_phtm.implementation_date,sysdate))
             -- ======================================================
             -- Get the phantom assemblies and their components at level 3
             -- ======================================================
             and    bom_phtm2.assembly_item_id      = comp_phtm.component_item_id
             and    bom_phtm2.organization_id       = wdj.organization_id
             and    comp_phtm2.bill_sequence_id     = bom_phtm2.bill_sequence_id
             and    msiv_comp3.inventory_item_id    = comp_phtm2.component_item_id
             and    msiv_comp3.organization_id      = wdj.organization_id
             -- Revision for version 1.13 and 1.17
             -- and    nvl(msiv_comp3.item_type,'X')  <> 'PH' -- phantom
             -- Revision for version 1.17 and version 1.34, comment this out
             -- and    coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0) <> 6 -- Not Phantom
             -- Revision for version 1.16
             -- and    comp_phtm2.effectivity_date          <= sysdate
             -- and    nvl(comp_phtm2.disable_date, sysdate+1) >  sysdate
             and    comp_phtm2.effectivity_date     <
                                 case
                                    -- Revision for version 1.21 and 1.24
                                    -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                    -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                    when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                    when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                    -- End revision for version 1.21 and 1.24
                                    else sysdate
                                 end
             and    nvl(comp_phtm2.disable_date, sysdate+1) >
                                 case
                                    when comp_phtm2.disable_date is null then sysdate
                                    when comp_phtm2.disable_date >= sysdate then sysdate
                                    when comp_phtm2.disable_date < sysdate then wdj.date_closed
                                    else sysdate
                                 end
             -- End revision for version 1.16
             -- Revision for version 1.27
             and    bom_phtm2.alternate_bom_designator = '&p_alt_bom_designator'
             and    '&p_alt_bom_designator' is not null
             -- End revision for version 1.27
             and    bom_phtm2.common_assembly_item_id is null
             and    bom_phtm2.assembly_type         = 1   -- Manufacturing
             and    comp_phtm2.component_quantity  <> 0
             and    nvl(comp_phtm2.implementation_date,sysdate) =
                                         decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                 'N', nvl(comp_phtm2.implementation_date,sysdate+1),
                                                 'Y', nvl(comp_phtm2.implementation_date,sysdate))
             -- Revision for version 1.30
             -- Only include components included in the cost rollup
             and    comp.include_in_cost_rollup     = 1
             and    comp_phtm.include_in_cost_rollup = 1
             and    comp_phtm2.include_in_cost_rollup = 1
             group by
                    comp.bill_sequence_id,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0), -- fg_total_qty
                    -- End revision for version 1.22
                    3, -- level_num
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id, -- level_1_parent_assy_id
                    bom_phtm.assembly_item_id, -- level_2_parent_assy_id
                    bom_phtm2.assembly_item_id, -- level_3_parent_assy_id
                    -999, -- level_4_parent_assy_id
                    -- Revision for version 1.36
                    -- 1, -- level_1_comp_is_phantom -- 0 is no
                    -- 1, -- level_2_comp_is_phantom -- 0 is no
                    -- 0, -- level_3_comp_is_phantom -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0), -- level_1_comp_is_phantom -- 0 is no
                    decode(coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), 6, 1 , 0), -- level_2_comp_is_phantom -- 0 is no
                    decode(coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0), 6, 1 , 0), -- level_3_comp_is_phantom -- 0 is no
                    -- End revision for version 1.36
                    0, -- level_4_from_phantom_assy
                    msiv_comp.concatenated_segments, -- level_1_component
                    msiv_comp2.concatenated_segments, -- level_2_component
                    msiv_comp3.concatenated_segments, -- level_3_component
                    null, -- level_4_component
                    -- Revision for version 1.6
                    comp_phtm2.operation_seq_num,
                    -- Revision for version 1.14
                    comp_phtm2.component_sequence_id,
                    -- Revision for version 1.27
                    comp_phtm2.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp_phtm2.component_item_id,
                    -- Revision for version 1.8
                    -- The parent sub-assembly may have a quantity required greater than one
                    -- comp_phtm2.component_quantity,
                    comp_phtm2.component_quantity * comp_phtm.component_quantity * comp.component_quantity,
                    -- End revision for version 1.8
                    -- Revision for version 1.22
                    -- comp_phtm2.last_update_date,
                    comp_phtm2.disable_date,
                    comp_phtm2.planning_factor,
                    comp_phtm2.component_yield_factor,
                    comp_phtm2.include_in_cost_rollup,
                    comp_phtm2.basis_type,
                    -- Revision for version 1.17
                    -- comp_phtm2.wip_supply_type,
                    coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0), -- wip_supply_type
                    -- Revision for version 1.6 and 1.22
                    msiv_comp3.concatenated_segments, -- component_number
                    msiv_comp3.description, -- component_description
                    nvl(msiv_comp3.item_type,'X'), -- item_type
                    msiv_comp3.planning_make_buy_code, -- comp_planning_make_buy_code
                    msiv_comp3.inventory_item_status_code, -- component_item_status_code
                    msiv_comp3.primary_uom_code, -- component_uom_code
                    -- End revision for version 1.22
                    -- Revision for version 1.21
                    -- 1, -- phantom_parent
                    -- End revision for version 1.6
                    comp_phtm2.supply_subinventory,
                    comp_phtm2.supply_locator_id
             union all
             -- Fourth BOM Explosion
             -- Get the components (level 4) from the phantoms which report to phantoms which report to phantoms
             -- Revision for version 1.10, add hint
             select /*+ leading(wdj) */ comp.bill_sequence_id,
                    -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account account,
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                    -- End revision for version 1.22
                    4 level_num,
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id level_1_parent_assy_id,
                    bom_phtm.assembly_item_id level_2_parent_assy_id,
                    bom_phtm2.assembly_item_id level_3_parent_assy_id,
                    bom_phtm3.assembly_item_id level_4_parent_assy_id,
                     -- Revision for version 1.36
                    -- 1 level_1_comp_is_phantom,
                    -- 1 level_2_comp_is_phantom,
                    -- 1 level_3_comp_is_phantom,
                    -- 0 level_4_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0) level_1_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), 6, 1 , 0) level_2_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0), 6, 1 , 0) level_3_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp_phtm3.wip_supply_type, msiv_comp4.wip_supply_type, 0), 6, 1 , 0) level_4_comp_is_phantom, -- 0 is no
                    -- End revision for version 1.36
                    msiv_comp.concatenated_segments level_1_component,
                    msiv_comp2.concatenated_segments level_2_component,
                    msiv_comp3.concatenated_segments level_3_component,
                    msiv_comp4.concatenated_segments level_4_component,
                    comp_phtm3.operation_seq_num,
                    -- Revision for version 1.14
                    comp_phtm3.component_sequence_id,
                    -- Revision for version 1.27
                    comp_phtm3.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp_phtm3.component_item_id,
                    -- Revision for version 1.8
                    -- The parent sub-assembly may have a quantity required greater than one
                    -- comp_phtm3.component_quantity,
                    comp_phtm3.component_quantity * comp_phtm2.component_quantity * comp_phtm.component_quantity * comp.component_quantity,
                    -- End revision for version 1.8
                    max(comp_phtm3.effectivity_date) effectivity_date,
                    -- Revision for version 1.22
                    -- comp_phtm3.last_update_date,
                    comp_phtm3.disable_date,
                    comp_phtm3.planning_factor,
                    comp_phtm3.component_yield_factor,
                    comp_phtm3.include_in_cost_rollup,
                    comp_phtm3.basis_type,
                    -- Revision for version 1.17
                    -- comp_phtm3.wip_supply_type,
                    coalesce(comp_phtm3.wip_supply_type, msiv_comp4.wip_supply_type, 0) wip_supply_type,
                    -- Revision for version 1.22
                    msiv_comp4.concatenated_segments component_number,
                    msiv_comp4.description component_description,
                    nvl(msiv_comp4.item_type,'X') item_type,
                    msiv_comp4.planning_make_buy_code comp_planning_make_buy_code,
                    msiv_comp4.inventory_item_status_code component_item_status_code,
                    msiv_comp4.primary_uom_code component_uom_code,
                    -- End revision for version 1.22
                    -- Revision for version 1.21
                    comp_phtm3.supply_subinventory,
                    comp_phtm3.supply_locator_id
            from   bom_structures_b bom,           -- Get the assemblies based on WIP, at level 1
                   bom_components_b comp,          -- Get the components on the assemblies, at level 1
                   mtl_system_items_vl msiv_comp,  -- Restrict to components which are phantoms, at level 1
                   bom_structures_b bom_phtm,      -- Get the boms for the phantoms, at level 1
                   bom_components_b comp_phtm,     -- Get the components on phantom assemblies, at level 2
                   mtl_system_items_vl msiv_comp2, -- Restrict to components which are phantoms, at level 2
                   bom_structures_b bom_phtm2,     -- Get the boms for the phantom assembles, at level 2
                   bom_components_b comp_phtm2,    -- Get the components on phantom assemblies, at level 3
                   mtl_system_items_vl msiv_comp3, -- Restrict to components which are phantoms, at level 3
                   bom_structures_b bom_phtm3,     -- Get the boms for the phantom assembles, at level 3
                   bom_components_b comp_phtm3,    -- Get the components on phantom assemblies, at level 4
                   mtl_system_items_vl msiv_comp4, -- Only select components which are not phantoms, at level 4
                   -- Revision for version 1.16
                   -- wdj_assys -- Limit to assemblies on WIP jobs
                   wdj                             -- List of WIP Jobs
            -- ======================================================
            -- Get the assemblies and components based on WIP jobs
            -- ======================================================
            where  bom.assembly_item_id            = wdj.primary_item_id
            and    bom.organization_id             = wdj.organization_id
            and    comp.bill_sequence_id           = bom.bill_sequence_id
            and    msiv_comp.inventory_item_id     = comp.component_item_id
            and    msiv_comp.organization_id       = wdj.organization_id
            -- Revision for version 1.13 and 1.17
            -- and    nvl(msiv_comp.item_type,'X')    = 'PH' -- phantom
            -- Revision for version 1.17 and version 1.34, comment this out
            -- and    coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 1) = 6 -- Phantom
            -- Revision for version 1.22
            -- and    msiv_parent.inventory_item_id   = bom.assembly_item_id
            -- and    msiv_parent.organization_id     = wdj.organization_id
            -- End revision for version 1.22
            -- Revision for version 1.16
            -- and    comp.effectivity_date          <= sysdate
            -- and    nvl(comp.disable_date, sysdate+1) >  sysdate
            and    comp.effectivity_date          <
                                case
                                   -- Revision for version 1.21 and 1.24
                                   -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                   -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                   when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                   when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                   -- End revision for version 1.21 and 1.24
                                   else sysdate
                                end
            and    nvl(comp.disable_date, sysdate+1) >
                                case
                                   when comp.disable_date is null then sysdate
                                   when comp.disable_date >= sysdate then sysdate
                                   when comp.disable_date < sysdate then wdj.date_closed
                                   else sysdate
                                end
                        -- End revision for version 1.16
            -- Revision for version 1.27
            and    bom.alternate_bom_designator    = '&p_alt_bom_designator'
            and    '&p_alt_bom_designator' is not null
            -- End revision for version 1.27
            and    bom.common_assembly_item_id is null
            and    bom.assembly_type               = 1   -- Manufacturing
            and    comp.component_quantity        <> 0
            and    nvl(comp.implementation_date,sysdate) =
                                        decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                'N', nvl(comp.implementation_date,sysdate+1),
                                                'Y', nvl(comp.implementation_date,sysdate))
            -- ======================================================
            -- Get phantom assemblies and their components at level 2
            -- ======================================================
            and    bom_phtm.assembly_item_id       = comp.component_item_id
            and    bom_phtm.organization_id        = wdj.organization_id
            and    comp_phtm.bill_sequence_id      = bom_phtm.bill_sequence_id
            and    msiv_comp2.inventory_item_id    = comp_phtm.component_item_id
            and    msiv_comp2.organization_id      = wdj.organization_id
            -- Revision for version 1.13 and 1.17
            -- and    nvl(msiv_comp2.item_type,'X')   = 'PH' -- phantom
            -- Revision for version 1.17 and version 1.34, comment this out
            -- and    coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0) = 6 -- Phantom
            -- Revision for version 1.16
            -- and    comp_phtm.effectivity_date          <= sysdate
            -- and    nvl(comp_phtm.disable_date, sysdate+1) >  sysdate
            and    comp_phtm.effectivity_date     <
                                case
                                   -- Revision for version 1.21 and 1.24
                                   -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                   -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                   when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                   when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                   -- End revision for version 1.21 and 1.24
                                   else sysdate
                                end
            and    nvl(comp_phtm.disable_date, sysdate+1) >
                                case
                                   when comp_phtm.disable_date is null then sysdate
                                   when comp_phtm.disable_date >= sysdate then sysdate
                                   when comp_phtm.disable_date < sysdate then wdj.date_closed
                                   else sysdate
                                end
                        -- End revision for version 1.16
            -- Revision for version 1.27
            and    bom_phtm.alternate_bom_designator = '&p_alt_bom_designator'
            and    '&p_alt_bom_designator' is not null
            -- End revision for version 1.27
            and    bom_phtm.common_assembly_item_id is null
            and    bom_phtm.assembly_type          = 1   -- Manufacturing
            and    comp_phtm.component_quantity   <> 0
            and    nvl(comp_phtm.implementation_date,sysdate) =
                                        decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                'N', nvl(comp_phtm.implementation_date,sysdate+1),
                                                'Y', nvl(comp_phtm.implementation_date,sysdate))
            -- ======================================================
            -- Get the phantom assemblies and their components at level 3
            -- ======================================================
            and    bom_phtm2.assembly_item_id      = comp_phtm.component_item_id
            and    bom_phtm2.organization_id       = wdj.organization_id
            and    comp_phtm2.bill_sequence_id     = bom_phtm2.bill_sequence_id
            and    msiv_comp3.inventory_item_id    = comp_phtm2.component_item_id
            and    msiv_comp3.organization_id      = wdj.organization_id
            --Revision for version 1.13 and 1.17
            --and    nvl(msiv_comp3.item_type,'X')   = 'PH' -- phantom
            --Revision for version 1.17
            and    coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0) = 6 -- Phantom
            --Revision for version 1.16
            --and    comp_phtm2.effectivity_date          <= sysdate
            --and    nvl(comp_phtm2.disable_date, sysdate+1) >  sysdate
            and    comp_phtm2.effectivity_date     <
                                case
                                   -- Revision for version 1.21 and 1.24
                                   -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                   -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                   when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                   when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                   -- End revision for version 1.21 and 1.24
                                   else sysdate
                                end
            and    nvl(comp_phtm2.disable_date, sysdate+1) >
                                case
                                   when comp_phtm2.disable_date is null then sysdate
                                   when comp_phtm2.disable_date >= sysdate then sysdate
                                   when comp_phtm2.disable_date < sysdate then wdj.date_closed
                                   else sysdate
                                end
            --End revision for version 1.16
            --Revision for version 1.27
            and    bom_phtm2.alternate_bom_designator = '&p_alt_bom_designator'
            and    '&p_alt_bom_designator' is not null
            --End revision for version 1.27
            and    bom_phtm2.common_assembly_item_id is null
            and    bom_phtm2.assembly_type         = 1   -- Manufacturing
            and    comp_phtm2.component_quantity  <> 0
            and    nvl(comp_phtm2.implementation_date,sysdate) =
                                        decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                'N', nvl(comp_phtm2.implementation_date,sysdate+1),
                                                'Y', nvl(comp_phtm2.implementation_date,sysdate))
            -- ======================================================
            -- Get the phantom assemblies and their components at level 4
            -- ======================================================
            and    bom_phtm3.assembly_item_id      = comp_phtm2.component_item_id
            and    bom_phtm3.organization_id       = wdj.organization_id
            and    comp_phtm3.bill_sequence_id     = bom_phtm3.bill_sequence_id
            and    msiv_comp4.inventory_item_id    = comp_phtm3.component_item_id
            and    msiv_comp4.organization_id      = wdj.organization_id
            -- Revision for version 1.13 and 1.17
            -- nvl(msiv_comp4.item_type,'X')  <> 'PH' -- phantom
            -- Revision for version 1.17, the fourth level component should not be a phantom
            and    coalesce(comp_phtm3.wip_supply_type, msiv_comp4.wip_supply_type, 0) <> 6 -- Not Phantom
            -- Revision for version 1.16
            -- and    comp_phtm3.effectivity_date          <= sysdate
            -- and    nvl(comp_phtm3.disable_date, sysdate+1) >  sysdate
            and    comp_phtm3.effectivity_date    <
                                case
                                   -- Revision for version 1.21 and 1.24
                                   -- when wdj.schedule_close_date <= sysdate then wdj.schedule_close_date
                                   -- when wdj.date_closed <= sysdate then wdj.schedule_close_date
                                   when nvl(wdj.date_closed,sysdate) < wdj.schedule_close_date then nvl(wdj.date_closed,sysdate) + 1
                                   when nvl(wdj.date_closed,sysdate) >= wdj.schedule_close_date then wdj.schedule_close_date + 1
                                   -- End revision for version 1.21 and 1.24
                                   else sysdate
                                end
            and    nvl(comp_phtm3.disable_date, sysdate+1) >
                                case
                                   when comp_phtm3.disable_date is null then sysdate
                                   when comp_phtm3.disable_date >= sysdate then sysdate
                                   when comp_phtm3.disable_date < sysdate then wdj.date_closed
                                   else sysdate
                                end
            -- End revision for version 1.16
            -- Revision for version 1.27
            and    bom_phtm3.alternate_bom_designator = '&p_alt_bom_designator'
            and    '&p_alt_bom_designator' is not null
            -- End revision for version 1.27
            and    bom_phtm3.common_assembly_item_id is null
            and    bom_phtm3.assembly_type         = 1   -- Manufacturing
            and    comp_phtm3.component_quantity  <> 0
            and    nvl(comp_phtm3.implementation_date,sysdate) =
                                        decode(:p_include_unimplemented_ECOs,                                   -- p_include_unimplemented_ECOs
                                                'N', nvl(comp_phtm3.implementation_date,sysdate+1),
                                                'Y', nvl(comp_phtm3.implementation_date,sysdate))
            -- Revision for version 1.30
            -- Only include components included in the cost rollup
            and    comp.include_in_cost_rollup     = 1
            and    comp_phtm.include_in_cost_rollup = 1
            and    comp_phtm2.include_in_cost_rollup = 1
            and    comp_phtm3.include_in_cost_rollup = 1
            group by
                   comp.bill_sequence_id,
                   -- Revision for version 1.22
                    wdj.report_type,
                    wdj.period_name,
                    wdj.organization_code,
                    wdj.organization_id,
                    wdj.primary_cost_method,
                    wdj.material_account, -- account
                    wdj.class_code,
                    wdj.class_type,
                    wdj.wip_entity_id,
                    wdj.project_id,
                    wdj.status_type,
                    wdj.primary_item_id,
                    wdj.assembly_number,
                    wdj.assy_description,
                    wdj.assy_item_type,
                    wdj.assy_item_status_code,
                    wdj.assy_uom_code,
                    wdj.planning_make_buy_code,
                    wdj.std_lot_size,
                    wdj.lot_number,
                    wdj.creation_date,
                    wdj.scheduled_start_date,
                    wdj.date_released,
                    wdj.date_completed,
                    wdj.date_closed,
                    wdj.schedule_close_date,
                    wdj.last_update_date,
                    wdj.start_quantity,
                    wdj.quantity_completed,
                    wdj.quantity_scrapped,
                    nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0), -- fg_total_qty
                    -- End revision for version 1.22
                    4, -- level_num
                    -- Revision for version 1.36, uncomment
                    bom.assembly_item_id, -- level_1_parent_assy_id
                    bom_phtm.assembly_item_id, -- level_2_parent_assy_id
                    bom_phtm2.assembly_item_id, -- level_3_parent_assy_id
                    bom_phtm3.assembly_item_id, -- level_4_parent_assy_id
                     -- Revision for version 1.36
                    -- 1 level_1_comp_is_phantom,
                    -- 1 level_2_comp_is_phantom,
                    -- 1 level_3_comp_is_phantom,
                    -- 0 level_4_comp_is_phantom, -- 0 is no
                    decode(coalesce(comp.wip_supply_type, msiv_comp.wip_supply_type, 0), 6, 1, 0), -- level_1_comp_is_phantom -- 0 is no
                    decode(coalesce(comp_phtm.wip_supply_type, msiv_comp2.wip_supply_type, 0), 6, 1 , 0), -- level_2_comp_is_phantom -- 0 is no
                    decode(coalesce(comp_phtm2.wip_supply_type, msiv_comp3.wip_supply_type, 0), 6, 1 , 0), -- level_3_comp_is_phantom -- 0 is no
                    decode(coalesce(comp_phtm3.wip_supply_type, msiv_comp4.wip_supply_type, 0), 6, 1 , 0), -- level_4_comp_is_phantom -- 0 is no
                    -- End revision for version 1.36
                    msiv_comp.concatenated_segments, -- level_1_component
                    msiv_comp2.concatenated_segments, -- level_2_component
                    msiv_comp3.concatenated_segments, -- level_3_component
                    msiv_comp4.concatenated_segments, -- level_4_component
                    comp_phtm3.operation_seq_num,
                    -- Revision for version 1.14
                    comp_phtm3.component_sequence_id,
                    -- Revision for version 1.27
                    comp_phtm3.item_num,
                    -- Revision for version 1.22
                    -- wdj.organization_id,
                    comp_phtm3.component_item_id,
                    -- Revision for version 1.8
                    -- The parent sub-assembly may have a quantity required greater than one
                    -- comp_phtm3.component_quantity,
                    comp_phtm3.component_quantity * comp_phtm2.component_quantity * comp_phtm.component_quantity * comp.component_quantity,
                    -- End revision for version 1.8
                    -- Revision for version 1.22
                    -- comp_phtm3.last_update_date,
                    comp_phtm3.disable_date,
                    comp_phtm3.planning_factor,
                    comp_phtm3.component_yield_factor,
                    comp_phtm3.include_in_cost_rollup,
                    comp_phtm3.basis_type,
                    -- Revision for version 1.17
                    -- comp_phtm3.wip_supply_type,
                    coalesce(comp_phtm3.wip_supply_type, msiv_comp4.wip_supply_type, 0), -- wip_supply_type
                    -- Revision for version 1.22
                    msiv_comp4.concatenated_segments, -- component_number
                    msiv_comp4.description, -- component_description
                    nvl(msiv_comp4.item_type,'X'), -- item_type
                    msiv_comp4.planning_make_buy_code, -- comp_planning_make_buy_code
                    msiv_comp4.inventory_item_status_code, -- component_item_status_code
                    msiv_comp4.primary_uom_code, -- component_uom_code
                    -- End revision for version 1.22
                    -- Revision for version 1.21
                    comp_phtm3.supply_subinventory,
                    comp_phtm3.supply_locator_id
            ) comp2
    ), -- std_bom_comp
-- Revision for version 1.35
wip_comp_list as
        (-- Get the WIP components
         select distinct
                wro.period_name,
                wro.organization_code,
                wro.organization_id,
                wro.primary_cost_method,
                wro.wip_entity_id,
                wro.project_id,
                wro.primary_item_id,
                wro.scheduled_start_date,
                wro.date_released,
                wro.date_completed,
                wro.date_closed,
                wro.schedule_close_date, -- Period Close Date
                wro.last_update_date,
                wro.inventory_item_id component_item_id
         from   wdj_comp wro
     union all
         -- Get the standard components
         select distinct
                comp.period_name,
                comp.organization_code,
                comp.organization_id,
                comp.primary_cost_method,
                comp.wip_entity_id,
                comp.project_id,
                comp.primary_item_id,
                comp.scheduled_start_date,
                comp.date_released,
                comp.date_completed,
                comp.date_closed,
                comp.schedule_close_date, -- Period Close Date
                comp.last_update_date,
                comp.component_item_id
         from   std_bom_comp comp
         where  not exists
                (select 'x'
                 from   wdj_comp
                 where  comp.component_item_id  = wdj_comp.inventory_item_id
                 and    comp.wip_entity_id      = wdj_comp.wip_entity_id
                )
         -- Revision for version 1.36
         -- Do not cost phantom components, not issued to WIP
         -- Do not get components if the prior level component was not a phantom,
         -- as phantom components are not issued to WIP.
         and    0 = case -- 0 = Not a phantom, 1 = Yes a phantom
                       -- Check level 1 components
                       when comp.level_num = 1 and comp.level_1_comp_is_phantom = 0 then 0
                       -- Check level 2 components
                       when comp.level_num = 2 and comp.level_1_comp_is_phantom = 1 and comp.level_2_comp_is_phantom = 0 then 0
                       -- Check level 3 components
                       when comp.level_num = 3 and comp.level_1_comp_is_phantom = 1 and comp.level_2_comp_is_phantom = 1 and comp.level_3_comp_is_phantom = 0 then 0
                       -- Check level 4 components
                       when comp.level_num = 4 and comp.level_1_comp_is_phantom = 1 and comp.level_2_comp_is_phantom = 1 and comp.level_3_comp_is_phantom = 1 and comp.level_4_comp_is_phantom = 0 then 0
                       else 1
                    end
         -- End revision for version 1.36
    ), -- wip_comp_list
-- End revision for version 1.35
-- Revision for version 1.19
-- Assembly cost type and lot information
-- Even in Release 12.2.9, lot info. is not stored in history (cst_elemental_cost_details), have to get it from cic
-- Revision for version 1.36, include assembly shrinkage rate, needed for standard component quantities
cic_assys as
        (select cic.organization_id,
                cic.inventory_item_id,
                cct.cost_type,
                cic.cost_type_id,
                -- Revision for version 1.36
                nvl(cic.shrinkage_rate,0) shrinkage_rate,
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
         from   cst_item_costs cic,
                cst_item_cost_details cicd,
                cst_cost_types cct,
                -- Limit to assemblies on WIP jobs
        -- Revision for version 1.34
                -- wdj_assys
                wdj wdj_assys
         where  cic.organization_id          = cicd.organization_id (+)
         and    cic.inventory_item_id        = cicd.inventory_item_id (+)
         and    cic.cost_type_id             = cicd.cost_type_id (+)
         and    cic.inventory_item_id        = wdj_assys.primary_item_id
         and    cic.organization_id          = wdj_assys.organization_id
         and    cct.cost_type_id             = cic.cost_type_id
         and    cct.cost_type                = decode(:p_cost_type,                                                -- p_cost_type
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
                -- Revision for version 1.36
                nvl(cic.shrinkage_rate,0),
                nvl(cic.lot_size,1)
         union all
         select cic.organization_id,
                cic.inventory_item_id,
                cct.cost_type,
                cic.cost_type_id,
                -- Revision for version 1.36
                nvl(cic.shrinkage_rate,0) shrinkage_rate,
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
         from   cst_item_costs cic,
                cst_item_cost_details cicd,
                cst_cost_types cct,
                -- Limit to assemblies on WIP jobs
                -- wdj
                -- wdj_assys
                wdj wdj_assys
         where  cic.cost_type_id             = cicd.cost_type_id (+)
         and    cic.inventory_item_id        = cicd.inventory_item_id (+)
         and    cic.organization_id          = cicd.organization_id (+)
         and    cic.inventory_item_id        = wdj_assys.primary_item_id
         and    cic.organization_id          = wdj_assys.organization_id
         and    cic.cost_type_id             = wdj_assys.primary_cost_method  -- this gets the Frozen Costs
         and    cct.cost_type_id            <> wdj_assys.primary_cost_method  -- this avoids getting the Frozen costs twice
         and    cct.cost_type                = decode(:p_cost_type,                                                -- p_cost_type
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
         and    not exists
                        (select 'x'
                         from   cst_item_costs cic2
                         where  cic2.organization_id   = cic.organization_id
                         and    cic2.inventory_item_id = cic.inventory_item_id
                         and    cic2.cost_type_id      = cct.cost_type_id
                        )
         group by
                cic.organization_id,
                cic.inventory_item_id,
                cct.cost_type,
                cic.cost_type_id,
                -- Revision for version 1.36
                nvl(cic.shrinkage_rate,0),
                nvl(cic.lot_size,1)
        ), -- cic_assys
-- Revision for version 1.35 and 1.37
-- Get the applicable cost update date from the standard cost history table for each WIP Job
max_cost_update as
        (select max(csc.cost_update_id) cost_update_id,
                csc.inventory_item_id,
                -- Revision for version 1.37
                wcl.assembly_or_component,
                csc.organization_id,
                wcl.wip_entity_id,
                -- Revision for version 1.37
                wcl.primary_cost_method,
                nvl(cic.lot_size,1) lot_size
                -- End revision for version 1.37
         from   cst_standard_costs csc,
                cst_item_costs cic,
                -- Revision for version 1.37
                -- Get both components and assemblies
                -- wip_comp_list wcl
                (select wcl2.component_item_id inventory_item_id,
                        'Component' assembly_or_component,
                        wcl2.wip_entity_id,
                        wcl2.organization_id,
                        wcl2.primary_cost_method,
                        wcl2.date_closed,
                        wcl2.schedule_close_date,
                        wcl2.last_update_date
                 from   wip_comp_list wcl2
                 union all
                 select wdj.primary_item_id inventory_item_id,
                        'Assembly' assembly_or_component,
                        wdj.wip_entity_id,
                        wdj.organization_id,
                        wdj.primary_cost_method,
                        wdj.date_closed,
                        wdj.schedule_close_date,
                        wdj.last_update_date
                 from   wdj
                ) wcl
         -- where  csc.inventory_item_id        = wcl.component_item_id
         where  csc.inventory_item_id        = wcl.inventory_item_id
         -- End revision for version 1.37
         and    csc.organization_id          = wcl.organization_id
         and    csc.inventory_item_id        = cic.inventory_item_id
         and    csc.organization_id          = cic.organization_id
         and    cic.cost_type_id             = wcl.primary_cost_method
         and    csc.standard_cost_revision_date <
                case
                   -- Open WIP jobs and costs changed before the end of the accounting period
                   when (wcl.date_closed is null and cic.last_update_date <  wcl.schedule_close_date + 1) then (cic.last_update_date + interval '1' second)
                   -- Open WIP jobs and costs changed after the end of the accounting period
                   when (wcl.date_closed is null and cic.last_update_date > wcl.schedule_close_date + 1) then (wcl.schedule_close_date + 1)
                   -- Closed WIP jobs and costs changed before the end of the accounting period and the WIP job was closed before the last cost update date
                   when (wcl.date_closed is not null and cic.last_update_date < wcl.schedule_close_date + 1 and wcl.date_closed < wcl.last_update_date) then (wcl.date_closed + interval '1' second)
                   -- Closed WIP jobs and costs changed before the end of the accounting period and the WIP job was closed after the last cost update date
                   when (wcl.date_closed is not null and cic.last_update_date < wcl.schedule_close_date + 1 and wcl.date_closed > cic.last_update_date) then (cic.last_update_date + interval '1' second)
                   -- Closed WIP jobs and costs changed after the end of the accounting period and the WIP job was closed before the end of the accounting period
                   when (wcl.date_closed is not null and cic.last_update_date >= wcl.schedule_close_date + 1 and wcl.date_closed < wcl.schedule_close_date + 1) then (wcl.date_closed + interval '1' second)
                   -- Closed WIP jobs and costs changed after the end of the accounting period and the WIP job was closed after the end of the accounting period
                   when (wcl.date_closed is not null and cic.last_update_date >= wcl.schedule_close_date + 1 and wcl.date_closed >= wcl.schedule_close_date + 1) then (wcl.schedule_close_date + 1)
                   else (wcl.schedule_close_date + 1)
                end
         group by
                csc.inventory_item_id,
                -- Revision for version 1.37
                wcl.assembly_or_component,
                csc.organization_id,
                wcl.wip_entity_id,
                -- Revision for version 1.37
                wcl.primary_cost_method,
                nvl(cic.lot_size,1)
                -- End revision for version 1.37
        ), -- max_cost_update
-- End revision for version 1.35, add in the WIP entity id to each inventory_item_id
-- Get the Component Cost Basis Type and Item Costs for each WIP Job
-- Revision for version 1.37, remove mtl_parameters
cic_comp as
        (select cic.inventory_item_id,
                cic.organization_id,
                -- Revision for version 1.35
                mcu.wip_entity_id,
                csc.standard_cost_revision_date,
                csc.cost_update_id,
                -- End revision for version 1.35
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
                --         when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then 0 -- material item basis type
                --         when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then 0 -- moh item basis type
                --         when cicd.level_type = 2 and cicd.basis_type = 2 then 0 -- previous level item basis type
                --         else 1
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
                nvl(csc.standard_cost,0) item_cost
         from   cst_item_cost_details cicd,
                cst_item_costs cic,
                cst_cost_types cct,
                -- Revision for version 1.35
                cst_standard_costs csc,
                max_cost_update mcu
                -- End revision for version 1.35
         -- Revision for version 1.37
         where  cic.organization_id          = mcu.organization_id
         and    cic.cost_type_id             = cct.cost_type_id
         and    cic.cost_type_id             = cicd.cost_type_id (+)
         and    cic.inventory_item_id        = cicd.inventory_item_id (+)
         and    cic.organization_id          = cicd.organization_id (+)
         -- Revision for version 1.35
         and    csc.cost_update_id           = mcu.cost_update_id
         and    csc.inventory_item_id        = mcu.inventory_item_id
         and    csc.organization_id          = mcu.organization_id
         -- Revision for version 1.37
         and    mcu.assembly_or_component    = 'Component'
         and    cic.inventory_item_id        = csc.inventory_item_id
         and    cic.organization_id          = csc.organization_id
         and    cct.cost_type                = decode(:p_cost_type,                                                -- p_cost_type
                                                        null, (select cct.cost_type
                                                               from   dual
                                                               where  cct.cost_type_id = mcu.primary_cost_method
                                                              ),
                                                        :p_cost_type
                                                     )
         group by
                cic.inventory_item_id,
                cic.organization_id,
                -- Revision for version 1.35
                mcu.wip_entity_id,
                csc.standard_cost_revision_date,
                csc.cost_update_id,
                -- End revision for version 1.35
                cic.last_update_date,
                cct.cost_type_id,
                cct.cost_type,
                -- Revision for version 1.28
                nvl(cic.lot_size,1),
                nvl(csc.standard_cost,0) -- Item Cost
         union all
         select cic.inventory_item_id,
                cic.organization_id,
                -- Revision for version 1.35
                wcl.wip_entity_id,
                cic.last_update_date standard_cost_revision_date,
                cic.cost_update_id,
                -- End revision for version 1.35
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
                --         when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then 0 -- material item basis type
                --         when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then 0 -- moh item basis type
                --         when cicd.level_type = 2 and cicd.basis_type = 2 then 0 -- previous level item basis type
                --         else 1
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
         from   cst_item_cost_details cicd,
                cst_item_costs cic,
                cst_cost_types cct,
                -- Revision for version 1.35
                wip_comp_list wcl
         where  cic.organization_id          = wcl.organization_id
         and    cic.cost_type_id             = wcl.primary_cost_method  -- this gets the Frozen Costs
         and    cic.cost_type_id             = cicd.cost_type_id (+)
         and    cic.inventory_item_id        = cicd.inventory_item_id (+)
         and    cic.organization_id          = cicd.organization_id (+)
         and    cct.cost_type_id            <> wcl.primary_cost_method  -- this avoids getting the Frozen costs twice
         -- Revision for version 1.35
         and    cic.inventory_item_id        = wcl.component_item_id (+)
         and    cic.organization_id          = wcl.organization_id (+)
         -- End revision for version 1.35
         and    cct.cost_type                = decode(:p_cost_type,                                                -- p_cost_type
                                                        null, (select cct.cost_type
                                                               from   dual
                                                               where  cct.cost_type_id = wcl.primary_cost_method
                                                              ),
                                                        :p_cost_type
                                                     )
         -- ======================================================
         -- Find all the Frozen costs not in the standard cost
         -- history, not in max_cost_update.  This is an old bug
         -- with the Standard Cost Update.
         -- ======================================================
         and    not exists
                        (select 'x'
                         from   max_cost_update mcu
                         where  mcu.organization_id   = cic.organization_id
                         and    mcu.inventory_item_id = cic.inventory_item_id
                         -- Revision for version 1.37
                         and    mcu.assembly_or_component    = 'Component'
                         group by
                                mcu.organization_id,
                                mcu.inventory_item_id
                        )
         group by
                cic.inventory_item_id,
                cic.organization_id,
                -- Revision for version 1.35
                wcl.wip_entity_id,
                cic.last_update_date, -- standard_cost_revision_date
                cic.cost_update_id,
                -- End revision for version 1.35
                cic.last_update_date,
                cct.cost_type_id,
                cct.cost_type,
                -- Revision for version 1.28
                nvl(cic.lot_size,1),
                nvl(cic.item_cost,0)
        ), -- cic_comp
-- Revision for version 1.37
-- Get the Assembly Item Costs for each WIP Job, for scrap amounts
cic_assy_cost as
        (select csc.inventory_item_id,
                csc.organization_id,
                mcu.wip_entity_id,
                csc.standard_cost_revision_date,
                csc.cost_update_id,
                cct.cost_type_id,
                cct.cost_type,
                mcu.lot_size,
                nvl(csc.standard_cost,0) item_cost
         from   cst_cost_types cct,
                cst_standard_costs csc,
                max_cost_update mcu
         where  csc.organization_id          = mcu.organization_id
         and    csc.cost_update_id           = mcu.cost_update_id
         and    csc.inventory_item_id        = mcu.inventory_item_id
         and    mcu.assembly_or_component    = 'Assembly'
         and    cct.cost_type                = decode(:p_cost_type,                                                -- p_cost_type
                                                        null, (select cct.cost_type
                                                               from   dual
                                                               where  cct.cost_type_id = mcu.primary_cost_method
                                                              ),
                                                        :p_cost_type
                                                     )
         group by
                csc.inventory_item_id,
                csc.organization_id,
                mcu.wip_entity_id,
                csc.standard_cost_revision_date,
                csc.cost_update_id,
                cct.cost_type_id,
                cct.cost_type,
                mcu.lot_size,
                nvl(csc.standard_cost,0) -- Item Cost
         union all
         select cic.inventory_item_id,
                cic.organization_id,
                wdj.wip_entity_id,
                cic.last_update_date standard_cost_revision_date,
                cic.cost_update_id,
                cct.cost_type_id,
                cct.cost_type,
                nvl(cic.lot_size,1) lot_size,
                nvl(cic.item_cost,0) item_cost
         from   cst_item_costs cic,
                cst_cost_types cct,
                wdj
         where  cic.organization_id          = wdj.organization_id
         and    cic.cost_type_id             = wdj.primary_cost_method  -- this gets the Frozen Costs
         and    cct.cost_type_id            <> wdj.primary_cost_method  -- this avoids getting the Frozen costs twice
         and    cic.inventory_item_id        = wdj.primary_item_id
         -- End revision for version 1.35
         and    cct.cost_type                = decode(:p_cost_type,                                                -- p_cost_type
                                                        null, (select cct.cost_type
                                                               from   dual
                                                               where  cct.cost_type_id = wdj.primary_cost_method
                                                              ),
                                                        :p_cost_type
                                                     )
         -- ======================================================
         -- Find all the Frozen costs not in the standard cost
         -- history, not in max_cost_update.  This is an old bug
         -- with the Standard Cost Update.
         -- ======================================================
         and    not exists
                        (select 'x'
                         from   max_cost_update mcu
                         where  mcu.organization_id          = cic.organization_id
                         and    mcu.inventory_item_id        = cic.inventory_item_id
                         -- Revision for version 1.37
                         and    mcu.assembly_or_component    = 'Assembly'
                         group by
                                mcu.organization_id,
                                mcu.inventory_item_id
                        )
         group by
                cic.inventory_item_id,
                cic.organization_id,
                wdj.wip_entity_id,
                cic.last_update_date, -- standard_cost_revision_date
                cic.cost_update_id,
                cic.last_update_date,
                cct.cost_type_id,
                cct.cost_type,
                nvl(cic.lot_size,1),
                nvl(cic.item_cost,0)
        ), -- cic_assy_cost
-- End revision for version 1.37
-- Get the Resource Cost Type, Cost Basis Type and Resource Rates
crc as
        (select crc.resource_id,
                crc.organization_id,
                crc.last_update_date,
                crc.cost_type_id,
                cct.cost_type,
                crc.resource_rate
         from   cst_resource_costs crc,
                cst_cost_types cct,
                mtl_parameters mp
         where  crc.cost_type_id             = decode(cct.cost_type_id,
                                                        2, mp.avg_rates_cost_type_id, -- Average Costing
                                                        5, mp.avg_rates_cost_type_id, -- FIFO Costing
                                                        6, mp.avg_rates_cost_type_id, -- LIFO Costing
                                                        cct.cost_type_id)
         and    crc.organization_id          = mp.organization_id
         and    cct.cost_type                = decode(:p_cost_type,
                                                        null, (select cct.cost_type
                                                                   from   dual
                                                                   where  cct.cost_type_id = mp.primary_cost_method
                                                              ),
                                                        :p_cost_type
                                                     )                                                               -- p_cost_type
         and    2=2                          -- p_org_code
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
         from   cst_resource_costs crc,
                cst_cost_types cct,
                mtl_parameters mp
         where  crc.organization_id          = mp.organization_id
         and    crc.cost_type_id             = decode(mp.primary_cost_method,
                                                        1, 1, -- Standard Costing, Frozen Cost Type
                                                        2, mp.avg_rates_cost_type_id, -- Average Costing
                                                        3, -99,                       -- Periodic Average
                                                        4, -99,                       -- Periodic Incremental LIFO
                                                        5, mp.avg_rates_cost_type_id, -- FIFO Costing
                                                        6, mp.avg_rates_cost_type_id  -- LIFO Costing
                                                     )
         -- Don't get the Frozen or AvgRates resource costs twice
         and    cct.cost_type_id            <> decode(mp.primary_cost_method,
                                                        1, 1, -- Standard Costing, Frozen Cost Type
                                                        2, mp.avg_rates_cost_type_id, -- Average Costing
                                                        3, -99,                       -- Periodic Average
                                                        4, -99,                       -- Periodic Incremental LIFO
                                                        5, mp.avg_rates_cost_type_id, -- FIFO Costing
                                                        6, mp.avg_rates_cost_type_id  -- LIFO Costing
                                                     )
         and    cct.cost_type                = decode(:p_cost_type,
                                                        null, (select cct.cost_type
                                                                   from   dual
                                                                   where  cct.cost_type_id = mp.primary_cost_method
                                                              ),
                                                        :p_cost_type
                                                     )                                                               -- p_cost_type
         and    2=2                          -- p_org_code
         -- ====================================
         -- Find all the resource costs not in the
         -- Pending or unimplemented cost type
         -- ====================================
         and    not exists
                        (select 'x'
                         from   cst_resource_costs crc2
                         where  crc2.organization_id   = crc.organization_id
                         and    crc2.resource_id       = crc.resource_id
                         and    crc2.cost_type_id      = case
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
        ), -- crc
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
         from   cst_department_overheads cdo,
                cst_cost_types cct,
                mtl_parameters mp
         where  cdo.cost_type_id             = decode(cct.cost_type_id,
                2, mp.avg_rates_cost_type_id, -- Average Costing
                5, mp.avg_rates_cost_type_id, -- FIFO Costing
                6, mp.avg_rates_cost_type_id, -- LIFO Costing
                cct.cost_type_id)
         and    cdo.organization_id          = mp.organization_id
         and    cct.cost_type                = decode(:p_cost_type,
                                                        null, (select cct.cost_type
                                                                   from   dual
                                                                   where  cct.cost_type_id = mp.primary_cost_method
                                                                  ),
                                                        :p_cost_type
                                                     )                                                               -- p_cost_type
         and    2=2                          -- p_org_code
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
         from   cst_department_overheads cdo,
                cst_cost_types cct,
                mtl_parameters mp
         where  cdo.organization_id          = mp.organization_id
         and    cdo.cost_type_id             = decode(mp.primary_cost_method,
                                                        1, 1, -- Standard Costing, Frozen Cost Type
                                                        2, mp.avg_rates_cost_type_id, -- Average Costing
                                                        3, -99,                       -- Periodic Average
                                                        4, -99,                       -- Periodic Incremental LIFO
                                                        5, mp.avg_rates_cost_type_id, -- FIFO Costing
                                                        6, mp.avg_rates_cost_type_id  -- LIFO Costing
                                                     )
         -- Don't get the Frozen or AvgRates resource costs twice
         and    cct.cost_type_id            <> decode(mp.primary_cost_method,
                                                        1, 1, -- Standard Costing, Frozen Cost Type
                                                        2, mp.avg_rates_cost_type_id, -- Average Costing
                                                        3, -99,                       -- Periodic Average
                                                        4, -99,                       -- Periodic Incremental LIFO
                                                        5, mp.avg_rates_cost_type_id, -- FIFO Costing
                                                        6, mp.avg_rates_cost_type_id  -- LIFO Costing
                                                     )
         and    cct.cost_type                = decode(:p_cost_type,
                                                        null, (select cct.cost_type
                                                                   from   dual
                                                                   where  cct.cost_type_id = mp.primary_cost_method
                                                                  ),
                                                        :p_cost_type
                                                     )                                                               -- p_cost_type
         and    2=2                          -- p_org_code
         -- ====================================
         -- Find all the resource costs not in the
         -- Pending or unimplemented cost type
         -- ====================================
         and    not exists
                        (select 'x'
                         from   cst_department_overheads cdo2
                         where  cdo2.organization_id   = cdo.organization_id
                         and    cdo2.overhead_id       = cdo.overhead_id
                         and    cdo2.cost_type_id      = case
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
        ), -- cdo
-- Get the resource overhead associations
cro as
        (select cro.overhead_id,
                cro.resource_id,
                cro.organization_id,
                cro.last_update_date,
                cro.cost_type_id,
                cct.cost_type
         from   cst_resource_overheads cro,
                cst_cost_types cct,
                mtl_parameters mp
         where  cro.cost_type_id             = decode(cct.cost_type_id,
                                                        2, mp.avg_rates_cost_type_id, -- Average Costing
                                                        5, mp.avg_rates_cost_type_id, -- FIFO Costing
                                                        6, mp.avg_rates_cost_type_id, -- LIFO Costing
                                                        cct.cost_type_id)
         and    cro.organization_id          = mp.organization_id
         and    cct.cost_type                = decode(:p_cost_type,
                                                        null, (select cct.cost_type
                                                                   from   dual
                                                                   where  cct.cost_type_id = mp.primary_cost_method
                                                              ),
                                                        :p_cost_type
                                                      )                                                              -- p_cost_type
         and    2=2                          -- p_org_code
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
         from   cst_resource_overheads cro,
                cst_cost_types cct,
                mtl_parameters mp
         where  cro.organization_id          = mp.organization_id
         and    cro.cost_type_id             = decode(mp.primary_cost_method,
                                                        1, 1, -- Standard Costing, Frozen Cost Type
                                                        2, mp.avg_rates_cost_type_id, -- Average Costing
                                                        3, -99,                       -- Periodic Average
                                                        4, -99,                       -- Periodic Incremental LIFO
                                                        5, mp.avg_rates_cost_type_id, -- FIFO Costing
                                                        6, mp.avg_rates_cost_type_id  -- LIFO Costing
                                                     )
         -- Don't get the Frozen or AvgRates resource costs twice
         and    cct.cost_type_id            <> decode(mp.primary_cost_method,
                                                        1, 1, -- Standard Costing, Frozen Cost Type
                                                        2, mp.avg_rates_cost_type_id, -- Average Costing
                                                        3, -99,                       -- Periodic Average
                                                        4, -99,                       -- Periodic Incremental LIFO
                                                        5, mp.avg_rates_cost_type_id, -- FIFO Costing
                                                        6, mp.avg_rates_cost_type_id  -- LIFO Costing
                                                      )
         and    cct.cost_type                = decode(:p_cost_type,
                                                        null, (select cct.cost_type
                                                                   from   dual
                                                                   where  cct.cost_type_id = mp.primary_cost_method
                                                              ),
                                                        :p_cost_type
                                                     )                                                              -- p_cost_type
         and    2=2                          -- p_org_code
         -- ====================================
         -- Find all the resource costs not in the
         -- Pending or unimplemented cost type
         -- ====================================
         and    not exists
                        (select 'x'
                         from   cst_resource_overheads cro2
                         where  cro2.organization_id   = cro.organization_id
                         and    cro2.overhead_id       = cro.overhead_id
                         and    cro2.resource_id       = cro.resource_id
                         and    cro2.cost_type_id      = case
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
        ), -- cro
-- End revision for version 1.19
-- Revision for version 1.36
-- Get the WIP resources and operations
wdj_res as
        (select worsum.report_type,
                worsum.period_name,
                worsum.organization_code,
                worsum.organization_id,
                worsum.primary_cost_method,
                worsum.account,
                worsum.class_code,
                worsum.class_type,
                worsum.wip_entity_id,
                worsum.project_id,
                worsum.status_type,
                worsum.primary_item_id,
                worsum.assembly_number,
                worsum.assy_description,
                worsum.assy_item_type,
                worsum.assy_item_status_code,
                worsum.assy_uom_code,
                worsum.planning_make_buy_code,
                worsum.std_lot_size,
                worsum.lot_number,
                worsum.creation_date,
                worsum.scheduled_start_date,
                worsum.date_released,
                worsum.date_completed,
                worsum.date_closed,
                worsum.schedule_close_date,
                worsum.last_update_date,
                worsum.start_quantity,
                worsum.quantity_completed,
                worsum.quantity_scrapped,
                worsum.fg_total_qty,
                worsum.purchase_item_id,
                worsum.department_id,
                worsum.operation_seq_num,
                worsum.resource_seq_num,
                worsum.resource_id,
                worsum.resource_code,
                worsum.description,
                worsum.basis_type,
                worsum.res_unit_of_measure,
                worsum.functional_currency_flag,
                worsum.cost_type,
                worsum.cost_element_id,
                worsum.resource_rate,
                worsum.usage_rate_or_amount,
                sum(worsum.total_req_quantity) total_req_quantity,
                sum(worsum.applied_resource_units) applied_resource_units,
                sum(worsum.wip_std_resource_value) wip_std_resource_value,
                sum(worsum.applied_resource_value) applied_resource_value,
                sum(0) std_usage_rate_or_amount,
                sum(0) std_total_req_quantity
         from   (select wdj.report_type,
                        wdj.period_name,
                        wdj.organization_code,
                        wdj.organization_id,
                        wdj.primary_cost_method,
                        decode(br.cost_element_id, 4, wdj.outside_processing_account, wdj.resource_account) account,
                        wdj.class_code,
                        wdj.class_type,
                        wdj.wip_entity_id,
                        wdj.project_id,
                        wdj.status_type,
                        wdj.primary_item_id,
                        wdj.assembly_number,
                        wdj.assy_description,
                        wdj.assy_item_type,
                        wdj.assy_item_status_code,
                        wdj.assy_uom_code,
                        wdj.planning_make_buy_code,
                        wdj.std_lot_size,
                        wdj.lot_number,
                        wdj.creation_date,
                        wdj.scheduled_start_date,
                        wdj.date_released,
                        wdj.date_completed,
                        wdj.date_closed,
                        wdj.schedule_close_date,
                        wdj.last_update_date,
                        wdj.start_quantity,
                        wdj.quantity_completed,
                        wdj.quantity_scrapped,
                        nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                        br.purchase_item_id,
                        wo.department_id,
                        wo.operation_seq_num,
                        wor.resource_seq_num,
                        br.resource_id,
                        br.resource_code,
                        br.description,
                        wor.basis_type,
                        br.unit_of_measure res_unit_of_measure,
                        br.functional_currency_flag,
                        crc.cost_type cost_type,
                        br.cost_element_id,
                        nvl(crc.resource_rate,0) resource_rate,
                        nvl(wor.usage_rate_or_amount,0) usage_rate_or_amount,
                        -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                        -- use the completions plus scrap quantities unless for lot-based jobs
                        nvl(round(case
                                     when wdj.status_type in (4,5,7,12,14,15) then
                                                decode(wor.basis_type,
                                                        2, nvl(wor.usage_rate_or_amount,0),                         -- Lot
                                                           nvl(wor.usage_rate_or_amount,0)                          -- Any other basis
                                                           * decode(wdj.class_type,
                                                                        5, nvl(wdj.quantity_completed, 0),
                                                                           nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                   )
                                                      )
                                     else
                                     -- else use the start quantity times the usage rate or amount
                                     decode(:p_use_completion_qtys,
                                                'Y', decode(wor.basis_type,
                                                             2, nvl(wor.usage_rate_or_amount,0),                         -- Lot
                                                                nvl(wor.usage_rate_or_amount,0)                          -- Any other basis
                                                                * decode(wdj.class_type,
                                                                         5, nvl(wdj.quantity_completed, 0),
                                                                            nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                        )
                                                           ),
                                                'N', decode(wor.basis_type,
                                                                 2, nvl(wor.usage_rate_or_amount,0),                         -- Lot
                                                                    nvl(wor.usage_rate_or_amount,0) * nvl(wdj.start_quantity, 0) -- Any other basis
                                                           )
                                           )
                                     end
                            ,6),0) total_req_quantity,
                        nvl(wor.applied_resource_units,0) applied_resource_units,
                        -- If the job status is "Complete" then use the completions plus
                        -- scrap quantities else use the planned required quantities; and
                        -- use the completions plus scrap quantities unless for lot-based jobs
                        -- Get the total required quantity
                        nvl(round(case when wdj.status_type in (4,5,7,12,14,15) then
                            decode(wor.basis_type,
                                    2, nvl(wor.usage_rate_or_amount,0),                         -- Lot
                                       nvl(wor.usage_rate_or_amount,0)                          -- Any other basis
                                            * decode(wdj.class_type,
                                                     5, nvl(wdj.quantity_completed, 0),
                                                        nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                    )
                                  ) else
                                    -- else use the start quantity times the usage rate or amount
                                    decode(:p_use_completion_qtys,
                                            'Y', decode(wor.basis_type,
                                                        2, nvl(wor.usage_rate_or_amount,0),                         -- Lot
                                                           nvl(wor.usage_rate_or_amount,0)                          -- Any other basis
                                                          * decode(wdj.class_type,
                                                                   5, nvl(wdj.quantity_completed, 0),
                                                                      nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                  )
                                                       ),
                                            'N', decode(wor.basis_type,
                                                        2, nvl(wor.usage_rate_or_amount,0),                         -- Lot
                                                           nvl(wor.usage_rate_or_amount,0) * nvl(wdj.start_quantity, 0)                         -- Any other basis
                                                       )
                                         ) end
                       ,6),0) -- total_req_quantity
                            -- And multiply by the AvgRate or Frozen standard costs
                            -- Revision for version 1.18
                            -- *  nvl(crc.resource_rate,0) std_resource_value,
                            * decode(br.functional_currency_flag, 1, 1, nvl(crc.resource_rate,0)) wip_std_resource_value,
                        nvl(wor.applied_resource_value,0) applied_resource_value,
                        0 std_usage_rate_or_amount,
                        0 std_total_req_quantity
                 from   wdj,
                        wip_operations wo,
                        wip_operation_resources wor,
                        bom_resources br,
                        crc
                 -- ===========================================
                 -- WIP_Job Entity, Routing, PO and Resource Cost Joins
                 -- ===========================================
                 where  wo.wip_entity_id          = wdj.wip_entity_id
                 and    wo.organization_id        = wdj.organization_id
                 and    wo.wip_entity_id          = wor.wip_entity_id
                 and    wo.organization_id        = wor.organization_id
                 and    wo.operation_seq_num      = wor.operation_seq_num
                 and    wor.resource_id           = br.resource_id
                 and    wor.organization_id       = br.organization_id
                 and    wor.resource_id           = crc.resource_id (+) 
                 and    wor.organization_id       = crc.organization_id (+)
                 and    8=8                       -- p_resource_code
                 union all
                 -- Subtract away the transactions which happened after the reported period
                 select wdj.report_type,
                        wdj.period_name,
                        wdj.organization_code,
                        wdj.organization_id,
                        wdj.primary_cost_method,
                        decode(br.cost_element_id, 4, wdj.outside_processing_account, wdj.resource_account) account,
                        wdj.class_code,
                        wdj.class_type,
                        wdj.wip_entity_id,
                        wdj.project_id,
                        wdj.status_type,
                        wdj.primary_item_id,
                        wdj.assembly_number,
                        wdj.assy_description,
                        wdj.assy_item_type,
                        wdj.assy_item_status_code,
                        wdj.assy_uom_code,
                        wdj.planning_make_buy_code,
                        wdj.std_lot_size,
                        wdj.lot_number,
                        wdj.creation_date,
                        wdj.scheduled_start_date,
                        wdj.date_released,
                        wdj.date_completed,
                        wdj.date_closed,
                        -- Revision for version 1.22
                        wdj.schedule_close_date,
                        wdj.last_update_date,
                        wdj.start_quantity,
                        wdj.quantity_completed,
                        wdj.quantity_scrapped,
                        nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                        br.purchase_item_id,
                        wt.department_id,
                        wt.operation_seq_num,
                        wt.resource_seq_num,
                        br.resource_id,
                        br.resource_code,
                        br.description,
                        wt.basis_type,
                        br.unit_of_measure res_unit_of_measure,
                        br.functional_currency_flag,
                        crc.cost_type cost_type,
                        br.cost_element_id,
                        nvl(crc.resource_rate,0) resource_rate,
                        nvl(wt.usage_rate_or_amount,0) usage_rate_or_amount,
                        0 total_req_quantity,
                        nvl(-1 * wt.primary_quantity,0) applied_resource_units,
                        0 wip_std_resource_value,
                        decode(wt.standard_rate_flag,
                                1, decode(br.functional_currency_flag, 1, 1, nvl(crc.resource_rate,0)),
                                2, nvl(wt.currency_actual_resource_rate, wt.actual_resource_rate) * nvl(currency_conversion_rate,1)
                              ) * wt.primary_quantity * -1 applied_resource_value,
                        0 std_usage_rate_or_amount,
                        0 std_total_req_quantity
                 from   wdj,
                        wip_transactions wt,
                        bom_resources br,
                        crc
                 where  wt.organization_id        = wdj.organization_id
                 and    wt.wip_entity_id          = wdj.wip_entity_id
                 and    wt.transaction_date      >= wdj.schedule_close_date + 1
                 and    br.resource_id            = wt.resource_id
                 and    br.cost_element_id in (3,4) -- Resource, Outside Processing
                 and    wt.resource_id            = crc.resource_id (+) 
                 and    wt.organization_id        = crc.organization_id (+)
                 and    8=8                       -- p_resource_code
                ) worsum
         group by
                worsum.report_type,
                worsum.period_name,
                worsum.organization_code,
                worsum.organization_id,
                worsum.primary_cost_method,
                worsum.account,
                worsum.class_code,
                worsum.class_type,
                worsum.wip_entity_id,
                worsum.project_id,
                worsum.status_type,
                worsum.primary_item_id,
                worsum.assembly_number,
                worsum.assy_description,
                worsum.assy_item_type,
                worsum.assy_item_status_code,
                worsum.assy_uom_code,
                worsum.planning_make_buy_code,
                worsum.std_lot_size,
                worsum.lot_number,
                worsum.creation_date,
                worsum.scheduled_start_date,
                worsum.date_released,
                worsum.date_completed,
                worsum.date_closed,
                worsum.schedule_close_date,
                worsum.last_update_date,
                worsum.start_quantity,
                worsum.quantity_completed,
                worsum.quantity_scrapped,
                worsum.fg_total_qty,
                worsum.purchase_item_id,
                worsum.department_id,
                worsum.operation_seq_num,
                worsum.resource_seq_num,
                worsum.resource_id,
                worsum.resource_code,
                worsum.description,
                worsum.basis_type,
                worsum.res_unit_of_measure,
                worsum.functional_currency_flag,
                worsum.cost_type,
                worsum.cost_element_id,
                worsum.resource_rate,
                worsum.usage_rate_or_amount
        ), -- wdj_res
res_sum as
        -- ========================================================
        -- Get the WIP Resource Information in a multi-part union
        -- which is then condensed into a summary data set
        -- ========================================================
        -- ========================================================
        -- Condense into a summary data set.
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
                res.assembly_number,
                res.assy_description,
                res.assy_item_type,
                res.assy_item_status_code,
                res.assy_uom_code,
                res.planning_make_buy_code,
                res.std_lot_size,
                res.lot_number,
                res.creation_date,
                res.scheduled_start_date,
                res.date_released,
                res.date_completed,
                res.date_closed,
                -- Revision for version 1.22
                res.schedule_close_date,
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
                res.operation_seq_num,
                null wip_supply_type,
                -- Revision for version 1.23
                -- 'N' phantom_parent,
                res.resource_seq_num,
                -- Revision for version 1.22
                res.resource_id,
                res.resource_code,
                res.description,
                res.basis_type,
                res.res_unit_of_measure,
                max(res.po_unit_price) po_unit_price,
                decode(res.basis_type, 2, 'Y', 'N') lot_basis_type,
                decode(res.basis_type, 2, res.resource_rate, 0) lot_basis_cost,
                decode(res.basis_type, 1, 'Y', 'N') item_basis_type,
                decode(res.basis_type, 1, res.resource_rate, 0) item_basis_cost,
                res.cost_type,
                -- Revision for version 1.18
                res.cost_element_id,
                res.resource_rate,
                sum(res.usage_rate_or_amount) usage_rate_or_amount,
                sum(res.total_req_quantity) total_req_quantity,
                sum(res.applied_resource_units) applied_resource_units,
                sum(res.wip_std_resource_value) wip_std_resource_value,
                sum(res.applied_resource_value) applied_resource_value,
                sum(res.std_usage_rate_or_amount) std_usage_rate_or_amount,
                sum(res.std_total_req_quantity) std_total_req_quantity
         from   -- ========================================================
                -- Section 'Applied OSP for WIP'
                -- First get the OSP resource information with the related
                -- PO number and unit price information
                -- Revision for version 1.36
                -- =======================================================
                (select 'Applied OSP for WIP' section,
                        wdj_res.report_type,
                        wdj_res.period_name,
                        wdj_res.organization_code,
                        wdj_res.organization_id,
                        wdj_res.primary_cost_method,
                        wdj_res.account,
                        wdj_res.class_code,
                        wdj_res.class_type,
                        wdj_res.wip_entity_id,
                        wdj_res.project_id,
                        wdj_res.status_type,
                        wdj_res.primary_item_id,
                        wdj_res.assembly_number,
                        wdj_res.assy_description,
                        wdj_res.assy_item_type,
                        wdj_res.assy_item_status_code,
                        wdj_res.assy_uom_code,
                        wdj_res.planning_make_buy_code,
                        wdj_res.std_lot_size,
                        wdj_res.lot_number,
                        wdj_res.creation_date,
                        wdj_res.scheduled_start_date,
                        wdj_res.date_released,
                        wdj_res.date_completed,
                        wdj_res.date_closed,
                        wdj_res.schedule_close_date,
                        wdj_res.last_update_date,
                        wdj_res.start_quantity,
                        wdj_res.quantity_completed,
                        wdj_res.quantity_scrapped,
                        wdj_res.fg_total_qty,
                        wdj_res.purchase_item_id,
                        poh.po_header_id,
                        pol.line_num,
                        pr.release_num,
                        wdj_res.department_id,
                        wdj_res.operation_seq_num,
                        wdj_res.resource_seq_num,
                        wdj_res.resource_id,
                        wdj_res.resource_code,
                        wdj_res.description,
                        wdj_res.basis_type,
                        wdj_res.res_unit_of_measure,
                        nvl(pll.price_override, pol.unit_price) po_unit_price,
                        wdj_res.cost_type,
                        wdj_res.cost_element_id,
                        wdj_res.resource_rate,
                        wdj_res.usage_rate_or_amount,
                        wdj_res.total_req_quantity,
                        wdj_res.applied_resource_units,
                        wdj_res.wip_std_resource_value,
                        wdj_res.applied_resource_value,
                        0 std_usage_rate_or_amount,
                        0 std_total_req_quantity
                 from   wdj_res,
                        po_headers_all poh,
                        po_lines_all pol,
                        po_line_locations_all pll,
                        po_releases_all pr,
                        po_distributions_all pod
                 -- ===========================================
                 -- WIP_Job Entity, Routing, PO and Resource Cost Joins
                 -- ===========================================
                 where  poh.po_header_id          = pod.po_header_id
                 and    pol.po_line_id            = pod.po_line_id
                 and    pll.line_location_id      = pod.line_location_id
                 and    pod.po_release_id         = pr.po_release_id (+)
                 and    wdj_res.wip_entity_id     = pod.wip_entity_id
                 and    wdj_res.resource_id       = pod.bom_resource_id
                 and    wdj_res.resource_seq_num  = pod.wip_resource_seq_num
                 and    wdj_res.operation_seq_num = pod.wip_operation_seq_num
                 and    wdj_res.organization_id   = pod.destination_organization_id
                 union all
                 -- =======================================================
                 -- Section 'Applied Non-OSP' for WIP for WIP
                 -- Now get the non-OSP resource information
                 -- Revision for version 1.36
                 -- =======================================================
                 select 'Applied Non-OSP for WIP' section,
                        wdj_res.report_type,
                        wdj_res.period_name,
                        wdj_res.organization_code,
                        wdj_res.organization_id,
                        wdj_res.primary_cost_method,
                        wdj_res.account,
                        wdj_res.class_code,
                        wdj_res.class_type,
                        wdj_res.wip_entity_id,
                        wdj_res.project_id,
                        wdj_res.status_type,
                        wdj_res.primary_item_id,
                        wdj_res.assembly_number,
                        wdj_res.assy_description,
                        wdj_res.assy_item_type,
                        wdj_res.assy_item_status_code,
                        wdj_res.assy_uom_code,
                        wdj_res.planning_make_buy_code,
                        wdj_res.std_lot_size,
                        wdj_res.lot_number,
                        wdj_res.creation_date,
                        wdj_res.scheduled_start_date,
                        wdj_res.date_released,
                        wdj_res.date_completed,
                        wdj_res.date_closed,
                        wdj_res.schedule_close_date,
                        wdj_res.last_update_date,
                        wdj_res.start_quantity,
                        wdj_res.quantity_completed,
                        wdj_res.quantity_scrapped,
                        wdj_res.fg_total_qty,
                        0 purchase_item_id,
                        0 po_header_id,
                        0 line_num,
                        0 release_num,
                        wdj_res.department_id,
                        wdj_res.operation_seq_num,
                        wdj_res.resource_seq_num,
                        wdj_res.resource_id,
                        wdj_res.resource_code,
                        wdj_res.description,
                        wdj_res.basis_type,
                        wdj_res.res_unit_of_measure,
                        0 po_unit_price,
                        wdj_res.cost_type,
                        wdj_res.cost_element_id,
                        wdj_res.resource_rate,
                        wdj_res.usage_rate_or_amount,
                        wdj_res.total_req_quantity,
                        wdj_res.applied_resource_units,
                        wdj_res.wip_std_resource_value,
                        wdj_res.applied_resource_value,
                        0 std_usage_rate_or_amount,
                        0 std_total_req_quantity
                 from   wdj_res
                 -- ===========================================
                 -- WIP_Job Entity, Routing and Resource Cost Joins
                 -- ===========================================
                 -- Only select non-OSP resources
                 where  wdj_res.purchase_item_id is null
                 and    wdj_res.cost_element_id   = 3 -- resource
                 union all
                 -- =======================================================
                 -- Section 'Non-Phtm Stds for Not Rolled Up'.  Get the
                 -- primary routing for resources which are not rolled up.
                 -- Get primary routing information for methods variances,
                 -- based on the routing, when rolled up Standard Costs do
                 -- not exist (such as for Average, FIFO, LIFO Costing) or
                 -- when sub-element details do not exist (for the Cost Type
                 -- definition, previous level rollup options not checked
                 -- for sub-elements).  Gets non-phantom resources.
                 -- =======================================================
                 select 'Non-Phtm Stds for Not Rolled Up' section,
                        wdj.report_type,
                        wdj.period_name,
                        wdj.organization_code,
                        wdj.organization_id,
                        wdj.primary_cost_method,
                        -- Revision for version 1.36
                        -- wdj.resource_account account,
                        decode(br.cost_element_id, 4, wdj.outside_processing_account, wdj.resource_account) account,
                        -- End revision for version 1.36
                        wdj.class_code,
                        wdj.class_type,
                        wdj.wip_entity_id,
                        wdj.project_id,
                        wdj.status_type,
                        wdj.primary_item_id,
                        wdj.assembly_number,
                        wdj.assy_description,
                        wdj.assy_item_type,
                        wdj.assy_item_status_code,
                        wdj.assy_uom_code,
                        wdj.planning_make_buy_code,
                        wdj.std_lot_size,
                        wdj.lot_number,
                        wdj.creation_date,
                        wdj.scheduled_start_date,
                        wdj.date_released,
                        wdj.date_completed,
                        wdj.date_closed,
                        -- Revision for version 1.22
                        wdj.schedule_close_date,
                        wdj.last_update_date,
                        wdj.start_quantity,
                        wdj.quantity_completed,
                        wdj.quantity_scrapped,
                        nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                        0 purchase_item_id,
                        0 po_header_id,
                        0 line_num,
                        0 release_num,
                        bos.department_id,
                        bos.operation_seq_num,
                        -- Revision for version 1.36
                        -- bor.operation_sequence_id,
                        bor.resource_seq_num,
                        -- Revision for version 1.22
                        br.resource_id,
                        br.resource_code,
                        br.description,
                        bor.basis_type,
                        br.unit_of_measure res_unit_of_measure,
                        0 po_unit_price,
                        crc.cost_type,
                        -- Revision for version 1.18
                        br.cost_element_id,
                        nvl(crc.resource_rate,0) resource_rate,
                        0 usage_rate_or_amount,
                        0 total_req_quantity,
                        0 applied_resource_units,
                        0 wip_std_resource_value,
                        0 applied_resource_value,        
                        nvl(bor.usage_rate_or_amount,0) std_usage_rate_or_amount,
                        -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                        -- use the completions plus scrap quantities unless for lot-based jobs
                        nvl(round(case when wdj.status_type in (4,5,7,12,14,15) then
                                decode(bor.basis_type,
                                        2, nvl(bor.usage_rate_or_amount,0),                                                     -- Lot
                                           nvl(bor.usage_rate_or_amount,0)                                                      -- Any other basis
                                                * decode(wdj.class_type,
                                                                5, nvl(wdj.quantity_completed, 0),
                                                                nvl(wdj.quantity_completed, 0) + 
                                                                decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                        )
                                      ) else
                                -- else use the start quantity times the usage rate or amount
                                decode(:p_use_completion_qtys,
                                        'Y', decode(bor.basis_type,
                                                        2, nvl(bor.usage_rate_or_amount,0),                                                     -- Lot
                                                                   nvl(bor.usage_rate_or_amount,0)                                                      -- Any other basis
                                                                        * decode(wdj.class_type,
                                                                                5, nvl(wdj.quantity_completed, 0),
                                                                                   nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                        )
                                                   ),
                                        'N', decode(bor.basis_type,
                                                        2, nvl(bor.usage_rate_or_amount,0),                                                     -- Lot
                                                           nvl(bor.usage_rate_or_amount,0) * nvl(wdj.start_quantity, 0)                         -- Any other basis
                                                   )
                                      ) end
                           ,6),0) std_total_req_quantity
                 from   wdj,
                        bom_operational_routings rout,
                        bom_operation_sequences bos,
                        bom_operation_resources bor,
                        bom_resources br,
                        -- Revision for version 1.36
                        cic_assys ca,
                        -- Revision for version 1.19
                        crc
                 -- ===========================================
                 -- WIP_Job Entity, Routing and Resource Cost Joins
                 -- ===========================================
                 where  rout.organization_id      = wdj.organization_id
                 and    rout.assembly_item_id     = wdj.primary_item_id
                 -- Revision for version 1.36
                 and    ca.inventory_item_id      = wdj.primary_item_id
                 and    ca.organization_id        = wdj.organization_id
                 -- Need to look for common routings
                 and    bos.routing_sequence_id   = nvl(rout.common_routing_sequence_id, rout.routing_sequence_id)
                 -- End revision for version 1.36
                 and    bor.operation_sequence_id = bos.operation_sequence_id
                 and    br.resource_id            = bor.resource_id
                 and    rout.routing_type         = 1   -- Manufacturing
                 and    rout.alternate_routing_designator is null
                 -- Revision for version 1.24 and 1.36
                 and    bos.effectivity_date     <  wdj.creation_date
                 -- Revision for version 1.36
                 -- and    nvl(bos.disable_date, sysdate+1) >  sysdate
                 and    nvl(bos.disable_date, wdj.creation_date+1) >  wdj.creation_date
                 -- Check and see if rolled up costs exist
                 -- Sections II.E and II.F handle rolled-up costs
                 and    ca.last_rollup_date is null
                 and    br.resource_id            = crc.resource_id (+) 
                 and    br.organization_id        = crc.organization_id (+) 
                 and    8=8                       -- p_resource_code
                 union all
                 -- Revision for version 1.34
                 -- =======================================================
                 -- Section 'Phtm Stds for Not Rolled Up'. Get the
                 -- primary routing for resources which are not rolled up.
                 -- Get primary phantom routing for methods variances,
                 -- based on the routing, when rolled up Standard Costs do
                 -- not exist (such as for Average, FIFO, LIFO Costing) or
                 -- when sub-element details do not exist (for the Cost Type
                 -- definition, previous level rollup options not checked
                 -- for sub-elements).  Gets phantom resources.
                 -- =======================================================
                 select 'Phtm Stds for Not Rolled Up' section,
                        comp.report_type,
                        comp.period_name,
                        comp.organization_code,
                        comp.organization_id,
                        comp.primary_cost_method,
                        -- Revision for version 1.36
                        -- comp.account,
                        decode(br.cost_element_id, 4, wdj.outside_processing_account, wdj.resource_account) account,
                        -- End revision for version 1.36
                        comp.class_code,
                        comp.class_type,
                        comp.wip_entity_id,
                        comp.project_id,
                        comp.status_type,
                        comp.primary_item_id,
                        comp.assembly_number,
                        comp.assy_description,
                        comp.assy_item_type,
                        comp.assy_item_status_code,
                        comp.assy_uom_code,
                        comp.planning_make_buy_code,
                        comp.std_lot_size,
                        comp.lot_number,
                        comp.creation_date,
                        comp.scheduled_start_date,
                        comp.date_released,
                        comp.date_completed,
                        comp.date_closed,
                        comp.schedule_close_date,
                        comp.last_update_date,
                        comp.start_quantity,
                        comp.quantity_completed,
                        comp.quantity_scrapped,
                        nvl(comp.quantity_completed,0) + nvl(comp.quantity_scrapped,0) fg_total_qty,
                        0 purchase_item_id,
                        0 po_header_id,
                        0 line_num,
                        0 release_num,
                        bos.department_id,
                        bos.operation_seq_num,
                        -- Revision for version 1.36
                        -- bor.operation_sequence_id,
                        -- Revision for version 1.34
                        -- For phantoms, need to reference the same WIP resource_seq_num
                        -- bor.resource_seq_num,
                        nvl((select wor.resource_seq_num 
                             from   wip_operation_resources wor
                             where  wor.organization_id        = comp.organization_id
                             and    wor.wip_entity_id          = comp.wip_entity_id
                             and    wor.operation_seq_num      = comp.operation_seq_num
                             and    wor.operation_seq_num      = bos.operation_seq_num
                             and    wor.resource_id            = bor.resource_id
                             and    wor.phantom_flag           = 1
                             and    wor.phantom_op_seq_num     = comp.operation_seq_num
                             and    comp.wip_supply_type       = 6 -- phantom
                             -- Prevent single-row subquery returns more than one row error
                             and    rownum                    = 1
                            ), bor.resource_seq_num) resource_seq_num,
                        -- End revision for version 1.34
                        -- Revision for version 1.22
                        br.resource_id,
                        br.resource_code,
                        br.description,
                        bor.basis_type,
                        br.unit_of_measure res_unit_of_measure,
                        0 po_unit_price,
                        crc.cost_type,
                        -- Revision for version 1.18
                        br.cost_element_id,
                        nvl(crc.resource_rate,0) resource_rate,
                        0 usage_rate_or_amount,
                        0 total_req_quantity,
                        0 applied_resource_units,
                        0 wip_std_resource_value,
                        0 applied_resource_value,        
                        nvl(bor.usage_rate_or_amount,0) std_usage_rate_or_amount,
                        -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                        -- use the completions plus scrap quantities unless for lot-based jobs
                        nvl(round(case when comp.status_type in (4,5,7,12,14,15) then
                                decode(bor.basis_type,
                                        2, nvl(bor.usage_rate_or_amount,0),                                                     -- Lot
                                           nvl(bor.usage_rate_or_amount,0)                                                      -- Any other basis
                                                * decode(comp.class_type,
                                                                5, nvl(comp.quantity_completed, 0),
                                                                nvl(comp.quantity_completed, 0) + 
                                                                decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0))
                                                        )
                                      ) else
                                -- else use the start quantity times the usage rate or amount
                                decode(:p_use_completion_qtys,
                                        'Y', decode(bor.basis_type,
                                                        2, nvl(bor.usage_rate_or_amount,0),                                                     -- Lot
                                                           nvl(bor.usage_rate_or_amount,0)                                                      -- Any other basis
                                                                * decode(comp.class_type,
                                                                                5, nvl(comp.quantity_completed, 0),
                                                                                   nvl(comp.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0))
                                                                        )
                                                   ),
                                        'N', decode(bor.basis_type,
                                                        2, nvl(bor.usage_rate_or_amount,0),                                                     -- Lot
                                                           nvl(bor.usage_rate_or_amount,0) * nvl(comp.start_quantity, 0)                         -- Any other basis
                                                   )
                                      ) end
                           ,6),0) std_total_req_quantity
                 from   std_bom_comp comp,-- get the phantom components
                        bom_operational_routings rout,
                        bom_operation_sequences bos,
                        bom_operation_resources bor,
                        bom_resources br,
                        bom_parameters bp,
                        -- Revision for version 1.36
                        cic_assys ca,
                        wdj,
                        crc
                 -- ===========================================
                 -- WIP_Job Entity, Routing and Resource Cost Joins
                 -- ===========================================
                 where  rout.organization_id      = comp.organization_id
                 and    rout.assembly_item_id     = comp.component_item_id
                 and    comp.wip_supply_type      = 6 -- phantom
                 and    bp.organization_id        = comp.organization_id
                 and    nvl(bp.use_phantom_routings,0) = 1
                 -- Revision for version 1.36
                 and    ca.inventory_item_id      = comp.primary_item_id
                 and    ca.organization_id        = comp.organization_id
                 -- Need to look for common routings
                 and    bos.routing_sequence_id   = nvl(rout.common_routing_sequence_id, rout.routing_sequence_id)
                 and    wdj.wip_entity_id         = comp.wip_entity_id
                 -- End revision for version 1.36
                 and    bor.operation_sequence_id = bos.operation_sequence_id
                 and    br.resource_id            = bor.resource_id
                 and    rout.routing_type         = 1   -- Manufacturing
                 and    rout.alternate_routing_designator is null
                 -- Revision for version 1.24 and 1.36
                 and    bos.effectivity_date     <  comp.creation_date
                 -- Revision for version 1.36
                 -- and    nvl(bos.disable_date, sysdate+1) >  sysdate
                 and    nvl(bos.disable_date, comp.creation_date+1) >  comp.creation_date
                 -- Check and see if rolled up costs exist
                 -- Sections II.E and II.F handle rolled-up costs
                 and    ca.last_rollup_date is null
                 and    br.resource_id            = crc.resource_id (+) 
                 and    br.organization_id        = crc.organization_id (+) 
                 and    8=8                       -- p_resource_code
                 union all
                 -- =======================================================
                 -- BEFORE
                 -- Section 'Stds Changed Before Period Close'.  Get the
                 -- primary routing for standards, for phtms and non-phtms.
                 -- Get primary routing information for methods variances
                 -- based on rolled up standard costs, for when the WIP job
                 -- is open and the std costs were changed before the period
                 -- schedule close date, or, the WIP job was closed after
                 -- the std costs were changed and the std costs were changed
                 -- before the period schedule close date.  In these cases, get
                 -- the routing costs from the item cost details (cicd).  This
                 -- query gets all rolled up components, including phantoms,
                 -- as this information is from the Cost Rollup.
                 -- =======================================================
                 select 'Stds Changed Before Period Close' section,
                        wdj.report_type,
                        wdj.period_name,
                        wdj.organization_code,
                        wdj.organization_id,
                        wdj.primary_cost_method,
                        -- Revision for version 1.36
                        -- wdj.resource_account account,
                        decode(br.cost_element_id, 4, wdj.outside_processing_account, wdj.resource_account) account,
                        -- End revision for version 1.36
                        wdj.class_code,
                        wdj.class_type,
                        wdj.wip_entity_id,
                        wdj.project_id,
                        wdj.status_type,
                        wdj.primary_item_id,
                        wdj.assembly_number,
                        wdj.assy_description,
                        wdj.assy_item_type,
                        wdj.assy_item_status_code,
                        wdj.assy_uom_code,
                        wdj.planning_make_buy_code,
                        wdj.std_lot_size,
                        wdj.lot_number,
                        wdj.creation_date,
                        wdj.scheduled_start_date,
                        wdj.date_released,
                        wdj.date_completed,
                        wdj.date_closed,
                        wdj.schedule_close_date,
                        wdj.last_update_date,
                        wdj.start_quantity,
                        wdj.quantity_completed,
                        wdj.quantity_scrapped,
                        nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                        0 purchase_item_id,
                        0 po_header_id,
                        0 line_num,
                        0 release_num,
                        cicd.department_id,
                        cicd.operation_seq_num,
                        -- Revision for version 1.36
                        -- cicd.operation_sequence_id,
                        cicd.resource_seq_num,
                        br.resource_id,
                        br.resource_code,
                        br.description,
                        cicd.basis_type,
                        br.unit_of_measure res_unit_of_measure,
                        0 po_unit_price,
                        crc.cost_type,
                        br.cost_element_id,
                        nvl(crc.resource_rate,0) resource_rate,
                        0 usage_rate_or_amount,
                        0 total_req_quantity,
                        0 applied_resource_units,
                        0 wip_std_resource_value,
                        0 applied_resource_value,
                        nvl(cicd.usage_rate_or_amount,0) std_usage_rate_or_amount,
                        -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                        -- use the completions plus scrap quantities unless for lot-based jobs
                        nvl(round(case when wdj.status_type in (4,5,7,12,14,15) then
                                decode(cicd.basis_type,
                                        2, nvl(cicd.usage_rate_or_amount,0),                                                     -- Lot
                                           nvl(cicd.usage_rate_or_amount,0)                                                      -- Any other basis
                                                * decode(wdj.class_type,
                                                                5, nvl(wdj.quantity_completed, 0),
                                                                nvl(wdj.quantity_completed, 0) + 
                                                                decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                        )
                                   ) else
                        -- else use the start quantity times the usage rate or amount
                        decode(:p_use_completion_qtys,
                                'Y', decode(cicd.basis_type,
                                                2, nvl(cicd.usage_rate_or_amount,0),                                                     -- Lot
                                                   nvl(cicd.usage_rate_or_amount,0)                                                      -- Any other basis
                                                        * decode(wdj.class_type,
                                                                        5, nvl(wdj.quantity_completed, 0),
                                                                           nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                )
                                           ),
                                'N', decode(cicd.basis_type,
                                                2, nvl(cicd.usage_rate_or_amount,0),                                                     -- Lot
                                                   nvl(cicd.usage_rate_or_amount,0) * nvl(wdj.start_quantity, 0)                         -- Any other basis
                                           )
                              ) end
                   ,6),0) std_total_req_quantity
                 from   wdj,
                        cst_item_cost_details cicd,
                        bom_resources br,
                        crc
                 -- ===========================================
                 -- WIP_Job Entity and Resource Cost Joins
                 -- ===========================================
                 where  cicd.organization_id      = wdj.organization_id
                 and    cicd.inventory_item_id    = wdj.primary_item_id
                 and    crc.cost_type_id          = cicd.cost_type_id
                 and    br.resource_id            = cicd.resource_id
                 -- Use cost resource details instead of routing details
                 and    cicd.rollup_source_type   = 3 -- Rolled up
                 and    cicd.cost_element_id      = 3 -- Resource
                 and    cicd.resource_id is not null
                 and    cicd.cost_type_id         = crc.cost_type_id
                 and    cicd.level_type           = 1 -- This Level
                 -- To avoid getting duplicate rows, caused by bad item cost conversions
                 and    cicd.item_cost           <> 0
                 -- Report either open WIP jobs and the std costs were changed before the
                 -- period schedule close date or jobs closed after the standard costs were
                 -- changed and the std costs were changed before the period schedule close date.
                 and    'Y' = case
                                 when (wdj.date_closed is null and cicd.last_update_date < wdj.schedule_close_date + 1) then 'Y'
                                 when (wdj.date_closed is not null and cicd.last_update_date < wdj.schedule_close_date + 1 and wdj.date_closed > cicd.last_update_date) then 'Y'
                                 else 'N'
                              end
                 and    br.resource_id            = crc.resource_id (+) 
                 and    br.organization_id        = crc.organization_id (+) 
                 and    8=8                       -- p_resource_code
                 union all
                 -- =======================================================
                 -- AFTER
                 -- Section 'Non-phtm Stds Changed after Period Close'.
                 -- Get the primary routing for standards, for non-phantoms.
                 -- Get primary routing information for methods variances
                 -- based on standard routing units/hours and costs, for
                 -- when the WIP job is open and the std costs were changed
                 -- after the period schedule close date, or, the std costs
                 -- were changed after the job was closed and the stds were
                 -- changed after the accounting period schedule close date.
                 -- In these cases get the routing costs from the standard
                 -- routing units or hours times the standard resource rates.
                 -- This query only gets non-phantom components.
                 -- =======================================================
                 select 'Non-phtm Stds Changed After Period Close' section,
                        wdj.report_type,
                        wdj.period_name,
                        wdj.organization_code,
                        wdj.organization_id,
                        wdj.primary_cost_method,
                        -- Revision for version 1.36
                        -- wdj.resource_account account,
                        decode(br.cost_element_id, 4, wdj.outside_processing_account, wdj.resource_account) account,
                        -- End revision for version 1.36
                        wdj.class_code,
                        wdj.class_type,
                        wdj.wip_entity_id,
                        wdj.project_id,
                        wdj.status_type,
                        wdj.primary_item_id,
                        wdj.assembly_number,
                        wdj.assy_description,
                        wdj.assy_item_type,
                        wdj.assy_item_status_code,
                        wdj.assy_uom_code,
                        wdj.planning_make_buy_code,
                        wdj.std_lot_size,
                        wdj.lot_number,
                        wdj.creation_date,
                        wdj.scheduled_start_date,
                        wdj.date_released,
                        wdj.date_completed,
                        wdj.date_closed,
                        wdj.schedule_close_date,
                        wdj.last_update_date,
                        wdj.start_quantity,
                        wdj.quantity_completed,
                        wdj.quantity_scrapped,
                        nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                        0 purchase_item_id,
                        0 po_header_id,
                        0 line_num,
                        0 release_num,
                        bos.department_id,
                        bos.operation_seq_num,
                        -- Revision for version 1.36
                        -- bor.operation_sequence_id,
                        bor.resource_seq_num,
                        br.resource_id,
                        br.resource_code,
                        br.description,
                        bor.basis_type,
                        br.unit_of_measure res_unit_of_measure,
                        0 po_unit_price,
                        crc.cost_type,
                        br.cost_element_id,
                        nvl(crc.resource_rate,0) resource_rate,
                        0 usage_rate_or_amount,
                        0 total_req_quantity,
                        0 applied_resource_units,
                        0 wip_std_resource_value,
                        0 applied_resource_value,
                        nvl(bor.usage_rate_or_amount,0) std_usage_rate_or_amount,
                        -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                        -- use the completions plus scrap quantities unless for lot-based jobs
                        nvl(round(case when wdj.status_type in (4,5,7,12,14,15) then
                                        decode(bor.basis_type,
                                                2, nvl(bor.usage_rate_or_amount,0),                                                     -- Lot
                                                   nvl(bor.usage_rate_or_amount,0)                                                      -- Any other basis
                                                        * decode(wdj.class_type,
                                                                        5, nvl(wdj.quantity_completed, 0),
                                                                        nvl(wdj.quantity_completed, 0) + 
                                                                        decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                )
                                           ) else
                                -- else use the start quantity times the usage rate or amount
                                decode(:p_use_completion_qtys,
                                        'Y', decode(bor.basis_type,
                                                        2, nvl(bor.usage_rate_or_amount,0),                                                     -- Lot
                                                           nvl(bor.usage_rate_or_amount,0)                                                      -- Any other basis
                                                                * decode(wdj.class_type,
                                                                                5, nvl(wdj.quantity_completed, 0),
                                                                                   nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                        )
                                                   ),
                                        'N', decode(bor.basis_type,
                                                        2, nvl(bor.usage_rate_or_amount,0),                                                     -- Lot
                                                           nvl(bor.usage_rate_or_amount,0) * nvl(wdj.start_quantity, 0)                         -- Any other basis
                                                   )
                                      ) end
                           ,6),0) std_total_req_quantity
                 from   wdj,
                        bom_operational_routings rout,
                        bom_operation_sequences bos,
                        bom_operation_resources bor,
                        bom_resources br,
                        -- Revision for version 1.36
                        cic_assys ca,
                        crc
                 -- ===========================================
                 -- WIP_Job Entity, Routing and Resource Cost Joins
                 -- ===========================================
                 where  rout.organization_id      = wdj.organization_id
                 and    rout.assembly_item_id     = wdj.primary_item_id
                 -- Need to look for common routings
                 and    bos.routing_sequence_id   = nvl(rout.common_routing_sequence_id, rout.routing_sequence_id)
                 and    bor.operation_sequence_id = bos.operation_sequence_id
                 and    br.resource_id            = bor.resource_id
                 and    rout.routing_type         = 1   -- Manufacturing
                 and    rout.alternate_routing_designator is null
                 -- Revision for version 1.24 and 1.36
                 and    bos.effectivity_date     <  wdj.creation_date
                 -- Revision for version 1.36
                 -- and    nvl(bos.disable_date, sysdate+1) >  sysdate
                 and    nvl(bos.disable_date, wdj.creation_date+1) >  wdj.creation_date
                 -- ===========================================
                 -- Verify WIP Job to Fetch
                 -- ===========================================
                 -- Revision for version 1.36
                 and    ca.inventory_item_id      = wdj.primary_item_id
                 and    ca.organization_id        = wdj.organization_id
                 -- Report either open WIP jobs and the std costs were changed after the period
                 -- schedule close date or standard costs were changed after the job was closed
                 -- and the stds were changed after the accounting period schedule close date.
                 and    'Y' = case
                                when (wdj.date_closed is null and ca.last_rollup_date > wdj.schedule_close_date + 1) then 'Y'
                                when (wdj.date_closed is not null and ca.last_rollup_date > wdj.schedule_close_date + 1) then 'Y'
                                else 'N'
                              end
                 -- End revision for version 1.36
                 and    br.resource_id            = crc.resource_id (+) 
                 and    br.organization_id        = crc.organization_id (+)
                 and    8=8                       -- p_resource_code
                 union all
                 -- =======================================================
                 -- AFTER
                 -- Section 'Phantom Stds Changed after Period Close'.
                 -- Get the primary routing for standards, for phantoms.
                 -- Section II.G. Primary Routing for Standard Costing
                 -- Get primary routing information for methods variances
                 -- based on standard routing units/hours and costs, for
                 -- when the WIP job is open and the std costs were changed
                 -- after the period schedule close date, or, the std costs
                 -- were changed after the job was closed and the stds were
                 -- changed after the accounting period schedule close date.
                 -- In these cases get the routing costs from the standard
                 -- routing units or hours times the standard resource rates.
                 -- This query only gets phantom components.
                 -- =======================================================
                 select 'Phantom Stds Changed after Period Close' section,
                        comp.report_type,
                        comp.period_name,
                        comp.organization_code,
                        comp.organization_id,
                        comp.primary_cost_method,
                        -- Revision for version 1.36
                        -- comp.account,
                        decode(br.cost_element_id, 4, wdj.outside_processing_account, wdj.resource_account) account,
                        -- End revision for version 1.36
                        comp.class_code,
                        comp.class_type,
                        comp.wip_entity_id,
                        comp.project_id,
                        comp.status_type,
                        comp.primary_item_id,
                        comp.assembly_number,
                        comp.assy_description,
                        comp.assy_item_type,
                        comp.assy_item_status_code,
                        comp.assy_uom_code,
                        comp.planning_make_buy_code,
                        comp.std_lot_size,
                        comp.lot_number,
                        comp.creation_date,
                        comp.scheduled_start_date,
                        comp.date_released,
                        comp.date_completed,
                        comp.date_closed,
                        comp.schedule_close_date,
                        comp.last_update_date,
                        comp.start_quantity,
                        comp.quantity_completed,
                        comp.quantity_scrapped,
                        nvl(comp.quantity_completed,0) + nvl(comp.quantity_scrapped,0) fg_total_qty,
                        0 purchase_item_id,
                        0 po_header_id,
                        0 line_num,
                        0 release_num,
                        bos.department_id,
                        bos.operation_seq_num,
                        -- Revision for version 1.36
                        -- bor.operation_sequence_id,
                        -- Revision for version 1.34
                        -- For phantoms, need to reference the same WIP resource_seq_num
                        -- bor.resource_seq_num,
                        nvl((select wor.resource_seq_num 
                             from   wip_operation_resources wor
                             where  wor.organization_id        = comp.organization_id
                             and    wor.wip_entity_id          = comp.wip_entity_id
                             and    wor.operation_seq_num      = comp.operation_seq_num
                             and    wor.operation_seq_num      = bos.operation_seq_num
                             and    wor.resource_id            = bor.resource_id
                             and    wor.phantom_flag           = 1
                             and    wor.phantom_op_seq_num     = comp.operation_seq_num
                             and    comp.wip_supply_type       = 6 -- phantom
                             -- Prevent single-row subquery returns more than one row error
                             and    rownum                    = 1
                            ), bor.resource_seq_num) resource_seq_num,
                        -- End revision for version 1.34
                        br.resource_id,
                        br.resource_code,
                        br.description,
                        bor.basis_type,
                        br.unit_of_measure res_unit_of_measure,
                        0 po_unit_price,
                        crc.cost_type,
                        br.cost_element_id,
                        nvl(crc.resource_rate,0) resource_rate,
                        0 usage_rate_or_amount,
                        0 total_req_quantity,
                        0 applied_resource_units,
                        0 wip_std_resource_value,
                        0 applied_resource_value,
                        nvl(bor.usage_rate_or_amount,0) std_usage_rate_or_amount,
                        -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                        -- use the completions plus scrap quantities unless for lot-based jobs
                        nvl(round(case when comp.status_type in (4,5,7,12,14,15) then
                                        decode(bor.basis_type,
                                                2, nvl(bor.usage_rate_or_amount,0),                                                     -- Lot
                                                   nvl(bor.usage_rate_or_amount,0)                                                      -- Any other basis
                                                        * decode(comp.class_type,
                                                                        5, nvl(comp.quantity_completed, 0),
                                                                        nvl(comp.quantity_completed, 0) + 
                                                                        decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0))
                                                                )
                                           ) else
                                -- else use the start quantity times the usage rate or amount
                                decode(:p_use_completion_qtys,
                                        'Y', decode(bor.basis_type,
                                                        2, nvl(bor.usage_rate_or_amount,0),                                                     -- Lot
                                                           nvl(bor.usage_rate_or_amount,0)                                                      -- Any other basis
                                                                * decode(comp.class_type,
                                                                                5, nvl(comp.quantity_completed, 0),
                                                                                   nvl(comp.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0))
                                                                        )
                                                   ),
                                        'N', decode(bor.basis_type,
                                                        2, nvl(bor.usage_rate_or_amount,0),                                                     -- Lot
                                                           nvl(bor.usage_rate_or_amount,0) * nvl(comp.start_quantity, 0)                         -- Any other basis
                                                   )
                                      ) end
                           ,6),0) std_total_req_quantity
                 from   std_bom_comp comp,
                        bom_operational_routings rout,
                        bom_operation_sequences bos,
                        bom_operation_resources bor,
                        bom_resources br,
                        bom_parameters bp,
                        -- Revision for version 1.36
                        cic_assys ca,
                        wdj,
                        crc
                 -- ===========================================
                 -- WIP_Job Entity, Routing and Resource Cost Joins
                 -- ===========================================
                 where  rout.organization_id      = comp.organization_id
                 and    rout.assembly_item_id     = comp.component_item_id
                 and    comp.wip_supply_type      = 6 -- phantom
                 and    bp.organization_id        = comp.organization_id
                 and    nvl(bp.use_phantom_routings,0) = 1
                 -- Need to look for common routings
                 and    bos.routing_sequence_id   = nvl(rout.common_routing_sequence_id, rout.routing_sequence_id)
                 and    bor.operation_sequence_id = bos.operation_sequence_id
                 and    br.resource_id            = bor.resource_id
                 and    rout.routing_type         = 1   -- Manufacturing
                 and    rout.alternate_routing_designator is null
                 -- Revision for version 1.24 and 1.36
                 and    bos.effectivity_date     <  comp.creation_date
                 -- Revision for version 1.36
                 -- and    nvl(bos.disable_date, sysdate+1) >  sysdate
                 and    nvl(bos.disable_date, comp.creation_date+1) >  comp.creation_date
                 and    wdj.wip_entity_id         = comp.wip_entity_id
                 -- End revision for version 1.36
                 -- ===========================================
                 -- Verify WIP Job to Fetch
                 -- ===========================================
                 -- Revision for version 1.36
                 and    ca.inventory_item_id      = comp.primary_item_id
                 and    ca.organization_id        = comp.organization_id
                 -- Report either open WIP jobs and the std costs were changed after the period
                 -- schedule close date or standard costs were changed after the job was closed
                 -- and the stds were changed after the accounting period schedule close date.
                 and    'Y' = case
                                 when (comp.date_closed is null and ca.last_rollup_date > comp.schedule_close_date + 1) then 'Y'
                                 when (comp.date_closed is not null and ca.last_rollup_date > comp.schedule_close_date + 1) then 'Y'
                                 else 'N'
                              end
                 -- End revision for version 1.36
                 and    br.resource_id            = crc.resource_id (+) 
                 and    br.organization_id        = crc.organization_id (+) 
                 and    8=8                       -- p_resource_code
                 -- End revision for version 1.34
                ) res
         group by
                res.report_type,
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
                res.assembly_number,
                res.assy_description,
                res.assy_item_type,
                res.assy_item_status_code,
                res.assy_uom_code,
                res.planning_make_buy_code,
                res.std_lot_size,
                res.lot_number,
                res.creation_date,
                res.scheduled_start_date,
                res.date_released,
                res.date_completed,
                res.date_closed,
                -- Revision for version 1.22
                res.schedule_close_date,
                res.last_update_date,
                res.start_quantity,
                res.quantity_completed,
                res.quantity_scrapped,
                res.fg_total_qty,
                res.department_id,
                res.operation_seq_num,
                null, -- wip_supply_type
                -- Revision for version 1.23
                -- 'N' phantom_parent,
                res.resource_seq_num,
                -- Revision for version 1.22
                res.resource_id,
                res.resource_code,
                res.description,
                res.basis_type,
                res.res_unit_of_measure,
                decode(res.basis_type, 2, 'Y', 'N'), -- lot_basis_type
                decode(res.basis_type, 2, res.resource_rate, 0), -- lot_basis_cost
                decode(res.basis_type, 1, 'Y', 'N'), -- item_basis_type
                decode(res.basis_type, 1, res.resource_rate, 0), -- item_basis_cost
                res.cost_type,
                -- Revision for version 1.18
                res.cost_element_id,
                res.resource_rate
        ), -- res_sum
-- End revision for version 1.36
-- Revision for version 1.30, 1.36 and 1.37
-- Get the list of primary and/or alternate BOMs, to enable joining to phantom subassemblies
bom_list as
         -- Get the alternate BOM if the alternate BOM is not null
        (select bsb.bill_sequence_id,
                bsb.assembly_item_id,
                bsb.organization_id,
                bsb.alternate_bom_designator
         from   bom_structures_b bsb,
                -- Revision for version 1.37
                (select wdj.primary_item_id,
                        wdj.organization_id
                 from   wdj
                 group by
                        wdj.primary_item_id,
                        wdj.organization_id
                ) wdj
                -- mtl_parameters mp
         -- where  bsb.organization_id             = mp.organization_id
         where  bsb.assembly_item_id            = wdj.primary_item_id
         and    bsb.organization_id             = wdj.organization_id 
         -- End revision for version 1.37
         and    bsb.assembly_type               = 1   -- Manufacturing
         and    bsb.common_assembly_item_id is null
         and    bsb.alternate_bom_designator    = '&p_alt_bom_designator'
         and    '&p_alt_bom_designator' is not null
         union all
         -- Get the primary BOM if the alternate BOM does not exist
         select bsb.bill_sequence_id,
                bsb.assembly_item_id,
                bsb.organization_id,
                bsb.alternate_bom_designator
         from   bom_structures_b bsb,
                -- Revision for version 1.37
                (select wdj.primary_item_id,
                        wdj.organization_id
                 from   wdj
                 group by
                        wdj.primary_item_id,
                        wdj.organization_id
                ) wdj
                -- mtl_parameters mp
         -- where  bsb.organization_id             = mp.organization_id
         where  bsb.assembly_item_id            = wdj.primary_item_id
         and    bsb.organization_id             = wdj.organization_id 
         -- End revision for version 1.37
         and    bsb.alternate_bom_designator is null -- get the primary BOM
         and    '&p_alt_bom_designator' is not null
         -- Check to see if the BOM structures exist as an alternate BOM
         and    not exists
                (
                 select 'x'
                 from   bom_structures_b bsb2
                 where  bsb2.assembly_item_id           = bsb.assembly_item_id
                 and    bsb2.organization_id            = bsb.organization_id
                 and    bsb.alternate_bom_designator    = '&p_alt_bom_designator'
                )
         union all
         -- Get the primary BOM if the alternate BOM is null
         select bsb.bill_sequence_id,
                bsb.assembly_item_id,
                bsb.organization_id,
                bsb.alternate_bom_designator
         from   bom_structures_b bsb,
                -- Revision for version 1.37
                (select wdj.primary_item_id,
                        wdj.organization_id
                 from   wdj
                 group by
                        wdj.primary_item_id,
                        wdj.organization_id
                ) wdj
                -- mtl_parameters mp
         -- where  bsb.organization_id             = mp.organization_id
         where  bsb.assembly_item_id            = wdj.primary_item_id
         and    bsb.organization_id             = wdj.organization_id 
         -- End revision for version 1.37
         and    bsb.alternate_bom_designator is null
         and    '&p_alt_bom_designator' is null
        ) -- bom_list
-- End revision for version 1.30, 1.36 and 1.37

-----------------main query starts here--------------

select  wip_sum.report_type Report_Type,
        -- Revision for version 1.19
        wip_sum.report_mode Report_Mode,
        nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        wip_sum.organization_code Org_Code,
        haou.name Organization_Name,
        wip_sum.period_name Period_Name,
&segment_columns
        wip_sum.class_code WIP_Class,
        ml1.meaning Class_Type,
        we.wip_entity_name WIP_Job,
        (select ppa.segment1
         from   pa_projects_all ppa
         where  ppa.project_id = wip_sum.project_id) Project_Number,
        ml2.meaning Job_Status,
        wip_sum.creation_date Creation_Date,
        wip_sum.scheduled_start_date Scheduled_Start_Date,
        wip_sum.date_released Date_Released,
        wip_sum.date_completed Date_Completed,
        wip_sum.date_closed Date_Closed,
        wip_sum.last_update_date Last_Update_Date,
        muomv.uom_code UOM_Code,
        wip_sum.std_lot_size Item_Std_Lot_Size,
        wip_sum.lot_size_cost_type  Lot_Size_Cost_Type,
        -- Revision for version 1.30, name change
        wip_sum.costing_lot_size Assembly_Cost_Lot_Size, 
        wip_sum.start_quantity Start_Quantity,
        wip_sum.quantity_completed Assembly_Quantity_Completed,
        wip_sum.quantity_scrapped Assembly_Quantity_Scrapped,
        wip_sum.fg_total_qty Total_Assembly_Quantity,
        wip_sum.assembly_number Assembly,
        wip_sum.assy_description Assembly_Description,
        fcl1.meaning Item_Type,
        misv.inventory_item_status_code Item_Status,
        ml3.meaning Make_Buy_Code,
&category_columns
        wip_sum.lot_number Lot_Number,
&p_det1_cols
        gl.currency_code Currency_Code,
&p_det2_cols
        wip_sum.matl_usage_var Material_Usage_Variance,
&p_det3_cols
        wip_sum.matl_config_var Configuration_Variance,
&p_det4_cols
        wip_sum.matl_lot_var Material_Lot_Variance, 
        wip_sum.total_matl_var Total_Material_Variance,
        wip_sum.res_efficiency_var Resource_Efficiency_Variance,
        wip_sum.res_methods_var Resource_Methods_Variance,
&p_det5_cols
        wip_sum.res_lot_var Resource_Lot_Variance,
        wip_sum.total_res_var Total_Resource_Variance,
        -- Revision for version 1.18
        wip_sum.osp_efficiency_var OSP_Efficiency_Variance,
        wip_sum.osp_methods_var OSP_Methods_Variance,
&p_det6_cols
        wip_sum.osp_lot_var OSP_Lot_Variance,
        wip_sum.total_osp_var Total_OSP_Variance,
&p_sum_cols
        fl2.meaning Rolled_Up,
        wip_sum.last_rollup_date Last_Cost_Rollup
        -- Revision for version 1.27 and 1.30
        -- Removed, not consistent for resources and overheads
        -- wip_sum.alternate_designator_code Alternate_BOM
from    mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv,
        -- Revision for version 1.38, to avoid category segment logic error
        mtl_system_items_vl msiv,
        wip_entities we,
        bom_departments bd,
        mfg_lookups ml1, -- WIP Class
        mfg_lookups ml2, -- WIP Status
        mfg_lookups ml3, -- Assy Planning Make Buy
        fnd_common_lookups fcl1, -- Assy Item Type
        fnd_lookups fl2, -- Rolled Up
        gl_code_combinations gcc,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2,
        gl_ledgers gl,
        -- ===========================================
        -- Condense the union all statements
        -- ===========================================
        (select wip.report_type,
                -- Revision for version 1.19
                ml8.meaning report_mode,
                wip.organization_code,
                wip.period_name,
                decode(ml8.lookup_code, 1, wip.account, null) account,
                wip.class_code,
                wip.class_type,
                wip.wip_entity_id,
                wip.project_id,
                wip.status_type,
                wip.creation_date,
                wip.scheduled_start_date,
                wip.date_released,
                wip.date_completed,
                wip.date_closed,
                wip.last_update_date,
                wip.organization_id,
                wip.std_lot_size,
                wip.lot_size_cost_type,
                wip.costing_lot_size,
                wip.start_quantity,
                wip.quantity_completed,
                wip.quantity_scrapped,
                wip.fg_total_qty,
                wip.primary_item_id,
                wip.assembly_number,
                wip.assy_description,
                wip.assy_item_type,
                wip.assy_item_status_code,
                wip.assy_uom_code,
                wip.planning_make_buy_code,
                wip.lot_number,
                -- Revision for version 1.23
                decode(ml8.lookup_code, 1, wip.report_sort, null) report_sort,
                decode(ml8.lookup_code, 1, wip.osp_item, null) OSP_item,
                decode(ml8.lookup_code, 1, wip.osp_description, null) osp_description,
                decode(ml8.lookup_code, 1, wip.po_number, null) po_number,
                decode(ml8.lookup_code, 1, wip.line_number, null) line_number,
                decode(ml8.lookup_code, 1, wip.po_release, null) po_release,
                decode(ml8.lookup_code, 1, wip.operation_seq_num, null) operation_seq_num,
                decode(ml8.lookup_code, 1, wip.item_or_res_op_seq, null) item_or_res_op_seq,
                decode(ml8.lookup_code, 1, wip.department_id, null) department_id,
                decode(ml8.lookup_code, 1, wip.item_or_resource, null) item_or_resource,
                -- Revision for version 1.30 Column name change for description to avoid SQL error
                decode(ml8.lookup_code, 1, wip.description, null) item_or_res_description,
                -- Revision for version 1.24 and 1.30
                decode(ml8.lookup_code, 1, wip.resource_uom_code, null) resource_uom_code,
                decode(ml8.lookup_code, 1, wip.overhead, null) overhead,
                -- Revision for version 1.23
                decode(ml8.lookup_code, 1, wip.ovhd_description, null) ovhd_description,
                -- Revision for version 1.23
                -- decode(ml8.lookup_code, 1, wip.phantom_parent, null) phantom_parent,
                decode(ml8.lookup_code, 1, wip.component_item_type, null) component_item_type,
                decode(ml8.lookup_code, 1, wip.component_status_code, null) component_status_code,
                decode(ml8.lookup_code, 1, wip.component_make_buy_code, null) component_make_buy_code,
                decode(ml8.lookup_code, 1, wip.wip_supply_type, null) wip_supply_type,
                decode(ml8.lookup_code, 1, wip.basis_type, null) basis_type,
                -- Revision for version 1.30
                decode(ml8.lookup_code, 1, wip.include_in_rollup, null) include_in_rollup,
                -- Revision for version 1.24 and 1.32
                decode(ml8.lookup_code, 1, wip.cost_type, null) cost_type, --  cost_type
                -- Revision for version 1.28
                decode(ml8.lookup_code, 1, wip.lot_basis_cost, null) lot_basis_cost,
                decode(ml8.lookup_code, 1, wip.comp_lot_size, null) component_cost_lot_size,
                -- End revision for version 1.28
                decode(ml8.lookup_code, 1, wip.item_or_resource_cost, null) item_or_resource_cost,
                -- Revision for version 1.23
                decode(ml8.lookup_code, 1, wip.rate_or_amount, null) overhead_rate,
                -- Revision for version 1.24
                decode(ml8.lookup_code, 1, wip.uom_code, null) uom_code,
                decode(ml8.lookup_code, 1, wip.quantity_per_assembly, null) quantity_per_assembly,
                decode(ml8.lookup_code, 1, wip.total_req_quantity, null) total_req_quantity,
                -- Revision for version 1.22
                decode(ml8.lookup_code, 1, wip.last_txn_date, null) last_txn_date,
                decode(ml8.lookup_code, 1, wip.quantity_issued, null) quantity_issued,
                decode(ml8.lookup_code, 1, round(wip.quantity_issued - wip.total_req_quantity,3), null) quantity_left_in_wip,
                -- Revision for version 1.23
                decode(ml8.lookup_code, 1, round(sum(wip.wip_std_comp_or_res_value),2), null) wip_std_comp_or_res_value,
                decode(ml8.lookup_code, 1, round(sum(wip.applied_comp_or_res_value),2), null) applied_comp_or_res_value,
                -- End revision for version 1.23
                round(sum(wip.matl_usage_var),2) matl_usage_var,
                decode(ml8.lookup_code, 1, wip.std_quantity_per_assembly, null) std_quantity_per_assembly,
                decode(ml8.lookup_code, 1, wip.std_total_req_quantity, null) std_total_req_quantity,
                round(sum(wip.matl_config_var),2) matl_config_var,
                -- Revision for version 1.30
                decode(ml8.lookup_code, 1, round(sum(wip.wip_matl_lot_charges_per_unit),5), null) wip_matl_lot_charges_per_unit, 
                decode(ml8.lookup_code, 1, round(sum(wip.std_matl_lot_charges_per_unit),5), null) std_matl_lot_charges_per_unit,
                -- End revision for version 1.30
                round(sum(wip.matl_lot_var),2) matl_lot_var, 
                round(sum(wip.matl_usage_var),2) + round(sum(wip.matl_config_var),2) + round(sum(wip.matl_lot_var),2) total_matl_var,
                round(sum(wip.res_efficiency_var),2) res_efficiency_var,
                round(sum(wip.res_methods_var),2) res_methods_var,
                -- Revision for version 1.30
                decode(ml8.lookup_code, 1, round(sum(wip.wip_res_lot_charges_per_unit),5), null) wip_res_lot_charges_per_unit, 
                decode(ml8.lookup_code, 1, round(sum(wip.std_res_lot_charges_per_unit),5), null) std_res_lot_charges_per_unit,
                -- End revision for version 1.30
                round(sum(wip.res_lot_var),2) res_lot_var, 
                round(sum(wip.res_efficiency_var),2) + round(sum(wip.res_methods_var),2) + round(sum(wip.res_lot_var),2) total_res_var,
                -- Revision for version 1.18
                round(sum(wip.osp_efficiency_var),2) osp_efficiency_var,
                round(sum(wip.osp_methods_var),2) osp_methods_var,
                -- Revision for version 1.30
                decode(ml8.lookup_code, 1, round(sum(wip.wip_osp_lot_charges_per_unit),5), null) wip_osp_lot_charges_per_unit, 
                decode(ml8.lookup_code, 1, round(sum(wip.std_osp_lot_charges_per_unit),5), null) std_osp_lot_charges_per_unit,
                -- End revision for version 1.30
                round(sum(wip.osp_lot_var),2) osp_lot_var, 
                round(sum(wip.osp_efficiency_var),2) + round(sum(wip.osp_methods_var),2) + round(sum(wip.osp_lot_var),2) total_osp_var,
                -- End revision for version 1.18
                -- Revision for version 1.36
                -- round(sum(wip.ovhd_efficiency_var),2) ovhd_efficiency_var,
                -- round(sum(wip.matl_usage_var),2) + round(sum(wip.matl_config_var),2) + round(sum(wip.matl_lot_var),2) +
                --         round(sum(wip.res_efficiency_var),2) + round(sum(wip.res_methods_var),2) + round(sum(wip.res_lot_var),2) + round(sum(wip.osp_efficiency_var),2) +
                --         round(sum(wip.osp_methods_var),2) + round(sum(wip.osp_lot_var),2) + round(sum(wip.ovhd_efficiency_var),2) total_explained_var,
                -- -- total_variance - total_explained_var = total_unexplained_var
                -- decode(ml8.lookup_code, 2, round(sum(wip.total_variance),2), null) - 
                -- decode(ml8.lookup_code, 2, round(sum(wip.matl_usage_var),2) + round(sum(wip.matl_config_var),2) + round(sum(wip.matl_lot_var),2) +
                --         round(sum(wip.res_efficiency_var),2) + round(sum(wip.res_methods_var),2) + round(sum(wip.res_lot_var),2) + round(sum(wip.osp_efficiency_var),2) +
                --         round(sum(wip.osp_methods_var),2) + round(sum(wip.osp_lot_var),2) + round(sum(wip.ovhd_efficiency_var),2), null) total_unexplained_var,
                decode(ml8.lookup_code, 2, round(sum(wip.ovhd_efficiency_var),2), null) ovhd_efficiency_var,
                -- Revision for version 1.37, add in scrap variance
                decode(ml8.lookup_code, 2, round(sum(wip.scrap_variance),2), null) scrap_variance,
                decode(ml8.lookup_code, 2, round(sum(wip.matl_usage_var),2) + round(sum(wip.matl_config_var),2) + round(sum(wip.matl_lot_var),2) +
                        round(sum(wip.res_efficiency_var),2) + round(sum(wip.res_methods_var),2) + round(sum(wip.res_lot_var),2) + round(sum(wip.osp_efficiency_var),2) +
                         -- Revision for version 1.37, add in scrap variance
                        round(sum(wip.osp_methods_var),2) + round(sum(wip.osp_lot_var),2) + round(sum(wip.ovhd_efficiency_var),2) + round(sum(wip.scrap_variance),2), null) total_explained_var,
                -- Revision for version 1.36
                decode(ml8.lookup_code, 2, decode(nvl(wip.rolled_up,'N'), 'Y', 0, round(sum(wip.material_variance),2) - (round(sum(wip.matl_usage_var),2) + round(sum(wip.matl_config_var),2) + round(sum(wip.matl_lot_var),2))), null) bor_matl_var,
                decode(ml8.lookup_code, 2, decode(nvl(wip.rolled_up,'N'), 'Y', 0, round(sum(wip.res_variance),2) - (round(sum(wip.res_efficiency_var),2) + round(sum(wip.res_methods_var),2) + round(sum(wip.res_lot_var),2))), null) bor_res_var,
                decode(ml8.lookup_code, 2, decode(nvl(wip.rolled_up,'N'), 'Y', 0, round(sum(wip.osp_variance),2) - (round(sum(wip.osp_efficiency_var),2) + round(sum(wip.osp_methods_var),2) + round(sum(wip.osp_lot_var),2))), null) bor_osp_var,
                decode(ml8.lookup_code, 2, decode(nvl(wip.rolled_up,'N'), 'Y', 0, round(sum(wip.ovhd_variance),2) - round(sum(wip.ovhd_efficiency_var),2)), null) bor_ovhd_var,
                decode(ml8.lookup_code, 2, decode(nvl(wip.rolled_up,'N'), 'Y', 0, round(sum(wip.total_variance),2) - 
                        (round(sum(wip.matl_usage_var),2) + round(sum(wip.matl_config_var),2) + round(sum(wip.matl_lot_var),2) +
                         round(sum(wip.res_efficiency_var),2) + round(sum(wip.res_methods_var),2) + round(sum(wip.res_lot_var),2) + round(sum(wip.osp_efficiency_var),2) +
                         -- Revision for version 1.37, add in scrap variance
                         round(sum(wip.osp_methods_var),2) + round(sum(wip.osp_lot_var),2) + round(sum(wip.ovhd_efficiency_var),2) + round(sum(wip.scrap_variance),2))), null) bor_total_var,
                -- End revision for version 1.36
                -- Revision for version 1.37, add in scrap variance
                -- Unexplained Material Variance = total_matl_var - material_variance
                decode(ml8.lookup_code, 2, round(sum(wip.material_variance),2) - (round(sum(wip.matl_usage_var),2) + round(sum(wip.matl_config_var),2) + round(sum(wip.matl_lot_var),2) + round(sum(wip.scrap_variance),2)), null) unexplained_matl_var,
                -- Unexplained Resource Variance = total_res_var - resource_variance
                decode(ml8.lookup_code, 2, round(sum(wip.res_variance),2) - (round(sum(wip.res_efficiency_var),2) + round(sum(wip.res_methods_var),2) + round(sum(wip.res_lot_var),2)), null) unexplained_res_var,
                -- Unexplained OSP Variance = total_osp_var - osp_variance
                decode(ml8.lookup_code, 2, round(sum(wip.osp_variance),2) - (round(sum(wip.osp_efficiency_var),2) + round(sum(wip.osp_methods_var),2) + round(sum(wip.osp_lot_var),2)), null) unexplained_osp_var,
                -- Unexplained Overhead Variance = ovhd_efficiency_var - ovhd_variance
                decode(ml8.lookup_code, 2, round(sum(wip.ovhd_variance),2) - round(sum(wip.ovhd_efficiency_var),2), null) unexplained_ovhd_var,
                decode(ml8.lookup_code, 2, round(sum(wip.total_variance),2) -
                -- Revision for version 1.36 (put sum of variances in parenthesis)
                        (round(sum(wip.matl_usage_var),2) + round(sum(wip.matl_config_var),2) + round(sum(wip.matl_lot_var),2) +
                         round(sum(wip.res_efficiency_var),2) + round(sum(wip.res_methods_var),2) + round(sum(wip.res_lot_var),2) + round(sum(wip.osp_efficiency_var),2) +
                         -- Revision for version 1.37, add in scrap variance
                         round(sum(wip.osp_methods_var),2) + round(sum(wip.osp_lot_var),2) + round(sum(wip.ovhd_efficiency_var),2) + round(sum(wip.scrap_variance),2)), null) total_unexplained_var,
                decode(ml8.lookup_code, 2, round(sum(wip.material_variance),2), null)  material_variance,
                decode(ml8.lookup_code, 2, round(sum(wip.res_variance),2), null)       res_variance,
                decode(ml8.lookup_code, 2, round(sum(wip.osp_variance),2), null)       osp_variance,
                decode(ml8.lookup_code, 2, round(sum(wip.ovhd_variance),2), null)      ovhd_variance,
                decode(ml8.lookup_code, 2, round(sum(wip.total_variance),2), null)     total_variance,
                decode(ml8.lookup_code, 2, round(sum(wip.wip_costs_in),2), null)       wip_costs_in,
                decode(ml8.lookup_code, 2, round(sum(wip.wip_costs_out),2), null)      wip_costs_out,
                decode(ml8.lookup_code, 2, round(sum(wip.wip_relief),2), null)         wip_relief,
                decode(ml8.lookup_code, 2, round(sum(wip.wip_value),2), null)          wip_value,
                -- Revision for version 1.27
                -- wip.rolled_up,
                nvl(wip.rolled_up,'N') rolled_up,
                wip.last_rollup_date
                -- Revision for version 1.27 and 1.30
                -- Removed, not consistent for resources and overheads
                -- wip.alternate_designator_code
                -- End revision for version 1.30
                -- Revision for version 1.19
         from    mfg_lookups ml8, -- cst_rpt_detail_option
                 -- ===========================================
                 -- Section I - Material Variances
                 -- Inline table select for WIP Matl Usage 
                 -- and configuration variances.
                 -- ===========================================
                (select mtl_sum.report_type,
                        mtl_sum.organization_code,
                        mtl_sum.period_name,
                        mtl_sum.account,
                        mtl_sum.class_code,
                        mtl_sum.class_type,
                        mtl_sum.wip_entity_id,
                        mtl_sum.project_id,
                        mtl_sum.status_type,
                        mtl_sum.primary_item_id,
                        mtl_sum.assembly_number,
                        mtl_sum.assy_description,
                        mtl_sum.assy_item_type,
                        mtl_sum.assy_item_status_code,
                        mtl_sum.assy_uom_code,
                        mtl_sum.planning_make_buy_code,
                        mtl_sum.lot_number,
                        -- Revision for version 1.23
                        1  report_sort,
                        mtl_sum.creation_date,
                        mtl_sum.scheduled_start_date,
                        mtl_sum.date_released,
                        mtl_sum.date_completed,
                        mtl_sum.date_closed,
                        mtl_sum.last_update_date,
                        mtl_sum.std_lot_size,
                        cic_assys.cost_type lot_size_cost_type,
                        nvl(cic_assys.lot_size, 1) costing_lot_size, 
                        mtl_sum.start_quantity,
                        mtl_sum.quantity_completed,
                        mtl_sum.quantity_scrapped,
                        mtl_sum.fg_total_qty,
                        mtl_sum.inventory_item_id,
                        mtl_sum.organization_id,
                        null osp_item,
                        null osp_description,
                        null po_number,
                        null line_number,
                        null po_release,
                        mtl_sum.department_id,
                        mtl_sum.operation_seq_num,
                        mtl_sum.item_num item_or_res_op_seq,
                        -- Revision for version 1.24
                        -- msiv2.concatenated_segments item_or_resource,
                        -- msiv2.description,
                        mtl_sum.component_number item_or_resource,
                        mtl_sum.component_description description,
                        null resource_uom_code,
                        -- End revision for version 1.24
                        null overhead,
                        null ovhd_description,
                        null ovhd_basis_type,
                        null ovhd_unit_of_measure,
                        -- Revision for version 1.23
                        -- fl.meaning phantom_parent,
                        fcl2.meaning component_item_type,
                        misv2.inventory_item_status_code component_status_code,
                        ml4.meaning component_make_buy_code,
                        ml5.meaning wip_supply_type,
                        ml6.meaning basis_type,
                        -- Revision for version 1.30
                        ml7.meaning include_in_rollup,
                        mtl_sum.lot_basis_type,
                        mtl_sum.comp_lot_size,
                        mtl_sum.lot_basis_cost,
                        -- End revision for version 1.30
                        mtl_sum.item_basis_type,
                        mtl_sum.item_basis_cost,
                        mtl_sum.cost_type,
                        nvl(mtl_sum.item_cost,0) item_or_resource_cost,
                        -- Revision for version 1.23
                        0 rate_or_amount,
                        -- Revision for version 1.28
                        muomv2.uom_code,
                        mtl_sum.quantity_per_assembly,
                        mtl_sum.total_req_quantity,
                        -- Revision for version 1.22 and 1.30, push txn query down to mtl2
                        mtl_sum.last_txn_date,
                        mtl_sum.quantity_issued,
                        mtl_sum.wip_std_component_value wip_std_comp_or_res_value,
                        mtl_sum.applied_component_value applied_comp_or_res_value,
                        mtl_sum.std_quantity_per_assembly,
                        mtl_sum.std_total_req_quantity,
                        0 wip_std_overhead_value,
                        -- To match the Oracle Discrete Job Value Report, turn off material usage 
                        -- variances when there are no completions and no applied or charged quantities.
                        case
                           when mtl_sum.fg_total_qty = 0 and round(mtl_sum.applied_component_value,2) = 0 then 0
                           else round(mtl_sum.applied_component_value - mtl_sum.wip_std_component_value,2)
                        end matl_usage_var,
                        -- =============================
                        -- Configuration_Variance
                        -- =============================
                        case
                           when nvl(mtl_sum.item_basis_type, 'N') = 'N' then 0
                           when mtl_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
                           when cic_assys.rolled_up = 'N' then 0
                           when (nvl(mtl_sum.std_total_req_quantity,0) + nvl(mtl_sum.total_req_quantity,0)) = 0 then 0
                           when nvl(mtl_sum.std_total_req_quantity,0) - nvl(mtl_sum.total_req_quantity,0) = 0 then 0
                           -- Only have configuration variances with Standard Costing (but still want to show qty configuration variances)
                           when mtl_sum.primary_cost_method <> 1 then 0
                           -- When the WIP BOM has a phantom component but the WIP supply type is not a phantom the report
                           -- compares the material usage and configuration variances for the children of the parent phantom.
                           -- The code section for WIP component requirements explodes the phantom component which enables the
                           -- comparison to the standard BOM and subsequent netting for material usage and configuration variances.
                           -- Revision for version 1.23
                           -- when mtl_sum.component_item_type = 'PH' and mtl_sum.wip_supply_type <> 6 then 0
                           -- When no completions, no applied value and no activity as there are no configuration variances
                           when mtl_sum.fg_total_qty = 0 and round(mtl_sum.applied_component_value,2) = 0 then 0
                           else round((nvl(mtl_sum.total_req_quantity,0) - nvl(mtl_sum.std_total_req_quantity,0)) * mtl_sum.item_basis_cost,2)
                        end  matl_config_var,
                        -- Revision for version 1.30
                        -- =============================
                        -- WIP Lot Charges Per Unit
                        -- =============================
                        --   when primary_cost_method is not Frozen (1) then zero
                        --   when the item is not lot-based then zero
                        --   when the item basis is null then zero
                        nvl(case
                           -- Revision for version 1.28
                           -- when nvl(mtl_sum.lot_basis_type, 'N') = 'N' then 0
                           when nvl(mtl_sum.item_basis_type, 'Y') = 'Y' then 0
                           -- End revision for version 1.28
                           when mtl_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
                           when cic_assys.rolled_up = 'N' then 0
                           when mtl_sum.quantity_per_assembly = 0 then 0
                           -- Revision for version 1.10, replace decodes with mtl_sum.status_type in (4,5,7,12,14,15) 
                           -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                           when mtl_sum.status_type in (4,5,7,12,14,15)
                                then round(mtl_sum.quantity_per_assembly * mtl_sum.lot_basis_cost /
                                          (decode(mtl_sum.quantity_completed, 0, 1, mtl_sum.quantity_completed) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(mtl_sum.quantity_scrapped, 0))),5)
                           when mtl_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'Y' -- Released and use completion quantities
                                then round(mtl_sum.quantity_per_assembly * mtl_sum.lot_basis_cost /
                                          (decode(mtl_sum.quantity_completed, 0, 1, mtl_sum.quantity_completed) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(mtl_sum.quantity_scrapped, 0))),5)
                           when mtl_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'N' -- Released but do not use completion quantities
                                -- Revision for version 1.33
                                -- then round(mtl_sum.quantity_per_assembly * mtl_sum.lot_basis_cost / mtl_sum.start_quantity,5)
                           -- else round(mtl_sum.quantity_per_assembly * mtl_sum.lot_basis_cost / mtl_sum.start_quantity,5)
                                then round(mtl_sum.quantity_per_assembly * mtl_sum.lot_basis_cost / decode(mtl_sum.start_quantity, 0, 1, mtl_sum.start_quantity),5)
                           else round(mtl_sum.quantity_per_assembly * mtl_sum.lot_basis_cost / decode(mtl_sum.start_quantity, 0, 1, mtl_sum.start_quantity),5)
                           -- End revision for version 1.8
                           -- End revision for version 1.33
                        end,0) wip_matl_lot_charges_per_unit,
                        -- =============================
                        -- Standard Lot Charges Per Unit
                        -- =============================
                        nvl(case
                           when nvl(mtl_sum.lot_basis_type, 'N') = 'N' then 0
                           when mtl_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
                           when cic_assys.rolled_up = 'N' then 0
                           when mtl_sum.std_quantity_per_assembly = 0 then 0
                           -- Revision for version 1.28, use the component lot size
                           else round(mtl_sum.std_quantity_per_assembly * mtl_sum.lot_basis_cost / mtl_sum.comp_lot_size,5)
                        end,0) std_matl_lot_charges_per_unit,
                        -- End revision for version 1.30
                        -- =============================
                        -- Lot_Variance
                        -- =============================
                        -- WIP Lot Charges per unit - Std Lot Charges per unit = Lot_Size_Variance
                        --   when primary_cost_method is not Frozen (1) then zero
                        --   when standard lot size is null then zero
                        --   when mtl_sum.basis_type is null then zero
                        --   when mtl_sum.basis_type <> lot (2) then zero
                        nvl(case
                           when mtl_sum.primary_cost_method <> 1 then 0
                           -- Revision for version 1.28
                           -- when nvl(mtl_sum.lot_basis_type, 'N') = 'N' then 0
                           when nvl(mtl_sum.item_basis_type, 'Y') = 'Y' then 0
                           -- End revision for version 1.28
                           when mtl_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
                           when cic_assys.rolled_up = 'N' then 0
                           when mtl_sum.std_quantity_per_assembly = 0 then 0
                           -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                           when mtl_sum.status_type in (4,5,7,12,14,15)
                                then round((mtl_sum.quantity_per_assembly * mtl_sum.lot_basis_cost) - mtl_sum.std_quantity_per_assembly * mtl_sum.lot_basis_cost / nvl(cic_assys.lot_size,1) * 
                                        (nvl(mtl_sum.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(mtl_sum.quantity_scrapped, 0))),2)
                           when mtl_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'Y' -- Released but has completion quantities
                                then round((mtl_sum.quantity_per_assembly * mtl_sum.lot_basis_cost) - mtl_sum.std_quantity_per_assembly * mtl_sum.lot_basis_cost / nvl(cic_assys.lot_size,1) * 
                                        (nvl(mtl_sum.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(mtl_sum.quantity_scrapped, 0))),2)
                           when mtl_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'N' -- Released but has no completion quantities
                                -- Revision for version 1.33
                                -- then round((mtl_sum.quantity_per_assembly * mtl_sum.lot_basis_cost) - (mtl_sum.std_quantity_per_assembly * mtl_sum.lot_basis_cost / nvl(cic_assys.lot_size,1) * mtl_sum.start_quantity),2)
                           -- else round((mtl_sum.quantity_per_assembly * mtl_sum.lot_basis_cost) - (mtl_sum.std_quantity_per_assembly * mtl_sum.lot_basis_cost / nvl(cic_assys.lot_size,1) * mtl_sum.start_quantity),2)
                                then round((mtl_sum.quantity_per_assembly * mtl_sum.lot_basis_cost) - (mtl_sum.std_quantity_per_assembly * mtl_sum.lot_basis_cost / nvl(cic_assys.lot_size,1) * decode(mtl_sum.start_quantity, 0, 1, mtl_sum.start_quantity)),2)
                           else round((mtl_sum.quantity_per_assembly * mtl_sum.lot_basis_cost) - (mtl_sum.std_quantity_per_assembly * mtl_sum.lot_basis_cost / nvl(cic_assys.lot_size,1) * decode(mtl_sum.start_quantity, 0, 1, mtl_sum.start_quantity)),2)
                           -- End revision for version 1.33
                        end,0) matl_lot_var,
                        0 res_efficiency_var,
                        0 res_methods_var,
                        -- Revision for version 1.30
                        0 wip_res_lot_charges_per_unit,
                        0 std_res_lot_charges_per_unit,
                        -- End revision for version 1.30
                        0 res_lot_var,
                        -- Revision for version 1.18
                        0 osp_efficiency_var,
                        0 osp_methods_var,
                        -- Revision for version 1.30
                        0 wip_osp_lot_charges_per_unit,
                        0 std_osp_lot_charges_per_unit,
                        -- End revision for version 1.30
                        0 osp_lot_var, 
                        -- End revision for version 1.18
                        0 ovhd_efficiency_var,
                        -- Revision for version 1.37
                        0 scrap_variance,
                        0 material_variance,
                        0 res_variance,
                        0 osp_variance,
                        0 ovhd_variance,
                        0 total_variance,
                        0 wip_costs_in,
                        0 wip_costs_out,
                        0 wip_relief,
                        0 wip_value,
                        cic_assys.rolled_up,
                        cic_assys.last_rollup_date --,
                        -- Revision for version 1.27 and 1.30
                        -- Removed, not consistent for resources and overheads
                        -- mtl_sum.alternate_designator_code
                 -- Revision for version 1.24
                 -- from   mtl_system_items_vl msiv2,
                 from   mtl_item_status_vl misv2,
                 -- End revision for version 1.24
                        mtl_units_of_measure_vl muomv2,
                        -- Revision for version 1.23
                        -- fnd_lookups fl,   -- phantom_parent
                        fnd_common_lookups fcl2, -- component_item_type
                        mfg_lookups ml4, -- component_make_buy_code
                        mfg_lookups ml5, -- wip_supply_type
                        mfg_lookups ml6, -- component_basis_type
                        -- Revision for version 1.30
                        mfg_lookups ml7, -- Include in Rollup
                        -- Revision for version 1.19
                        cic_assys, -- item costs
                        -- ========================================================
                        -- Get the WIP Component Information in a multi-part union
                        -- which is then condensed into a summary data set
                        -- ========================================================
                        -- Section I  Condense into a summary data set.
                        -- ========================================================
                        (select mtl.report_type,
                                mtl.period_name,
                                mtl.organization_code,
                                mtl.organization_id,
                                mtl.primary_cost_method,
                                mtl.account,
                                mtl.class_code,
                                mtl.class_type,
                                mtl.wip_entity_id,
                                mtl.project_id,
                                mtl.status_type,
                                mtl.primary_item_id,
                                mtl.assembly_number,
                                mtl.assy_description,
                                mtl.assy_item_type,
                                mtl.assy_item_status_code,
                                mtl.assy_uom_code,
                                mtl.planning_make_buy_code,
                                mtl.std_lot_size,
                                mtl.lot_number,
                                mtl.creation_date,
                                mtl.scheduled_start_date,
                                mtl.date_released,
                                mtl.date_completed,
                                mtl.date_closed,
                                mtl.last_update_date,
                                mtl.start_quantity,
                                mtl.quantity_completed,
                                mtl.quantity_scrapped,
                                mtl.fg_total_qty,
                                mtl.inventory_item_id,
                                mtl.department_id,
                                mtl.operation_seq_num,
                                mtl.item_num,
                                mtl.wip_supply_type,
                                mtl.component_number,
                                mtl.component_description,
                                mtl.component_item_type,
                                mtl.comp_planning_make_buy_code,
                                mtl.component_item_status_code,
                                mtl.component_uom_code,
                                -- Revision for version 1.28
                                -- Condense to a common value to get only one row
                                case
                                  when mtl.wip_basis_type = 0 and mtl.comp_basis_type = 0 then 1
                                  when mtl.wip_basis_type = 1 then 1
                                  when mtl.wip_basis_type = 2 then 2
                                  when mtl.wip_basis_type = 0 and mtl.comp_basis_type = 1 then 1
                                  when mtl.wip_basis_type = 0 and mtl.comp_basis_type = 2 then 2
                                  else 1
                                end component_basis_type,
                                -- End revision for version 1.28
                                -- Revision for version 1.30
                                mtl.include_in_cost_rollup,
                                mtl.lot_basis_type,
                                mtl.comp_lot_size,
                                mtl.lot_basis_cost,
                                -- Revision for version 1.28, could not do this in Section mtl2
                                -- Condense to a common value to get only one row
                                case
                                  when mtl.wip_basis_type = 0 and mtl.comp_basis_type = 0 then 'Y'
                                  when mtl.wip_basis_type = 1 then 'Y'
                                  when mtl.wip_basis_type = 2 then 'N'
                                  when mtl.wip_basis_type = 0 and mtl.comp_basis_type = 1 then 'Y'
                                  when mtl.wip_basis_type = 0 and mtl.comp_basis_type = 2 then 'N'
                                  else 'Y'
                                end item_basis_type,
                                -- End revision for version 1.28
                                mtl.item_basis_cost,
                                mtl.cost_type,
                                mtl.item_cost,
                                mtl.quantity_per_assembly,
                                mtl.total_req_quantity,
                                mtl.last_txn_date,
                                mtl.quantity_issued,
                                mtl.wip_std_component_value,
                                mtl.applied_component_value,
                                mtl.std_quantity_per_assembly,
                                mtl.std_total_req_quantity --,
                                -- Revision for version 1.27 and 1.30
                                -- Removed, not consistent for resources and overheads
                                -- mtl.alternate_designator_code
                         from   (select mtl2.report_type,
                                        mtl2.period_name,
                                        mtl2.organization_code,
                                        mtl2.organization_id,
                                        mtl2.primary_cost_method,
                                        -- Revision for version 1.12
                                        -- mtl2.primary_cost_type,
                                        mtl2.account,
                                        mtl2.class_code,
                                        mtl2.class_type,
                                        mtl2.wip_entity_id,
                                        mtl2.project_id,
                                        mtl2.status_type,
                                        mtl2.primary_item_id,
                                        -- Revision for version 1.22
                                        mtl2.assembly_number,
                                        mtl2.assy_description,
                                        mtl2.assy_item_type,
                                        mtl2.assy_item_status_code,
                                        mtl2.assy_uom_code,
                                        mtl2.planning_make_buy_code,
                                        mtl2.std_lot_size,
                                        -- End revision for version 1.22
                                        -- Revision for version 1.7
                                        mtl2.lot_number,
                                        mtl2.creation_date,
                                        -- Revision for version 1.5
                                        mtl2.scheduled_start_date,
                                        mtl2.date_released,
                                        mtl2.date_completed,
                                        mtl2.date_closed,
                                        -- Revision for version 1.18
                                        mtl2.schedule_close_date,
                                        mtl2.last_update_date,
                                        mtl2.start_quantity,
                                        mtl2.quantity_completed,
                                        mtl2.quantity_scrapped,
                                        mtl2.fg_total_qty,
                                        mtl2.inventory_item_id,
                                        -- Revision for version 1.19, 1.30 and 1.37
                                        -- mtl2.department_id,
                                        min(case
                                           when mtl2.department_id = 0 then
                                                -- If the component is not on the standard BOM then get
                                                -- the department information from the WIP job.
                                                (select nvl(wro.department_id, wo.department_id)
                                                 from   wip_requirement_operations wro,
                                                        wip_operations wo
                                                 where  wo.wip_entity_id          = wro.wip_entity_id
                                                 and    wo.organization_id        = wro.organization_id
                                                 and    wo.operation_seq_num      = wro.operation_seq_num
                                                 and    wro.inventory_item_id     = mtl2.inventory_item_id
                                                 and    wro.wip_entity_id         = mtl2.wip_entity_id
                                                 -- Revision for version 1.27
                                                 -- Prevent single-row subquery returns more than one row error
                                                 and    rownum                    = 1
                                                 and    wro.organization_id       = mtl2.organization_id)
                                           else mtl2.department_id
                                        end) department_id,
                                        -- End revision for version 1.19, 1.30 and 1.37
                                        -- Revision for version 1.12 and 1.14
                                        -- mtl2.level_num,
                                        -- Revision for version 1.19
                                        -- mtl2.operation_seq_num,
                                        -- Revision for version 1.30
                                        min(case
                                           when mtl2.operation_seq_num is null then
                                                -- Get the operation_seq_num from the WIP BOM, but if the component
                                                -- is not on the WIP BOM, then get it from the standard BOM.
                                                -- This query uses the bill_sequence_id.
                                                (select nvl(wro.operation_seq_num,
                                                            (select comp.operation_seq_num
                                                             from   bom_components_b comp,
                                                                    bom_list bom
                                                             where  bom.bill_sequence_id       = comp.bill_sequence_id
                                                             and    comp.component_item_id     = mtl2.inventory_item_id
                                                             and    bom.assembly_item_id       = mtl2.primary_item_id
                                                             and    bom.organization_id        = mtl2.organization_id
                                                             -- Revision for version 1.33
                                                             -- Prevent single-row subquery returns more than one row error
                                                             and    rownum                     = 1))
                                                 from   wip_requirement_operations wro
                                                 where  wro.inventory_item_id     = mtl2.inventory_item_id
                                                 and    wro.wip_entity_id         = mtl2.wip_entity_id
                                                 and    wro.organization_id       = mtl2.organization_id
                                                 -- Revision for version 1.27
                                                 -- Prevent single-row subquery returns more than one row error
                                                 and    rownum                    = 1
                                                 group by wro.operation_seq_num)
                                           when mtl2.operation_seq_num is not null then mtl2.operation_seq_num
                                           else mtl2.operation_seq_num
                                        end) operation_seq_num,
                                        -- End revision for version 1.19 and 1.30
                                        -- Revision for version 1.27
                                        mtl2.item_num,
                                        -- Revision for version 1.36
                                        case
                                           -- Component is only on the WIP BOM
                                           when sum(mtl2.comp_wip_supply_type) = 0 then sum(mtl2.wip_supply_type)
                                           -- Component is only on the Std BOM
                                           when sum(mtl2.wip_supply_type) = 0 then sum(mtl2.comp_wip_supply_type)
                                           else sum(mtl2.wip_supply_type)
                                        end wip_supply_type,
                                        -- Revision for version 1.6 and 1.22
                                        mtl2.component_number,
                                        mtl2.component_description,
                                        mtl2.component_item_type,
                                        mtl2.comp_planning_make_buy_code,
                                        mtl2.component_item_status_code,
                                        mtl2.component_uom_code,
                                        -- Revision for version 1.28
                                        -- Revision for version 1.8
                                        -- mtl2.basis_type,
                                        -- Condense to a common value to get only one row
                                        sum(mtl2.wip_basis_type) wip_basis_type,
                                        -- End revision for version 1.28
                                        mtl2.lot_basis_type,
                                        -- Revision for version 1.28
                                        mtl2.comp_lot_size,
                                        mtl2.lot_basis_cost,
                                        -- Revision for version 1.28
                                        -- mtl2.item_basis_type,
                                        -- Condense to a common value to get only one row
                                        sum(mtl2.comp_basis_type) comp_basis_type,
                                        -- End revision for version 1.28
                                        -- Revision for version 1.30
                                        sum(mtl2.include_in_cost_rollup) include_in_cost_rollup,
                                        mtl2.item_basis_cost,
                                        -- End revision for version 1.8
                                        mtl2.cost_type,
                                        mtl2.item_cost,
                                        sum(mtl2.quantity_per_assembly) quantity_per_assembly,
                                        sum(mtl2.total_req_quantity) total_req_quantity,
                                        -- Revision for version 1.18
                                        (select max(mmt.transaction_date)
                                         from   mtl_material_transactions mmt
                                         where  mmt.inventory_item_id          = mtl2.inventory_item_id
                                         and    mmt.organization_id            = mtl2.organization_id
                                         and    mmt.transaction_source_id      = mtl2.wip_entity_id
                                         and    mmt.transaction_source_type_id = 5
                                         and    mmt.transaction_date           < mtl2.schedule_close_date + 1) last_txn_date,
                                        -- End revision for version 1.18
                                        sum(mtl2.quantity_issued) quantity_issued,
                                        sum(mtl2.wip_std_component_value) wip_std_component_value,
                                        sum(mtl2.applied_component_value) applied_component_value,
                                        sum(mtl2.std_quantity_per_assembly) std_quantity_per_assembly,
                                        sum(mtl2.std_total_req_quantity) std_total_req_quantity --,
                                        -- Revision for version 1.27 and 1.36
                                        -- Removed, not consistent for resources and overheads
                                        -- (select badv.display_name
                                        --  from   bom_structures_b bom,
                                        --         bom_alternate_designators_vl badv 
                                        --  where  bom.assembly_item_id           = mtl2.primary_item_id
                                        --  and    bom.organization_id            = mtl2.organization_id 
                                        --  and    badv.alternate_designator_code = bom.alternate_bom_designator
                                        --  -- Revision for version 1.28
                                        --  and    badv.display_name              = nvl('&p_alt_bom_designator', badv.display_name)                -- p_alt_bom_designator
                                        --  and    rownum                         = 1 
                                        -- ) alternate_designator_code
                                        -- End revision for version 1.27 and 1.36
                                 from   -- =======================================================
                                        -- Section I.A. WIP and WIP Material Components
                                        -- =======================================================
                                        -- Revision for version 1.12
                                        (select 'I.A' section,
                                                -- Revision for version 1.22
                                                wro.report_type,
                                                wro.period_name,
                                                wro.organization_code,
                                                wro.organization_id,
                                                wro.primary_cost_method,
                                                -- Revision for version 1.12
                                                -- cct.cost_type primary_cost_type,
                                                wro.account,
                                                wro.class_code,
                                                wro.class_type,
                                                wro.wip_entity_id,
                                                wro.project_id,
                                                wro.status_type,
                                                wro.primary_item_id,
                                                -- Revision for version 1.22
                                                wro.assembly_number,
                                                wro.assy_description,
                                                wro.assy_item_type,
                                                wro.assy_item_status_code,
                                                wro.assy_uom_code,
                                                wro.planning_make_buy_code,
                                                wro.std_lot_size,
                                                -- End revision for version 1.22
                                                -- Revision for version 1.7
                                                wro.lot_number,
                                                wro.creation_date,
                                                -- Revision for version 1.5
                                                wro.scheduled_start_date,
                                                wro.date_released,
                                                wro.date_completed,
                                                wro.date_closed,
                                                -- Revision for version 1.22
                                                wro.schedule_close_date,
                                                wro.last_update_date,
                                                wro.start_quantity,
                                                wro.quantity_completed,
                                                wro.quantity_scrapped,
                                                wro.fg_total_qty,
                                                -- End revision for version 1.22
                                                wro.inventory_item_id,
                                                -- Revision for version 1.14
                                                -- nvl(wo.department_id,0) department_id,
                                                wo.department_id department_id,
                                                -- Revision for version 1.6
                                                wro.level_num,
                                                -- Revision for version 1.25
                                                -- wo.operation_seq_num,
                                                wro.operation_seq_num,
                                                -- Revision for version 1.14
                                                wro.component_sequence_id,
                                                -- Revision for version 1.27
                                                wro.item_num,
                                                wro.wip_supply_type,
                                                -- Revision for version 1.36
                                                0 comp_wip_supply_type,
                                                -- Revision for version 1.6 and 1.22
                                                wro.component_number,
                                                wro.component_description,
                                                wro.component_item_type,
                                                wro.comp_planning_make_buy_code,
                                                wro.component_item_status_code,
                                                wro.component_uom_code,
                                                -- End revision for version 1.22
                                                -- Revision for version 1.21
                                                -- wro.phantom_parent,
                                                -- End revision for version 1.6
                                                -- Revision for version 1.8
                                                -- coalesce(wro.basis_type, cic_comp.basis_type, 1) basis_type,
                                                -- Revision for version 1.28
                                                -- nvl(wro.basis_type, 1) basis_type,
                                                nvl(wro.basis_type, 1) wip_basis_type,
                                                0 comp_basis_type,
                                                -- End revision for version 1.28
                                                -- Revision for version 1.30
                                                0 include_in_cost_rollup,
                                                decode(cic_comp.lot_basis_type, 0, 'N', 'Y') lot_basis_type,
                                                nvl(cic_comp.lot_size,1) comp_lot_size,
                                                -- Revision for version 1.12
                                                nvl(cic_comp.lot_basis_cost,0) lot_basis_cost,
                                                -- Revision for version 1.28
                                                -- decode(nvl(wro.basis_type,1),
                                                --            1, 'Y',
                                                --            2, 'N',
                                                --            decode(cic_comp.item_basis_type, 0, 'N', 'Y')
                                                --      ) item_basis_type,
                                                -- End revision for version 1.28
                                                -- Revision for version 1.12
                                                nvl(cic_comp.item_basis_cost,0) item_basis_cost,
                                                cic_comp.cost_type cost_type,
                                                nvl(cic_comp.item_cost,0) item_cost,
                                                -- a basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
                                                decode(nvl(wro.basis_type,1), 
                                                        1, nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1),                    -- Item basis
                                                        2, nvl(wro.required_quantity,1),                                                              -- Lot
                                                           nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1)                     -- Any other basis
                                                          ) quantity_per_assembly,
                                                -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                                                -- then use completions plus scrap quantities unless for lot-based jobs.
                                                round(case when wro.status_type in (4,5,7,12,14,15) then
                                                        -- use the completions plus scrap quantities unless for lot-based jobs
                                                        decode(nvl(wro.basis_type, 1),
                                                                        -- Revision for version 1.29
                                                                        -- 2, nvl(wro.quantity_per_assembly,0),                                        -- Lot
                                                                        2, nvl(wro.quantity_per_assembly,0) *                                          -- Lot
                                                                                case
                                                                                   when nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0)) = 0 then 0
                                                                                   when nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0)) > 0 then 1
                                                                                   else 0
                                                                                end,
                                                                        -- End revision for version 1.29
                                                                        nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1)         -- Any other basis
                                                                        * decode(wro.class_type,
                                                                                 5, nvl(wro.quantity_completed, 0),
                                                                                        nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0))
                                                                                )
                                                                  ) else
                                                        -- Else use the start quantity times the usage rate or amount
                                                        decode(:p_use_completion_qtys,
                                                                'Y', decode(nvl(wro.basis_type, 1),
                                                                                -- use the completions plus scrap quantities unless for lot-based jobs
                                                                                -- Revision for version 1.29
                                                                                -- 2, nvl(wro.quantity_per_assembly,0),                                -- Lot
                                                                                2, nvl(wro.quantity_per_assembly,0) *                                  -- Lot
                                                                                        case
                                                                                           when nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0)) = 0 then 0
                                                                                           when nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0)) > 0 then 1
                                                                                           else 0
                                                                                        end,
                                                                                -- End revision for version 1.29
                                                                                   nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) -- Any other basis
                                                                                        * decode(wro.class_type,
                                                                                                 5, nvl(wro.quantity_completed, 0),
                                                                                                        nvl(wro.quantity_completed, 1) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0))
                                                                                                )
                                                                           ),
                                                                'N', decode(nvl(wro.basis_type, 1),
                                                                                2, nvl(wro.quantity_per_assembly,0),                                                           -- Lot
                                                                                   nvl(wro.quantity_per_assembly,0) * wro.start_quantity * 1/nvl(wro.component_yield_factor,1) -- Any other basis
                                                                           )
                                                                  ) end
                                                   ,6) total_req_quantity,
                                                nvl(wro.quantity_issued,0) quantity_issued,
                                                -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                                                -- then use completions plus scrap quantities unless for lot-based jobs.
                                                round(case when wro.status_type in (4,5,7,12,14,15) then
                                                        -- use the completions plus scrap quantities unless for lot-based jobs
                                                        decode(nvl(wro.basis_type,1),
                                                                        -- Revision for version 1.29
                                                                        -- 2, nvl(wro.quantity_per_assembly,0),                                        -- Lot
                                                                        2, nvl(wro.quantity_per_assembly,0) *                                          -- Lot
                                                                                case
                                                                                   when nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0)) = 0 then 0
                                                                                   when nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0)) > 0 then 1
                                                                                   else 0
                                                                                end,
                                                                        -- End revision for version 1.29
                                                                           nvl(wro.quantity_per_assembly,1) * 1/nvl(wro.component_yield_factor,1)                -- Any other basis
                                                                        * decode(wro.class_type,
                                                                                 5, nvl(wro.quantity_completed, 0),
                                                                                        nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0))
                                                                                )
                                                                  ) else
                                                        -- else use the start quantity times the usage rate or amount
                                                        decode(:p_use_completion_qtys,
                                                                'Y', decode(nvl(wro.basis_type,1),
                                                                                -- use the completions plus scrap quantities unless for lot-based jobs
                                                                                -- Revision for version 1.29
                                                                                -- 2, nvl(wro.quantity_per_assembly,0),                                -- Lot
                                                                                2, nvl(wro.quantity_per_assembly,0) *                                  -- Lot
                                                                                        case
                                                                                           when nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0)) = 0 then 0
                                                                                           when nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0)) > 0 then 1
                                                                                           else 0
                                                                                        end,
                                                                                -- End revision for version 1.29
                                                                                   nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1)         -- Any other basis
                                                                                        * decode(wro.class_type,
                                                                                                 5, nvl(wro.quantity_completed, 0),
                                                                                                        nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0))
                                                                                                )
                                                                           ),
                                                                'N', decode(nvl(wro.basis_type,1),
                                                                                2, nvl(wro.quantity_per_assembly,0),                                                           -- Lot
                                                                                   nvl(wro.quantity_per_assembly,0) * wro.start_quantity * 1/nvl(wro.component_yield_factor,1) -- Any other basis
                                                                           )
                                                                  ) end
                                                   ,6) -- total_req_quantity
                                                -- And multiply by the Cost_Type or Costing_Method costs
                                                * nvl(cic_comp.item_cost,0) wip_std_component_value,
                                                nvl(wro.quantity_issued,0)
                                                -- And multiply by the Cost Type or Costing Method costs
                                                        * nvl(cic_comp.item_cost,0) applied_component_value,
                                                0 std_quantity_per_assembly,
                                                0 std_total_req_quantity
                                         from   wip_operations wo,
                                                -- Revision for version 1.12
                                                -- cst_cost_types cct,
                                                -- Revision for version 1.22
                                                -- mtl_system_items_vl msiv,
                                                -- Revision for version 1.22
                                                cic_comp, -- Get the Cost Basis Type and Component Item Costs
                                                -- wdj, -- get the corrected wip qty completed and qty scrapped
                                                -- End revision for version 1.22
                                                -- get the corrected wip component issue quantities
                                                -- Revision for version 1.34, make the WIP component code section as a WITH statement
                                                wdj_comp wro
                                         -- ===========================================
                                         -- WIP_Job Entity, Class and Period joins
                                         -- ===========================================
                                         -- Revision for version 1.22
                                         -- where  wro.wip_entity_id              = wdj.wip_entity_id
                                         -- and    wro.organization_id            = wdj.organization_id
                                         -- and    wo.operation_seq_num (+)       = wro.operation_seq_num
                                         -- End revision for version 1.22
                                         where  wo.operation_seq_num (+)       = wro.operation_seq_num
                                         and    wo.wip_entity_id (+)           = wro.wip_entity_id
                                         and    wo.organization_id (+)         = wro.organization_id
                                        -- Revision for version 1.12
                                        -- and    cct.cost_type_id               = wdj.primary_cost_method
                                         and    wro.organization_id            = cic_comp.organization_id (+)
                                         and    wro.inventory_item_id          = cic_comp.inventory_item_id (+)
                                         -- Revision for version 1.35
                                         and    wro.wip_entity_id              = cic_comp.wip_entity_id (+)
                                         -- Revision for version 1.22
                                         -- and    msiv.organization_id           = wro.organization_id
                                         -- and    msiv.inventory_item_id         = wro.inventory_item_id
                                         -- End revision for version 1.22
                                         union all
                                         -- =======================================================
                                         -- Section I.B. Get the Bill of Material
                                         -- Get BOM information for configuration variances.
                                         -- =======================================================
                                         -- Revision for version 1.12
                                         select 'I.B' section,
                                                -- Revision for version 1.22
                                                comp.report_type,
                                                comp.period_name,
                                                comp.organization_code,
                                                comp.organization_id,
                                                comp.primary_cost_method,
                                                -- Revision for version 1.12
                                                -- cct.cost_type primary_cost_type,
                                                comp.account,
                                                comp.class_code,
                                                comp.class_type,
                                                comp.wip_entity_id,
                                                comp.project_id,
                                                comp.status_type,
                                                comp.primary_item_id,
                                                -- Revision for version 1.22
                                                comp.assembly_number,
                                                comp.assy_description,
                                                comp.assy_item_type,
                                                comp.assy_item_status_code,
                                                comp.assy_uom_code,
                                                comp.planning_make_buy_code,
                                                comp.std_lot_size,
                                                -- End revision for version 1.22
                                                -- Revision for version 1.7
                                                comp.lot_number,
                                                comp.creation_date,
                                                -- Revision for version 1.5
                                                comp.scheduled_start_date,
                                                comp.date_released,
                                                comp.date_completed,
                                                comp.date_closed,
                                                -- Revision for version 1.18
                                                comp.schedule_close_date,
                                                comp.last_update_date,
                                                comp.start_quantity,
                                                comp.quantity_completed,
                                                comp.quantity_scrapped,
                                                comp.fg_total_qty,
                                                comp.component_item_id inventory_item_id,
                                                -- Revision for version 1.37
                                                -- Get the department from the routing  
                                                nvl((select nvl(res_sum.department_id, 0)
                                                     from   res_sum
                                                     where  res_sum.operation_seq_num = comp.operation_seq_num
                                                     and    res_sum.wip_entity_id     = comp.wip_entity_id
                                                     -- Revision for version 1.27
                                                     -- Prevent single-row subquery returns more than one row error
                                                     and    rownum                    = 1
                                                     group by department_id),0) department_id,
                                                -- End revision for version 1.37
                                                -- Revision for version 1.6
                                                comp.level_num,
                                                -- Revision for version 1.5, 1.14, 1.19 and 1.22
                                                -- The primary BOM operation_seq_num may be null or different from the WIP BOM
                                                -- This logic tries to keep the BOM information on the same row.
                                                -- abs(comp.operation_seq_num) operation_seq_num,
                                                -- This query uses the component_sequence_id.
                                                nvl((select min(wro.operation_seq_num)
                                                     from   wip_requirement_operations wro
                                                     where  wro.inventory_item_id     = comp.component_item_id
                                                     and    wro.component_sequence_id = comp.component_sequence_id
                                                     and    wro.wip_entity_id         = comp.wip_entity_id
                                                     and    wro.organization_id       = comp.organization_id
                                                     -- Revision for version 1.33
                                                     and    rownum                    = 1
                                                -- Revision for version 1.36
                                                -- ), '') operation_seq_num,
                                                ), comp.operation_seq_num) operation_seq_num,
                                                -- End revision for version 1.36
                                                -- Revision for version 1.14
                                                comp.component_sequence_id,
                                                -- Revision for version 1.27
                                                comp.item_num,
                                                -- Revision for version 1.36
                                                0 wip_supply_type,
                                                comp.wip_supply_type comp_wip_supply_type,
                                                -- End revision for version 1.36
                                                -- Revision for version 1.6 and 1.22
                                                comp.component_number,
                                                comp.component_description,
                                                comp.component_item_type,
                                                comp.comp_planning_make_buy_code,
                                                comp.component_item_status_code,
                                                comp.component_uom_code,
                                                -- End revision for version 1.22
                                                -- Revision for version 1.21
                                                -- comp.phantom_parent,
                                                -- End revision for version 1.6
                                                -- Revision for version 1.28
                                                -- nvl(comp.basis_type, 1) basis_type,
                                                0 wip_basis_type,
                                                nvl(comp.basis_type, 1) comp_basis_type,
                                                -- End revision for version 1.28
                                                -- Revision for version 1.30
                                                comp.include_in_cost_rollup,
                                                decode(cic_comp.lot_basis_type, 0, 'N', 'Y') lot_basis_type,
                                                nvl(cic_comp.lot_size,1) comp_lot_size,
                                                -- Revision for version 1.12
                                                nvl(cic_comp.lot_basis_cost,0) lot_basis_cost,
                                                -- Revision for version 1.28
                                                -- decode(nvl(comp.basis_type,1),
                                                --         1, 'Y',
                                                --         2, 'N',
                                                --         decode(cic_comp.item_basis_type, 0, 'N', 'Y')
                                                --      ) item_basis_type,
                                                -- End revision for version 1.28
                                                -- Revision for version 1.12
                                                nvl(cic_comp.item_basis_cost,0) item_basis_cost,
                                                cic_comp.cost_type cost_type,
                                                nvl(cic_comp.item_cost,0) item_cost,
                                                0 quantity_per_assembly,
                                                0 total_req_quantity,
                                                0 quantity_issued,
                                                0 wip_std_component_value,
                                                0 applied_component_value,
                                                -- Revision for version 1.12, restructure the code
                                                -- a basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
                                                -- Revision for version 1.36, std_quantity_per_assembly = component usage quantity) / component yield) / (1 - shrinkage rate for parent)
                                                decode(nvl(comp.basis_type,1), 
                                                        1,    nvl(comp.component_quantity,0) * 1/nvl(comp.component_yield_factor,1),                   -- Item basis
                                                        2,    nvl(comp.component_quantity,1),                                                          -- Lot
                                                              nvl(comp.component_quantity,0) * 1/nvl(comp.component_yield_factor,1)                    -- Any other basis
                                                -- Revision for version 1.36, include shrinkage_rate
                                                      )  / (1 - ca.shrinkage_rate) std_quantity_per_assembly,
                                                round(case when comp.status_type in (4,5,7,12,14,15) then
                                                        -- use the completions plus scrap quantities unless for lot-based jobs
                                                        decode(nvl(comp.basis_type, 1),
                                                                -- Revision for version 1.29
                                                                -- 2, nvl(comp.component_quantity,0),                                                  -- Lot
                                                                2, nvl(comp.component_quantity,0) *                                                    -- Lot
                                                                        case
                                                                           -- Revision for version 1.36
                                                                           -- If the shrinkage rate is not zero, do not include scrap quantities as scrap is already included in the shrinkage rate, as the expected scrap amount.
                                                                           -- when nvl(comp.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0)) = 0 then 0
                                                                           -- when nvl(comp.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0)) > 0 then 1
                                                                           when nvl(comp.quantity_completed, 0) + decode(ca.shrinkage_rate, 0, decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0)), 0) = 0 then 0
                                                                           when nvl(comp.quantity_completed, 0) + decode(ca.shrinkage_rate, 0, decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0)), 0) > 0 then 1
                                                                           -- End for revision 1.36
                                                                           else 0
                                                                        end,
                                                                -- End revision for version 1.29
                                                                   nvl(comp.component_quantity,0) * 1/nvl(comp.component_yield_factor,1)               -- Any other basis
                                                                * decode(comp.class_type,
                                                                         5, nvl(comp.quantity_completed, 0),
                                                                                -- Revision for version 1.36
                                                                                -- If the shrinkage rate is not zero, do not include scrap quantities as scrap is already included in the shrinkage rate, as the expected scrap amount.
                                                                                -- nvl(comp.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0))
                                                                                nvl(comp.quantity_completed, 0) + decode(ca.shrinkage_rate, 0, decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0)), 0)
                                                                                -- End for revision 1.36
                                                                        )
                                                                  ) else
                                                        -- else use the start quantity times the usage rate or amount
                                                        -- Revision for version 1.5
                                                        decode(:p_use_completion_qtys,
                                                                'Y', decode(nvl(comp.basis_type,1),
                                                                                -- use the completions plus scrap quantities unless for lot-based jobs
                                                                                -- Revision for version 1.29
                                                                                -- 2, nvl(comp.component_quantity,0),                                  -- Lot
                                                                                2, nvl(comp.component_quantity,0) *                                    -- Lot
                                                                                        case
                                                                                           -- Revision for version 1.36
                                                                                           -- If the shrinkage rate is not zero, do not include scrap quantities as scrap is already included in the shrinkage rate, as the expected scrap amount.
                                                                                           -- when nvl(comp.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0)) = 0 then 0
                                                                                           -- when nvl(comp.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0)) > 0 then 1
                                                                                           when nvl(comp.quantity_completed, 0) + decode(ca.shrinkage_rate, 0, decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0)), 0) = 0 then 0
                                                                                           when nvl(comp.quantity_completed, 0) + decode(ca.shrinkage_rate, 0, decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0)), 0) > 0 then 1
                                                                                           -- End for revision 1.36
                                                                                           else 0
                                                                                        end,
                                                                                -- End revision for version 1.29
                                                                                   nvl(comp.component_quantity,0) * 1/nvl(comp.component_yield_factor,1)         -- Any other basis
                                                                                * decode(comp.class_type,
                                                                                         5, nvl(comp.quantity_completed, 0),
                                                                                                -- Revision for version 1.36
                                                                                                -- If the shrinkage rate is not zero, do not include scrap quantities as scrap is already included in the shrinkage rate, as the expected scrap amount.
                                                                                                -- nvl(comp.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0))
                                                                                                nvl(comp.quantity_completed, 0) + decode(ca.shrinkage_rate, 0, decode(:p_include_scrap, 'N', 0, null, 0, nvl(comp.quantity_scrapped, 0)), 0)
                                                                                                -- End for revision 1.36
                                                                                        )
                                                                           ),
                                                                -- else use the start quantity times the usage rate or amount
                                                                'N', decode(nvl(comp.basis_type,1),
                                                                                2, nvl(comp.component_quantity,0),                                                             -- Lot
                                                                                   nvl(comp.component_quantity,0) * comp.start_quantity * 1/nvl(comp.component_yield_factor,1) -- Any other basis
                                                                           )
                                                              ) end
                                                        -- End revision for version 1.5
                                                   ,6) std_total_req_quantity
                                        -- Revision for version 1.22
                                        -- from   bom_structures_b bom,
                                        from    cic_comp, -- Get the Cost Basis Type and Item Costs
                                                -- Revision for version 1.34, put standard components code section into WITH statement
                                                std_bom_comp comp,
                                                -- Revision for version 1.36
                                                cic_assys ca
                                         where  cic_comp.organization_id (+)   = comp.organization_id
                                         and    cic_comp.inventory_item_id (+) = comp.component_item_id
                                         -- Revision for version 1.35
                                         and    cic_comp.wip_entity_id (+)     = comp.wip_entity_id
                                         -- Revision for version 1.34 and 1.36
                                         -- Do not get phantom components, not issued to WIP
                                         -- and    comp.wip_supply_type          <> 6
                                         -- Rules for version 1.36
                                         -- Do not get components if the prior (higher) level component was not
                                         -- a phantom, as phantom components are not issued to WIP.
                                         and    0 = case -- 0 = Not a phantom, 1 = Yes a phantom
                                                      -- Check level 1 components
                                                      when comp.level_num = 1 and comp.level_1_comp_is_phantom = 0 then 0
                                                      -- Check level 2 components
                                                      when comp.level_num = 2 and comp.level_1_comp_is_phantom = 1 and comp.level_2_comp_is_phantom = 0 then 0
                                                      -- Check level 3 components
                                                      when comp.level_num = 3 and comp.level_1_comp_is_phantom = 1 and comp.level_2_comp_is_phantom = 1 and comp.level_3_comp_is_phantom = 0 then 0
                                                      -- Check level 4 components
                                                      when comp.level_num = 4 and comp.level_1_comp_is_phantom = 1 and comp.level_2_comp_is_phantom = 1 and comp.level_3_comp_is_phantom = 1 and comp.level_4_comp_is_phantom = 0 then 0
                                                      else 1
                                                    end
                                         and    ca.organization_id             = comp.organization_id
                                         and    ca.inventory_item_id           = comp.primary_item_id
                                         -- End revision for version 1.36
                                        ) mtl2
                                 group by
                                        mtl2.report_type,
                                        mtl2.period_name,
                                        mtl2.organization_code,
                                        mtl2.organization_id,
                                        mtl2.primary_cost_method,
                                        -- Revision for version 1.12
                                        -- mtl2.primary_cost_type,
                                        mtl2.account,
                                        mtl2.class_code,
                                        mtl2.class_type,
                                        mtl2.wip_entity_id,
                                        mtl2.project_id,
                                        mtl2.status_type,
                                        mtl2.primary_item_id,
                                        -- Revision for version 1.22
                                        mtl2.assembly_number,
                                        mtl2.assy_description,
                                        mtl2.assy_item_type,
                                        mtl2.assy_item_status_code,
                                        mtl2.assy_uom_code,
                                        mtl2.planning_make_buy_code,
                                        mtl2.std_lot_size,
                                        -- End revision for version 1.22
                                        -- Revision for version 1.7
                                        mtl2.lot_number,
                                        mtl2.creation_date,
                                        -- Revision for version 1.5
                                        mtl2.scheduled_start_date,
                                        mtl2.date_released,
                                        mtl2.date_completed,
                                        mtl2.date_closed,
                                        -- Revision for version 1.18
                                        mtl2.schedule_close_date,
                                        mtl2.last_update_date,
                                        mtl2.start_quantity,
                                        mtl2.quantity_completed,
                                        mtl2.quantity_scrapped,
                                        mtl2.fg_total_qty,
                                        mtl2.inventory_item_id,
                                        -- Revision for version 1.12 and 1.14
                                        -- mtl2.level_num,
                                        -- Revision for version 1.14 and 1.30
                                        -- mtl2.operation_seq_num,
                                        -- Revision for version 1.27
                                        mtl2.item_num, -- item_op_seq
                                        -- Revision for version 1.30
                                        -- mtl2.wip_supply_type,
                                        -- End revision for version 1.14
                                        -- Revision for version 1.6 and 1.22
                                        mtl2.component_number,
                                        mtl2.component_description,
                                        mtl2.component_item_type,
                                        mtl2.comp_planning_make_buy_code,
                                        mtl2.component_item_status_code,
                                        mtl2.component_uom_code,
                                        -- End revision for version 1.22
                                        -- Revision for version 1.28
                                        -- Revision for version 1.8
                                        -- mtl2.basis_type,
                                        mtl2.lot_basis_type,
                                        -- Revision for version 1.28
                                        mtl2.comp_lot_size,
                                        mtl2.lot_basis_cost,
                                        -- Revision for version 1.28
                                        -- mtl2.item_basis_type,
                                        mtl2.item_basis_cost,
                                        -- End revision for version 1.8
                                        mtl2.cost_type,
                                        mtl2.item_cost
                                ) mtl
                         group by
                                mtl.report_type,
                                mtl.period_name,
                                mtl.organization_code,
                                mtl.organization_id,
                                mtl.primary_cost_method,
                                mtl.account,
                                mtl.class_code,
                                mtl.class_type,
                                mtl.wip_entity_id,
                                mtl.project_id,
                                mtl.status_type,
                                mtl.primary_item_id,
                                mtl.assembly_number,
                                mtl.assy_description,
                                mtl.assy_item_type,
                                mtl.assy_item_status_code,
                                mtl.assy_uom_code,
                                mtl.planning_make_buy_code,
                                mtl.std_lot_size,
                                -- End revision for version 1.22
                                -- Revision for version 1.7
                                mtl.lot_number,
                                mtl.creation_date,
                                -- Revision for version 1.5
                                mtl.scheduled_start_date,
                                mtl.date_released,
                                mtl.date_completed,
                                mtl.date_closed,
                                mtl.last_update_date,
                                mtl.start_quantity,
                                mtl.quantity_completed,
                                mtl.quantity_scrapped,
                                mtl.fg_total_qty,
                                mtl.inventory_item_id,
                                mtl.department_id,
                                mtl.operation_seq_num,
                                mtl.item_num, -- item_or_res_op_seq
                                mtl.wip_supply_type,
                                mtl.component_number,
                                mtl.component_description,
                                mtl.component_item_type,
                                mtl.comp_planning_make_buy_code,
                                mtl.component_item_status_code,
                                mtl.component_uom_code,
                                -- Revision for version 1.28
                                -- Condense to a common value to get only one row
                                case
                                  when mtl.wip_basis_type = 0 and mtl.comp_basis_type = 0 then 1
                                  when mtl.wip_basis_type = 1 then 1
                                  when mtl.wip_basis_type = 2 then 2
                                  when mtl.wip_basis_type = 0 and mtl.comp_basis_type = 1 then 1
                                  when mtl.wip_basis_type = 0 and mtl.comp_basis_type = 2 then 2
                                  else 1
                                end, -- component_basis_type
                                -- End revision for version 1.28
                                -- Revision for version 1.30
                                mtl.include_in_cost_rollup,
                                mtl.lot_basis_type,
                                mtl.comp_lot_size,
                                mtl.lot_basis_cost,
                                -- Revision for version 1.28
                                -- Condense to a common value to get only one row
                                case
                                  when mtl.wip_basis_type = 0 and mtl.comp_basis_type = 0 then 'Y'
                                  when mtl.wip_basis_type = 1 then 'Y'
                                  when mtl.wip_basis_type = 2 then 'N'
                                  when mtl.wip_basis_type = 0 and mtl.comp_basis_type = 1 then 'Y'
                                  when mtl.wip_basis_type = 0 and mtl.comp_basis_type = 2 then 'N'
                                  else 'Y'
                                end, -- item_basis_type
                                -- End revision for version 1.28
                                mtl.item_basis_cost,
                                mtl.cost_type,
                                mtl.item_cost,
                                mtl.quantity_per_assembly,
                                mtl.total_req_quantity,
                                mtl.last_txn_date,
                                mtl.quantity_issued,
                                mtl.wip_std_component_value,
                                mtl.applied_component_value,
                                mtl.std_quantity_per_assembly,
                                mtl.std_total_req_quantity --,
                                -- Revision for version 1.27 and 1.30
                                -- Removed, not consistent for resources and overheads
                                -- mtl.alternate_designator_code
                        ) mtl_sum
                 -- ===========================================
                 -- Item, cost and department joins
                 -- ===========================================
                 -- Revision for version 1.24
                 -- where  msiv2.organization_id            = mtl_sum.organization_id      -- component org
                 -- and    msiv2.inventory_item_id          = mtl_sum.inventory_item_id    -- component item
                 -- and    misv2.inventory_item_status_code = msiv2.inventory_item_status_code
                 -- and    muomv2.uom_code                  = msiv2.primary_uom_code
                 where  misv2.inventory_item_status_code = mtl_sum.component_item_status_code
                 and    muomv2.uom_code                  = mtl_sum.component_uom_code
                 -- Revision for version 1.24
                 and    ml4.lookup_type                  = 'MTL_PLANNING_MAKE_BUY'
                 -- and    ml4.lookup_code                  = msiv2.planning_make_buy_code
                 and    ml4.lookup_code                  = mtl_sum.comp_planning_make_buy_code
                 -- End revision for version 1.24
                 and    ml5.lookup_type (+)              = 'WIP_SUPPLY'
                 and    ml5.lookup_code (+)              = mtl_sum.wip_supply_type
                 and    ml6.lookup_type                  = 'CST_BASIS'
                 and    ml6.lookup_code                  = mtl_sum.component_basis_type
                 -- Revision for version 1.30
                 and    ml7.lookup_type                 = 'SYS_YES_NO'
                 and    ml7.lookup_code                 = to_char(decode(mtl_sum.include_in_cost_rollup,0,2,1,1,2,2,2))
                 -- Revision for version 1.23
                 -- and    fl.lookup_type                   = 'YES_NO'
                 -- and    fl.lookup_code                   = mtl_sum.phantom_parent
                 -- End revision for version 1.23
                 -- Revision for version 1.24
                 and    fcl2.lookup_type (+)             = 'ITEM_TYPE'
                 -- and    fcl2.lookup_code (+)             = msiv2.item_type
                 and    fcl2.lookup_code (+)             = mtl_sum.component_item_type
                 -- End revision for version 1.24
                 -- These joins get the Item Lot Size
                 and    cic_assys.organization_id (+)    = mtl_sum.organization_id
                 and    cic_assys.inventory_item_id (+)  = mtl_sum.primary_item_id
                 and    cic_assys.cost_type_id (+)       = mtl_sum.primary_cost_method
                 -- Screen out phantoms from the WIP BOM as these are never issued from stock
                 -- Phantoms on the WIP BOM have a negative operation_seq_num
                 -- Revision for version 1.31
                 -- Fix for components on standard BOM but not on WIP BOM
                 -- and    nvl(mtl_sum.operation_seq_num,0) > 0
                 and    nvl(mtl_sum.operation_seq_num,1) > 0
                 -- Remove noise from the report, if no quantities required do not report the component
                 and    nvl(mtl_sum.quantity_per_assembly,0) + nvl(mtl_sum.std_quantity_per_assembly,0) + round(mtl_sum.quantity_issued,3) <> 0
                 and    6=6                              -- p_include_bulk_items
                 and    9=9                              -- p_component_number
                 union all
                 -- ===========================================
                 -- Section II - Resource Variances
                 -- Inline table select for WIP Resource Variances
                 -- ===========================================
                 select res_sum.report_type,
                        res_sum.organization_code,
                        res_sum.period_name,
                        res_sum.account,
                        res_sum.class_code,
                        res_sum.class_type,
                        res_sum.wip_entity_id,
                        res_sum.project_id,
                        res_sum.status_type,
                        res_sum.primary_item_id,
                        res_sum.assembly_number,
                        res_sum.assy_description,
                        res_sum.assy_item_type,
                        res_sum.assy_item_status_code,
                        res_sum.assy_uom_code,
                        res_sum.planning_make_buy_code,
                        res_sum.lot_number,
                        -- Revision for version 1.23
                        2  report_sort,
                        res_sum.creation_date,
                        res_sum.scheduled_start_date,
                        res_sum.date_released,
                        res_sum.date_completed,
                        res_sum.date_closed,
                        res_sum.last_update_date,
                        res_sum.std_lot_size,
                        cic_assys.cost_type  lot_size_cost_type,
                        nvl(cic_assys.lot_size, 1) costing_lot_size, 
                        res_sum.start_quantity,
                        res_sum.quantity_completed,
                        res_sum.quantity_scrapped,
                        res_sum.fg_total_qty,
                        res_sum.purchase_item_id inventory_item_id,
                        res_sum.organization_id,
                        msiv2.concatenated_segments osp_item,
                        msiv2.description osp_description,
                        (select poh.segment1
                         from   po_headers_all poh
                         where  poh.po_header_id = res_sum.po_header_id) po_number,
                        decode(res_sum.line_num, 0, null, res_sum.line_num) line_number,
                        decode(res_sum.release_num, 0, null, res_sum.release_num) po_release,
                        res_sum.department_id,
                        res_sum.operation_seq_num,
                        res_sum.resource_seq_num  item_or_res_op_seq,
                        res_sum.resource_code item_or_resource,
                        res_sum.description,
                        -- Revision for version 1.24
                        res_sum.res_unit_of_measure resource_uom_code,
                        null overhead,
                        null ovhd_description,
                        null ovhd_basis_type,
                        null ovhd_unit_of_measure,
                        -- Revision for version 1.23
                        -- fl.meaning phantom_parent,
                        fcl2.meaning component_item_type,
                        misv2.inventory_item_status_code component_status_code,
                        ml4.meaning component_make_buy_code,
                        null wip_supply_type,
                        ml6.meaning basis_type,
                        -- Revision for version 1.30
                        null include_in_rollup,
                        res_sum.lot_basis_type,
                        null comp_lot_size,
                        res_sum.lot_basis_cost,
                        -- End revision for version 1.30
                        res_sum.item_basis_type,
                        res_sum.item_basis_cost,
                        res_sum.cost_type,
                        nvl(res_sum.resource_rate,0) item_or_resource_cost,
                        -- Revision for version 1.23
                        0 rate_or_amount,
                        muomv2.uom_code,
                        res_sum.usage_rate_or_amount quantity_per_assembly,
                        res_sum.total_req_quantity,
                        -- Revision for version 1.22
                        (select max(wt.transaction_date)
                         from   wip_transactions wt
                         where  wt.resource_id                = res_sum.resource_id
                         and    wt.organization_id            = res_sum.organization_id
                         and    wt.wip_entity_id              = res_sum.wip_entity_id
                         and    wt.transaction_type in (1,3) -- 1 - Resource, 3 - Outside Processing
                         and    wt.transaction_date           < res_sum.schedule_close_date + 1) last_txn_date,
                        -- End revision for version 1.22
                        res_sum.applied_resource_units quantity_issued,
                        res_sum.wip_std_resource_value wip_std_comp_or_res_value,
                        res_sum.applied_resource_value applied_comp_or_res_value,
                        round(res_sum.std_usage_rate_or_amount,3) std_quantity_per_assembly,
                        round(res_sum.std_total_req_quantity,3) std_total_req_quantity,
                        0 wip_std_overhead_value,
                        0 matl_usage_var,
                        0 matl_config_var,
                        -- Revision for version 1.30
                        0 wip_matl_lot_charges_per_unit,
                        0 std_matl_lot_charges_per_unit,
                        -- End revision for version 1.30
                        0 matl_lot_var,
                        -- =============================
                        -- Resource Efficiency Variance
                        -- =============================
                        decode(res_sum.cost_element_id, 4, 0, round(res_sum.applied_resource_value - res_sum.wip_std_resource_value,2)) res_efficiency_var,
                        -- =============================
                        -- Resource Methods Variance
                        -- =============================
                        decode(res_sum.cost_element_id, 4, 0, 
                                case
                                   when nvl(res_sum.basis_type, 1) <> 1 then 0
                                   -- when nvl(res_sum.total_req_quantity,0) = 0 then 0
                                   -- when nvl(res_sum.std_total_req_quantity,0) = 0 then 0
                                   -- Add parameter for non-standard jobs.
                                   -- when res_sum.class_type = 3 then 0 -- 3 - non-standard job
                                   when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
                                   -- Zero out the resource efficiency calculation when there are no completions and no applied quantities.
                                   when res_sum.fg_total_qty = 0 and round(res_sum.applied_resource_value,2) = 0
                                        then -1 * (round(res_sum.applied_resource_value - res_sum.wip_std_resource_value,2))
                                   when cic_assys.rolled_up = 'N' then 0
                                   when nvl(res_sum.std_total_req_quantity,0) = 0 and nvl(res_sum.total_req_quantity,0) = 0 then 0
                                   else round((nvl(res_sum.total_req_quantity,0) - nvl(res_sum.std_total_req_quantity,0)) * res_sum.resource_rate,2)
                                end)  res_methods_var,
                        -- Revision for version 1.30
                        -- =============================
                        -- WIP Res Lot Charges Per Unit
                        -- =============================
                        --   when standard lot size is null then zero
                        --   when res_sum.basis_type is null then zero
                        --   when res_sum.basis_type <> lot (2) then zero
                        --   when the wip usage rate or amount is zero then zero
                        --   when the assembly is not rolled up then zero
                        decode(res_sum.cost_element_id, 4, 0, 
                                case
                                   when cic_assys.lot_size is null then 0
                                   when nvl(res_sum.basis_type, 1) <> 2 then 0
                                   when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
                                   when res_sum.usage_rate_or_amount = 0 then 0
                                   when cic_assys.rolled_up = 'N' then 0
                                   -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                                   when res_sum.status_type in (4,5,7,12,14,15)
                                        then round(res_sum.usage_rate_or_amount * res_sum.resource_rate / (decode(res_sum.quantity_completed, 0, 1, res_sum.quantity_completed) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),5)
                                   when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'Y' -- Released but has completion quantities
                                        then round(res_sum.usage_rate_or_amount * res_sum.resource_rate / (decode(res_sum.quantity_completed, 0, 1, res_sum.quantity_completed) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),5)
                                   when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'N' -- Released but does not has completion quantities
                                        -- Revision for version 1.33
                                        -- then round(res_sum.usage_rate_or_amount * res_sum.resource_rate / res_sum.start_quantity,5)
                                        then round(res_sum.usage_rate_or_amount * res_sum.resource_rate / decode(res_sum.start_quantity, 0, 1, res_sum.start_quantity),5)
                                   -- End revision for version 1.21
                                   -- else round(res_sum.usage_rate_or_amount * res_sum.resource_rate / res_sum.start_quantity,5)
                                   else round(res_sum.usage_rate_or_amount * res_sum.resource_rate / decode(res_sum.start_quantity, 0, 1, res_sum.start_quantity),5)
                                   -- End revision for version 1.33
                                end) wip_res_lot_charges_per_unit,
                        -- =============================
                        -- Standard Res Lot Charges Per Unit
                        -- =============================
                        --   wwhen standard lot size is null then zero
                        --   when res_sum.basis_type is null then zero
                        --   when res_sum.basis_type <> lot (2) then zero
                        --   when the standard usage rate or amount is zero then zero
                        --   when the assembly is not rolled up then zero
                        decode(res_sum.cost_element_id, 4, 0,
                                case
                                   when cic_assys.lot_size is null then 0
                                   when nvl(res_sum.basis_type, 1) <> 2 then 0
                                   when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
                                   when cic_assys.rolled_up = 'N' then 0
                                   when res_sum.std_usage_rate_or_amount = 0 then 0
                                   else round(res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1),5)
                                end) std_res_lot_charges_per_unit,
                        -- End revision for version 1.30
                        -- =============================
                        -- Resource Lot Variance
                        -- =============================
                        -- WIP Setup Charges per unit - Std Setup Charges per unit = Lot Size Variance
                        --   when primary_cost_method is not Frozen (1) then zero
                        --   when standard lot size is null then zero
                        --   when res_sum.basis_type is null then zero
                        --   when res_sum.basis_type <> lot (2) then zero
                        decode(res_sum.cost_element_id, 4, 0, 
                                case
                                   when res_sum.primary_cost_method <> 1 then 0
                                   when cic_assys.lot_size is null then 0
                                   when nvl(res_sum.basis_type, 1) <> 2 then 0
                                   when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
                                   when cic_assys.rolled_up = 'N' then 0
                                   when res_sum.std_usage_rate_or_amount = 0 then 0
                                   when res_sum.status_type in (4,5,7,12,14,15)
                                        then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1) * 
                                                (nvl(res_sum.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),2)
                                   when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'Y' -- Released but has completion quantities
                                        then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1) * 
                                                (nvl(res_sum.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),2)
                                   when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'N' -- Released but has no completion quantities
                                        -- Revision for version 1.29
                                        -- then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1) * res_sum.start_quantity),2)
                                   -- else round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1) * res_sum.start_quantity),2)
                                        then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1) * decode(res_sum.start_quantity, 0, 1, res_sum.start_quantity)),2)
                                   else round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1) * decode(res_sum.start_quantity, 0, 1, res_sum.start_quantity)),2)
                                   -- End revision for version 1.29
                                end) res_lot_var,
                        -- =============================
                        -- OSP Efficiency Variance
                        -- =============================
                        -- Revision for version 1.18
                        decode(res_sum.cost_element_id, 3, 0, round(res_sum.applied_resource_value - res_sum.wip_std_resource_value,2)) osp_efficiency_var,
                        -- =============================
                        -- OSP Methods Variance
                        -- =============================
                        decode(res_sum.cost_element_id, 3, 0, 
                                case
                                   when nvl(res_sum.basis_type, 1) <> 1 then 0
                                   -- when nvl(res_sum.total_req_quantity,0) = 0 then 0
                                   -- when nvl(res_sum.std_total_req_quantity,0) = 0 then 0
                                   -- Add parameter for non-standard jobs.
                                   -- when res_sum.class_type = 3 then 0 -- 3 - non-standard job
                                   when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
                                   -- Zero out the resource efficiency calculation when there are no completions and no applied quantities.
                                   when res_sum.fg_total_qty = 0 and round(res_sum.applied_resource_value,2) = 0
                                        then -1 * (round((res_sum.applied_resource_value - res_sum.wip_std_resource_value),2))
                                   when cic_assys.rolled_up = 'N' then 0
                                   when nvl(res_sum.std_total_req_quantity,0) = 0 and nvl(res_sum.total_req_quantity,0) = 0 then 0
                                   else round((nvl(res_sum.total_req_quantity,0) - nvl(res_sum.std_total_req_quantity,0)) * res_sum.resource_rate,2)
                                end)  osp_methods_var,
                        -- Revision for version 1.30
                        -- =============================
                        -- WIP OSP Lot Charges Per Unit
                        -- =============================
                        --   when standard lot size is null then zero
                        --   when res_sum.basis_type is null then zero
                        --   when res_sum.basis_type <> lot (2) then zero
                        --   when the wip usage rate or amount is zero then zero
                        --   when the assembly is not rolled up then zero
                        decode(res_sum.cost_element_id, 3, 0, 
                                case
                                   when cic_assys.lot_size is null then 0
                                   when nvl(res_sum.basis_type, 1) <> 2 then 0
                                   when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
                                   when res_sum.usage_rate_or_amount = 0 then 0
                                   when cic_assys.rolled_up = 'N' then 0
                                   -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                                   when res_sum.status_type in (4,5,7,12,14,15)
                                        then round(res_sum.usage_rate_or_amount * res_sum.resource_rate / (decode(res_sum.quantity_completed, 0, 1, res_sum.quantity_completed) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),5)
                                   when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'Y' -- Released but has completion quantities
                                        then round(res_sum.usage_rate_or_amount * res_sum.resource_rate / (decode(res_sum.quantity_completed, 0, 1, res_sum.quantity_completed) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),5)
                                   when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'N' -- Released but does not has completion quantities
                                        -- Revision for version 1.33
                                        -- then round(res_sum.usage_rate_or_amount * res_sum.resource_rate / res_sum.start_quantity,5)
                                        then round(res_sum.usage_rate_or_amount * res_sum.resource_rate / decode(res_sum.start_quantity, 0, 1, res_sum.start_quantity),5)
                                   -- End revision for version 1.21
                                   -- else round(res_sum.usage_rate_or_amount * res_sum.resource_rate / res_sum.start_quantity,5)
                                   else round(res_sum.usage_rate_or_amount * res_sum.resource_rate / decode(res_sum.start_quantity, 0, 1, res_sum.start_quantity),5)
                                   -- End revision for version 1.33
                                -- Revision for version 1.34
                                -- end) wip_res_lot_charges_per_unit,
                                end) wip_osp_lot_charges_per_unit,
                        -- =============================
                        -- Standard OSP Lot Charges Per Unit
                        -- =============================
                        --   when standard lot size is null then zero
                        --   when res_sum.basis_type is null then zero
                        --   when res_sum.basis_type <> lot (2) then zero
                        --   when the standard usage rate or amount is zero then zero
                        --   when the assembly is not rolled up then zero
                        decode(res_sum.cost_element_id, 3, 0,
                                case
                                   when cic_assys.lot_size is null then 0
                                   when nvl(res_sum.basis_type, 1) <> 2 then 0
                                   when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
                                   when cic_assys.rolled_up = 'N' then 0
                                   when res_sum.std_usage_rate_or_amount = 0 then 0
                                   else round(res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1),5)
                                -- Revision for version 1.34
                                -- end) std_res_lot_charges_per_unit,
                                end) std_osp_lot_charges_per_unit,
                        -- End revision for version 1.30
                        -- =============================
                        -- OSP Lot Variance
                        -- =============================
                        decode(res_sum.cost_element_id, 3, 0, 
                                case
                                   when res_sum.primary_cost_method <> 1 then 0
                                   when cic_assys.lot_size is null then 0
                                   when nvl(res_sum.basis_type, 1) <> 2 then 0
                                   when res_sum.class_type = 3 and :p_nsj_config_lot_var = 'N' then 0
                                   when cic_assys.rolled_up = 'N' then 0
                                   when res_sum.std_usage_rate_or_amount = 0 then 0
                                   when res_sum.status_type in (4,5,7,12,14,15)
                                        then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1) * 
                                                (nvl(res_sum.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),2)
                                   when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'Y' -- Released but has completion quantities
                                        then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1) * 
                                                (nvl(res_sum.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(res_sum.quantity_scrapped, 0))),2)
                                   when res_sum.quantity_completed <> 0 and :p_use_completion_qtys = 'N' -- Released but has no completion quantities
                                        -- Revision for version 1.33
                                        -- then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1) * res_sum.start_quantity),2)
                                   -- else round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1) * res_sum.start_quantity),2)
                                        then round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1) * decode(res_sum.start_quantity, 0, 1, res_sum.start_quantity)),2)
                                   else round((res_sum.usage_rate_or_amount * res_sum.resource_rate) - (res_sum.std_usage_rate_or_amount * res_sum.resource_rate / nvl(cic_assys.lot_size,1) * decode(res_sum.start_quantity, 0, 1, res_sum.start_quantity)),2)
                                   -- End revision for version 1.33
                                end) osp_lot_var,
                        -- End revision for version 1.18
                        0 ovhd_efficiency_var,
                        -- Revision for version 1.37
                        0 scrap_variance,
                        0 material_variance,
                        0 res_variance,
                        0 osp_variance,
                        0 ovhd_variance,
                        0 total_variance,
                        0 wip_costs_in,
                        0 wip_costs_out,
                        0 wip_relief,
                        0 wip_value,
                        cic_assys.rolled_up,
                        cic_assys.last_rollup_date --,
                        -- Revision for version 1.27 and 1.30
                        -- Removed, not consistent for resources and overheads
                        -- null alternate_designator_code
                 from   mtl_system_items_vl msiv2,
                        mtl_item_status_vl misv2,
                        mtl_units_of_measure_vl muomv2,
                        -- Revision for version 1.23
                        -- fnd_lookups fl,   -- phantom_parent
                        fnd_common_lookups fcl2, -- osp_component_item_type
                        mfg_lookups ml4, -- osp_component_make_buy_code
                        mfg_lookups ml6, -- osp_component_basis_type
                        -- Revision for version 1.19
                        cic_assys,
                        res_sum
                 -- ===========================================
                 -- Item, cost and department joins
                 -- ===========================================
                 where  msiv2.organization_id (+)        = res_sum.organization_id
                 and    msiv2.inventory_item_id (+)      = res_sum.purchase_item_id   -- OSP item
                 and    misv2.inventory_item_status_code (+) = msiv2.inventory_item_status_code
                 and    muomv2.uom_code (+)              = msiv2.primary_uom_code
                 -- These joins get the Item Lot Size
                 and    cic_assys.organization_id (+)    = res_sum.organization_id
                 and    cic_assys.inventory_item_id (+)  = res_sum.primary_item_id
                 and    cic_assys.cost_type_id (+)       = res_sum.primary_cost_method
                 -- ===========================================
                 -- Lookup Codes
                 -- ===========================================
                 and    ml4.lookup_type (+)              = 'MTL_PLANNING_MAKE_BUY'
                 and    ml4.lookup_code (+)              = msiv2.planning_make_buy_code
                 and    ml6.lookup_type                  = 'CST_BASIS'
                 and    ml6.lookup_code                  = res_sum.basis_type
                 -- Revision for version 1.23
                 -- and    fl.lookup_type                   = 'YES_NO'
                 -- and    fl.lookup_code                   = res_sum.phantom_parent
                 -- End revision for version 1.23
                 and    fcl2.lookup_type (+)             = 'ITEM_TYPE'
                 and    fcl2.lookup_code (+)             = msiv2.item_type
                 and    5=5                              -- p_osp_item
                 union all
                 -- ===========================================
                 -- Section III - WIP Overhead Variances
                 -- Inline table select for WIP Overhead Variances
                 -- ===========================================
                 select ovhd_sum.report_type,
                        ovhd_sum.organization_code,
                        ovhd_sum.period_name,
                        ovhd_sum.account,
                        ovhd_sum.class_code,
                        ovhd_sum.class_type,
                        ovhd_sum.wip_entity_id,
                        ovhd_sum.project_id,
                        ovhd_sum.status_type,
                        ovhd_sum.primary_item_id,
                        ovhd_sum.assembly_number,
                        ovhd_sum.assy_description,
                        ovhd_sum.assy_item_type,
                        ovhd_sum.assy_item_status_code,
                        ovhd_sum.assy_uom_code,
                        ovhd_sum.planning_make_buy_code,
                        ovhd_sum.lot_number,
                        -- Revision for version 1.23
                        3  report_sort,
                        ovhd_sum.creation_date,
                        ovhd_sum.scheduled_start_date,
                        ovhd_sum.date_released,
                        ovhd_sum.date_completed,
                        ovhd_sum.date_closed,
                        ovhd_sum.last_update_date,
                        ovhd_sum.std_lot_size,
                        cic_assys.cost_type  lot_size_cost_type,
                        nvl(cic_assys.lot_size, 1) costing_lot_size, 
                        ovhd_sum.start_quantity,
                        ovhd_sum.quantity_completed,
                        ovhd_sum.quantity_scrapped,
                        ovhd_sum.fg_total_qty,
                        ovhd_sum.purchase_item_id inventory_item_id,
                        ovhd_sum.organization_id,
                        msiv2.concatenated_segments osp_item,
                        msiv2.description osp_description,
                        (select poh.segment1
                         from   po_headers_all poh
                         where  poh.po_header_id          = ovhd_sum.po_header_id
                         -- Revision for version 1.33
                         and    rownum                    = 1
                        ) po_number,
                        decode(ovhd_sum.line_num, 0, null, ovhd_sum.line_num) line_number,
                        decode(ovhd_sum.release_num, 0, null, ovhd_sum.release_num) po_release,
                        ovhd_sum.department_id,
                        ovhd_sum.operation_seq_num,
                        ovhd_sum.resource_seq_num  item_or_res_op_seq,
                        ovhd_sum.resource_code item_or_resource,
                        ovhd_sum.description,
                        -- Revision for version 1.24
                        ovhd_sum.res_unit_of_measure resource_uom_code,
                        ovhd_sum.overhead,
                        ovhd_sum.ovhd_description,
                        ml7.meaning ovhd_basis_type,
                        ovhd_sum.ovhd_unit_of_measure,
                        -- Revision for version 1.23
                        -- fl.meaning phantom_parent,
                        fcl2.meaning component_item_type,
                        misv2.inventory_item_status_code component_status_code,
                        ml4.meaning component_make_buy_code,
                        null wip_supply_type,
                        ml6.meaning basis_type,
                        -- Revision for version 1.30
                        null include_in_rollup,
                        ovhd_sum.lot_basis_type,
                        null comp_lot_size,
                        ovhd_sum.lot_basis_cost,
                        -- End revision for version 1.30
                        ovhd_sum.item_basis_type,
                        ovhd_sum.item_basis_cost,
                        ovhd_sum.cost_type,
                        nvl(ovhd_sum.resource_rate,0) item_or_resource_cost,
                        -- Revision for version 1.23
                        ovhd_sum.rate_or_amount,
                        muomv2.uom_code,
                        ovhd_sum.usage_rate_or_amount quantity_per_assembly,
                        ovhd_sum.total_req_quantity,
                        -- Revision for version 1.22
                        (select max(wt.transaction_date)
                         from   wip_transactions wt
                         where  wt.resource_id                = ovhd_sum.overhead_id
                         and    wt.organization_id            = ovhd_sum.organization_id
                         and    wt.wip_entity_id              = ovhd_sum.wip_entity_id
                         and    wt.transaction_type           = 2 -- Moved-Based Overhead Transaction
                         and    wt.transaction_date           < ovhd_sum.schedule_close_date + 1
                         -- Revision for version 1.33
                         and    rownum                        = 1
                        ) last_txn_date,
                        -- End revision for version 1.22
                        ovhd_sum.applied_resource_units quantity_issued,
                        ovhd_sum.wip_std_resource_value wip_std_comp_or_res_value,
                        ovhd_sum.applied_resource_value applied_comp_or_res_value,
                        round(ovhd_sum.std_usage_rate_or_amount,3) std_quantity_per_assembly,
                        round(ovhd_sum.std_total_req_quantity,3) std_total_req_quantity,
                        ovhd_sum.wip_std_overhead_value wip_std_overhead_value,
                        0 matl_usage_var,
                        0 matl_config_var,
                        -- Revision for version 1.30
                        0 wip_matl_lot_charges_per_unit,
                        0 std_matl_lot_charges_per_unit,
                        -- End revision for version 1.30
                        0 matl_lot_var,
                        0 res_efficiency_var,
                        0 res_methods_var,
                        -- Revision for version 1.30
                        0 wip_res_lot_charges_per_unit,
                        0 std_res_lot_charges_per_unit,
                        -- End revision for version 1.30
                        0 res_lot_var,
                        -- Revision for version 1.18
                        0 osp_efficiency_var,
                        0 osp_methods_var,
                        -- Revision for version 1.30
                        0 wip_osp_lot_charges_per_unit,
                        0 std_osp_lot_charges_per_unit,
                        -- End revision for version 1.30
                        0 osp_lot_var,
                        -- End revision for version 1.18
                        ovhd_sum.ovhd_efficiency_var,
                        -- Revision for version 1.37
                        0 scrap_variance,
                        0 material_variance,
                        0 res_variance,
                        0 osp_variance,
                        0 ovhd_variance,
                        0 total_variance,
                        0 wip_costs_in,
                        0 wip_costs_out,
                        0 wip_relief,
                        0 wip_value,
                        cic_assys.rolled_up,
                        cic_assys.last_rollup_date --,
                        -- Revision for version 1.27 and 1.30
                        -- Removed, not consistent for resources and overheads
                        -- null alternate_designator_code
                from    mtl_system_items_vl msiv2,
                        mtl_item_status_vl misv2,
                        mtl_units_of_measure_vl muomv2,
                        -- Revision for version 1.23
                        -- fnd_lookups fl,   -- phantom_parent
                        fnd_common_lookups fcl2, -- osp_component_item_type
                        mfg_lookups ml4, -- osp_component_make_buy_code
                        mfg_lookups ml6, -- osp_component_basis_type
                        mfg_lookups ml7, -- ovhd_basis_type
                        -- Revision for version 1.19
                        cic_assys,
                        -- ========================================================
                        -- Get the WIP Overhead Information in a multipart union
                        -- which is then condensed into a summary data set
                        -- ========================================================
                        -- ========================================================
                        -- Condense into a summary data set.
                        -- =======================================================
                        (select ovhd.report_type,
                                ovhd.period_name,
                                ovhd.organization_code,
                                ovhd.organization_id,
                                ovhd.primary_cost_method,
                                ovhd.account,
                                ovhd.class_code,
                                ovhd.class_type,
                                ovhd.wip_entity_id,
                                ovhd.project_id,
                                ovhd.status_type,
                                ovhd.primary_item_id,
                                ovhd.assembly_number,
                                ovhd.assy_description,
                                ovhd.assy_item_type,
                                ovhd.assy_item_status_code,
                                ovhd.assy_uom_code,
                                ovhd.planning_make_buy_code,
                                ovhd.std_lot_size,
                                ovhd.lot_number,
                                ovhd.creation_date,
                                ovhd.scheduled_start_date,
                                ovhd.date_released,
                                ovhd.date_completed,
                                ovhd.date_closed,
                                -- Revision for version 1.22
                                ovhd.schedule_close_date,
                                ovhd.last_update_date,
                                ovhd.start_quantity,
                                ovhd.quantity_completed,
                                ovhd.quantity_scrapped,
                                ovhd.fg_total_qty,
                                max(ovhd.po_header_id) po_header_id,
                                max(ovhd.line_num) line_num,
                                max(ovhd.release_num) release_num,
                                max(ovhd.purchase_item_id) purchase_item_id,
                                ovhd.department_id,
                                ovhd.operation_seq_num,
                                null wip_supply_type,
                                -- Revision for version 1.23
                                -- 'N' phantom_parent,
                                ovhd.resource_seq_num,
                                -- Revision for version 1.22
                                ovhd.resource_id,
                                ovhd.resource_code,
                                ovhd.description,
                                ovhd.basis_type,
                                ovhd.res_unit_of_measure,
                                -- Revision for version 1.22
                                ovhd.overhead_id,
                                ovhd.overhead,
                                ovhd.ovhd_description,
                                ovhd.ovhd_basis_type,
                                ovhd.ovhd_unit_of_measure,
                                max(ovhd.po_unit_price) po_unit_price,
                                decode(ovhd.basis_type, 2, 'Y', 'N') lot_basis_type,
                                decode(ovhd.basis_type, 2, ovhd.resource_rate, 0) lot_basis_cost,
                                decode(ovhd.basis_type, 1, 'Y', 'N') item_basis_type,
                                decode(ovhd.basis_type, 1, ovhd.resource_rate, 0) item_basis_cost,
                                ovhd.cost_type,
                                ovhd.resource_rate,
                                sum(ovhd.usage_rate_or_amount) usage_rate_or_amount,
                                sum(ovhd.total_req_quantity) total_req_quantity,
                                sum(ovhd.applied_resource_units) applied_resource_units,
                                sum(ovhd.wip_std_resource_value) wip_std_resource_value,
                                sum(ovhd.applied_resource_value) applied_resource_value,
                                sum(ovhd.std_usage_rate_or_amount) std_usage_rate_or_amount,
                                sum(ovhd.std_total_req_quantity) std_total_req_quantity,
                                ovhd.rate_or_amount,
                                sum(ovhd.wip_std_overhead_value) wip_std_overhead_value,
                                sum(ovhd.ovhd_efficiency_var) ovhd_efficiency_var
                                from   -- ========================================================
                                        -- Section III.A.OSP
                                        -- First get the OSP resource overhead information with the
                                        -- related PO number and unit price information
                                        -- =======================================================
                                        -- Revision for version 1.36
                                        (select 'III.A' section,
                                                res_sum.report_type,
                                                res_sum.period_name,
                                                res_sum.organization_code,
                                                res_sum.organization_id,
                                                res_sum.primary_cost_method,
                                                wdj.overhead_account account,
                                                res_sum.class_code,
                                                res_sum.class_type,
                                                res_sum.wip_entity_id,
                                                res_sum.project_id,
                                                res_sum.status_type,
                                                res_sum.primary_item_id,
                                                res_sum.assembly_number,
                                                res_sum.assy_description,
                                                res_sum.assy_item_type,
                                                res_sum.assy_item_status_code,
                                                res_sum.assy_uom_code,
                                                res_sum.planning_make_buy_code,
                                                res_sum.std_lot_size,
                                                res_sum.lot_number,
                                                res_sum.creation_date,
                                                res_sum.scheduled_start_date,
                                                res_sum.date_released,
                                                res_sum.date_completed,
                                                res_sum.date_closed,
                                                -- Revision for version 1.22
                                                res_sum.schedule_close_date,
                                                res_sum.last_update_date,
                                                res_sum.start_quantity,
                                                res_sum.quantity_completed,
                                                res_sum.quantity_scrapped,
                                                res_sum.fg_total_qty,
                                                res_sum.purchase_item_id,
                                                poh.po_header_id,
                                                pol.line_num,
                                                pr.release_num,
                                                res_sum.department_id,
                                                res_sum.operation_seq_num,
                                                -- Revision for version 1.36
                                                -- wo.operation_sequence_id,
                                                res_sum.resource_seq_num,
                                                -- Revision for version 1.22
                                                res_sum.resource_id,
                                                res_sum.resource_code,
                                                res_sum.description,
                                                res_sum.basis_type,
                                                res_sum.res_unit_of_measure,
                                                -- Revision for version 1.22
                                                br_ovhd.resource_id overhead_id,
                                                br_ovhd.resource_code overhead,
                                                br_ovhd.description ovhd_description,
                                                cdo.basis_type ovhd_basis_type,
                                                br_ovhd.unit_of_measure ovhd_unit_of_measure,
                                                nvl(pll.price_override, pol.unit_price) po_unit_price,
                                                res_sum.cost_type,
                                                res_sum.resource_rate,
                                                res_sum.usage_rate_or_amount,
                                                res_sum.total_req_quantity,
                                                res_sum.applied_resource_units,
                                                res_sum.wip_std_resource_value, -- at std_basis_factor
                                                res_sum.applied_resource_value,
                                                0 std_usage_rate_or_amount, -- per the Std BOM
                                                0 std_total_req_quantity, -- per the Std BOM
                                                cdo.rate_or_amount,
                                                -- ==========================================================================================
                                                -- WIP Std Overhead Value = WIP Standard Resource Units or Value * Overhead Rate or Amount
                                                -- ==========================================================================================
                                                round(nvl(cdo.rate_or_amount,0) *
                                                                decode(cdo.basis_type,
                                                                        3, res_sum.total_req_quantity,  -- resource units
                                                                        4, res_sum.wip_std_resource_value, -- resource Value
                                                                        0
                                                                      )
                                                   ,2) wip_std_overhead_value,
                                                -- ==========================================================================================
                                                -- Overhead Efficiency Variance = WIP Applied Overhead Value - WIP Standard Overhead Value
                                                -- ==========================================================================================
                                                -- WIP Applied Overhead Value
                                                round(nvl(cdo.rate_or_amount,0) *
                                                                decode(cdo.basis_type,
                                                                        3, res_sum.applied_resource_units,
                                                                        4, res_sum.applied_resource_value,
                                                                        0
                                                                      )
                                                   ,2) - 
                                                -- WIP Standard Overhead Value
                                                round(nvl(cdo.rate_or_amount,0) *
                                                                decode(cdo.basis_type,
                                                                        3, res_sum.total_req_quantity,  -- resource units
                                                                        4, res_sum.wip_std_resource_value, -- resource Value
                                                                        0
                                                                      )
                                                   ,2) ovhd_efficiency_var
                                         from   -- Revision for version 1.36
                                                -- wip_operations wo,
                                                -- wip_operation_resources wor,
                                                -- bom_resources br,
                                                wdj,
                                                res_sum,
                                                -- End revision for version 1.36
                                                po_headers_all poh,
                                                po_lines_all pol,
                                                po_line_locations_all pll,
                                                po_releases_all pr,
                                                po_distributions_all pod,
                                                -- Get the Resource_Cost_Type, Cost Basis_Type and Resource_Rates
                                                bom_resources br_ovhd,
                                                -- Revision for version 1.19
                                                crc,
                                                cdo,
                                                cro
                                         -- ===========================================
                                         -- WIP_Job Entity, Routing, PO and Resource Cost Joins
                                         -- ===========================================
                                         where  poh.po_header_id          = pod.po_header_id
                                         and    pol.po_line_id            = pod.po_line_id
                                         and    pll.line_location_id      = pod.line_location_id
                                         and    pod.po_release_id         = pr.po_release_id (+)
                                         and    res_sum.wip_entity_id     = wdj.wip_entity_id
                                         and    res_sum.organization_id   = wdj.organization_id
                                         and    res_sum.wip_entity_id     = pod.wip_entity_id
                                         and    res_sum.resource_id       = pod.bom_resource_id
                                         and    res_sum.resource_seq_num  = pod.wip_resource_seq_num
                                         and    res_sum.operation_seq_num = pod.wip_operation_seq_num
                                         and    res_sum.organization_id   = pod.destination_organization_id
                                         -- Only select OSP resources
                                         and    res_sum.purchase_item_id is not null
                                         and    crc.resource_id (+)       = res_sum.resource_id
                                         and    crc.organization_id (+)   = res_sum.organization_id
                                         and    cro.resource_id           = res_sum.resource_id
                                         and    cdo.department_id         = res_sum.department_id
                                         -- End revision for version 1.36
                                         and    cro.overhead_id           = cdo.overhead_id
                                         -- Revision for version 1.19
                                         and    cdo.basis_type in (3,4)
                                         and    br_ovhd.resource_id       = cdo.overhead_id
                                         union all
                                         -- =======================================================
                                         -- Section III.B. Non-OSP
                                         -- Now get the non-OSP resource information
                                         -- =======================================================
                                         select 'III.B' section,
                                                res_sum.report_type,
                                                res_sum.period_name,
                                                res_sum.organization_code,
                                                res_sum.organization_id,
                                                res_sum.primary_cost_method,
                                                wdj.overhead_account account,
                                                res_sum.class_code,
                                                res_sum.class_type,
                                                res_sum.wip_entity_id,
                                                res_sum.project_id,
                                                res_sum.status_type,
                                                res_sum.primary_item_id,
                                                res_sum.assembly_number,
                                                res_sum.assy_description,
                                                res_sum.assy_item_type,
                                                res_sum.assy_item_status_code,
                                                res_sum.assy_uom_code,
                                                res_sum.planning_make_buy_code,
                                                res_sum.std_lot_size,
                                                res_sum.lot_number,
                                                res_sum.creation_date,
                                                res_sum.scheduled_start_date,
                                                res_sum.date_released,
                                                res_sum.date_completed,
                                                res_sum.date_closed,
                                                -- Revision for version 1.22
                                                res_sum.schedule_close_date,
                                                res_sum.last_update_date,
                                                res_sum.start_quantity,
                                                res_sum.quantity_completed,
                                                res_sum.quantity_scrapped,
                                                res_sum.fg_total_qty,
                                                0 purchase_item_id,
                                                0 po_header_id,
                                                0 line_num,
                                                0 release_num,
                                                res_sum.department_id,
                                                res_sum.operation_seq_num,
                                                -- Revision for version 1.36
                                                -- wo.operation_sequence_id,
                                                res_sum.resource_seq_num,
                                                -- Revision for version 1.22
                                                res_sum.resource_id,
                                                res_sum.resource_code,
                                                res_sum.description,
                                                res_sum.basis_type,
                                                res_sum.res_unit_of_measure,
                                                -- Revision for version 1.22
                                                br_ovhd.resource_id overhead_id,
                                                br_ovhd.resource_code overhead,
                                                br_ovhd.description ovhd_description,
                                                cdo.basis_type ovhd_basis_type,
                                                br_ovhd.unit_of_measure ovhd_unit_of_measure,
                                                0 po_unit_price,
                                                res_sum.cost_type,
                                                res_sum.resource_rate,
                                                res_sum.usage_rate_or_amount,
                                                res_sum.total_req_quantity,
                                                res_sum.applied_resource_units,
                                                res_sum.wip_std_resource_value, -- at std_basis_factor
                                                res_sum.applied_resource_value,
                                                0 std_usage_rate_or_amount, -- per the Std BOM
                                                0 std_total_req_quantity, -- per the Std BOM
                                                cdo.rate_or_amount,
                                                -- ==========================================================================================
                                                -- WIP Std Overhead Value = WIP Standard Resource Units or Value * Overhead Rate or Amount
                                                -- ==========================================================================================
                                                round(nvl(cdo.rate_or_amount,0) *
                                                                decode(cdo.basis_type,
                                                                        3, res_sum.total_req_quantity,  -- resource units
                                                                        4, res_sum.wip_std_resource_value, -- resource Value
                                                                        0
                                                                      )
                                                   ,2) wip_std_overhead_value,
                                                -- ==========================================================================================
                                                -- Overhead Efficiency Variance = WIP Applied Overhead Value - WIP Standard Overhead Value
                                                -- ==========================================================================================
                                                -- WIP Applied Overhead Value
                                                round(nvl(cdo.rate_or_amount,0) *
                                                                decode(cdo.basis_type,
                                                                        3, res_sum.applied_resource_units,
                                                                        4, res_sum.applied_resource_value,
                                                                        0
                                                                      )
                                                   ,2) - 
                                                -- WIP Standard Overhead Value
                                                round(nvl(cdo.rate_or_amount,0) *
                                                                decode(cdo.basis_type,
                                                                        3, res_sum.total_req_quantity,  -- resource units
                                                                        4, res_sum.wip_std_resource_value, -- resource Value
                                                                        0
                                                                      )
                                                   ,2) ovhd_efficiency_var
                                         from   -- Revision for version 1.36
                                                -- wip_operations wo,
                                                -- wip_operation_resources wor,
                                                -- bom_resources br,
                                                wdj,
                                                res_sum,
                                                -- End revision for version 1.36
                                                -- Get the Resource_Cost_Type, Cost Basis_Type and Resource_Rates
                                                bom_resources br_ovhd,
                                                -- Get the resource rates
                                                -- Revision for version 1.19
                                                crc,
                                                cdo,
                                                cro
                                         -- ===========================================
                                         -- WIP_Job Entity, Class and Period joins
                                         -- ===========================================
                                         -- Revision for version 1.19
                                         where  res_sum.wip_entity_id         = wdj.wip_entity_id
                                         and    res_sum.organization_id       = wdj.organization_id
                                         and    cdo.basis_type in (3, 4)
                                         -- Only select non-OSP resources
                                         and    res_sum.purchase_item_id is null
                                         and    crc.resource_id (+)       = res_sum.resource_id
                                         and    crc.organization_id (+)   = res_sum.organization_id
                                         and    cro.resource_id           = res_sum.resource_id
                                         and    cdo.department_id         = res_sum.department_id
                                         -- End revision for version 1.36
                                         and    cro.overhead_id           = cdo.overhead_id
                                         -- Revision for version 1.19
                                         and    cdo.basis_type in (3,4)
                                         and    br_ovhd.resource_id       = cdo.overhead_id
                                         union all
                                         -- ========================================================
                                         -- Section III.C. Move-Based Overheads
                                         -- =======================================================
                                         select 'III.C' section,
                                                wdj.report_type,
                                                wdj.period_name,
                                                wdj.organization_code,
                                                wdj.organization_id,
                                                wdj.primary_cost_method,
                                                wdj.overhead_account account,
                                                wdj.class_code,
                                                wdj.class_type,
                                                wdj.wip_entity_id,
                                                wdj.project_id,
                                                wdj.status_type,
                                                wdj.primary_item_id,
                                                wdj.assembly_number,
                                                wdj.assy_description,
                                                wdj.assy_item_type,
                                                wdj.assy_item_status_code,
                                                wdj.assy_uom_code,
                                                wdj.planning_make_buy_code,
                                                wdj.std_lot_size,
                                                wdj.lot_number,
                                                wdj.creation_date,
                                                wdj.scheduled_start_date,
                                                wdj.date_released,
                                                wdj.date_completed,
                                                wdj.date_closed,
                                                -- Revision for version 1.22
                                                wdj.schedule_close_date,
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
                                                -- Revision for version 1.36
                                                -- wo.operation_sequence_id,
                                                null resource_seq_num,
                                                -- Revision for version 1.22
                                                null resource_id,
                                                null resource_code,
                                                null description,
                                                cdo.basis_type,
                                                null res_unit_of_measure,
                                                -- Revision for version 1.22
                                                br_ovhd.resource_id overhead_id,
                                                br_ovhd.resource_code overhead,
                                                br_ovhd.description ovhd_description,
                                                cdo.basis_type ovhd_basis_type,
                                                br_ovhd.unit_of_measure ovhd_unit_of_measure,
                                                null po_unit_price,
                                                cdo.cost_type cost_type,
                                                null resource_rate,
                                                null usage_rate_or_amount,
                                                -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                                                -- If the wdj.status_type in (4,5,7,12,14,15) then use the quantity completed else use the p_use_completion_qtys parameter
                                                -- And use the completions plus scrap quantities unless for lot-based jobs
                                                nvl(round(case
                                                        when wdj.status_type in (4,5,7,12,14,15) then
                                                                decode(cdo.basis_type,
                                                                        2, decode(wdj.quantity_completed + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0)), 0, 0, 1), -- Lot
                                                                        1, decode(wdj.class_type,                                                                                                -- Item
                                                                                        5, nvl(wdj.quantity_completed, 0),
                                                                                           nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                                 )
                                                                      )
                                                        when wdj.status_type not in (4,5,7,12,14,15) and :p_use_completion_qtys = 'Y' then
                                                                decode(cdo.basis_type,
                                                                        2, decode(wdj.quantity_completed + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0)), 0, 0, 1), -- Lot
                                                                        1, decode(wdj.class_type,                                                                                                -- Item
                                                                                        5, nvl(wdj.quantity_completed, 0),
                                                                                           nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                                 )
                                                                      )
                                                        when wdj.status_type not in (4,5,7,12,14,15) and :p_use_completion_qtys = 'N' then
                                                                decode(cdo.basis_type,
                                                                        2, decode(nvl(wdj.start_quantity, 0), 0, 0, 1),                                                                          -- Lot
                                                                        1, nvl(wdj.start_quantity, 0)                                                                                            -- Item
                                                                      )
                                                        else 0
                                                        end
                                                ,6),0) total_req_quantity,
                                                -- Revision for version 1.23
                                                -- 0 applied_resource_units,
                                                decode(cdo.basis_type,
                                                        1, nvl(wo.quantity_completed, 0),        -- Item
                                                        2, decode(wo.quantity_completed,0,0,1)   -- Lot
                                                      ) applied_resource_units,
                                                -- End revision for version 1.23
                                                -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                                                -- If the wdj.status_type in (4,5,7,12,14,15) then use the quantity completed else use the p_use_completion_qtys parameter
                                                -- And use the completions plus scrap quantities unless for lot-based jobs
                                                -- Get the total required quantity
                                                nvl(round(case
                                                        when wdj.status_type in (4,5,7,12,14,15) then
                                                                decode(cdo.basis_type,
                                                                        2, decode(wdj.quantity_completed + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0)), 0, 0, 1), -- Lot
                                                                        1, decode(wdj.class_type,                                                                                                -- Item
                                                                                        5, nvl(wdj.quantity_completed, 0),
                                                                                           nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                                 )
                                                                      )
                                                        when wdj.status_type not in (4,5,7,12,14,15) and :p_use_completion_qtys = 'Y' then
                                                                decode(cdo.basis_type,
                                                                        2, decode(wdj.quantity_completed + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0)), 0, 0, 1), -- Lot
                                                                        1, decode(wdj.class_type,                                                                                                -- Item
                                                                                        5, nvl(wdj.quantity_completed, 0),
                                                                                           nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                                 )
                                                                      )
                                                        when wdj.status_type not in (4,5,7,12,14,15) and :p_use_completion_qtys = 'N' then
                                                                decode(cdo.basis_type,
                                                                        2, decode(nvl(wdj.start_quantity, 0), 0, 0, 1),                                                                          -- Lot
                                                                        1, nvl(wdj.start_quantity, 0)                                                                                            -- Item
                                                                      )
                                                        else 0
                                                        end
                                                ,2),0) wip_std_resource_value,  -- std_bas_fctr
                                                round(decode(cdo.basis_type,
                                                                1, nvl(wo.quantity_completed, 0),        -- Item
                                                                2, decode(wo.quantity_completed,0,0,1)   -- Lot
                                                            ) * cdo.rate_or_amount,2) applied_resource_value,
                                                0 std_usage_rate_or_amount, -- per the Std BOM
                                                0 std_total_req_quantity, -- per the Std BOM
                                                cdo.rate_or_amount,
                                                -- =======================
                                                -- wip_std_overhead_value
                                                -- =======================
                                                -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                                                -- If the wdj.status_type in (4,5,7,12,14,15) then use the quantity completed else use the p_use_completion_qtys parameter
                                                -- use the completions plus scrap quantities unless for lot-based jobs
                                                -- Get the total required quantity
                                                nvl(round(case
                                                        when wdj.status_type in (4,5,7,12,14,15) then
                                                                decode(cdo.basis_type,
                                                                        2, decode(wdj.quantity_completed + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0)), 0, 0, 1), -- Lot
                                                                        1, decode(wdj.class_type,                                                                                                -- Item
                                                                                        5, nvl(wdj.quantity_completed, 0),
                                                                                           nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                                 )
                                                                      )
                                                        when wdj.status_type not in (4,5,7,12,14,15) and :p_use_completion_qtys = 'Y' then
                                                                decode(cdo.basis_type,
                                                                        2, decode(wdj.quantity_completed + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0)), 0, 0, 1), -- Lot
                                                                        1, decode(wdj.class_type,                                                                                                -- Item
                                                                                        5, nvl(wdj.quantity_completed, 0),
                                                                                           nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                                 )
                                                                      )
                                                        when wdj.status_type not in (4,5,7,12,14,15) and :p_use_completion_qtys = 'N' then
                                                                decode(cdo.basis_type,
                                                                        2, decode(nvl(wdj.start_quantity, 0), 0, 0, 1),                                                                          -- Lot
                                                                        1, nvl(wdj.start_quantity, 0)                                                                                            -- Item
                                                                      )
                                                        else 0
                                                        end
                                                        * nvl(cdo.rate_or_amount,0)
                                                ,2),0) wip_std_overhead_value,
                                                -- ==========================================================================================
                                                -- Overhead Efficiency Variance = WIP Applied Overhead Value - WIP Standard Overhead Value
                                                -- ==========================================================================================
                                                -- WIP Applied Overhead Value
                                                nvl(round(decode(cdo.basis_type,
                                                                1, nvl(wo.quantity_completed, 0),        -- Item
                                                                2, decode(wo.quantity_completed,0,0,1)   -- Lot
                                                            ) * cdo.rate_or_amount - 
                                                -- WIP Standard Overhead Value
                                                   case
                                                        when wdj.status_type in (4,5,7,12,14,15) then
                                                                decode(cdo.basis_type,
                                                                        2, decode(wdj.quantity_completed + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0)), 0, 0, 1), -- Lot
                                                                        1, decode(wdj.class_type,                                                                                                -- Item
                                                                                        5, nvl(wdj.quantity_completed, 0),
                                                                                           nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                                 )
                                                                      )
                                                        when wdj.status_type not in (4,5,7,12,14,15) and :p_use_completion_qtys = 'Y' then
                                                                decode(cdo.basis_type,
                                                                        2, decode(wdj.quantity_completed + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0)), 0, 0, 1), -- Lot
                                                                        1, decode(wdj.class_type,                                                                                                -- Item
                                                                                        5, nvl(wdj.quantity_completed, 0),
                                                                                           nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wdj.quantity_scrapped, 0))
                                                                                 )
                                                                      )
                                                        when wdj.status_type not in (4,5,7,12,14,15) and :p_use_completion_qtys = 'N' then
                                                                decode(cdo.basis_type,
                                                                        2, decode(nvl(wdj.start_quantity, 0), 0, 0, 1),                                                                          -- Lot
                                                                        1, nvl(wdj.start_quantity, 0)                                                                                            -- Item
                                                                      )
                                                        else 0
                                                   end
                                                   * nvl(cdo.rate_or_amount,0)
                                                ,2),0) ovhd_efficiency_var
                                         from   wdj,
                                                wip_operations wo,
                                                -- Get the Resource Cost Type, Cost Basis Type and Resource Rates
                                                bom_resources br_ovhd,
                                                -- Revision for version 1.19
                                                cdo
                                         -- ===========================================
                                         -- WIP_Job Entity, Class and Period joins
                                         -- ===========================================
                                         where  wo.wip_entity_id          = wdj.wip_entity_id
                                         and    wo.organization_id        = wdj.organization_id
                                         and    wo.department_id          = cdo.department_id
                                         and    br_ovhd.resource_id       = cdo.overhead_id
                                         -- Revision for version 1.19
                                         and    cdo.basis_type in (1,2)
                                        ) ovhd
                        group by
                                ovhd.report_type,
                                ovhd.period_name,
                                ovhd.organization_code,
                                ovhd.organization_id,
                                ovhd.primary_cost_method,
                                ovhd.account,
                                ovhd.class_code,
                                ovhd.class_type,
                                ovhd.wip_entity_id,
                                ovhd.project_id,
                                ovhd.status_type,
                                ovhd.primary_item_id,
                                ovhd.assembly_number,
                                ovhd.assy_description,
                                ovhd.assy_item_type,
                                ovhd.assy_item_status_code,
                                ovhd.assy_uom_code,
                                ovhd.planning_make_buy_code,
                                ovhd.std_lot_size,
                                ovhd.lot_number,
                                ovhd.creation_date,
                                ovhd.scheduled_start_date,
                                ovhd.date_released,
                                ovhd.date_completed,
                                ovhd.date_closed,
                                ovhd.schedule_close_date,
                                ovhd.last_update_date,
                                ovhd.start_quantity,
                                ovhd.quantity_completed,
                                ovhd.quantity_scrapped,
                                ovhd.fg_total_qty,
                                ovhd.department_id,
                                ovhd.operation_seq_num,
                                null, -- wip_supply_type
                                -- Revision for version 1.23
                                -- 'N', -- phantom_parent
                                ovhd.resource_seq_num,
                                -- Revision for version 1.22
                                ovhd.resource_id,
                                ovhd.resource_code,
                                ovhd.description,
                                ovhd.basis_type,
                                ovhd.res_unit_of_measure,
                                -- Revision for version 1.22
                                ovhd.overhead_id,
                                ovhd.overhead,
                                ovhd.ovhd_description,
                                ovhd.ovhd_basis_type,
                                ovhd.ovhd_unit_of_measure,
                                decode(ovhd.basis_type, 2, 'Y', 'N'), -- lot_basis_type
                                decode(ovhd.basis_type, 2, ovhd.resource_rate, 0), -- lot_basis_cost
                                decode(ovhd.basis_type, 1, 'Y', 'N'), -- item_basis_type
                                decode(ovhd.basis_type, 1, ovhd.resource_rate, 0), -- item_basis_cost
                                ovhd.cost_type,
                                ovhd.resource_rate,
                                ovhd.rate_or_amount
                        ) ovhd_sum
                 -- ===========================================
                 -- Account, cost and department joins
                 -- ===========================================
                 where  msiv2.organization_id (+)        = ovhd_sum.organization_id
                 and    msiv2.inventory_item_id (+)      = ovhd_sum.purchase_item_id   -- OSP item
                 and    misv2.inventory_item_status_code (+) = msiv2.inventory_item_status_code
                 and    muomv2.uom_code (+)              = msiv2.primary_uom_code        
                 -- These joins get the Item Lot Size
                 and    cic_assys.organization_id (+)    = ovhd_sum.organization_id
                 and    cic_assys.inventory_item_id (+)  = ovhd_sum.primary_item_id
                 and    cic_assys.cost_type_id (+)       = ovhd_sum.primary_cost_method
                 -- ===========================================
                 -- Lookup Codes
                 -- ===========================================
                 and    ml4.lookup_type (+)              = 'MTL_PLANNING_MAKE_BUY'
                 and    ml4.lookup_code (+)              = msiv2.planning_make_buy_code
                 and    ml6.lookup_type                  = 'CST_BASIS'
                 and    ml6.lookup_code                  = ovhd_sum.basis_type
                 and    ml7.lookup_type                  = 'CST_BASIS'
                 and    ml7.lookup_code                  = ovhd_sum.ovhd_basis_type
                 -- Revision for version 1.23
                 -- and    fl.lookup_type                   = 'YES_NO'
                 -- and    fl.lookup_code                   = ovhd_sum.phantom_parent
                 and    fcl2.lookup_type (+)             = 'ITEM_TYPE'
                 and    fcl2.lookup_code (+)             = msiv2.item_type
                 and    5=5                              -- p_osp_item
                 union all
                 -- ===========================================
                 -- Section IV - WIP Balances
                 -- Inline table select for WIP Period Balances
                 -- ===========================================
                 select wdj.report_type,
                        wdj.organization_code,
                        wdj.period_name,
                        wdj.overhead_account account,
                        wdj.class_code,
                        wdj.class_type,
                        wdj.wip_entity_id,
                        wdj.project_id,
                        wdj.status_type,
                        wdj.primary_item_id,
                        wdj.assembly_number,
                        wdj.assy_description,
                        wdj.assy_item_type,
                        wdj.assy_item_status_code,
                        wdj.assy_uom_code,
                        wdj.planning_make_buy_code,
                        wdj.lot_number,
                        -- Revision for version 1.23
                        4  report_sort,
                        wdj.creation_date,
                        wdj.scheduled_start_date,
                        wdj.date_released,
                        wdj.date_completed,
                        wdj.date_closed,
                        wdj.last_update_date,
                        wdj.std_lot_size,
                        cic_assys.cost_type  lot_size_cost_type,
                        nvl(cic_assys.lot_size, 1) costing_lot_size, 
                        wdj.start_quantity,
                        wdj.quantity_completed,
                        wdj.quantity_scrapped,
                        nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                        null inventory_item_id,
                        wdj.organization_id,
                        null osp_item,
                        null osp_description,
                        null po_number,
                        null line_number,
                        null po_release,
                        null department_id,
                        null operation_seq_num,
                        null item_or_res_op_seq,
                        null item_or_resource,
                        null description,
                        -- Revision for version 1.24
                        null resource_uom_code,
                        null overhead,
                        null ovhd_description,
                        null ovhd_basis_type,
                        null ovhd_unit_of_measure,
                        -- Revision for version 1.23
                        -- null phantom_parent,
                        null component_item_type,
                        null component_status_code,
                        null component_make_buy_code,
                        null wip_supply_type,
                        null basis_type,
                        -- Revision for version 1.30
                        null include_in_rollup,
                        null lot_basis_type,
                        null comp_lot_size,
                        null lot_basis_cost,
                        -- End revision for version 1.30
                        null item_basis_type,
                        null item_basis_cost,
                        cic_assys.cost_type,
                        null item_or_resource_cost,
                        -- Revision for version 1.23
                        null rate_or_amount,
                        null uom_code,
                        0 quantity_per_assembly,
                        0 total_req_quantity,
                        -- Revision for version 1.22
                        null last_txn_date,
                        0 quantity_issued,
                        0 wip_std_comp_or_res_value,
                        0 applied_comp_or_res_value,
                        0 std_quantity_per_assembly,
                        0 std_total_req_quantity,
                        0 wip_std_overhead_value,
                        0 matl_usage_var,
                        0 matl_config_var,
                        -- Revision for version 1.30
                        0 wip_matl_lot_charges_per_unit,
                        0 std_matl_lot_charges_per_unit,
                        -- End revision for version 1.30
                        0 matl_lot_var,
                        0 res_efficiency_var,
                        0 res_methods_var,
                        -- Revision for version 1.30
                        0 wip_res_lot_charges_per_unit,
                        0 std_res_lot_charges_per_unit,
                        -- End revision for version 1.30
                        0 res_lot_var,
                        -- Revision for version 1.18
                        0 osp_efficiency_var,
                        0 osp_methods_var,
                        -- Revision for version 1.30
                        0 wip_osp_lot_charges_per_unit,
                        0 std_osp_lot_charges_per_unit,
                        -- End revision for version 1.30
                        0 osp_lot_var, 
                        -- End revision for version 1.18
                        0 ovhd_efficiency_var,
                        -- Revision for version 1.37
                        0 scrap_variance,
                        -- Revision for version 1.36
                        -- Material gets both TL and PL, Res, OSP and Ovhd only TL
                        sum(nvl(tl_scrap_in,0)+
                            nvl(pl_material_in,0)+
                            nvl(pl_material_overhead_in,0)+
                            nvl(pl_resource_in,0)+
                            nvl(pl_outside_processing_in,0)+
                            nvl(pl_overhead_in,0)-
                            nvl(tl_scrap_out,0)-
                            nvl(tl_material_out,0)-
                            nvl(pl_material_out,0)-
                            nvl(tl_material_overhead_out,0)-
                            nvl(pl_material_overhead_out,0)-
                            nvl(pl_resource_out,0)-
                            nvl(pl_outside_processing_out,0)-
                            nvl(pl_overhead_out,0)) material_variance,
                        sum(nvl(tl_resource_in,0)-
                            nvl(tl_resource_out,0)) res_variance,
                        sum(nvl(tl_outside_processing_in,0)-
                            nvl(tl_outside_processing_out,0)) osp_variance,
                        sum(nvl(tl_overhead_in,0)-
                            nvl(tl_overhead_out,0)) ovhd_variance,
                        -- End revision for version 1.36
                        -- wip_costs_in minus wip_costs_out = total_variance
                        -- wip_costs_in
                        sum(nvl(tl_scrap_in,0)+
                            nvl(pl_material_in,0)+
                            nvl(pl_material_overhead_in,0)+
                            nvl(tl_resource_in,0)+
                            nvl(pl_resource_in,0)+
                            nvl(tl_outside_processing_in,0)+
                            nvl(pl_outside_processing_in,0)+
                            nvl(tl_overhead_in,0)+
                            nvl(pl_overhead_in,0)) -
                        -- wip_costs_out
                        sum(nvl(tl_scrap_out,0)+
                            nvl(tl_material_out,0)+
                            nvl(pl_material_out,0)+
                            nvl(tl_material_overhead_out,0)+
                            nvl(pl_material_overhead_out,0)+
                            nvl(tl_resource_out,0)+
                            nvl(pl_resource_out,0)+
                            nvl(tl_outside_processing_out,0)+
                            nvl(pl_outside_processing_out,0)+
                            nvl(tl_overhead_out,0)+
                            nvl(pl_overhead_out,0)) total_variance,
                        sum(nvl(tl_scrap_in,0)+
                            nvl(pl_material_in,0)+
                            nvl(pl_material_overhead_in,0)+
                            nvl(tl_resource_in,0)+
                            nvl(pl_resource_in,0)+
                            nvl(tl_outside_processing_in,0)+
                            nvl(pl_outside_processing_in,0)+
                            nvl(tl_overhead_in,0)+
                            nvl(pl_overhead_in,0))  wip_costs_in,
                        sum(nvl(tl_scrap_out,0)+
                            nvl(tl_material_out,0)+
                            nvl(pl_material_out,0)+
                            nvl(tl_material_overhead_out,0)+
                            nvl(pl_material_overhead_out,0)+
                            nvl(tl_resource_out,0)+
                            nvl(pl_resource_out,0)+
                            nvl(tl_outside_processing_out,0)+
                            nvl(pl_outside_processing_out,0)+
                            nvl(tl_overhead_out,0)+
                            nvl(pl_overhead_out,0)) wip_costs_out,
                        sum(nvl(tl_scrap_var,0)+
                            nvl(tl_material_var,0)+
                            nvl(pl_material_var,0)+
                            nvl(tl_material_overhead_var,0)+
                            nvl(pl_material_overhead_var,0)+
                            nvl(tl_resource_var,0)+
                            nvl(pl_resource_var,0)+
                            nvl(tl_outside_processing_var,0)+
                            nvl(pl_outside_processing_var,0)+
                            nvl(tl_overhead_var,0)+
                            nvl(pl_overhead_var,0)) wip_relief,
                        sum(nvl(tl_scrap_in,0)+
                            nvl(pl_material_in,0)-
                            nvl(tl_material_out,0)-
                            nvl(tl_scrap_out,0)-
                            nvl(pl_material_out,0)-
                            nvl(tl_material_var,0)-
                            nvl(tl_scrap_var,0)-
                            nvl(pl_material_var,0)+
                            nvl(pl_material_overhead_in,0)-
                            nvl(tl_material_overhead_out,0)-
                            nvl(pl_material_overhead_out,0)-
                            nvl(tl_material_overhead_var,0)-
                            nvl(pl_material_overhead_var,0)+
                            nvl(tl_resource_in,0)+
                            nvl(pl_resource_in,0)-
                            nvl(tl_resource_out,0)-
                            nvl(pl_resource_out,0)-
                            nvl(tl_resource_var,0)-
                            nvl(pl_resource_var,0)+
                            nvl(tl_outside_processing_in,0)+
                            nvl(pl_outside_processing_in,0)-
                            nvl(tl_outside_processing_out,0)-
                            nvl(pl_outside_processing_out,0)-
                            nvl(tl_outside_processing_var,0)-
                            nvl(pl_outside_processing_var,0)+
                            nvl(tl_overhead_in,0)+
                            nvl(pl_overhead_in,0)-
                            nvl(tl_overhead_out,0)-
                            nvl(pl_overhead_out,0)-
                            nvl(tl_overhead_var,0)-
                            nvl(pl_overhead_var,0)) wip_value,
                        cic_assys.rolled_up,
                        cic_assys.last_rollup_date --,
                        -- Revision for version 1.27 and 1.30
                        -- Removed, not consistent for resources and overheads
                        -- null alternate_designator_code
                 from   wip_period_balances wpb,
                        wdj,
                        -- Revision for version 1.19
                        cic_assys,
                        -- Revision for version 1.23
                        mfg_lookups ml8
                 where  wpb.wip_entity_id                = wdj.wip_entity_id
                 -- Don't report jobs closed after the Accounting Period
                 and    wpb.acct_period_id              <= wdj.acct_period_id
                 and    wpb.organization_id              = wdj.organization_id
                 -- Revision for version 1.19
                 -- This section only available for summary information
                 and    ml8.lookup_type                  = 'CST_RPT_DETAIL_OPTION'
                 and    ml8.lookup_code                  = 2 -- Summary
                 and    7=7                              -- p_report_mode, Summary or Detail
                 -- These joins get the Item Lot Size
                 and    cic_assys.organization_id (+)    = wdj.organization_id
                 and    cic_assys.inventory_item_id (+)  = wdj.primary_item_id
                 and    cic_assys.cost_type_id (+)       = wdj.primary_cost_method
                 group by
                        wdj.report_type,
                        wdj.organization_code,
                        wdj.period_name,
                        wdj.overhead_account, -- account
                        wdj.class_code,
                        wdj.class_type,
                        wdj.wip_entity_id,
                        wdj.project_id,
                        wdj.status_type,
                        wdj.primary_item_id,
                        wdj.assembly_number,
                        wdj.assy_description,
                        wdj.assy_item_type,
                        wdj.assy_item_status_code,
                        wdj.assy_uom_code,
                        wdj.planning_make_buy_code,
                        wdj.lot_number,
                        -- Revision for version 1.23
                        4, --  report_sort
                        wdj.creation_date,
                        wdj.scheduled_start_date,
                        wdj.date_released,
                        wdj.date_completed,
                        wdj.date_closed,
                        wdj.last_update_date,
                        wdj.std_lot_size,
                        cic_assys.cost_type, -- lot_size_cost_type
                        nvl(cic_assys.lot_size, 1), -- costing_lot_size 
                        wdj.start_quantity,
                        wdj.quantity_completed,
                        wdj.quantity_scrapped,
                        nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0), -- fg_total_qty
                        null, -- inventory_item_id
                        wdj.organization_id,
                        null, -- osp_item
                        null, -- osp_description
                        null, -- po_number
                        null, -- line_number
                        null, -- po_release
                        null, -- department_id
                        null, -- operation_seq_num
                        null, -- item_or_res_op_seq
                        null, -- item_or_resource
                        null, -- description
                        -- Revision for version 1.24
                        null, -- resource_uom_code
                        null, -- overhead
                        null, -- ovhd_description
                        null, -- ovhd_basis_type
                        null, -- ovhd_unit_of_measure
                        -- Revision for version 1.23
                        -- null, -- phantom_parent
                        null, -- component_item_type
                        null, -- component_status_code
                        null, -- component_make_buy_code
                        null, -- wip_supply_type
                        null, -- basis_type
                        null, -- lot_basis_type
                        null, -- lot_basis_cost
                        null, -- item_basis_type
                        null, -- item_basis_cost
                        cic_assys.cost_type,
                        null, -- item_or_resource_cost
                        -- Revision for version 1.23
                        null, -- rate_or_amount
                        null, -- uom_code
                        0, -- quantity_per_assembly
                        0, -- total_req_quantity
                        -- Revision for version 1.22
                        null, -- last_txn_date
                        0, -- quantity_issued
                        0, -- wip_std_comp_or_res_value
                        0, -- applied_comp_or_res_value
                        0, -- std_quantity_per_assembly
                        0, -- std_total_req_quantity
                        0, -- wip_std_overhead_value
                        0, -- matl_usage_var
                        0, -- matl_config_var
                        -- Revision for version 1.30
                        0, --  wip_matl_lot_charges_per_unit
                        0, --  std_matl_lot_charges_per_unit
                        -- End revision for version 1.30
                        0, -- matl_lot_var
                        0, -- res_efficiency_var
                        0, -- res_methods_var
                        -- Revision for version 1.30
                        0, --  wip_res_lot_charges_per_unit
                        0, --  std_res_lot_charges_per_unit
                        -- End revision for version 1.30
                        0, -- res_lot_var
                        -- Revision for version 1.18
                        0, -- osp_efficiency_var
                        0, -- osp_methods_var
                        -- Revision for version 1.30
                        0, --  wip_osp_lot_charges_per_unit
                        0, --  std_osp_lot_charges_per_unit
                        -- End revision for version 1.30
                        0, -- osp_lot_var
                        -- End revision for version 1.18
                        0, -- ovhd_efficiency_var
                        -- Revision for version 1.37
                        0, -- scrap_variance
                        cic_assys.rolled_up,
                        cic_assys.last_rollup_date --,
                        -- Revision for version 1.27 and 1.30
                        -- Removed, not consistent for resources and overheads
                        -- null alternate_designator_code
                 union all
                 -- ===========================================
                 -- Section V - WIP Scrap
                 -- Inline table select for WIP Scrap Amounts
                 -- ===========================================
                 select wdj.report_type,
                        wdj.organization_code,
                        wdj.period_name,
                        wdj.overhead_account account,
                        wdj.class_code,
                        wdj.class_type,
                        wdj.wip_entity_id,
                        wdj.project_id,
                        wdj.status_type,
                        wdj.primary_item_id,
                        wdj.assembly_number,
                        wdj.assy_description,
                        wdj.assy_item_type,
                        wdj.assy_item_status_code,
                        wdj.assy_uom_code,
                        wdj.planning_make_buy_code,
                        wdj.lot_number,
                        5  report_sort,
                        wdj.creation_date,
                        wdj.scheduled_start_date,
                        wdj.date_released,
                        wdj.date_completed,
                        wdj.date_closed,
                        wdj.last_update_date,
                        wdj.std_lot_size,
                        cac.cost_type  lot_size_cost_type,
                        cac.lot_size costing_lot_size, 
                        wdj.start_quantity,
                        wdj.quantity_completed,
                        wdj.quantity_scrapped,
                        nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0) fg_total_qty,
                        null inventory_item_id,
                        wdj.organization_id,
                        null osp_item,
                        null osp_description,
                        null po_number,
                        null line_number,
                        null po_release,
                        null department_id,
                        null operation_seq_num,
                        null item_or_res_op_seq,
                        null item_or_resource,
                        null description,
                        null resource_uom_code,
                        null overhead,
                        null ovhd_description,
                        null ovhd_basis_type,
                        null ovhd_unit_of_measure,
                        null component_item_type,
                        null component_status_code,
                        null component_make_buy_code,
                        null wip_supply_type,
                        null basis_type,
                        null include_in_rollup,
                        null lot_basis_type,
                        null comp_lot_size,
                        null lot_basis_cost,
                        null item_basis_type,
                        null item_basis_cost,
                        cac.cost_type,
                        null item_or_resource_cost,
                        null rate_or_amount,
                        null uom_code,
                        0 quantity_per_assembly,
                        0 total_req_quantity,
                        null last_txn_date,
                        0 quantity_issued,
                        0 wip_std_comp_or_res_value,
                        0 applied_comp_or_res_value,
                        0 std_quantity_per_assembly,
                        0 std_total_req_quantity,
                        0 wip_std_overhead_value,
                        0 matl_usage_var,
                        0 matl_config_var,
                        0 wip_matl_lot_charges_per_unit,
                        0 std_matl_lot_charges_per_unit,
                        0 matl_lot_var,
                        0 res_efficiency_var,
                        0 res_methods_var,
                        0 wip_res_lot_charges_per_unit,
                        0 std_res_lot_charges_per_unit,
                        0 res_lot_var,
                        0 osp_efficiency_var,
                        0 osp_methods_var,
                        0 wip_osp_lot_charges_per_unit,
                        0 std_osp_lot_charges_per_unit,
                        0 osp_lot_var, 
                        0 ovhd_efficiency_var,
                        nvl(cac.item_cost * wdj.quantity_scrapped,0) * -1 scrap_variance,
                        0 material_variance,
                        0 res_variance,
                        0 osp_variance,
                        0 ovhd_variance,
                        0 total_variance,
                        0 wip_costs_in,
                        0 wip_costs_out,
                        0 wip_relief,
                        0 wip_value,
                        cic_assys.rolled_up,
                        cic_assys.last_rollup_date
                 from   cic_assy_cost cac,
                        wdj,
                        cic_assys,
                        mfg_lookups ml8
                 where  cac.wip_entity_id (+)            = wdj.wip_entity_id
                 and    cac.organization_id (+)          = wdj.organization_id
                 and    cic_assys.inventory_item_id (+)  = wdj.primary_item_id
                 and    cic_assys.cost_type_id (+)       = wdj.primary_cost_method
                 -- Only report the scrap variance if recorded to the G/L as a WIP Scrap Variance
                 and    wdj.mandatory_scrap_flag         = 1 -- Yes
                 -- This section only available for summary information
                 and    ml8.lookup_type                  = 'CST_RPT_DETAIL_OPTION'
                 and    ml8.lookup_code                  = 2 -- Summary
                 and    7=7                              -- p_report_mode, Summary or Detail
                 and    cic_assys.organization_id (+)    = wdj.organization_id
                 and    cic_assys.inventory_item_id (+)  = wdj.primary_item_id
                 and    cic_assys.cost_type_id (+)       = wdj.primary_cost_method
                 group by
                        wdj.report_type,
                        wdj.organization_code,
                        wdj.period_name,
                        wdj.overhead_account, -- account
                        wdj.class_code,
                        wdj.class_type,
                        wdj.wip_entity_id,
                        wdj.project_id,
                        wdj.status_type,
                        wdj.primary_item_id,
                        wdj.assembly_number,
                        wdj.assy_description,
                        wdj.assy_item_type,
                        wdj.assy_item_status_code,
                        wdj.assy_uom_code,
                        wdj.planning_make_buy_code,
                        wdj.lot_number,
                        5, --  report_sort
                        wdj.creation_date,
                        wdj.scheduled_start_date,
                        wdj.date_released,
                        wdj.date_completed,
                        wdj.date_closed,
                        wdj.last_update_date,
                        wdj.std_lot_size,
                        cac.cost_type, -- lot_size_cost_type
                        cac.lot_size,
                        wdj.start_quantity,
                        wdj.quantity_completed,
                        wdj.quantity_scrapped,
                        nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0), -- fg_total_qty
                        null, -- inventory_item_id
                        wdj.organization_id,
                        null, -- osp_item
                        null, -- osp_description
                        null, -- po_number
                        null, -- line_number
                        null, -- po_release
                        null, -- department_id
                        null, -- operation_seq_num
                        null, -- item_or_res_op_seq
                        null, -- item_or_resource
                        null, -- description
                        null, -- resource_uom_code
                        null, -- overhead
                        null, -- ovhd_description
                        null, -- ovhd_basis_type
                        null, -- ovhd_unit_of_measure
                        null, -- component_item_type
                        null, -- component_status_code
                        null, -- component_make_buy_code
                        null, -- wip_supply_type
                        null, -- basis_type
                        null, -- lot_basis_type
                        null, -- lot_basis_cost
                        null, -- item_basis_type
                        null, -- item_basis_cost
                        cic_assys.cost_type,
                        null, -- item_or_resource_cost
                        null, -- rate_or_amount
                        null, -- uom_code
                        0, -- quantity_per_assembly
                        0, -- total_req_quantity
                        null, -- last_txn_date
                        0, -- quantity_issued
                        0, -- wip_std_comp_or_res_value
                        0, -- applied_comp_or_res_value
                        0, -- std_quantity_per_assembly
                        0, -- std_total_req_quantity
                        0, -- wip_std_overhead_value
                        0, -- matl_usage_var
                        0, -- matl_config_var
                        0, -- wip_matl_lot_charges_per_unit
                        0, -- std_matl_lot_charges_per_unit
                        0, -- matl_lot_var
                        0, -- res_efficiency_var
                        0, -- res_methods_var
                        0, -- wip_res_lot_charges_per_unit
                        0, -- std_res_lot_charges_per_unit
                        0, -- res_lot_var
                        0, -- osp_efficiency_var
                        0, -- osp_methods_var
                        0, -- wip_osp_lot_charges_per_unit
                        0, -- std_osp_lot_charges_per_unit
                        0, -- osp_lot_var,
                        0, -- ovhd_efficiency_var
                        nvl(cac.item_cost * wdj.quantity_scrapped,0) * -1, -- scrap_var
                        cic_assys.rolled_up,
                        cic_assys.last_rollup_date
                ) wip
        -- Revision for version 1.19
        where  ml8.lookup_type                 = 'CST_RPT_DETAIL_OPTION'
        and    ml8.lookup_code                 = decode(:p_report_mode,              -- p_report_mode
                                                        'Detail', 1,
                                                        'Summary', 2,
                                                        1)
        and    7=7                             -- p_report_mode, Summary or Detail
        group by
                wip.report_type,
                -- Revision for version 1.19
                ml8.meaning, -- report_mode
                wip.organization_code,
                wip.period_name,
                decode(ml8.lookup_code, 1, wip.account, null), -- account
                wip.class_code,
                wip.class_type,
                wip.wip_entity_id,
                wip.project_id,
                wip.status_type,
                wip.creation_date,
                wip.scheduled_start_date,
                wip.date_released,
                wip.date_completed,
                wip.date_closed,
                wip.last_update_date,
                wip.organization_id,
                wip.std_lot_size,
                wip.lot_size_cost_type,
                wip.costing_lot_size,
                wip.start_quantity,
                wip.quantity_completed,
                wip.quantity_scrapped,
                wip.fg_total_qty,
                wip.primary_item_id,
                wip.assembly_number,
                wip.assy_description,
                wip.assy_item_type,
                wip.assy_item_status_code,
                wip.assy_uom_code,
                wip.planning_make_buy_code,
                wip.lot_number,
                -- Revision for version 1.23
                decode(ml8.lookup_code, 1, wip.report_sort, null), -- report_sort
                decode(ml8.lookup_code, 1, wip.osp_item, null), -- osp_item
                decode(ml8.lookup_code, 1, wip.osp_description, null), -- osp_description
                decode(ml8.lookup_code, 1, wip.po_number, null), -- po_number
                decode(ml8.lookup_code, 1, wip.line_number, null), -- line_number
                decode(ml8.lookup_code, 1, wip.po_release, null), -- po_release
                decode(ml8.lookup_code, 1, wip.department_id, null), -- department_id
                decode(ml8.lookup_code, 1, wip.operation_seq_num, null), -- operation_seq_num
                decode(ml8.lookup_code, 1, wip.item_or_res_op_seq, null), -- item_or_res_op_seq
                decode(ml8.lookup_code, 1, wip.item_or_resource, null), -- item_or_resource
                -- Revision for version 1.30 Column name change for description to avoid SQL error
                decode(ml8.lookup_code, 1, wip.description, null), -- item_or_res_description,
                -- Revision for version 1.24 and 1.30
                decode(ml8.lookup_code, 1, wip.resource_uom_code, null), -- resource_uom_code
                decode(ml8.lookup_code, 1, wip.overhead, null), -- overhead
                -- Revision for version 1.23
                decode(ml8.lookup_code, 1, wip.ovhd_description, null), -- ovhd_description
                -- Revision for version 1.23
                -- decode(ml8.lookup_code, 1, wip.phantom_parent, null), -- phantom_parent
                decode(ml8.lookup_code, 1, wip.component_item_type, null), -- component_item_type
                decode(ml8.lookup_code, 1, wip.component_status_code, null), -- component_status_code
                decode(ml8.lookup_code, 1, wip.component_make_buy_code, null), -- component_make_buy_code
                decode(ml8.lookup_code, 1, wip.wip_supply_type, null), -- wip_supply_type
                decode(ml8.lookup_code, 1, wip.basis_type, null), -- basis_type
                -- Revision for version 1.30
                decode(ml8.lookup_code, 1, wip.include_in_rollup, null), -- include_in_rollup
                -- Revision for version 1.24 and 1.32
                decode(ml8.lookup_code, 1, wip.cost_type, null), -- cost_type
                -- Revision for version 1.28
                decode(ml8.lookup_code, 1, wip.lot_basis_cost, null), --  lot_basis_cost
                decode(ml8.lookup_code, 1, wip.comp_lot_size, null), --  component_cost_lot_size
                -- End revision for version 1.28
                decode(ml8.lookup_code, 1, wip.item_or_resource_cost, null), -- item_or_resource_cost
                -- Revision for version 1.23
                decode(ml8.lookup_code, 1, wip.rate_or_amount, null), -- overhead_rate
                -- Revision for version 1.24
                decode(ml8.lookup_code, 1, wip.uom_code, null), --  uom_code
                decode(ml8.lookup_code, 1, wip.quantity_per_assembly, null), -- quantity_per_assembly
                decode(ml8.lookup_code, 1, wip.total_req_quantity, null), -- total_req_quantity
                -- Revision for version 1.22
                decode(ml8.lookup_code, 1, wip.last_txn_date, null), -- last_txn_date
                decode(ml8.lookup_code, 1, wip.quantity_issued, null), -- quantity_issued
                decode(ml8.lookup_code, 1, round(wip.quantity_issued - wip.total_req_quantity,3), null), -- quantity_left_in_wip
                decode(ml8.lookup_code, 1, wip.std_quantity_per_assembly, null), -- std_quantity_per_assembly
                decode(ml8.lookup_code, 1, wip.std_total_req_quantity, null), -- std_total_req_quantity
                -- For summation statements,
                ml8.lookup_code,
                -- Revision for version 1.27
                -- wip.rolled_up,
                nvl(wip.rolled_up,'N'), -- rolled_up
                wip.last_rollup_date
                -- Revision for version 1.27 and 1.30
                -- Removed, not consistent for resources and overheads
                -- wip.alternate_designator_code
                -- End revision for version 1.30
                -- End revision for version 1.19
        ) wip_sum
-- ===========================================
-- Ledger, organization, item master and cost joins
-- ===========================================
where  we.wip_entity_id                = wip_sum.wip_entity_id
-- Revision for version 1.37
and    we.organization_id              = wip_sum.organization_id
and    muomv.uom_code                  = wip_sum.assy_uom_code
and    misv.inventory_item_status_code = wip_sum.assy_item_status_code
and    bd.department_id (+)            = wip_sum.department_id
-- Revision for version 1.38, to avoid category segment logic error
and    msiv.inventory_item_id          = wip_sum.primary_item_id
and    msiv.organization_id            = wip_sum.organization_id
-- End revision for version 1.38
and    gcc.code_combination_id (+)     = wip_sum.account
and    hoi.org_information_context     = 'Accounting Information'
and    hoi.organization_id             = wip_sum.organization_id
and    hoi.organization_id             = haou.organization_id            -- get the organization name
and    haou2.organization_id           = to_number(hoi.org_information3) -- get the operating unit id
and    gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- ===========================================
-- Lookup Codes
-- ===========================================
and    ml1.lookup_type                 = 'WIP_CLASS_TYPE'
and    ml1.lookup_code                 = wip_sum.class_type
and    ml2.lookup_type                 = 'WIP_JOB_STATUS'
and    ml2.lookup_code                 = wip_sum.status_type
and    ml3.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and    ml3.lookup_code                 = wip_sum.planning_make_buy_code
and    fl2.lookup_type                 = 'YES_NO'
and    fl2.lookup_code                 = wip_sum.rolled_up
and    fcl1.lookup_type (+)            = 'ITEM_TYPE'
and    fcl1.lookup_code (+)            = wip_sum.assy_item_type
-- ===========================================
-- Additional parameters, version 1.5
-- ===========================================
and    1=1                             -- p_operating_unit, p_ledger
-- order by Report_Type, Ledger, Operating_Unit, Org_Code, Period_Name, Accounts, WIP_Class, WIP_Job, Component, Item Op Num and Operation
order by
        wip_sum.report_type,
        nvl(gl.short_name, gl.name),
        haou2.name, --  Operating_Unit
        wip_sum.organization_code,
        wip_sum.class_code,
        we.wip_entity_name
&p_det_order_by