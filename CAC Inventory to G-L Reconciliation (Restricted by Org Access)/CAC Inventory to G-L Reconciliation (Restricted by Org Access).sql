/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory to G/L Reconciliation (Restricted by Org Access)
-- Description: For Discrete Costing, this report compares the General Ledger inventory balances with the perpetual inventory values (based on the stored month-end inventory and WIP balances, generated when the inventory accounting period is closed, plus a calculated month-end receiving value).  Inventory balances includes Receiving, Onhand Inventory (Stock), Intransit and Work in Process (WIP).  This report automatically discovers your valuation accounts based on your setups, such as the Cost Method (Standard, Average, FIFO or LIFO Costing), and also if using Project Manufacturing (PJM - Cost Group Accounting) or Warehouse Management (WMS - Cost Group Accounting) or even if using Category Accounts.  But note as maintenance work orders are normally charged to expense accounts, maintenance (EAM) work orders are not included in this report.  Also note this report does not break out the perpetual account values by cost element; it assumes the elemental cost accounts by subinventory or cost group are the same as the material account, as the stored month-end perpetual inventory balances are only stored by organization, accounting period and item, but not by cost element.

/* +=============================================================================+
-- |  Copyright 2010-23 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  XXX_INV_RECON_REPT.sql
-- |
-- |  Parameters:
-- |  P_PERIOD_NAME      -- Enter the Period Name you wish to reconcile balances for (mandatory)
-- |  P_LEDGER           -- general ledger you wish to report, for all ledgers left this parameter blank
-- |  ============================================================================
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     24 Sep 2004 Douglas Volz   Initial Coding based on earlier work with
-- |                                     the following scripts and designs:
-- |                                        XXX_GL_RECON.sql,
-- |                                        XXX_PERPETUAL_INV_RECON_SUM.sql,
-- |                                        XXX_PERPETUAL_RCV_RECON_SUM.sql,
-- |                                        XXX_PERPETUAL_WIP_RECON_SUM.sql,
-- |                                        MD050 Inventory Reconciliation
-- |  1.1     28 Jun 2010 Douglas Volz   Updated design and code for Release 12,
-- |                                     changed GL_SETS_OF_BOOKS to GL_LEDGERS
-- |  1.2     14 Nov 2010 Douglas Volz   Modified for Cost SIG Presentation
-- |  1.3     11 Mar 2014 Douglas Volz   Changed the COA segments to be generic and removed
-- |                                     the second product line join to gl_code_combinations
-- |  1.4     07 Apr 2014 Douglas Volz   Added join condition to avoid secondary ledgers and
-- |                                     added an explicit to_char on the accounts
-- |                                     ml.lookup_code to avoid an "invalid number" SQL error.
-- |  1.5     20 Jul 2016 Douglas Volz   Added condition to avoid summary journals
-- |  1.6     18 May 2020 Douglas Volz   Avoid disabled inventory organizations.
-- |  1.7     07 Dec 2020 Douglas Volz/Andy Haack   Only report inventory organization ledgers.  Initial Blitz version.
-- |  1.8     22 Feb 2023 Douglas Volz   Add in Receiving Value, fixes for Category Accounting.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/
-- Run Report: https://demo.enginatics.com/

with y as (
select distinct
gcc.&account_segment account
from
(
--subinventory
select
msi.acct
from
(
select msi.material_account acct, msi.organization_id, msi.asset_inventory from mtl_secondary_inventories msi union
select msi.material_overhead_account, msi.organization_id, msi.asset_inventory from mtl_secondary_inventories msi union
select msi.resource_account, msi.organization_id, msi.asset_inventory from mtl_secondary_inventories msi union
select msi.overhead_account, msi.organization_id, msi.asset_inventory from mtl_secondary_inventories msi union
select msi.outside_processing_account, msi.organization_id, msi.asset_inventory from mtl_secondary_inventories msi
) msi,
mtl_parameters mp
where
msi.asset_inventory=1 and
msi.organization_id=mp.organization_id and
mp.primary_cost_method=1 and --frozen
-- Revision for version 1.8
-- nvl(mp.cost_group_accounting,-99)<>1
2 = case
 when nvl(mp.cost_group_accounting,2) = 1 then 1
 when exists (select 'x'
   from   pjm_org_parameters pop
   where  mp.organization_id = pop.organization_id) then 1 -- Project MFG Enabled
 when nvl(mp.wms_enabled_flag, 'N') = 'Y' then 1 -- WMS uses Cost Group Accounting
 when nvl(mp.cost_group_accounting,2) = 2 then 2
 else 2
    end and
5=5 and
mp.organization_id in (select ood.organization_id from org_organization_definitions ood where nvl(ood.disable_date,sysdate+1)>sysdate and ood.set_of_books_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
-- End for revision 1.8
union
--organization
select
mp.acct
from
(
select mp.material_account acct, mp.primary_cost_method, mp.cost_group_accounting, mp.organization_id, mp.wms_enabled_flag from mtl_parameters mp union
select mp.material_overhead_account, mp.primary_cost_method, mp.cost_group_accounting, mp.organization_id, mp.wms_enabled_flag from mtl_parameters mp union
select mp.resource_account, mp.primary_cost_method, mp.cost_group_accounting, mp.organization_id, mp.wms_enabled_flag from mtl_parameters mp union
select mp.overhead_account, mp.primary_cost_method, mp.cost_group_accounting, mp.organization_id, mp.wms_enabled_flag from mtl_parameters mp union
select mp.outside_processing_account, mp.primary_cost_method, mp.cost_group_accounting, mp.organization_id, mp.wms_enabled_flag from mtl_parameters mp
) mp
where
mp.primary_cost_method<>1 and --non frozen
-- Revision for version 1.8
-- nvl(mp.cost_group_accounting,-99)<>1
2 = case
 when nvl(mp.cost_group_accounting,2) = 1 then 1
 when exists (select 'x'
   from   pjm_org_parameters pop
   where  mp.organization_id = pop.organization_id) then 1 -- Project MFG Enabled
 when nvl(mp.wms_enabled_flag, 'N') = 'Y' then 1 -- WMS uses Cost Group Accounting
 when nvl(mp.cost_group_accounting,2) = 2 then 2
 else 2
    end and
5=5
-- End for revision 1.8
union
--intransit accounting
select mip.intransit_inv_account from mtl_interorg_parameters mip
-- Revision for version 1.8
where 6=6 and
(
mip.from_organization_id in (select ood.organization_id from org_organization_definitions ood where nvl(ood.disable_date,sysdate+1)>sysdate and ood.set_of_books_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))) or
mip.to_organization_id in (select ood.organization_id from org_organization_definitions ood where nvl(ood.disable_date,sysdate+1)>sysdate and ood.set_of_books_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
)
union
--receiving accounting
select rp.receiving_account_id from rcv_parameters rp
-- Revision for version 1.8
where 7=7 and
rp.organization_id in (select ood.organization_id from org_organization_definitions ood where nvl(ood.disable_date,sysdate+1)>sysdate and ood.set_of_books_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
union
--wip accounting when cost group accounting is not in use
select distinct
wac.acct
from
(
select wac.material_account acct, wac.class_type, wac.organization_id from wip_accounting_classes wac union
select wac.material_overhead_account, wac.class_type, wac.organization_id from wip_accounting_classes wac union
select wac.resource_account, wac.class_type, wac.organization_id from wip_accounting_classes wac union
select wac.overhead_account, wac.class_type, wac.organization_id from wip_accounting_classes wac union
select wac.outside_processing_account, wac.class_type, wac.organization_id from wip_accounting_classes wac
) wac
where
wac.class_type not in (4,6,7) and --4-expense non-standard, 6-maintenance, 7-expense non-standard lot based
-- Revision for version 1.8
-- wac.organization_id in (select mp.organization_id from mtl_parameters mp where nvl(mp.cost_group_accounting,-99)<>1)
wac.organization_id in 
(select mp.organization_id from mtl_parameters mp where
 2 = case
 when nvl(mp.cost_group_accounting,2) = 1 then 1
 when exists (select 'x'
   from   pjm_org_parameters pop
   where  mp.organization_id = pop.organization_id) then 1 -- Project MFG Enabled
 when nvl(mp.wms_enabled_flag, 'N') = 'Y' then 1 -- WMS uses Cost Group Accounting
 when nvl(mp.cost_group_accounting,2) = 2 then 2
 else 2
    end and
 5=5
)
-- End revision for version 1.8
union
--cost group accounting
select
ccga.acct
from
(
select ccga.material_account acct, ccga.cost_group_id, ccga.organization_id from cst_cost_group_accounts ccga union
select ccga.material_overhead_account, ccga.cost_group_id, ccga.organization_id from cst_cost_group_accounts ccga union
select ccga.resource_account, ccga.cost_group_id, ccga.organization_id from cst_cost_group_accounts ccga union
select ccga.overhead_account, ccga.cost_group_id, ccga.organization_id from cst_cost_group_accounts ccga union
select ccga.outside_processing_account, ccga.cost_group_id, ccga.organization_id from cst_cost_group_accounts ccga
) ccga
where
ccga.cost_group_id in (
select
msi.default_cost_group_id --from subinventory
from
mtl_secondary_inventories msi
where
msi.asset_inventory=1 and
-- Revision for version 1.8
-- msi.organization_id in (select mp.organization_id from mtl_parameters mp where mp.cost_group_accounting=1)
msi.organization_id in 
(select mp.organization_id from mtl_parameters mp where
 1 = case
 when nvl(mp.cost_group_accounting,2) = 1 then 1
 when exists (select 'x'
   from   pjm_org_parameters pop
   where  mp.organization_id = pop.organization_id) then 1 -- Project MFG Enabled
 when nvl(mp.wms_enabled_flag, 'N') = 'Y' then 1 -- WMS uses Cost Group Accounting
 when nvl(mp.cost_group_accounting,2) = 2 then 2
 else 2
    end and
 5=5
)
)
-- End revision for version 1.8
union
select
ccwac.cost_group_id --wip accounting when cost group accounting is in use
from
cst_cg_wip_acct_classes ccwac,
wip_accounting_classes wac
where
ccwac.organization_id=wac.organization_id and
ccwac.class_code=wac.class_code and
wac.class_type not in (4,6,7) and --4-expense non-standard, 6-maintenance, 7-expense non-standard lot based
-- Revision for version 1.8
-- wac.organization_id in (select mp.organization_id from mtl_parameters mp where mp.cost_group_accounting=1)
wac.organization_id in 
(select mp.organization_id from mtl_parameters mp where
 1 = case
 when nvl(mp.cost_group_accounting,2) = 1 then 1
 when exists (select 'x'
   from   pjm_org_parameters pop
   where  mp.organization_id = pop.organization_id) then 1 -- Project MFG Enabled
 when nvl(mp.wms_enabled_flag, 'N') = 'Y' then 1 -- WMS uses Cost Group Accounting
 when nvl(mp.cost_group_accounting,2) = 2 then 2
 else 2
    end and
 5=5
-- End revision for version 1.8
)
) x,
gl_code_combinations gcc
where
x.acct=gcc.code_combination_id
)
------------------------SQL starts here-----------------------
select
net_recon_bal.period_name,
net_recon_bal.ledger,
&segment_columns
sum(nvl(net_recon_bal.gl_beg_balance,0)) GL_Beginning_Balance,
-- Revision for version 1.8
sum(nvl(net_recon_bal.gl_receiving_amount,0)) GL_Receiving,
sum(nvl(net_recon_bal.gl_inventory_amount,0)) GL_Inventory,
sum(nvl(net_recon_bal.gl_wip_amount,0)) GL_Work_in_Process,
sum(nvl(net_recon_bal.gl_payables_amount,0)) GL_Payables,
sum(nvl(net_recon_bal.gl_other_amount,0)) GL_Other,
sum(nvl(net_recon_bal.gl_end_balance,0)) GL_Ending_Balance,
sum(nvl(net_recon_bal.receiving_value,0)) Receiving_Value,
sum(nvl(net_recon_bal.inv_onhand_value,0)) Inventory_Value,
sum(nvl(net_recon_bal.wip_value,0)) WIP_Value,
-- Revision for version 1.8
sum(nvl(net_recon_bal.receiving_value,0) + nvl(net_recon_bal.inv_onhand_value,0) + nvl(net_recon_bal.wip_value,0)) Total_Perpetual_Value,
sum(nvl(net_recon_bal.gl_end_balance,0)) - sum(nvl(net_recon_bal.receiving_value,0) + nvl(net_recon_bal.inv_onhand_value,0) + nvl(net_recon_bal.wip_value,0)) Difference
-- End revision for version 1.8
from
-- ==============================================
-- 1.0 first select the general ledger balances
-- ==============================================
(
select gb.period_name period_name,
    gl.name ledger,
    gcc.segment1 seg1,
    gcc.segment2 seg2,
    gcc.segment3 seg3,
    gcc.segment4 seg4,
    gcc.segment5 seg5,
    gcc.segment6 seg6,
    gcc.segment7 seg7,
    gcc.segment8 seg8,
    gcc.segment9 seg9,
    gcc.segment10 seg10,
    gcc.segment11 seg11,
    gcc.segment12 seg12,
    gcc.segment13 seg13,
    gcc.segment14 seg14,
    gcc.segment15 seg15,
    sum(nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0)) gl_beg_balance,
    -- Revision for version 1.8
    sum(nvl(gl_per_sum.receiving_amount,0)) gl_receiving_amount,
    sum(nvl(gl_per_sum.inventory_amount,0)) gl_inventory_amount,
    sum(nvl(gl_per_sum.wip_amount,0)) gl_wip_amount,
    sum(nvl(gl_per_sum.payables_amount,0)) gl_payables_amount,
    sum(nvl(gl_per_sum.other_amount,0)) gl_other_amount,
    sum(nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0)) +
      sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0)) gl_end_balance,
    -- Revision for version 1.8
    null receiving_value,
    null inv_onhand_value,
    null wip_value
    from
    gl_ledgers gl,
    gl_code_combinations gcc,
    gl_balances gb,
    (select gjh.period_name period_name,
        gjh.ledger_id,
        gjl.code_combination_id,
        gcc.segment1 seg1,
        gcc.segment2 seg2,
        gcc.segment3 seg3,
        gcc.segment4 seg4,
        gcc.segment5 seg5,
        gcc.segment6 seg6,
        gcc.segment7 seg7,
        gcc.segment8 seg8,
        gcc.segment9 seg9,
        gcc.segment10 seg10,
        gcc.segment11 seg11,
        gcc.segment12 seg12,
        gcc.segment13 seg13,
        gcc.segment14 seg14,
        gcc.segment15 seg15,
        nvl(sum(case when gjh.je_source='Cost Management' and gjh.je_category='Receiving' then gjl.amount end),0) receiving_amount,
        nvl(sum(case when gjh.je_source='Cost Management' and gjh.je_category='Inventory' then gjl.amount end),0) inventory_amount,
        nvl(sum(case when gjh.je_source='Cost Management' and gjh.je_category='WIP' then gjl.amount end),0) wip_amount,
        nvl(sum(case when gjh.je_source='Payables' then gjl.amount end),0) payables_amount,
        nvl(sum(case when gjh.je_source not in ('Cost Management','Payables') then gjl.amount end),0) other_amount,
        nvl(sum(gjl.amount),0) monthly_activity
     from
     gl_je_headers gjh,
     (select nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) amount, gjl.* from gl_je_lines gjl) gjl,
     gl_code_combinations gcc,
     gl_ledgers gl
     where 1=1  -- gjh.period_name=:period_name
     -- Revision for version 1.8
     and    gjh.ledger_id           = gl.ledger_id
     and    gjh.je_header_id        = gjl.je_header_id
     and    gjh.status              = 'P'
     and    gjh.actual_flag         = 'A'
     and    gcc.summary_flag        = 'N'
     and    gjl.code_combination_id = gcc.code_combination_id
     and    gcc.&account_segment in (select y.account from y)
     -- ===========================================
     -- Revision for version 1.1
     -- Only get inventory organization ledgers
     -- ===========================================
     and    gl.ledger_id in 
                (select distinct gl.ledger_id
                 from   hr_organization_information hoi,
                        hr_all_organization_units haou,
                        mtl_parameters mp,
                        gl_ledgers gl
                 where  hoi.org_information_context   = 'Accounting Information'
                 and    hoi.organization_id           = mp.organization_id
                 and    hoi.organization_id           = haou.organization_id   -- this gets the organization name
                 and    gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
                 -- avoid selecting disabled inventory organizations
                 and    sysdate < nvl(haou.date_to, sysdate + 1)
                 -- Revision for version 1.8
                 and    8=8
                 and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
                )
     -- ======================================
     group by
        gjh.period_name,
        gjh.ledger_id,
        gjl.code_combination_id,
        gcc.segment1,
        gcc.segment2,
        gcc.segment3,
        gcc.segment4,
        gcc.segment5,
        gcc.segment6,
        gcc.segment7,
        gcc.segment8,
        gcc.segment9,
        gcc.segment10,
        gcc.segment11,
        gcc.segment12,
        gcc.segment13,
        gcc.segment14,
        gcc.segment15) gl_per_sum
 where 2=2 -- gb.period_name=:period_name
 and    gb.code_combination_id = gcc.code_combination_id
 and    gb.code_combination_id = gl_per_sum.code_combination_id (+)
 and    gb.ledger_id           = gl_per_sum.ledger_id (+)
 and    gb.ledger_id           = gl.ledger_id
 and    gb.actual_flag         = 'A'
 and    gb.period_type         = gl.accounted_period_type -- replaces parameter
 and    gb.currency_code       = gl.currency_code
 and    gcc.summary_flag       = 'N'
 -- avoid reporting the consolidated ledger
 and    gl.bal_seg_value_option_code <> 'A'
 and    gcc.&account_segment in (select y.account from y)
 and    gl.ledger_category_code <> 'SECONDARY'
 -- ===========================================
 -- Revision for version 1.1
 -- Only get inventory organization ledgers
 -- ===========================================
 and    gl.ledger_id in 
                (select distinct gl.ledger_id
                 from   hr_organization_information hoi,
                        hr_all_organization_units haou,
                        mtl_parameters mp,
                        gl_ledgers gl
                 where  hoi.org_information_context   = 'Accounting Information'
                 and    hoi.organization_id           = mp.organization_id
                 and    hoi.organization_id           = haou.organization_id   -- this gets the organization name
                 and    gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
                 -- avoid selecting disabled inventory organizations
                 and    sysdate < nvl(haou.date_to, sysdate + 1)
                 -- Revision for version 1.8
                 and    8=8
                )
 -- ======================================
 group by
    gb.period_name,
    gl.name,
    gcc.segment1,
    gcc.segment2,
    gcc.segment3,
    gcc.segment4,
    gcc.segment5,
    gcc.segment6,
    gcc.segment7,
    gcc.segment8,
    gcc.segment9,
    gcc.segment10,
    gcc.segment11,
    gcc.segment12,
    gcc.segment13,
    gcc.segment14,
    gcc.segment15
 union all
 -- ==============================================
 -- 2.0 select the inventory perpetual balances
 -- ==============================================
 -- =======================================================================
 -- this select combines the two inline table select statements by ledger
 -- for the standard inventory values
 -- =======================================================================
 select inv_value.period_name period_name,
    inv_value.name ledger,
    inv_value.segment1 seg1,
    inv_value.segment2 seg2,
    inv_value.segment3 seg3,
    inv_value.segment4 seg4,
    inv_value.segment5 seg5,
    inv_value.segment6 seg6,
    inv_value.segment7 seg7,
    inv_value.segment8 seg8,
    inv_value.segment9 seg9,
    inv_value.segment10 seg10,
    inv_value.segment11 seg11,
    inv_value.segment12 seg12,
    inv_value.segment13 seg13,
    inv_value.segment14 seg14,
    inv_value.segment15 seg15,
    null gl_beg_balance,
    -- Revision for version 1.8
    null gl_receiving_amount,
    null gl_inventory_amount,
    null gl_wip_amount,
    null gl_payables_amount,
    null gl_other_amount,
    null gl_end_balance,
    sum(nvl(inv_value.rollback_value,0)) inv_onhand_value,
    -- Revision for version 1.8
    null receiving_value,
    null wip_value
 from
    -- =======================================================================
    -- 2.1  the first select gets the period-end quantities from the subinventories
    -- =======================================================================    
    (select    oap.period_name,
        gl.name,
        gcc1.segment1,
        gcc1.segment2,
        gcc1.segment3,
        gcc1.segment4,
        gcc1.segment5,
        gcc1.segment6,
        gcc1.segment7,
        gcc1.segment8,
        gcc1.segment9,
        gcc1.segment10,
        gcc1.segment11,
        gcc1.segment12,
        gcc1.segment13,
        gcc1.segment14,
        gcc1.segment15,
        sum(nvl(cpcs.rollback_value,0)) rollback_value
     from
     cst_period_close_summary cpcs,
     org_acct_periods oap,
     mtl_parameters mp,
     mtl_system_items_b msi,
     mtl_secondary_inventories msub,
     gl_code_combinations gcc1,  -- subinventory accounts
     hr_organization_information hoi,
     hr_all_organization_units haou,
     hr_all_organization_units haou2,
     gl_ledgers gl
    -- ===========================================
    -- inventory accounting period joins
    -- ===========================================
    where 3=3 -- oap.period_name=:period_name
    and     oap.acct_period_id            = cpcs.acct_period_id
    and     oap.organization_id           = mp.organization_id 
    -- ========================================================================
    -- subinventory, mtl parameter, item master and period close snapshot joins
    -- ========================================================================
    and    msub.secondary_inventory_name = cpcs.subinventory_code
    and    msub.organization_id          = cpcs.organization_id
    and    mp.organization_id            = cpcs.organization_id
    and    mp.organization_id            = msi.organization_id
    and    msi.organization_id           = cpcs.organization_id
    and    msi.inventory_item_id         = cpcs.inventory_item_id
    -- ===========================================
    -- accounting code combination joins
    -- ===========================================
    and    msub.material_account         = gcc1.code_combination_id
    -- ===========================================
    -- organization joins to the hr org model
    -- ===========================================
    -- avoid selecting disabled inventory organizations
    and    sysdate < nvl(haou.date_to, sysdate + 1)
    and    hoi.org_information_context   = 'Accounting Information'
    and    hoi.organization_id           = mp.organization_id
    and    hoi.organization_id           = haou.organization_id   -- this gets the organization name
    and    haou2.organization_id         = to_number(hoi.org_information3) -- this gets the operating unit id
    and    gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
    -- Revision for version 1.8
    and    8=8
    -- ===========================================
    -- limit the rows returned-don't get zero rows
    -- ===========================================
    and    nvl(cpcs.rollback_quantity,0) <> 0
    group by
        oap.period_name,
        gl.name,
        gcc1.segment1,
        gcc1.segment2,
        gcc1.segment3,
        gcc1.segment4,
        gcc1.segment5,
        gcc1.segment6,
        gcc1.segment7,
        gcc1.segment8,
        gcc1.segment9,
        gcc1.segment10,
        gcc1.segment11,
        gcc1.segment12,
        gcc1.segment13,
        gcc1.segment14,
        gcc1.segment15,
        msi.inventory_item_id,
        msi.organization_id
    union all
    -- =======================================================================
    -- 2.2 the second select gets the period-end quantities from intransit
    -- =======================================================================
    select    oap.period_name,
        gl.name,
        gcc1.segment1,
        gcc1.segment2,
        gcc1.segment3,
        gcc1.segment4,
        gcc1.segment5,
        gcc1.segment6,
        gcc1.segment7,
        gcc1.segment8,
        gcc1.segment9,
        gcc1.segment10,
        gcc1.segment11,
        gcc1.segment12,
        gcc1.segment13,
        gcc1.segment14,
        gcc1.segment15,
        sum(nvl(cpcs.rollback_value,0)) rollback_value
    from
    cst_period_close_summary cpcs,
    org_acct_periods oap,
    mtl_parameters mp,
    mtl_system_items_b msi,
    gl_code_combinations gcc1,  -- subinventory accounts
    hr_organization_information hoi,
    hr_all_organization_units haou,
    hr_all_organization_units haou2,
    gl_ledgers gl
    -- ===========================================
    -- inventory accounting period joins
    -- ===========================================
    where 3=3 -- oap.period_name=:period_name
    and    oap.acct_period_id            = cpcs.acct_period_id
    and    oap.organization_id           = mp.organization_id 
    -- ========================================================================
    -- subinventory, mtl parameter, item master and period close snapshot joins
    -- ========================================================================
    and    cpcs.subinventory_code        is null -- indicates it is for intransit
    and    mp.organization_id            = cpcs.organization_id
    and    mp.organization_id            = msi.organization_id
    and    msi.organization_id           = cpcs.organization_id
    and    msi.inventory_item_id         = cpcs.inventory_item_id
    -- ===========================================
    -- accounting code combination joins
    -- ===========================================
    and    mp.intransit_inv_account      = gcc1.code_combination_id
    -- ===========================================
    -- organization joins to the hr org model
    -- ===========================================
    and    hoi.org_information_context   = 'Accounting Information'
    and    hoi.organization_id           = mp.organization_id
    and    hoi.organization_id           = haou.organization_id   -- this gets the organization name
    and    haou2.organization_id         = to_number(hoi.org_information3) -- this gets the operating unit id
    and    gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
    -- avoid selecting disabled inventory organizations
    and  sysdate < nvl(haou.date_to, sysdate + 1)
    -- Revision for version 1.8
    and    8=8
    -- ===========================================
    -- limit the rows returned-don't get zero rows
    -- ===========================================
    and    nvl(cpcs.rollback_quantity,0) <> 0
    group by
        oap.period_name,
        gl.name,
        gcc1.segment1,
        gcc1.segment2,
        gcc1.segment3,
        gcc1.segment4,
        gcc1.segment5,
        gcc1.segment6,
        gcc1.segment7,
        gcc1.segment8,
        gcc1.segment9,
        gcc1.segment10,
        gcc1.segment11,
        gcc1.segment12,
        gcc1.segment13,
        gcc1.segment14,
        gcc1.segment15,
        msi.inventory_item_id,
        msi.organization_id
    ) inv_value
 group by
    inv_value.period_name,
    inv_value.name,
    inv_value.segment1,
    inv_value.segment2,
    inv_value.segment3,
    inv_value.segment4,
    inv_value.segment5,
    inv_value.segment6,
    inv_value.segment7,
    inv_value.segment8,
    inv_value.segment9,
    inv_value.segment10,
    inv_value.segment11,
    inv_value.segment12,
    inv_value.segment13,
    inv_value.segment14,
    inv_value.segment15
 union all
 -- ==============================================
 -- 3.0 select the wip perpetual balances at gross
 -- ==============================================
 -- =======================================================================
 -- this select combines the inline table select statements by ledger
 -- for the gross wip values
 -- =======================================================================
 select    gross_wip_value.period_name period_name,
    gross_wip_value.name ledger,
    gross_wip_value.segment1 seg1,
    gross_wip_value.segment2 seg2,
    gross_wip_value.segment3 seg3,
    gross_wip_value.segment4 seg4,
    gross_wip_value.segment5 seg5,
    gross_wip_value.segment6 seg6,
    gross_wip_value.segment7 seg7,
    gross_wip_value.segment8 seg8,
    gross_wip_value.segment9 seg9,
    gross_wip_value.segment10 seg10,
    gross_wip_value.segment11 seg11,
    gross_wip_value.segment12 seg12,
    gross_wip_value.segment13 seg13,
    gross_wip_value.segment14 seg14,
    gross_wip_value.segment15 seg15,
    null gl_beg_balance,
    -- Revision for version 1.8
    null gl_receiving_amount,
    null gl_inventory_amount,
    null gl_wip_amount,
    null gl_payables_amount,
    null gl_other_amount,
    null gl_end_balance,
    null inv_onhand_value,
    -- Revision for version 1.8
    null receiving_value,
    sum(nvl(gross_wip_value.wip_value,0)) wip_value
 from
    -- =======================================================================
    -- 3.1  the first select gets the period-end wip values
    -- at the gross wip value (gross standard value)
    -- =======================================================================
    (select    wip_value.period_name, -- period name
        gl.name,               -- ledger name
        gcc.segment1,
        gcc.segment2,
        gcc.segment3,
        gcc.segment4,
        gcc.segment5,
        gcc.segment6,
        gcc.segment7,
        gcc.segment8,
        gcc.segment9,
        gcc.segment10,
        gcc.segment11,
        gcc.segment12,
        gcc.segment13,
        gcc.segment14,
        gcc.segment15,
        sum(wip_value.wip_value) wip_value
     from
     gl_ledgers gl,
     gl_code_combinations gcc,
     hr_organization_information hoi,
     hr_all_organization_units haou,  -- inv_organization_id
     hr_all_organization_units haou2, -- operating unit
     mtl_system_items_b msi,
        -- ===========================================
        -- inline table select for wip period balances
        -- ===========================================
        -- =====================================================
        -- 3.11 first get the material value for the wip jobs
        -- =====================================================
        (select oap.period_name period_name,
            wpb.acct_period_id acct_period_id,
            wpb.organization_id organization_id,
            wdj.material_account code_combination_id,
            wdj.class_code class_code,
            wdj.primary_item_id inventory_item_id,
            sum(nvl(tl_scrap_in,0)+
             nvl(pl_material_in,0)-
             nvl(tl_material_out,0) -
             nvl(tl_scrap_out,0)-
             nvl(pl_material_out,0)-
             nvl(tl_material_var,0)-
             nvl(tl_scrap_var,0)-
             nvl(pl_material_var,0)) wip_value
         from 
         wip_period_balances wpb,
         wip_discrete_jobs wdj,
         org_acct_periods oap,
         -- Revision for version 1.8
         wip_accounting_classes wac
         -- ===========================================
         -- wip job entity and accounting period joins
         -- ===========================================
         where 3=3 -- oap.period_name=:period_name
         and    wpb.wip_entity_id         = wdj.wip_entity_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id
         -- Revision for version 1.8
         and    wac.class_code            = wdj.class_code 
         and    wac.organization_id       = wdj.organization_id
         and    wac.class_type not in (4,6,7) -- 4-expense non-standard, 6-maintenance, 7-expense non-standard lot based
         -- End revision for version 1.8
         group by
            oap.period_name,
            wpb.acct_period_id,
            wpb.organization_id,
            wdj.material_account,
            wdj.class_code,
            wdj.primary_item_id
         -- =====================================================
         -- 3.12 now get the material overhead value for the wip jobs
         -- =====================================================
         union all
         select oap.period_name period_name,
            wpb.acct_period_id acct_period_id,
            wpb.organization_id organization_id,
            wdj.material_overhead_account code_combination_id,
            wdj.class_code class_code,
            wdj.primary_item_id inventory_item_id,
             sum(nvl(pl_material_overhead_in,0)-
             nvl(tl_material_overhead_out,0)-
             nvl(pl_material_overhead_out,0)-
             nvl(tl_material_overhead_var,0)-
             nvl(pl_material_overhead_var,0)) wip_value
        from  wip_period_balances wpb,
              wip_discrete_jobs wdj,
              org_acct_periods oap,
              -- Revision for version 1.8
              wip_accounting_classes wac
         -- ===========================================
         -- wip job entity and accounting period joins
         -- ===========================================
         where 3=3 -- oap.period_name=:period_name
         and    wpb.wip_entity_id         = wdj.wip_entity_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id
         -- Revision for version 1.8
         and    wac.class_code            = wdj.class_code 
         and    wac.organization_id       = wdj.organization_id
         and    wac.class_type not in (4,6,7) -- 4-expense non-standard, 6-maintenance, 7-expense non-standard lot based
         -- End revision for version 1.8 
         group by
            oap.period_name,
            wpb.acct_period_id,
            wpb.organization_id,
            wdj.material_overhead_account,
            wdj.class_code,
            wdj.primary_item_id
         -- =====================================================
         -- 3.13 now get the resource value for the wip jobs
         -- =====================================================
         union all
         select oap.period_name period_name,
            wpb.acct_period_id acct_period_id,
            wpb.organization_id organization_id,
            wdj.resource_account code_combination_id,
            wdj.class_code class_code,
            wdj.primary_item_id inventory_item_id,
            sum(nvl(tl_resource_in,0)+
             nvl(pl_resource_in,0)-
             nvl(tl_resource_out,0)-
             nvl(pl_resource_out,0)-
             nvl(tl_resource_var,0)-
             nvl(pl_resource_var,0)) wip_value
         from wip_period_balances wpb,
              wip_discrete_jobs wdj,
              org_acct_periods oap,
             -- Revision for version 1.8
             wip_accounting_classes wac
         -- ===========================================
         -- wip job entity and accounting period joins
         -- ===========================================
         where 3=3 -- oap.period_name=:period_name
         and    wpb.wip_entity_id         = wdj.wip_entity_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id
         -- Revision for version 1.8
         and    wac.class_code            = wdj.class_code 
         and    wac.organization_id       = wdj.organization_id
         and    wac.class_type not in (4,6,7) -- 4-expense non-standard, 6-maintenance, 7-expense non-standard lot based
         -- End revision for version 1.8
         group by
            oap.period_name,
            wpb.acct_period_id,
            wpb.organization_id,
            wdj.resource_account,
            wdj.class_code,
            wdj.primary_item_id
         -- =====================================================
         -- 3.14 now get the osp value for the wip jobs
         -- =====================================================
         union all
         select oap.period_name period_name,
            wpb.acct_period_id acct_period_id,
            wpb.organization_id organization_id,
            wdj.outside_processing_account code_combination_id,
            wdj.class_code class_code,
            wdj.primary_item_id inventory_item_id,
            sum(nvl(tl_outside_processing_in,0)+
             nvl(pl_outside_processing_in,0)-
             nvl(tl_outside_processing_out,0)-
             nvl(pl_outside_processing_out,0)-
             nvl(tl_outside_processing_var,0)-
             nvl(pl_outside_processing_var,0)) wip_value
         from wip_period_balances wpb,
              wip_discrete_jobs wdj,
              org_acct_periods oap,
              -- Revision for version 1.8
              wip_accounting_classes wac
         -- ===========================================
         -- wip job entity and accounting period joins
         -- ===========================================
         where 3=3 -- oap.period_name=:period_name
         and    wpb.wip_entity_id         = wdj.wip_entity_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id
         -- Revision for version 1.8
         and    wac.class_code            = wdj.class_code 
         and    wac.organization_id       = wdj.organization_id
         and    wac.class_type not in (4,6,7) -- 4-expense non-standard, 6-maintenance, 7-expense non-standard lot based
         -- End revision for version 1.8
         group by
            oap.period_name,
            wpb.acct_period_id,
            wpb.organization_id,
            wdj.outside_processing_account,
            wdj.class_code,
            wdj.primary_item_id
         -- =====================================================
         -- 3.15 now get the overhead value for the wip jobs
         -- =====================================================
         union all
         select oap.period_name period_name,
            wpb.acct_period_id acct_period_id,
            wpb.organization_id organization_id,
            wdj.overhead_account code_combination_id,
            wdj.class_code class_code,
            wdj.primary_item_id inventory_item_id,
            sum(nvl(tl_overhead_in,0)+
             nvl(pl_overhead_in,0)-
             nvl(tl_overhead_out,0)-
             nvl(pl_overhead_out,0)-
             nvl(tl_overhead_var,0)-
             nvl(pl_overhead_var,0)) wip_value
         from wip_period_balances wpb,
              wip_discrete_jobs wdj,
              org_acct_periods oap,
              -- Revision for version 1.8
              wip_accounting_classes wac
         -- ===========================================
         -- wip job entity and accounting period joins
         -- ===========================================
         where 3=3 -- oap.period_name=:period_name
         and    wpb.wip_entity_id         = wdj.wip_entity_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id
         -- Revision for version 1.8
         and    wac.class_code            = wdj.class_code 
         and    wac.organization_id       = wdj.organization_id
         and    wac.class_type not in (4,6,7) -- 4-expense non-standard, 6-maintenance, 7-expense non-standard lot based
         -- End revision for version 1.8
         group by
            oap.period_name,
            wpb.acct_period_id,
            wpb.organization_id,
            wdj.overhead_account,
            wdj.class_code,
            wdj.primary_item_id
        ) wip_value
     -- ========================================================
     -- g/l ledger, organization and code combination joins
     -- ========================================================
     where    gcc.code_combination_id   = wip_value.code_combination_id
     and    msi.inventory_item_id       = wip_value.inventory_item_id
     and    msi.organization_id         = wip_value.organization_id
     -- avoid selecting disabled inventory organizations
     and sysdate < nvl(haou.date_to, sysdate + 1)
     and    hoi.org_information_context = 'Accounting Information'
     and    hoi.organization_id         = wip_value.organization_id
     and    hoi.organization_id         = haou.organization_id            -- get the organization name
     and    haou2.organization_id       = to_number(hoi.org_information3) -- get the operating unit id
     and    gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
    -- Revision for version 1.8
     and    8=8
     group by
        wip_value.period_name, -- period name
        gl.name,               -- ledger name
        gcc.segment1,
        gcc.segment2,
        gcc.segment3,
        gcc.segment4,
        gcc.segment5,
        gcc.segment6,
        gcc.segment7,
        gcc.segment8,
        gcc.segment9,
        gcc.segment10,
        gcc.segment11,
        gcc.segment12,
        gcc.segment13,
        gcc.segment14,
        gcc.segment15
    ) gross_wip_value
 group by 
    gross_wip_value.period_name,
    gross_wip_value.name,
    gross_wip_value.segment1,
    gross_wip_value.segment2,
    gross_wip_value.segment3,
    gross_wip_value.segment4,
    gross_wip_value.segment5,
    gross_wip_value.segment6,
    gross_wip_value.segment7,
    gross_wip_value.segment8,
    gross_wip_value.segment9,
    gross_wip_value.segment10,
    gross_wip_value.segment11,
    gross_wip_value.segment12,
    gross_wip_value.segment13,
    gross_wip_value.segment14,
    gross_wip_value.segment15
 union all
 -- ===========================================================
 -- 4.0 This select combines the inline table select statements
 --     by Ledger for the receiving perpetual values
 -- ===========================================================
  select rcv_value.period_name period_name,
   rcv_value.Ledger,
  rcv_value.segment1 seg1,
  rcv_value.segment2 seg2,
  rcv_value.segment3 seg3,
  rcv_value.segment4 seg4,
  rcv_value.segment5 seg5,
  rcv_value.segment6 seg6,
  rcv_value.segment7 seg7,
  rcv_value.segment8 seg8,
  rcv_value.segment9 seg9,
  rcv_value.segment10 seg10,
  rcv_value.segment11 seg11,
  rcv_value.segment12 seg12,
  rcv_value.segment13 seg13,
  rcv_value.segment14 seg14,
  rcv_value.segment15 seg15,
  null gl_beg_balance,
  null gl_receiving_amount,
  null gl_inventory_amount,
  null gl_wip_amount,
  null gl_payables_amount,
  null gl_other_amount,
  null gl_end_balance,
  sum(rcv_value.rcv_value) receiving_value,
  null inv_onhand_value,
  null wip_value
  from
 -- =======================================================================
 --  4.1 The first select gets the current receiving quantities and values
 --      based on the CAC Receiving Inventory Value Report, version 1.38
 -- =======================================================================
   -- =================================================
   -- Condense the receiving quantities and values
   -- to period, ledger and account information
   -- =================================================
  (select oap.period_name period_name,
    gl.name Ledger,
   gcc.segment1,
   gcc.segment2,
   gcc.segment3,
   gcc.segment4,
   gcc.segment5,
   gcc.segment6,
   gcc.segment7,
   gcc.segment8,
   gcc.segment9,
   gcc.segment10,
   gcc.segment11,
   gcc.segment12,
   gcc.segment13,
   gcc.segment14,
   gcc.segment15,
   sum(rcv.amount) rcv_value,
   sum(rcv.quantity) rcv_quantity   
  from rcv_parameters rp,
  gl_code_combinations gcc,
  org_acct_periods oap,
  hr_organization_information hoi,
  hr_all_organization_units haou,
  hr_all_organization_units haou2,
  gl_ledgers gl,
  -- =============================================================
  -- Part 4.2
  -- Get the onhand receiving quantities
  -- =============================================================
  -- Revision for version 1.38, rewrite this section to not use
  -- rcv_receiving_value_view, unit prices in Release 12 from
  -- purchase orders or from transfer prices based on advanced pricing.
  -- =============================================================
  (select 'rcv_onhand' section,
    rs.to_organization_id organization_id,
   rs.item_id  inventory_item_id,
   rs.destination_type_code,
   rs.po_header_id,
   rs.po_line_id,
   rs.po_line_location_id,
   -- Revision for version 1.29
   rs.po_release_id,
   -- Revision for version 1.36
   -- Move Txn Date Logic to all_rcv Query
   rs.shipment_header_id,
   rs.shipment_line_id,
   -- End revision for version 1.36
   pod.project_id,
   -- End revision for version 1.29
   rsh.receipt_num,
   pod.wip_entity_id,
   pod.bom_resource_id,
   round(rs.to_org_primary_quantity,3) quantity,
   rs.amount
   from (select ms.to_organization_id,
    ms.item_id,
    ms.destination_type_code,
    ms.po_header_id,
    ms.po_line_id,
    ms.po_line_location_id,
    ms.po_distribution_id,
    ms.po_release_id,
    ms.req_header_id,
    ms.shipment_header_id,
    ms.shipment_line_id,
    ms.rcv_transaction_id,
    ms.to_org_primary_quantity,
    -- Revision for version 1.32
    -- Need a consistent price based on rae qtys as the transaction quantity in rcv_accounting_events may be
    -- different from the ms.to_org_primary_quantity in mtl_supply, due to returns to vendor transactions.
    -- Average Unit Price
    round(sum(decode(rae.currency_conversion_rate,
       null, nvl(rae.unit_price,0),
       nvl(rae.unit_price,0) * rae.currency_conversion_rate
      )
       * (rae.source_doc_quantity/rae.primary_quantity) * rae.primary_quantity
      )
    -- Divided by the Quantity
      / sum(rae.primary_quantity)
       ,8) avg_unit_price,
    -- Average Unit Price X Quantity = Amount
    round(ms.to_org_primary_quantity *
     -- Price X Quantity
     round(sum(decode(rae.currency_conversion_rate,
        null, nvl(rae.unit_price,0),
        nvl(rae.unit_price,0) * rae.currency_conversion_rate
       ) * (rae.source_doc_quantity/rae.primary_quantity) * rae.primary_quantity
           ) / sum(rae.primary_quantity)
        ,8)
        ,2) amount
    from mtl_supply ms,
    -- Revision for version 1.35
    (select x.*
     from (select rt.transaction_id parent_transaction_id,
      rt.organization_id,
      connect_by_root rt.transaction_id child_transaction_id,
      connect_by_isleaf
      from rcv_transactions rt
      connect by prior rt.parent_transaction_id=rt.transaction_id
      start with rt.transaction_id in
      (select ms.rcv_transaction_id
       from mtl_supply ms
       where ms.supply_type_code       ='RECEIVING'
       -- Revision for version 1.36, client has expense receipts with items
       -- and ms.destination_type_code <>'EXPENSE'
       -- End revision for version 1.36
      )
      -- Transfer of ownership consigned entries do not hit receiving accounts
      and nvl(rt.consigned_flag,'N')        = 'N'
     ) x
     where x.connect_by_isleaf=1
    ) rt,
    -- End revision for version 1.35
    rcv_accounting_events rae
    where ms.rcv_transaction_id         = rt.child_transaction_id
    and rt.parent_transaction_id      = rae.rcv_transaction_id
    -- Revision for version 1.35
    -- and rae.transaction_date         >= ms.receipt_date
    and rae.organization_id           = rt.organization_id
    -- Revision for version 1.36
    and ms.to_organization_id         = rt.organization_id
    group by
    ms.to_organization_id,
    ms.item_id,
    ms.destination_type_code,
    ms.po_header_id,
    ms.po_line_id,
    ms.po_line_location_id,
    ms.po_distribution_id,
    ms.po_release_id,
    ms.req_header_id,
    ms.shipment_header_id,
    ms.shipment_line_id,
    ms.rcv_transaction_id,
    ms.to_org_primary_quantity
   ) rs,
   -- End revision for version 1.35
   rcv_shipment_headers rsh,
   rcv_shipment_lines rsl,
   po_headers_all ph,
   po_line_locations_all pll,
   po_distributions_all pod,
   po_requisition_headers_all prh
   -- Revision for version 1.29
   -- po_lines_all pl,
   -- po_requisition_lines_all prl,
   -- rcv_transactions rt
  where rsh.shipment_header_id        = rs.shipment_header_id
  and rsl.shipment_line_id          = rs.shipment_line_id
  -- Revision for version 1.36
  and rsl.shipment_header_id        = rs.shipment_header_id
  and ph.po_header_id (+)           = rs.po_header_id
  -- Revision for version 1.29
  -- and pl.po_line_id (+)             = rs.po_line_id
  and pll.line_location_id (+)      = rs.po_line_location_id
  and pod.po_distribution_id (+)    = rs.po_distribution_id
  and prh.requisition_header_id (+) = rs.req_header_id
  -- Internal requisitions are not part of receiving inventory value
  and rsl.source_document_code <> 'REQ'
  union all
   -- =============================================================
  -- Part 4.3
  -- Sum up all the post close rcv'g transactions by item and org
  -- The SIGN of the quantities and amounts have been reversed
  -- =============================================================
   select post_close_rcv_txns.section               section,
   post_close_rcv_txns.organization_id       organization_id,
   post_close_rcv_txns.inventory_item_id     inventory_item_id,
   post_close_rcv_txns.destination_type_code destination_type_code,
   post_close_rcv_txns.po_header_id          po_header_id,
   post_close_rcv_txns.po_line_id            po_line_id,
   post_close_rcv_txns.po_line_location_id   po_line_location_id,
   -- Revision for version 1.29
   post_close_rcv_txns.po_release_id         po_release_id,
   -- Revision for version 1.36
   -- Move Txn Date Logic to all_rcv Query
   post_close_rcv_txns.shipment_header_id,
   post_close_rcv_txns.shipment_line_id,
   -- End revision for version 1.36
   post_close_rcv_txns.project_id            project_id,
   -- End revision for version 1.29
   post_close_rcv_txns.receipt_num           receipt_num,
   post_close_rcv_txns.wip_entity_id         wip_entity_id,
   post_close_rcv_txns.bom_resource_id       bom_resource_id,
   -- Revision for version 1.36
   -- post_close_rcv_txns.transaction_date      transaction_date,
   sum(nvl(post_close_rcv_txns.quantity,0))  quantity,
   sum(nvl(post_close_rcv_txns.amount,0))    amount
   from (
       -- ==========================================================
       -- Part 4.3.1
       -- Get the post close transactions for all receiving activity
       -- ==========================================================
    -- ==========================================================
    -- Section 1.1 Get the PO receipts into receiving inspection
    -- ==========================================================
    select 'Section 1.1' section,
    -- Revision for version 1.28, added to avoid missing
    -- transactions having same organization_id, item_id, etc.
    rae.rcv_transaction_id,
    rae.organization_id,
    rae.inventory_item_id inventory_item_id,
    pod.destination_type_code destination_type_code,
    rae.po_header_id po_header_id,
    rae.po_line_id po_line_id,
    rae.po_line_location_id po_line_location_id,
    -- Revision for version 1.29
    rsl.po_release_id po_release_id,
    -- Revision for version 1.36
    -- Move Txn Date Logic to all_rcv Query
    rsh.shipment_header_id,
    rsl.shipment_line_id,
    -- End revision for version 1.36
    pod.project_id project_id,
    -- End revision for version 1.29
    rsh.receipt_num receipt_num,
    pod.wip_entity_id wip_entity_id,
    pod.bom_resource_id bom_resource_id,
    -- Amount = Quantity X Price
    -- Rewrite quantity logic for version 1.38, decode on received accounted amounts does not work if it is zero
    round(decode(rt.transaction_type,
      'RECEIVE', -1 * rt.primary_quantity,
      'RETURN TO VENDOR', 1 * rt.primary_quantity,
      'MATCH', -1 * rt.primary_quantity,
      'CORRECT',
       decode(parent_rt.transaction_type,
        'UNORDERED', 0,
        'RECEIVE', -1 * rt.primary_quantity,
        'RETURN TO VENDOR', 1 * rt.primary_quantity,
        0
             ),
      0
         )
       ,3) quantity,
    -- =====================================================================
    -- Revision for version 1.28
    -- 1)  Round amounts to 2 decimals
    -- 2)  No longer use rrsl, inconsistent amounts with mmt when try to
    --     subtract away non-recoverable tax and recoverable tax amounts
    -- 3)  Invert the SIGN as we will subtract away these amounts
    -- 4)  Convert the price into the primary UOM -- (rae.source_doc_quantity/rae.primary_quantity)
    -- 5)  Use rcv_accounting_events to get the quantity received by PO Distribution
    -- 6)  Don't sum up the quantities or amounts as there are multiple po
    --     distributions per PO Header, Line and Line Location, which creates
    --     split PO receipts by a percentage of the PO Distributions.
    -- =====================================================================
    -- Comment out the below code
    -- -1 * round(sum((nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0)
    -- - nvl(rrsl.accounted_rec_tax,0) - nvl(rrsl.accounted_nr_tax0))),2) amount
    -- =====================================================================
    round(
     -- Quantity
     round(decode(sign(nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0)),
         1,  -1 * abs(rae.primary_quantity),
        -1, +1 * abs(rae.primary_quantity),
        rae.primary_quantity
           )
        ,3) *
            -- Price
     decode(rt.currency_conversion_rate,
      null, nvl(rt.po_unit_price,0),
      nvl(rt.po_unit_price,0) * rt.currency_conversion_rate
           ) *
     -- Convert into the primary UOM
     (rt.source_doc_quantity/rt.primary_quantity)
       ,2) amount
    -- End fix for version 1.28
    from -- =====================================================================
    -- Revision for version 1.28
    -- Client has multiple WIP Entity Ids and multiple PO distributions per
    -- Receipt Number for the same PO Header, Line, Line Location and item number.
    -- Need to use rcv_accounting_events to get the split quantities
    -- =====================================================================
    rcv_transactions rt,
    -- Revision for version 1.38
    rcv_transactions parent_rt,
    rcv_shipment_headers rsh,
    rcv_shipment_lines rsl,
    rcv_accounting_events rae,
    rcv_receiving_sub_ledger rrsl,
    po_distributions_all pod,
    org_acct_periods oap
    where rt.transaction_id            = rae.rcv_transaction_id
    -- Revision for version 1.38
    and rt.parent_transaction_id     = parent_rt.transaction_id (+)
    and rt.organization_id           = parent_rt.organization_id (+)
    and rt.transaction_id            = rrsl.rcv_transaction_id
    -- Oracle difference =>  the RRSL table is using the meaning as the value for the CST_ACCOUNTING_LINE_TYPE
    --                       lookup code, as opposed to the lookup code values 1 - 99
    -- Revision for version 1.34, receiving transactions also use 'Clearing'
    -- and rrsl.accounting_line_type    = 'Receiving Inspection'
    and rrsl.accounting_line_type in ('Clearing', 'Receiving Inspection')
    -- End revision for version 1.34
    -- Revision for version 1.32
    -- Fix for version 1.16
    -- and trunc(rae.transaction_date) > oap.schedule_close_date
    and rt.transaction_date         >= oap.schedule_close_date + 1
    -- Revision for version 1.36
    and rrsl.transaction_date       >= oap.schedule_close_date + 1
    and pod.po_distribution_id       = rrsl.reference3
    -- and rae.organization_id          = rt.organization_id
    -- and oap.organization_id          = rae.organization_id
    -- and rae.transaction_date        >= oap.schedule_close_date + 1
    -- and pod.po_distribution_id       = rae.po_distribution_id
    -- End revision for version 1.36
    and rt.transaction_id            = rrsl.rcv_transaction_id
    and oap.organization_id          = rt.organization_id
    and rae.accounting_event_id      = rrsl.accounting_event_id
    -- End revision for version 1.32
    -- Revision for version 1.32
    and 3=3                          -- oap.period_name=:period_name
    -- Revision for version 1.36
    -- and pod.destination_type_code   <> 'EXPENSE'
    and rt.shipment_header_id        = rsh.shipment_header_id
    and rt.shipment_line_id          = rsl.shipment_line_id
    -- Fix for version 1.19
    and rt.transaction_type         <> 'DELIVER'  -- only want receipts, return to vendor and corrections
    -- End revision for version 1.32
    group by
    'Section 1.1', -- section
    -- Revision for version 1.28
    rae.rcv_transaction_id,
    rae.organization_id,
    rae.inventory_item_id,
    pod.destination_type_code,
    rae.po_header_id,
    rae.po_line_id,
    rae.po_line_location_id,
    -- Revision for version 1.29
    rsl.po_release_id,
    -- Revision for version 1.36
    -- Move Txn Date Logic to all_rcv Query
    rsh.shipment_header_id,
    rsl.shipment_line_id,
    -- End revision for version 1.36
    pod.project_id,
    -- End revision for version 1.29
    rsh.receipt_num,
    pod.wip_entity_id,
    pod.bom_resource_id,
    -- Revision for version 1.38, decode on accounted amounts does not work if it is zero
    round(decode(rt.transaction_type,
      'RECEIVE', -1 * rt.primary_quantity,
      'RETURN TO VENDOR', 1 * rt.primary_quantity,
      'MATCH', -1 * rt.primary_quantity,
      'CORRECT',
       decode(parent_rt.transaction_type,
        'UNORDERED', 0,
        'RECEIVE', -1 * rt.primary_quantity,
        'RETURN TO VENDOR', 1 * rt.primary_quantity,
        0
             ),
      0
         )
       ,3), --quantity
    -- Amount = Quantity X Price
    round(
     -- Quantity
     round(decode(sign(nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0)),
         1,  -1 * abs(rae.primary_quantity),
        -1, +1 * abs(rae.primary_quantity),
        rae.primary_quantity
           )
        ,3) *
    -- Price
     decode(rt.currency_conversion_rate,
      null, nvl(rt.po_unit_price,0),
      nvl(rt.po_unit_price,0) * rt.currency_conversion_rate
           ) *
     -- Convert into the primary UOM
     (rt.source_doc_quantity/rt.primary_quantity)
       ,2) -- Amount = Quantity X Price
    -- End revision for version 1.26
    -- ==========================================================
    -- Section 1.2 Get the PO deliveries from receiving inspt into
    -- inventory for both costed and uncosted material transactions
    -- Uncosted entries are not in mtl_transaction_accounts
    -- ==========================================================
    union all
     select 'Section 1.2' section,
    -- Revision for version 1.28, added because Section 1.1
    -- needed the rae.rcv_transaction_id for uniqueness
    rt.transaction_id,
    mmt.organization_id organization_id,
    rsl.item_id inventory_item_id,
    pod.destination_type_code destination_type_code,
    rt.po_header_id po_header_id,
    rt.po_line_id po_line_id,
    rt.po_line_location_id po_line_location_id,
    -- Revision for version 1.29
    rsl.po_release_id po_release_id,
    -- Revision for version 1.36
    -- Move Txn Date Logic to all_rcv Query
    rsh.shipment_header_id,
    rsl.shipment_line_id,
    -- End revision for version 1.36
    pod.project_id project_id,
    -- End revision for version 1.29
    rsh.receipt_num receipt_num,
    pod.wip_entity_id wip_entity_id,
    pod.bom_resource_id bom_resource_id,
    -- Fix for version 1.17, get the SIGN of the quantity correct
    -- no need to invert the SIGN, is it positive going into inventory
    --sum(-1*(nvl(mmt.primary_quantity,0))) quantity,
    -- Revision for version 1.28, round qtys to 3 decimals
    round(sum((nvl(mmt.primary_quantity,0))),3) quantity,
    -- Fix for version 1.18
    round(sum((nvl(mmt.primary_quantity,0) *
        -- Fix for version 1.28, the PO Unit Price on RT may be in a different UOM
        -- Convert into the primary UOM
        (rt.source_doc_quantity/rt.primary_quantity) *
        -- End revision for version 1.28
        decode(rt.currency_conversion_rate, null, nvl(rt.po_unit_price,0),
          nvl(rt.po_unit_price,0) * rt.currency_conversion_rate))),2) amount
    from mtl_material_transactions mmt,
    rcv_transactions rt,
    rcv_parameters rp,
    -- Revision for version 1.29
    -- po_lines_all pol,
    po_line_locations_all pll,
    po_distributions_all pod,
    rcv_shipment_headers rsh,
    rcv_shipment_lines rsl,
    org_acct_periods oap
    where mmt.rcv_transaction_id       = rt.transaction_id
    and mmt.transaction_source_type_id = 1 -- purchasing receipts
    -- Revision for version 1.29
    -- and rt.po_line_id                = pol.po_line_id
    and rt.po_line_location_id       = pll.line_location_id
    and pll.line_location_id         = pod.line_location_id
    and rt.shipment_line_id          = rsl.shipment_line_id
    -- Revision for version 1.36
    and rt.shipment_header_id        = rsh.shipment_header_id
    and rsl.shipment_header_id       = rsh.shipment_header_id
    -- Revision for version 1.34, to prevent cross-joining with pod
    and pod.po_distribution_id       = nvl(rsl.po_distribution_id, pod.po_distribution_id)
    and oap.organization_id          = mmt.organization_id
    and 3=3                          -- oap.period_name=:period_name
    -- Revision for version 1.32
    -- Fix for version 1.16
    -- The oap.schedule_close_date does not have a timestamp so we have to trunc to make the comparison
    --and mmt.transaction_date        >= oap.schedule_close_date
    -- and trunc(mmt.transaction_date) > oap.schedule_close_date
    and mmt.transaction_date        >= oap.schedule_close_date + 1
    -- End revision for version 1.32
    -- Revision for version 1.36
    and rt.transaction_date         >= oap.schedule_close_date + 1
    and rp.receiving_account_id      = mmt.distribution_account_id
    and rp.organization_id           = mmt.organization_id
    -- Revision for version 1.36
    -- and pod.destination_type_code <> 'EXPENSE'
    group by
    'Section 1.2', -- section
    -- Revision for version 1.28
    rt.transaction_id,
    mmt.organization_id,
    rsl.item_id,
    pod.destination_type_code,
    rt.po_header_id,
    rt.po_line_id,
    rt.po_line_location_id,
    -- Revision for version 1.29
    rsl.po_release_id,
    -- Revision for version 1.36
    -- Move Txn Date Logic to all_rcv Query
    rsh.shipment_header_id,
    rsl.shipment_line_id,
    -- End revision for version 1.36
    pod.project_id,
    -- End revision for version 1.29
    rsh.receipt_num,
    pod.wip_entity_id,
    pod.bom_resource_id,
    -- Revision for version 1.26
    -- for receipt date inline select
    rsh.organization_id
    -- End revision for version 1.26
    -- ==========================================================
    -- Section 1.3 Get the PO deliveries from receiving inspection into WIP
    -- ==========================================================
    union all
     select 'Section 1.3' section,
    -- Revision for version 1.28, added because Section 1.1
    -- needed the rae.rcv_transaction_id for uniqueness
    rt.transaction_id,
    wta.organization_id organization_id,
    rsl.item_id inventory_item_id,
    pod.destination_type_code destination_type_code,
    rt.po_header_id po_header_id,
    rt.po_line_id po_line_id,
    rt.po_line_location_id po_line_location_id,
    -- Revision for version 1.29
    rsl.po_release_id po_release_id,
    -- Revision for version 1.36
    -- Move Txn Date Logic to all_rcv Query
    rsh.shipment_header_id,
    rsl.shipment_line_id,
    -- End revision for version 1.36
    pod.project_id project_id,
    -- End revision for version 1.29
    rsh.receipt_num receipt_num,
    pod.wip_entity_id wip_entity_id,
    pod.bom_resource_id bom_resource_id,
    -- Revision for version 1.38, decode on accounted amounts does not work if it is zero
    round(decode(rt.transaction_type,
     'DELIVER', 1 * rt.primary_quantity,
     'RETURN TO RECEIVING', -1 * rt.primary_quantity,
     'CORRECT',
      decode(parent_rt.transaction_type,
       'UNORDERED', 0,
       'DELIVER', 1 * rt.primary_quantity,
       'RETURN TO RECEIVING', -1 * rt.primary_quantity,
       'MATCH', -1 * rt.primary_quantity,
       0),
     0)
       ,3) quantity,
    -- invert the SIGN as we will subtract away these amounts
    --Fix for version 1.18
    round(sum(-1*wta.base_transaction_value),2) amount
    from wip_transaction_accounts wta,
    wip_transactions wt,
    rcv_transactions rt,
    -- Revision for version 1.38
    rcv_transactions parent_rt,
    rcv_parameters rp,
    -- Revision for version 1.29
    -- po_lines_all pol,
    po_line_locations_all pll,
    rcv_shipment_headers rsh,
    rcv_shipment_lines rsl,
    po_distributions_all pod,
    org_acct_periods oap
    where wt.transaction_id            = wta.transaction_id
    -- Oracle bug => the accounting line type used is 4 (res absorption) and should be 5 (receiving)
    and wta.accounting_line_type in (4,5)
    and wt.rcv_transaction_id        = rt.transaction_id
    -- Revision for version 1.38
    and rt.parent_transaction_id     = parent_rt.transaction_id (+)
    and rt.organization_id           = parent_rt.organization_id (+)
    -- Revision for version 1.36
    and wt.organization_id           = rt.organization_id
    -- Revision for version 1.29
    -- and rt.po_line_id                = pol.po_line_id
    and rt.po_line_location_id       = pll.line_location_id
    and pll.line_location_id         = pod.line_location_id
    and rt.shipment_line_id          = rsl.shipment_line_id
    -- Revision for version 1.36
    and rt.shipment_header_id        = rsh.shipment_header_id
    and rsl.shipment_header_id       = rsh.shipment_header_id
    -- Revision for version 1.34, to prevent cross-joining with pod
    and pod.po_distribution_id       = nvl(rsl.po_distribution_id, pod.po_distribution_id)
    and oap.organization_id          = wta.organization_id
    and 3=3                          -- oap.period_name=:period_name
    -- Revision for version 1.32
    -- Fix for version 1.16
    -- The oap.schedule_close_date does not have a timestamp so we have to trunc to make the comparison
    --and wta.transaction_date        >= oap.schedule_close_date
    -- and trunc(wta.transaction_date) > oap.schedule_close_date
    and wta.transaction_date        >= oap.schedule_close_date + 1
    -- End revision for version 1.32
    -- Revision for version 1.36
    and wt.transaction_date         >= oap.schedule_close_date + 1
    and rt.transaction_date         >= oap.schedule_close_date + 1
    -- End revision for version 1.36
    and rp.receiving_account_id      = wta.reference_account
    and rp.organization_id           = wta.organization_id
    and pod.destination_type_code <> 'EXPENSE'
   -- Fix for version 1.2, to avoid doubling up results
    and pod.wip_entity_id            = wta.wip_entity_id
    group by
    'Section 1.3', -- section
    -- Revision for version 1.28
    rt.transaction_id,
    wta.organization_id,
    rsl.item_id,
    pod.destination_type_code,
    rt.po_header_id,
    rt.po_line_id,
    rt.po_line_location_id,
    -- Revision for version 1.29
    rsl.po_release_id,
    -- Revision for version 1.36
    -- Move Txn Date Logic to all_rcv Query
    rsh.shipment_header_id,
    rsl.shipment_line_id,
    -- End revision for version 1.36
    pod.project_id,
    -- End revision for version 1.29
    rsh.receipt_num,
    pod.wip_entity_id,
    pod.bom_resource_id,
    -- Revision for version 1.38, decode on accounted amounts does not work if it is zero
    round(decode(rt.transaction_type,
     'DELIVER', 1 * rt.primary_quantity,
     'RETURN TO RECEIVING', -1 * rt.primary_quantity,
     'CORRECT',
      decode(parent_rt.transaction_type,
       'UNORDERED', 0,
       'DELIVER', 1 * rt.primary_quantity,
       'RETURN TO RECEIVING', -1 * rt.primary_quantity,
       'MATCH', -1 * rt.primary_quantity,
       0),
     0)
       ,3), -- quantity
    -- Revision for version 1.26
    -- for receipt date inline select
    rsh.organization_id
    -- End revision for version 1.26
    -- ==========================================================
    -- Section 1.4 Get the unprocessed PO deliveries (wip_cost_txn_interface)
    -- from WIP receiving inspection into WIP, as the receiving
    -- quantities in MTL_SUPPLY have already been updated, but the
    -- WIP transactions and WIP accounting entries do not exist.
    -- ==========================================================
    union all
     select 'Section 1.4' section,
    -- Revision for version 1.28, added because Section 1.1
    -- needed the rae.rcv_transaction_id for uniqueness
    rt.transaction_id,
    wcti.organization_id organization_id,
    rsl.item_id inventory_item_id,
    pod.destination_type_code destination_type_code,
    rt.po_header_id po_header_id,
    rt.po_line_id po_line_id,
    rt.po_line_location_id po_line_location_id,
    -- Revision for version 1.29
    rsl.po_release_id po_release_id,
    -- Revision for version 1.36
    -- Move Txn Date Logic to all_rcv Query
    rsh.shipment_header_id,
    rsl.shipment_line_id,
    -- End revision for version 1.36
    pod.project_id project_id,
    -- End revision for version 1.29
    rsh.receipt_num receipt_num,
    pod.wip_entity_id wip_entity_id,
    pod.bom_resource_id bom_resource_id,
    -- Revision for version 1.28, round qtys to 3 decimals
    -- no need to invert the SIGN of the quantity, already a positive QTY
    round(sum((nvl(wcti.primary_quantity,0))),3) quantity,
    -- no need to invert the SIGN of the quantity, already a positive QTY
    -- Fix for version 1.18
    round(sum(nvl(wcti.primary_quantity,0) *
       -- Fix for version 1.28
       -- Make sure the price is in the primary UOM
       (rt.source_doc_quantity/rt.primary_quantity) *
       decode(rt.currency_conversion_rate, null, nvl(rt.po_unit_price,0),
          nvl(rt.po_unit_price,0) * rt.currency_conversion_rate)),2) amount
    from wip_cost_txn_interface wcti,
    rcv_transactions rt,
    rcv_parameters rp,
    -- Revision for version 1.29
    -- po_lines_all pol,
    po_line_locations_all pll,
    rcv_shipment_headers rsh,
    rcv_shipment_lines rsl,
    po_distributions_all pod,
    org_acct_periods oap
    where wcti.rcv_transaction_id      = rt.transaction_id
    and wcti.transaction_type        = 3 -- outside processing
    -- Revision for version 1.29
    -- and rt.po_line_id                = pol.po_line_id
    and rt.po_line_location_id       = pll.line_location_id
    and pll.line_location_id         = pod.line_location_id
    and rt.shipment_line_id          = rsl.shipment_line_id
    and rsl.shipment_header_id       = rsh.shipment_header_id
    and rt.shipment_line_id          = rsl.shipment_line_id
    -- Revision for version 1.36
    and rt.shipment_header_id        = rsh.shipment_header_id
    -- Revision for version 1.34, to prevent cross-joining with pod
    and pod.po_distribution_id       = nvl(rsl.po_distribution_id, pod.po_distribution_id)
    and oap.organization_id          = wcti.organization_id
    and 3=3                          -- oap.period_name=:period_name
    -- Revision for version 1.32
    -- Fix for version 1.16
    -- The oap.schedule_close_date does not have a timestamp so we have to trunc to make the comparison
    -- and wcti.transaction_date       >= oap.schedule_close_date
    -- and trunc(wcti.transaction_date) > oap.schedule_close_date
    and wcti.transaction_date       >= oap.schedule_close_date + 1
    -- Revision for version 1.36
    and rt.transaction_date         >= oap.schedule_close_date + 1
    and wcti.organization_id         = rt.organization_id
    -- End revision for version 1.32
    and rp.receiving_account_id      = wcti.receiving_account_id
    and rp.organization_id           = wcti.organization_id
    -- revision for version 1.28
    -- To avoid cross-joining with multiple PO distributions, multiple WIP jobs per receipt
    and pod.wip_entity_id            = wcti.wip_entity_id
    and pod.destination_type_code <> 'EXPENSE'
    group by
    'Section 1.4', -- section
    -- Revision for version 1.28
    rt.transaction_id,
    wcti.organization_id,
    rsl.item_id,
    pod.destination_type_code,
    rt.po_header_id,
    rt.po_line_id,
    rt.po_line_location_id,
    -- Revision for version 1.29
    rsl.po_release_id,
    -- Revision for version 1.36
    -- Move Txn Date Logic to all_rcv Query
    rsh.shipment_header_id,
    rsl.shipment_line_id,
    -- End revision for version 1.36
    pod.project_id,
    -- End revision for version 1.29
    rsh.receipt_num,
    pod.wip_entity_id,
    pod.bom_resource_id,
    -- Revision for version 1.26
    -- for receipt date inline select
    rsh.organization_id
    -- End revision for version 1.26
    -- ==========================================================
    -- Section 1.5 Get the retroactive price adjustments on the DELIVER
    -- transaction type from rrsl.  Retroactive price adjust-
    -- ments have entries in rrsl on DELIVER rt.transaction_type.
    -- Normally there are no accounting entries in rrsl for
    -- DELIVER rt.transaction types.
    -- This logic applies to material and WIP DELIVER txns.
    -- Fix for version 1.19
    -- ==========================================================
    union all
     select 'Section 1.5' section,
    -- Revision for version 1.28, added because Section 1.1
    -- needed the rae.rcv_transaction_id for uniqueness
    rt.transaction_id,
    rt.organization_id organization_id,
    rsl.item_id inventory_item_id,
    pod.destination_type_code destination_type_code,
    rt.po_header_id po_header_id,
    rt.po_line_id po_line_id,
    rt.po_line_location_id po_line_location_id,
    -- Revision for version 1.29
    rsl.po_release_id po_release_id,
    -- Revision for version 1.36
    -- Move Txn Date Logic to all_rcv Query
    rsh.shipment_header_id,
    rsl.shipment_line_id,
    -- End revision for version 1.36
    pod.project_id project_id,
    -- End revision for version 1.29
    rsh.receipt_num receipt_num,
    pod.wip_entity_id wip_entity_id,
    pod.bom_resource_id bom_resource_id,
    -- the quantities have already been included in sections
    -- 1.1 to 1.4, no "real" qty for retroactive price adjustments
    -- as this works like a valuation adjustment
    sum(0) quantity,
    -- invert the SIGN as we will subtract away these amounts
    round(sum(-1*(nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0))),2) amount
    from rcv_transactions rt,
    rcv_receiving_sub_ledger rrsl,
    rcv_parameters rp,
    -- Revision for version 1.29
    -- po_lines_all pol,
    po_line_locations_all pll,
    po_distributions_all pod,
    rcv_shipment_headers rsh,
    rcv_shipment_lines rsl,
    org_acct_periods oap
    -- Revision for version 1.29
    -- where rt.po_line_id               = pol.po_line_id
    where rt.po_line_location_id       = pll.line_location_id
    and pll.line_location_id         = pod.line_location_id
    and rt.shipment_line_id          = rsl.shipment_line_id
    -- Revision for version 1.36
    and rt.shipment_header_id        = rsh.shipment_header_id
    -- Revision for version 1.34, to prevent cross-joining with pod
    -- and pod.po_distribution_id       = nvl(rsl.po_distribution_id, pod.po_distribution_id)
    and pod.po_distribution_id       = rrsl.reference3
    -- End revision for version 1.36
    and rsl.shipment_header_id       = rsh.shipment_header_id
    and oap.organization_id          = rt.organization_id
    and 3=3                          -- oap.period_name=:period_name
    -- Revision for version 1.32
    -- Fix for version 1.16
    -- The oap.schedule_close_date does not have a timestamp
    -- Use rt.transaction_date as this correctly references the quantity movement, even
    -- though the rrsl.accounting_date is when the retroactive adjustment happened
    -- and trunc(rt.transaction_date)  > oap.schedule_close_date
    and rt.transaction_date         >= oap.schedule_close_date + 1
    and rp.organization_id           = rt.organization_id
    -- Revision for version 1.36
    and rrsl.transaction_date       >= oap.schedule_close_date + 1
    -- ==============================================
    -- These joins will get the retroactive price
    -- adjustments for both inventory and WIP, that
    -- hit the receiving inspection account
    -- ==============================================
    and rp.receiving_account_id      = rrsl.code_combination_id
    and rt.transaction_type          = 'DELIVER'
    and pod.destination_type_code   <> 'EXPENSE'
    and rt.transaction_id            = rrsl.rcv_transaction_id
    -- Oracle difference =>  the RRSL table is using the meaning as the value for the CST_ACCOUNTING_LINE_TYPE
    --                       lookup code, as opposed to the lookup code values 1 - 99
    -- Revision for version 1.34, receiving transactions also use 'Clearing'
    -- and rrsl.accounting_line_type    = 'Receiving Inspection'
    and rrsl.accounting_line_type in ('Clearing', 'Receiving Inspection')
    -- End revision for version 1.34
    group by
    'Section 1.5', -- section
    -- Revision for version 1.28
    rt.transaction_id,
    rt.organization_id,
    rsl.item_id,
    pod.destination_type_code,
    rt.po_header_id,
    rt.po_line_id,
    rt.po_line_location_id,
    -- Revision for version 1.29
    rsl.po_release_id,
    -- Revision for version 1.36
    -- Move Txn Date Logic to all_rcv Query
    rsh.shipment_header_id,
    rsl.shipment_line_id,
    -- End revision for version 1.36
    pod.project_id,
    -- End revision for version 1.29
    rsh.receipt_num,
    pod.wip_entity_id,
    pod.bom_resource_id,
    -- Revision for version 1.26
    -- for receipt date inline select
    rsh.organization_id
    -- End revision for version 1.26
   ) post_close_rcv_txns
   group by
   post_close_rcv_txns.section,
   post_close_rcv_txns.organization_id,
   post_close_rcv_txns.inventory_item_id,
   post_close_rcv_txns.destination_type_code,
   post_close_rcv_txns.po_header_id,
   post_close_rcv_txns.po_line_id,
   post_close_rcv_txns.po_line_location_id,
   -- Revision for version 1.29
   post_close_rcv_txns.po_release_id,
   -- Revision for version 1.36
   -- Move Txn Date Logic to all_rcv Query
   post_close_rcv_txns.shipment_header_id,
   post_close_rcv_txns.shipment_line_id,
   -- End revision for version 1.36
   post_close_rcv_txns.project_id,
   -- End revision for version 1.29
   post_close_rcv_txns.receipt_num,
   post_close_rcv_txns.wip_entity_id,
   post_close_rcv_txns.bom_resource_id
   -- Revision for version 1.36
   -- post_close_rcv_txns.transaction_date
  ) rcv
    where rcv.organization_id        = rp.organization_id
   and rp.receiving_account_id    = gcc.code_combination_id
   and rcv.organization_id        = oap.organization_id
   and 3=3                        -- oap.period_name=:period_name
   -- ===========================================
   -- Organization joins to the HR org model
   -- ===========================================
   and hoi.org_information_context   = 'Accounting Information'
   and hoi.organization_id           = rp.organization_id
   and hoi.organization_id           = haou.organization_id   -- this gets the organization name
   and haou2.organization_id         = to_number(hoi.org_information3) -- this gets the operating unit id
   and gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
   -- avoid selecting disabled inventory organizations
   and sysdate < nvl(haou.date_to, sysdate + 1)
   and    8=8
   group by
   oap.period_name,
     gl.name,
    gcc.segment1,
   gcc.segment2,
   gcc.segment3,
   gcc.segment4,
   gcc.segment5,
   gcc.segment6,
   gcc.segment7,
   gcc.segment8,
   gcc.segment9,
   gcc.segment10,
   gcc.segment11,
   gcc.segment12,
   gcc.segment13,
   gcc.segment14,
   gcc.segment15
   -- ============================================================== 
   -- Added qualifier to remove zero quantity balances from the
   -- results.  Such as rolled back PICK material transactions in STAGE,
   -- or very small fractional quantities.  This condition also
   -- screens out orphan retro-active price adjustments, where Part IV.C
   -- has picked up a retro-active price adjustment, but, no quantities
   -- exist in receiving and only a small fractional amount exists due
   -- to rounding on the debits or credits on retroactive price adjustmnts.
   -- ============================================================== 
   having abs(sum(rcv.quantity + rcv.amount)) > .01
  ) rcv_value
   group by
   rcv_value.period_name,
    rcv_value.ledger,
   rcv_value.segment1,
   rcv_value.segment2,
   rcv_value.segment3,
   rcv_value.segment4,
   rcv_value.segment5,
   rcv_value.segment6,
   rcv_value.segment7,
   rcv_value.segment8,
   rcv_value.segment9,
   rcv_value.segment10,
   rcv_value.segment11,
   rcv_value.segment12,
   rcv_value.segment13,
   rcv_value.segment14,
   rcv_value.segment15
) net_recon_bal
where 4=4 and -- net_recon_bal.ledger=:ledger
net_recon_bal.ledger in (select gl.name from gl_ledgers gl where gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
group by
net_recon_bal.period_name,
net_recon_bal.ledger,
&group_by_segments
1
&having_clause
order by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17