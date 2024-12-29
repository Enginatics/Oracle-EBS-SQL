/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Material Usage Variance
-- Description: Report your material usage variances for your open and closed WIP jobs.  This report replicates the Material Variance Section for the Oracle Discrete Job Value - Standard Costing report.

If the job is open the Report Type column displays "Valuation", as this WIP job and potential material usage variance is still in your WIP inventory balances.  If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction.  You can report prior periods and this report will automatically adjust the assembly completion quantities and component issue quantities to reflect the quantities for the specified accounting period, as well as report only jobs which were open or closed during that prior period.

Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities.  All other WIP jobs use the parameter "Use Completion Quantities".  

Parameters:
==========
Report Option:  Open jobs, Closed jobs or All jobs.  Use this to limit the size of the report.  (mandatory)
Period Name:  the accounting period you wish to report.  (mandatory)
Cost Type:  defaults to your Costing Method; if the cost type is missing component costs the report will find any missing item costs from your Costing Method cost type. (optional)
Include Scrap Quantities:  for calculating your completion quantities and component quantity requirements, include or exclude any scrapped assembly quantities.  (mandatory)
Include Unreleased Jobs:  include jobs which have not been released and are not started.  (mandatory)
Include Bulk Supply Items:  include Bulk items to match the results from the Oracle Discrete Job Value Report; exclude knowing that Bulk items are usually not issued to the WIP job.  (mandatory)
Use Completion Qtys:  for jobs in a released status, use the completion quantities for the material usage and configuration variance calculations.  Useful if you backflush your materials based on your completion quantities.  Complete, Complete - No Charges, Cancelled, Closed, Pending Close or Failed Close alway use the completion quantities for the variance calculations.  (mandatory)
Category Set 1:  any item category you wish (optional).
Category Set 2:  any item category you wish (optional).
Class Code:  specific type of WIP class to report (optional).
Job Status:  specific WIP job status (optional).
WIP Job:  specific WIP job (optional).
Assembly Number:  specific assembly number you wish to report (optional)
Component Number:   specific component item you wish to report (optional)
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)

/* +=============================================================================+
-- |  Copyright 2009 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is acknowledged.
-- +=============================================================================+
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== =============== =========================================
-- |  1.0     12 Oct 2020 Douglas Volz    Initial Coding Based on ICP WIP Component 
-- |                                      Variances and ICP WIP Component Valuation
-- |  1.24     02 Feb 2022 Douglas Volz   Fix for non-standard jobs, there are no rows in wip_operations if there is no routing.
-- |  1.25     20 Jun 2024 Douglas Volz   Remove tabs, reinstall parameters and inventory org access controls.
-- |  ======= =========== =============== =========================================
-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-material-usage-variance/
-- Library Link: https://www.enginatics.com/reports/cac-wip-material-usage-variance/
-- Run Report: https://demo.enginatics.com/

with wdj00 as
(      select /*+ materialize */ wdj.wip_entity_id,min(mmt.transaction_date) transaction_date
       from wip_discrete_jobs wdj, 
       org_acct_periods oap,
       mtl_parameters mp,
       wip_accounting_classes wac,
       mtl_material_transactions mmt
       where wdj.class_code=wac.class_code and
       wdj.organization_id=wac.organization_id and
       wac.class_type in (1,3,5) and
       oap.organization_id= wdj.organization_id and
       mp.organization_id= wdj.organization_id and
       mmt.transaction_source_id=wdj.wip_entity_id and
       mmt.transaction_source_type_id=5 and 
       mmt.transaction_date >= oap.period_start_date and mmt.transaction_date < oap.schedule_close_date + 1 and
       mmt.organization_id=mp.organization_id and
       mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
       2=2 and -- p_org_code
       3=3 and -- p_assembly_number
       4=4 -- p_period_name, p_wip_job, wip_status, p_wip_class_code
       group by wdj.wip_entity_id
),
 wdj0 as
 (        select /*+ materialize */ wdj.wip_entity_id,
                wdj.organization_id,
                wdj.class_code,
                wdj.creation_date,
                wdj.scheduled_start_date,
                wdj.date_released,
                wdj.date_completed,
                -- Revision for version 1.22
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
                wdj.quantity_completed,
                wdj.quantity_scrapped,
                oap.period_start_date,
                oap.schedule_close_date,
                oap.period_name,
                -- Revision for version 1.12
                (case
                   when wdj.date_closed >= oap.period_start_date and wdj.date_closed < oap.schedule_close_date + 1 then 'Variance'
                   -- the job is open
                   when wdj.date_closed is null and((wdj.creation_date <  oap.schedule_close_date + 1 and not exists (select null from mtl_material_transactions mmt where mmt.transaction_source_id=wdj.wip_entity_id and mmt.transaction_source_type_id=5 and mmt.organization_id=mp.organization_id))
                   or(wdj00.transaction_date<oap.schedule_close_date + 1)) then 'Valuation'
                   -- the job is closed and ...the job was closed after the accounting period
                   when wdj.date_closed is not null and wdj.date_closed >= oap.schedule_close_date + 1 then 'Valuation'
                 end
                ) Report_Type,
                -- End revision for version 1.12
                -- Revision for version 1.10
                oap.acct_period_id,
                mp.primary_cost_method,
                mp.organization_code,
                wac.class_type
         from   wip_discrete_jobs wdj,
                org_acct_periods oap,
                mtl_parameters mp,
                wip_accounting_classes wac,
                mtl_system_items_vl msiv,
                wdj00
         where  wdj.class_code = wac.class_code
         and    wdj.organization_id = wac.organization_id
         and    wac.class_type in (1,3,5)
         and    oap.organization_id             = wdj.organization_id
         and    mp.organization_id              = wdj.organization_id
         and    msiv.organization_id            = wdj.organization_id
         and    msiv.inventory_item_id          = wdj.primary_item_id
         and    wdj.wip_entity_id=wdj00.wip_entity_id(+)
         -- find jobs that were open or closed during or after the report period
                -- the job is open or opened before the period close date
         and ( (wdj.date_closed is null -- the job is open
            and((wdj.creation_date <  oap.schedule_close_date + 1 and not exists (select null from mtl_material_transactions mmt where mmt.transaction_source_id=wdj.wip_entity_id and mmt.transaction_source_type_id=5 and mmt.organization_id=mp.organization_id))
                or(wdj00.transaction_date<oap.schedule_close_date + 1)
               )
            and :p_report_option in ('Open jobs', 'All jobs')    -- p_report_option
               )
             or -- the job is closed and ...the job was closed after the accounting period 
            (wdj.date_closed is not null
            and wdj.date_closed >= oap.schedule_close_date + 1
            and((wdj.creation_date <  oap.schedule_close_date + 1 and not exists (select null from mtl_material_transactions mmt where mmt.transaction_source_id=wdj.wip_entity_id and mmt.transaction_source_type_id=5 and mmt.organization_id=mp.organization_id))
            or(wdj00.transaction_date<oap.schedule_close_date + 1)
            )
            and :p_report_option in ('Open jobs', 'All jobs')    -- p_report_option
            )
             or -- find jobs that were closed during the report period
            (wdj.date_closed >= oap.period_start_date
            and wdj.date_closed < oap.schedule_close_date + 1
            and :p_report_option in ('Closed jobs', 'All jobs')  -- p_report_option
            )
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
                wdjsum.period_start_date,
                wdjsum.schedule_close_date,
                wdjsum.period_name,
                -- Revision for version 1.12
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
                        -- Revision for version 1.12
                        wdj0.report_type,
                        -- Revision for version 1.10
                        wdj0.acct_period_id,
                        wdj0.primary_cost_method,
                        wdj0.organization_code,
                        wdj0.class_type
                 from   wdj0,
                        mtl_material_transactions mmt
                 where  mmt.transaction_source_type_id  = 5
                 -- Revision for version 1.23
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
                wdjsum.period_start_date,
                wdjsum.schedule_close_date,
                wdjsum.period_name,
                -- Revision for version 1.12
                wdjsum.report_type,
                -- Revision for version 1.10
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
-- Revision for version 1.22
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
         from   cst_item_costs cic,
                cst_item_cost_details cicd,
                cst_cost_types cct,
                -- Limit to assemblies on WIP jobs
                wdj_assys
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
         from   cst_item_costs cic,
                cst_item_cost_details cicd,
                cst_cost_types cct,
                -- Limit to assemblies on WIP jobs
                -- wdj
                wdj_assys
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
                nvl(cic.lot_size,1)
        ),
-- Get the Component Cost Basis Type and Item Costs
cic_comp as
        (select cic.inventory_item_id,
                cic.organization_id,
                cic.last_update_date,
                cct.cost_type_id,
                cct.cost_type,
                mcacd.cost_element_id,
                null lot_basis_type,
                null lot_basis_cost,
                null item_basis_type,
                null item_basis_cost,
                wdj.wip_entity_id,
                max(nvl(mcacd.actual_cost,0)) item_cost
         from   cst_item_costs cic,
                cst_cost_types cct,
                mtl_parameters mp,
                wdj wdj,
                mtl_material_transactions mmt,
                mtl_cst_actual_cost_details mcacd,
                org_acct_periods oap
         where  4=4 and
         2=2 and -- p_org_code
         mp.organization_id=cic.organization_id and
         cic.cost_type_id=cct.cost_type_id and
         mcacd.transaction_id = mmt.transaction_id and
         mmt.inventory_item_id=mcacd.inventory_item_id and
         mmt.organization_id = mcacd.organization_id and
         mmt.transaction_source_id=wdj.wip_entity_id and
         mmt.transaction_source_type_id=5 and 
         oap.organization_id=mp.organization_id and
         mmt.transaction_date >= oap.period_start_date and mmt.transaction_date < oap.schedule_close_date + 1 and
         cic.inventory_item_id= mcacd.inventory_item_id and
         cic.organization_id= mcacd.organization_id and
         cct.cost_type= decode(:p_cost_type, -- p_cost_type
                               null, (select cct.cost_type 
                                      from dual 
                                      where cct.cost_type_id = mp.primary_cost_method
                                      ), 
                              :p_cost_type
                              )
         group by
         cic.inventory_item_id,
         cic.organization_id,
         cic.last_update_date,
         cct.cost_type_id,
         cct.cost_type,
         mcacd.cost_element_id,
         mcacd.level_type,
         wdj.wip_entity_id
         union all
         select cic.inventory_item_id,
                cic.organization_id,
                cic.last_update_date,
                cct.cost_type_id,
                cct.cost_type,
                cicd.cost_element_id,
                max(case
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
                max(case
                       when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then 0 -- material item basis type
                       when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then 0 -- moh item basis type
                       when cicd.level_type = 2 and cicd.basis_type = 2 then 0 -- previous level item basis type
                       else 1
                    end) item_basis_type,
                sum(case
                       when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then 0 -- material item basis cost
                       when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then 0 -- moh item basis cost
                       when cicd.level_type = 2 and cicd.basis_type = 2 then 0 -- previous level item basis cost
                       else cicd.item_cost
                    end) item_basis_cost,
                wdj.wip_entity_id,
                nvl(cicd.item_cost,0) item_cost
         from   cst_item_cost_details cicd,
                cst_item_costs cic,
                wdj wdj,
                wip_requirement_operations wro,
                cst_cost_types cct,
                mtl_parameters mp
         where 2=2 and  -- p_org_code
         mp.organization_id=cic.organization_id and
         cic.cost_type_id=cct.cost_type_id and
         wdj.wip_entity_id=wro.wip_entity_id and
         mp.organization_id=wro.organization_id and
         wro.wip_supply_type<>6 and
         cic.inventory_item_id=wro.inventory_item_id and
         cic.cost_type_id=cicd.cost_type_id (+) and
         not exists(
         select null 
         from 
         mtl_cst_actual_cost_details mcacd_new,
         mtl_material_transactions mmt_new,
         org_acct_periods oap
         where 4=4 and
         oap.organization_id=mp.organization_id and
         mcacd_new.transaction_id = mmt_new.transaction_id and
         mmt_new.transaction_date >= oap.period_start_date and mmt_new.transaction_date < oap.schedule_close_date + 1 and
         mmt_new.transaction_source_id=wdj.wip_entity_id and
         mmt_new.transaction_source_type_id=5 and 
         mmt_new.inventory_item_id=cic.inventory_item_id and
         mmt_new.organization_id = cic.organization_id
         ) and
         cic.inventory_item_id=cicd.inventory_item_id (+) and
         cic.organization_id=cicd.organization_id (+) and
         cct.cost_type=decode(:p_cost_type,-- p_cost_type
                              null, (select cct.cost_type 
                                     from dual 
                                     where cct.cost_type_id = mp.primary_cost_method
                                     ), 
                             :p_cost_type
                             )
         group by
         cic.inventory_item_id,
         cic.organization_id,
         cic.last_update_date,
         cct.cost_type_id,
         cct.cost_type,
         cicd.cost_element_id,
         wdj.wip_entity_id,
         cicd.level_type,
         nvl(cicd.item_cost,0)
         union all
         select cic.inventory_item_id,
                cic.organization_id,
                cic.last_update_date,
                cct.cost_type_id,
                cct.cost_type,
                cicd.cost_element_id,
                max(case
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
                max(case
                       when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then 0 -- material item basis type
                       when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then 0 -- moh item basis type
                       when cicd.level_type = 2 and cicd.basis_type = 2 then 0 -- previous level item basis type
                       else 1
                    end) item_basis_type,
                sum(case
                       when cicd.level_type = 1 and cicd.cost_element_id = 1 and cicd.basis_type = 2 then 0 -- material item basis cost
                       when cicd.level_type = 1 and cicd.cost_element_id = 2 and cicd.basis_type = 2 then 0 -- moh item basis cost
                       when cicd.level_type = 2 and cicd.basis_type = 2 then 0 -- previous level item basis cost
                       else cicd.item_cost
                    end) item_basis_cost,
                wdj.wip_entity_id,
                nvl(cicd.item_cost,0) item_cost
         from   cst_item_cost_details cicd,
                cst_item_costs cic,
                cst_cost_types cct,
                mtl_parameters mp,
                wdj wdj,
                wip_requirement_operations wro
         where 2=2 and
         mp.organization_id=cic.organization_id and
         cic.cost_type_id=mp.primary_cost_method and  -- this gets the Frozen Costs
         cic.cost_type_id=cicd.cost_type_id (+) and
         cic.inventory_item_id=cicd.inventory_item_id (+) and
         cic.organization_id=cicd.organization_id (+) and
         wdj.wip_entity_id=wro.wip_entity_id and
         wro.wip_supply_type<>6 and
         mp.organization_id=wro.organization_id and
         cic.inventory_item_id=wro.inventory_item_id and
         cct.cost_type_id<>mp.primary_cost_method and  -- this avoids getting the Frozen costs twice
         cct.cost_type= decode(:p_cost_type,                                                -- p_cost_type
                               null, (select cct.cost_type 
                                        from dual 
                                      where  cct.cost_type_id = mp.primary_cost_method
                                      ), 
                               :p_cost_type
                              ) and
         -- ====================================
         -- Find all the Frozen costs not in the
         -- Pending or unimplemented cost type
         -- ====================================
         not exists(select 'x'
                    from cst_item_costs cic2
                    where cic2.organization_id=cic.organization_id
                    and cic2.inventory_item_id=cic.inventory_item_id
                    and cic2.cost_type_id=cct.cost_type_id
                   )
         group by
         cic.inventory_item_id,
         cic.organization_id,
         cic.last_update_date,
         cct.cost_type_id,
         cicd.level_type,
         cct.cost_type,
         cicd.cost_element_id,
         nvl(cicd.item_cost,0),
         wdj.wip_entity_id
        )
----------------main query starts here--------------

select  mtl_sum.report_type Report_Type,
        nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mtl_sum.organization_code Org_Code,
        mtl_sum.period_name Period_Name,
        &segment_columns
        mtl_sum.class_code WIP_Class,
        ml1.meaning Class_Type,
        we.wip_entity_name WIP_Job,
        (select ppa.segment1
         from   pa_projects_all ppa
         where  ppa.project_id = mtl_sum.project_id) Project_Number,
        ml2.meaning Job_Status,
        mtl_sum.creation_date Creation_Date,
        -- Revision for version 1.5
        mtl_sum.scheduled_start_date Scheduled_Start_Date,
        mtl_sum.date_released Date_Released,
        mtl_sum.date_completed Date_Completed,
        mtl_sum.date_closed Date_Closed,
        mtl_sum.last_update_date Last_Update_Date,
        muomv.uom_code UOM_Code,
        mtl_sum.std_lot_size Item_Std_Lot_Size,
        -- Revision for version 1.12
        -- mtl_sum.primary_cost_type  Lot_Size_Cost_Type,
        cic_assys.cost_type  Lot_Size_Cost_Type,
        cic_assys.lot_size Costing_Lot_Size,
        mtl_sum.start_quantity Start_Quantity,
        mtl_sum.quantity_completed Assembly_Quantity_Completed,
        mtl_sum.quantity_scrapped Assembly_Quantity_Scrapped,
        mtl_sum.fg_total_qty Total_Assembly_Quantity,
        -- Revision for version 1.22
        mtl_sum.assembly_number Assembly,
        mtl_sum.assy_description Assembly_Description,
        -- End revision for version 1.22
        fcl1.meaning Item_Type,
        misv.inventory_item_status_code Item_Status,
        ml3.meaning Make_Buy_Code,
&category_columns
        -- Revision for version 1.7
        mtl_sum.lot_number Lot_Number,
        mtl_sum.operation_seq_num Operation_Seq_Number,
        bd.department_code Department,
        -- Revision for version 1.22
        -- msiv2.concatenated_segments Component,
        -- msiv2.description Component_Description,
        mtl_sum.Component_Number,
        mtl_sum.Component_Description,
        -- End revision for version 1.22
        -- Revision for version 1.6 and 1.20
        -- fl1.meaning Phantom_Parent,
        fcl2.meaning Component_Item_Type,
        misv2.inventory_item_status_code Component_Status_Code,
        ml4.meaning Component_Make_Buy_Code,
        ml5.meaning  WIP_Supply_Type,
        ml6.meaning Component_Basis_Type,
        mtl_sum.cost_type Cost_Type,
        gl.currency_code Currency_Code,
        nvl(xxen_util.meaning(mtl_sum.cost_element_id ,'CST_COST_CODE_TYPE',700),'No Cost') cost_element_type,
        mtl_sum.item_cost Item_Cost,
        muomv2.uom_code UOM_Code,        
        mtl_sum.quantity_per_assembly Quantity_Per_Assembly,
        round(mtl_sum.total_req_quantity,3) Total_Required_Quantity,
        -- Revision for version 1.18
        case when mtl_sum.last_txn_date is null then 'No WIP Issue' else to_char(mtl_sum.last_txn_date,'DD-Mon-RRRR HH24:MI:SS') end Last_Transaction_Date,
        nvl(mtl_sum.last_txn_type,'No WIP Issue') Last_Transaction_Type,
        round(mtl_sum.quantity_issued,3) Quantity_Issued,
        -- ===========================================
        -- Quantity_Left_in_WIP = Quantity_Issued minus the Quantity Required 
        -- ===========================================
        round(mtl_sum.quantity_issued - mtl_sum.total_req_quantity,3) Quantity_Left_in_WIP,
        round(mtl_sum.wip_std_component_value,fc.precision) WIP_Standard_Component_Value,
        round(mtl_sum.applied_component_value,fc.precision) Applied_Component_Value,
        -- Revision for version 1.8 and 1.9
        -- To match the Oracle Discrete Job Value Report, for cancelled wip jobs, turn off 
        -- material usage variances when there are no completions and no applied or charged quantities.
        -- round(mtl_sum.applied_component_value - mtl_sum.wip_std_component_value,2) Material_Usage_Variance,
        case
           when mtl_sum.fg_total_qty = 0 and mtl_sum.applied_component_value = 0 then 0
           -- End revision for version 1.9
           else mtl_sum.applied_component_value - mtl_sum.wip_std_component_value
 