/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Subinventory Accounts Setup
-- Description: Report to show accounts used for the subinventories; these valuation and expense accounts are used with Standard Costing.
-- / +=============================================================================+
-- -- | Copyright 2009 - 22 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxsubinvsetupacctsrept.sql
-- -- |
-- -- | Parameters:
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- |
-- -- | Description:
-- -- | Report to show accounts used for the subinventories
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 24 Nov 2009 Douglas Volz Initial Coding
-- -- | 1.1 28 Mar 2011 Douglas Volz Minor column heading changes
-- -- | 1.2 30 Mar 2011 Douglas Volz Minor column heading changes for Inv Asset,
-- -- | added quantity tracked and disable date
-- -- | columns
-- -- | 1.3 23 Dec 2014 Douglas Volz Added DFFs for "Use Item Type Accounts".
-- -- | For OPM orgs, the ICP valuation reports use
-- -- | this to indicate if the Item Type accounts
-- -- | or the subinventory valuation accounts are
-- -- | displayed on the report.
-- -- | 1.4 07 Oct 2015 Douglas Volz Removed above DFFs for "Use Item Type Accounts",
-- -- | changed COA to match new client. Also added
-- -- | Cost Group Name and accounts. Replaced OOD
-- -- | with mtlparameters and mp.organizationname with
-- -- | haou.name. And removed prior client's organization
-- -- | restrictions.
-- -- | 1.5 11 Nov 2016 Douglas Volz Modified chart of accounts for client
-- -- | 1.6 28 Mar 2017 Douglas Volz Added Creation Date, Last Update Date, Created
-- -- | By, Last Updated By
-- -- | 1.7 02 Feb 2020 Douglas Volz Added Operating Unit and Org Code Parameters
-- -- | and added outer join to gcc.codecombinationsid
-- -- | 1.8 29 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, inventory orgs and operating units.
-- -- | 1.9 10 Jul 2022 Douglas Volz Account Type column now uses a lookup code.
-- -- | 1.10 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-subinventory-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-subinventory-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
haou.name organization_name,
(select ccg.cost_group from cst_cost_groups ccg where x.default_cost_group_id=ccg.cost_group_id) cost_group,
x.secondary_inventory_name subinventory,
xxen_util.yes(decode(x.asset_inventory,1,'Y')) inventory_asset,
xxen_util.yes(decode(x.quantity_tracked,1,'Y')) quantity_tracked,
decode(x.account_number,6,xxen_util.meaning(3,'CST_ACCOUNT_TYPE',700),xxen_util.meaning(x.account_number,'CST_COST_CODE_TYPE',700)) account_type,
&segment_columns
x.creation_date,
x.disable_date,
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
y.*,
rowgen.column_value account_number,
decode(rowgen.column_value,1,y.material_account,2,y.material_overhead_account,3,y.resource_account,4,y.outside_processing_account,5,y.overhead_account,6,y.expense_account) account_id
from
(
select
msi.organization_id,
msi.secondary_inventory_name,
msi.asset_inventory,
msi.quantity_tracked,
msi.default_cost_group_id,
msi.creation_date,
msi.disable_date,
msi.created_by,
msi.last_updated_by,
msi.material_account,
msi.material_overhead_account,
msi.resource_account,
msi.outside_processing_account,
msi.overhead_account,
msi.expense_account
from
mtl_parameters mp,
mtl_secondary_inventories msi
where
mp.organization_id=msi.organization_id and
nvl(mp.cost_group_accounting,2)=2 and
mp.primary_cost_method=1
union all
select
msi.organization_id,
msi.secondary_inventory_name,
msi.asset_inventory,
msi.quantity_tracked,
msi.default_cost_group_id,
msi.creation_date,
msi.disable_date,
msi.created_by,
msi.last_updated_by,
mp.material_account,
mp.material_overhead_account,
mp.resource_account,
mp.outside_processing_account,
mp.overhead_account,
mp.expense_account
from
mtl_parameters mp,
mtl_secondary_inventories msi
where
mp.organization_id=msi.organization_id and
nvl(mp.cost_group_accounting,2)=2 and
mp.primary_cost_method<>1
union all
select
msi.organization_id,
msi.secondary_inventory_name,
msi.asset_inventory,
msi.quantity_tracked,
msi.default_cost_group_id,
msi.creation_date,
msi.disable_date,
msi.created_by,
msi.last_updated_by,
ccga.material_account,
ccga.material_overhead_account,
ccga.resource_account,
ccga.outside_processing_account,
ccga.overhead_account,
ccga.expense_account
from
mtl_parameters mp,
mtl_secondary_inventories msi,
cst_cost_group_accounts ccga
where
mp.organization_id=msi.organization_id and
mp.cost_group_accounting=1 and
nvl(msi.default_cost_group_id,mp.default_cost_group_id)=ccga.cost_group_id
) y,
table(xxen_util.rowgen(6)) rowgen
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
x.account_id=gcc.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
subinventory,
x.account_number
