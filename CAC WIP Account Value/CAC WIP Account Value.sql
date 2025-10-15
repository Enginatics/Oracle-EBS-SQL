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
Job Status:  enter a specific job status (optional).
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
-- |  1.25    17 Mar 2025 Douglas Volz   WIP performance improvements.
-- |  1.26    31 Aug 2025 Douglas Volz  Added Job Status parameter.
+=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-account-value/
-- Library Link: https://www.enginatics.com/reports/cac-wip-account-value/
-- Run Report: https://demo.enginatics.com/

with inv_organizations as
-- Get the list of organizations, ledgers and operating units for Discrete organizations
        (select nvl(gl.short_name, gl.name) ledger,
                gl.ledger_id,
                haou2.name operating_unit,
                haou2.organization_id operating_unit_id,
                mp.organization_code,
                mp.organization_id,
                haou.date_to disable_date,
                gl.currency_code
         from   mtl_parameters mp,
                hr_organization_information hoi,
                hr_all_organization_units_vl haou, -- inv_organization_id
                hr_all_organization_units_vl haou2, -- operating unit
                gl_ledgers gl
         -- Avoid the item master organization
         where  mp.organization_id             <> mp.master_organization_id
         -- Avoid disabled inventory organizations
         and    sysdate                        <  nvl(haou.date_to, sysdate +1)
         and    hoi.org_information_context     = 'Accounting Information'
         and    hoi.organization_id             = mp.organization_id
         and    hoi.organization_id             = haou.organization_id   -- this gets the organization name
         and    haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
         and    gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
         -- Revision for version 1.24, Operating Unit and Ledger Controls and Parameters
         and     (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
         and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
         and    1=1                             -- p_org_code, p_operating_unit, p_ledger
         group by
                nvl(gl.short_name, gl.name),
                gl.ledger_id,
                to_number(hoi.org_information2),
                haou2.name, -- operating_unit
                haou2.organization_id, -- operating_unit_id
                mp.organization_code,
                mp.organization_id,
                haou.date_to,
                gl.currency_code
        ), -- inv_organizations
wip_value as
        (select inv_orgs.ledger,
                inv_orgs.operating_unit,
                inv_orgs.organization_code,
                wpb.organization_id,
                oap.period_name period_name,
                oap.schedule_close_date,
                wdj.material_account,
                wdj.material_overhead_account,
                wdj.resource_account,
                wdj.outside_processing_account,
                wdj.overhead_account,
                nvl(wdj.est_scrap_account,wdj.material_account) scrap_account,
                wdj.class_code class_code,
                ml2.meaning class_type,
                we.wip_entity_name,
                regexp_replace(we.description,'[^[:alnum:]'' '']', null) job_description,
                wdj.wip_entity_id wip_entity_id,
                ml1.meaning job_status,
                we.creation_date,
                wdj.scheduled_start_date,
                wdj.date_released,
                wdj.date_completed date_completed,
                wdj.date_closed date_closed,
                case 
                 when (oap.schedule_close_date - we.creation_date) < 31  then '30 days'
                 when (oap.schedule_close_date - we.creation_date) < 61  then '60 days'
                 when (oap.schedule_close_date - we.creation_date) < 91  then '90 days'
                 when (oap.schedule_close_date - we.creation_date) < 121 then '120 days'
                 when (oap.schedule_close_date - we.creation_date) < 151 then '150 days'
                 when (oap.schedule_close_date - we.creation_date) < 181 then '180 days'
                 else 'Over 180 days'
                end Aged_Creation_Date,
                case 
                 when (nvl(wdj.date_completed,oap.schedule_close_date) - 
                       nvl(wdj.date_released,(nvl(wdj.date_completed,sysdate)))) < 31  then '30 days'
                 when (nvl(wdj.date_completed,oap.schedule_close_date) - 
                       nvl(wdj.date_released,(nvl(wdj.date_completed,sysdate)))) < 61  then '60 days'
                 when (nvl(wdj.date_completed,oap.schedule_close_date) - 
                       nvl(wdj.date_released,(nvl(wdj.date_completed,sysdate)))) < 91  then '90 days'
                 when (nvl(wdj.date_completed,oap.schedule_close_date) - 
                       nvl(wdj.date_released,(nvl(wdj.date_completed,sysdate)))) < 121 then '120 days'
                 when (nvl(wdj.date_completed,oap.schedule_close_date) - 
                       nvl(wdj.date_released,(nvl(wdj.date_completed,sysdate)))) < 151 then '150 days'
                 when (nvl(wdj.date_completed,oap.schedule_close_date) - 
                       nvl(wdj.date_released,(nvl(wdj.date_completed,sysdate)))) < 181 then '180 days'
                 else 'Over 180 days'
                end Aged_Compln_vs_Release_Date,
                case 
                 when (nvl(wdj.date_completed,oap.schedule_close_date) - we.creation_date) < 31  then '30 days'
                 when (nvl(wdj.date_completed,oap.schedule_close_date) - we.creation_date) < 61  then '60 days'
                 when (nvl(wdj.date_completed,oap.schedule_close_date) - we.creation_date) < 91  then '90 days'
                 when (nvl(wdj.date_completed,oap.schedule_close_date) - we.creation_date) < 121 then '120 days'
                 when (nvl(wdj.date_completed,oap.schedule_close_date) - we.creation_date) < 151 then '150 days'
                 when (nvl(wdj.date_completed,oap.schedule_close_date) - we.creation_date) < 181 then '180 days'
                 else 'Over 180 days'
                end Aged_Compln_vs_Creation_Date,
                wdj.start_quantity start_quantity,
                wdj.quantity_completed quantity_completed,
                wdj.quantity_scrapped quantity_scrapped,
                wdj.completion_subinventory,
                regexp_replace(msub.description,'[^[:alnum:]'' '']', null) subinventory_description,
                wdj.primary_item_id,
                wdj.project_id,
                wdj.lot_number,
                inv_orgs.currency_code,
                sum(nvl(wpb.pl_material_in,0)-
                    nvl(wpb.tl_material_out,0)-
                    nvl(wpb.pl_material_out,0)-
                    nvl(wpb.tl_material_var,0)-
                    nvl(wpb.pl_material_var,0)) matl_value,
                sum(nvl(wpb.pl_material_overhead_in,0)-
                    nvl(wpb.tl_material_overhead_out,0)-
                    nvl(wpb.pl_material_overhead_out,0)-
                    nvl(wpb.tl_material_overhead_var,0)-
                    nvl(wpb.pl_material_overhead_var,0)) moh_value,
                sum(nvl(wpb.tl_resource_in,0)+
                    nvl(wpb.pl_resource_in,0)-
                    nvl(wpb.tl_resource_out,0)-
                    nvl(wpb.pl_resource_out,0)-
                    nvl(wpb.tl_resource_var,0)-
                    nvl(wpb.pl_resource_var,0)) res_value,
                sum(nvl(wpb.tl_outside_processing_in,0)+
                    nvl(wpb.pl_outside_processing_in,0)-
                    nvl(wpb.tl_outside_processing_out,0)-
                    nvl(wpb.pl_outside_processing_out,0)-
                    nvl(wpb.tl_outside_processing_var,0)-
                    nvl(wpb.pl_outside_processing_var,0)) osp_value,
                sum(nvl(wpb.tl_overhead_in,0)+
                    nvl(wpb.pl_overhead_in,0)-
                    nvl(wpb.tl_overhead_out,0)-
                    nvl(wpb.pl_overhead_out,0)-
                    nvl(wpb.tl_overhead_var,0)-
                    nvl(wpb.pl_overhead_var,0)) ovhd_value,
                sum(nvl(wpb.tl_scrap_in,0)-
                    nvl(wpb.tl_scrap_out,0)-
                    nvl(wpb.tl_scrap_var,0)) scrap_value,
                sum(nvl(wpb.pl_material_in,0)) matl_costs_in,
                sum(nvl(wpb.pl_material_overhead_in,0)) moh_costs_in,
                sum(nvl(wpb.tl_resource_in,0)+
                    nvl(wpb.pl_resource_in,0)) res_costs_in,
                sum(nvl(wpb.tl_outside_processing_in,0)+
                    nvl(wpb.pl_outside_processing_in,0)) osp_costs_in,
                sum(nvl(wpb.tl_overhead_in,0)+
                    nvl(wpb.pl_overhead_in,0)) ovhd_costs_in,
                sum(nvl(wpb.tl_scrap_in,0)) scrap_costs_in,
                sum(nvl(wpb.tl_material_out,0)+
                    nvl(wpb.pl_material_out,0)) matl_costs_out,
                sum(nvl(wpb.tl_material_overhead_out,0)+
                    nvl(wpb.pl_material_overhead_out,0)) moh_costs_out,
                sum(nvl(wpb.tl_resource_out,0)+
                    nvl(wpb.pl_resource_out,0)) res_costs_out,
                sum(nvl(wpb.tl_outside_processing_out,0)+
                    nvl(wpb.pl_outside_processing_out,0)) osp_costs_out,
                sum(nvl(wpb.tl_overhead_out,0)+
                    nvl(wpb.pl_overhead_out,0)) ovhd_costs_out,
                sum(nvl(wpb.tl_scrap_out,0)) scrap_costs_out,
                sum(nvl(wpb.tl_material_var,0)+
                    nvl(wpb.pl_material_var,0)) matl_relief,
                sum(nvl(wpb.tl_material_overhead_var,0)+
                    nvl(wpb.pl_material_overhead_var,0)) moh_relief,
                sum(nvl(wpb.tl_resource_var,0)+
                    nvl(wpb.pl_resource_var,0)) res_relief,
                sum(nvl(wpb.tl_outside_processing_var,0)+
                    nvl(wpb.pl_outside_processing_var,0)) osp_relief,
                sum(nvl(wpb.tl_overhead_var,0)+
                    nvl(wpb.pl_overhead_var,0)) ovhd_relief,
                sum(nvl(wpb.tl_scrap_var,0)) scrap_relief
         from   wip_period_balances wpb,
                wip_discrete_jobs wdj,
                wip_entities we,
                wip_accounting_classes wac,
                mtl_secondary_inventories msub,
                org_acct_periods oap,
                inv_organizations inv_orgs,
                mfg_lookups ml1, -- job status
                mfg_lookups ml2  -- class type
         -- ===========================================
         -- WIP Job Entity and accounting period joins
         -- ===========================================
         where  wpb.wip_entity_id             = wdj.wip_entity_id
         and    we.wip_entity_id              = wdj.wip_entity_id
         and    wpb.acct_period_id           <= oap.acct_period_id
         and    wpb.organization_id           = oap.organization_id
         and    wac.class_code                = wdj.class_code 
         and    wac.organization_id           = wdj.organization_id
         and    msub.secondary_inventory_name (+) = wdj.completion_subinventory
         and    msub.organization_id (+)      = wdj.organization_id 
         and    2=2                           -- p_period_name, p_job_status
         and    inv_orgs.organization_id      = wdj.organization_id 
         -- ===========================================
         -- Inventory accounting period joins to limit
         -- to wip activity within the accounting period.
         -- ===========================================
         -- Limit to jobs closed after the period start date
         and    nvl(trunc(wdj.date_closed), oap.period_start_date) >= oap.period_start_date
         -- ===========================================
         -- Lookup Code joins
         -- ===========================================
         and    ml1.lookup_type               = 'WIP_JOB_STATUS'
         and    ml1.lookup_code               = wdj.status_type
         and    ml2.lookup_type               = 'WIP_CLASS_TYPE'
         and    ml2.lookup_code               = wac.class_type
         -- ===========================================
         -- Expense WIP Accounting Classes
         -- 4 - Expense Non-standard
         -- 6 - Maintenance
         -- 7 - Expense Non-standard Lot Based
         -- ===========================================
         and    wac.class_type                = decode(wac.class_type,
                                                1, wac.class_type,
                                                2, wac.class_type,
                                                3, wac.class_type,
                                                4,         decode(upper(:p_include_expense_wip),                -- p_include_expense_wip
                                                            'Y',   wac.class_type,
                                                            'N',   99,
                                                            99),
                                                5, wac.class_type,
                                                6, decode(upper(:p_include_expense_wip),                        -- p_include_expense_wip
                                                            'Y',   wac.class_type,
                                                            'N',   99,
                                                            99),
                                                7,  wac.class_type,
                                               wac.class_type)
         group by
                inv_orgs.ledger,
                inv_orgs.operating_unit,
                inv_orgs.organization_code,
                wpb.organization_id,
                oap.period_name,
                oap.schedule_close_date,
                wdj.material_account,
                wdj.material_overhead_account,
                wdj.resource_account,
                wdj.outside_processing_account,
                wdj.overhead_account,
                nvl(wdj.est_scrap_account,wdj.material_account), -- scrap_account
                wdj.class_code,
                ml2.meaning, -- class_type
                we.wip_entity_name,
                regexp_replace(we.description,'[^[:alnum:]'' '']', null), -- Job_Description
                wdj.wip_entity_id,
                ml1.meaning, -- job status
                we.creation_date,
                wdj.scheduled_start_date,
                wdj.date_released,
                wdj.date_completed,
                wdj.date_closed,
                wdj.start_quantity,
                wdj.quantity_completed,
                wdj.quantity_scrapped,
                wdj.completion_subinventory,
                regexp_replace(msub.description,'[^[:alnum:]'' '']', null), -- Subinventory_Description,
                wdj.primary_item_id,
                wdj.project_id,
                wdj.lot_number,
                inv_orgs.currency_code
) -- wip_value

------------ main sql query starts here ---------------------

select  wip.ledger Ledger,
        wip.operating_unit Operating_Unit,
        wip.organization_code Org_Code,
        wip.period_name Period_Name,
        gcc.concatenated_segments WIP_Valuation_Account,
        &segment_columns
        wip.class_code WIP_Class,
        wip.class_type Class_Type,
        wip.wip_entity_name WIP_Job,
        wip.job_description Job_Description,
        wip.job_status Job_Status,
        wip.creation_date Creation_Date,
        wip.scheduled_start_date Schedule_Start_Date,
        wip.date_released Date_Released,
        wip.date_completed Date_Completed,
        wip.date_closed Date_Closed,
        wip.aged_creation_date Aged_Creation_Date,
        wip.aged_compln_vs_release_date Aged_Compln_vs_Release_Date,
        wip.aged_compln_vs_creation_date Aged_Compln_vs_Creation_Date,
        muomv.uom_code UOM_Code,
        wip.start_quantity Start_Quantity,
        wip.quantity_completed Quantity_Completed,
        wip.quantity_scrapped Quantity_Scrapped,
        wip.quantity_completed + quantity_scrapped Total_Quantity,
        wip.completion_subinventory Completion_Subinventory,
        wip.subinventory_description Subinventory_Description,
        msiv.concatenated_segments  Item_Number,
        msiv.description Item_Description,
&category_columns
        pp.segment1 Project_Number,
        pp.name Project_Name,
        wip.lot_number Lot_Number,
        wip.currency_code Currency_Code,
        sum(wip.matl_value) WIP_Material_Value,
        sum(wip.moh_value) WIP_Material_Overhead_Value,
        sum(wip.res_value) WIP_Resource_Value,
        sum(wip.osp_value) WIP_Outside_Processing_Value,
        sum(wip.ovhd_value) WIP_Overhead_Value,
        sum(wip.scrap_value) WIP_Scrap_Value,
        sum(wip.costs_in) WIP_Costs_In,
        sum(wip.costs_out) WIP_Costs_Out,
        sum(wip.relief) WIP_Relief,
        sum(wip.value) WIP_Value
from    gl_code_combinations_kfv gcc,
        mtl_system_items_vl msiv,
        mtl_units_of_measure_vl muomv,
        pa_projects_all pp,
        (
         -- ============================
         -- WIP Material Value
         -- ============================
         select wv.ledger,
                wv.operating_unit,
                wv.organization_code,
                wv.organization_id,
                wv.period_name period_name,
                wv.schedule_close_date,
                wv.material_account code_combination_id,
                wv.class_code class_code,
                wv.class_type,
                wv.wip_entity_name,
                wv.job_description,
                wv.wip_entity_id,
                wv.job_status,
                wv.creation_date,
                wv.scheduled_start_date,
                wv.date_released,
                wv.date_completed date_completed,
                wv.date_closed date_closed,
                wv.Aged_Creation_Date,
                wv.Aged_Compln_vs_Release_Date,
                wv.Aged_Compln_vs_Creation_Date,
                wv.start_quantity start_quantity,
                wv.quantity_completed quantity_completed,
                wv.quantity_scrapped quantity_scrapped,
                wv.completion_subinventory,
                wv.subinventory_description,
                wv.primary_item_id,
                wv.project_id,
                wv.lot_number,
                wv.currency_code,
                wv.matl_value,
                0 moh_value,
                0 res_value,
                0 osp_value,
                0 ovhd_value,
                0 scrap_value,
                wv.matl_costs_in costs_in,
                wv.matl_costs_out costs_out,
                wv.matl_relief relief,
                wv.matl_value value
         from   wip_value wv
         union all
         -- ============================
         -- WIP Material Overhead Value
         -- ============================
         select wv.ledger,
                wv.operating_unit,
                wv.organization_code,
                wv.organization_id,
                wv.period_name period_name,
                wv.schedule_close_date,
                wv.material_overhead_account code_combination_id,
                wv.class_code class_code,
                wv.class_type,
                wv.wip_entity_name,
                wv.job_description,
                wv.wip_entity_id,
                wv.job_status,
                wv.creation_date,
                wv.scheduled_start_date,
                wv.date_released,
                wv.date_completed date_completed,
                wv.date_closed date_closed,
                wv.Aged_Creation_Date,
                wv.Aged_Compln_vs_Release_Date,
                wv.Aged_Compln_vs_Creation_Date,
                wv.start_quantity start_quantity,
                wv.quantity_completed quantity_completed,
                wv.quantity_scrapped quantity_scrapped,
                wv.completion_subinventory,
                wv.subinventory_description,
                wv.primary_item_id,
                wv.project_id,
                wv.lot_number,
                wv.currency_code,
                0 matl_value,
                wv.moh_value,
                0 res_value,
                0 osp_value,
                0 ovhd_value,
                0 scrap_value,
                wv.moh_costs_in costs_in,
                wv.moh_costs_out costs_out,
                wv.moh_relief relief,
                wv.moh_value value
         from   wip_value wv
         union all
         -- ============================
         -- WIP Resource Value
         -- ============================
         select wv.ledger,
                wv.operating_unit,
                wv.organization_code,
                wv.organization_id,
                wv.period_name period_name,
                wv.schedule_close_date,
                wv.resource_account code_combination_id,
                wv.class_code class_code,
                wv.class_type,
                wv.wip_entity_name,
                wv.job_description,
                wv.wip_entity_id,
                wv.job_status,
                wv.creation_date,
                wv.scheduled_start_date,
                wv.date_released,
                wv.date_completed date_completed,
                wv.date_closed date_closed,
                wv.Aged_Creation_Date,
                wv.Aged_Compln_vs_Release_Date,
                wv.Aged_Compln_vs_Creation_Date,
                wv.start_quantity start_quantity,
                wv.quantity_completed quantity_completed,
                wv.quantity_scrapped quantity_scrapped,
                wv.completion_subinventory,
                wv.subinventory_description,
                wv.primary_item_id,
                wv.project_id,
                wv.lot_number,
                wv.currency_code,
                0 matl_value,
                0 moh_value,
                wv.res_value,
                0 osp_value,
                0 ovhd_value,
                0 scrap_value,
                wv.res_costs_in costs_in,
                wv.res_costs_out costs_out,
                wv.res_relief relief,
                wv.res_value value
         from   wip_value wv
         union all
         -- ============================
         -- WIP Outside Processing Value
         -- ============================
         select wv.ledger,
                wv.operating_unit,
                wv.organization_code,
                wv.organization_id,
                wv.period_name period_name,
                wv.schedule_close_date,
                wv.outside_processing_account code_combination_id,
                wv.class_code class_code,
                wv.class_type,
                wv.wip_entity_name,
                wv.job_description,
                wv.wip_entity_id,
                wv.job_status,
                wv.creation_date,
                wv.scheduled_start_date,
                wv.date_released,
                wv.date_completed date_completed,
                wv.date_closed date_closed,
                wv.Aged_Creation_Date,
                wv.Aged_Compln_vs_Release_Date,
                wv.Aged_Compln_vs_Creation_Date,
                wv.start_quantity start_quantity,
                wv.quantity_completed quantity_completed,
                wv.quantity_scrapped quantity_scrapped,
                wv.completion_subinventory,
                wv.subinventory_description,
                wv.primary_item_id,
                wv.project_id,
                wv.lot_number,
                wv.currency_code,
                0 matl_value,
                0 moh_value,
                0 res_value,
                wv.osp_value,
                0 ovhd_value,
                0 scrap_value,
                wv.osp_costs_in costs_in,
                wv.osp_costs_out costs_out,
                wv.osp_relief relief,
                wv.osp_value value
         from   wip_value wv
         union all
         -- ============================
         -- WIP Overhead Value
         -- ============================
         select wv.ledger,
                wv.operating_unit,
                wv.organization_code,
                wv.organization_id,
                wv.period_name period_name,
                wv.schedule_close_date,
                wv.overhead_account code_combination_id,
                wv.class_code class_code,
                wv.class_type,
                wv.wip_entity_name,
                wv.job_description,
                wv.wip_entity_id,
                wv.job_status,
                wv.creation_date,
                wv.scheduled_start_date,
                wv.date_released,
                wv.date_completed date_completed,
                wv.date_closed date_closed,
                wv.Aged_Creation_Date,
                wv.Aged_Compln_vs_Release_Date,
                wv.Aged_Compln_vs_Creation_Date,
                wv.start_quantity start_quantity,
                wv.quantity_completed quantity_completed,
                wv.quantity_scrapped quantity_scrapped,
                wv.completion_subinventory,
                wv.subinventory_description,
                wv.primary_item_id,
                wv.project_id,
                wv.lot_number,
                wv.currency_code,
                0 matl_value,
                0 moh_value,
                0 res_value,
                0 osp_value,
                wv.ovhd_value,
                0 scrap_value,
                wv.ovhd_costs_in costs_in,
                wv.ovhd_costs_out costs_out,
                wv.ovhd_relief relief,
                wv.ovhd_value value
         from   wip_value wv
         union all
         -- ============================
         -- WIP Scrap Value
         -- ============================
         select wv.ledger,
                wv.operating_unit,
                wv.organization_code,
                wv.organization_id,
                wv.period_name period_name,
                wv.schedule_close_date,
                wv.scrap_account code_combination_id,
                wv.class_code class_code,
                wv.class_type,
                wv.wip_entity_name,
                wv.job_description,
                wv.wip_entity_id,
                wv.job_status,
                wv.creation_date,
                wv.scheduled_start_date,
                wv.date_released,
                wv.date_completed date_completed,
                wv.date_closed date_closed,
                wv.Aged_Creation_Date,
                wv.Aged_Compln_vs_Release_Date,
                wv.Aged_Compln_vs_Creation_Date,
                wv.start_quantity start_quantity,
                wv.quantity_completed quantity_completed,
                wv.quantity_scrapped quantity_scrapped,
                wv.completion_subinventory,
                wv.subinventory_description,
                wv.primary_item_id,
                wv.project_id,
                wv.lot_number,
                wv.currency_code,
                0 matl_value,
                0 moh_value,
                0 res_value,
                0 osp_value,
                0 ovhd_value,
                wv.scrap_value,
                wv.scrap_costs_in costs_in,
                wv.scrap_costs_out costs_out,
                wv.scrap_relief relief,
                wv.scrap_value value
         from   wip_value wv
        ) wip
-- ===================================================
-- Code combination, item and project joins
-- ===================================================
where   gcc.code_combination_id (+)   = wip.code_combination_id
and     msiv.inventory_item_id        = wip.primary_item_id
and     msiv.organization_id          = wip.organization_id
and     msiv.primary_uom_code         = muomv.uom_code
and     pp.project_id (+)             = wip.project_id
group by 
        wip.ledger,
        wip.operating_unit,
        wip.organization_code,
        wip.period_name,
        gcc.concatenated_segments, -- WIP Valuation Account
        &segment_columns_grp
        wip.class_code,
        wip.class_type,
        wip.wip_entity_name,
        wip.job_description,
        wip.job_status,
        wip.creation_date,
        wip.scheduled_start_date,
        wip.date_released,
        wip.date_completed,
        wip.date_closed,
        wip.aged_creation_date,
        wip.aged_compln_vs_release_date,
        wip.aged_compln_vs_creation_date,
        muomv.uom_code,
        wip.start_quantity,
        wip.quantity_completed,
        wip.quantity_scrapped,
        wip.quantity_completed + wip.quantity_scrapped,
        wip.completion_subinventory,
        wip.subinventory_description,
        msiv.concatenated_segments,
        -- Needed for inline select on category
        msiv.inventory_item_id,
        msiv.organization_id,
        msiv.description,
        pp.segment1, -- Project Number
        pp.name, -- Project Name
        wip.lot_number,
        wip.currency_code
-- order by Ledger, Operating Unit, Org Code, Accounts, WIP Class and WIP Job
order by
        wip.ledger,
        wip.operating_unit,
        wip.organization_code,
        gcc.concatenated_segments, -- WIP Valuation Account
        wip.class_code,
        wip.wip_entity_name