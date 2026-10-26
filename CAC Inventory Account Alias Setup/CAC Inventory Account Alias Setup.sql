/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Account Alias Setup
-- Description: Report to show accounts assigned for inventory account aliases
-- / +=============================================================================+
-- -- | Copyright 2011 - 2020 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- | 1.4 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxacctaliassetuprept.sql
-- -- |
-- -- | Parameters:
-- -- | pledger -- Ledger you wish to report, enter a null for all
-- -- | ledgers. (optional)
-- -- |
-- -- | Description:
-- -- | Report to show accounts used for account aliases
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 03 Feb 2011 Douglas Volz Initial Coding
-- -- | 1.1 28 Mar 2011 Douglas Volz Added Ledger parameter, effective date
-- -- | and disable date
-- -- | 1.2 07 Oct 2015 Douglas Volz Removed prior client's org restrictions.
-- -- | 1.3 27 Apr 2020 Douglas Volz Changed to multi-language views for the
-- -- | inventory orgs and operating units.
-- Excel Example Output: https://www.enginatics.com/example/cac-inventory-account-alias-setup/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-account-alias-setup/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
haouv.name organization_name,
mgd.segment1 account_alias,
mgd.description,
&segment_columns
mgd.effective_date,
mgd.disable_date,
mgd.disposition_id alias_id
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_generic_dispositions mgd,
gl_code_combinations gcc
where
1=1 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
nvl(haouv.date_to,sysdate+1)>sysdate and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=mgd.organization_id and
mgd.distribution_account=gcc.code_combination_id
order by
ledger,
operating_unit,
org_code,
organization_name,
account_alias
