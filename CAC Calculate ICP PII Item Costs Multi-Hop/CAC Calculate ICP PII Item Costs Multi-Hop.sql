/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Calculate ICP PII Item Costs Multi-Hop
-- Description: Calculates the intercompany profit in inventory (PII or ICP) for each item and receiving organization, accumulated over every transfer of the sourcing chain from the origin organization to the receiving organization, for any number of hops.
-- One row per item and sourcing path. The profit of a hop is the receiving organization's item cost without its this level material overhead, resource, outside processing and overhead costs, less the source organization's converted item cost. Calculated To Org PII is the sum over all hops of the path, each converted into the next organization's currency, plus the origin organization's stored PII cost. Only the origin's stored PII is used, so the PII of intermediate organizations does not have to be loaded first. PII Cost Difference is the calculated less the stored PII of the receiving organization.
-- Sourcing is read from mrpitemsourcinglevelsv: for each item and organization the most specific assignment of the assignment set (item-organization, item master source organization, category, item, organization, organization parameter, global), effective on the currency conversion date. Rules disabled before today are not available for a conversion date in the past. A receiving organization with several transfer sources gets one row per path, with rank and allocation percent of the last hop.
-- Circular Sourcing marks organizations that are only reached through a sourcing loop without an origin; they are calculated for one hop from the source organization's stored PII.
-- A missing exchange rate leaves the calculated columns blank. Inactive items, master organizations and items without costs in the source or receiving organization are not reported. The hidden parameter Numeric Sign for PII (default 1) states whether PII costs are stored as positive or negative amounts.
-- Excel Example Output: https://www.enginatics.com/example/cac-calculate-icp-pii-item-costs-multi-hop/
-- Library Link: https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs-multi-hop/
-- Run Report: https://demo.enginatics.com/

with
c as (
select /*+ inline */
cic.inventory_item_id,
cic.organization_id,
nvl(cic.item_cost,0) item_cost,
nvl(cic.item_cost,0)-nvl(cic.tl_material_overhead,0)-nvl(cic.tl_resource,0)-nvl(cic.tl_outside_processing,0)-nvl(cic.tl_overhead,0) net_cost,
nvl((
select
sum(cicd.item_cost)
from
cst_cost_types cct2,
cst_item_cost_details cicd,
bom_resources br
where
cct2.cost_type=:pii_cost_type and
cct2.cost_type_id=cicd.cost_type_id and
cic.inventory_item_id=cicd.inventory_item_id and
cic.organization_id=cicd.organization_id and
cicd.resource_id=br.resource_id and
br.resource_code=:pii_sub_element
),0) pii_cost
from
cst_cost_types cct,
mtl_parameters mp,
cst_item_costs cic
where
cct.cost_type=:cost_type and
mp.organization_id=cic.organization_id and
(
cic.cost_type_id=cct.cost_type_id or
cic.cost_type_id=mp.primary_cost_method and
(cic.inventory_item_id,cic.organization_id) not in (select cic2.inventory_item_id,cic2.organization_id from cst_item_costs cic2 where cic2.cost_type_id=cct.cost_type_id)
)
),
e as (
select /*+ materialize */
rownum edge_id,
y.*,
decode(y.src_currency,y.to_currency,1,gdr.conversion_rate) conversion_rate,
sign(:sign_pii)*(y.to_net_cost-decode(y.src_currency,y.to_currency,1,gdr.conversion_rate)*y.src_item_cost) hop_pii_cost
from
(
select
x.inventory_item_id,
x.organization_id,
x.source_organization_id,
x.assignment_type,
x.sourcing_rule_name,
x.rank,
x.allocation_percent,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.primary_uom_code,
msiv.item_type,
msiv.planning_make_buy_code,
misv.inventory_item_status_code_tl item_status,
ood_s.organization_code src_org,
ood_t.organization_code to_org,
gl_s.currency_code src_currency,
gl_t.currency_code to_currency,
c_s.item_cost src_item_cost,
c_s.pii_cost src_pii_cost,
c_t.net_cost to_net_cost,
c_t.pii_cost to_pii_cost
from
(
select
mislv.*,
min(mislv.sourcing_level) over (partition by mislv.inventory_item_id,mislv.organization_id) min_sourcing_level
from
mrp_assignment_sets mas,
mrp_item_sourcing_levels_v mislv
where
mas.assignment_set_name=:assignment_set and
mas.assignment_set_id=mislv.assignment_set_id and
mislv.customer_id is null and
mislv.effective_date<:conversion_date+1 and
nvl(mislv.disable_date,:conversion_date)>=:conversion_date
) x,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
org_organization_definitions ood_s,
org_organization_definitions ood_t,
gl_ledgers gl_s,
gl_ledgers gl_t,
c c_s,
c c_t
where
1=1 and
x.sourcing_level=x.min_sourcing_level and
x.source_type=1 and
x.source_organization_id<>x.organization_id and
x.source_organization_id not in (select mp.master_organization_id from mtl_parameters mp) and
x.organization_id not in (select mp.master_organization_id from mtl_parameters mp) and
x.inventory_item_id=msiv.inventory_item_id and
x.organization_id=msiv.organization_id and
msiv.inventory_item_status_code<>'Inactive' and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
x.source_organization_id=ood_s.organization_id and
x.organization_id=ood_t.organization_id and
ood_s.set_of_books_id=gl_s.ledger_id and
ood_t.set_of_books_id=gl_t.ledger_id and
x.inventory_item_id=c_s.inventory_item_id and
x.source_organization_id=c_s.organization_id and
x.inventory_item_id=c_t.inventory_item_id and
x.organization_id=c_t.organization_id
) y,
(
select
gdr.from_currency,
gdr.to_currency,
gdr.conversion_rate
from
gl_daily_conversion_types gdct,
gl_daily_rates gdr
where
gdct.user_conversion_type=:user_conversion_type and
gdct.conversion_type=gdr.conversion_type and
gdr.conversion_date=:conversion_date
) gdr
where
y.src_currency=gdr.from_currency(+) and
y.to_currency=gdr.to_currency(+)
),
h (inventory_item_id,organization_id,edge_id,origin_org,path,hops,src_pii_cost,pii_cost) as (
select
e.inventory_item_id,
e.organization_id,
e.edge_id,
e.src_org,
cast(e.src_org||'>'||e.to_org as varchar2(400)),
1,
e.src_pii_cost,
e.conversion_rate*e.src_pii_cost+e.hop_pii_cost
from
e
where
(e.inventory_item_id,e.source_organization_id) not in (select e2.inventory_item_id,e2.organization_id from e e2)
union all
select
e.inventory_item_id,
e.organization_id,
e.edge_id,
h.origin_org,
h.path||'>'||e.to_org,
h.hops+1,
h.pii_cost,
e.conversion_rate*h.pii_cost+e.hop_pii_cost
from
h,
e
where
h.inventory_item_id=e.inventory_item_id and
h.organization_id=e.source_organization_id
)
cycle organization_id set is_cycle to 'Y' default 'N'
select
:period_name period_name,
e.item_number,
e.item_description,
e.primary_uom_code uom_code,
xxen_util.meaning(e.item_type,'ITEM_TYPE',3) item_type,
xxen_util.meaning(e.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) to_org_make_buy_code,
e.item_status,
&category_columns
h.origin_org,
h.path sourcing_path,
h.hops,
xxen_util.yes(h.circular) circular_sourcing,
e.src_org,
e.sourcing_rule_name sourcing_rule,
xxen_util.meaning(e.assignment_type,'MRP_ASSIGNMENT_TYPE',700) assignment_type,
e.rank,
e.allocation_percent,
e.src_currency src_curr_code,
round(e.src_item_cost-sign(:sign_pii)*h.src_pii_cost,5) source_item_cost,
:conversion_date currency_conversion_date,
e.conversion_rate currency_conversion_rate,
e.to_currency to_org_currency_code,
round(e.conversion_rate*(e.src_item_cost-sign(:sign_pii)*h.src_pii_cost),5) converted_source_item_cost,
e.to_org,
round(e.to_net_cost,5) to_org_item_cost,
round(h.pii_cost,5) calculated_to_org_pii,
round(h.pii_cost/nullif(e.to_net_cost,0)*100,1) pii_percent,
e.to_pii_cost pii_item_cost,
round(h.pii_cost,5)-e.to_pii_cost pii_cost_difference
from
(
select
h.edge_id,
h.origin_org,
h.path,
h.hops,
h.src_pii_cost,
h.pii_cost,
null circular
from
h
where
h.is_cycle='N'
union all
select
e.edge_id,
e.src_org origin_org,
e.src_org||'>'||e.to_org path,
1 hops,
e.src_pii_cost,
e.conversion_rate*e.src_pii_cost+e.hop_pii_cost pii_cost,
'Y' circular
from
e
where
(e.inventory_item_id,e.organization_id) not in (select h.inventory_item_id,h.organization_id from h)
) h,
e
where
2=2 and
h.edge_id=e.edge_id and
e.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV')
order by
e.item_number,
e.to_org,
h.path
