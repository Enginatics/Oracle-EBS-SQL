/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Cost Group Accounts Setup
-- Description: Report to show the cost group accounts in use. If using Average Costing, FIFO Costing, LIFO Costing, WMS (Warehouse Management System) or Project Manufacturing, the Inventory Cost Processor uses the cost group valuation accounts as opposed to subinventory valuation accounts.
-- Parameters:
-- ===========
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2022 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 04 Oct 2022 Douglas Volz Initial Coding
-- -- | 1.1 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-cost-group-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-cost-group-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
haou.name organization_name,
x.cost_group,
decode(x.account_number,
1,'Material Account',
2,'Material Overhead Account',
3,'Resource Account',
4,'Outside Processing Account',
5,'Overhead Account',
6,'Expense Account',
7,'Encumbrance Account',
8,'Average Cost Variance',
9,'Payback Material Variance Account',
10,'Payback Resource Variance Account',
11,'Payback Outside Processing Variance Account',
12,'Payback Material Overhead Variance Account',
13,'Payback Overhead Variance Account',
14,'Purchase Price Variance Account') account_type,
&segment_columns
x.creation_date,
x.last_update_date,
xxen_util.user_name(x.created_by) created_by,
xxen_util.user_name(x.last_updated_by) last_updated_by
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
(
select
ccg.organization_id,
ccg.cost_group,
ccg.creation_date,
ccg.last_update_date,
ccga.created_by,
ccga.last_updated_by,
rowgen.column_value account_number,
decode(rowgen.column_value,
1,ccga.material_account,
2,ccga.material_overhead_account,
3,ccga.resource_account,
4,ccga.outside_processing_account,
5,ccga.overhead_account,
6,ccga.expense_account,
7,ccga.encumbrance_account,
8,ccga.average_cost_var_account,
9,ccga.payback_mat_var_account,
10,ccga.payback_res_var_account,
11,ccga.payback_osp_var_account,
12,ccga.payback_moh_var_account,
13,ccga.payback_ovh_var_account,
14,ccga.purchase_price_var_account) account_id
from
cst_cost_groups ccg,
cst_cost_group_accounts ccga,
table(xxen_util.rowgen(14)) rowgen
where
ccg.cost_group_id=ccga.cost_group_id and
ccg.organization_id=ccga.organization_id
) x,
gl_code_combinations gcc
where
1=1 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=x.organization_id and
(x.account_number<=6 or x.account_id is not null) and
x.account_id=gcc.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
x.cost_group,
x.account_number
