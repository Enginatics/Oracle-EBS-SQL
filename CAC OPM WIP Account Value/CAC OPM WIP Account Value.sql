/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC OPM WIP Account Value
-- Description: Report to show WIP values for process manufacturing (OPM), in summary by inventory organization and batch, with batch status, name and other details.  The valuation accounts come from the cumulative WIP Valuation accounting entries, as processed by Create Accounting.

Parameters:
===========
Period Name:  the inventory accounting period you wish to report (mandatory).
Include Lab Batches:  enter Yes to include laboratory batches.  Enter No to exclude them.  Defaults to No (mandatory).
Show Batch Details:  enter Yes to display the formula, routing and recipe numbers and versions.  Defaults to No (mandatory).
Show Transaction Details: enter Yes to show the Event Class, Transaction Type, Transaction ID and Transaction Date.  Defaults to No (mandatory). 
Batch Number:  enter a specific batch number to report (optional).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  The second item category set to report, typically the Inventory Category Set (optional).
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional).
Ledger:  specific ledger (optional).

/* +=============================================================================+
-- |  Copyright 2014 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     22-Oct-2014 Douglas Volz   Initial version.
-- |  1.1     06-Jul-2024 Douglas Volz   Cumulative changes plus format for Blitz Report.
-- |  1.2     31-Jul-2024 Douglas Volz   Fix to get current and prior month's transactions
-- |  1.3     06-Aug-2024 Douglas Volz   Add Batch and Txn Detail parameters.
-- |  1.4     08-Aug-2024 Douglas Volz   Add Product and Byproduct completion quantity columns.
-- |                                     and inventory access control security.
-- |  1.5     17-Aug-2024 Douglas Volz   Fix for reporting batches closed after the reported period.
-- |                                     Add Batch Number parameter.  Display the Ledger short name.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-opm-wip-account-value/
-- Library Link: https://www.enginatics.com/reports/cac-opm-wip-account-value/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        wip.organization_code Org_Code,
        wip.period_name Period_Name,
        &segment_columns
        gem_l1.meaning Batch_Type,
        wip.batch_no Batch_Number,
        gem_l2.meaning Batch_Status,
        &p_show_batch_dtls
        wip.creation_date Creation_Date,
        wip.plan_start_date Planned_Start_Date,
        wip.actual_start_date Actual_Start_Date,
        wip.due_date Due_Date,
        wip.actual_cmplt_date Actual_Completion_Date,
        wip.batch_close_date Batch_Close_Date,
        case 
           when (wip.schedule_close_date - wip.creation_date) < 31  then '30 days'
           when (wip.schedule_close_date - wip.creation_date) < 61  then '60 days'
           when (wip.schedule_close_date - wip.creation_date) < 91  then '90 days'
           when (wip.schedule_close_date - wip.creation_date) < 121 then '120 days'
           when (wip.schedule_close_date - wip.creation_date) < 151 then '150 days'
           when (wip.schedule_close_date - wip.creation_date) < 181 then '180 days'
           else 'Over 180 days'
        end Aged_Creation_Date,
        case 
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - nvl(wip.actual_start_date,(nvl(wip.actual_cmplt_date,sysdate)))) < 31  then '30 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - nvl(wip.actual_start_date,(nvl(wip.actual_cmplt_date,sysdate)))) < 61  then '60 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - nvl(wip.actual_start_date,(nvl(wip.actual_cmplt_date,sysdate)))) < 91  then '90 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - nvl(wip.actual_start_date,(nvl(wip.actual_cmplt_date,sysdate)))) < 121 then '120 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - nvl(wip.actual_start_date,(nvl(wip.actual_cmplt_date,sysdate)))) < 151 then '150 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - nvl(wip.actual_start_date,(nvl(wip.actual_cmplt_date,sysdate)))) < 181 then '180 days'
           else 'Over 180 days'
        end Aged_Compln_vs_Release_Date,
        case 
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - wip.creation_date) < 31  then '30 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - wip.creation_date) < 61  then '60 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - wip.creation_date) < 91  then '90 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - wip.creation_date) < 121 then '120 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - wip.creation_date) < 151 then '150 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - wip.creation_date) < 181 then '180 days'
           else 'Over 180 days'
        end Aged_Compln_vs_Creation_Date,
        muomv.uom_code UOM_Code,
        -- Revision for version 1.4
        nvl((select  sum(decode(mmt.transaction_type_id,
                                44, mmt.primary_quantity, -- WIP completions
                                17, mmt.primary_quantity, -- WIP completion returns
                                0)
                        )
             from    mtl_material_transactions mmt
             where   mmt.transaction_source_type_id = 5
             and     mmt.organization_id            = wip.organization_id
             and     mmt.transaction_source_id      = wip.batch_id
            ),
          '') Product_Quantity_Completed,
        nvl((select  sum(decode(mmt.transaction_type_id,
                                1002, mmt.primary_quantity, -- WIP byproduct completions
                                1003, mmt.primary_quantity, -- WIP byproduct completion returns
                                0)
                        )
             from    mtl_material_transactions mmt
             where   mmt.transaction_source_type_id = 5
             and     mmt.organization_id            = wip.organization_id
             and     mmt.transaction_source_id      = wip.batch_id
            ),
          '') Byproduct_Quantity_Completed,
        -- End revision for version 1.4
        msiv.concatenated_segments "Product Number",
        msiv.description "Product Description",
        fcl.meaning Item_Type,
&category_columns
        xl.meaning Accounting_Class,
        &p_show_txn_dtls
        gl.currency_code Currency_Code,
        sum(wip.wip_costs_in) WIP_Costs_In,
        sum(wip.wip_costs_out) WIP_Costs_Out,
        sum(wip.wip_relief) WIP_Relief,
        sum(wip.wip_value) WIP_Value
from    mtl_system_items_vl msiv,
        mtl_units_of_measure_vl muomv,
        gl_code_combinations gcc,
        gl_ledgers gl,
        hr_organization_information hoi,
        hr_all_organization_units haou,
        hr_all_organization_units haou2,
        fnd_common_lookups fcl,
        xla_lookups xl,
        gem_lookups gem_l1, -- Batch Type
        gem_lookups gem_l2, -- Batch Status
        -- ==========================================================
        -- This first select gets the OPM Batch Resource
        -- Transactions based on the view gmf_subledger_rep_v.
        -- See the section called Q6 batch Resource transactions
        -- ==========================================================
        (select xah.ledger_id,
                mp.organization_code,
                mp.organization_id,
                oap.period_name,
                xal.code_combination_id,
                oap.schedule_close_date,
                gbh.laboratory_ind, -- Batch Type
                gbh.batch_no,
                gbh.batch_id,
                gbh.batch_status,
                -- Revision for version 1.3
                &p_show_batch_dtls2
                gbh.creation_date,
                gxeh.inventory_item_id,
                gbh.plan_start_date,
                gbh.actual_start_date,
                gbh.due_date,
                gbh.actual_cmplt_date,
                gbh.batch_close_date,
                xal.accounting_class_code,
                &p_show_txn_dtls2
                sum(nvl(xal.accounted_dr, 0) - nvl(xal.accounted_cr, 0)) wip_costs_in,
                sum(0) wip_costs_out,
                sum(0) wip_relief,
                sum(nvl(xal.accounted_dr, 0) - nvl(xal.accounted_cr, 0)) wip_value        
         from   gme_batch_header gbh,
                -- Revision for version 1.3
                &p_show_batch_dtl_tables
                gmf_xla_extract_headers gxeh,
                gme_resource_txns grt,
                org_acct_periods oap,
                xla_ae_headers xah,
                xla_ae_lines xal,
                mtl_parameters mp,
                gmf_fiscal_policies gfp
         where  gxeh.event_id                   = xah.event_id
         and    gxeh.organization_id            = mp.organization_id
         and    gxeh.transaction_id             = grt.poc_trans_id
         and    gxeh.source_document_id         = grt.doc_id
         and    gxeh.source_line_id             = grt.line_id
         and    gxeh.resources                  = grt.resources
         and    gbh.batch_id                    = grt.doc_id
         -- Revision for version 1.3
         &p_show_batch_dtl_joins
         and    mp.organization_id              = gbh.organization_id
         and    gxeh.txn_source                 = 'PM'
         and    xal.accounting_class_code       = 'WIP_VALUATION'
         and    mp.process_enabled_flag         = 'Y'
         -- ===========================================
         -- Limit to just WIP Resource Txns
         -- ===========================================
         and    gxeh.entity_code                = 'PRODUCTION'
         and    gxeh.event_class_code           = 'BATCH_RESOURCE'
         -- ===========================================
         -- Get resource transactions from the batch 
         -- start date to the period close date.
         -- ===========================================
         -- Revision for version 1.2
         -- and    oap.period_name                 = xah.period_name
         and    oap.organization_id             = mp.organization_id
         -- Revision for version 1.2 and 1.3
         -- and    nvl(trunc(gbh.batch_close_date), oap.period_start_date) >= oap.period_start_date
         and    grt.trans_date                 >= gbh.actual_start_date
         and    grt.trans_date                 <  oap.schedule_close_date + 1
         -- Revision for version 1.5
         -- and    ((gbh.batch_close_date is null and gbh.actual_start_date < oap.schedule_close_date + 1)
         --         or
         --         (gbh.batch_close_date >= oap.period_start_date and gbh.batch_close_date <= oap.schedule_close_date)
         --        )
         and    ((gbh.batch_close_date is null and nvl(gbh.actual_start_date, sysdate) < oap.schedule_close_date + 1)
                  or
                 (gbh.batch_close_date is not null and gbh.batch_close_date >= oap.period_start_date)
                )
         -- End revision for version 1.5
         -- ===========================================
         -- Only get entries which go to the G/L
         -- ===========================================
         and    gfp.ledger_id                   = xah.ledger_id
         and    gfp.cost_type_id                = gxeh.valuation_cost_type_id
         and    gfp.legal_entity_id             = (select to_number(hoi.org_information2) 
                                                   from   hr_organization_information hoi
                                                   where  hoi.org_information_context     = 'Accounting Information'
                                                   and    hoi.organization_id             = mp.organization_id)
         -- ===========================================
         -- Subledger Accounting joins
         -- ===========================================
         and    xah.ae_header_id                = xal.ae_header_id
         and    xah.ledger_id                   = xal.ledger_id
         and    xah.application_id              = 555
         and    xah.application_id              = xal.application_id
         and    2=2                             -- p_org_code, p_period_name, p_include_lab_batches, p_batch_number
         -- Revision for version 1.4
         and     mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) 
         group by
                xah.ledger_id,
                mp.organization_code,
                mp.organization_id,
                oap.period_name,
                xal.code_combination_id,
                oap.schedule_close_date,
                gbh.laboratory_ind, -- Batch Type
                gbh.batch_no,
                gbh.batch_id,
                gbh.batch_status,
                -- Revision for version 1.3
                &p_show_batch_dtls2_grp
                gbh.creation_date,
                gxeh.inventory_item_id,
                gbh.plan_start_date,
                gbh.actual_start_date,
                gbh.due_date,
                gbh.actual_cmplt_date,
                gbh.batch_close_date,
                &p_show_txn_dtls2_grp
                xal.accounting_class_code
         union all
         -- ==========================================================
         -- This second select gets the OPM Batch Close Transactions
         -- based on the view gmf_subledger_rep_v.
         -- See the section called Q7 Batch Close Variances
         -- ==========================================================
         select xah.ledger_id,
                mp.organization_code,
                mp.organization_id,
                oap.period_name,
                xal.code_combination_id,
                oap.schedule_close_date,
                gbh.laboratory_ind, -- Batch Type
                gbh.batch_no,
                gbh.batch_id,
                gbh.batch_status,
                -- Revision for version 1.3
                &p_show_batch_dtls2
                gbh.creation_date,
                we.primary_item_id inventory_item_id,
                gbh.plan_start_date,
                gbh.actual_start_date,
                gbh.due_date,
                gbh.actual_cmplt_date,
                gbh.batch_close_date,
                xal.accounting_class_code,
                &p_show_txn_dtls2
                sum(0) wip_costs_in,
                sum(0) wip_costs_out,
                -- Revision, change SIGN of WIP Cost Relief to match Oracle (Discrete) WIP Value Report
                decode(xal.accounting_class_code,
                                'WIP_VALUATION',   -1 * sum(nvl(xal.accounted_dr, 0) - nvl(xal.accounted_cr, 0)),
                                sum(0)
                      ) wip_relief,
                decode(xal.accounting_class_code,
                                'WIP_VALUATION', sum(nvl(xal.accounted_dr, 0) - nvl(xal.accounted_cr, 0)),
                                sum(0)
                      ) wip_value
         from   gme_batch_header gbh,
                -- Revision for version 1.3
                &p_show_batch_dtl_tables
                gmf_xla_extract_headers gxeh,
                org_acct_periods oap,
                -- Revision, show Product not Ingredient
                wip_entities we,
                xla_ae_headers xah,
                xla_ae_lines xal,
                gmf_fiscal_policies gfp,
                mtl_parameters mp
         -- ===========================================
         -- Transaction, Batch and item master joins
         -- ===========================================
         where  gxeh.event_id                   = xah.event_id
         and    gxeh.transaction_id             = gbh.batch_id
         and    gxeh.source_document_id         = gbh.batch_id
         and    gxeh.organization_id            = mp.organization_id
         -- Revision for version 1.3
         &p_show_batch_dtl_joins
         and    mp.organization_id              = gbh.organization_id
         and    gbh.batch_status                = 4 -- Closed
         and    we.wip_entity_id                = gbh.batch_id
         and    we.organization_id              = mp.organization_id
         and    gxeh.txn_source                 = 'PM'
         and    gxeh.event_type_code            = 'CLOS'
         and    xal.accounting_class_code       = 'WIP_VALUATION'
         and    mp.process_enabled_flag         = 'Y'
         -- ===========================================
         -- Limit to just WIP Close Txns
         -- ===========================================
         and     gxeh.entity_code                = 'PRODUCTION'
         and     gxeh.event_class_code           = 'BATCH_CLOSE'
         -- ===========================================
         -- Limit batch close transactions to batches
         -- which closed within the accounting period.
         -- ===========================================
         -- Revision for version 1.2
         -- and    oap.period_name                 = xah.period_name
         and    oap.organization_id             = mp.organization_id
         -- Revision for version 1.2 and 1.3
         -- and    nvl(trunc(gbh.batch_close_date), oap.period_start_date) >= oap.period_start_date
         and    gxeh.transaction_date          >= oap.period_start_date
         and    gxeh.transaction_date          <= oap.schedule_close_date
         -- End revision for version 1.2 and 1.3
         -- ===========================================
         -- Only get entries which go to the G/L
         -- ===========================================
         and    gfp.ledger_id                   = xah.ledger_id
         and    gfp.legal_entity_id             = (select to_number(hoi.org_information2) 
                                                   from   hr_organization_information hoi
                                                   where  hoi.org_information_context     = 'Accounting Information'
                                                   and    hoi.organization_id             = mp.organization_id)
         and    gxeh.valuation_cost_type_id     = gfp.cost_type_id
         -- ===========================================
         -- Subledger Accounting joins
         -- ===========================================
         and    xah.ae_header_id                = xal.ae_header_id
         and    xah.ledger_id                   = xal.ledger_id
         and    xah.application_id              = 555
         and    xah.application_id              = xal.application_id
         and    2=2                             -- p_org_code, p_period_name, p_include_lab_batches, p_batch_number
         -- Revision for version 1.4
         and     mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) 
         group by
                xah.ledger_id,
                mp.organization_code,
                mp.organization_id,
                oap.period_name,
                xal.code_combination_id,
                oap.schedule_close_date,
                xal.code_combination_id,
                gbh.laboratory_ind, -- Batch Type
                gbh.batch_no,
                gbh.batch_id,
                gbh.batch_status,
                -- Revision for version 1.3
                &p_show_batch_dtls2_grp
                gbh.creation_date,
                we.primary_item_id, -- inventory_item_id
                gbh.plan_start_date,
                gbh.actual_start_date,
                gbh.due_date,
                gbh.actual_cmplt_date,
                gbh.batch_close_date,
                &p_show_txn_dtls2_grp
                xal.accounting_class_code
         union all
         -- ==========================================================
         -- This third select gets the OPM Batch Material Transactions
         -- based on the BIP Material Account Summary Report
         -- ==========================================================
         select xah.ledger_id,
                mp.organization_code,
                mp.organization_id,
                oap.period_name,
                xal.code_combination_id,
                oap.schedule_close_date,
                gbh.laboratory_ind, -- Batch Type
                gbh.batch_no,
                gbh.batch_id,
                gbh.batch_status,
                -- Revision for version 1.3
                &p_show_batch_dtls2
                gbh.creation_date,
                we.primary_item_id inventory_item_id,
                gbh.plan_start_date,
                gbh.actual_start_date,
                gbh.due_date,
                gbh.actual_cmplt_date,
                gbh.batch_close_date,
                xal.accounting_class_code,
                &p_show_txn_dtls2
                decode(mmt.transaction_action_id,
                                31, 0,
                                32, 0,
                                sum(nvl(xal.accounted_dr, 0) - nvl(xal.accounted_cr, 0))
                      ) wip_costs_in,
                -- Revision, change SIGN of Costs Out to match Oracle (Discrete) WIP Value Report
                decode(mmt.transaction_action_id,
                                31, sum(nvl(xal.accounted_dr, 0) - nvl(xal.accounted_cr, 0)),
                                32, sum(nvl(xal.accounted_dr, 0) - nvl(xal.accounted_cr, 0)),
                                sum(0)
                      ) * -1 wip_costs_out,
                sum(0) wip_relief,
                sum(nvl(xal.accounted_dr, 0) - nvl(xal.accounted_cr, 0)) wip_value
         from   mtl_material_transactions mmt,
                gme_batch_header gbh,
                -- Revision for version 1.3
                &p_show_batch_dtl_tables
                gmf_xla_extract_headers gxeh,
                org_acct_periods oap,
                -- Revision, show Product not Ingredient
                wip_entities we,
                xla_ae_headers xah,
                xla_ae_lines xal,
                gmf_fiscal_policies gfp,
                mtl_parameters mp
         where  mmt.transaction_id              = gxeh.transaction_id
         and    mmt.transaction_source_type_id  = 5
         and    we.wip_entity_id                = gbh.batch_id
         and    gxeh.organization_id            = mp.organization_id
         and    mmt.transaction_source_id       = gbh.batch_id
         and    mmt.organization_id             = mp.organization_id
         -- Revision for version 1.3
         &p_show_batch_dtl_joins
         and    gxeh.event_id                   = xah.event_id
         and    gxeh.txn_source                 = 'PM'
         and    xal.accounting_class_code       = 'WIP_VALUATION'
         and    mp.process_enabled_flag         = 'Y'
         -- ===========================================
         -- Limit to just WIP Batch Material
         -- ===========================================
         and    gxeh.entity_code                = 'PRODUCTION'
         and    gxeh.event_class_code           = 'BATCH_MATERIAL'
         -- ===========================================
         -- Get material transactions from the batch 
         -- start date to the period close date.
         -- ===========================================
         -- Revision for version 1.2
         -- and    oap.period_name                 = xah.period_name
         and    oap.organization_id             = mp.organization_id
         -- Revision for version 1.2 and 1.3
         -- and    nvl(trunc(gbh.batch_close_date), oap.period_start_date) >= oap.period_start_date
         and    mmt.transaction_date           >= gbh.actual_start_date
         and    mmt.transaction_date           <  oap.schedule_close_date + 1
         -- Revision for version 1.5
         -- and    ((gbh.batch_close_date is null and gbh.actual_start_date < oap.schedule_close_date + 1)
         --         or
         --         (gbh.batch_close_date >= oap.period_start_date and gbh.batch_close_date <= oap.schedule_close_date)
         --        )
         and    ((gbh.batch_close_date is null and nvl(gbh.actual_start_date, sysdate) < oap.schedule_close_date + 1)
                  or
                 (gbh.batch_close_date is not null and gbh.batch_close_date >= oap.period_start_date)
                )
         -- End revision for version 1.5
         -- ===========================================
         -- Only get entries which go to the G/L
         -- ===========================================
         and    gfp.ledger_id                   = xah.ledger_id
         and    gxeh.valuation_cost_type_id     = gfp.cost_type_id
         and    gfp.legal_entity_id             = (select to_number(hoi.org_information2) 
                                                   from   hr_organization_information hoi
                                                   where  hoi.org_information_context     = 'Accounting Information'
                                                   and    hoi.organization_id             = mp.organization_id)
         -- ===========================================
         -- Subledger Accounting joins
         -- ===========================================
         and    xah.ae_header_id                = xal.ae_header_id
         and    xah.ledger_id                   = xal.ledger_id
         and    xah.application_id              = 555
         and    xah.application_id              = xal.application_id
         and    2=2                             -- p_org_code, p_period_name, p_include_lab_batches, p_batch_number
         -- Revision for version 1.4
         and     mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) 
         group by
                xah.ledger_id,
                mp.organization_code,
                mp.organization_id,
                oap.period_name,
                xal.code_combination_id,
                oap.schedule_close_date,
                xal.code_combination_id,
                gbh.laboratory_ind, -- Batch Type
                gbh.batch_no,
                gbh.batch_id,
                gbh.batch_status,
                -- Revision for version 1.3
                &p_show_batch_dtls2_grp
                gbh.creation_date,
                we.primary_item_id, -- inventory_item_id
                gbh.plan_start_date,
                gbh.actual_start_date,
                gbh.due_date,
                gbh.actual_cmplt_date,
                gbh.batch_close_date,
                xal.accounting_class_code,
                -- For inline select
                mmt.transaction_action_id,
                &p_show_txn_dtls2_grp
                xal.accounting_class_code
        ) wip
where   msiv.inventory_item_id          = wip.inventory_item_id
and     msiv.organization_id            = wip.organization_id
and     msiv.primary_uom_code           = muomv.uom_code
-- ===========================================
-- Accounts (CCID) join
-- ===========================================
-- Outer join in case Create Accounting fails
and     gcc.code_combination_id(+)      = wip.code_combination_id
-- ===========================================
-- Lookup Codes
-- ===========================================
and     xl.lookup_code (+)              = wip.accounting_class_code
and     xl.lookup_type (+)              = 'XLA_ACCOUNTING_CLASS'
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv.item_type
and     gem_l1.lookup_type (+)          = 'GME_LABORATORY_IND'
and     gem_l1.lookup_code (+)          = wip.laboratory_ind
and     gem_l2.lookup_type (+)          = 'GME_BATCH_STATUS'
and     gem_l2.lookup_code (+)          = wip.batch_status
-- ===========================================
-- Organization joins
-- ===========================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = wip.organization_id
and     hoi.organization_id             = haou.organization_id
and     haou2.organization_id           = to_number(hoi.org_information3)
and     gl.ledger_id                    = to_number(hoi.org_information1)
and     1=1                             -- p_operating_unit, p_ledger
group by
        nvl(gl.short_name, gl.name),
        haou2.name,
        wip.organization_code,
        wip.period_name,
        &segment_columns_grp
        gem_l1.meaning, -- Batch Type
        wip.batch_no,
        gem_l2.meaning, -- Batch Status
        -- Revision for version 1.3
        &p_show_batch_dtls_grp
        wip.creation_date,
        wip.plan_start_date,
        wip.actual_start_date,
        wip.due_date,
        wip.actual_cmplt_date,
        wip.batch_close_date,
        case 
           when (wip.schedule_close_date - wip.creation_date) < 31  then '30 days'
           when (wip.schedule_close_date - wip.creation_date) < 61  then '60 days'
           when (wip.schedule_close_date - wip.creation_date) < 91  then '90 days'
           when (wip.schedule_close_date - wip.creation_date) < 121 then '120 days'
           when (wip.schedule_close_date - wip.creation_date) < 151 then '150 days'
           when (wip.schedule_close_date - wip.creation_date) < 181 then '180 days'
           else 'Over 180 days'
        end, -- Aged_Creation_Date
        case 
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - nvl(wip.actual_start_date,(nvl(wip.actual_cmplt_date,sysdate)))) < 31  then '30 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - nvl(wip.actual_start_date,(nvl(wip.actual_cmplt_date,sysdate)))) < 61  then '60 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - nvl(wip.actual_start_date,(nvl(wip.actual_cmplt_date,sysdate)))) < 91  then '90 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - nvl(wip.actual_start_date,(nvl(wip.actual_cmplt_date,sysdate)))) < 121 then '120 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - nvl(wip.actual_start_date,(nvl(wip.actual_cmplt_date,sysdate)))) < 151 then '150 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - nvl(wip.actual_start_date,(nvl(wip.actual_cmplt_date,sysdate)))) < 181 then '180 days'
           else 'Over 180 days'
        end, -- Aged_Compln_vs_Release_Date
        case 
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - wip.creation_date) < 31  then '30 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - wip.creation_date) < 61  then '60 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - wip.creation_date) < 91  then '90 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - wip.creation_date) < 121 then '120 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - wip.creation_date) < 151 then '150 days'
           when (nvl(wip.actual_cmplt_date, wip.schedule_close_date) - wip.creation_date) < 181 then '180 days'
           else 'Over 180 days'
        end, -- Aged_Compln_vs_Creation_Date
        msiv.concatenated_segments, -- Product Number
        msiv.description,
        muomv.uom_code,
        fcl.meaning, -- Item Type
        xl.meaning, -- Accounting Class
        wip.batch_close_date,
        wip.accounting_class_code,
        -- Revision for version 1.3
        &p_show_txn_dtls_grp
        gl.currency_code,
        -- added for inline selects
        msiv.inventory_item_id,
        msiv.organization_id,
        wip.organization_id,
        wip.batch_id
-- Order by Ledger, Operating Unit, Org Code, Period Name, Accounts, Item and Batch
order by 1,2,3,4,5,6,7,8,9,10,11,12,14,21