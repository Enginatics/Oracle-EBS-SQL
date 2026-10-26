/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Shipping Network (Inter-Org) Accounts Setup
-- Description: Report to show accounts used for the inter-org shipping network. If the accounts are missing or invalid the account segments are shown as blank entries.
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
-- -- | Program Name: xxxinterorgsetupacctsrept.sql
-- -- |
-- -- | Parameters:
-- -- | pfromorgcode -- Specific from inventory organization you wish to report (optional)
-- -- | pfromoperatingunit -- From operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- | Description:
-- -- | Report to show accounts used for the inter-org shipping network. If the
-- -- | accounts are missing or invalid the account segments are shown as blank entries.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 24 Nov 2009 Douglas Volz Initial Coding
-- -- | 1.1 28 Oct 2010 Douglas Volz Added ledger parameter
-- -- | 1.2 25 Sep 2014 Douglas Volz Removed mfglookup for FOB point, was
-- -- | skipping direct transfers
-- -- | 1.3 07 Jan 2015 Douglas Volz Minor bug fixes
-- -- | 1.4 08 Oct 2015 Douglas Volz Modify for latest client's COA
-- -- | 1.5 06 Oct 2016 Douglas Volz Modified for latest client's COA
-- -- | 1.6 16 Jan 2017 Douglas Volz Added Internal Order Flag Required,
-- -- | Elemental Visibility Enabled and
-- -- | Profit in Inventory Account
-- -- | 1.7 21 Jan 2017 Douglas Volz Added Manual Receipt required for expenses flag
-- -- | 1.8 17 Jul 2018 Douglas Volz Modified chart of accounts for client
-- -- | 1.9 16 Oct 2018 Douglas Volz Retrofitted to Release 11i and added To-Org
-- -- | Operating Unit
-- -- | 1.10 18 Oct 2018 Douglas Volz Added InterOrg Transfer Code and Percentage
-- -- | 1.11 11 Jul 2019 Douglas Volz Changed to G/L short name, chg to Release 12
-- -- | 1.12 17 Jan 2020 Douglas Volz Add Org Code and Operating Unit parameters.
-- -- | 1.13 20 Apr 2020 Douglas Volz Add outer join for gl code combinations, for
-- -- | invalid or missing accounts (CCIDs).
-- -- | 1.14 27 Apr 2020 Douglas Volz Changed to multi-language views for the
-- -- | inventory orgs and operating units.
-- -- | 1.15 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-shipping-network-inter-org-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-shipping-network-inter-org-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name from_operating_unit,
mp.organization_code from_org_code,
haou.name from_org_name,
haouv_ou2.name to_operating_unit,
mp2.organization_code to_org_code,
xxen_util.meaning(x.matl_interorg_transfer_code,'MTL_INTER_INV_TRANSFER',700) transfer_charge_type,
x.interorg_trnsfr_charge_percent transfer_percent,
decode(x.account_number,1,'Intransit Account',2,'InterOrg Xfer CR Account',3,'InterOrg A/R Account',4,'InterOrg A/P Account',5,'Interorg PPV Account',6,'Profit in Inventory Account') account_type,
decode(x.intransit_type,2,xxen_util.meaning(3,'MSC_CALENDAR_TYPE',700),1,xxen_util.meaning('DIRECT','PV_PURCHASE_METHOD',0)) intransit_type,
xxen_util.meaning(x.fob_point,'MTL_FOB_POINT',700) fob_point,
xxen_util.yes(decode(x.internal_order_required_flag,1,'Y')) internal_order_required,
xxen_util.yes(x.elemental_visibility_enabled) elemental_visibility,
xxen_util.yes(x.manual_receipt_expense) manual_receipt_at_expense_dest,
&segment_columns
x.creation_date,
x.last_update_date
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
(
select
mip.from_organization_id,
mip.to_organization_id,
mip.matl_interorg_transfer_code,
mip.interorg_trnsfr_charge_percent,
mip.intransit_type,
mip.fob_point,
mip.internal_order_required_flag,
mip.elemental_visibility_enabled,
mip.manual_receipt_expense,
mip.creation_date,
mip.last_update_date,
rowgen.column_value account_number,
decode(rowgen.column_value,1,mip.intransit_inv_account,2,mip.interorg_transfer_cr_account,3,mip.interorg_receivables_account,4,mip.interorg_payables_account,5,mip.interorg_price_var_account,6,mip.profit_in_inv_account) account_id
from
mtl_interorg_parameters mip,
table(xxen_util.rowgen(6)) rowgen
where
mip.intransit_type in (1,2)
) x,
mtl_parameters mp2,
hr_organization_information hoi2,
hr_all_organization_units_vl haouv_ou2,
gl_code_combinations gcc
where
1=1 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=x.from_organization_id and
x.to_organization_id=mp2.organization_id and
mp2.organization_id=hoi2.organization_id and
hoi2.org_information_context='Accounting Information' and
to_number(hoi2.org_information3)=haouv_ou2.organization_id and
x.account_id=gcc.code_combination_id(+)
order by
x.account_number,
ledger,
from_operating_unit,
from_org_code,
to_org_code
