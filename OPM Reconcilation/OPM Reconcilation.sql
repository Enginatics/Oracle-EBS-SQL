/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Reconcilation
-- Description: OPM Reconciliation Report.
Blitz Report implementation of the Oracle sql script: OPMRecon.sql 
Reference MOS Document: OPM Inventory Balance Reconciliation (Doc ID 1510357.1)
-- Excel Examle Output: https://www.enginatics.com/example/opm-reconcilation/
-- Library Link: https://www.enginatics.com/reports/opm-reconcilation/
-- Run Report: https://demo.enginatics.com/

with
q_inv_val_cur as
(
  select
   '1. Inv Value for Current Period' record_type,
   oap.period_year period_year,
   oap.period_num period_num,
   (oap.schedule_close_date + (86399/86400)) transdate,
   haou.name organization_name,
   mp.organization_code,
   iim.item_number,
   iim.description,
   iim.primary_uom_code primary_uom,
   nvl(sum(gpb.primary_quantity), 0) primary_quantity,
   iim.secondary_uom_code secondary_uom,
   nvl(sum(gpb.secondary_quantity),0) secondary_quantity,
   decode(iim.dual_uom_control,1,'Primary',2,'Fixed',3,'Default','No Default') dual_uom_control,
   xxen_inv_value.gmfinval_unit_cost(to_number(hoi.org_information2),oap.period_year,oap.period_num,iim.inventory_item_id, mp.organization_id, (oap.schedule_close_date + (86399/86400))) unit_cost,
   (nvl(sum(gpb.primary_quantity),0) * xxen_inv_value.gmfinval_unit_cost(to_number(hoi.org_information2),oap.period_year,oap.period_num,iim.inventory_item_id, mp.organization_id, (oap.schedule_close_date + (86399/86400)))) total_cost,
   --
   to_number(null) sub_ledger_value,
   --
   to_number(null) recon_item_value_current,
   to_number(null) recon_item_value_prior,
   to_number(null) recon_sub_ledger_value,
   to_number(null) recon_item_value_difference,
   --
   to_number(hoi.org_information2) legal_entity_id,
   mp.organization_id,
   iim.inventory_item_id inventory_item_id
  from
   mtl_item_flexfields iim,
   mtl_parameters mp,
   gmf_period_balances gpb,
   org_acct_periods oap,
   hr_all_organization_units haou,
   hr_organization_information hoi,
   mtl_secondary_inventories msi
  where
   iim.inventory_item_id = gpb.inventory_item_id and
   iim.organization_id = gpb.organization_id and
   iim.organization_id = mp.organization_id and
   mp.organization_id = gpb.organization_id and
   hoi.org_information2 = to_char(:p_legal_entity_id) and
   hoi.organization_id = mp.organization_id and
   hoi.org_information_context = 'Accounting Information' and
   haou.organization_id = hoi.organization_id and
   haou.organization_id = mp.organization_id and
   mp.organization_id = oap.organization_id and
   gpb.acct_period_id = oap.acct_period_id and
   oap.period_year = :p_current_period_year and
   oap.period_num = :p_current_period_num and
   gpb.subinventory_code (+)= msi.secondary_inventory_name and
   mp.organization_id = msi.organization_id and
   msi.asset_inventory = 1
  group by
   iim.item_number,
   iim.inventory_item_id,
   mp.organization_code,
   to_number(hoi.org_information2),
   oap.period_year,
   oap.period_num,
   iim.primary_uom_code,
   iim.secondary_uom_code,
   iim.description,
   oap.schedule_close_date,
   haou.name,
   mp.organization_id,
   iim.dual_uom_control
),
q_inv_val_pri as
(
  select
   '2. Inv Value for Prior Period' record_type,
   oap.period_year period_year,
   oap.period_num period_num,
   (oap.schedule_close_date + (86399/86400)) transdate,
   haou.name organization_name,
   mp.organization_code,
   iim.item_number,
   iim.description,
   iim.primary_uom_code primary_uom,
   nvl(sum(gpb.primary_quantity), 0) primary_quantity,
   iim.secondary_uom_code secondary_uom,
   nvl(sum(gpb.secondary_quantity),0) secondary_quantity,
   decode(iim.dual_uom_control,1,'Primary',2,'Fixed',3,'Default','No Default') dual_uom_control,
   xxen_inv_value.gmfinval_unit_cost(to_number(hoi.org_information2),oap.period_year,oap.period_num,iim.inventory_item_id, mp.organization_id, (oap.schedule_close_date + (86399/86400))) unit_cost,
   (nvl(sum(gpb.primary_quantity),0) * xxen_inv_value.gmfinval_unit_cost(to_number(hoi.org_information2),oap.period_year,oap.period_num,iim.inventory_item_id, mp.organization_id, (oap.schedule_close_date + (86399/86400)))) total_cost,
   --
   to_number(null) sub_ledger_value,
   --
   to_number(null) recon_item_value_current,
   to_number(null) recon_item_value_prior,
   to_number(null) recon_sub_ledger_value,
   to_number(null) recon_item_value_difference,
   --
   to_number(hoi.org_information2) legal_entity_id,
   mp.organization_id,
   iim.inventory_item_id inventory_item_id
  from
   mtl_item_flexfields iim,
   mtl_parameters mp,
   gmf_period_balances gpb,
   org_acct_periods oap,
   hr_all_organization_units haou,
   hr_organization_information hoi,
   mtl_secondary_inventories msi
  where
   iim.inventory_item_id = gpb.inventory_item_id and
   iim.organization_id = gpb.organization_id and
   iim.organization_id = mp.organization_id and
   mp.organization_id = gpb.organization_id and
   hoi.org_information2 = to_char(:p_legal_entity_id) and
   hoi.organization_id = mp.organization_id and
   hoi.org_information_context = 'Accounting Information' and
   haou.organization_id = hoi.organization_id and
   haou.organization_id = mp.organization_id and
   mp.organization_id = oap.organization_id and
   gpb.acct_period_id = oap.acct_period_id and
   oap.period_year = :p_prior_period_year and
   oap.period_num = :p_prior_period_num and
   gpb.subinventory_code (+)= msi.secondary_inventory_name and
   mp.organization_id = msi.organization_id and
   msi.asset_inventory = 1
  group by
   iim.item_number,
   iim.inventory_item_id,
   mp.organization_code,
   to_number(hoi.org_information2),
   oap.period_year,
   oap.period_num,
   iim.primary_uom_code,
   iim.secondary_uom_code,
   iim.description,
   oap.schedule_close_date,
   haou.name,
   mp.organization_id,
   iim.dual_uom_control
),
q_sl_val_cur as
(
  select
   '3. SubLedger Values Current' record_type,
   oap.period_year period_year,
   oap.period_num period_num,
   (oap.schedule_close_date + (86399/86400)) transdate,
   haou.name organization_name,
   mp.organization_code,
   iim.item_number,
   iim.description,
   iim.primary_uom_code primary_uom,
   to_number(null) primary_quantity,
   iim.secondary_uom_code secondary_uom,
   to_number(null) secondary_quantity,
   decode(iim.dual_uom_control,1,'Primary',2,'Fixed',3,'Default','No Default') dual_uom_control,
   to_number(null) unit_cost,
   to_number(null) total_cost,
   --
   sum(sl.base_amount) sub_ledger_value,
   --
   to_number(null) recon_item_value_current,
   to_number(null) recon_item_value_prior,
   to_number(null) recon_sub_ledger_value,
   to_number(null) recon_item_value_difference,
   --
   sl.legal_entity_id,
   sl.organization_id,
   sl.inventory_item_id inventory_item_id
  from
   (select
     eh.reference_no,
     eh.legal_entity_id,
     eh.ledger_id,
     eh.inventory_item_id,
     eh.organization_id,
     eh.transaction_source_type_id,
     eh.transaction_action_id,
     eh.transaction_type_id,
     eh.entity_code,
     eh.event_class_code,
     eh.event_type_code,
     eh.valuation_cost_type,
     eh.accounted_flag,
     el.journal_line_type,
     sum(el.component_cost),
     sum(el.trans_amount_raw),
     sum(el.base_amount_raw) base_amount
    from
     gmf_xla_extract_lines el,
     gmf_xla_extract_headers eh
    where
     el.header_id = eh.header_id and
     eh.transaction_date >= :p_current_period_start_date and
     eh.transaction_date <= :p_current_period_end_date and
     eh.legal_entity_id = :p_legal_entity_id
    group by
     eh.reference_no,
     eh.legal_entity_id,
     eh.ledger_id,
     eh.inventory_item_id,
     eh.organization_id,
     eh.transaction_source_type_id,
     eh.transaction_action_id,
     eh.transaction_type_id,
     eh.entity_code,
     eh.event_class_code,
     eh.event_type_code,
     eh.valuation_cost_type,
     eh.accounted_flag,
     el.journal_line_type
   ) sl,
   mtl_item_flexfields iim,
   mtl_parameters mp,
   hr_all_organization_units haou,
   org_acct_periods oap
  where
   sl.journal_line_type IN ('INV','PPV') and
   iim.inventory_item_id = sl.inventory_item_id and
   iim.organization_id = sl.organization_id and
   mp.organization_id = sl.organization_id and
   haou.organization_id = sl.organization_id and
   oap.organization_id = sl.organization_id and
   oap.period_year = :p_current_period_year and
   oap.period_num = :p_current_period_num
  group by
   oap.period_year,
   oap.period_num,
   (oap.schedule_close_date + (86399/86400)),
   haou.name,
   mp.organization_code,
   iim.item_number,
   iim.description,
   iim.primary_uom_code,
   iim.secondary_uom_code,
   iim.dual_uom_control,
   sl.legal_entity_id,
   sl.organization_id,
   sl.inventory_item_id
),
q_item_diff_val as
(
  select
   '4. Item Reconcilation Diff' record_type,
   y.period_year,
   y.period_num,
   y.transdate,
   y.organization_name,
   y.organization_code,
   y.item_number,
   y.description,
   y.primary_uom,
   to_number(null) primary_quantity,
   y.secondary_uom,
   to_number(null) secondary_quantity,
   y.dual_uom_control dual_uom_control,
   to_number(null) unit_cost,
   to_number(null) total_cost,
   --
   to_number(null) sub_ledger_value,
   --
   nvl(y.itm_val_cur,0) recon_item_value_current,
   nvl(y.itm_val_prior,0) recon_item_value_prior,
   nvl(y.sl_val_cur,0) recon_sub_ledger_value,
   case when (nvl(y.itm_val_cur,0) - nvl(y.itm_val_prior,0)) != nvl(y.sl_val_cur,0)
   then (nvl(y.itm_val_cur,0) - nvl(y.itm_val_prior,0)) - nvl(y.sl_val_cur,0)
   else null
   end recon_item_value_difference,
   --
   y.legal_entity_id,
   y.organization_id,
   y.inventory_item_id inventory_item_id
  from
   (
    select
      oap.period_year period_year,
      oap.period_num period_num,
      (oap.schedule_close_date + (86399/86400)) transdate,
      x.*,
      (select
        qivc.total_cost
       from
        q_inv_val_cur qivc
       where
        qivc.organization_id   = x.organization_id and
        qivc.inventory_item_id = x.inventory_item_id
      ) itm_val_cur,
      (select
        qivp.total_cost
       from
        q_inv_val_pri qivp
       where
        qivp.organization_id   = x.organization_id and
        qivp.inventory_item_id = x.inventory_item_id
      ) itm_val_prior,
      (select
        qsvc.sub_ledger_value
       from
        q_sl_val_cur qsvc
       where
        qsvc.organization_id   = x.organization_id and
        qsvc.inventory_item_id = x.inventory_item_id
      ) sl_val_cur
    from
      (select
        qivc.organization_name,
        qivc.organization_code,
        qivc.item_number,
        qivc.description,
        qivc.primary_uom,
        qivc.secondary_uom,
        qivc.dual_uom_control,
        qivc.legal_entity_id,
        qivc.organization_id,
        qivc.inventory_item_id
       from
        q_inv_val_cur qivc
       union
       select
        qivp.organization_name,
        qivp.organization_code,
        qivp.item_number,
        qivp.description,
        qivp.primary_uom,
        qivp.secondary_uom,
        qivp.dual_uom_control,
        qivp.legal_entity_id,
        qivp.organization_id,
        qivp.inventory_item_id
       from
        q_inv_val_pri qivp
       union
       select
        qsvc.organization_name,
        qsvc.organization_code,
        qsvc.item_number,
        qsvc.description,
        qsvc.primary_uom,
        qsvc.secondary_uom,
        qsvc.dual_uom_control,
        qsvc.legal_entity_id,
        qsvc.organization_id,
        qsvc.inventory_item_id
       from
        q_sl_val_cur qsvc
      ) x,
      mtl_parameters mp,
      org_acct_periods oap
    where
      mp.organization_id = x.organization_id and
      mp.process_enabled_flag = 'Y' and
      oap.organization_id = x.organization_id and
      oap.period_year = :p_current_period_year and
      oap.period_num = :p_current_period_num
   ) y
  where
   (nvl(y.itm_val_cur,0) - nvl(y.itm_val_prior,0)) != nvl(y.sl_val_cur,0)
)
--
-- Main Query Starts Here
--
select
 x.*
from
 (select
   qivc.*
  from
   q_inv_val_cur qivc
  union all
  select
   qivp.*
  from
   q_inv_val_pri qivp
  union all
  select
   qsvc.*
  from
   q_sl_val_cur qsvc
  union all
  select
   qidv.*
  from
   q_item_diff_val qidv
 ) x
where
 :p_legal_entity = :p_legal_entity and
 :p_current_period = :p_current_period and
 :p_period_organization_id = :p_period_organization_id
order by
 x.record_type,
 x.organization_code,
 x.item_number