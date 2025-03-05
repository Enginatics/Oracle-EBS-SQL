/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Account Value
-- Description: Report to show WIP values and all accounts for discrete manufacturing, in summary by inventory, organization, with WIP class, job status, name and other details.  This report uses the valuation accounts from each discrete job and reports both jobs which were open during the accounting period as well as jobs closed during the accounting period.  You can also run this report for earlier accounting periods and still get the correct amounts and the jobs that were open at that time.

Parameters
==========
Period Name:  the accounting period you wish to report (mandatory).
Include Expense WIP:  enter Yes to include Expense WIP jobs.  Defaults to No.
Category Sets 1 - 3:  any item category you wish (optional).
Item Number:  specific item you wish to report (optional)
Organization Code:  specific inventory organization to report (optional)
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)

/* +=============================================================================+
-- |  Copyright 2009 - 2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this permission. 
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     29 Oct 2009 Douglas Volz   Based on XXX_WIP_VALUE_REPT.sql
-- |  1.13    22 May 2017 Douglas Volz   Added cost item category
-- |  1.14    10 Jul 2017 Douglas Volz   Added column to indicate a WIP job was converted
-- |                                     from the Legacy Systems
-- |  1.15    26 Jul 2018 Douglas Volz   Modified for chart of accounts and for categories
-- |  1.16    04 Dec 2018 Douglas Volz   Modified for chart of accounts and removed converted 
-- |                                     job column. Fixed outer join for completion subinventories
-- |  1.17    19 Jun 2019 Douglas Volz   Changed to G/L short name, for brevity, added
-- |                                     inventory category.  Added Date Released column.
-- |  1.17    19 Jun 2019 Douglas Volz   Changed to G/L short name, for brevity, added
-- |                                     inventory category.  Added Date Released column.
-- |  1.18    24 Oct 2019 Douglas Volz   Added aging dates, creation date and date released columns
-- |  1.19    06 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters.
-- |  1.20    24 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, item categories and operating units.
-- |                                     And put the WIP Costs In, WIP Costs Out, WIP
-- |                                     Relief and WIP Value as the last report columns.
-- |                                     Add Project Number and Project Name columns.
-- |  1.21    17 Aug 2020 Douglas Volz   Change categories to use category_concat_segs not segment1
-- |  1.22    09 Oct 2020 Douglas Volz   Added unit of measure column
-- |  1.23    13 Mar 2022 Douglas Volz   Added WIP job description column.
-- |  1.24    27 Feb 2025 Douglas Volz   Removed tabs, fixed OU and GL security profiles.
+=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-account-value/
-- Library Link: https://www.enginatics.com/reports/cac-wip-account-value/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        wip_value.period_name Period_Name,
        gcc.concatenated_segments Accounts,
        &segment_columns
        wip_value.class_code WIP_Class,
        ml2.meaning Class_Type,
        we.wip_entity_name WIP_Job,
        -- Revision for version 1.23
        regexp_replace(we.description,'[^[:alnum:]'' '']', null) Job_Description,
        wip_value.status Job_Status,
        -- Revision for version 1.18
        we.creation_date Creation_Date,
        -- Revision for version 1.8
        wip_value.scheduled_start_date Scheduled_Start_Date,
        -- Revision for version 1.17
        wip_value.date_released Date_Released,
        wip_value.date_completed Date_Completed,
        wip_value.date_closed Date_Closed,
        -- Revision for version 1.18
        case 
         when (wip_value.schedule_close_date - we.creation_date) < 31  then '30 days'
         when (wip_value.schedule_close_date - we.creation_date) < 61  then '60 days'
         when (wip_value.schedule_close_date - we.creation_date) < 91  then '90 days'
         when (wip_value.schedule_close_date - we.creation_date) < 121 then '120 days'
         when (wip_value.schedule_close_date - we.creation_date) < 151 then '150 days'
         when (wip_value.schedule_close_date - we.creation_date) < 181 then '180 days'
         else 'Over 180 days'
        end Aged_Creation_Date,
        case 
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - nvl(wip_value.date_released,(nvl(wip_value.date_completed,sysdate)))) < 31  then '30 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - nvl(wip_value.date_released,(nvl(wip_value.date_completed,sysdate)))) < 61  then '60 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - nvl(wip_value.date_released,(nvl(wip_value.date_completed,sysdate)))) < 91  then '90 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - nvl(wip_value.date_released,(nvl(wip_value.date_completed,sysdate)))) < 121 then '120 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - nvl(wip_value.date_released,(nvl(wip_value.date_completed,sysdate)))) < 151 then '150 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - nvl(wip_value.date_released,(nvl(wip_value.date_completed,sysdate)))) < 181 then '180 days'
         else 'Over 180 days'
        end Aged_Compln_vs_Release_Date,
        case 
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - we.creation_date) < 31  then '30 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - we.creation_date) < 61  then '60 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - we.creation_date) < 91  then '90 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - we.creation_date) < 121 then '120 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - we.creation_date) < 151 then '150 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - we.creation_date) < 181 then '180 days'
         else 'Over 180 days'
        end Aged_Compln_vs_Creation_Date,
        -- End revision for version 1.18
        -- Revision for version 1.8 and 1.22
        muomv.uom_code UOM_Code,
        wip_value.start_quantity Start_Quantity,
        wip_value.quantity_completed Quantity_Completed,
        wip_value.quantity_scrapped Quantity_Scrapped,
        wip_value.quantity_completed + quantity_scrapped Total_Quantity,
        wip_value.completion_subinventory Completion_Subinventory,
        -- Revision for version 1.12
        msub.description Subinventory_Description,
        msiv.concatenated_segments  Item_Number,
        msiv.description Item_Description,
        fcl.meaning Item_Type,
        -- Revision for version 1.13
&category_columns
        -- Revision for version 1.20
        pp.segment1 Project_Number,
        pp.name Project_Name,
        wip_value.lot_number Lot_Number,
        gl.currency_code Currency_Code,
        sum(wip_value.wip_matl_value) WIP_Material_Value,
        sum(wip_value.wip_moh_value) WIP_Material_Overhead_Value,
        sum(wip_value.wip_res_value) WIP_Resource_Value,
        sum(wip_value.wip_osp_value) WIP_Outside_Processing_Value,
        sum(wip_value.wip_ovhd_value) WIP_Overhead_Value,
        sum(wip_value.wip_scrap_value) WIP_Scrap_Value,
        sum(wip_value.wip_costs_in) WIP_Costs_In,
        sum(wip_value.wip_costs_out) WIP_Costs_Out,
        sum(wip_value.wip_relief) WIP_Relief,
        sum(wip_value.wip_value) WIP_Value
from    gl_ledgers gl,
        gl_code_combinations_kfv gcc,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2, -- operating unit
        mtl_system_items_vl msiv,
        -- Revision for version 1.22
        mtl_units_of_measure_vl muomv,
        -- Revision for version 1.20
        pa_projects_all pp,
        mtl_parameters mp,
        wip_accounting_classes wac,
        wip_entities we,
        -- Revision for version 1.12
        mtl_secondary_inventories msub,
        mfg_lookups ml2,
        fnd_common_lookups fcl,
        -- ===========================================
        -- Inline table select for WIP Period Balances
        -- ===========================================
        -- =====================================================
        -- First get the material value for the WIP Jobs
        -- =====================================================
        (select oap.period_name period_name,
                -- Revision for version 1.18
                oap.schedule_close_date,
                wpb.acct_period_id acct_period_id,
                wpb.organization_id organization_id,
                wdj.material_account code_combination_id,
                wdj.class_code class_code,
                wdj.wip_entity_id wip_entity_id,
                ml.meaning status,
                -- Revision for version 1.8
                wdj.scheduled_start_date,
                -- Revision for version 1.17
                wdj.date_released,
                wdj.date_completed date_completed,
                wdj.date_closed date_closed,
                -- Revision for version 1.14
                decode(wdj.attribute13, null, 'No', 'Yes') converted_job,
                wdj.start_quantity start_quantity,
                wdj.quantity_completed quantity_completed,
                wdj.quantity_scrapped quantity_scrapped,
                -- Revision for version 1.9
                wdj.completion_subinventory completion_subinventory,
                wdj.primary_item_id inventory_item_id,
                -- Revision for version 1.20
                wdj.project_id,
                -- Revision for version 1.8
                wdj.lot_number,
                sum(nvl(wpb.pl_material_in,0)) wip_costs_in,
                sum(nvl(wpb.tl_material_out,0) +
                    nvl(wpb.pl_material_out,0)) wip_costs_out,
                sum(nvl(wpb.tl_material_var,0)+
                    nvl(wpb.pl_material_var,0)) wip_relief,
                sum(nvl(wpb.pl_material_in,0)-
                    nvl(wpb.tl_material_out,0)-
                    nvl(wpb.pl_material_out,0)-
                    nvl(wpb.tl_material_var,0)-
                    nvl(wpb.pl_material_var,0)) wip_value,
                -- Revision for version 1.9
                sum(nvl(wpb.pl_material_in,0)-
                    nvl(wpb.tl_material_out,0)-
                    nvl(wpb.pl_material_out,0)-
                    nvl(wpb.tl_material_var,0)-
                    nvl(wpb.pl_material_var,0)) wip_matl_value,
                sum(0) wip_moh_value,
                sum(0) wip_res_value,
                sum(0) wip_osp_value,
                sum(0) wip_ovhd_value,
                sum(0) wip_scrap_value
                -- End revision for version 1.9
         from   wip_period_balances wpb,
                wip_discrete_jobs wdj,
                org_acct_periods oap,
                mfg_lookups ml
         -- ===========================================
         -- WIP Job Entity and accounting period joins
         -- ===========================================
         where  wpb.wip_entity_id         = wdj.wip_entity_id
         -- bug fix for version 1.1
         -- and     wpb.acct_period_id        = oap.acct_period_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id 
         -- end fix for version 1.1
         and    4=4                      -- p_period_name
         -- ===========================================
         -- Inventory accounting period joins to limit
         -- to wip activity within the accounting period.
         -- ===========================================
         -- Limit to jobs closed after the period start date
         and    nvl(trunc(wdj.date_closed), oap.period_start_date) >= oap.period_start_date
         -- ===========================================
         -- Lookup Code joins
         -- ===========================================
         and    ml.lookup_type              = 'WIP_JOB_STATUS'
         and    ml.lookup_code              = wdj.status_type        
         group by
                oap.period_name,
                -- Revision for version 1.18
                oap.schedule_close_date,
                wpb.acct_period_id,
                wpb.organization_id,
                wdj.material_account,
                wdj.class_code,
                wdj.wip_entity_id,
                ml.meaning,
                -- Revision for version 1.8
                wdj.scheduled_start_date,
                -- Revision for version 1.17
                wdj.date_released,
                wdj.date_completed,
                wdj.date_closed,
                -- Revision for version 1.14
                decode(wdj.attribute13, null, 'No', 'Yes'),
                wdj.start_quantity,
                wdj.quantity_completed,
                wdj.quantity_scrapped,
                -- Revision for version 1.9
                wdj.completion_subinventory,
                wdj.primary_item_id,
                -- Revision for version 1.20
                wdj.project_id,
                -- Revision for version 1.8
                wdj.lot_number
         -- =====================================================
         -- Now get the material overhead Value for the WIP Jobs
         -- =====================================================
         union all
         select oap.period_name period_name,
                -- Revision for version 1.18
                oap.schedule_close_date,
                wpb.acct_period_id acct_period_id,
                wpb.organization_id organization_id,
                wdj.material_overhead_account code_combination_id,
                wdj.class_code class_code,
                wdj.wip_entity_id wip_entity_id,
                ml.meaning status,
                -- Revision for version 1.8
                wdj.scheduled_start_date,
                -- Revision for version 1.17
                wdj.date_released,
                wdj.date_completed date_completed,
                wdj.date_closed date_closed,
                -- Revision for version 1.14
                decode(wdj.attribute13, null, 'No', 'Yes') converted_job,
                wdj.start_quantity start_quantity,
                wdj.quantity_completed quantity_completed,
                wdj.quantity_scrapped quantity_scrapped,
                -- Revision for version 1.9
                wdj.completion_subinventory,
                wdj.primary_item_id inventory_item_id,
                -- Revision for version 1.20
                wdj.project_id,
                -- Revision for version 1.8
                wdj.lot_number,
                sum(nvl(wpb.pl_material_overhead_in,0))  wip_costs_in,
                sum(nvl(wpb.tl_material_overhead_out,0)+
                    nvl(wpb.pl_material_overhead_out,0)) wip_costs_out,
                sum(nvl(wpb.tl_material_overhead_var,0)+
                    nvl(wpb.pl_material_overhead_var,0)) wip_relief,
                 sum(nvl(wpb.pl_material_overhead_in,0)-
                    nvl(wpb.tl_material_overhead_out,0)-
                    nvl(wpb.pl_material_overhead_out,0)-
                    nvl(wpb.tl_material_overhead_var,0)-
                    nvl(wpb.pl_material_overhead_var,0)) wip_value,
                -- Revision for version 1.9
                sum(0) wip_matl_value,
                 sum(nvl(wpb.pl_material_overhead_in,0)-
                    nvl(wpb.tl_material_overhead_out,0)-
                    nvl(wpb.pl_material_overhead_out,0)-
                    nvl(wpb.tl_material_overhead_var,0)-
                    nvl(wpb.pl_material_overhead_var,0)) wip_moh_value,
                sum(0) wip_res_value,
                sum(0) wip_osp_value,
                sum(0) wip_ovhd_value,
                sum(0) wip_scrap_value
                -- End revision for version 1.9
         from   wip_period_balances wpb,
                wip_discrete_jobs wdj,
                org_acct_periods oap,
                mfg_lookups ml
         -- ===========================================
         -- WIP Job Entity and accounting period joins
         -- ===========================================
         where  wpb.wip_entity_id         = wdj.wip_entity_id
         -- bug fix for version 1.1
         -- and    wpb.acct_period_id        = oap.acct_period_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id 
         -- end fix for version 1.1
         and    4=4                      -- p_period_name
         -- ===========================================
         -- Inventory accounting period joins to limit
         -- to wip activity within the accounting period.
         -- ===========================================
         -- Limit to jobs closed after the period start date
         and    nvl(trunc(wdj.date_closed), oap.period_start_date) >= oap.period_start_date
         -- ===========================================
         -- Lookup Code joins
         -- ===========================================
         and    ml.lookup_type              = 'WIP_JOB_STATUS'
         and    ml.lookup_code              = wdj.status_type        
         group by
                oap.period_name,
                -- Revision for version 1.18
                oap.schedule_close_date,
                wpb.acct_period_id,
                wpb.organization_id,
                wdj.material_overhead_account,
                wdj.class_code,
                wdj.wip_entity_id,
                ml.meaning,
                -- Revision for version 1.8
                wdj.scheduled_start_date,
                -- Revision for version 1.17
                wdj.date_released,
                wdj.date_completed,
                wdj.date_closed,
                -- Revision for version 1.14
                decode(wdj.attribute13, null, 'No', 'Yes'),
                wdj.start_quantity,
                wdj.quantity_completed,
                wdj.quantity_scrapped,
                -- Revision for version 1.9
                wdj.completion_subinventory,
                wdj.primary_item_id,
                -- Revision for version 1.20
                wdj.project_id,
                -- Revision for version 1.8
                wdj.lot_number
         -- =====================================================
         -- Now get the resource Value for the WIP Jobs
         -- =====================================================
         union all
         select oap.period_name period_name,
                -- Revision for version 1.18
                oap.schedule_close_date,
                wpb.acct_period_id acct_period_id,
                wpb.organization_id organization_id,
                wdj.resource_account code_combination_id,
                wdj.class_code class_code,
                wdj.wip_entity_id wip_entity_id,
                ml.meaning status,
                -- Revision for version 1.8
                wdj.scheduled_start_date,
                -- Revision for version 1.17
                wdj.date_released,
                wdj.date_completed date_completed,
                wdj.date_closed date_closed,
                -- Revision for version 1.14
                decode(wdj.attribute13, null, 'No', 'Yes') converted_job,
                wdj.start_quantity start_quantity,
                wdj.quantity_completed quantity_completed,
                wdj.quantity_scrapped quantity_scrapped,
                -- Revision for version 1.9
                wdj.completion_subinventory,
                wdj.primary_item_id inventory_item_id,
                -- Revision for version 1.20
                wdj.project_id,
                -- Revision for version 1.8
                wdj.lot_number,
                sum(nvl(wpb.tl_resource_in,0)+
                    nvl(wpb.pl_resource_in,0))  wip_costs_in,
                sum(nvl(wpb.tl_resource_out,0)+
                    nvl(wpb.pl_resource_out,0)) wip_costs_out,
                sum(nvl(wpb.tl_resource_var,0)+
                    nvl(wpb.pl_resource_var,0)) wip_relief,
                 sum(nvl(wpb.tl_resource_in,0)+
                    nvl(wpb.pl_resource_in,0)-
                    nvl(wpb.tl_resource_out,0)-
                    nvl(wpb.pl_resource_out,0)-
                    nvl(wpb.tl_resource_var,0)-
                    nvl(wpb.pl_resource_var,0)) wip_value,
                -- Revision for version 1.9
                sum(0) wip_matl_value,
                sum(0) wip_moh_value,
                sum(nvl(wpb.tl_resource_in,0)+
                    nvl(wpb.pl_resource_in,0)-
                    nvl(wpb.tl_resource_out,0)-
                    nvl(wpb.pl_resource_out,0)-
                    nvl(wpb.tl_resource_var,0)-
                    nvl(wpb.pl_resource_var,0)) wip_res_value,
                sum(0) wip_osp_value,
                sum(0) wip_ovhd_value,
                sum(0) wip_scrap_value
                -- End revision for version 1.9
         from   wip_period_balances wpb,
                wip_discrete_jobs wdj,
                org_acct_periods oap,
                mfg_lookups ml
         -- ===========================================
         -- WIP Job Entity and accounting period joins
         -- ===========================================
         where  wpb.wip_entity_id         = wdj.wip_entity_id
         -- bug fix for version 1.1
         -- and    wpb.acct_period_id        = oap.acct_period_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id 
         -- end fix for version 1.1
         and    4=4                      -- p_period_name
         -- ===========================================
         -- Inventory accounting period joins to limit
         -- to wip activity within the accounting period.
         -- ===========================================
         -- Limit to jobs closed after the period start date
         and    nvl(trunc(wdj.date_closed), oap.period_start_date) >= oap.period_start_date
         -- ===========================================
         -- Lookup Code joins
         -- ===========================================
         and    ml.lookup_type              = 'WIP_JOB_STATUS'
         and    ml.lookup_code              = wdj.status_type        
         group by
                oap.period_name,
                -- Revision for version 1.18
                oap.schedule_close_date,
                wpb.acct_period_id,
                wpb.organization_id,
                wdj.resource_account,
                wdj.class_code,
                wdj.wip_entity_id,
                ml.meaning,
                -- Revision for version 1.8
                wdj.scheduled_start_date,
                -- Revision for version 1.17
                wdj.date_released,
                wdj.date_completed,
                wdj.date_closed,
                -- Revision for version 1.14
                decode(wdj.attribute13, null, 'No', 'Yes'),
                wdj.start_quantity,
                wdj.quantity_completed,
                wdj.quantity_scrapped,
                -- Revision for version 1.9
                wdj.completion_subinventory,
                wdj.primary_item_id,
                -- Revision for version 1.20
                wdj.project_id,
                -- Revision for version 1.8
                wdj.lot_number
         -- =====================================================
         -- Now get the OSP Value for the WIP Jobs
         -- =====================================================
         union all
         select oap.period_name period_name,
                -- Revision for version 1.18
                oap.schedule_close_date,
                wpb.acct_period_id acct_period_id,
                wpb.organization_id organization_id,
                wdj.outside_processing_account code_combination_id,
                wdj.class_code class_code,
                wdj.wip_entity_id wip_entity_id,
                ml.meaning status,
                -- Revision for version 1.8
                wdj.scheduled_start_date,
                -- Revision for version 1.17
                wdj.date_released,
                wdj.date_completed date_completed,
                wdj.date_closed date_closed,
                -- Revision for version 1.14
                decode(wdj.attribute13, null, 'No', 'Yes') converted_job,
                wdj.start_quantity start_quantity,
                wdj.quantity_completed quantity_completed,
                wdj.quantity_scrapped quantity_scrapped,
                -- Revision for version 1.9
                wdj.completion_subinventory,
                wdj.primary_item_id inventory_item_id,
                -- Revision for version 1.20
                wdj.project_id,
                -- Revision for version 1.8
                wdj.lot_number,
                sum(nvl(wpb.tl_outside_processing_in,0)+
                    nvl(wpb.pl_outside_processing_in,0))  wip_costs_in,
                sum(nvl(wpb.tl_outside_processing_out,0)+
                    nvl(wpb.pl_outside_processing_out,0)) wip_costs_out,
                sum(nvl(wpb.tl_outside_processing_var,0)+
                    nvl(wpb.pl_outside_processing_var,0)) wip_relief,
                 sum(nvl(wpb.tl_outside_processing_in,0)+
                    nvl(wpb.pl_outside_processing_in,0)-
                    nvl(wpb.tl_outside_processing_out,0)-
                    nvl(wpb.pl_outside_processing_out,0)-
                    nvl(wpb.tl_outside_processing_var,0)-
                    nvl(wpb.pl_outside_processing_var,0)) wip_value,
                -- Revision for version 1.9
                sum(0) wip_matl_value,
                sum(0) wip_moh_value,
                sum(0) wip_res_value,
                 sum(nvl(wpb.tl_outside_processing_in,0)+
                    nvl(wpb.pl_outside_processing_in,0)-
                    nvl(wpb.tl_outside_processing_out,0)-
                    nvl(wpb.pl_outside_processing_out,0)-
                    nvl(wpb.tl_outside_processing_var,0)-
                    nvl(wpb.pl_outside_processing_var,0)) wip_osp_value,
                sum(0) wip_ovhd_value,
                sum(0) wip_scrap_value
                -- End revision for version 1.9
         from   wip_period_balances wpb,
                wip_discrete_jobs wdj,
                org_acct_periods oap,
                mfg_lookups ml
         -- ===========================================
         -- WIP Job Entity and accounting period joins
         -- ===========================================
         where  wpb.wip_entity_id         = wdj.wip_entity_id
         -- bug fix for version 1.1
         -- and    wpb.acct_period_id        = oap.acct_period_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id 
         -- end fix for version 1.1
         and    4=4                      -- p_period_name
         -- ===========================================
         -- Inventory accounting period joins to limit
         -- to wip activity within the accounting period.
         -- ===========================================
         -- Limit to jobs closed after the period start date
         and    nvl(trunc(wdj.date_closed), oap.period_start_date) >= oap.period_start_date
         -- ===========================================
         -- Lookup Code joins
         -- ===========================================
         and    ml.lookup_type              = 'WIP_JOB_STATUS'
         and    ml.lookup_code              = wdj.status_type        
         group by
                oap.period_name,
                -- Revision for version 1.18
                oap.schedule_close_date,
                wpb.acct_period_id,
                wpb.organization_id,
                wdj.outside_processing_account,
                wdj.class_code,
                wdj.wip_entity_id,
                ml.meaning,
                -- Revision for version 1.8
                wdj.scheduled_start_date,
                -- Revision for version 1.17
                wdj.date_released,
                wdj.date_completed,
                wdj.date_closed,
                -- Revision for version 1.14
                decode(wdj.attribute13, null, 'No', 'Yes'),
                wdj.start_quantity,
                wdj.quantity_completed,
                wdj.quantity_scrapped,
                -- Revision for version 1.9
                wdj.completion_subinventory,
                wdj.primary_item_id,
                -- Revision for version 1.20
                wdj.project_id,
                -- Revision for version 1.8
                wdj.lot_number
         -- =====================================================
         -- Now get the overhead Value for the WIP Jobs
         -- =====================================================
         union all
         select oap.period_name period_name,
                -- Revision for version 1.18
                oap.schedule_close_date,
                wpb.acct_period_id acct_period_id,
                wpb.organization_id organization_id,
                wdj.overhead_account code_combination_id,
                wdj.class_code class_code,
                wdj.wip_entity_id wip_entity_id,
                ml.meaning status,
                -- Revision for version 1.8
                wdj.scheduled_start_date,
                -- Revision for version 1.17
                wdj.date_released,
                wdj.date_completed date_completed,
                wdj.date_closed date_closed,
                -- Revision for version 1.14
                decode(wdj.attribute13, null, 'No', 'Yes') converted_job,
                wdj.start_quantity start_quantity,
                wdj.quantity_completed quantity_completed,
                wdj.quantity_scrapped quantity_scrapped,
                -- Revision for version 1.9
                wdj.completion_subinventory completion_subinventory,
                wdj.primary_item_id inventory_item_id,
                -- Revision for version 1.20
                wdj.project_id,
                -- Revision for version 1.8
                wdj.lot_number,
                sum(nvl(wpb.tl_overhead_in,0)+
                    nvl(wpb.pl_overhead_in,0)) wip_costs_in,
                sum(nvl(wpb.tl_overhead_out,0)+
                    nvl(wpb.pl_overhead_out,0)) wip_costs_out,
                sum(nvl(wpb.tl_overhead_var,0)+
                    nvl(wpb.pl_overhead_var,0)) wip_relief,
                 sum(nvl(wpb.tl_overhead_in,0)+
                    nvl(wpb.pl_overhead_in,0)-
                    nvl(wpb.tl_overhead_out,0)-
                    nvl(wpb.pl_overhead_out,0)-
                    nvl(wpb.tl_overhead_var,0)-
                    nvl(wpb.pl_overhead_var,0)) wip_value,
                -- Revision for version 1.9
                sum(0) wip_matl_value,
                sum(0) wip_moh_value,
                sum(0) wip_res_value,
                 sum(0) wip_osp_value,
                 sum(nvl(wpb.tl_overhead_in,0)+
                    nvl(wpb.pl_overhead_in,0)-
                    nvl(wpb.tl_overhead_out,0)-
                    nvl(wpb.pl_overhead_out,0)-
                    nvl(wpb.tl_overhead_var,0)-
                    nvl(wpb.pl_overhead_var,0)) wip_ovhd_value,
                sum(0) wip_scrap_value
                -- End revision for version 1.9
         from   wip_period_balances wpb,
                wip_discrete_jobs wdj,
                org_acct_periods oap,
                mfg_lookups ml
         -- ===========================================
         -- WIP Job Entity and accounting period joins
         -- ===========================================
         where  wpb.wip_entity_id         = wdj.wip_entity_id
         -- bug fix for version 1.1
         -- and    wpb.acct_period_id        = oap.acct_period_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id 
         -- end fix for version 1.1
         and    4=4                      -- p_period_name
         -- ===========================================
         -- Inventory accounting period joins to limit
         -- to wip activity within the accounting period.
         -- ===========================================
         -- Limit to jobs closed after the period start date
         and    nvl(trunc(wdj.date_closed), oap.period_start_date) >= oap.period_start_date
         -- ===========================================
         -- Lookup Code joins
         -- ===========================================
         and    ml.lookup_type              = 'WIP_JOB_STATUS'
         and    ml.lookup_code              = wdj.status_type        
         group by
                oap.period_name,
                -- Revision for version 1.18
                oap.schedule_close_date,
                wpb.acct_period_id,
                wpb.organization_id,
                wdj.overhead_account,
                wdj.class_code,
                wdj.wip_entity_id,
                ml.meaning,
                -- Revision for version 1.8
                wdj.scheduled_start_date,
                -- Revision for version 1.17
                wdj.date_released,
                wdj.date_completed,
                wdj.date_closed,
                -- Revision for version 1.14
                decode(wdj.attribute13, null, 'No', 'Yes'),
                wdj.start_quantity,
                wdj.quantity_completed,
                wdj.quantity_scrapped,
                -- Revision for version 1.9
                wdj.completion_subinventory,
                wdj.primary_item_id,
                -- Revision for version 1.20
                wdj.project_id,
                -- Revision for version 1.8
                wdj.lot_number
        -- =====================================================
        -- Now get the scrap value for the WIP Jobs
        -- =====================================================
        union all
        select  oap.period_name period_name,
                -- Revision for version 1.18
                oap.schedule_close_date,
                wpb.acct_period_id acct_period_id,
                wpb.organization_id organization_id,
                nvl(wdj.est_scrap_account,wdj.material_account) code_combination_id,
                wdj.class_code class_code,
                wdj.wip_entity_id wip_entity_id,
                ml.meaning status,
                -- Revision for version 1.8
                wdj.scheduled_start_date,
                -- Revision for version 1.17
                wdj.date_released,
                wdj.date_completed date_completed,
                wdj.date_closed date_closed,
                -- Revision for version 1.14
                decode(wdj.attribute13, null, 'No', 'Yes') converted_job,
                wdj.start_quantity start_quantity,
                wdj.quantity_completed quantity_completed,
                wdj.quantity_scrapped quantity_scrapped,
                -- Revision for version 1.9
                wdj.completion_subinventory completion_subinventory,
                wdj.primary_item_id inventory_item_id,
                -- Revision for version 1.20
                wdj.project_id,
                -- Revision for version 1.8
                wdj.lot_number,
                sum(nvl(wpb.tl_scrap_in,0)) wip_costs_in,
                sum(nvl(wpb.tl_scrap_out,0)) wip_costs_out,
                sum(nvl(wpb.tl_scrap_var,0)) wip_relief,
                sum(nvl(wpb.tl_scrap_in,0)-
                    nvl(wpb.tl_scrap_out,0)-
                    nvl(wpb.tl_scrap_var,0)) wip_value,
                -- Revision for version 1.9
                sum(0) wip_matl_value,
                sum(0) wip_moh_value,
                sum(0) wip_res_value,
                sum(0) wip_osp_value,
                sum(0) wip_ovhd_value,
                sum(nvl(wpb.tl_scrap_in,0)-
                    nvl(wpb.tl_scrap_out,0)-
                    nvl(wpb.tl_scrap_var,0)) wip_scrap_value
                -- End revision for version 1.9
         from   wip_period_balances wpb,
                wip_discrete_jobs wdj,
                org_acct_periods oap,
                mfg_lookups ml
         -- ===========================================
         -- WIP Job Entity and accounting period joins
         -- ===========================================
         where  wpb.wip_entity_id         = wdj.wip_entity_id
         -- bug fix for version 1.1
         -- and    wpb.acct_period_id        = oap.acct_period_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id 
         -- end fix for version 1.1
         and    4=4                      -- p_period_name
         -- ===========================================
         -- Inventory accounting period joins to limit
         -- to wip activity within the accounting period.
         -- ===========================================
         -- Limit to jobs closed after the period start date
         and    nvl(trunc(wdj.date_closed), oap.period_start_date) >= oap.period_start_date
         -- ===========================================
         -- Lookup Code joins
         -- ===========================================
         and    ml.lookup_type              = 'WIP_JOB_STATUS'
         and    ml.lookup_code              = wdj.status_type        
         group by
                oap.period_name,
                -- Revision for version 1.18
                oap.schedule_close_date,
                wpb.acct_period_id,
                wpb.organization_id,
                nvl(wdj.est_scrap_account,wdj.material_account),
                wdj.class_code,
                wdj.wip_entity_id,
                ml.meaning,
                -- Revision for version 1.8
                wdj.scheduled_start_date,
                -- Revision for version 1.17
                wdj.date_released,
                wdj.date_completed,
                wdj.date_closed,
                -- Revision for version 1.14
                decode(wdj.attribute13, null, 'No', 'Yes'),
                wdj.start_quantity,
                wdj.quantity_completed,
                wdj.quantity_scrapped,
                -- Revision for version 1.9
                wdj.completion_subinventory,
                wdj.primary_item_id,
                -- Revision for version 1.20
                wdj.project_id,
                -- Revision for version 1.8
                wdj.lot_number
) wip_value
-- ===================================================
-- G/L ledger, organization and code combination joins
-- ===================================================
where   gcc.code_combination_id (+)   = wip_value.code_combination_id
and     msiv.inventory_item_id        = wip_value.inventory_item_id
and     msiv.organization_id          = wip_value.organization_id
and     msiv.organization_id          = mp.organization_id
-- Revision for version 1.22
and     msiv.primary_uom_code         = muomv.uom_code
and     hoi.org_information_context   = 'Accounting Information'
and     hoi.organization_id           = wip_value.organization_id
and     hoi.organization_id           = haou.organization_id            -- get the organization name
and     haou2.organization_id         = to_number(hoi.org_information3) -- get the operating unit id
and     gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
-- avoid selecting disabled inventory organizations
and     sysdate < nvl(haou.date_to, sysdate + 1)
-- Revision for version 1.24, Operating Unit and Ledger Controls and Parameters
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
and     1=1                          -- p_org_code, p_operating_unit, p_ledger
-- ===========================================
-- Lookup Code joins
-- ===========================================
and     fcl.lookup_type (+)           = 'ITEM_TYPE'
and     fcl.lookup_code (+)           = msiv.item_type
and     ml2.lookup_type               = 'WIP_CLASS_TYPE'
and     ml2.lookup_code               = wac.class_type
-- ===========================================
-- WIP Job Entity and Class joins
-- ===========================================
and     we.wip_entity_id              = wip_value.wip_entity_id
and     wac.class_code                = wip_value.class_code 
and     wac.organization_id           = wip_value.organization_id
-- Revision for version 1.16
-- Revision for version 1.12
-- and     msub.secondary_inventory_name = wip_value.completion_subinventory (+)
-- and     msub.organization_id          = wip_value.organization_id (+)
and     msub.secondary_inventory_name (+) = wip_value.completion_subinventory
and     msub.organization_id (+)      = wip_value.organization_id 
-- Revision for version 1.20
and     pp.project_id (+)             = wip_value.project_id
-- ===========================================
-- Expense WIP Accounting Classes
-- 4 - Expense Non-standard
-- 6 - Maintenance
-- 7 - Expense Non-standard Lot Based
-- ===========================================
and     wac.class_type                = decode(wac.class_type,
                                    1, wac.class_type,
                                    2, wac.class_type,
                                    3, wac.class_type,
                                    4, decode(upper('&p_include_expense_wip'),                       -- p_include_expense_wip
                                                'Y',   wac.class_type,
                                                'N',   99,
                                                99),
                                    5, wac.class_type,
                                    6, decode(upper('&p_include_expense_wip'),                        -- p_include_expense_wip
                                                'Y',   wac.class_type,
                                                'N',   99,
                                                99),
                                    7,  wac.class_type,
                                   wac.class_type)
group by 
        nvl(gl.short_name, gl.name),
        haou2.name,
        mp.organization_code,
        wip_value.period_name,
        gcc.concatenated_segments, -- Accounts
        &segment_columns_grp
        wip_value.class_code,
        ml2.meaning,
        we.wip_entity_name,
        -- Revision for version 1.23
        regexp_replace(we.description,'[^[:alnum:]'' '']', null), -- Job_Description
        wip_value.status,
        -- Revision for version 1.18
        we.creation_date,
        -- Revision for version 1.8
        wip_value.scheduled_start_date,
        -- Revision for version 1.17
        wip_value.date_released,
        wip_value.date_completed,
        wip_value.date_closed,
        -- Revision for version 1.18
        case 
         when (wip_value.schedule_close_date - we.creation_date) < 31  then '30 days'
         when (wip_value.schedule_close_date - we.creation_date) < 61  then '60 days'
         when (wip_value.schedule_close_date - we.creation_date) < 91  then '90 days'
         when (wip_value.schedule_close_date - we.creation_date) < 121 then '120 days'
         when (wip_value.schedule_close_date - we.creation_date) < 151 then '150 days'
         when (wip_value.schedule_close_date - we.creation_date) < 181 then '180 days'
         else 'Over 180 days'
        end, -- Aged_Creation_Date
        case 
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - nvl(wip_value.date_released,(nvl(wip_value.date_completed,sysdate)))) < 31  then '30 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - nvl(wip_value.date_released,(nvl(wip_value.date_completed,sysdate)))) < 61  then '60 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - nvl(wip_value.date_released,(nvl(wip_value.date_completed,sysdate)))) < 91  then '90 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - nvl(wip_value.date_released,(nvl(wip_value.date_completed,sysdate)))) < 121 then '120 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - nvl(wip_value.date_released,(nvl(wip_value.date_completed,sysdate)))) < 151 then '150 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - nvl(wip_value.date_released,(nvl(wip_value.date_completed,sysdate)))) < 181 then '180 days'
         else 'Over 180 days'
        end, -- Aged_Compln_Vs_Release_Date
        case 
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - we.creation_date) < 31  then '30 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - we.creation_date) < 61  then '60 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - we.creation_date) < 91  then '90 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - we.creation_date) < 121 then '120 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - we.creation_date) < 151 then '150 days'
         when (nvl(wip_value.date_completed,wip_value.schedule_close_date) - we.creation_date) < 181 then '180 days'
         else 'Over 180 days'
        end, -- Aged_Compln_Vs_Creation_Date
        -- End revision for version 1.18
        -- Revision for version 1.8 and 1.22
        muomv.uom_code,
        wip_value.start_quantity,
        wip_value.quantity_completed,
        wip_value.quantity_scrapped,
        wip_value.quantity_completed + wip_value.quantity_scrapped,
        -- Revision for version 1.9
        wip_value.completion_subinventory,
        -- Revision for version 1.12
        msub.description,
        msiv.concatenated_segments,
        -- Revision for version 1.11
        -- Needed for inline select on category
        msiv.inventory_item_id,
        msiv.organization_id,
        -- End revision for version 1.11
        msiv.description,
        fcl.meaning, -- Item_Type
        -- Revision for version 1.20
        pp.segment1, -- Project_Number
        pp.name, -- Project_Name
        wip_value.lot_number,
        -- End revision for version 1.8
        gl.currency_code
-- order by Ledger, Operating_Unit, Org_Code, Accounts, WIP_Class and WIP_Job
order by
        nvl(gl.short_name, gl.name), -- Ledger
        haou2.name, -- Operating_Unit
        mp.organization_code, -- Org_Code
        &segment_columns_grp
        wip_value.class_code, -- WIP_Class
        we.wip_entity_name -- WIP_Job