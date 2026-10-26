/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Intercompany Relationship Setup
-- Description: Report to show accounts used for the intercompany parameters and relationships across operating units.
-- / +=============================================================================+
-- -- | Copyright 2018 - 2020 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxintercoparametersrept.sql
-- -- |
-- -- | Parameters:
-- -- | none
-- -- |
-- -- | Description:
-- -- | Report to show accounts used for the intercompany parameters and relationships
-- -- | across operating units.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 16 Oct 2018 Douglas Volz Initial Coding, based on mtlintercompanyparametersv
-- -- | 1.1 7 Mar 2020 Douglas Volz Add Advanced Accounting Option based on view
-- -- | mtltransactionflowsv.
-- -- | 1.2 27 Apr 2020 Douglas Volz Changed to multi-language views for the
-- -- | inventory orgs and operating units.
-- -- | 1.3 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-intercompany-relationship-setup/
-- Library Link: https://www.enginatics.com/reports/cac-intercompany-relationship-setup/
-- Run Report: https://demo.enginatics.com/

select
haouv_ship.name from_ship_operating_unit,
haouv_sell.name to_sell_operating_unit,
xxen_util.yes(mtfh.new_accounting_flag) advanced_accounting,
mp.organization_code ship_from_to_org,
xxen_util.meaning(mtfh.flow_type,'INV_TRANSACTION_FLOW_TYPE',700) flow_type,
hp.party_name customer_name,
hca.account_number customer_number,
(select qlht.name from qp_list_headers_tl qlht where nvl(hcsua.price_list_id,hca.price_list_id)=qlht.list_header_id and qlht.language=userenv('lang')) price_list,
hcsua.location,
rctta.name receivables_transaction_type,
gcck_ic_cogs.concatenated_segments intercompany_cogs,
decode(mip.inv_currency_code,1,'Currency Code of From_Operating_Unit',2,'Currency Code of To_Operating_Unit',3,'Currency Code of Order') currency_setting,
aps.vendor_name supplier,
assa.vendor_site_code supplier_site,
gcck_frt.concatenated_segments freight_account,
gcck_ia.concatenated_segments inventory_accrual_account,
gcck_ea.concatenated_segments expense_accrual_account,
mip.last_update_date
from
mtl_intercompany_parameters mip,
hr_all_organization_units_vl haouv_ship,
hr_all_organization_units_vl haouv_sell,
mtl_transaction_flow_lines mtfl,
mtl_transaction_flow_headers mtfh,
mtl_parameters mp,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
ra_cust_trx_types_all rctta,
ap_suppliers aps,
ap_supplier_sites_all assa,
gl_code_combinations_kfv gcck_ic_cogs,
gl_code_combinations_kfv gcck_frt,
gl_code_combinations_kfv gcck_ia,
gl_code_combinations_kfv gcck_ea
where
mip.ship_organization_id=haouv_ship.organization_id and
nvl(haouv_ship.date_to,sysdate+1)>sysdate and
mip.sell_organization_id=haouv_sell.organization_id and
nvl(haouv_sell.date_to,sysdate+1)>sysdate and
mip.ship_organization_id=mtfl.from_org_id and
mip.sell_organization_id=mtfl.to_org_id and
mtfl.header_id=mtfh.header_id and
mip.flow_type=mtfh.flow_type and
mtfh.organization_id=mp.organization_id(+) and
mip.customer_id=hca.cust_account_id and
hca.party_id=hp.party_id and
mip.customer_site_id=hcsua.site_use_id and
mip.address_id=hcsua.cust_acct_site_id and
mip.cust_trx_type_id=rctta.cust_trx_type_id and
mip.ship_organization_id=rctta.org_id and
mip.vendor_id=aps.vendor_id(+) and
mip.vendor_site_id=assa.vendor_site_id(+) and
mip.sell_organization_id=assa.org_id(+) and
mip.intercompany_cogs_account_id=gcck_ic_cogs.code_combination_id(+) and
mip.freight_code_combination_id=gcck_frt.code_combination_id(+) and
mip.inventory_accrual_account_id=gcck_ia.code_combination_id(+) and
mip.expense_accrual_account_id=gcck_ea.code_combination_id(+)
order by
from_ship_operating_unit,
to_sell_operating_unit
