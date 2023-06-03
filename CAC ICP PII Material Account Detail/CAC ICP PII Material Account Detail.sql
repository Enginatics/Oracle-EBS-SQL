/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII Material Account Detail
-- Description: Report to get the Material accounting distributions, in detail, for each item, organization and individual transaction.  Including profit in inventory amounts based on your PII cost type.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  Use Show Projects to display or not display the project information (project number, name, task and project cost collection status) and use Show WIP Job to display or not display the WIP job information (WIP class, class type, WIP job, description, assembly number and assembly description).  To get all positive and negative amounts above a threshold value, use the Absolute Transaction Amount parameter.  For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules).  Both Flow and Workorderless show up as the WIP Type "Flow schedule".

Note:  The SQL logic and code for this report is identical to the CAC Material Account Summary report.

Hidden Parameters:
================
Numeric Sign for PII:  allows you to set the sign of the profit in inventory amounts, defaulted to "1" (mandatory).

Parameters:
===========
PII Cost Type:  the profit in inventory cost type you wish to report (mandatory).
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (mandatory).
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show SLA Accounting:  enter Yes to use the Subledger Accounting rules for your accounting information (mandatory).  If you choose No the report uses the pre-Create Accounting entries.
Show Projects:  display the project information.  Enter Yes or No, use to limit the report size (mandatory).
Show WIP:  display the WIP job or flow schedule information.  Enter Yes or No, use to limit the report size (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Accounting Line Type:  enter the accounting purpose or line type to report (optional). 
Transaction Type:  select the material transaction type, such as PO Receipt, Return to Vendor or Account Alias Issue (optional).
Transaction Source Type:  select the material transaction source, such as Purchase Order or Account Alias (optional).
Transaction Id:  enter the transaction number or identifier to report (optional).
Minimum Absolute Amount:  enter the minimum debit or credit to report (optional).  To see all accounting entries, enter zero (0).
Only Zero Amounts:  use this parameter to find entries with a zero transaction amount (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2009- 2022 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission. 
-- +=============================================================================+
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- | 1.30    21 Oct 2022 Douglas Volz    Logic change for resolving Internal RMA order numbers.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-icp-pii-material-account-detail/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-material-account-detail/
-- Run Report: https://demo.enginatics.com/

with pii as
 -- ===========================================================
 -- Revision 1.29, Inline select for Profit in Inventory costs
 -- ===========================================================
 (select sum(nvl(cicd.item_cost, 0)) pii_item_cost,
  sum(nvl(cicd.item_cost,0)) * decode(sign('&p_sign_pii'),1,1,-1,-1,1) corrected_pii_item_cost,
  cicd.inventory_item_id,
  cicd.organization_id,
  cct.cost_type pii_cost_type
  from cst_item_cost_details cicd,
  bom_resources br,
  cst_cost_types cct,
  mtl_parameters mp
  where cicd.resource_id                = br.resource_id
  and cicd.cost_type_id               = cct.cost_type_id
  and mp.organization_id              = cicd.organization_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 3=3                             -- p_org_code
  and 5=5                             -- p_pii_cost_type, p_pii_sub_element
  &only_no_pii
  group by
  cicd.inventory_item_id,
  cicd.organization_id,
  cct.cost_type
 )

----------------main query starts here--------------

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 acct_dist.organization_code Org_Code,
 -- Revision for version 1.8
 haou2_from.name From_OU,
 haou2_to.name To_OU,
 nvl((select ml2.meaning
      from mfg_lookups ml2
      where ml2.lookup_type  = 'MTL_FOB_POINT'
      and ml2.lookup_code  = acct_dist.fob_point),'') FOB_Point,
 acct_dist.ship_from_org Ship_From_Org,
 acct_dist.ship_to_org Ship_To_Org,
 -- Revision for version 1.25
 -- ah.period_name Period_Name,
 oap.period_name Period_Name,
 -- End revision for version 1.25
 &segment_columns
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 -- Revision for version 1.6 and 1.19, add in item type
 fcl.meaning Item_Type,
 -- Revision for version 1.22
 misv.inventory_item_status_code Item_Status,
 -- Revision for version 1.23
 ml2.meaning Make_Buy_Code,
 -- Revision for version 1.12 and 1.24
&category_columns
 ml1.meaning Accounting_Line_Type,
 mtt.transaction_type_name Transaction_Type,
 -- Revision for version 1.13
 mtst.transaction_source_type_name Transaction_Source,
 -- Revision for version 1.27
 acct_dist.document_order_num Document_Number,
 decode(acct_dist.transaction_source_type_id,
     2, acct_dist.order_type, -- Sales order
     8, acct_dist.order_type, -- Internal order
    12, acct_dist.order_type, -- RMA
   101, acct_dist.order_type, -- Internal RMA
   null) Order_Type,
 br.resource_code Sub_Element,
 acct_dist.transaction_id Transaction_Id,
 acct_dist.transfer_transaction_id Transfer_Transaction_Id,
 acct_dist.parent_transaction_id Parent_Transaction_Id,
 acct_dist.transaction_date Transaction_Date,
 acct_dist.creation_date Creation_Date,
 fu.user_name Created_By,
 acct_dist.transaction_reference Transaction_Comments,
 -- End revision for version 1.27
 -- Revision for version 1.25
 msub.secondary_inventory_name Subinventory,
 msub.description Subinventory_Description,
 -- Revision for version 1.27
 acct_dist.transfer_subinventory Transfer_Subinventory,
 ccg.cost_group Cost_Group,
 ccg_xfer.cost_group Transfer_Cost_Group,
 -- End revision for version 1.27
 &p_show_project
 &p_show_wip_job
        muomv.uom_code UOM_Code,
 acct_dist.primary_quantity Quantity,
 -- Revision for version 1.27
 cce.cost_element Cost_Element,
 gl.currency_code Currency_Code,
 acct_dist.Matl_Amount Material_Amount,
 acct_dist.Matl_Ovhd_Amount Material_Overhead_Amount,
  acct_dist.Resource_Amount Resource_Amount,
 acct_dist.OSP_Amount Outside_Processing_Amount,
 acct_dist.Overhead_Amount Overhead_Amount,
 -- Revision for version 1.27
 round(acct_dist.mta_amount /
      decode(acct_dist.primary_quantity, 0, 1, acct_dist.primary_quantity),5) Item_Cost,
 -- End revision for version 1.27
 acct_dist.mta_amount Amount
 -- Revision for version 1.26
 &p_show_pii
from mtl_system_items_vl msiv,
 org_acct_periods oap,
 mtl_transaction_types mtt,
 -- Revision for version 1.21
 mtl_units_of_measure_vl muomv,
 -- Revision for version 1.22
 mtl_item_status_vl misv,
 -- Revision for version 1.13
 mtl_txn_source_types mtst,
 -- Revision for version 1.29
 pii,
 -- Revision for version 1.27
 mtl_secondary_inventories msub,
 mtl_transaction_reasons mtr,
 cst_cost_groups ccg,
 cst_cost_groups ccg_xfer,
 cst_cost_elements cce,
 bom_resources br,
 fnd_user fu,
 -- End revision for version 1.27
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou, -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 hr_organization_information hoi_from,
 hr_all_organization_units_vl haou_from, -- inv_organization_id
 hr_all_organization_units_vl haou2_from, -- operating unit
 hr_organization_information hoi_to,
 hr_all_organization_units_vl haou_to, -- inv_organization_id
 hr_all_organization_units_vl haou2_to, -- operating unit
 gl_ledgers gl,
 -- Revision for version 1.19
 fnd_common_lookups fcl, -- Item Type
 mfg_lookups ml1, -- Accounting Line Type
 mfg_lookups ml2, -- Planning Make Buy Code
 -- Revision for versions 1.26 and 1.27
 &pii_lookup_table
 &project_tables
 &mtl_sla_tables
 -- Revision for version 1.26
 -- ===========================================================
 -- Inline select for finding components with PII not issued to WIP
 -- ===========================================================
 -- get the corrected wip component issue status
 (select wro.organization_id,
  wro.wip_entity_id,
  wro.primary_item_id,
  'N' wip_pii_component_quantity,
  5 transaction_source_type_id
  from (select wrosum.wip_entity_id,
   wrosum.organization_id,
   wrosum.primary_item_id,
   wrosum.inventory_item_id,
   sum(wrosum.quantity_issued) quantity_issued
   from (select wro.wip_entity_id,
    wro.organization_id,
    wdj.primary_item_id,
    wro.inventory_item_id,
    wro.quantity_issued
    from wip_requirement_operations wro,
    wip_discrete_jobs wdj,
    -- Revision for version 1.29
    -- Only select components with PII
    -- cst_item_cost_details cicd,
    -- cst_cost_types cct,
    -- bom_resources br,
    pii cicd,
    -- End revision for version 1.29
    mtl_parameters mp
    where wdj.wip_entity_id               = wro.wip_entity_id
    and wdj.organization_id             = wro.organization_id
    and wdj.organization_id             = mp.organization_id
    -- Do not select phantom (6) or bulk (4) WIP supply types, typically not issued to WIP
    and wro.wip_supply_type not in (4,6)
    -- find jobs to highlight that were open during the report period or closed after the transaction to date 
    and (wdj.date_closed is null -- the job is open
     and wdj.creation_date < :p_trx_date_to + 1
      or -- the job is closed and ...the job was closed after the transaction from date 
     wdj.date_closed is not null
     and wdj.date_closed >= :p_trx_date_to + 1
    )
    -- Only select components with PII
    and cicd.inventory_item_id          = wro.inventory_item_id
    and cicd.organization_id            = wro.organization_id
    -- Revision for version 1.29
    -- and cicd.cost_type_id               = cct.cost_type_id
    -- and cicd.resource_id                = br.resource_id
    -- and cicd.item_cost                 <> 0
    and cicd.pii_item_cost             <> 0
    -- End revision for version 1.29
    and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 3=3                             -- p_org_code
    &only_no_pii
    union all
    select mmt.transaction_source_id,
    wro.organization_id,
    wdj.primary_item_id,
    mmt.inventory_item_id,
    decode(mmt.transaction_type_id,
     35, mmt.primary_quantity,     -- wip component issue
      43, -1 * mmt.primary_quantity -- wip component return
          ) quantity_issued
    from mtl_material_transactions mmt,
    wip_discrete_jobs wdj,
    wip_requirement_operations wro,
    -- Revision for version 1.29
    -- Only select components with PII
    -- cst_item_cost_details cicd,
    -- cst_cost_types cct,
    -- bom_resources br,
    pii cicd,
    -- End revision for version 1.29
    mtl_parameters mp
    where mmt.transaction_source_type_id  = 5
    and mmt.transaction_source_id       = wdj.wip_entity_id
    and mmt.organization_id             = wdj.organization_id
    and mp.organization_id              = wdj.organization_id
    -- Revision for version 1.29, join to wdj, not mmt, for performance
    and wro.wip_entity_id               = wdj.wip_entity_id
    and wro.organization_id             = wdj.organization_id
    -- End revision for version 1.29
    and mmt.operation_seq_num           = wro.operation_seq_num
    and mmt.transaction_date           >= :p_trx_date_to + 1
    -- Do not select phantom (6) or bulk (4) WIP supply types, typically not issued to WIP
    and wro.wip_supply_type not in (4,6)
    -- find jobs to highlight that were open during the report period or closed after the transaction to date 
    and (wdj.date_closed is null -- the job is open
     and wdj.creation_date < :p_trx_date_to + 1
      or -- the job is closed and ...the job was closed after the transaction from date 
     wdj.date_closed is not null
     and wdj.date_closed >= :p_trx_date_to + 1
    )
    -- Only select components with PII
    and cicd.inventory_item_id          = wro.inventory_item_id
    and cicd.organization_id            = wro.organization_id
    -- Revision for version 1.29
    and cicd.inventory_item_id          = mmt.inventory_item_id
    and cicd.organization_id            = mmt.organization_id
    -- and cicd.cost_type_id               = cct.cost_type_id
    -- and cicd.resource_id                = br.resource_id
    -- and cicd.item_cost                 <> 0
    and cicd.pii_item_cost             <> 0
    -- End revision for version 1.29
    and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 3=3                             -- p_org_code
    &only_no_pii
   ) wrosum
    group by
   wrosum.wip_entity_id,
   wrosum.organization_id,
   wrosum.primary_item_id,
   wrosum.inventory_item_id) wro
  -- Only select components with no issues to WIP
  where nvl(wro.quantity_issued,0)      = 0
  &only_no_pii
  group by
  wro.organization_id,
  wro.wip_entity_id,
  wro.primary_item_id,
  'N', -- wip_pii_component_quantity
  5 --transaction_source_type_id
 ) wro_pii,
 -- End revision for version 1.26
 -- ==========================================================================
 -- Use this inline table to fetch the material transactions
 -- ==========================================================================
 (
  select mp.organization_code organization_code,
  -- Fix for version 1.6
  -- Revision for version 1.5
  decode(mmt.transaction_action_id,
    3, mp_mmt_org.organization_code,  -- Direct Org Transfer, txn_id 3
    9, mp_mmt_org.organization_code,  -- Logical Intercompany Sales Issue, txn_id 11
   10, mp_xfer_org.organization_code, -- Logical Intercompany Shipment Receipt, txn_id 10
   12, mp_xfer_org.organization_code, -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
   13, mp_mmt_org.organization_code,  -- Logical Intercompany Receipt Return, txn_id 13
   15, mp_xfer_org.organization_code, -- Logical Intransit Receipt, txn_id 76
   -- Revision for version 1.11
   17, mp_xfer_org.organization_code, -- Logical Expense Requisition Receipt, txn_id 27
   21, mp_mmt_org.organization_code,  -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
   22, mp_mmt_org.organization_code,  -- Logical Intransit Shipment, tnx_id 60, 65
      '') ship_from_org,
                decode(mmt.transaction_action_id,
    3, mp_xfer_org.organization_code, -- Direct Org Transfer, txn_id 3
    9, mp_xfer_org.organization_code, -- Logical Intercompany Sales Issue, txn_id 11
   10, mp_mmt_org.organization_code,  -- Logical Intercompany Shipment Receipt, txn_id 10
   12, mp_mmt_org.organization_code,  -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
   13, mp_xfer_org.organization_code, -- Logical Intercompany Receipt Return, txn_id 13
   15, mp_mmt_org.organization_code,  -- Logical Intransit Receipt, txn_id 76
   -- Revision for version 1.11
   17, mp_mmt_org.organization_code,  -- Logical Expense Requisition Receipt, txn_id 27
   21, mp_xfer_org.organization_code, -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
   22, mp_xfer_org.organization_code, -- Logical Intransit Shipment, tnx_id 60, 65
      '') ship_to_org,
  -- End revision for version 1.5
  -- End revision for version 1.6 
  mp.organization_id organization_id,
  -- Revision for version 1.8
                decode(mmt.transaction_action_id,
    3, mp_mmt_org.organization_id,  -- Direct Org Transfer, txn_id 3
    9, mp_mmt_org.organization_id,  -- Logical Intercompany Sales Issue, txn_id 11
   10, mp_xfer_org.organization_id, -- Logical Intercompany Shipment Receipt, txn_id 10
   12, mp_xfer_org.organization_id, -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
   13, mp_mmt_org.organization_id,  -- Logical Intercompany Receipt Return, txn_id 13
   15, mp_xfer_org.organization_id, -- Logical Intransit Receipt, txn_id 76
   -- Revision for version 1.11
   17, mp_xfer_org.organization_id, -- Logical Expense Requisition Receipt, txn_id 27 
   21, mp_mmt_org.organization_id,  -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
   22, mp_mmt_org.organization_id,  -- Logical Intransit Shipment, tnx_id 60, 65
   mta.organization_id) ship_from_org_id,
  decode(mmt.transaction_action_id,
    3, mp_xfer_org.organization_id, -- Direct Org Transfer, txn_id 3
    9, mp_xfer_org.organization_id, -- Logical Intercompany Sales Issue, txn_id 11
   10, mp_mmt_org.organization_id,  -- Logical Intercompany Shipment Receipt, txn_id 10
   12, mp_mmt_org.organization_id,  -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
   13, mp_xfer_org.organization_id, -- Logical Intercompany Receipt Return, txn_id 13
   15, mp_mmt_org.organization_id,  -- Logical Intransit Receipt, txn_id 76
   -- Revision for version 1.11
   17, mp_mmt_org.organization_id,  -- Logical Expense Requisition Receipt, txn_id 27
   21, mp_xfer_org.organization_id, -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
   22, mp_xfer_org.organization_id, -- Logical Intransit Shipment, tnx_id 60, 65
   mta.organization_id) ship_to_org_id,
  mmt.fob_point fob_point,
  -- End revision for version 1.8
  mmt.acct_period_id acct_period_id,
  mta.reference_account reference_account,
  mta.inv_sub_ledger_id inv_sub_ledger_id,
  mmt.inventory_item_id,
  mmt.transaction_source_type_id,
  -- Revision for version 1.27
  &show_document_number
  nvl((select ottt.name
       from   oe_order_lines_all ool,
              oe_order_headers_all ooh,
              oe_transaction_types_tl ottt 
       where  ooh.order_type_id          = ottt.transaction_type_id
       and    ooh.header_id              = ool.header_id
       and    mmt.trx_source_line_id     = ool.line_id
       and    ottt.language              = userenv('lang')),'') order_type,
  mmt.transaction_id,
  mmt.transfer_transaction_id,
  mmt.parent_transaction_id,
  mta.transaction_date,
  mta.creation_date,
  mmt.created_by,
  mmt.reason_id,
  regexp_replace(mmt.transaction_reference,'[^[:alnum:]'' '']', null) transaction_reference,
  -- End for revision 1.27
  mmt.transaction_type_id,
  mta.accounting_line_type,
  -- Revision for version 1.15
  decode(mta.accounting_line_type, 7, ml1.meaning, 14, ml1.meaning, 1,
   decode(mmt.transaction_action_id,
     2, decode(sign (mta.primary_quantity),
     -1, mmt.subinventory_code,
      1, mmt.transfer_subinventory,
     mmt.subinventory_code
                            ),
     3, decode(mmt.organization_id,
     mta.organization_id, mmt.subinventory_code,
     mmt.transfer_subinventory
       ),
    21, decode(sign (mta.primary_quantity),
     -1, mmt.subinventory_code,
      1, mmt.transfer_subinventory,
     mmt.subinventory_code
       ),
    22, decode(sign (mta.primary_quantity),
     -1, mmt.subinventory_code,
      1, mmt.transfer_subinventory,
     mmt.subinventory_code
       ),
    28, decode(sign (mta.primary_quantity),
     -1, mmt.subinventory_code,
      1, mmt.transfer_subinventory,
     mmt.subinventory_code
       ),
    mmt.subinventory_code
    -- Fix for version 1.6
    -- )
         ) 
        ) subinventory_code,
  -- End revision for version 1.15
  -- Revision for version 1.27
  mmt.transfer_subinventory,
  mmt.cost_group_id,
  mmt.transfer_cost_group_id,
  -- End revision for version 1.27
  -- Revision for version 1.26
  mmt.transaction_source_id,
  -- Revision for version 1.25
  mmt.project_id,
  -- Revision for version 1.27
  mmt.task_id,
  mmt.pm_cost_collected,
  -- End revision for version 1.27
  null wip_class,
  null class_type,
  null wip_type,
  null job,
  null fg_item,
  null fg_description,
  -- End revision for version 1.25
  -- Revision for version 1.20 and 1.28, logic fix for the transaction quantity
  decode(mmt.transaction_action_id, 
   24, mmt.quantity_adjusted,
   mta.primary_quantity
        ) primary_quantity,
  -- Revision for version 1.27
  mta.cost_element_id,
  mta.resource_id,
  -- End revision for version 1.27
  -- Revision for version 1.13
  decode(mta.cost_element_id,
   1, mta.base_transaction_value,
   0) Matl_Amount,
  decode(mta.cost_element_id,
   2, mta.base_transaction_value,
   0) Matl_Ovhd_Amount,
   decode(mta.cost_element_id,
   3, mta.base_transaction_value,
   0) Resource_Amount,
  decode(mta.cost_element_id,
   4, mta.base_transaction_value,
   0) OSP_Amount,
  decode(mta.cost_element_id,
   5, mta.base_transaction_value,
   0) Overhead_Amount,
  -- End revision for version 1.13
  mta.base_transaction_value mta_amount
  &p_show_pii2
  from mtl_transaction_accounts mta,
  mtl_material_transactions mmt,
  mtl_parameters mp,
  mtl_parameters mp_xfer_org,   -- Transfer Org
  mtl_parameters mp_mmt_org,    -- MMT Org
  mfg_lookups ml1, -- Accounting Line Type
  -- Revision for version 1.27
  mfg_lookups ml2 -- Transaction Action
  -- ========================================================
  -- Material transaction, date, org and item joins
  -- ========================================================
  where mta.transaction_id              = mmt.transaction_id
  and mp.organization_id              = mta.organization_id
  and mp_xfer_org.organization_id     = nvl(mmt.transfer_organization_id, mmt.organization_id)
  and mp_mmt_org.organization_id      = mmt.organization_id
  -- to use the mmt index N1 by inventory_item_id, organization_id and date
  and mmt.inventory_item_id           = mta.inventory_item_id
  and ml1.lookup_type (+)             = 'CST_ACCOUNTING_LINE_TYPE'
  and ml1.lookup_code (+)             = mta.accounting_line_type
  -- Revision for version 1.27
  and ml2.lookup_type (+)             = 'MTL_TRANSACTION_ACTION'
  and ml2.lookup_code (+)             = mmt.transaction_action_id
  -- End revision for version 1.27
  and 2=2                             -- p_trx_date_from, p_trx_date_to
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 3=3                             -- p_org_code
  and 4=4                             -- p_item_number, p_min_transaction_amount, p_max_transaction_amount, p_absolute_txn_amount
  and 6=6                             -- p_transaction_type
  and 7=7                             -- p_transaction_source
  &only_non_wip_sources1
  union all
  -- Revision for version 1.25
  -- Now join to WIP entries
  select mp.organization_code organization_code,
  null ship_from_org,
  null ship_to_org,
  mp.organization_id organization_id,
  -- Revision for version 1.8
  mp.organization_id ship_from_org_id,
  mp.organization_id ship_to_org_id,
  mmt.fob_point fob_point,
  -- End revision for version 1.8
  mmt.acct_period_id acct_period_id,
  mta.reference_account reference_account,
  mta.inv_sub_ledger_id inv_sub_ledger_id,
  mmt.inventory_item_id,
  mmt.transaction_source_type_id,
  -- Revision for version 1.27
  decode(mmt.transaction_source_type_id,
    5, (select we.wip_entity_name                                               -- Job or Schedule
        from   wip_entities we
        where  we.wip_entity_id          = mmt.transaction_source_id),
    null
        ) document_order_num,
  null order_type,
  mmt.transaction_id,
  mmt.transfer_transaction_id,
  mmt.parent_transaction_id,
  mta.transaction_date,
  mta.creation_date,
  mmt.created_by,
  mmt.reason_id,
  regexp_replace(mmt.transaction_reference,'[^[:alnum:]'' '']', null) transaction_reference,
  -- End for revision 1.27
  mmt.transaction_type_id,
  mta.accounting_line_type,
  -- Revision for version 1.15
  decode(mta.accounting_line_type, 7, ml1.meaning, 14, ml1.meaning, 1,
   decode(mmt.transaction_action_id,
     2, decode(sign (mta.primary_quantity),
     -1, mmt.subinventory_code,
      1, mmt.transfer_subinventory,
     mmt.subinventory_code
                           ),
     3, decode(mmt.organization_id,
     mta.organization_id, mmt.subinventory_code,
     mmt.transfer_subinventory
       ),
    21, decode(sign (mta.primary_quantity),
     -1, mmt.subinventory_code,
      1, mmt.transfer_subinventory,
     mmt.subinventory_code
       ),
    22, decode(sign (mta.primary_quantity),
     -1, mmt.subinventory_code,
      1, mmt.transfer_subinventory,
     mmt.subinventory_code
       ),
    28, decode(sign (mta.primary_quantity),
     -1, mmt.subinventory_code,
      1, mmt.transfer_subinventory,
     mmt.subinventory_code
       ),
    mmt.subinventory_code
    -- Fix for version 1.6
    -- )
                ) 
        ) subinventory_code,
  -- End revision for version 1.15
  -- Revision for version 1.27
  mmt.transfer_subinventory,
  mmt.cost_group_id,
  mmt.transfer_cost_group_id,
  -- End revision for version 1.27
  -- Revision for version 1.26
  mmt.transaction_source_id,
  -- Revision for version 1.25
  mmt.project_id,
  -- Revision for version 1.27
  mmt.task_id,
  mmt.pm_cost_collected,
  -- End revision for version 1.27
  wac.class_code wip_class,
  ml3.meaning class_type,
  ml4.meaning wip_type,
  we.wip_entity_name job,
  msiv2.concatenated_segments fg_item,
  msiv2.description fg_description,
  -- End revision for version 1.25
  -- Revision for version 1.20 and 1.28, logic fix for the transaction quantity
  decode(mmt.transaction_action_id, 
   24, mmt.quantity_adjusted,
   mta.primary_quantity
        ) primary_quantity,
  -- Revision for version 1.27
  mta.cost_element_id,
  mta.resource_id,
  -- End revision for version 1.27
  -- Revision for version 1.13
  decode(mta.cost_element_id,
   1, mta.base_transaction_value,
   0) Matl_Amount,
  decode(mta.cost_element_id,
   2, mta.base_transaction_value,
   0) Matl_Ovhd_Amount,
   decode(mta.cost_element_id,
   3, mta.base_transaction_value,
   0) Resource_Amount,
  decode(mta.cost_element_id,
   4, mta.base_transaction_value,
   0) OSP_Amount,
  decode(mta.cost_element_id,
   5, mta.base_transaction_value,
   0) Overhead_Amount,
  -- End revision for version 1.13
  mta.base_transaction_value mta_amount
  &p_show_pii2
  from mtl_transaction_accounts mta,
  mtl_material_transactions mmt,
  mtl_parameters mp,
  wip_entities we,
  wip_accounting_classes wac,
  wip_discrete_jobs wdj,
  wip_flow_schedules wfs,
  mtl_system_items_vl msiv2,
  mfg_lookups ml1, -- Accounting Line Type
  mfg_lookups ml3, -- Class Type
  mfg_lookups ml4  -- WIP Type
  -- ========================================================
  -- Material Transaction, date, wip job, org and item joins
  -- ========================================================
  where mta.transaction_id              = mmt.transaction_id
  and mp.organization_id              = mta.organization_id
  and mta.transaction_source_type_id  = 5
  -- This gets rid of the full table scan on wip_entities
  and wdj.wip_entity_id (+)           = mta.transaction_source_id
  and wdj.organization_id (+)         = mta.organization_id
  and wfs.wip_entity_id (+)           = mta.transaction_source_id
  and wfs.organization_id (+)         = mta.organization_id
  and we.wip_entity_id  (+)           = mta.transaction_source_id
  and wac.class_code                  = nvl(wdj.class_code, wfs.class_code)
  and wac.organization_id             = mp.organization_id
  and we.primary_item_id              = msiv2.inventory_item_id
  and we.organization_id              = msiv2.organization_id
  and ml1.lookup_type (+)             = 'CST_ACCOUNTING_LINE_TYPE'
  and ml1.lookup_code (+)             = mta.accounting_line_type
  and ml3.lookup_type (+)             = 'WIP_CLASS_TYPE'
  and ml3.lookup_code (+)             = wac.class_type
  and ml4.lookup_type (+)             = 'WIP_ENTITY'
  and ml4.lookup_code (+)             = we.entity_type
  -- to use the mmt index N1 by inventory_item_id, organization_id and date
  and mmt.inventory_item_id           = mta.inventory_item_id
  and 2=2                             -- p_trx_date_from, p_trx_date_to
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 3=3                             -- p_org_code
  and 4=4                             -- p_item_number, p_min_transaction_amount, p_max_transaction_amount, p_absolute_txn_amount
  and 6=6                             -- p_transaction_type
  &only_non_wip_sources2
  -- End revision for version 1.25
 ) acct_dist
-- ========================================================
-- Material Transaction, org and item joins
-- ========================================================
where msiv.organization_id             = acct_dist.organization_id
and msiv.inventory_item_id           = acct_dist.inventory_item_id
and mtt.transaction_type_id          = acct_dist.transaction_type_id
-- Revision for version 1.14
-- Join to mta instead of mmt for faster performance
-- and mmt.transaction_source_type_id   = mtst.transaction_source_type_id
and mtst.transaction_source_type_id  = acct_dist.transaction_source_type_id
-- Revision for version 1.21
and msiv.primary_uom_code            = muomv.uom_code
-- Revision for version 1.22
and msiv.inventory_item_status_code  = misv.inventory_item_status_code
and oap.acct_period_id               = acct_dist.acct_period_id
-- Revision for version 1.27
-- This join does not work with interorg transfers
-- and oap.organization_id              = acct_dist.organization_id
-- Revision for version 1.26
and acct_dist.inventory_item_id      = pii.inventory_item_id (+)
and acct_dist.organization_id        = pii.organization_id (+)
and acct_dist.organization_id        = wro_pii.organization_id (+)
and acct_dist.inventory_item_id      = wro_pii.primary_item_id (+)
and acct_dist.transaction_source_id  = wro_pii.wip_entity_id (+)
and acct_dist.transaction_source_type_id = wro_pii.transaction_source_type_id (+)
-- End revision for version 1.26
-- Revision for version 1.27
and acct_dist.reason_id              = mtr.reason_id (+)
and acct_dist.created_by             = fu.user_id (+)
and acct_dist.resource_id            = br.resource_id (+)
and acct_dist.subinventory_code      = msub.secondary_inventory_name (+)
and acct_dist.organization_id        = msub.organization_id (+)
and acct_dist.cost_group_id          = ccg.cost_group_id (+)
and acct_dist.cost_group_id          = ccg_xfer.cost_group_id (+)
and acct_dist.cost_element_id        = cce.cost_element_id (+)
-- End revision for version 1.27
-- ========================================================
-- Revision for version 1.25, 1.27 Dynamic SQL joins
-- ========================================================
&project_table_joins
&pii_table_joins
-- ========================================================
-- using base tables for organization information
-- ========================================================
and hoi.org_information_context      = 'Accounting Information'
and hoi.organization_id              = acct_dist.organization_id
and hoi.organization_id              = haou.organization_id   -- this gets the organization name
and haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
and 1=1                              -- p_operating_unit, p_ledger, p_only_zero_amounts
-- ========================================================
-- Revision for version 1.8
-- Joins for From and To Operating Units
-- ========================================================
and hoi_from.org_information_context = 'Accounting Information'
and hoi_from.organization_id         = acct_dist.ship_from_org_id
and hoi_from.organization_id         = haou_from.organization_id   -- this gets the organization name
and haou2_from.organization_id       = to_number(hoi_from.org_information3) -- this gets the operating unit id
and hoi_to.org_information_context   = 'Accounting Information'
and hoi_to.organization_id           = acct_dist.ship_to_org_id
and hoi_to.organization_id           = haou_to.organization_id   -- this gets the organization name
and haou2_to.organization_id         = to_number(hoi_to.org_information3) -- this gets the operating unit id
-- ========================================================
-- Lookup values to see more detail
-- ========================================================
and fcl.lookup_code (+)              = msiv.item_type
and fcl.lookup_type (+)              = 'ITEM_TYPE'
and ml1.lookup_type                  = 'CST_ACCOUNTING_LINE_TYPE'
and ml1.lookup_code                  = acct_dist.accounting_line_type
-- Revision for version 1.23
and ml2.lookup_type                  = 'MTL_PLANNING_MAKE_BUY'
and ml2.lookup_code                  = msiv.planning_make_buy_code
-- ========================================================
-- Revision for version 1.25, SLA and Non-SLA joins.
-- ========================================================
&mtl_sla_table_joins
&mtl_non_sla_table_joins
-- Revision for version 1.15
order by
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, -- Operating_Unit
 acct_dist.organization_code, -- Org_Code
 -- Revision for version 1.25
 -- ah.period_name,
 oap.period_name,
 -- End revision for version 1.25
 &segment_columns_grp
 msiv.concatenated_segments, -- Item_Number
 ml1.meaning, -- Accounting Line Type
 mtt.transaction_type_name,
 -- Revision for version 1.25
 msub.secondary_inventory_name
 &order_by_project
 &order_by_wip
 ,acct_dist.organization_id