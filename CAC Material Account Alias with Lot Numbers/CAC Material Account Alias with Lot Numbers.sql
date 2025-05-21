/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Material Account Alias with Lot Numbers
-- Description: Report to display the material account alias transactions by lot number.  Specify Yes for Show Lot Number to split out the transaction quantities and amounts by transaction lot number.  And if processed by Create Accounting, the Create Accounting column shows "Yes".

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show Lot Number:  enter Yes to see transactions by lot number, enter No to exclude lot information (mandatory).
Account Alias:  enter the account alias to report (optional).
Category Set 1, 2, 3:  any item category you wish (optional).
Item Number:  enter the item numbers you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2009-2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- |  1.1     11 Nov 2009 Douglas Volz   Added Org Code and transaction ID
-- |  1.2     12 Nov 2009 Douglas Volz   Added item and description
-- |  1.3     06 Jan 2010 Douglas Volz   Made dates a parameter
-- |  1.4     12 Jan 2010 Douglas Volz   Added quantity and unit cost columns
-- |  1.5     12 Jan 2010 Douglas Volz   Added account alias information
-- |  1.6     20 Jun 2010 Douglas Volz   Added created by information and fixed sort
-- |  1.7     27 Jun 2010 Douglas Volz   Fixed column label for user name, added Ledger parameter
-- |  1.8     16 Jul 2010 Douglas Volz   Added primary unit of measure (UOM), reason
-- |                                     code and transaction reference (comments) and added lot number
-- |  1.9     06 Feb 2012 Douglas Volz   Rewrite SQL report to solve cross-joining problem
-- |                                     with having multiple lot numbers per material transaction and multiple material overheads
-- |  1.10    22 Jun 2015 Douglas Volz   Added back comments to this code, removed client-specific SLA rules
-- |  1.11    17 May 2017 Douglas Volz   Added category sets
-- |  1.12    25 Mar 2025 Douglas Volz   Cleaned up code for Blitz Report and added Create Accounting Y/N column.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-material-account-alias-with-lot-numbers/
-- Library Link: https://www.enginatics.com/reports/cac-material-account-alias-with-lot-numbers/
-- Run Report: https://demo.enginatics.com/

with inv_organizations as
-- Get the list of organizations, ledgers and operating units for Discrete and OPM organizations
        (select nvl(gl.short_name, gl.name) ledger,
                gl.ledger_id,
                to_number(hoi.org_information2) legal_entity_id,
                haou2.name operating_unit,
                haou2.organization_id operating_unit_id,
                mp.organization_code,
                mp.organization_id,
                nvl(mp.process_enabled_flag, 'N') process_enabled_flag,
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
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where  oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) 
         and    1=1                             -- p_org_code, p_operating_unit, p_ledger
         -- Revision for Operating Unit and Ledger Controls and Parameters
         and    (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
         and    (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
         group by
                nvl(gl.short_name, gl.name),
                gl.ledger_id,
                to_number(hoi.org_information2),
                haou2.name, -- operating_unit
                haou2.organization_id, -- operating_unit_id
                mp.organization_code,
                mp.organization_id,
                nvl(mp.process_enabled_flag, 'N'), -- process_enabled_flag
                haou.date_to,
                gl.currency_code
        ) -- inv_organizations

-----------------main query starts here--------------

select  mmt_lot_txn.ledger Ledger, 
        mmt_lot_txn.operating_unit Operating_Unit,
        mmt_lot_txn.organization_code Org_Code,
        oap.period_name Period_Name,
        gcc.concatenated_segments Accounts,
        &segment_columns
        fl.meaning Create_Accounting,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
        fcl.meaning Item_Type,
        misv.inventory_item_status_code Item_Status,
        ml1.meaning Make_Buy_Code,
&category_columns
        ml2.meaning Accounting_Line_Type,
        mtt.transaction_type_name Transaction_Type,
        mmt_lot_txn.account_alias Account_Alias,
        fu.user_name User_Name,
        mtr.reason_name Reason_Code,
        mmt_lot_txn.transaction_reference Transaction_Comments,
        mta_lot_amt.transaction_id Transaction_Id,
        mta_lot_amt.transaction_date Transaction_Date,
        &p_show_lot_num_col
        -- mmt_lot_txn.lot_number Lot_Number,
        decode(mta_lot_amt.accounting_line_type,
                 7, 'WIP',
                14, '',
                 1, decode(mmt_lot_txn.transaction_action_id,
                                2, decode(sign(mta_lot_amt.primary_quantity),
                                        -1, mmt_lot_txn.subinventory_code,
                                         1, mmt_lot_txn.transfer_subinventory,
                                        mmt_lot_txn.subinventory_code),
                                3, decode(mmt_lot_txn.organization_id, 
                                        mta_lot_amt.organization_id, mmt_lot_txn.subinventory_code,
                                        mmt_lot_txn.transfer_subinventory),
                               21, decode(sign(mta_lot_amt.primary_quantity),
                                        -1, mmt_lot_txn.subinventory_code,
                                         1, mmt_lot_txn.transfer_subinventory,
                                        mmt_lot_txn.subinventory_code),
                               22, decode(sign(mta_lot_amt.primary_quantity),
                                        -1, mmt_lot_txn.subinventory_code,
                                         1, mmt_lot_txn.transfer_subinventory,
                                        mmt_lot_txn.subinventory_code),
                               28, decode(sign(mta_lot_amt.primary_quantity),
                                        -1, mmt_lot_txn.subinventory_code,
                                         1, mmt_lot_txn.transfer_subinventory,
                                        mmt_lot_txn.subinventory_code),
                               mmt_lot_txn.subinventory_code)) Subinventory,
        muomv.uom_code UOM_Code,
        decode(sign(decode(mta_lot_amt.base_transaction_value,
                                 0, mta_lot_amt.primary_quantity,
                                    mta_lot_amt.base_transaction_value)),
                                -1, -1 * abs(mmt_lot_txn.primary_quantity),
                                +1, +1 * abs(mmt_lot_txn.primary_quantity)) Quantity,
        mmt_lot_txn.currency_code Currency_Code,
        cce.cost_element Cost_Element,
        round(mta_lot_amt.unit_cost, 5) Item_Cost,
        round(decode(sign(decode(mta_lot_amt.base_transaction_value,
                                 0, mta_lot_amt.primary_quantity,
                                    mta_lot_amt.base_transaction_value)),
                                -1, -1 * abs(mmt_lot_txn.primary_quantity),
                                +1, +1 * abs(mmt_lot_txn.primary_quantity))
                * mta_lot_amt.unit_cost, 2) Amount
from    mtl_transaction_reasons mtr,
        mtl_transaction_types mtt,
        mtl_system_items_vl msiv,
        mtl_item_status_vl misv,
        mtl_units_of_measure_vl muomv,
        org_acct_periods oap,
        cst_cost_elements cce,
        gl_code_combinations_kfv gcc,
        fnd_user fu,
        mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
        mfg_lookups ml2, -- accounting line type
        fnd_common_lookups fcl,
        fnd_lookups fl,
        -- This section for reporting lot numbers
        (select inv_orgs.ledger,
                inv_orgs.operating_unit,
                inv_orgs.organization_code,
                mmt.inventory_item_id,
                mmt.organization_id,
                mmt.acct_period_id,
                mmt.transaction_type_id,
                mmt.transaction_action_id,
                mmt.subinventory_code,
                mmt.transfer_subinventory,
                mmt.reason_id,
                mmt.transaction_reference,
                mmt.created_by,
                mgd.segment1 account_alias,
                mmt.transaction_id,
                mtln.lot_number,
                mmt.locator_id,
                mmt.actual_cost unit_cost,
                decode(mtln.primary_quantity, 
                        null, mmt.primary_quantity,
                        mtln.primary_quantity) primary_quantity,
                inv_orgs.currency_code
         from   mtl_material_transactions mmt,
                mtl_transaction_lot_numbers mtln,
                mtl_generic_dispositions mgd,
                inv_organizations inv_orgs
         where  mmt.transaction_source_id       = mgd.disposition_id
         and    mmt.organization_id             = inv_orgs.organization_id
         and    mmt.transaction_source_type_id  = 6 -- Account Alias
         and    mmt.transaction_id              = mtln.transaction_id (+)
         and    nvl('&p_show_lot_number', 'N')    = 'Y'
         and    2=2                             -- p_trx_date_from, p_trx_date_to, p_acct_alias, p_item_number
         -- This section for not reporting lot numbers
         union all
         select inv_orgs.ledger,
                inv_orgs.operating_unit,
                inv_orgs.organization_code,
                mmt.inventory_item_id,
                mmt.organization_id,
                mmt.acct_period_id,
                mmt.transaction_type_id,
                mmt.transaction_action_id,
                mmt.subinventory_code,
                mmt.transfer_subinventory,
                mmt.reason_id,
                mmt.transaction_reference,
                mmt.created_by,
                mgd.segment1 account_alias,
                mmt.transaction_id,
                null lot_number,
                mmt.locator_id,
                mmt.actual_cost unit_cost,
                mmt.primary_quantity,
                inv_orgs.currency_code
         from   mtl_material_transactions mmt,
                mtl_generic_dispositions mgd,
                inv_organizations inv_orgs
         where  mmt.transaction_source_id       = mgd.disposition_id
         and    mmt.organization_id             = inv_orgs.organization_id
         and    mmt.transaction_source_type_id  = 6 -- Account Alias
         and    nvl('&p_show_lot_number', 'N')    = 'N'
         and    2=2                             -- p_trx_date_from, p_trx_date_to, p_acct_alias, p_item_number           -- p_acct_alias
        ) mmt_lot_txn,
        (select mta.transaction_id,
                mta.organization_id,
                mta.inventory_item_id,
                mta.transaction_date,
                nvl(al.code_combination_id, mta.reference_account) code_combination_id,
                decode(al.code_combination_id, null, 'Y', 'N') create_acctg,
                mta.transaction_source_type_id,
                mta.accounting_line_type,
                mta.cost_element_id,
                mta.primary_quantity primary_quantity,
                round(sum(mta.base_transaction_value)/decode(mta.primary_quantity, 0, 1, mta.primary_quantity), 8) unit_cost,
                sum(mta.base_transaction_value) base_transaction_value
         from   mtl_transaction_accounts mta,
                xla_distribution_links xdl,
                xla_ae_headers ah,
                xla_ae_lines al,
                inv_organizations inv_orgs
         where  mta.transaction_source_type_id  = 6 -- Account Alias
         and    3=3                             -- p_trx_date_from, p_trx_date_to
         and    mta.organization_id             = inv_orgs.organization_id
         -- ========================================================
         -- SLA table joins to get the exact account numbers
         -- Outer joins in case Create Accounting has not been run.
         -- ========================================================
         and    ah.application_id (+)           = al.application_id
         and    ah.application_id (+)           = 707
         and    ah.ae_header_id (+)             = al.ae_header_id
         and    ah.ledger_id  (+)               = al.ledger_id
         and    al.ae_header_id (+)             = xdl.ae_header_id
         and    al.ae_line_num (+)              = xdl.ae_line_num
         and    xdl.application_id (+)          = 707
         and    xdl.source_distribution_type (+) = 'MTL_TRANSACTION_ACCOUNTS'
         and    xdl.source_distribution_id_num_1 (+) = mta.inv_sub_ledger_id
         group by
                mta.transaction_id,
                mta.organization_id,
                mta.transaction_date,
                mta.inventory_item_id,
                nvl(al.code_combination_id, mta.reference_account), -- code_combination_id
                decode(al.code_combination_id, null, 'Y', 'N'), -- create_acctg,
                mta.inventory_item_id,
                mta.transaction_source_type_id,
                mta.accounting_line_type,
                mta.cost_element_id,
                mta.primary_quantity) mta_lot_amt
   -- ========================================================
   -- Material txn, org, item, period and accounting code joins
   -- ========================================================
where   mmt_lot_txn.transaction_id      = mta_lot_amt.transaction_id
and     mtt.transaction_type_id         = mmt_lot_txn.transaction_type_id
and     msiv.inventory_item_id          = mmt_lot_txn.inventory_item_id
and     msiv.organization_id            = mmt_lot_txn.organization_id
and     msiv.primary_uom_code           = muomv.uom_code
and     msiv.inventory_item_status_code = misv.inventory_item_status_code
and     mmt_lot_txn.reason_id           = mtr.reason_id(+)
and     cce.cost_element_id (+)         = mta_lot_amt.cost_element_id
and     fu.user_id                      = mmt_lot_txn.created_by
and     oap.acct_period_id              = mmt_lot_txn.acct_period_id
and     gcc.code_combination_id (+)     = mta_lot_amt.code_combination_id
-- ========================================================
-- Lookup Types
-- ========================================================
and     ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                 = msiv.planning_make_buy_code
and     ml2.lookup_type                 = 'CST_ACCOUNTING_LINE_TYPE'
and     ml2.lookup_code                 = mta_lot_amt.accounting_line_type
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv.item_type
and     fl.lookup_type (+)              = 'YES_NO'
and     fl.lookup_code (+)              = mta_lot_amt.create_acctg
group by
        mmt_lot_txn.ledger, 
        mmt_lot_txn.operating_unit,
        mmt_lot_txn.organization_code,
        oap.period_name,
        gcc.concatenated_segments, -- Accounts
        &segment_columns_grp
        fl.meaning, -- Create Accounting
        msiv.concatenated_segments, -- Item Number
        msiv.description, -- Item Description
        muomv.uom_code,
        fcl.meaning, -- Item Type
        misv.inventory_item_status_code,
        ml1.meaning, -- Make Buy Code
        -- For inline category query
        msiv.inventory_item_id,
        msiv.organization_id,
        ml2.meaning, -- Accounting Line Type
        mtt.transaction_type_name,
        mmt_lot_txn.account_alias,
        fu.user_name,
        mtr.reason_name,
        mmt_lot_txn.transaction_reference,
        mta_lot_amt.transaction_id,
        mta_lot_amt.transaction_date,
        mmt_lot_txn.lot_number,
        mmt_lot_txn.locator_id,
        mmt_lot_txn.organization_id,
        decode(mta_lot_amt.accounting_line_type,
                 7, 'WIP',
                14, '',
                 1, decode(mmt_lot_txn.transaction_action_id,
                                2, decode(sign(mta_lot_amt.primary_quantity),
                                        -1, mmt_lot_txn.subinventory_code,
                                         1, mmt_lot_txn.transfer_subinventory,
                                        mmt_lot_txn.subinventory_code),
                                3, decode(mmt_lot_txn.organization_id, 
                                        mta_lot_amt.organization_id, mmt_lot_txn.subinventory_code,
                                        mmt_lot_txn.transfer_subinventory),
                               21, decode(sign(mta_lot_amt.primary_quantity),
                                        -1, mmt_lot_txn.subinventory_code,
                                         1, mmt_lot_txn.transfer_subinventory,
                                        mmt_lot_txn.subinventory_code),
                               22, decode(sign(mta_lot_amt.primary_quantity),
                                        -1, mmt_lot_txn.subinventory_code,
                                         1, mmt_lot_txn.transfer_subinventory,
                                        mmt_lot_txn.subinventory_code),
                               28, decode(sign(mta_lot_amt.primary_quantity),
                                        -1, mmt_lot_txn.subinventory_code,
                                         1, mmt_lot_txn.transfer_subinventory,
                                        mmt_lot_txn.subinventory_code),
                               mmt_lot_txn.subinventory_code)), -- Subinventory
        msiv.primary_uom_code,
        decode(sign(decode(mta_lot_amt.base_transaction_value,
                                 0, mta_lot_amt.primary_quantity,
                                    mta_lot_amt.base_transaction_value)),
                                -1, -1 * abs(mmt_lot_txn.primary_quantity),
                                +1, +1 * abs(mmt_lot_txn.primary_quantity)), -- Quantity
        mmt_lot_txn.currency_code,
        cce.cost_element,
        round(mta_lot_amt.unit_cost, 5), -- Item Cost
        round(decode(sign(decode(mta_lot_amt.base_transaction_value,
                                 0, mta_lot_amt.primary_quantity,
                                    mta_lot_amt.base_transaction_value)),
                                -1, -1 * abs(mmt_lot_txn.primary_quantity),
                                +1, +1 * abs(mmt_lot_txn.primary_quantity))
                * mta_lot_amt.unit_cost, 2) -- Amount
-- Order by Ledger, Operating Unit, Org Code, Accounts, Item Number, Accounting Line Type, 
-- Account Alias, Transaction Id, Transaction Date, Lot Number and Subinventory
order by
        mmt_lot_txn.ledger, 
        mmt_lot_txn.operating_unit,
        mmt_lot_txn.organization_code,
        gcc.concatenated_segments, -- Accounts
        msiv.concatenated_segments, -- Item Number
        ml2.meaning, -- Accounting Line Type
        mmt_lot_txn.account_alias,
        mta_lot_amt.transaction_id, -- Transaction Id
        mta_lot_amt.transaction_date, --Transaction Date
        mmt_lot_txn.lot_number, --Lot Number
       decode(mta_lot_amt.accounting_line_type,
                 7, 'WIP',
                14, '',
                 1, decode(mmt_lot_txn.transaction_action_id,
                                2, decode(sign(mta_lot_amt.primary_quantity),
                                        -1, mmt_lot_txn.subinventory_code,
                                         1, mmt_lot_txn.transfer_subinventory,
                                        mmt_lot_txn.subinventory_code),
                                3, decode(mmt_lot_txn.organization_id, 
                                        mta_lot_amt.organization_id, mmt_lot_txn.subinventory_code,
                                        mmt_lot_txn.transfer_subinventory),
                               21, decode(sign(mta_lot_amt.primary_quantity),
                                        -1, mmt_lot_txn.subinventory_code,
                                         1, mmt_lot_txn.transfer_subinventory,
                                        mmt_lot_txn.subinventory_code),
                               22, decode(sign(mta_lot_amt.primary_quantity),
                                        -1, mmt_lot_txn.subinventory_code,
                                         1, mmt_lot_txn.transfer_subinventory,
                                        mmt_lot_txn.subinventory_code),
                               28, decode(sign(mta_lot_amt.primary_quantity),
                                        -1, mmt_lot_txn.subinventory_code,
                                         1, mmt_lot_txn.transfer_subinventory,
                                        mmt_lot_txn.subinventory_code),
                               mmt_lot_txn.subinventory_code)) -- Subinventory