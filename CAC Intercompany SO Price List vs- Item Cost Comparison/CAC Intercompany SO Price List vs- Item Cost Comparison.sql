/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Intercompany SO Price List vs. Item Cost Comparison
-- Description: Report to show the internal SO price lists, source org item costs and compare against the "To Org" item costs and PII (profit in inventory) amounts. This report is used to ensure the profit in inventory (PII) cost model is working correctly.
-- Parameters:
-- ===========
-- Price Effective Date: the date the sales order list prices are effective (mandatory).
-- Currency Conversion Date: the exchange rate conversion date to use to convert the sales price to the same currency as the item cost (mandatory).
-- Currency Conversion Type: the desired currency conversion type to use to convert the sales price to the same currency as the item cost (mandatory).
-- PII Cost Type: the profit in inventory cost type you wish to report (mandatory).
-- PII Sub-Element: the sub-element or resource for profit in inventory, such as PII or ICP (mandatory).
-- Assignment Set: the set of sourcing rules to use with calculating the PII item costs (mandatory).
-- Cost Type: the cost type to use for the item costs, such as Frozen or Pending (mandatory).
-- Category Set: any item category you wish, typically the Cost or Product Line category set (optional).
-- Item Number: enter the specific item numbers(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- To Org Code: enter the specific To Org you wish to report (optional).
-- To Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- To Org Ledger: enter the specific "To Org" ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2010 - 2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxsopricecostpiirept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== =========================================
-- -- | 1.0 26 Nov 2010 Douglas Volz Created initial Report
-- -- | 1.18 13 Dec 2018 Douglas Volz Add Source Org OU to the InterCoOUs inline table, to ensure
-- -- | uniqueness. Add Source Org joins for SrcOrg item costs.
-- -- | Removed Release 11i edits. Replaced gl.name with gl.shortname.
-- -- | 1.19 17 Jun 2019 Douglas Volz Replace Oracle function apps.qppricelistpvt.getproductuomcode
-- -- | with "and ucr.uomcode = qpa.productuomcode". Comment out Source
-- -- | and To Org Added Costs columns.
-- -- | 1.20 21 Aug 2019 Douglas Volz Removed client-specific SQL logic.
-- -- | 1.21 25 Oct 2019 Douglas Volz Correction to ppriceeffectivedate parameter
-- -- | 1.22 17 Jul 2022 Douglas Volz Changes for multi-language lookup values. Changed
-- -- | back to Oracle QP price packages, to get price list
-- -- | information based on both category or item-specific price lists.
-- -- | 1.23 28 Nov 2023 Andy Haack Added G/L security for the "To Org" G/L and removed tabs.
-- -- | 1.24 06 Feb 2024 Douglas Volz Fix for G/L Daily Rates and add "To Org" inventory security.
-- -- | 1.25 25 Jun 2024 Douglas Volz Reinstall missing parameters, Item Number and To Operating Unit.
-- -- | 1.26 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-intercompany-so-price-list-vs-item-cost-comparison/
-- Library Link: https://www.enginatics.com/reports/cac-intercompany-so-price-list-vs-item-cost-comparison/
-- Run Report: https://demo.enginatics.com/

with s as (
select /*+ materialize*/ distinct
msa.inventory_item_id,
msa.organization_id to_org_id,
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
5=5 and
mas.assignment_set_id=msa.assignment_set_id and
msa.sourcing_rule_id=msr.sourcing_rule_id and
msr.sourcing_rule_id=msro.sourcing_rule_id and
msro.sr_receipt_id=msso.sr_receipt_id
union all
select
msib.inventory_item_id,
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
5=5 and
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
nvl(cic.item_cost,0) item_cost,
nvl((select sum(cicd.item_cost) from cst_item_cost_details cicd, cst_cost_types cct, bom_resources br where cic.organization_id=cicd.organization_id and cic.inventory_item_id=cicd.inventory_item_id and cicd.cost_type_id=cct.cost_type_id and cicd.resource_id=br.resource_id and 4=4),0) pii_cost
from
cst_cost_types cct,
cst_item_costs cic
where
cct.cost_type=:p_cost_type and
cct.cost_type_id=cic.cost_type_id and
(cic.organization_id,cic.inventory_item_id) in (select s.src_org_id,s.inventory_item_id from s union all select s.to_org_id,s.inventory_item_id from s)
),
ic as (
select /*+ materialize*/ distinct
mip.ship_organization_id,
mip.sell_organization_id,
nvl(hcsua.price_list_id,hca.price_list_id) price_list_id
from
mtl_intercompany_parameters mip,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_cust_accounts hca
where
mip.customer_site_id=hcsua.site_use_id and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id and
hcasa.cust_account_id=hca.cust_account_id
),
p as (
select /*+ materialize*/
ic.ship_organization_id,
ic.sell_organization_id,
x.inventory_item_id,
qlhv.name price_list_name,
qlhv.currency_code,
x.operand/mucv.conversion_rate price_in_primary_uom,
max(x.start_date_active) start_date,
x.revision_date
from
ic,
qp_list_headers_vl qlhv,
(
select /*+ no_merge*/
qll.list_header_id,
qll.operand,
qll.start_date_active,
trunc(qll.revision_date) revision_date,
qp_price_list_pvt.get_inventory_item_id(qll.list_line_id) inventory_item_id,
qp_price_list_pvt.get_product_uom_code(qll.list_line_id) uom_code
from
qp_list_lines qll
where
1=1 and
qll.list_header_id in (select ic.price_list_id from ic) and
qll.list_line_type_code='PLL' and
qll.modifier_level_code='LINE'
) x,
mtl_uom_conversions_view mucv
where
ic.price_list_id=qlhv.list_header_id and
qlhv.list_header_id=x.list_header_id and
x.inventory_item_id=mucv.inventory_item_id and
x.uom_code=mucv.uom_code and
mucv.organization_id=(select qp_util.get_item_validation_org from dual)
group by
ic.ship_organization_id,
ic.sell_organization_id,
x.inventory_item_id,
qlhv.name,
qlhv.currency_code,
x.operand/mucv.conversion_rate,
x.revision_date
)
select
y.source_ledger,
y.source_operating_unit,
y.source_org,
y.assignment_set,
y.sourcing_rule,
y.item_number,
y.item_description,
y.uom_code,
y.item_status,
y.item_type,
y.source_make_buy_code,
y.to_org_make_buy_code,
:p_category_set1 category_set,
y.source_category,
y.to_org_category,
y.source_price_list_name,
y.price_currency_code,
y.list_price_in_primary_uom,
:p_conversion_date currency_conversion_date,
round(y.price_rate,6) currency_conversion_rate,
round(y.list_price_in_primary_uom*y.price_rate,5) converted_source_list_price,
y.source_currency_code,
y.source_item_cost,
round(y.cost_rate,6) to_org_currency_conv_rate,
y.to_org_currency_code,
round(y.source_item_cost*y.cost_rate,5) converted_src_item_cost,
round(y.list_price_in_primary_uom*y.price_rate,5)-round(y.source_item_cost*y.cost_rate,5) converted_src_interco_margin,
y.source_pii_cost,
y.to_org_ledger,
y.to_org_operating_unit,
y.to_org,
y.to_org_item_cost,
round(y.list_price_in_primary_uom*y.price_rate,5)-y.to_org_item_cost source_price_vs_to_org_cost,
round(y.source_item_cost*y.cost_rate,5)-y.to_org_item_cost src_org_cost_vs_to_org_cost,
y.to_org_prod_pii_cost,
y.price_start_date,
y.price_revision_date
from
(
select
nvl(gl_src.short_name,gl_src.name) source_ledger,
haouv_src.name source_operating_unit,
mp_src.organization_code source_org,
s.assignment_set,
s.sourcing_rule,
msiv_src.concatenated_segments item_number,
msiv_src.description item_description,
msiv_src.primary_uom_code uom_code,
(select misv.inventory_item_status_code_tl from mtl_item_status_vl misv where msiv_src.inventory_item_status_code=misv.inventory_item_status_code) item_status,
xxen_util.meaning(msiv_src.item_type,'ITEM_TYPE',3) item_type,
xxen_util.meaning(msiv_src.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) source_make_buy_code,
xxen_util.meaning(msiv_to.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) to_org_make_buy_code,
(select mcv.category_concat_segs from mtl_category_sets_vl mcsv, mtl_item_categories mic, mtl_categories_v mcv where mcsv.category_set_name=:p_category_set1 and mcsv.category_set_id=mic.category_set_id and msiv_src.organization_id=mic.organization_id and msiv_src.inventory_item_id=mic.inventory_item_id and mic.category_id=mcv.category_id) source_category,
(select mcv.category_concat_segs from mtl_category_sets_vl mcsv, mtl_item_categories mic, mtl_categories_v mcv where mcsv.category_set_name=:p_category_set1 and mcsv.category_set_id=mic.category_set_id and msiv_to.organization_id=mic.organization_id and msiv_to.inventory_item_id=mic.inventory_item_id and mic.category_id=mcv.category_id) to_org_category,
p.price_list_name source_price_list_name,
p.currency_code price_currency_code,
p.price_in_primary_uom list_price_in_primary_uom,
decode(p.currency_code,gl_to.currency_code,1,(select gdr.conversion_rate from gl_daily_rates gdr, gl_daily_conversion_types gdct where p.currency_code=gdr.from_currency and gl_to.currency_code=gdr.to_currency and gdr.conversion_date=:p_conversion_date and gdr.conversion_type=gdct.conversion_type and gdct.user_conversion_type=:p_user_conversion_type)) price_rate,
gl_src.currency_code source_currency_code,
c_src.item_cost source_item_cost,
decode(gl_src.currency_code,gl_to.currency_code,1,(select gdr.conversion_rate from gl_daily_rates gdr, gl_daily_conversion_types gdct where gl_src.currency_code=gdr.from_currency and gl_to.currency_code=gdr.to_currency and gdr.conversion_date=:p_conversion_date and gdr.conversion_type=gdct.conversion_type and gdct.user_conversion_type=:p_user_conversion_type)) cost_rate,
gl_to.currency_code to_org_currency_code,
c_src.pii_cost source_pii_cost,
nvl(gl_to.short_name,gl_to.name) to_org_ledger,
haouv_to.name to_org_operating_unit,
mp_to.organization_code to_org,
c_to.item_cost to_org_item_cost,
c_to.pii_cost to_org_prod_pii_cost,
p.start_date price_start_date,
p.revision_date price_revision_date
from
s,
mtl_parameters mp_src,
mtl_system_items_vl msiv_src,
hr_organization_information hoi_src,
hr_all_organization_units_vl haouv_src_org,
hr_all_organization_units_vl haouv_src,
gl_ledgers gl_src,
mtl_parameters mp_to,
mtl_system_items_vl msiv_to,
hr_organization_information hoi_to,
hr_all_organization_units_vl haouv_to,
gl_ledgers gl_to,
c c_src,
c c_to,
p
where
6=6 and
7=7 and
s.to_org_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
s.src_org_id=mp_src.organization_id and
mp_src.organization_id<>mp_src.master_organization_id and
s.src_org_id=msiv_src.organization_id and
s.inventory_item_id=msiv_src.inventory_item_id and
msiv_src.inventory_item_status_code<>'Inactive' and
mp_src.organization_id=hoi_src.organization_id and
hoi_src.org_information_context='Accounting Information' and
hoi_src.organization_id=haouv_src_org.organization_id and
sysdate<nvl(haouv_src_org.date_to,sysdate+1) and
to_number(hoi_src.org_information3)=haouv_src.organization_id and
to_number(hoi_src.org_information1)=gl_src.ledger_id and
s.to_org_id=mp_to.organization_id and
mp_to.organization_id<>mp_to.master_organization_id and
s.to_org_id=msiv_to.organization_id and
s.inventory_item_id=msiv_to.inventory_item_id and
msiv_to.inventory_item_status_code<>'Inactive' and
mp_to.organization_id=hoi_to.organization_id and
hoi_to.org_information_context='Accounting Information' and
to_number(hoi_to.org_information3)=haouv_to.organization_id and
to_number(hoi_to.org_information1)=gl_to.ledger_id and
s.src_org_id=c_src.organization_id and
s.inventory_item_id=c_src.inventory_item_id and
s.to_org_id=c_to.organization_id and
s.inventory_item_id=c_to.inventory_item_id and
haouv_src.organization_id=p.ship_organization_id and
haouv_to.organization_id=p.sell_organization_id and
s.inventory_item_id=p.inventory_item_id
) y
order by
y.source_ledger,
y.source_operating_unit,
y.source_org,
y.item_number,
y.to_org_ledger,
y.to_org_operating_unit,
y.to_org
