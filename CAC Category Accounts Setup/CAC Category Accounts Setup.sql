/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Category Accounts Setup
-- Description: Report to show the category accounts in use. If category accounts have been set up with your Subledger Accounting Rules, the Inventory Cost Processor can use them and bypass the organization accounts (Average, LIFO, FIFO Costing) or the subinventory accounts (Standard Costing).
-- / +=============================================================================+
-- -- | Copyright 2021 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxcategorysetupacctsrept.sql
-- -- |
-- -- | Parameters:
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- OperatingUnit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- |
-- -- | Description:
-- -- | Report to show accounts used for the subinventories
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 16 Aug 2021 Douglas Volz Initial Coding
-- -- | 1.1 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-category-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-category-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
haou.name organization_name,
mcv.category_concat_segs category,
(select ccg.cost_group from cst_cost_groups ccg where x.cost_group_id=ccg.cost_group_id) cost_group,
x.subinventory_code subinventory,
(select xxen_util.yes(decode(msi.asset_inventory,1,'Y')) from mtl_secondary_inventories msi where x.organization_id=msi.organization_id and x.subinventory_code=msi.secondary_inventory_name) inventory_asset,
decode(x.account_number,1,'Material Account',2,'Material Overhead Account',3,'Resource Account',4,'Outside Processing Account',5,'Overhead Account',6,'Expense Account',7,'Encumbrance Account',8,'Bridging Account') account_type,
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
mca.organization_id,
mca.category_id,
mca.cost_group_id,
mca.subinventory_code,
mca.creation_date,
mca.last_update_date,
mca.created_by,
mca.last_updated_by,
rowgen.column_value account_number,
decode(rowgen.column_value,1,mca.material_account,2,mca.material_overhead_account,3,mca.resource_account,4,mca.outside_processing_account,5,mca.overhead_account,6,mca.expense_account,7,mca.encumbrance_account,8,mca.bridging_account) account_id
from
mtl_category_accounts mca,
table(xxen_util.rowgen(8)) rowgen
) x,
mtl_categories_v mcv,
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
x.category_id=mcv.category_id and
(x.account_number<=6 or x.account_id is not null) and
x.account_id=gcc.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
category,
subinventory,
x.account_number
