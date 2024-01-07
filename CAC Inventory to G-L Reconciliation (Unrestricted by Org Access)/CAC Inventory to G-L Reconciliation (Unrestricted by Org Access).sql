/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory to G/L Reconciliation (Unrestricted by Org Access)
-- Description: Report to compare the General Ledger inventory balances with the perpetual inventory values (based on the stored month-end inventory balances, generated when the inventory accounting period is closed).

/* +=============================================================================+
-- |  Copyright 2010-20 Douglas Volz Consulting, Inc.                            |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  XXX_INV_RECON_REPT.sql
-- |
-- |  Parameters:
-- |  P_PERIOD_NAME      -- Enter the Period Name you wish to reconcile balances for
-- |                        (mandatory)
-- |  P_LEDGER           -- general ledger you wish to report, for all ledgers enter
-- |                        a NULL or % symbol (optional parameter)
-- |
-- |  Description:
-- |  Report to reconcile G/L and the Inventory and WIP Perpetual
-- |  by Ledger and full account, for a desired accounting period.
-- |
-- |  ============================================================================
-- |  Does not consider cost groups and assumes the elemental cost accounts by
-- |  subinventory are the same as the material account.
-- |  This script also uses a custom lookup code called XXX_CST_GLINV_RECON_ACCOUNTS
-- |  as a means to determine the valid inventory account numbers
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
-- +=============================================================================+*/

XXX_INV_RECON_REPT_V5-20-Jul-2016.sql
-- Excel Examle Output: https://www.enginatics.com/example/cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access/
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
nvl(mp.cost_group_accounting,-99)<>1
union
--organization
select
mp.acct
from
(
select mp.material_account acct, mp.primary_cost_method, mp.cost_group_accounting from mtl_parameters mp union
select mp.material_overhead_account, mp.primary_cost_method, mp.cost_group_accounting from mtl_parameters mp union
select mp.resource_account, mp.primary_cost_method, mp.cost_group_accounting from mtl_parameters mp union
select mp.overhead_account, mp.primary_cost_method, mp.cost_group_accounting from mtl_parameters mp union
select mp.outside_processing_account, mp.primary_cost_method, mp.cost_group_accounting from mtl_parameters mp
) mp
where
mp.primary_cost_method<>1 and --non frozen
nvl(mp.cost_group_accounting,-99)<>1
union
--intransit accounting
select mip.intransit_inv_account from mtl_interorg_parameters mip
union
--receiving accounting
select rp.receiving_account_id from rcv_parameters rp
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
wac.organization_id in (select mp.organization_id from mtl_parameters mp where nvl(mp.cost_group_accounting,-99)<>1)
union
--cost group accounting
select
ccga.acct
from
(
select ccga.material_account acct, ccga.cost_group_id from cst_cost_group_accounts ccga union
select ccga.material_overhead_account, ccga.cost_group_id from cst_cost_group_accounts ccga union
select ccga.resource_account, ccga.cost_group_id from cst_cost_group_accounts ccga union
select ccga.overhead_account, ccga.cost_group_id from cst_cost_group_accounts ccga union
select ccga.outside_processing_account, ccga.cost_group_id from cst_cost_group_accounts ccga
) ccga
where
ccga.cost_group_id in (
select
msi.default_cost_group_id --from subinventory
from
mtl_secondary_inventories msi
where
msi.asset_inventory=1 and
msi.organization_id in (select mp.organization_id from mtl_parameters mp where mp.cost_group_accounting=1)
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
wac.organization_id in (select mp.organization_id from mtl_parameters mp where mp.cost_group_accounting=1)
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
sum(nvl(net_recon_bal.gl_inventory_amount,0)) GL_Inventory,
sum(nvl(net_recon_bal.gl_payables_amount,0)) GL_Payables,
sum(nvl(net_recon_bal.gl_wip_amount,0)) GL_Work_in_Process,
sum(nvl(net_recon_bal.gl_other_amount,0)) GL_Other,
sum(nvl(net_recon_bal.gl_end_balance,0)) GL_Ending_Balance,
sum(nvl(net_recon_bal.inv_onhand_value,0)) Inventory_Value,
sum(nvl(net_recon_bal.wip_value,0)) WIP_Value,
sum(nvl(net_recon_bal.inv_onhand_value,0) + nvl(net_recon_bal.wip_value,0)) Total_Perpetual_Value,
sum(nvl(net_recon_bal.gl_end_balance,0)) - sum(nvl(net_recon_bal.inv_onhand_value,0) + nvl(net_recon_bal.wip_value,0)) Difference
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
    sum(nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0)) gl_beg_balance,
    sum(nvl(gl_per_sum.inventory_amount,0)) gl_inventory_amount,
    sum(nvl(gl_per_sum.payables_amount,0)) gl_payables_amount,
    sum(nvl(gl_per_sum.wip_amount,0)) gl_wip_amount,
    sum(nvl(gl_per_sum.other_amount,0)) gl_other_amount,
    sum(nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0)) +
      sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0)) gl_end_balance,
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
nvl(sum(case when gjh.je_source='Cost Management' and gjh.je_category='Inventory' then gjl.amount end),0) inventory_amount,
nvl(sum(case when gjh.je_source='Payables' then gjl.amount end),0) payables_amount,
nvl(sum(case when gjh.je_source='Cost Management' and gjh.je_category='Receiving' then gjl.amount end),0) receiving_amount,
nvl(sum(case when gjh.je_source='Cost Management' and gjh.je_category='WIP' then gjl.amount end),0) wip_amount,
nvl(sum(case when gjh.je_source not in ('Cost Management','Payables') then gjl.amount end),0) other_amount,
nvl(sum(gjl.amount),0) monthly_activity
     from
     gl_je_headers gjh,
(select nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) amount, gjl.* from gl_je_lines gjl) gjl,
     gl_code_combinations gcc
     where 1=1  -- gjh.period_name=:period_name
     and    gjh.je_header_id        = gjl.je_header_id
     and    gjh.status              = 'P'
     and    gjh.actual_flag         = 'A'
     and    gcc.summary_flag = 'N'
     and    gjl.code_combination_id = gcc.code_combination_id
     and    gcc.&account_segment in (select y.account from y)
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
        gcc.segment9) gl_per_sum
 where 2=2 -- gb.period_name=:period_name
 and    gb.code_combination_id = gcc.code_combination_id
 and    gb.code_combination_id = gl_per_sum.code_combination_id (+)
 and    gb.ledger_id           = gl_per_sum.ledger_id (+)
 and    gb.ledger_id           = gl.ledger_id
 and    gb.actual_flag         = 'A'
 and    gb.period_type         = gl.accounted_period_type -- replaces parameter
 and    gb.currency_code       = gl.currency_code
 -- avoid reporting the consolidated ledger
 and    gl.bal_seg_value_option_code <> 'A'
 and    gcc.&account_segment in (select y.account from y)
 and    gl.ledger_category_code <> 'SECONDARY'
 and    gcc.summary_flag = 'N'
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
    gcc.segment9
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
    null gl_beg_balance,
    null gl_inventory_amount,
    null gl_payables_amount,
    null gl_wip_amount,
    null gl_other_amount,
    null gl_end_balance,
    sum(nvl(inv_value.rollback_value,0)) inv_onhand_value,
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
    and     mp.organization_id            = cpcs.organization_id
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
    and	sysdate < nvl(haou.date_to, sysdate + 1)
    and    hoi.org_information_context   = 'Accounting Information'
    and    hoi.organization_id           = mp.organization_id
    and    hoi.organization_id           = haou.organization_id   -- this gets the organization name
    and    haou2.organization_id         = to_number(hoi.org_information3) -- this gets the operating unit id
    and    gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
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
    and     mp.organization_id            = cpcs.organization_id
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
    inv_value.segment9
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
    null gl_beg_balance,
    null gl_inventory_amount,
    null gl_payables_amount,
    null gl_wip_amount,
    null gl_other_amount,
    null gl_end_balance,
    null inv_onhand_value,
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
         org_acct_periods oap
         -- ===========================================
         -- wip job entity and accounting period joins
         -- ===========================================
         where 3=3 -- oap.period_name=:period_name
         and    wpb.wip_entity_id         = wdj.wip_entity_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id 
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
              org_acct_periods oap
         -- ===========================================
         -- wip job entity and accounting period joins
         -- ===========================================
         where 3=3 -- oap.period_name=:period_name
         and    wpb.wip_entity_id         = wdj.wip_entity_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id 
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
            org_acct_periods oap
         -- ===========================================
         -- wip job entity and accounting period joins
         -- ===========================================
         where 3=3 -- oap.period_name=:period_name
         and    wpb.wip_entity_id         = wdj.wip_entity_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id 
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
            org_acct_periods oap
         -- ===========================================
         -- wip job entity and accounting period joins
         -- ===========================================
         where 3=3 -- oap.period_name=:period_name
         and    wpb.wip_entity_id         = wdj.wip_entity_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id 
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
            org_acct_periods oap
         -- ===========================================
         -- wip job entity and accounting period joins
         -- ===========================================
         where 3=3 -- oap.period_name=:period_name
         and    wpb.wip_entity_id         = wdj.wip_entity_id
         and    wpb.acct_period_id       <= oap.acct_period_id
         and    wpb.organization_id       = oap.organization_id 
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
     and	sysdate < nvl(haou.date_to, sysdate + 1)
     and    hoi.org_information_context = 'Accounting Information'
     and    hoi.organization_id         = wip_value.organization_id
     and    hoi.organization_id         = haou.organization_id            -- get the organization name
     and    haou2.organization_id       = to_number(hoi.org_information3) -- get the operating unit id
     and    gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
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
        gcc.segment9
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
    gross_wip_value.segment9
) net_recon_bal
where 4=4 -- net_recon_bal.ledger=:ledger
group by
net_recon_bal.period_name,
net_recon_bal.ledger,
&group_by_segments
1
&having_clause
order by 1,2,3,4,5,6,7,8,9