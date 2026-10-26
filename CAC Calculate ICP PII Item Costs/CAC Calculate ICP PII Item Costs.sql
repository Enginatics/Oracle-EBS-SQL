/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Calculate ICP PII Item Costs
-- Description: Report to identify the intercompany "To Org" profit in inventory (also known as PII or ICP) for each inventory organization and item. Report gets the PII item costs across organizations, by joining the sourcing rule information from the first "hop" to the sourcing rule information to the second "hop". In addition, if an item has a source organization in the item master, but the sourcing rule does not exist, this item relationship will still be reported. This report also assumes that the first hop may have profit in inventory from another source organization and will not include any profit in inventory from the source org for the "To Org" profit in inventory calculations. Likewise for the "To Org", any this level material overheads, resources, outside processing or overhead costs are ignored for the profit in inventory calculations. In addition, inactive items and disabled organizations are ignored.
-- Note: there is one hidden parameter:
-- 1) Numeric Sign for PII which allows you to set the sign of the profit in inventory amounts. You can specify positive or negative values based on how you enter PII amounts. Defaulted as positive (+1).
-- / +=============================================================================+
-- -- | Copyright 2009-23 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- | 1.38 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 26 Sep 2009 Douglas Volz Initial Coding
-- -- | 1.34 05 May 2021 Douglas Volz Add Make Buy Code.
-- -- | 1.35 26 Feb 2022 Douglas Volz Add category sets and To Org and From Org
-- -- | parameters. Add two hidden parameters,
-- -- | Include Same OU Transfers and set Sign
-- -- | for PII Amounts (psignpii), to determine
-- -- | if PII is entered as a positive or negative.
-- -- | 1.36 28 Nov 2023 Andy Haack Remove tabs, add org access controls, fix for G/L Daily Rates, outer joins
-- -- | 1.37 28 Jan 2024 Douglas Volz Make Include Transfers to Same OU a displayed parameter.
-- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-calculate-icp-pii-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs/
-- Run Report: https://demo.enginatics.com/

with s as (
select /*+ materialize*/ distinct
msa.inventory_item_id,
msa.organization_id item_org_id,
msro.receipt_organization_id to_org_id,
msso.source_organization_id src_org_id,
mas.assignment_set_name assignment_set,
msr.sourcing_rule_name sourcing_rule
from
mrp_assignment_sets mas,
mrp_sr_assignments msa,
mrp_sourcing_rules msr,
mrp_sr_receipt_org msro,
mrp_sr_source_org msso
where
1=1 and
mas.assignment_set_id=msa.assignment_set_id and
msa.sourcing_rule_id=msr.sourcing_rule_id and
msr.sourcing_rule_id=msro.sourcing_rule_id and
msro.sr_receipt_id=msso.sr_receipt_id
union all
select
msib.inventory_item_id,
msib.organization_id item_org_id,
msib.organization_id to_org_id,
msib.source_organization_id src_org_id,
null assignment_set,
null sourcing_rule
from
mtl_system_items_b msib
where
not exists (
select null
from
mrp_assignment_sets mas,
mrp_sr_assignments msa,
mrp_sr_receipt_org msro,
mrp_sr_source_org msso
where
1=1 and
mas.assignment_set_id=msa.assignment_set_id and
msib.organization_id=msa.organization_id and
msib.inventory_item_id=msa.inventory_item_id and
msa.sourcing_rule_id=msro.sourcing_rule_id and
msro.sr_receipt_id=msso.sr_receipt_id and
msib.source_organization_id=msso.source_organization_id
)
),
c as (
select /*+ materialize*/
cic.organization_id,
cic.inventory_item_id,
nvl(max(cic.item_cost) keep (dense_rank first order by decode(cct.cost_type,:p_cost_type,1,2)),0) item_cost,
nvl(max(cic.item_cost-cic.tl_material_overhead-cic.tl_resource-cic.tl_outside_processing-cic.tl_overhead) keep (dense_rank first order by decode(cct.cost_type,:p_cost_type,1,2)),0) net_cost,
nvl((select sum(cicd.item_cost) from cst_item_cost_details cicd, cst_cost_types cct, bom_resources br where cic.organization_id=cicd.organization_id and cic.inventory_item_id=cicd.inventory_item_id and cicd.cost_type_id=cct.cost_type_id and cicd.resource_id=br.resource_id and 2=2 and 8=8),0) pii_cost
from
cst_item_costs cic,
cst_cost_types cct,
mtl_parameters mp
where
(cic.organization_id,cic.inventory_item_id) in (select s.src_org_id,s.inventory_item_id from s union all select s.to_org_id,s.inventory_item_id from s) and
cic.cost_type_id=cct.cost_type_id and
cic.organization_id=mp.organization_id and
(cct.cost_type=:p_cost_type or cic.cost_type_id=mp.primary_cost_method)
group by
cic.organization_id,
cic.inventory_item_id
)
select
:p_period_name period_name,
y.item_number,
y.item_description,
y.uom_code,
y.item_type,
y.source_make_buy_code,
y.source_status_code,
&category_columns
y.src_org,
y.src_org_assignment_set,
y.sourcing_rule,
y.src_curr_code,
round(y.src_cost,5) source_item_cost,
:p_conversion_date currency_conversion_date,
y.rate currency_conversion_rate,
y.to_org_currency_code,
round(y.rate*y.src_cost,5) converted_source_item_cost,
y.to_org,
round(y.to_cost,5) to_org_item_cost,
round((y.rate*y.src_cost-y.to_cost)*-sign(:p_sign_pii),5) calculated_to_org_pii,
round((y.rate*y.src_cost-y.to_cost)/decode(y.to_cost,0,1,y.to_cost)*100*case when y.to_pii_cost=0 then -sign(:p_sign_pii) when y.to_pii_cost<0 then 1 else -1 end,1) pii_percent,
y.to_pii_cost pii_item_cost,
round((y.rate*y.src_cost-y.to_cost)*-sign(:p_sign_pii),5)-y.to_pii_cost pii_cost_difference
from
(
select
s.inventory_item_id,
s.to_org_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.primary_uom_code uom_code,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) source_make_buy_code,
misv.inventory_item_status_code_tl source_status_code,
mp_src.organization_code src_org,
s.assignment_set src_org_assignment_set,
s.sourcing_rule,
gl_src.currency_code src_curr_code,
c_src.item_cost-sign(:p_sign_pii)*c_src.pii_cost src_cost,
decode(gl_src.currency_code,gl_to.currency_code,1,(select gdr.conversion_rate from gl_daily_rates gdr, gl_daily_conversion_types gdct where gl_src.currency_code=gdr.from_currency and gl_to.currency_code=gdr.to_currency and gdr.conversion_date=:p_conversion_date and gdr.conversion_type=gdct.conversion_type and gdct.user_conversion_type=:p_user_conversion_type)) rate,
gl_to.currency_code to_org_currency_code,
mp_to.organization_code to_org,
c_to.net_cost to_cost,
c_to.pii_cost to_pii_cost
from
s,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
mtl_parameters mp_src,
hr_organization_information hoi_src,
gl_ledgers gl_src,
mtl_parameters mp_to,
hr_organization_information hoi_to,
gl_ledgers gl_to,
c c_src,
c c_to
where
7=7 and
9=9 and
10=10 and
s.to_org_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
s.item_org_id=msiv.organization_id and
s.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code<>'Inactive' and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
s.src_org_id<>s.to_org_id and
s.src_org_id not in (select mp.master_organization_id from mtl_parameters mp) and
s.to_org_id not in (select mp.master_organization_id from mtl_parameters mp) and
s.src_org_id=mp_src.organization_id and
mp_src.organization_id=hoi_src.organization_id and
hoi_src.org_information_context='Accounting Information' and
to_number(hoi_src.org_information1)=gl_src.ledger_id and
s.to_org_id=mp_to.organization_id and
mp_to.organization_id=hoi_to.organization_id and
hoi_to.org_information_context='Accounting Information' and
to_number(hoi_to.org_information1)=gl_to.ledger_id and
s.src_org_id=c_src.organization_id and
s.inventory_item_id=c_src.inventory_item_id and
s.to_org_id=c_to.organization_id and
s.inventory_item_id=c_to.inventory_item_id
) y
order by
y.item_number,
y.to_org,
y.src_org
