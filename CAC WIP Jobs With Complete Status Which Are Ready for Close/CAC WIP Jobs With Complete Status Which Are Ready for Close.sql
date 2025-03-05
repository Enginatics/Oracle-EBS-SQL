/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Jobs With Complete Status Which Are Ready for Close
-- Description: Report WIP jobs which have a status of "Complete", do not exceed variance tolerances, have completed or exceeded the WIP start quantity, with no open material requirements, no unearned OSP (outside processing) charges and no stuck transactions in interfaces.  When you include scrap quantities, any scrapped assemblies are counted with the completed units.  Note that for material requirements, expense items are ignored.

Parameters:
==========
Variance Amount Threshold:  maximum absolute WIP variance or current job balance that is allowed for jobs you wish to close (required).
Variance Percent Threshold: maximum absolute WIP variance percentage that is allowed for jobs you wish to close.  Based on WIP Job Balance / WIP Costs In. (required).
Include Scrap Quantities:  include scrapped assemblies in completion and component material requirements (required).
Include Bulk Supply Items:  include bulk WIP supply types in the component requirements (required).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Class Code:  enter the WIP class code to report (optional).
WIP Job:  enter the WIP Job to report (optional).
Assembly Number:  enter the specific assembly number(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2017 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas A. Volz
-- | 
-- |  Version Modified on Modified  by  Description
-- |  ======= =========== ============= =========================================
-- |  1.0     16 MAR 2017 Douglas Volz  Initial Coding
-- |  1.1     19 MAR 2017 Douglas Volz  Added interface conditions for eligibility
-- |                                    and check for no applied OSP
-- |  1.3     27 MAR 2017 Douglas Volz  Fix "return more than one row" error for
-- |                                    correlated sub-query on OSP and add in check for purchase requisitions
-- |  1.4     27 APR 2017 Douglas Volz  Fix for cross-joining results
-- |  1.6     25 Oct 2017 Douglas Volz  Remove p_date_completed parameter, not needed
-- |  1.7     25 Jul 2018 Douglas Volz  Removed all categories except Inventory
-- |  1.8     25 Jul 2018 Douglas Volz  Removed all category values
-- |  1.9     11 Dec 2020 Douglas Volz  Now for Standard, Lot Based Standard and Non-
-- |                                    Standard Asset Jobs.  Added another category.
-- |  1.10    26 Jan 2021 Douglas Volz  Check for unissued materials and WIP scrap controls
-- |  1.11    11 Feb 2021 Douglas Volz  Added parameter to include scrap for requirements
-- |  1.12    05 Mar 2021 Douglas Volz  Added parameter to include bulk items for requirements.
-- |  1.13    12 Mar 2021 Douglas Volz  Add logic to ignore Phantom WIP Supply Types as
-- |                                    these requirements are never issued.
-- |  1.14    15 Apr 2021 Douglas Volz  Added Date Released
-- |  1.15    10 Jul 2022 Douglas Volz  Added WIP Variance Percentage parameter.
-- |  1.16    21 Jan 2024 Douglas Volz  Bug fix for Pending Material and Pending Shop Floor
-- |                                    Move.  Remove tabs and add inventory access controls.
-- +=============================================================================+*/







-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-jobs-with-complete-status-which-are-ready-for-close/
-- Library Link: https://www.enginatics.com/reports/cac-wip-jobs-with-complete-status-which-are-ready-for-close/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        -- Revision for version 1.6
        -- 'p_date_completed' For_Completion_Date,
        wac.class_code WIP_Class,
        ml1.meaning Class_Type,
        we.wip_entity_name WIP_Job,
        ml2.meaning Job_Status,
        -- Revision for version 1.14
        wdj.date_released Date_Released,
        wdj.date_completed Date_Completed,
        wdj.last_update_date Last_Update_Date,
        wdj.completion_subinventory Completion_Subinventory,
        msiv.concatenated_segments  Assembly_Number,
        msiv.description Assembly_Description,
        -- Revision for version 1.14
        fcl.meaning Item_Type,
        misv.inventory_item_status_code Item_Status,
        ml3.meaning Make_Buy_Code,
        -- End revision for version 1.14
&category_columns
        -- Revision for version 1.10
        muomv.uom_code UOM_Code,
        nvl(wdj.start_quantity, 0) Start_Quantity,
        nvl(wdj.quantity_completed, 0) Quantity_Completed,
        nvl(wdj.quantity_scrapped, 0) Quantity_Scrapped,
        nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0) Total_Quantity,
        -- Check for completion quantities
        -- Revision for version 1.10, check if WIP scrap is financially recorded
        case 
          when (wdj.quantity_completed + decode(:p_include_scrap,'N',0, wdj.quantity_scrapped)) = 0
                then (select fl.meaning from fnd_lookups fl where fl.lookup_type = 'YES_NO_ALL' and fl.lookup_code = 'N')     -- No completion quantities
          when (wdj.start_quantity - (wdj.quantity_completed + decode(:p_include_scrap,'N',0, wdj.quantity_scrapped))) = 0
                then (select fl.meaning from fnd_lookups fl where fl.lookup_type = 'YES_NO_ALL' and fl.lookup_code = 'A')     -- All quantities completed
          when (wdj.start_quantity - (wdj.quantity_completed + decode(:p_include_scrap,'N',0, wdj.quantity_scrapped))) > 0
                then (select ml.meaning from mfg_lookups ml where ml.lookup_type = 'SYS_RANGE' and ml.lookup_code = 2)        -- Partial quantities completed
         else  (select fl.meaning from fnd_lookups fl where fl.lookup_type = 'YES_NO_ALL' and fl.lookup_code = 'A')            -- All quantities completed
        end Quantities_Completed,
         -- Revision for version 1.10, check for WIP with material quantities not issued
        (select max(fl.meaning)
         from   wip_requirement_operations wro,
                mtl_system_items_b msi,
                wip_parameters wp,
                fnd_lookups fl
         where  wro.wip_entity_id        = wdj.wip_entity_id 
         and    wro.organization_id      = wdj.organization_id
         and    msi.organization_id      = wro.organization_id
         and    msi.inventory_item_id    = wro.inventory_item_id
         -- Only want to check valued items, not expense items
         and    msi.inventory_asset_flag = 'Y'
         and    wp.organization_id       = wdj.organization_id
         and    fl.lookup_type           = 'YES_NO'
         and    fl.lookup_code           = 'Y'
         -- Revision for version 1.12
         and    2=2                      -- Include WIP bulk supply types
         -- Revision for version 1.13
         and    wro.wip_supply_type <> 6 -- Phantom
         -- Calculate the quantity required based on the completion quantities
         -- Use the completion quantities with scrap quantities unless scrap is not financially recorded
         -- Basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
         having round(sum(decode(wro.basis_type,
                                 null, nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
                                          (nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap,'N',0,nvl(wdj.quantity_scrapped, 0))),
                                 1,    nvl(wro.quantity_per_assembly, wdj.start_quantity) * 1 / nvl(wro.component_yield_factor, 1) *
                                          (nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap,'N',0,nvl(wdj.quantity_scrapped, 0))),
                                 2,    nvl(wro.required_quantity,1),
                                       nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
                                          (nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap,'N',0,nvl(wdj.quantity_scrapped, 0)))
                                )
                         )
                   ,3) - round(sum(nvl(wro.quantity_issued, 0)),3) > 0
        ) Open_Material_Quantities,  -- Quantity_Left_in_WIP
        -- End of revision for version 1.10
        -- Check for WIP Operation Resources with no earned OSP
        -- Revision for version 1.3
        -- nvl((select 'Yes'
        (select max(fl.meaning)
         from   wip_operation_resources wor,
                fnd_lookups fl
         where  wor.wip_entity_id = wdj.wip_entity_id 
         and    wor.organization_id = wdj.organization_id
         and    wor.autocharge_type in ( 3, 4 ) -- 3 = 'PO receipt' and 4 =  'PO move' 
         and    nvl(wor.applied_resource_units,0) = 0
         and    fl.lookup_type           = 'YES_NO'
         and    fl.lookup_code           = 'Y'
        ) No_Earned_OSP,
        gl.currency_code Currency_Code,
        round(
        sum(nvl(wpb.pl_material_in,0)-
            nvl(wpb.tl_material_out,0)-
            nvl(wpb.pl_material_out,0)-
            nvl(wpb.tl_material_var,0)-
            nvl(wpb.pl_material_var,0) +
        -- Material Overhead Balance 
            nvl(wpb.pl_material_overhead_in,0)-
            nvl(wpb.tl_material_overhead_out,0)-
            nvl(wpb.pl_material_overhead_out,0)-
            nvl(wpb.tl_material_overhead_var,0)-
            nvl(wpb.pl_material_overhead_var,0) +
        -- Resource Balance
            nvl(wpb.tl_resource_in,0)+
            nvl(wpb.pl_resource_in,0)-
            nvl(wpb.tl_resource_out,0)-
            nvl(wpb.pl_resource_out,0)-
            nvl(wpb.tl_resource_var,0)-
            nvl(wpb.pl_resource_var,0)+
        -- Outside Processing Balance
            nvl(wpb.tl_outside_processing_in,0)+
            nvl(wpb.pl_outside_processing_in,0)-
            nvl(wpb.tl_outside_processing_out,0)-
            nvl(wpb.pl_outside_processing_out,0)-
            nvl(wpb.tl_outside_processing_var,0)-
            nvl(wpb.pl_outside_processing_var,0) +
        -- Overhead Balance
            nvl(wpb.tl_overhead_in,0)+
            nvl(wpb.pl_overhead_in,0)-
            nvl(wpb.tl_overhead_out,0)-
            nvl(wpb.pl_overhead_out,0)-
            nvl(wpb.tl_overhead_var,0)-
            nvl(wpb.pl_overhead_var,0) +
        -- Estimated Scrap Balances
            nvl(wpb.tl_scrap_in,0)-
            nvl(wpb.tl_scrap_out,0)-
            nvl(wpb.tl_scrap_var,0)
        ),2) WIP_Value,
        -- Revision for version 1.15
        round(
                sum(nvl(wpb.pl_material_in,0)+
                    nvl(wpb.pl_material_overhead_in,0)+
                    nvl(wpb.tl_resource_in,0)+
                    nvl(wpb.pl_resource_in,0)+
                    nvl(wpb.tl_outside_processing_in,0)+
                    nvl(wpb.pl_outside_processing_in,0)+
                    nvl(wpb.tl_overhead_in,0)+
                    nvl(wpb.pl_overhead_in,0)+
                    nvl(wpb.tl_scrap_in,0)
                   )
              ) WIP_Costs_In,
        -- WIP variance percentage = WIP Net Value / WIP Costs In
        -- WIP Net Value
        round(
                sum(nvl(wpb.pl_material_in,0)-
                    nvl(wpb.tl_material_out,0)-
                    nvl(wpb.pl_material_out,0)-
                    nvl(wpb.tl_material_var,0)-
                    nvl(wpb.pl_material_var,0) +
                -- Material Overhead Balance 
                    nvl(wpb.pl_material_overhead_in,0)-
                    nvl(wpb.tl_material_overhead_out,0)-
                    nvl(wpb.pl_material_overhead_out,0)-
                    nvl(wpb.tl_material_overhead_var,0)-
                    nvl(wpb.pl_material_overhead_var,0) +
                -- Resource Balance
                    nvl(wpb.tl_resource_in,0)+
                    nvl(wpb.pl_resource_in,0)-
                    nvl(wpb.tl_resource_out,0)-
                    nvl(wpb.pl_resource_out,0)-
                    nvl(wpb.tl_resource_var,0)-
                    nvl(wpb.pl_resource_var,0)+
                -- Outside Processing Balance
                    nvl(wpb.tl_outside_processing_in,0)+
                    nvl(wpb.pl_outside_processing_in,0)-
                    nvl(wpb.tl_outside_processing_out,0)-
                    nvl(wpb.pl_outside_processing_out,0)-
                    nvl(wpb.tl_outside_processing_var,0)-
                    nvl(wpb.pl_outside_processing_var,0) +
                -- Overhead Balance
                    nvl(wpb.tl_overhead_in,0)+
                    nvl(wpb.pl_overhead_in,0)-
                    nvl(wpb.tl_overhead_out,0)-
                    nvl(wpb.pl_overhead_out,0)-
                    nvl(wpb.tl_overhead_var,0)-
                    nvl(wpb.pl_overhead_var,0) +
                -- Estimated Scrap Balances
                    nvl(wpb.tl_scrap_in,0)-
                    nvl(wpb.tl_scrap_out,0)-
                    nvl(wpb.tl_scrap_var,0)
                   ) /
        decode(
                sum(nvl(wpb.pl_material_in,0)+
                    nvl(wpb.pl_material_overhead_in,0)+
                    nvl(wpb.tl_resource_in,0)+
                    nvl(wpb.pl_resource_in,0)+
                    nvl(wpb.tl_outside_processing_in,0)+
                    nvl(wpb.pl_outside_processing_in,0)+
                    nvl(wpb.tl_overhead_in,0)+
                    nvl(wpb.pl_overhead_in,0)+
                    nvl(wpb.tl_scrap_in,0)
                   ), 0, 1,
                sum(nvl(wpb.pl_material_in,0)+
                    nvl(wpb.pl_material_overhead_in,0)+
                    nvl(wpb.tl_resource_in,0)+
                    nvl(wpb.pl_resource_in,0)+
                    nvl(wpb.tl_outside_processing_in,0)+
                    nvl(wpb.pl_outside_processing_in,0)+
                    nvl(wpb.tl_overhead_in,0)+
                    nvl(wpb.pl_overhead_in,0)+
                    nvl(wpb.tl_scrap_in,0)
                   )
              )
           ,3) * 100 WIP_Variance_Percent,
        -- End revision for version 1.15
        -- Check for Unprocessed Material
        -- Revision for version 1.3
        -- nvl((select 'Yes' 
        (select max(fl.meaning)
         from   mtl_material_transactions_temp mmtt,
                fnd_lookups fl
         where  mmtt.organization_id       = wdj.organization_id
         and    mmtt.transaction_source_type_id = 5
         and    mmtt.transaction_source_id = wdj.wip_entity_id
         and    fl.lookup_type             = 'YES_NO'
         and    fl.lookup_code             = 'Y'
        ) Unprocessed_Material,
        -- Check for Uncosted Material
        -- Revision for version 1.3
        -- nvl((select 'Yes' 
        (select max(fl.meaning)
         from   mtl_material_transactions mmt1,
                fnd_lookups fl
         where  mmt1.transaction_source_id = wdj.wip_entity_id 
         and    mmt1.organization_id       = wdj.organization_id
         and    mmt1.transaction_source_type_id = 5
         and    mmt1.costed_flag is not null
         and    fl.lookup_type             = 'YES_NO'
         and    fl.lookup_code             = 'Y'
        ) Uncosted_Material,
        -- Check for Pending WIP Costing
        -- Revision for version 1.3
        -- nvl((select 'Yes' 
        (select max(fl.meaning)
         from   wip_cost_txn_interface wcti,
                fnd_lookups fl
         where  wcti.wip_entity_id         = wdj.wip_entity_id 
         and    wcti.organization_id       = wdj.organization_id
         and    fl.lookup_type             = 'YES_NO'
         and    fl.lookup_code             = 'Y'
        ) Pending_WIP_Costing,
        -- Check for Pending Receiving
        -- Revision for version 1.3
        -- nvl((select 'Yes' 
        (select max(fl.meaning)
         from   rcv_transactions_interface rti,
                fnd_lookups fl
         where  rti.wip_entity_id          = wdj.wip_entity_id 
         and    rti.to_organization_id     = wdj.organization_id
         and    fl.lookup_type             = 'YES_NO'
         and    fl.lookup_code             = 'Y'
        ) Pending_Receiving,
        -- Revision for version 1.3
        -- Check for Pending Purchase Requisitions
        (select max(fl.meaning)
         from   po_requisitions_interface pri,
                wip_operation_resources wor,
                fnd_lookups fl
         where  pri.wip_entity_id          = wdj.wip_entity_id 
         and    pri.destination_organization_id = wdj.organization_id
         and    wor.wip_entity_id          = wdj.wip_entity_id 
         and    wor.organization_id        = wdj.organization_id
         and    wor.autocharge_type in ( 3, 4 ) -- 3 = 'PO receipt' and 4 =  'PO move' 
         -- Only for jobs with no applied resource units, to avoid
         -- selecting duplicate purchase requisition interface entries
         and    nvl(wor.applied_resource_units,0) = 0
         and    fl.lookup_type             = 'YES_NO'
         and    fl.lookup_code             = 'Y'
        ) Pending_Requisitions,
        -- Check for Pending Material
        -- Revision for version 1.3
        -- nvl((select 'Yes' 
        (select max(fl.meaning)
         from   mtl_transactions_interface mti,
                -- Revision for version 1.16
                -- wip_discrete_jobs wdj,
                fnd_lookups fl
         where  mti.transaction_source_id  = wdj.wip_entity_id 
         and    mti.organization_id        = wdj.organization_id
         and    mti.transaction_source_type_id = 5
         and    fl.lookup_type             = 'YES_NO'
         and    fl.lookup_code             = 'Y'
        ) Pending_Material,
        -- Check for Pending Shop Floor Move
        -- Revision for version 1.3
        -- nvl((select 'Yes' 
        (select max(fl.meaning)
         from   wip_move_txn_interface wmti,
                -- Revision for version 1.16
                -- wip_discrete_jobs wdj,
                fnd_lookups fl
         where  wmti.wip_entity_id         = wdj.wip_entity_id 
         and    wmti.organization_id       = wdj.organization_id
         and    fl.lookup_type             = 'YES_NO'
         and    fl.lookup_code             = 'Y'
        ) Pending_Shop_Floor_Move,
        -- Check for WSM Split Merge Transactions
         -- Uncosted WSM starting jobs
         -- Uncosted WSM resulting jobs
        (select max(fl.meaning)
         from   wsm_split_merge_transactions wsmt,
                wsm_sm_starting_jobs wssj, 
                wsm_sm_resulting_jobs wsrj,
                fnd_lookups fl
         where  ((wssj.wip_entity_id = wdj.wip_entity_id and wssj.organization_id = wdj.organization_id and wsmt.transaction_id = wssj.transaction_id)
                  or
                 (wsrj.wip_entity_id = wdj.wip_entity_id and wsrj.organization_id = wdj.organization_id and wsmt.transaction_id = wsrj.transaction_id) 
                )
         and    wsmt.costed <> 4
         and    fl.lookup_type             = 'YES_NO'
         and    fl.lookup_code             = 'Y'
        ) Uncosted_Split_Merge_Txn, 
        -- Check for WSM Split Merge Transactions
         -- Pending WSM Jobs Interface - starting_jobs
         -- Pending WSM Jobs Interface - resulting_jobs
        (select max(fl.meaning)
         from   wsm_split_merge_txn_interface wsmti,
                wsm_starting_jobs_interface wsji, 
                wsm_resulting_jobs_interface wrji,
                fnd_lookups fl
         where  ((      wsji.wip_entity_id   = wdj.wip_entity_id
                  and   wsji.organization_id = wdj.organization_id
                  and   wsmti.header_id      = wsji.header_id
                 )
                  or
                 (      wrji.wip_entity_name = we.wip_entity_name 
                  and   wrji.organization_id = we.organization_id
                  and   wsmti.header_id      = wrji.header_id
                 )
                )
         and    wsmti.process_status <> 4
         and    fl.lookup_type               = 'YES_NO'
         and    fl.lookup_code               = 'Y'
        ) Unprocessed_WSM_Txn_Interface,
        -- Check for Pending WSM Lots Interface - resulting_lots
        -- Revision for version 1.3
        -- nvl((select 'Yes' 
        (select max(fl.meaning)
         from   wsm_resulting_lots_interface wrli, 
                wsm_lot_split_merges_interface wlsmi,
                fnd_lookups fl
         where  wrli.wip_entity_id        = wdj.wip_entity_id
         and    wrli.organization_id      = wdj.organization_id
         and    wlsmi.header_id           = wrli.header_id
         and    wlsmi.wip_flag            = 1
         and    wlsmi.process_status     <> 4
         and    fl.lookup_type            = 'YES_NO'
         and    fl.lookup_code            = 'Y'
        ) Pending_Resulting_Lots,
        --Check for WSM_Lot_Job_Interface
        (select max(fl.meaning)
         from   wsm_lot_job_interface wlji,
                fnd_lookups fl
         where  wlji.wip_entity_id       = wdj.wip_entity_id
         and    wlji.organization_id     = wdj.organization_id
         and    wlji.process_status     <> 4
         and    fl.lookup_type           = 'YES_NO'
         and    fl.lookup_code           = 'Y'
        ) Pending_WSM_Job_Lots
from    wip_discrete_jobs wdj, 
        wip_entities we, 
        mtl_parameters mp, 
        -- Revision for version 1.10
        wip_parameters wp,
        wip_period_balances wpb,
        wip_accounting_classes wac,
        mtl_system_items_vl msiv,
        -- Revision for version 1.10
        mtl_units_of_measure_vl muomv,
        mfg_lookups ml1, -- Class Type
        mfg_lookups ml2, -- Job Status
        -- Revision for version 1.14
        mfg_lookups ml3, -- Planning Make Buy
        fnd_common_lookups fcl,
        mtl_item_status_vl misv,
        -- End revision for version 1.14
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,
        hr_all_organization_units_vl haou2,
        gl_ledgers gl,
        (-- Revision for version 1.4
         -- Add a group by, need one row per WIP Entity ID
         -- to avoid cross-joining
         -- Revision for version 1.1 
         -- Interface select statements for WIP Jobs
         -- Check for Unprocessed Material
         select wip_interface_errs.wip_entity_id
         from   (
                 select wcti.wip_entity_id wip_entity_id
                 from   wip_cost_txn_interface wcti
                 union all
                 -- Check for Pending Receiving
                 select rti.wip_entity_id
                 from   rcv_transactions_interface rti
                 where  rti.wip_entity_id is not null
                 union all
                 -- Check for Pending Material
                 select mti.transaction_source_id
                 from   mtl_transactions_interface mti
                 where  mti.transaction_source_type_id = 5
                 union all
                 -- Check for Pending Shop Floor Move
                 select wmti.wip_entity_id
                 from   wip_move_txn_interface wmti
                 union all
                 -- Check for WSM Split Merge Transactions
                 select  WSM.wip_entity_id
                 from        
                        -- Uncosted WSM starting jobs
                        (select wssj.wip_entity_id wip_entity_id
                         from   wsm_sm_starting_jobs wssj, 
                                wsm_split_merge_transactions wsmt
                         where  wsmt.transaction_id = wssj.transaction_id
                         and    wsmt.costed <> 4
                         union all
                         -- Uncosted WSM resulting jobs
                         select wsrj.wip_entity_id wip_entity_id
                         from   wsm_sm_resulting_jobs wsrj, 
                                wsm_split_merge_transactions wsmt
                         where  wsmt.transaction_id   = wsrj.transaction_id
                         and    wsmt.costed          <> 4 
                        ) WSM
                 union all
                 -- Check for WSM Split Merge Interface Transactions
                 select  WSMI.wip_entity_id
                 from        
                        -- Pending WSM Jobs Interface - starting_jobs
                        (select wsji.wip_entity_id wip_entity_id
                         from   wsm_starting_jobs_interface wsji, 
                                wsm_split_merge_txn_interface wsmti
                         where  wsmti.header_id = wsji.header_id
                         and    wsmti.process_status <> 4
                        union all
                        -- Pending WSM Jobs Interface - resulting_jobs
                         select we.wip_entity_id wip_entity_id
                         from   wip_entities we, 
                                wsm_resulting_jobs_interface wrji, 
                                wsm_split_merge_txn_interface wsmti
                         where  wrji.wip_entity_name = we.wip_entity_name
                         and    wrji.organization_id = we.organization_id
                         and    wsmti.header_id = wrji.header_id
                         and    wsmti.process_status <> 4
                        ) WSMI
                 union all
                 -- Check for Pending WSM Lots Interface - resulting_lots
                 select wrli.wip_entity_id
                 from   wsm_resulting_lots_interface wrli, 
                        wsm_lot_split_merges_interface wlsmi
                 where  wlsmi.header_id = wrli.header_id
                 and    wlsmi.wip_flag = 1
                 and    wlsmi.process_status <> 4
                 union all
                 --Check for WSM_Lot_Job_Interface
                 select wlji.wip_entity_id
                 from   wsm_lot_job_interface wlji
                 where  wlji.process_status <> 4
                 -- Revision for version 1.3
                 union all
                 -- Check for Pending Purchase Requisitions
                 select pri.wip_entity_id
                 from   po_requisitions_interface pri,
                        wip_operation_resources wor,
                        wip_discrete_jobs wdj
                 where  pri.wip_entity_id = wor.wip_entity_id  
                 and    pri.destination_organization_id = wor.organization_id
                 and    wor.autocharge_type in ( 3, 4 ) -- 3 = 'PO receipt' and 4 =  'PO move' 
                 -- Only for jobs with no applied resource units, to avoid
                 -- selecting duplicate purchase requisition interface entries
                 and    nvl(wor.applied_resource_units,0) = 0
                 and    wdj.wip_entity_id = wor.wip_entity_id
                 and    wdj.date_closed is null
                 -- End revision for version 1.3
                ) wip_interface_errs
                 group by wip_interface_errs.wip_entity_id
        ) wip_interfaces
-- WIP Joins
where   wdj.date_completed is not null -- wdj.status_type = 4
and     wdj.date_closed is null
and     wdj.status_type                  = 4 -- Complete
and     we.wip_entity_id                 = wdj.wip_entity_id
and     mp.organization_id               = wdj.organization_id
-- Revision for version 1.10
and     wp.organization_id               = wdj.organization_id
and     wpb.wip_entity_id                = wdj.wip_entity_id
and     wpb.organization_id              = wdj.organization_id
and     wac.class_code                   = wdj.class_code
and     wac.organization_id              = wdj.organization_id
and     wac.class_type in (1,3,5) 
-- ================================
-- 1 Standard Discrete 
-- 2 Repetitive Assembly 
-- 3 Asset Non-standard 
-- 4 Expense Non-standard 
-- 5 Standard Lot Based 
-- 6 Maintenance 
-- 7 Expense Non-standard Lot Based
-- ================================
-- WIP Joins to WIP Interfaces
and     wip_interfaces.wip_entity_id (+) = wdj.wip_entity_id
-- Item Master Joins
and     msiv.organization_id             = wdj.organization_id
and     msiv.inventory_item_id           = wdj.primary_item_id
-- Revision for version 1.14
and     msiv.inventory_item_status_code  = misv.inventory_item_status_code
-- Revision for version 1.10
and     msiv.primary_uom_code            = muomv.uom_code
-- Lookup Joins
and     ml1.lookup_type                  = 'WIP_CLASS_TYPE'
and     ml1.lookup_code                  = wac.class_type
and     ml2.lookup_type                  = 'WIP_JOB_STATUS'
and     ml2.lookup_code                  = wdj.status_type
-- Revision for version 1.14
and     ml3.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml3.lookup_code                 = msiv.planning_make_buy_code
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv.item_type
-- End revision for version 1.14
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and     hoi.org_information_context      = 'Accounting Information'
and     hoi.organization_id              = mp.organization_id
and     hoi.organization_id              = haou.organization_id   -- this gets the organization name
and     haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.16
and     mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     1=1                              -- p_assembly_number, p_wip_job, p_wip_class_code, p_org_code, p_operating_unit, p_ledger
-- Same joins as the view
-- Quantities Completed
and     (wdj.start_quantity - (wdj.quantity_completed + decode(:p_include_scrap,'N',0, wdj.quantity_scrapped))) <= 0
-- Unprocessed Material
and not exists 
        (select 1
         from   mtl_material_transactions_temp mmtt
         where  mmtt.organization_id            = wdj.organization_id
         and    mmtt.transaction_source_type_id = 5
         and    mmtt.transaction_source_id      = wdj.wip_entity_id)
-- Uncosted Material
and not exists 
        (select 1
         from   mtl_material_transactions mmt1
         where  mmt1.transaction_source_id      = wdj.wip_entity_id 
         and    mmt1.organization_id            = wdj.organization_id
         and    mmt1.transaction_source_type_id = 5
         and    mmt1.costed_flag is not null)
-- Uncosted WSM starting_jobs
and not exists
        (select 1
         from   wsm_sm_starting_jobs wssj, 
                wsm_split_merge_transactions wsmt
         where  wssj.wip_entity_id              = wdj.wip_entity_id 
         and    wssj.organization_id            = wdj.organization_id
         and    wsmt.transaction_id             = wssj.transaction_id
         and    wsmt.costed                    <> 4)
-- Uncosted WSM resulting_jobs
and not exists
        (select 1
         from   wsm_sm_resulting_jobs wsrj, 
                wsm_split_merge_transactions wsmt
         where  wsrj.wip_entity_id              = wdj.wip_entity_id 
         and    wsrj.organization_id            = wdj.organization_id
         and    wsmt.transaction_id             = wsrj.transaction_id
         and    wsmt.costed                    <> 4)
-- Pending WIP Costing
and not exists
        (select 1
         from   wip_cost_txn_interface wcti
         where  wcti.wip_entity_id              = wdj.wip_entity_id 
         and    wcti.organization_id            = wdj.organization_id )
-- Pending WSM Jobs Interface - starting_jobs
and not exists
        (select 1
         from   wsm_starting_jobs_interface wsji, 
                wsm_split_merge_txn_interface wsmti
         where  wsji.wip_entity_id              = wdj.wip_entity_id 
         and    wsji.organization_id            = wdj.organization_id
         and    wsmti.header_id                 = wsji.header_id
         and    wsmti.process_status           <> 4)
-- Pending WSM Jobs Interface - resulting_jobs
and not exists
        (select 1
         from   wsm_resulting_jobs_interface wrji, 
                wsm_split_merge_txn_interface wsmti
         where  we.wip_entity_id                = wdj.wip_entity_id
         and    wrji.wip_entity_name            = we.wip_entity_name 
         and    wrji.organization_id            = we.organization_id
         and    wsmti.header_id                 = wrji.header_id
         and    wsmti.process_status           <> 4)
-- Pending WSM Lots Interface - resulting_lots
and not exists
        (select 1
         from   wsm_resulting_lots_interface wrli, 
                wsm_lot_split_merges_interface wlsmi
         where  wrli.wip_entity_id              = wdj.wip_entity_id
         and    wrli.organization_id            = wdj.organization_id
         and    wlsmi.header_id                 = wrli.header_id
         and    wlsmi.wip_flag                  = 1
         and    wlsmi.process_status           <> 4)
-- WSM_Lot_Job_Interface
and not exists
        (select 1
         from   wsm_lot_job_interface wlji
         where  wlji.wip_entity_id              = wdj.wip_entity_id
         and    wlji.organization_id            = wdj.organization_id
         and    wlji.process_status            <> 4)
-- Pending Receiving
and not exists
        (select 1
         from   rcv_transactions_interface rti
         where  rti.wip_entity_id               = wdj.wip_entity_id 
         and    rti.to_organization_id          = wdj.organization_id )
-- Pending Material
and not exists
        (select 1
         from   mtl_transactions_interface mti
         where  mti.transaction_source_id       = wdj.wip_entity_id 
         and    mti.organization_id             = wdj.organization_id
         and    mti.transaction_source_type_id  = 5
         and    process_flag <> 9)
-- Pending Shop Floor Move
and not exists 
        (select 1
         from   wip_move_txn_interface wmti
         where  wmti.wip_entity_id              = wdj.wip_entity_id 
         and    wmti.organization_id            = wdj.organization_id)
-- WIP Operation Resources with no earned OSP
and not exists 
        (select 1
         from   wip_operation_resources wor
         where  wor.wip_entity_id               = wdj.wip_entity_id
         and    wor.organization_id             = wdj.organization_id
         and    wor.autocharge_type in ( 3, 4 )
         and    nvl(wor.applied_resource_units,0) = 0)
-- WIP with material quantities not issued
and not exists 
        (select 1
         from   wip_requirement_operations wro,
                mtl_system_items_b msi,
                wip_parameters wp
         where  wro.wip_entity_id        = wdj.wip_entity_id 
         and    wro.organization_id      = wdj.organization_id
         and    msi.organization_id      = wro.organization_id
         and    msi.inventory_item_id    = wro.inventory_item_id
         -- Only want to check valued items, not expense items
         and    msi.inventory_asset_flag = 'Y'
         and    wp.organization_id       = wdj.organization_id
         -- Revision for version 1.12
         and    2=2                      -- Include WIP bulk supply types
         -- Revision for version 1.13
         and    wro.wip_supply_type     <> 6 -- Phantom
         -- Calculate the quantity required based on the completion quantities
         -- Use the completion quantities with scrap quantities unless scrap is not financially recorded
         -- Basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
         and    round(decode(wro.basis_type,
                                null, nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
                                         (nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap,'N',0,nvl(wdj.quantity_scrapped, 0))),
                                1,    nvl(wro.quantity_per_assembly, wdj.start_quantity) * 1 / nvl(wro.component_yield_factor, 1) *
                                         (nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap,'N',0,nvl(wdj.quantity_scrapped, 0))),
                                2,    nvl(wro.required_quantity,1),
                                      nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
                                         (nvl(wdj.quantity_completed, 0) + decode(:p_include_scrap,'N',0,nvl(wdj.quantity_scrapped, 0)))
                            )
                   ,3) - round(nvl(wro.quantity_issued, 0),3) > 0 -- Quantity_Left_in_WIP
        )
group by
        nvl(gl.short_name, gl.name),
        haou2.name,
        mp.organization_code,
        -- Revision for version 1.6
        -- 'p_date_completed',
        we.wip_entity_name,
        wac.class_code,
        ml1.meaning, -- Class Type
        we.wip_entity_name,
        we.organization_id,
        ml2.meaning, -- Job Status
        -- Revision for version 1.14
        wdj.date_released,
        -- Revision for version 1.2
        -- decode(wdj.attribute15, null, 'No', 'Yes'),
        wdj.date_completed,
        wdj.last_update_date,
        wdj.completion_subinventory,
        msiv.concatenated_segments,
        msiv.description,
        -- Revision for version 1.14
        fcl.meaning, -- Item Type
        misv.inventory_item_status_code, -- Item Status
        ml3.meaning, -- Make Buy Code
        -- End revision for version 1.14
        wdj.start_quantity,
        wdj.quantity_completed,
        wdj.quantity_scrapped,
        wp.mandatory_scrap_flag,
        -- Revision for version 1.10
        muomv.uom_code,
        gl.currency_code,
        -- Needed for inline queries
        msiv.inventory_item_id,
        msiv.organization_id,
        wdj.organization_id,
        wdj.wip_entity_id,
        -- Revision for version 1.1
        wip_interfaces.wip_entity_id
-- ===========================================
-- Check for variance tolerances
-- ===========================================
having  abs(sum(nvl(wpb.pl_material_in,0)-
            nvl(wpb.tl_material_out,0)-
            nvl(wpb.pl_material_out,0)-
            nvl(wpb.tl_material_var,0)-
            nvl(wpb.pl_material_var,0) +
        -- Material Overhead Balance 
            nvl(wpb.pl_material_overhead_in,0)-
            nvl(wpb.tl_material_overhead_out,0)-
            nvl(wpb.pl_material_overhead_out,0)-
            nvl(wpb.tl_material_overhead_var,0)-
            nvl(wpb.pl_material_overhead_var,0) +
        -- Resource Balance
            nvl(wpb.tl_resource_in,0)+
            nvl(wpb.pl_resource_in,0)-
            nvl(wpb.tl_resource_out,0)-
            nvl(wpb.pl_resource_out,0)-
            nvl(wpb.tl_resource_var,0)-
            nvl(wpb.pl_resource_var,0)+
        -- Outside Processing Balance
            nvl(wpb.tl_outside_processing_in,0)+
            nvl(wpb.pl_outside_processing_in,0)-
            nvl(wpb.tl_outside_processing_out,0)-
            nvl(wpb.pl_outside_processing_out,0)-
            nvl(wpb.tl_outside_processing_var,0)-
            nvl(wpb.pl_outside_processing_var,0) +
        -- Overhead Balance
            nvl(wpb.tl_overhead_in,0)+
            nvl(wpb.pl_overhead_in,0)-
            nvl(wpb.tl_overhead_out,0)-
            nvl(wpb.pl_overhead_out,0)-
            nvl(wpb.tl_overhead_var,0)-
            nvl(wpb.pl_overhead_var,0) +
        -- Estimated Scrap Balances
            nvl(wpb.tl_scrap_in,0)-
            nvl(wpb.tl_scrap_out,0)-
            -- Revision for version 1.6
            nvl(wpb.tl_scrap_var,0))) <  :p_wip_var_threshold
-- Revision for version 1.15
and     -- Revision for version 1.15
        -- WIP variance percentage = WIP Net Value / WIP Costs In
        -- WIP Net Value
        abs(round(
                sum(nvl(wpb.pl_material_in,0)-
                    nvl(wpb.tl_material_out,0)-
                    nvl(wpb.pl_material_out,0)-
                    nvl(wpb.tl_material_var,0)-
                    nvl(wpb.pl_material_var,0) +
                -- Material Overhead Balance 
                    nvl(wpb.pl_material_overhead_in,0)-
                    nvl(wpb.tl_material_overhead_out,0)-
                    nvl(wpb.pl_material_overhead_out,0)-
                    nvl(wpb.tl_material_overhead_var,0)-
                    nvl(wpb.pl_material_overhead_var,0) +
                -- Resource Balance
                    nvl(wpb.tl_resource_in,0)+
                    nvl(wpb.pl_resource_in,0)-
                    nvl(wpb.tl_resource_out,0)-
                    nvl(wpb.pl_resource_out,0)-
                    nvl(wpb.tl_resource_var,0)-
                    nvl(wpb.pl_resource_var,0)+
                -- Outside Processing Balance
                    nvl(wpb.tl_outside_processing_in,0)+
                    nvl(wpb.pl_outside_processing_in,0)-
                    nvl(wpb.tl_outside_processing_out,0)-
                    nvl(wpb.pl_outside_processing_out,0)-
                    nvl(wpb.tl_outside_processing_var,0)-
                    nvl(wpb.pl_outside_processing_var,0) +
                -- Overhead Balance
                    nvl(wpb.tl_overhead_in,0)+
                    nvl(wpb.pl_overhead_in,0)-
                    nvl(wpb.tl_overhead_out,0)-
                    nvl(wpb.pl_overhead_out,0)-
                    nvl(wpb.tl_overhead_var,0)-
                    nvl(wpb.pl_overhead_var,0) +
                -- Estimated Scrap Balances
                    nvl(wpb.tl_scrap_in,0)-
                    nvl(wpb.tl_scrap_out,0)-
                    nvl(wpb.tl_scrap_var,0)
                   ) /
        -- WIP Costs In
        decode(
                sum(nvl(wpb.pl_material_in,0)+
                    nvl(wpb.pl_material_overhead_in,0)+
                    nvl(wpb.tl_resource_in,0)+
                    nvl(wpb.pl_resource_in,0)+
                    nvl(wpb.tl_outside_processing_in,0)+
                    nvl(wpb.pl_outside_processing_in,0)+
                    nvl(wpb.tl_overhead_in,0)+
                    nvl(wpb.pl_overhead_in,0)+
                    nvl(wpb.tl_scrap_in,0)
                   ), 0, 1,
                sum(nvl(wpb.pl_material_in,0)+
                    nvl(wpb.pl_material_overhead_in,0)+
                    nvl(wpb.tl_resource_in,0)+
                    nvl(wpb.pl_resource_in,0)+
                    nvl(wpb.tl_outside_processing_in,0)+
                    nvl(wpb.pl_outside_processing_in,0)+
                    nvl(wpb.tl_overhead_in,0)+
                    nvl(wpb.pl_overhead_in,0)+
                    nvl(wpb.tl_scrap_in,0)
                   )
              )
           ,3)) * 100 <  :p_wip_var_percent