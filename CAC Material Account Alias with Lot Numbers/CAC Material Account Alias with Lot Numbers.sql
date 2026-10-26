/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Material Account Alias with Lot Numbers
-- Description: Report to display the material account alias transactions by lot number. Specify Yes for Show Lot Number to split out the transaction quantities and amounts by transaction lot number. And if processed by Create Accounting, the Create Accounting column shows "Yes".
-- Parameters:
-- ===========
-- Transaction Date From: enter the starting transaction date (mandatory).
-- Transaction Date To: enter the ending transaction date (mandatory).
-- Show Lot Number: enter Yes to see transactions by lot number, enter No to exclude lot information (mandatory).
-- Account Alias: enter the account alias to report (optional).
-- Category Set 1, 2, 3: any item category you wish (optional).
-- Item Number: enter the item numbers you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2009-2025 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 06 Nov 2009 Douglas Volz Initial Coding
-- -- | 1.1 11 Nov 2009 Douglas Volz Added Org Code and transaction ID
-- -- | 1.2 12 Nov 2009 Douglas Volz Added item and description
-- -- | 1.3 06 Jan 2010 Douglas Volz Made dates a parameter
-- -- | 1.4 12 Jan 2010 Douglas Volz Added quantity and unit cost columns
-- -- | 1.5 12 Jan 2010 Douglas Volz Added account alias information
-- -- | 1.6 20 Jun 2010 Douglas Volz Added created by information and fixed sort
-- -- | 1.7 27 Jun 2010 Douglas Volz Fixed column label for user name, added Ledger parameter
-- -- | 1.8 16 Jul 2010 Douglas Volz Added primary unit of measure (UOM), reason
-- -- | code and transaction reference (comments) and added lot number
-- -- | 1.9 06 Feb 2012 Douglas Volz Rewrite SQL report to solve cross-joining problem
-- -- | with having multiple lot numbers per material transaction and multiple material overheads
-- -- | 1.10 22 Jun 2015 Douglas Volz Added back comments to this code, removed client-specific SLA rules
-- -- | 1.11 17 May 2017 Douglas Volz Added category sets
-- -- | 1.12 25 Mar 2025 Douglas Volz Cleaned up code for Blitz Report and added Create Accounting Y/N column.
-- -- | 1.13 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-material-account-alias-with-lot-numbers/
-- Library Link: https://www.enginatics.com/reports/cac-material-account-alias-with-lot-numbers/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
oap.period_name,
gcck.concatenated_segments accounts,
&segment_columns
xxen_util.yes(y.create_accounting) create_accounting,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
xxen_util.meaning(y.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_line_type,
mtt.transaction_type_name transaction_type,
mgd.segment1 account_alias,
xxen_util.user_name(mmt.created_by) user_name,
(select mtr.reason_name from mtl_transaction_reasons mtr where mmt.reason_id=mtr.reason_id) reason_code,
mmt.transaction_reference transaction_comments,
y.transaction_id,
y.transaction_date,
&p_show_lot_num_col
decode(y.accounting_line_type,
7,'WIP',
14,null,
1,decode(mmt.transaction_action_id,
  2,decode(sign(y.primary_quantity),1,mmt.transfer_subinventory,mmt.subinventory_code),
  3,decode(mmt.organization_id,y.organization_id,mmt.subinventory_code,mmt.transfer_subinventory),
  21,decode(sign(y.primary_quantity),1,mmt.transfer_subinventory,mmt.subinventory_code),
  22,decode(sign(y.primary_quantity),1,mmt.transfer_subinventory,mmt.subinventory_code),
  28,decode(sign(y.primary_quantity),1,mmt.transfer_subinventory,mmt.subinventory_code),
  mmt.subinventory_code)
) subinventory,
msiv.primary_uom_code uom_code,
nullif(sign(decode(y.base_transaction_value,0,y.primary_quantity,y.base_transaction_value)),0)*abs(nvl(mtln.primary_quantity,mmt.primary_quantity)) quantity,
gl.currency_code,
cce.cost_element,
round(y.unit_cost,5) item_cost,
round(nullif(sign(decode(y.base_transaction_value,0,y.primary_quantity,y.base_transaction_value)),0)*abs(nvl(mtln.primary_quantity,mmt.primary_quantity))*y.unit_cost,2) amount
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_material_transactions mmt,
mtl_generic_dispositions mgd,
mtl_transaction_lot_numbers mtln,
mtl_transaction_types mtt,
mtl_system_items_vl msiv,
org_acct_periods oap,
(
select
mta.transaction_id,
mta.organization_id,
mta.transaction_date,
nvl(xal.code_combination_id,mta.reference_account) code_combination_id,
decode(xal.code_combination_id,null,'Y') create_accounting,
mta.accounting_line_type,
mta.cost_element_id,
mta.primary_quantity,
round(sum(mta.base_transaction_value)/decode(mta.primary_quantity,0,1,mta.primary_quantity),8) unit_cost,
sum(mta.base_transaction_value) base_transaction_value
from
mtl_transaction_accounts mta,
xla_distribution_links xdl,
xla_ae_lines xal
where
3=3 and
mta.transaction_source_type_id=6 and
mta.inv_sub_ledger_id=xdl.source_distribution_id_num_1(+) and
xdl.source_distribution_type(+)='MTL_TRANSACTION_ACCOUNTS' and
xdl.application_id(+)=707 and
xdl.ae_header_id=xal.ae_header_id(+) and
xdl.ae_line_num=xal.ae_line_num(+) and
xdl.application_id=xal.application_id(+)
group by
mta.transaction_id,
mta.organization_id,
mta.transaction_date,
nvl(xal.code_combination_id,mta.reference_account),
decode(xal.code_combination_id,null,'Y'),
mta.accounting_line_type,
mta.cost_element_id,
mta.primary_quantity
) y,
cst_cost_elements cce,
gl_code_combinations_kfv gcck
where
1=1 and
2=2 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=mmt.organization_id and
mmt.transaction_source_type_id=6 and
mmt.transaction_source_id=mgd.disposition_id and
decode('&p_show_lot_number','Y',mmt.transaction_id)=mtln.transaction_id(+) and
mmt.transaction_type_id=mtt.transaction_type_id and
mmt.organization_id=msiv.organization_id and
mmt.inventory_item_id=msiv.inventory_item_id and
mmt.acct_period_id=oap.acct_period_id and
mmt.transaction_id=y.transaction_id and
y.cost_element_id=cce.cost_element_id(+) and
y.code_combination_id=gcck.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
accounts,
item_number,
accounting_line_type,
account_alias,
y.transaction_id,
y.transaction_date,
mtln.lot_number,
subinventory
