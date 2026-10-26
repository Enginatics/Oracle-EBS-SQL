/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Accounts Setup
-- Description: Report to show accounts used for WIP accounting classes.
-- Parameters:
-- Organization Code: specific inventory organization to report (optional)
-- Operating Unit: specific operating unit (optional)
-- Ledger: specific ledger (optional)
-- / +=============================================================================+
-- -- | Copyright 2009 - 2025 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 24 Nov 2009 Douglas Volz Initial Coding
-- -- | 1.1 28 Mar 2011 Douglas Volz Added ledger parameter
-- -- | 1.2 18 Nov 2012 Douglas Volz Removed client-specific COA segments and
-- -- | organization conditions
-- -- | 1.3 02 Feb 2020 Douglas Volz Outer join for accounts join, short name
-- -- | for Ledger, Operating Unit and Org Code
-- -- | parameters.
-- -- | 1.4 20 Apr 2020 Douglas Volz Added Creation Date, Last Update Date
-- -- | Changed to multi-language views for the item
-- -- | master, inventory orgs and operating units.
-- -- | 1.5 10 Jul 2022 Douglas Volz Account Type column now uses a lookup code.
-- -- | 1.6 05 Nov 2025 Douglas Volz Added completion cost source, system option
-- -- | and cost type for Average and FIFO Costing.
-- -- | 1.7 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-wip-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-wip-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
x.class_code wip_class,
xxen_util.meaning(x.class_type,'WIP_CLASS_TYPE',700) class_type,
x.disable_date,
decode(x.account_number,10,xxen_util.meaning(11,'INV_RESERVATION_SOURCE_TYPES',700),xxen_util.meaning(x.account_number,'WIP_ELEMENT_VAR_TYPE',700)) account_type,
&segment_columns
gcck.concatenated_segments account_number,
xxen_util.meaning(x.completion_cost_source,'CST_COMPLETION_COST_SRC',700) completion_cost_source,
xxen_util.meaning(x.system_option_id,'CST_SYSTEM_COMPLETION_OPTIONS',700) system_resource_option,
x.creation_date,
x.last_update_date
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
(
select
wac.organization_id,
wac.class_code,
wac.class_type,
wac.disable_date,
wac.completion_cost_source,
wac.system_option_id,
wac.creation_date,
wac.last_update_date,
rowgen.column_value account_number,
decode(rowgen.column_value,
1,wac.material_account,
2,wac.material_overhead_account,
3,wac.resource_account,
4,wac.outside_processing_account,
5,wac.overhead_account,
6,wac.material_variance_account,
7,wac.resource_variance_account,
8,wac.outside_proc_variance_account,
9,wac.overhead_variance_account,
10,wac.std_cost_adjustment_account) account_id
from
wip_accounting_classes wac,
table(xxen_util.rowgen(10)) rowgen
) x,
gl_code_combinations_kfv gcck
where
1=1 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=x.organization_id and
x.account_id=gcck.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
wip_class,
x.account_number
