/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Account Summary
-- Description: Report to get the WIP accounting distributions, in summary, by WIP job, resource, overhead and WIP cost update.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  With parameters to limit the report size, Show Project to display or not display the project number and name, Show WIP Job to display or not display the WIP job (WIP job, description and resource codes) and Show WIP Outside Processing to display or not display the outside processing information (WIP OSP item number, supplier, purchase order, purchase order line and release).  For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules).  Note that both Flow and Workorderless show up as the WIP Type "Flow schedule".

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show SLA Accounting:  enter Yes to use the Subledger Accounting rules for your accounting information (mandatory).  If you choose No the report uses the pre-Create Accounting entries.
Show Projects:  display the project number and name.  Enter Yes or No, use to limit the report size. (mandatory).
Show WIP Jobs:  display the WIP job, description, department and resource.  Enter Yes or No, use to limit the report size (mandatory).
Show WIP Outside Processing:  display the WIP OSP item number, supplier, purchase order, purchase order line and release.  Enter Yes or No, use to limit the report size (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Assembly Number:  enter the specific assembly number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2009- 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission. 
-- +=============================================================================+
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- |   1.13   11 Mar 2021 Douglas Volz   Added Flow Schedules and Workorderless WIP
-- |                                     and removed redundant joins and tables to 
-- |                                     improve performance.
-- |   1.14   22 Mar 2021 Douglas Volz   Add WIP Job parameter.
-- |   1.15   20 Dec 2021 Douglas Volz   Add WIP Department.
-- |   1.16   12 Aug 2022 Douglas Volz   Combine with WIP Account Summary No SLA report
-- |                                     and add Show WIP Job and Show WIP OSP parameters.
-- |   1.17   14 Aug 2022 Douglas Volz   Screen out zero job close variances for Flow Schedules.
-- |  1.18   22 Aug 2022 Douglas Volz    Improve performance with outer joins and streamline dynamic SQL.
-- |  1.19   26 Feb 2023 Douglas Volz    Fix to show job close variances.
-- |  1.20   20 Jun 2024 Douglas Volz    Remove tabs, reinstall missing parameters and org access controls.
-- +=============================================================================+*/




-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-account-summary/
-- Library Link: https://www.enginatics.com/reports/cac-wip-account-summary/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        acct_dist.organization_code Org_Code,
        oap.period_name Period_Name,
        &segment_columns
        msiv.concatenated_segments Assembly_Number,
        msiv.description Assembly_Description,
        -- Revision for version 1.13
        fcl.meaning item_type,
        -- Revision for version 1.9
&category_columns
        -- End revision for version 1.9
        ml1.meaning Accounting_Line_Type,
        ml2.meaning Transaction_Type,
        wac.class_code WIP_Class,
        ml3.meaning Class_Type,
        -- Revision for version 1.13
        ml4.meaning WIP_Type,
        -- Revision for version 1.17
        &p_show_project
        &p_show_wip_job
        &p_show_wip_osp
        -- End revision for version 1.17
        -- Revision for version 1.11, 1.12 and 1.16
        &p_show_wip_job_uom
        round(sum(decode(acct_dist.transaction_type, 
                         'Cost Update', 0,
                         nvl(acct_dist.primary_quantity,0)
                        )
                 )
           ,3) Primary_Quantity,
        -- End revision for version 1.11
        gl.currency_code Currency_Code,
        -- Revision for version 1.11
        sum(decode(acct_dist.cost_element_id,
                        1, acct_dist.base_transaction_value,
                        0)) Material_Amount,
        sum(decode(acct_dist.cost_element_id,
                        2, acct_dist.base_transaction_value,
                        0)) Material_Overhead_Amount,
        sum(decode(acct_dist.cost_element_id,
                        3, acct_dist.base_transaction_value,
                        0)) Resource_Amount,
        sum(decode(acct_dist.cost_element_id,
                        4, acct_dist.base_transaction_value,
                        0)) Outside_Processing_Amount,
        sum(decode(acct_dist.cost_element_id,
                        5, acct_dist.base_transaction_value,
                        0)) Overhead_Amount,
        -- End revision for version 1.11
        sum(acct_dist.base_transaction_value) Amount
from    wip_entities we,
        wip_accounting_classes wac,
        mtl_system_items_vl msiv,
        -- Revision for version 1.15
        bom_departments bd,
        bom_resources br,
        org_acct_periods oap,
        gl_code_combinations gcc,
        mfg_lookups ml1,
        mfg_lookups ml2,
        mfg_lookups ml3,
        -- Revision for version 1.13
        mfg_lookups ml4,
        -- Revision for version 1.10
        fnd_common_lookups fcl,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou, -- inv_organization_id
        hr_all_organization_units_vl haou2, -- operating unit
        gl_ledgers gl,
        -- Revision for version 1.18
        &project_tables
        &wip_osp_tables
        -- Revision for version 1.17
        &wip_sla_tables
        (select mp.organization_code,
                mp.organization_id,
                wt.acct_period_id,
                wta.reference_account,
                nvl(wdj.primary_item_id, wfs.primary_item_id) primary_item_id,
                wta.accounting_line_type,
                wt.transaction_type,
                -- Revision for version 1.17
                wt.transaction_id,
                wt.rcv_transaction_id,
                wt.move_transaction_id,
                wt.completion_transaction_id,
                wt.transaction_date,
                wt.creation_date,
                wt.created_by,
                -- Release 12.2 wt.reason_code,
                regexp_replace(wt.reference,'[^[:alnum:]'' '']', null) transaction_reference,
                -- End revision for version 1.17
                nvl(wdj.class_code, wfs.class_code) class_code,
                nvl(wdj.wip_entity_id, wfs.wip_entity_id) wip_entity_id,
                wta.resource_id,
                wt.po_header_id,
                wt.po_line_id,
                wt.cost_update_id,
                -- Revision for version 1.17
                -- Release 12.2 wt.resource_instance,
                -- Revision for version 1.15
                wt.department_id,
                nvl(wdj.project_id, wfs.project_id) project_id,
                -- Revision for version 1.17
                wt.task_id,
                wt.pm_cost_collected,
                wt.operation_seq_num,
                wt.resource_seq_num,
                wt.autocharge_type,
                wt.standard_rate_flag,
                -- Release 12.2 wt.usage_rate_of_amount,
                wt.actual_resource_rate,
                wt.standard_resource_rate,
                wta.rate_or_amount,
                wta.basis_type,
                wta.currency_code,
                wta.currency_conversion_date,
                wta.currency_conversion_rate,
                wta.overhead_basis_factor,
                wta.basis_resource_id,
                wt.activity_id,
                -- End revision for version 1.17
                wt.transaction_uom,
                wt.primary_uom,
                wta.primary_quantity,
                wta.cost_element_id,
                wta.base_transaction_value,
                wta.wip_sub_ledger_id
         from   wip_transaction_accounts wta,
                wip_transactions wt,
                wip_discrete_jobs wdj,
                -- Revision for version 1.18
                wip_flow_schedules wfs,
                mtl_parameters mp
         -- ========================================================
         -- WIP Transaction, org and item joins
         -- ========================================================
         where  wt.transaction_id                = wta.transaction_id
         -- Revision for version 1.18
         and    wdj.wip_entity_id (+)            = wta.wip_entity_id
         and    wdj.organization_id (+)          = wta.organization_id
         and    wfs.wip_entity_id (+)            = wta.wip_entity_id
         and    wfs.organization_id (+)          = wta.organization_id
         -- End revision for version 1.18
         and    mp.organization_id               = wta.organization_id
         -- Revision for version 1.19
         -- Improve logic to screen out zero job close and flow schedule variances
         -- Revision for version 1.17
         -- Do not show zero job and flow schedule close variances
         -- and (wt.transaction_type <> 6 and wta.base_transaction_value <> 0)
         and    1 = case
                        when wt.transaction_type =  5 and wta.base_transaction_value = 0 then 2
                        when wt.transaction_type =  6 and wta.base_transaction_value = 0 then 2
                        when wt.transaction_type =  7 and wta.base_transaction_value = 0 then 2
                        else 1
                    end
         -- End for revision for version 1.19
         and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    2=2                              -- p_org_code, p_trx_date_from, p_trx_date_to, p_wip_job
        ) acct_dist
-- ========================================================
-- WIP Transaction, org and item joins
-- ========================================================
where   msiv.organization_id             = acct_dist.organization_id
and     msiv.inventory_item_id           = acct_dist.primary_item_id
-- Revision for version 1.15
and     we.wip_entity_id                 = acct_dist.wip_entity_id
and     bd.department_id (+)             = acct_dist.department_id
and     br.resource_id (+)               = acct_dist.resource_id
-- ========================================================
-- Dynamic SQL joins
-- ========================================================
&project_table_joins
&osp_wip_table_joins
-- ========================================================
and     wac.class_code (+)               = acct_dist.class_code
-- Revision for version 1.2
and     wac.organization_id (+)          = acct_dist.organization_id
and     we.wip_entity_id                 = acct_dist.wip_entity_id
-- ========================================================
-- Inventory Org accounting period joins
-- ========================================================
and     oap.acct_period_id               = acct_dist.acct_period_id
and     oap.organization_id              = acct_dist.organization_id
-- ========================================================
-- Version 1.3, added lookup values to see more detail
-- ========================================================
and     ml1.lookup_type                  = 'CST_ACCOUNTING_LINE_TYPE'
and     ml1.lookup_code                  = acct_dist.accounting_line_type
and     ml2.lookup_type                  = 'WIP_TRANSACTION_TYPE_SHORT'
and     ml2.lookup_code                  = acct_dist.transaction_type
and     ml3.lookup_type                  = 'WIP_CLASS_TYPE'
and     ml3.lookup_code                  = wac.class_type
-- Revision for version 1.13
and     ml4.lookup_type                  = 'WIP_ENTITY'
and     ml4.lookup_code                  = we.entity_type
-- ========================================================
-- Version 1.10, added Item_Type lookup values
-- ========================================================
and     fcl.lookup_code (+)              = msiv.item_type
and     fcl.lookup_type (+)              = 'ITEM_TYPE'
-- End revision for version 1.10
-- ========================================================
-- using the base tables to avoid using
-- org_organization_definitions and hr_operating_units
-- ========================================================
and     hoi.org_information_context      = 'Accounting Information'
and     hoi.organization_id              = acct_dist.organization_id
and     hoi.organization_id              = haou.organization_id   -- this gets the organization name
and     haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
and     1=1                              -- p_assy_number, p_operating_unit, p_ledger
-- ========================================================
-- Revision for version 1.17, SLA and Non-SLA joins.
-- ========================================================
&wip_sla_table_joins
&wip_non_sla_table_joins
-- ==========================================================
group by 
        nvl(gl.short_name, gl.name),
        haou2.name,
        acct_dist.organization_code,
        oap.period_name,
        &segment_columns_grp
        msiv.concatenated_segments,
        msiv.description,
        -- Revision for version 1.10
        fcl.meaning, -- item_type
        ml1.meaning, -- Accounting Line Type
        ml2.meaning, -- WIP Transaction Type
        wac.class_code,
        ml3.meaning, -- WIP Class Type
        -- Revision for version 1.13
        ml4.meaning, -- WIP Entity Type
        &group_by_project
        &group_by_wip_job
        &group_by_wip_osp
        -- Added for inline column selects
        -- Revision for version 1.12
        msiv.organization_id,
        msiv.inventory_item_id,
        -- End revision for version 1.8
        gl.currency_code
order by 
        -- Fix for version 1.10
        -- 1,3,4,5,6,7,8,9,10,12,13
        nvl(gl.short_name, gl.name),
        haou2.name,
        acct_dist.organization_code,
        oap.period_name,
        &segment_columns_grp
        msiv.concatenated_segments,
        ml1.meaning, -- Accounting_Line_Type
        ml2.meaning, -- Transaction_Type
        wac.class_code, -- WIP_Class
        -- Revision for version 1.13
        ml4.meaning -- WIP Entity Type
        &order_by_project
        &order_by_wip_job
        &order_by_wip_osp
        ,msiv.organization_id