/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Accounts Setup
-- Description: Report to show Valuation, Receiving, Profit and Loss and Inter-Org accounts as setup in the inventory organization parameters.
-- / +=============================================================================+
-- -- | Copyright 2009 - 2020 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxinvacctssetuprept.sql
-- -- |
-- -- | Parameters:
-- -- | paccountgroup -- The group of inventory organization parameter accounts
-- -- | you wish to report
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- | Description:
-- -- | Report to show Valuation, Receiving, Profit and Loss and Inter-Org accounts
-- -- | as setup in the inventory organization parameters
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.11 06 Mar 2019 Douglas Volz Added Cost Variance Account, used with Average, FIFO, LIFO
-- -- | 1.12 14 Mar 2019 Douglas Volz Added Expense A/P Accrual Account, Retroactive Price
-- -- | Adjustment Account, Receiving Clearing Account.
-- -- | 1.13 12 Jan 2020 Douglas Volz Added Org Code and Operating Unit parameters,
-- -- | an outer join to gcc in case of invalid accounts
-- -- | and change to gl.shortname.
-- -- | 1.14 28 Feb 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, inventory orgs and operating units.
-- -- | 1.15 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-inventory-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select
y.account_group,
y.account_type,
y.ledger,
y.operating_unit,
y.org_code,
y.organization_name,
&segment_columns
y.last_update_date
from
(
select
case
when rowgen.column_value<=5 then 'Inter-org'
when rowgen.column_value<=7 then 'Profit and Loss'
when rowgen.column_value<=10 then 'Other Accounts'
when rowgen.column_value=12 then 'Shipping'
when rowgen.column_value<=16 then 'Receiving'
else 'Valuation'
end account_group,
decode(rowgen.column_value,
1,'Inter-Org A/P Account',
2,'Inter-Org A/R Account',
3,'Intransit Account',
4,'Inter-Org PPV Account',
5,'Inter-Org Xfer Credit Account',
6,'Cost of Goods Sold Account',
7,'Sales Account',
8,'Deferred COGS Account',
9,'Expense Account',
10,'Avg Cost Variance Account',
11,'Inv. A/P Accrual Account',
12,'Goods Dispatched Account',
13,'IPV Account',
14,'PPV Account',
15,'Clearing Account',
16,'Expense A/P Accrual Account',
17,'Material Value Account',
18,'Matl Ovhd Value Account',
19,'Resource Value Account',
20,'OSP Value Account',
21,'Overhead Value Account',
22,'Receiving Value Account'
) account_type,
decode(rowgen.column_value,
1,mp.interorg_payables_account,
2,mp.interorg_receivables_account,
3,mp.intransit_inv_account,
4,mp.interorg_price_var_account,
5,mp.interorg_transfer_cr_account,
6,mp.cost_of_sales_account,
7,mp.sales_account,
8,mp.deferred_cogs_account,
9,mp.expense_account,
10,mp.average_cost_var_account,
11,mp.ap_accrual_account,
12,wsp.goods_dispatched_account,
13,mp.invoice_price_var_account,
14,mp.purchase_price_var_account,
15,rp.clearing_account_id,
16,psp.accrued_code_combination_id,
17,mp.material_account,
18,mp.material_overhead_account,
19,mp.resource_account,
20,mp.outside_processing_account,
21,mp.overhead_account,
22,rp.receiving_account_id
) code_combination_id,
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
haouv.name organization_name,
mp.last_update_date,
rowgen.column_value sort_order
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
wsh_shipping_parameters wsp,
rcv_parameters rp,
po_system_parameters_all psp,
table(xxen_util.rowgen(22)) rowgen
where
1=1 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
sysdate<nvl(haouv.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=wsp.organization_id(+) and
mp.organization_id=rp.organization_id(+) and
haouv_ou.organization_id=psp.org_id(+) and
(rowgen.column_value<>12 or wsp.organization_id is not null) and
(rowgen.column_value not in (15,22) or rp.organization_id is not null) and
(rowgen.column_value<>16 or psp.org_id is not null and mp.master_organization_id=mp.organization_id)
) y,
gl_code_combinations gcc
where
(:p_account_group is null or upper(y.account_group)=upper(:p_account_group)) and
y.code_combination_id=gcc.code_combination_id(+)
order by
y.sort_order,
y.ledger,
y.operating_unit,
y.org_code
