/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Recost Cost of Goods Sold
-- Description: Report to compare the "as transacted" cost of goods sold (COGS) transactions in Oracle Inventory with the "what if" costs from a simulation cost type.  Use this report when you need to make manual journal entry corrections to your COGS entries, due to incorrect item costs.  In addition to reporting the normal COGS entries for the COGS Recognition, Sales Order Issue, RMA Receipt and RMA Return transactions, you can also report user-defined material transactions such as Account Issues/Receipts, Miscellaneous Issues/Receipts and Account Alias transactions which could represent COGS entries from other ERP Systems.  To report additional user-defined transactions enter these along with the defaulted values for the COGS Transaction Type parameter:  COGS Recognition, Sales Order Issue, RMA Receipt and RMA Return.

Note:  in order for COGS entries to be reported you must first run Create Accounting.

Parameters:
===========
Transaction Date From:  enter the starting transaction date for COGS transactions (mandatory).
Transaction Date To:  enter the ending transaction date for PO COGS transactions (mandatory).
COGS Transaction Types:  enter the COGS related transaction types you wish to report (mandatory).
Recost Cost Type:  enter the cost type you wish to use to recost your COGS transactions (mandatory).
Minimum Value Difference:  the absolute smallest COGS difference you want to report (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2006- 2023 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_recost_cogs_detail_rept.sql
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     02 Apr 2006 Douglas Volz   Initial Coding
-- |  1.1     28 Apr 2006 Douglas Volz   Final Coding
-- |  1.2     02 May 2017 Douglas Volz   Modified for Client's use, added inline table
-- |                                     to get one row for COGS accounting entries, to
-- |                                     to get the mmt correct qty and avoid cross-joining.
-- |  1.3     13 Nov 2023 Douglas Volz   Modified for organization access, removed tabs and
-- |                                     added subledger accounting ccids.
-- |  1.4     16 Nov 2023 Douglas Volz   Remove org_acct_periods, use period name from xla_ae_headers.
-- |  1.5     05 Dec 2023 Douglas Volz   Added G/L and Operating Unit security restrictions.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-recost-cost-of-goods-sold/
-- Library Link: https://www.enginatics.com/reports/cac-recost-cost-of-goods-sold/
-- Run Report: https://demo.enginatics.com/

select  gl.name Ledger,
        haou2.name Operating_Unit,
        cogs.organization_code Org_Code,
        haou.name Organization_Name,
        -- Revision for version 1.4
        -- oap.period_name Period_Name,
        ah.period_name Period_Name,
        -- End revision for version 1.4
        &segment_columns
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
        fcl.meaning Item_Type,
        misv.inventory_item_status_code_tl Item_Status,
        ml1.meaning Make_Buy_Code,
        ml2.meaning Based_on_Rollup,
        ml3.meaning Inventory_Asset,
        ml4.meaning Accounting_line_Type,
        cogs.transaction_type_name Transaction_Type,
        mtst.transaction_source_type_name Transaction_Source,
        -- Revision for version 1.3
        cogs.document_order_num Document_Number,
        cogs.order_type Order_Type,
        cogs.transaction_id Transaction_Id,
        cogs.transaction_date Transaction_Date,
        cogs.transaction_reference Transaction_Comments,
&category_columns
        muomv.uom_code UOM_Code,
        sum(cogs.primary_quantity) Quantity,
        sum(cogs.base_transaction_value) Original_COGS,
        -- Revision for version 1.3
        round(sum(decode(cic.item_cost, null, cogs.base_transaction_value, cic.item_cost * cogs.primary_quantity)),2) New_COGS,
        round(decode(sign(sum(decode(cic.item_cost, null, cogs.base_transaction_value, cic.item_cost * cogs.primary_quantity)) - sum(cogs.base_transaction_value)),-1,0,1,
                          sum(decode(cic.item_cost, null, cogs.base_transaction_value, cic.item_cost * cogs.primary_quantity)) - sum(cogs.base_transaction_value),
                          sum(decode(cic.item_cost, null, cogs.base_transaction_value, cic.item_cost * cogs.primary_quantity)) - sum(cogs.base_transaction_value)),2) Debit_COGS_Amount,
        abs(round(decode(sign(sum(decode(cic.item_cost, null, cogs.base_transaction_value, cic.item_cost * cogs.primary_quantity)) - sum(cogs.base_transaction_value)), 1,0,-1,
                              sum(decode(cic.item_cost, null, cogs.base_transaction_value, cic.item_cost * cogs.primary_quantity)) - sum(cogs.base_transaction_value),
                              sum(decode(cic.item_cost, null, cogs.base_transaction_value, cic.item_cost * cogs.primary_quantity)) - sum(cogs.base_transaction_value)),2)) Credit_COGS_Amount,
        round(sum(decode(cic.item_cost, null, cogs.base_transaction_value, cic.item_cost * cogs.primary_quantity)) - sum(cogs.base_transaction_value),2) Difference,
        -- Percent Difference = Difference / Original COGS
        round((sum(decode(cic.item_cost, null, cogs.base_transaction_value, cic.item_cost * cogs.primary_quantity)) - sum(cogs.base_transaction_value)) /
                   (decode(sum(cogs.base_transaction_value), 0, 1, sum(cogs.base_transaction_value))) * 100, 1) Percent_Difference
        -- End revision for version 1.3
from    -- Revision for version 1.3
        mtl_system_items_vl msiv,
        mtl_txn_source_types mtst,
        cst_item_costs cic,
        cst_cost_types cct,
        mtl_item_status_vl misv,
        mtl_units_of_measure_vl muomv,
        -- Revision for version 1.4
        -- org_acct_periods oap,
        mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
        mfg_lookups ml2, -- based on rollup, CST_BONROLLUP_VAL
        mfg_lookups ml3, -- inventory_asset_flag, SYS_YES_NO
        mfg_lookups ml4, -- accounting line type, CST_ACCOUNTING_LINE_TYPE
        fnd_common_lookups fcl, -- Item Type
        -- Revision for version 1.2
        (select mp.organization_code,
                mp.organization_id,
                mta.transaction_id,
                mta.inventory_item_id,
                mmt.transaction_type_id,
                mmt.acct_period_id,
                mtt.transaction_type_name,
                mta.accounting_line_type,
                mta.reference_account,
                mta.inv_sub_ledger_id,
                mmt.transaction_source_type_id,
                -- Revision for version 1.3
                decode(mmt.transaction_source_type_id,
                        1, (select poh.segment1                                                     -- Purchase Order
                            from   po_headers_all poh
                             where poh.po_header_id          = mmt.transaction_source_id),
                        2, (select ooh.order_number                                                 -- Sales order
                            from   oe_order_headers_all ooh,
                                   oe_order_lines_all ool
                            where  ooh.header_id             = ool.header_id
                            and    ool.line_id               = mmt.trx_source_line_id),
                        3, ml5.meaning,                                                             -- Account
                        4, (select ooh.order_number                                                 -- Move order
                            from   oe_order_headers_all ooh,
                                   oe_order_lines_all ool
                            where  ooh.header_id             = ool.header_id
                            and    ool.line_id               = mmt.trx_source_line_id),
                        5, (select we.wip_entity_name                                               -- Job or Schedule
                            from   wip_entities we
                            where  we.wip_entity_id          = mmt.transaction_source_id),
                        6, (select mgd.segment1                                                     -- Account alias
                            from   mtl_generic_dispositions mgd
                            where  mgd.disposition_id        = mmt.transaction_source_id),
                        7, (select prh.segment1                                                     -- Internal requisition
                            from   po_requisition_headers_all prh
                         where  prh.requisition_header_id    = mmt.transaction_source_id),
                        8, (select ooh.order_number                                                 -- Internal order
                            from   oe_order_headers_all ooh,
                                   oe_order_lines_all ool
                            where  ooh.header_id             = ool.header_id
                            and    ool.line_id               = mmt.trx_source_line_id),
                        9, (select mcch.cycle_count_header_name                                     -- Cycle count
                            from   mtl_cycle_count_headers mcch
                            where  mcch.cycle_count_header_id = mmt.transaction_source_id),
                       10, (select mpi.description                                                  -- Physical inventory
                            from   mtl_physical_inventories mpi
                            where  mpi.physical_inventory_id = mmt.transaction_source_id),
                       11, (select description                                                      -- Std cost update
                            from   cst_cost_updates ccu
                            where  ccu.cost_update_id        = mmt.cost_update_id),
                       12, (select ooh.order_number                                                 -- RMA
                            from   oe_order_headers_all ooh,
                                   oe_order_lines_all ool
                            where  ooh.header_id             = ool.header_id
                            and    ool.line_id               = mmt.trx_source_line_id),
                       13, decode(mmt.transaction_action_id,                                        -- Inventory
                                   1, ml5.meaning,                                                     -- Issue from stores
                                   2, ml5.meaning,                                                     -- Subinventory transfer
                                   3, ml5.meaning,                                                     -- Direct organization transfer
                                   5, ml5.meaning,                                                     -- Planning transfer
                                   6, ml5.meaning,                                                     -- Ownership xfer / consignment
                                   9, (select ooh.order_number                                         -- Logical Intercompany Sales
                                       from   oe_order_headers_all ooh,
                                              oe_order_lines_all ool,
                                              mtl_material_transactions mmt_parent
                                       where  ooh.header_id             = ool.header_id
                                       and    ool.line_id               = mmt_parent.trx_source_line_id
                                       and    mmt.parent_transaction_id = mmt_parent.transaction_id),
                                   10, (select ooh.order_number                                         -- Logical Intercompany Receipt
                                       from   oe_order_headers_all ooh,
                                              oe_order_lines_all ool,
                                              mtl_material_transactions mmt_parent
                                       where  ooh.header_id             = ool.header_id
                                       and    ool.line_id               = mmt_parent.trx_source_line_id
                                       and    mmt.parent_transaction_id = mmt_parent.transaction_id),
                                  12, ml5.meaning,                                                     -- Intransit Receipt
                                  13, (select ooh.order_number                                         -- Logical Intercompany Sales Return
                                       from   oe_order_headers_all ooh,
                                              oe_order_lines_all ool
                                       where  ooh.header_id             = ool.header_id
                                       and    ool.line_id               = mmt.trx_source_line_id),
                                  14, (select ooh.order_number                                         -- Logical Intercompany Sales Return
                                       from   oe_order_headers_all ooh,
                                              oe_order_lines_all ool,
                                              mtl_material_transactions mmt_parent
                                       where  ooh.header_id             = ool.header_id
                                       and    ool.line_id               = mmt_parent.trx_source_line_id
                                       and    mmt.parent_transaction_id = mmt_parent.transaction_id),
                                  15, ml5.meaning,                                                     -- Logical Intransit Receipt
                                  21, ml5.meaning,                                                     -- Intransit Shipment
                                  22, ml5.meaning,                                                     -- Logical Intransit Shipment
                                  24, ml5.meaning,                                                     -- Average Cost Update
                                  27, ml5.meaning,                                                     -- Receipt into Stores
                                  ml5.meaning),
                       101, (select ooh.order_number                                                    -- Internal RMA
                             from   oe_order_headers_all ooh,
                                    oe_order_lines_all ool
                             where  ooh.header_id             = ool.header_id
                             and    ool.line_id               = mmt.trx_source_line_id),
                       ml5.meaning                                                                      -- Any other source type
                      ) document_order_num,
                nvl((select ottt.name
                     from   oe_order_lines_all ool,
                            oe_order_headers_all ooh,
                            oe_transaction_types_tl ottt 
                     where  ooh.order_type_id          = ottt.transaction_type_id
                     and    ooh.header_id              = ool.header_id
                     and    mmt.trx_source_line_id     = ool.line_id
                     and    ottt.language              = userenv('lang')),'') order_type,
                mta.transaction_date,
                mmt.transaction_reference,
                -- End revision for version 1.3
                -- Revision for version 1.3, logic fix for the transaction quantity
                decode(mmt.transaction_action_id, 
                        24, mmt.quantity_adjusted,
                        mta.primary_quantity/
                                (select count(*)
                                        from    mtl_transaction_accounts mta2
                                        where   mta2.transaction_id       = mta.transaction_id
                                        and     mta2.reference_account    = mta.reference_account
                                        and     mta2.accounting_line_type = mta.accounting_line_type)
                ) primary_quantity,
                -- End revision for version 1.3
                mta.base_transaction_value base_transaction_value
         from   mtl_transaction_accounts mta,
                mtl_material_transactions mmt,
                mtl_transaction_types mtt,
                -- Revision for version 1.3
                mfg_lookups ml5, -- Transaction action
                mtl_parameters mp
         where  mta.transaction_id              = mmt.transaction_id
         and    mtt.transaction_type_id         = mmt.transaction_type_id
         -- Revision for version 1.3
         and    ml5.lookup_type (+)             = 'MTL_TRANSACTION_ACTION'
         and    ml5.lookup_code (+)             = mmt.transaction_action_id
         -- End revision for version 1.3
         and    mp.organization_id              = mta.organization_id
         and    2=2                             -- p_txn_date_from, p_txn_date_to, p_org_code, p_item_number, p_transaction_type                                                                                                
         and    mmt.transaction_source_type_id  = mtt.transaction_source_type_id
         and    mta.transaction_source_type_id  = mtt.transaction_source_type_id
         -- Revision for version 1.3
         -- Limit to COGS entries or to material transactions which replicate COGS entries
         and    mta.accounting_line_type   in (35, 2) -- Cost of Goods Sold, Account
         -- End revision for version 1.3
         -- Revision for version 1.5
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
        ) cogs,
        -- End revision for version 1.2
        gl_code_combinations gcc,
        hr_organization_information hoi,
        hr_all_organization_units haou, -- inv_organization_id
        hr_all_organization_units haou2, -- operating unit
        gl_ledgers gl,
        -- Revision for version 1.3
        xla_distribution_links xdl,
        xla_ae_headers ah,
        xla_ae_lines al
        -- End revision for version 1.3
where   msiv.organization_id             = cogs.organization_id
and     msiv.inventory_item_id           = cogs.inventory_item_id
and     msiv.primary_uom_code            = muomv.uom_code
and     msiv.inventory_item_status_code  = misv.inventory_item_status_code
and     mtst.transaction_source_type_id  = cogs.transaction_source_type_id
-- Revision for version 1.4
-- and     oap.acct_period_id               = cogs.acct_period_id
and     cogs.organization_id (+)         = cic.organization_id
and     cogs.inventory_item_id (+)       = cic.inventory_item_id
and     cic.cost_type_id (+)             = cct.cost_type_id
and     fcl.lookup_type (+)              = 'ITEM_TYPE'
and     fcl.lookup_code (+)              = msiv.item_type
and     ml1.lookup_type                  = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                  = msiv.planning_make_buy_code
and     ml2.lookup_type                  = 'CST_BONROLLUP_VAL'
and     ml2.lookup_code                  = cic.based_on_rollup_flag
and     ml3.lookup_type                  = 'SYS_YES_NO'
and     ml3.lookup_code                  = to_char(cic.inventory_asset_flag)
and     ml4.lookup_type                  = 'CST_ACCOUNTING_LINE_TYPE'
and     ml4.lookup_code                  = cogs.accounting_line_type
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and     hoi.org_information_context      = 'Accounting Information'
and     hoi.organization_id              = cogs.organization_id
and     hoi.organization_id              = haou.organization_id             -- this gets the organization name
-- avoid selecting disabled inventory organizations
and     sysdate                         <  nvl(haou.date_to, sysdate +1)
and     haou2.organization_id            = to_number(hoi.org_information3)  -- this gets the operating unit id
and     gl.ledger_id                     = to_number(hoi.org_information1)  -- get the ledger_id
-- ===================================================================
-- Revision for version 1.3, Subledger accounting joins
-- ===================================================================
and     ah.application_id                = al.application_id
and     ah.application_id                = 707
and     ah.ae_header_id                  = al.ae_header_id
and     al.ledger_id                     = ah.ledger_id
and     al.ae_header_id                  = xdl.ae_header_id
and     al.ae_line_num                   = xdl.ae_line_num
and     al.code_combination_id           = gcc.code_combination_id (+)
and     xdl.application_id               = 707
and     xdl.source_distribution_type     = 'MTL_TRANSACTION_ACCOUNTS'
and     xdl.source_distribution_id_num_1 = cogs.inv_sub_ledger_id
-- End revision for version 1.3
-- ===================================================================
-- Revision for version 1.5
and     gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and     haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
-- End revision for version 1.5
and     1=1                              -- p_ledger, p_operating_unit, p_cost_type
group by
        gl.name, -- Ledger
        haou2.name, -- Operating Unit
        cogs.organization_code,
        haou.name, -- Organization Name
        -- Revision for version 1.4
        -- oap.period_name,
        ah.period_name,
        -- End revision for version 1.4
        &segment_columns_grp
        msiv.concatenated_segments, -- Item Number
        msiv.description, -- Item Description
        fcl.meaning, -- Item Type
        misv.inventory_item_status_code_tl, -- Item Status
        ml1.meaning, -- Make_Buy_Code
        ml2.meaning, -- Based_on_Rollup
        ml3.meaning, -- Inventory_Asset
        cogs.transaction_type_name, -- Transaction Type
        ml4.meaning, -- Accounting_Line_Type
        cogs.transaction_type_name, -- Transaction Type
        mtst.transaction_source_type_name, -- Transaction_Source
        -- Revision for version 1.3
        cogs.document_order_num, -- Document_Number
        cogs.order_type, -- Order_Type
        cogs.transaction_id, -- Transaction_Id
        cogs.transaction_date, -- Transaction_Date
        cogs.transaction_reference, -- Transaction_Comments
        -- for inline selects
        msiv.inventory_item_id,
        msiv.organization_id,
        muomv.uom_code
having  abs(round(sum(decode((nvl(cic.item_cost,0) * cogs.primary_quantity), 0, cogs.base_transaction_value, 
                 (nvl(cic.item_cost,0) * cogs.primary_quantity))),2)
                - sum(cogs.base_transaction_value)) >= nvl(:p_min_value_diff,.01)                              -- p_min_value_diff
order by 1,2,3,5,6,7,8,9,10,11,18,20