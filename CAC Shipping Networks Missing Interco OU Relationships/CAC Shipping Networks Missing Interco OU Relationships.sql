/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Shipping Networks Missing Interco OU Relationships
-- Description: Report to show the missing inventory intercompany operating unit relationships. This report has no parameters.
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
-- -- | Program Name: xxxmissingintercosetupsforshippingnetworksv1.sql
-- -- |
-- -- | Parameters:
-- -- | None
-- -- |
-- -- | Description:
-- -- | Report to show the missing inventory intercompany operating unit relationships.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 16 Oct 2018 Douglas Volz Initial Coding
-- -- | 1.1 11 Apr 2019 Douglas Volz Revert to Release 12
-- -- | 1.2 29 Apr 2020 Douglas Volz Changed to multi-language views for the
-- -- | inventory orgs and operating units.
-- -- | 1.3 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-shipping-networks-missing-interco-ou-relationships/
-- Library Link: https://www.enginatics.com/reports/cac-shipping-networks-missing-interco-ou-relationships/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou_from.name from_operating_unit,
mp_from.organization_code from_org_code,
haouv_from.name from_org_name,
haouv_ou_to.name to_operating_unit,
mp_to.organization_code to_org_code,
decode(mip.intransit_type,1,xxen_util.meaning('DIRECT','PV_PURCHASE_METHOD',0),2,xxen_util.meaning('3','MSC_CALENDAR_TYPE',700)) intransit_type,
xxen_util.meaning(mip.fob_point,'MTL_FOB_POINT',700) fob_point,
xxen_util.yes(decode(mip.internal_order_required_flag,1,'Y')) internal_order_required,
xxen_util.yes(mip.elemental_visibility_enabled) elemental_visibility,
xxen_util.yes(mip.manual_receipt_expense) manual_receipt_at_expense_dest
from
mtl_interorg_parameters mip,
mtl_parameters mp_from,
hr_organization_information hoi_from,
hr_all_organization_units_vl haouv_from,
hr_all_organization_units_vl haouv_ou_from,
gl_ledgers gl,
mtl_parameters mp_to,
hr_organization_information hoi_to,
hr_all_organization_units_vl haouv_ou_to
where
mip.intransit_type in (1,2) and
mip.from_organization_id=mp_from.organization_id and
mp_from.organization_id=hoi_from.organization_id and
hoi_from.org_information_context='Accounting Information' and
hoi_from.organization_id=haouv_from.organization_id and
nvl(haouv_from.date_to,sysdate+1)>sysdate and
to_number(hoi_from.org_information3)=haouv_ou_from.organization_id and
to_number(hoi_from.org_information1)=gl.ledger_id and
mip.to_organization_id=mp_to.organization_id and
mp_to.organization_id=hoi_to.organization_id and
hoi_to.org_information_context='Accounting Information' and
to_number(hoi_to.org_information3)=haouv_ou_to.organization_id and
haouv_ou_from.organization_id<>haouv_ou_to.organization_id and
(haouv_ou_from.organization_id,haouv_ou_to.organization_id) not in (select mip2.ship_organization_id, mip2.sell_organization_id from mtl_intercompany_parameters mip2)
order by
ledger,
from_operating_unit,
from_org_code,
to_operating_unit,
to_org_code
