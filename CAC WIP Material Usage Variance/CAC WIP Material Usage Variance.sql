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
        end Material_Usage_Variance,
        -- End revision for version 1.8
        -- Revision for version 1.8
        fl2.meaning Rolled_Up,
        cic_assys.last_rollup_date Last_Cost_Rollup
        -- End revision for version 1.8
-- Revision for version 1.22
-- from mtl_system_items_vl msiv2,
from    mtl_units_of_measure_vl muomv,
        mtl_units_of_measure_vl muomv2,
        mtl_item_status_vl misv,
        mtl_item_status_vl misv2,
        bom_departments bd,
        wip_entities we,
        mfg_lookups ml1, -- WIP_Class
        mfg_lookups ml2, -- WIP Status
        mfg_lookups ml3, -- Assy Planning Make Buy
        mfg_lookups ml4, -- Component Planning Make Buy
        mfg_lookups ml5, -- WIP_Supply_Type
        mfg_lookups ml6, -- Component Basis Type
        -- Revision for version 1.20, comment out Phantom Parent
        -- Revision for version 1.6
        -- fnd_lookups fl1,  -- Phantom Parent
        -- Revision for version 1.8
        fnd_lookups fl2,  -- Rolled Up
        fnd_common_lookups fcl1, -- Assy Item Type
        fnd_common_lookups fcl2, -- Component Item Type
        gl_code_combinations gcc,  -- wip job accounts
        hr_organization_information hoi,
        hr_all_organization_units haou,
        hr_all_organization_units haou2,
        gl_ledgers gl,
        fnd_currencies fc,
        -- Revision for version 1.8
        -- cst_item_costs cic,
        -- Revision for version 1.22
        cic_assys,
        -- ========================================================
        -- Get the WIP Component Information in a multi-part union
        -- which is then condensed into a summary data set
        -- ========================================================
        -- ========================================================
        -- Section I  Condense into a summary data set.
        -- =======================================================
        (select mtl.report_type,
                mtl.period_name,
                mtl.organization_code,
                mtl.organization_id,
                mtl.primary_cost_method,
                -- Revision for version 1.12
                -- mtl.primary_cost_type,
                mtl.account,
                mtl.class_code,
                mtl.class_type,
                mtl.wip_entity_id,
                mtl.project_id,
                mtl.status_type,
                mtl.primary_item_id,
                -- Revision for version 1.22
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
                -- Revision for version 1.12 and 1.14
                -- mtl.level_num,
                mtl.operation_seq_num,
                mtl.wip_supply_type,
                -- Revision for version 1.6 and 1.22
                mtl.component_number,
                mtl.component_description,
                mtl.component_item_type,
                mtl.comp_planning_make_buy_code,
                mtl.component_item_status_code,
                mtl.component_uom_code,
                -- End revision for version 1.22
                -- Revision for version 1.21
                -- case
                --    when sum(mtl.phantom_parent) > 0 then 'Y'
                --    else 'N'
                -- end phantom_parent,
                -- Revision for version 1.8
                mtl.basis_type,
                mtl.lot_basis_type,
                mtl.lot_basis_cost,
                mtl.item_basis_type,
                mtl.item_basis_cost,
                -- End revision for version 1.8
                mtl.cost_type,
                mtl.item_cost,
                mtl.cost_element_id,
                sum(mtl.quantity_per_assembly) quantity_per_assembly,
                sum(mtl.total_req_quantity) total_req_quantity,
                -- Revision for version 1.18
                (select max(mmt.transaction_date)
                 from   mtl_material_transactions mmt
                 where  mmt.inventory_item_id          = mtl.inventory_item_id
                 and    mmt.organization_id            = mtl.organization_id
                 and    mmt.transaction_source_id      = mtl.wip_entity_id
                 and    mmt.transaction_source_type_id = 5
                 and    mmt.transaction_date           < mtl.schedule_close_date + 1) last_txn_date,
                (select mtt.transaction_type_name
                from
                (select mtt.transaction_type_name,row_number() over (order by mmt.transaction_date desc) row_num
                 from 
                 mtl_material_transactions mmt,
                 mtl_transaction_types mtt
                 where mmt.inventory_item_id=mtl.inventory_item_id and
                 mmt.organization_id=mtl.organization_id and
                 mmt.transaction_source_id=mtl.wip_entity_id and
                 mmt.transaction_source_type_id=5 and
                 mtt.transaction_type_id=mmt.transaction_type_id and
                 mmt.transaction_date<mtl.schedule_close_date + 1
                 )mtt
                 where mtt.row_num=1) last_txn_type,
                -- End revision for version 1.18
                sum(mtl.quantity_issued) quantity_issued,
                sum(mtl.wip_std_component_value) wip_std_component_value,
                sum(mtl.applied_component_value) applied_component_value
                from    -- =======================================================
                        -- Section II.A. WIP and WIP Material Components
                        -- =======================================================
                        -- Revision for version 1.12
                        (select 'II.A' section,
                                -- Revision for version 1.22
                                wro.report_type,
                                wro.period_name,
                                wro.organization_code,
                                wro.organization_id,
                                wro.primary_cost_method,
                                -- Revision for version 1.12
                                -- cct.cost_type primary_cost_type,
                                -- Revision for deriving account as per cost element
                                --wro.account,
                               decode(cic_comp.cost_element_id,
                                      1, wdj_accounts.material_account,
                                      2, wdj_accounts.material_overhead_account,
                                      3, wdj_accounts.resource_account,
                                      4, wdj_accounts.outside_processing_account,
                                      5, wdj_accounts.overhead_account,
                                      wdj_accounts.material_account
                                     )account,
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
                                -- Revision for version 1.18
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
                                -- Revision for version 1.24
                                -- wo.operation_seq_num,
                                wro.operation_seq_num,
                                -- Revision for version 1.14
                                wro.component_sequence_id,
                                wro.wip_supply_type,
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
                                nvl(wro.basis_type, 1) basis_type,
                                decode(cic_comp.lot_basis_type, 0, 'N', 'Y') lot_basis_type,
                                -- Revision for version 1.12
                                nvl(cic_comp.lot_basis_cost,0) lot_basis_cost,
                                decode(nvl(wro.basis_type,1),
                                            1, 'Y',
                                            2, 'N',
                                            decode(cic_comp.item_basis_type, 0, 'N', 'Y')
                                      ) item_basis_type,
                                -- Revision for version 1.12
                                nvl(cic_comp.item_basis_cost,0) item_basis_cost,
                                cic_comp.cost_type cost_type,
                                nvl(cic_comp.item_cost,0) item_cost,
                                cic_comp.cost_element_id,
                                -- a basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
                                decode(nvl(wro.basis_type,1), 
                                        1, nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1),                    -- Item basis
                                        2, nvl(wro.required_quantity,1),                                                              -- Lot
                                           nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1)                     -- Any other basis
                                      ) quantity_per_assembly,
                                -- If the job status is 'Complete' or 'Complete - No Charges' then use the 
                                -- completions plus scrap quantities else use the planned required quantities;
                                -- and use the completions plus scrap quantities unless for lot-based jobs
                                -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                                round(decode(:p_use_completion_qtys,
                                             'Y',
                                                 case when wro.status_type in (4,5,7,12,14,15) then
                                                   -- use the completions plus scrap quantities unless for lot-based jobs
                                                   decode(nvl(wro.basis_type, 1),
                                                          2, nvl(wro.quantity_per_assembly,0),                                           -- Lot
                                                          nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1)         -- Any other basis
                                                          * decode(wro.class_type,
                                                                    5, nvl(wro.quantity_completed, 0),
                                                                    nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0))
                                                                   )
                                                         ) 
                                                 else
                                                    -- else use the start quantity times the usage rate or amount
                                                    decode(:p_use_completion_qtys,
                                                           'Y', decode(nvl(wro.basis_type, 1),
                                                                       -- use the completions plus scrap quantities unless for lot-based jobs
                                                                       2, nvl(wro.quantity_per_assembly,0),                                          -- Lot
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
                                                           )
                                                 end,
                                              wro.required_quantity-decode(:p_include_scrap, 'Y', 0, nvl(wro.quantity_per_assembly,0)*nvl(wro.quantity_scrapped, 0))
                                           )
                                   ,6) total_req_quantity,
                                nvl(wro.quantity_issued,0) quantity_issued,
                                -- If the job status is 'Complete' or 'Complete - No Charges' then use the 
                                -- completions plus scrap quantities else use the planned required quantities;
                                -- and use the completions plus scrap quantities unless for lot-based jobs
                                -- For 'Complete', 'Complete - No Charges', 'Cancelled', 'Closed', 'Pending Close' and 'Failed Close'
                                round(decode(:p_use_completion_qtys,
                                             'Y',
                                                 case when wro.status_type in (4,5,7,12,14,15) then
                                                   -- use the completions plus scrap quantities unless for lot-based jobs
                                                   decode(nvl(wro.basis_type, 1),
                                                          2, nvl(wro.quantity_per_assembly,0),                                           -- Lot
                                                          nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1)         -- Any other basis
                                                          * decode(wro.class_type,
                                                                    5, nvl(wro.quantity_completed, 0),
                                                                    nvl(wro.quantity_completed, 0) + decode(:p_include_scrap, 'N', 0, null, 0, nvl(wro.quantity_scrapped, 0))
                                                                   )
                                                         ) 
                                                 else
                                                    -- else use the start quantity times the usage rate or amount
                                                    decode(:p_use_completion_qtys,
                                                           'Y', decode(nvl(wro.basis_type, 1),
                                                                       -- use the completions plus scrap quantities unless for lot-based jobs
                                                                       2, nvl(wro.quantity_per_assembly,0),                                          -- Lot
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
                                                           )
                                                 end,
                                              wro.required_quantity-decode(:p_include_scrap, 'Y', 0, nvl(wro.quantity_per_assembly,0)*nvl(wro.quantity_scrapped, 0))
                                           )
                                   ,6) -- total_req_quantity
                                -- And multiply by the Cost_Type or Costing_Method costs
                                * nvl(cic_comp.item_cost,0) wip_std_component_value,
                                nvl(wro.quantity_issued,0)
                                -- And multiply by the Cost_Type or Costing_Method costs
                                * nvl(cic_comp.item_cost,0) applied_component_value
                         from   wip_discrete_jobs wdj_accounts,
                                wip_operations wo,
                                -- Revision for version 1.12
                                -- cst_cost_types cct,
                                -- Revision for version 1.22
                                -- mtl_system_items_vl msiv,
                                -- Revision for version 1.22
                                cic_comp, -- Get the Cost Basis Type and Component Item Costs
                                -- wdj, -- get the corrected wip qty completed and qty scrapped
                                -- End revision for version 1.22
                                -- get the corrected wip component issue quantities
                                -- Revision for version 1.6
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
                                        -- wrosum.wip_entity_id,
                                        -- wrosum.organization_id,
                                        -- End revision for version 1.22
                                        wrosum.inventory_item_id,
                                        wrosum.operation_seq_num,
                                        wrosum.component_sequence_id,
                                        wrosum.quantity_per_assembly,
                                        max(wrosum.required_quantity) required_quantity,
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
                                 -- from (select  1 level_num,
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
                                                -- wdj.primary_item_id level_1_parent_assy_id,
                                                -- End revision for version 1.22
                                                0 level_2_parent_assy_id,
                                                0 level_3_parent_assy_id,
                                                0 level_4_parent_assy_id,
                                                -- Revision for version 1.21
                                                -- 0 level_1_from_phantom_assy,
                                                -- 0 level_2_from_phantom_assy,
                                                -- 0 level_3_from_phantom_assy,
                                                -- 0 level_4_from_phantom_assy,
                                                -- End revision for version 1.21
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
                                         and    6=6                             -- p_include_bulk_items
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
                                                -- wdj.primary_item_id level_1_parent_assy_id,
                                                -- End revision for version 1.22
                                                0 level_2_parent_assy_id,
                                                0 level_3_parent_assy_id,
                                                0 level_4_parent_assy_id,
                                                -- Revision for version 1.21
                                                -- 0 level_1_from_phantom_assy,
                                                -- 0 level_2_from_phantom_assy,
                                                -- 0 level_3_from_phantom_assy,
                                                -- 0 level_4_from_phantom_assy,
                                                -- End revision for version 1.21
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
                                         -- and wdj.acct_period_id              = mmt.acct_period_id
                                         -- and wdj.organization_id             = mmt.organization_id
                                         -- Revision for version 1.10
                                         -- and oap.acct_period_id              = mmt.acct_period_id
                                         -- and wdj.organization_id             = oap.organization_id
                                         -- and mmt.transaction_date           >= oap.schedule_close_date + 1
                                         and    mmt.transaction_date           >= wdj.schedule_close_date + 1
                                         -- End revision for version 1.10
                                         -- End revision for version 1.23
                                         -- Revision for version 1.3
                                         and        6=6                             -- p_include_bulk_items
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
                                        -- wrosum.wip_entity_id,
                                        -- wrosum.organization_id,
                                        -- End revision for version 1.22
                                        wrosum.inventory_item_id,
                                        wrosum.operation_seq_num,
                                        wrosum.component_sequence_id,
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
                                ) wro
                         -- ===========================================
                         -- WIP_Job Entity, Class and Period joins
                         -- ===========================================
                         -- Revision for version 1.22
                         -- where wro.wip_entity_id         = wdj.wip_entity_id
                         -- and   wro.organization_id       = wdj.organization_id
                         -- and   wo.operation_seq_num (+)  = wro.operation_seq_num
                         -- End revision for version 1.22
                         where wo.operation_seq_num (+)  = wro.operation_seq_num
                         and wo.wip_entity_id (+)      = wro.wip_entity_id
                         and wdj_accounts.wip_entity_id=wro.wip_entity_id
                         and wdj_accounts.organization_id=wro.organization_id
                         and wo.organization_id (+)    = wro.organization_id    
                        -- Revision for version 1.12
                        -- and   cct.cost_type_id          = wdj.primary_cost_method
                         and wro.organization_id       = cic_comp.organization_id (+)
                         and wro.inventory_item_id     = cic_comp.inventory_item_id (+)
                         and wro.wip_entity_id         = cic_comp.wip_entity_id(+)
                         -- Revision for version 1.22
                         -- and        msiv.organization_id      = wro.organization_id
                         -- and        msiv.inventory_item_id    = wro.inventory_item_id
                         -- End revision for version 1.22
                        ) mtl
         group by
                mtl.report_type,
                mtl.period_name,
                mtl.organization_code,
                mtl.organization_id,
                mtl.primary_cost_method,
                -- Revision for version 1.12
                -- mtl.primary_cost_type,
                mtl.account,
                mtl.class_code,
                mtl.class_type,
                mtl.wip_entity_id,
                mtl.project_id,
                mtl.status_type,
                mtl.primary_item_id,
                -- Revision for version 1.22
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
                -- Revision for version 1.18
                mtl.schedule_close_date,
                mtl.last_update_date,
                mtl.start_quantity,
                mtl.quantity_completed,
                mtl.quantity_scrapped,
                mtl.fg_total_qty,
                mtl.inventory_item_id,
                -- Revision for version 1.14
                mtl.department_id,
                -- Revision for version 1.19
                mtl.inventory_item_id,
                -- Revision for version 1.12 and 1.14
                -- mtl.level_num,
                -- Revision for version 1.14
                mtl.operation_seq_num,
                mtl.wip_supply_type,
                -- End revision for version 1.14
                -- Revision for version 1.6 and 1.22
                mtl.component_number,
                mtl.component_description,
                mtl.component_item_type,
                mtl.comp_planning_make_buy_code,
                mtl.component_item_status_code,
                mtl.component_uom_code,
                -- End revision for version 1.22
                -- Revision for version 1.8
                mtl.basis_type,
                mtl.lot_basis_type,
                mtl.lot_basis_cost,
                mtl.item_basis_type,
                mtl.item_basis_cost,
                -- End revision for version 1.8
                mtl.cost_type,
                mtl.item_cost,
                mtl.cost_element_id
        ) mtl_sum
-- ===========================================
-- Account, cost and department joins
-- ===========================================
where   we.wip_entity_id                = mtl_sum.wip_entity_id
-- and  msiv2.organization_id           = mtl_sum.organization_id
-- and  msiv2.inventory_item_id         = mtl_sum.inventory_item_id  -- Component item
-- and  muomv.uom_code                  = mtl_sum.primary_uom_code
and     muomv.uom_code                  = mtl_sum.assy_uom_code
-- End revision for version 1.22
and     misv.inventory_item_status_code = mtl_sum.assy_item_status_code
and     muomv2.uom_code                 = mtl_sum.component_uom_code
and     misv2.inventory_item_status_code (+) = mtl_sum.component_item_status_code
and     bd.department_id (+)            = mtl_sum.department_id
-- Revision for version 1.6
-- Screen out phantoms from the WIP BOM as these are never issued from stock
-- Phantoms on the WIP BOM have a negative operation_seq_num
and     nvl(mtl_sum.operation_seq_num,0) > 0
-- These joins get the Item Lot_Size
and     cic_assys.organization_id (+)   = mtl_sum.organization_id
and     cic_assys.inventory_item_id (+) = mtl_sum.primary_item_id
and     gcc.code_combination_id (+)     = mtl_sum.account
-- Revision for version 1.5
-- Remove noise from the report, if no quantities required do not report the component
and     nvl(mtl_sum.quantity_per_assembly,0) + round(mtl_sum.quantity_issued,3) <> 0
-- ===========================================
-- Lookup Codes
-- ===========================================
and     ml1.lookup_type                 = 'WIP_CLASS_TYPE'
and     ml1.lookup_code                 = mtl_sum.class_type
and     ml2.lookup_type                 = 'WIP_JOB_STATUS'
and     ml2.lookup_code                 = mtl_sum.status_type
and     ml3.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml3.lookup_code                 = mtl_sum.planning_make_buy_code
and     ml4.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml4.lookup_code                 = mtl_sum.comp_planning_make_buy_code
and     ml5.lookup_type (+)             = 'WIP_SUPPLY'
and     ml5.lookup_code (+)             = mtl_sum.wip_supply_type
and     ml6.lookup_type                 = 'CST_BASIS'
and     ml6.lookup_code                 = mtl_sum.basis_type
-- Revision for version 1.20, comment out Phantom Parent
-- Revision for version 1.6
-- and  fl1.lookup_type                 = 'YES_NO'
-- and  fl1.lookup_code                 = mtl_sum.phantom_parent
-- Revision for version 1.8
and     fl2.lookup_type                 = 'YES_NO'
and     fl2.lookup_code                 = cic_assys.rolled_up
and     fcl1.lookup_type (+)            = 'ITEM_TYPE'
and     fcl1.lookup_code (+)            = mtl_sum.assy_item_type
and     fcl2.lookup_type (+)            = 'ITEM_TYPE'
and     fcl2.lookup_code (+)            = mtl_sum.component_item_type
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mtl_sum.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and     gl.currency_code                = fc.currency_code
and     1=1                            -- p_component_number, p_operating_unit, p_ledger
and     mtl_sum.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
-- order by Report_Type, Ledger, Operating_Unit, Org_Code, Period_Name, Accounts, WIP_Class, WIP_Job, Component and Operation
order by
        mtl_sum.report_type,
        nvl(gl.short_name, gl.name),
        haou2.name, --  Operating_Unit
        mtl_sum.organization_code,
        &segment_columns_grp
        mtl_sum.class_code,
        we.wip_entity_name,
        -- Revision for version 1.14
        -- Revision for version 1.22
        -- msiv2.concatenated_segments,
        mtl_sum.operation_seq_num,
        mtl_sum.component_number,
        bd.department_code