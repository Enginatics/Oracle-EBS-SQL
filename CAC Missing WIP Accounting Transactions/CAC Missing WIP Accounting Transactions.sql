/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Missing WIP Accounting Transactions
-- Description: Report to find work in process (WIP) accounting entries where the WIP transaction has been created but the WIP accounting entries do not exist. If you enter Yes for "Only Costed Resources" the report ignores WIP transactions where the resource code is defined as not allowing costs (not costed). If you enter No for "Only Costed Resources" the report includes WIP transactions where the resource code does not allow costs as well as costed resources. And to get all transactions which are missing the WIP accounting entries, even for transactions where the resources are not costed, set the "Only Costed Resources" to No and the Minimum Transaction Amount to zero (0).
-- / +=============================================================================+
-- -- | Copyright 2022 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: missingwipaccountingtransactions.sql
-- -- |
-- -- | Parameters:
-- -- | ptrxdatefrom -- Starting transaction date, mandatory
-- -- | ptrxdateto -- Ending transaction date, mandatory
-- -- | pminimumamount -- The absolute smallest transaction amount to be reported
-- -- | ponlycostedresources -- Only include transactions where the resource code is costed.
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- |
-- -- | Description:
-- -- | Report to find WIP accounting entries where the WIP accounting entries do not
-- -- | exist.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 21 Jul 2022 Douglas Volz Initial Coding based on missingmaterialaccountingtransactions.sql
-- -- | 1.1 23 Jul 2022 Douglas Volz Added Ledger and Operating Unit columns.
-- -- | 1.2 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-missing-wip-accounting-transactions/
-- Library Link: https://www.enginatics.com/reports/cac-missing-wip-accounting-transactions/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
oap.period_name,
(select mtst.transaction_source_type_name from mtl_txn_source_types mtst where mtst.transaction_source_type_id=5) transaction_source,
xxen_util.meaning(wt.transaction_type,'WIP_TRANSACTION_TYPE_SHORT',700) transaction_type,
wt.transaction_id,
wt.transaction_date,
wt.creation_date,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) wip_type,
we.wip_entity_name wip_job,
wt.operation_seq_num operation_seq_number,
wt.resource_seq_num resource_seq_number,
br.resource_code,
br.description resource_description,
cce.cost_element,
msiv.concatenated_segments outside_processing_item,
msiv.description outside_processing_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) outside_processing_item_type,
xxen_util.meaning(br.resource_type,'BOM_RESOURCE_TYPE',700) resource_type,
xxen_util.meaning(br.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) charge_type,
xxen_util.meaning(br.default_basis_type,'CST_BASIS',700) basis_type,
xxen_util.yes(decode(br.allow_costs_flag,1,'Y')) allow_costs,
br.unit_of_measure uom_code,
wt.primary_quantity,
xxen_util.yes(decode(br.standard_rate_flag,1,'Y')) standard_rate,
gl.currency_code,
wt.actual_resource_rate,
wt.standard_resource_rate,
wt.usage_rate_or_amount,
round(nvl(wt.primary_quantity,0)*nvl(wt.usage_rate_or_amount,0)*nvl(decode(br.standard_rate_flag,2,wt.actual_resource_rate,wt.standard_resource_rate),0),2) extended_wip_amount,
(select cct.cost_type from cst_cost_types cct where mp.primary_cost_method=cct.cost_type_id) cost_method,
(select crc.resource_rate from cst_resource_costs crc where wt.resource_id=crc.resource_id and wt.organization_id=crc.organization_id and decode(mp.primary_cost_method,1,1,mp.avg_rates_cost_type_id)=crc.cost_type_id) current_resource_cost
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
wip_transactions wt,
org_acct_periods oap,
wip_entities we,
bom_resources br,
cst_cost_elements cce,
mtl_system_items_vl msiv
where
1=1 and
2=2 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=wt.organization_id and
wt.transaction_id not in (select wta.transaction_id from wip_transaction_accounts wta) and
abs(round(nvl(wt.primary_quantity,0)*nvl(wt.usage_rate_or_amount,0)*nvl(decode(br.standard_rate_flag,2,wt.actual_resource_rate,wt.standard_resource_rate),0),2))>=:p_minimum_amount and
wt.acct_period_id=oap.acct_period_id and
wt.wip_entity_id=we.wip_entity_id and
wt.resource_id=br.resource_id(+) and
br.cost_element_id=cce.cost_element_id(+) and
br.purchase_item_id=msiv.inventory_item_id(+) and
br.organization_id=msiv.organization_id(+)
order by
ledger,
operating_unit,
org_code,
period_name,
transaction_type,
transaction_date
