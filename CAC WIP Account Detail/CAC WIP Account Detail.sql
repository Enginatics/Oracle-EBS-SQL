/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Account Detail
-- Description: Report to get the WIP accounting distributions, in summary, by WIP job, resource, overhead and WIP cost update.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  With parameters to limit the number of report columns, Show Project to display or not display the project number and name, Show WIP Job to display or not display the WIP job (WIP job, description and resource codes) and Show WIP Outside Processing to display or not display the outside processing information (WIP OSP item number, supplier, purchase order, purchase order line and release).  For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules).  Note that both Flow and Workorderless show up as the WIP Type "Flow schedule".

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show SLA Accounting:  enter Yes to use the Subledger Accounting rules for your accounting information (mandatory).  If you choose No the report uses the pre-Create Accounting entries.
Show Projects:  display the project number and name.  Enter Yes or No, use to control the reported columns. (mandatory).
Show WIP Outside Processing:  display the WIP OSP item number, supplier, purchase order, purchase order line and release.  Enter Yes or No, use to control the reported columns (mandatory).
Show WIP Overheads:  display the earned WIP production overheads, including the Overhead Code and Resource Basis Amount.  Enter Yes or No, use to control the reported columns (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Accounting Line Type:  enter the accounting purpose or line type to report (optional).
WIP Transaction Type:  enter the transaction type to report (optional).
Minimum Absolute Amount:  enter the minimum debit or credit to report (optional).  To see all accounting entries, enter zero (0).
Resource Code:  enter the resource codes to report (optional).
Department:  enter the routing department to report (optional).
Class Code:  enter the WIP class code to report (optional).
WIP Job or Flow Schedule:  enter the WIP Job or the Flow Schedule to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Assembly Number:  enter the specific assembly number(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2009- 2022 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission. 
-- +=============================================================================+
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- |  1.17   14 Aug 2022 Douglas Volz   Screen out zero job close variances for Flow Schedules.
-- |  1.18   03 Sep 2022 Douglas Volz    Improve performance with outer joins.  Add in Detail columns.
-- |  1.19   08 Oct 2022 Douglas Volz    Correct project and task information.
-- |  1.20   20 Oct 2022 Douglas Volz    Remove duplicate table and joins for bom_resources br_basis
-- +=============================================================================+*/




-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-account-detail/
-- Library Link: https://www.enginatics.com/reports/cac-wip-account-detail/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
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
 -- Revision for version 1.18
 acct_dist.transaction_id Transaction_Id,
 &p_show_wip_osp
 acct_dist.move_transaction_id Move_Transaction_Id,
 acct_dist.completion_transaction_id Completion_Transaction_Id,
 acct_dist.transaction_date Transaction_Date,
 acct_dist.creation_date Creation_Date,
 fu.user_name Created_By,
 acct_dist.transaction_reference,
 -- End revision for version 1.18
 wac.class_code WIP_Class,
 ml3.meaning Class_Type,
 -- Revision for version 1.13
 ml4.meaning WIP_Type,
 -- Revision for version 1.17
 &p_show_project
 we.wip_entity_name WIP_Job,
 we.description Description,
 -- Revision for version 1.18
 decode(ml4.lookup_code, 4, ml9.meaning, ml8.meaning) WIP_Status,
 -- Revision for version 1.15
 acct_dist.operation_seq_num Operation_Seq_Number,
 acct_dist.resource_seq_num Resource_Operation_Seq,
 bd.department_code WIP_Department,
 -- Revision for version 1.18
 regexp_replace(bd.description,'[^[:alnum:]'' '']', null) Department_Description,
 br.resource_code WIP_Resource,
 ml5.meaning Autocharge_Type,
 ml6.meaning Standard_Rate,
 -- End revision for version 1.18
 &p_show_wip_osp2
 -- End revision for version 1.17
 -- Revision for version 1.18
 acct_dist.actual_resource_rate,
 acct_dist.standard_resource_rate,
 acct_dist.rate_or_amount Resource_Cost,
 -- Revision for version 1.23
 ml7.meaning Basis_Type,
 &p_show_wip_ovhds
 ca.activity Activity,
 -- End revision for version 1.18
 -- Revision for version 1.11, 1.12 and 1.16
 (select nvl(muomv.uom_code, br.unit_of_measure)
  from bom_resources br,
  mtl_units_of_measure_vl muomv
  where acct_dist.resource_id    = br.resource_id
  and muomv.uom_code (+) = br.unit_of_measure
   ) UOM_Code,
 round(nvl(acct_dist.primary_quantity,0),3) Primary_Quantity,
 -- End revision for version 1.11
 cce.cost_element Cost_Element,
 gl.currency_code Currency_Code,
 acct_dist.base_transaction_value Amount
from wip_entities we,
 wip_accounting_classes wac,
 mtl_system_items_vl msiv,
 org_acct_periods oap,
 gl_code_combinations gcc,
 mfg_lookups ml1, -- CST_ACCOUNTING_LINE_TYPE
 mfg_lookups ml2, -- WIP_TRANSACTION_TYPE_SHORT
 mfg_lookups ml3, -- WIP_CLASS_TYPE
 -- Revision for version 1.13
 mfg_lookups ml4, -- WIP_ENTITY
 -- Revision for version 1.10
 fnd_common_lookups fcl,
 -- Revision for version 1.18
 bom_resources br,
 bom_departments bd,
 cst_activities ca,
 cst_cost_elements cce,
 fnd_user fu,
 mfg_lookups ml5, -- BOM_AUTOCHARGE_TYPE
 mfg_lookups ml6, -- Standard Rate Flag
 mfg_lookups ml7, -- CST_BASIS
 mfg_lookups ml8, -- WIP Job Status
 mfg_lookups ml9, -- WIP Flow Schedule Status
 -- End revision for version 1.18
 hr_organization_information hoi,
 hr_all_organization_units_vl haou, -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl,
 -- Revision for version 1.18
 &project_tables
 &wip_osp_tables
 &wip_ovhd_tables
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
  -- Revision for version 1.18
  nvl(wdj.status_type, wfs.status) status_type,
  wta.resource_id,
  wt.po_header_id,
  wt.po_line_id,
  wt.cost_update_id,
  -- Revision for version 1.17
  -- Release 12.2 wt.resource_instance,
  -- Revision for version 1.15
  wt.department_id,
  -- Revision for version 1.19
  wt.project_id,
  -- Revision for version 1.17
  wt.task_id,
  -- Revision for version 1.19
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
  from wip_transaction_accounts wta,
  wip_transactions wt,
  wip_discrete_jobs wdj,
  -- Revision for version 1.18
  wip_flow_schedules wfs,
  mtl_parameters mp
  -- End revision for version 1.18
  -- ========================================================
  -- WIP Transaction, org and item joins
  -- ========================================================
  where wt.transaction_id                = wta.transaction_id
  -- Revision for version 1.18
  and mp.organization_id               = wta.organization_id
  and wdj.wip_entity_id (+)            = wta.wip_entity_id
  and wdj.organization_id (+)          = wta.organization_id
  and wfs.wip_entity_id (+)            = wta.wip_entity_id
  and wfs.organization_id (+)          = wta.organization_id
  -- End revision for version 1.18
  -- Revision for version 1.17, do not show zero job and flow schedule close variances
  -- and (wt.transaction_type <> 6 and wta.base_transaction_value <> 0)
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                              -- p_org_code, p_trx_date_from, p_trx_date_to, p_wip_job, p_minimum_amount
 ) acct_dist
-- ========================================================
-- WIP Transaction, org and item joins
-- ========================================================
where msiv.organization_id             = acct_dist.organization_id
and msiv.inventory_item_id           = acct_dist.primary_item_id
-- Revision for version 1.15
and we.wip_entity_id                 = acct_dist.wip_entity_id
and bd.department_id (+)             = acct_dist.department_id
and br.resource_id (+)               = acct_dist.resource_id
and ca.activity_id (+)               = acct_dist.activity_id
and cce.cost_element_id (+)          = acct_dist.cost_element_id
and fu.user_id (+)                   = acct_dist.created_by
and wac.class_code (+)               = acct_dist.class_code
-- Revision for version 1.2
and wac.organization_id (+)          = acct_dist.organization_id
-- ========================================================
-- Dynamic SQL joins
-- ========================================================
&project_table_joins
&osp_wip_table_joins
&wip_ovhd_table_joins
-- ========================================================
-- Inventory Org accounting period joins
-- ========================================================
and oap.acct_period_id               = acct_dist.acct_period_id
and oap.organization_id              = acct_dist.organization_id
-- ========================================================
-- Version 1.3, added lookup values to see more detail
-- ========================================================
and ml1.lookup_type                  = 'CST_ACCOUNTING_LINE_TYPE'
and ml1.lookup_code                  = acct_dist.accounting_line_type
and ml2.lookup_type                  = 'WIP_TRANSACTION_TYPE_SHORT'
and ml2.lookup_code                  = acct_dist.transaction_type
and ml3.lookup_type                  = 'WIP_CLASS_TYPE'
and ml3.lookup_code                  = wac.class_type
-- Revision for version 1.13
and ml4.lookup_type                  = 'WIP_ENTITY'
and ml4.lookup_code                  = we.entity_type
-- Revision for version 1.18
and ml5.lookup_type (+)              = 'BOM_AUTOCHARGE_TYPE'
and ml5.lookup_code (+)              = acct_dist.autocharge_type
and ml6.lookup_type (+)              = 'SYS_YES_NO'
and ml6.lookup_code (+)              = to_char(acct_dist.standard_rate_flag)
and ml7.lookup_type (+)              = 'CST_BASIS'
and ml7.lookup_code (+)              = acct_dist.basis_type
and ml8.lookup_type (+)              = 'WIP_JOB_STATUS'
and ml8.lookup_code (+)              = acct_dist.status_type
and ml9.lookup_type (+)              = 'WIP_FLOW_SCHEDULE_STATUS'
and ml9.lookup_code (+)              = acct_dist.status_type
-- End revision for version 1.18
-- Version 1.10, added Item Type lookup values
and fcl.lookup_code (+)              = msiv.item_type
and fcl.lookup_type (+)              = 'ITEM_TYPE'
-- End revision for version 1.10
-- ========================================================
-- using the base tables to avoid using
-- org_organization_definitions and hr_operating_units
-- ========================================================
and hoi.org_information_context      = 'Accounting Information'
and hoi.organization_id              = acct_dist.organization_id
and hoi.organization_id              = haou.organization_id   -- this gets the organization name
and haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                              -- p_assy_number, p_operating_unit, p_ledger
-- ========================================================
-- Revision for version 1.17 and 1.18, SLA and Non-SLA joins.
-- ========================================================
&wip_sla_table_joins
&wip_non_sla_table_joins
-- ==========================================================
-- End revisions for version 1.17 and 1.18
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
 ,we.wip_entity_name
 ,br.resource_code
 &order_by_wip_osp
 &order_by_wip_ovhds
 ,msiv.organization_id