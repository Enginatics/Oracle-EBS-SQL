/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC OPM Costed Formula
-- Description: Report showing OPM formulas and item costs, by OPM Cost Component Class. The report automatically displays the first thirty Cost Components, sorted by Usage Indicator (1-Material, 2-Overhead, 3-Resource, 4-Expense Alloc), then by the Cost Component Class. With the "Other Costs" column summing up any other non-displayed Cost Component Classes. For a different selection of Cost Component Classes, you may override any of the defaulted Cost Component Classes. If you have fewer than thirty Cost Components the report automatically displays "Not Available", for the succeeding Cost Component columns. And if you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end item costs.
-- Note: The Label Approval column is from a user-defined Formula field, attribute4. Your use of these descriptive flexfields, may be different and may require you to customize this report.
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ==============
-- -- | 1.0 02 Jun 2024 Douglas Volz Initial Coding based on client's sample report.
-- -- | 1.1 03 Jun 2024 Douglas Volz UOM conversions for formula line quantities
-- -- | 1.2 08 Jun 2024 Douglas Volz Replaced Cost Component rownum sort logic.
-- -- | 1.3 12 Jun 2024 Douglas Volz Cleaned-up naming for Cost Component parameters, fixed item number parameter.
-- -- | 1.4 03 Aug 2024 Douglas Volz Add OPM Cost Organizations to get correct item costs.
-- -- | 1.5 05 Aug 2024 Douglas Volz Add inventory organization access control security.
-- -- | 1.6 07 Aug 2024 Douglas Volz Not all formulas are assigned to classes, needs outer join.
-- -- | 1.7 08 Aug 2024 Douglas Volz Add item status and Make/Buy columns.
-- -- | 1.8 09 Aug 2024 Douglas Volz Add parameter "Show More Details" for Scale Type, Contribute to Yield, Std Lot Size and End Date.
-- -- | 1.9 17 Aug 2024 Douglas Volz Add parameters "Only Show Latest Version" and "Effective Date".
-- -- | 1.10 18 Aug 2024 Douglas Volz Restructured code.
-- -- | 1.11 07 Sep 2024 Douglas Volz Fixed Cost Component parameters, from lexicals to bind variables.
-- -- | 1.12 10 Sep 2024 Douglas Volz Add Std Lot Size UOM column.
-- -- | 1.13 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- Excel Example Output: https://www.enginatics.com/example/cac-opm-costed-formula/
-- Library Link: https://www.enginatics.com/reports/cac-opm-costed-formula/
-- Run Report: https://demo.enginatics.com/

with lc as (
select /*+ materialize*/
x.organization_id,
x.inventory_item_id,
max(x.cost_type) cost_type,
max(x.cost_type_desc) cost_type_desc,
sum(decode(x.cost_component_code,:p_cost_component1,x.component_cost)) c1,
sum(decode(x.cost_component_code,:p_cost_component2,x.component_cost)) c2,
sum(decode(x.cost_component_code,:p_cost_component3,x.component_cost)) c3,
sum(decode(x.cost_component_code,:p_cost_component4,x.component_cost)) c4,
sum(decode(x.cost_component_code,:p_cost_component5,x.component_cost)) c5,
sum(decode(x.cost_component_code,:p_cost_component6,x.component_cost)) c6,
sum(decode(x.cost_component_code,:p_cost_component7,x.component_cost)) c7,
sum(decode(x.cost_component_code,:p_cost_component8,x.component_cost)) c8,
sum(decode(x.cost_component_code,:p_cost_component9,x.component_cost)) c9,
sum(decode(x.cost_component_code,:p_cost_component10,x.component_cost)) c10,
sum(decode(x.cost_component_code,:p_cost_component11,x.component_cost)) c11,
sum(decode(x.cost_component_code,:p_cost_component12,x.component_cost)) c12,
sum(decode(x.cost_component_code,:p_cost_component13,x.component_cost)) c13,
sum(decode(x.cost_component_code,:p_cost_component14,x.component_cost)) c14,
sum(decode(x.cost_component_code,:p_cost_component15,x.component_cost)) c15,
sum(decode(x.cost_component_code,:p_cost_component16,x.component_cost)) c16,
sum(decode(x.cost_component_code,:p_cost_component17,x.component_cost)) c17,
sum(decode(x.cost_component_code,:p_cost_component18,x.component_cost)) c18,
sum(decode(x.cost_component_code,:p_cost_component19,x.component_cost)) c19,
sum(decode(x.cost_component_code,:p_cost_component20,x.component_cost)) c20,
sum(decode(x.cost_component_code,:p_cost_component21,x.component_cost)) c21,
sum(decode(x.cost_component_code,:p_cost_component22,x.component_cost)) c22,
sum(decode(x.cost_component_code,:p_cost_component23,x.component_cost)) c23,
sum(decode(x.cost_component_code,:p_cost_component24,x.component_cost)) c24,
sum(decode(x.cost_component_code,:p_cost_component25,x.component_cost)) c25,
sum(decode(x.cost_component_code,:p_cost_component26,x.component_cost)) c26,
sum(decode(x.cost_component_code,:p_cost_component27,x.component_cost)) c27,
sum(decode(x.cost_component_code,:p_cost_component28,x.component_cost)) c28,
sum(decode(x.cost_component_code,:p_cost_component29,x.component_cost)) c29,
sum(decode(x.cost_component_code,:p_cost_component30,x.component_cost)) c30,
sum(case when x.cost_component_code in (:p_cost_component1,:p_cost_component2,:p_cost_component3,:p_cost_component4,:p_cost_component5,:p_cost_component6,:p_cost_component7,:p_cost_component8,:p_cost_component9,:p_cost_component10,:p_cost_component11,:p_cost_component12,:p_cost_component13,:p_cost_component14,:p_cost_component15,:p_cost_component16,:p_cost_component17,:p_cost_component18,:p_cost_component19,:p_cost_component20,:p_cost_component21,:p_cost_component22,:p_cost_component23,:p_cost_component24,:p_cost_component25,:p_cost_component26,:p_cost_component27,:p_cost_component28,:p_cost_component29,:p_cost_component30) then null else x.component_cost end) other_costs,
sum(x.component_cost) total_item_cost
from
(
select
x.organization_id,
x.inventory_item_id,
x.cost_type,
x.cost_type_desc,
x.cost_component_code,
round(sum(x.component_cost),9) component_cost
from
(
select
mp.organization_id,
gic.inventory_item_id,
cmm.cost_mthd_code cost_type,
cmm.cost_mthd_desc cost_type_desc,
ccmb.cost_cmpntcls_code cost_component_code,
gid.cmptcost_amt component_cost
from
mtl_parameters mp,
hr_organization_information hoi,
cm_whse_asc cwa,
gmf_fiscal_policies gfp,
gmf_period_statuses gps,
cm_mthd_mst cmm,
gl_item_cst gic,
gl_item_dtl gid,
cm_cmpt_mst_b ccmb
where
:p_cost_type is null and
32=32 and
35=35 and
36=36 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
mp.organization_id=cwa.organization_id(+) and
to_number(hoi.org_information2)=gfp.legal_entity_id and
gfp.legal_entity_id=gps.legal_entity_id and
gfp.cost_type_id=gps.cost_type_id and
gps.cost_type_id=cmm.cost_type_id and
gps.period_id=gic.period_id and
gps.cost_type_id=gic.cost_type_id and
nvl(cwa.cost_organization_id,mp.organization_id)=gic.organization_id and
gic.delete_mark=0 and
gic.itemcost_id=gid.itemcost_id and
gid.cost_cmpntcls_id=ccmb.cost_cmpntcls_id
union all
select
mp.organization_id,
ccd.inventory_item_id,
cmm.cost_mthd_code cost_type,
cmm.cost_mthd_desc cost_type_desc,
ccmb.cost_cmpntcls_code cost_component_code,
ccd.cmpnt_cost component_cost
from
mtl_parameters mp,
hr_organization_information hoi,
cm_whse_asc cwa,
gmf_period_statuses gps,
cm_mthd_mst cmm,
cm_cmpt_dtl ccd,
cm_cmpt_mst_b ccmb
where
:p_cost_type is not null and
32=32 and
33=33 and
35=35 and
36=36 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
mp.organization_id=cwa.organization_id(+) and
to_number(hoi.org_information2)=gps.legal_entity_id and
gps.cost_type_id=cmm.cost_type_id and
gps.period_id=ccd.period_id and
gps.cost_type_id=ccd.cost_type_id and
nvl(cwa.cost_organization_id,mp.organization_id)=ccd.organization_id and
ccd.delete_mark=0 and
ccd.cost_cmpntcls_id=ccmb.cost_cmpntcls_id and
ccmb.product_cost_ind=1
) x
group by
x.organization_id,
x.inventory_item_id,
x.cost_type,
x.cost_type_desc,
x.cost_component_code
) x
group by
x.organization_id,
x.inventory_item_id
),
last_formula as (
select
max(ffmv.formula_id) keep (dense_rank last order by ffmv.formula_vers) formula_id
from
mtl_parameters mp,
fm_form_mst_vl ffmv,
gmd_status_vl gsv
where
32=32 and
37=37 and
mp.organization_id=ffmv.owner_organization_id and
ffmv.delete_mark=0 and
ffmv.formula_status=gsv.status_code
group by
ffmv.owner_organization_id,
ffmv.formula_no
)
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
:p_calendar_code calendar_code,
:p_period_code period_code,
&category_segments1
ffmv.formula_no formula_number,
ffmv.formula_vers formula_version,
gsv.status_code,
gsv.meaning status_description,
ffmv.formula_desc1 formula_description1,
ffmv.formula_class,
gfcv.formula_class_desc formula_class_description,
msiv.concatenated_segments product_item_number,
&category_segments2
&category_segments3
nvl(ffmv.attribute4,msiv.attribute4) label_approval,
fmd.line_no,
msiv2.concatenated_segments line_item_number,
msiv2.description line_item_description,
xxen_util.meaning(msiv2.item_type,'ITEM_TYPE',3) item_type,
xxen_util.meaning(fmd.line_type,'GMD_FORMULA_ITEM_TYPE',552) formula_item_type,
(select misv.inventory_item_status_code_tl from mtl_item_status_vl misv where msiv2.inventory_item_status_code=misv.inventory_item_status_code) item_status,
xxen_util.meaning(msiv2.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&p_show_more_details
fmd.detail_uom detailed_uom,
msiv2.primary_uom_code primary_uom,
fmd.qty quantity,
fmd.qty*mucv.conversion_rate primary_quantity,
fmd.cost_alloc cost_allocation,
lc.cost_type,
lc.cost_type_desc cost_type_description,
nvl(lc.c1,0) "&p_cost_component1",
nvl(lc.c2,0) "&p_cost_component2",
nvl(lc.c3,0) "&p_cost_component3",
nvl(lc.c4,0) "&p_cost_component4",
nvl(lc.c5,0) "&p_cost_component5",
nvl(lc.c6,0) "&p_cost_component6",
nvl(lc.c7,0) "&p_cost_component7",
nvl(lc.c8,0) "&p_cost_component8",
nvl(lc.c9,0) "&p_cost_component9",
nvl(lc.c10,0) "&p_cost_component10",
nvl(lc.c11,0) "&p_cost_component11",
nvl(lc.c12,0) "&p_cost_component12",
nvl(lc.c13,0) "&p_cost_component13",
nvl(lc.c14,0) "&p_cost_component14",
nvl(lc.c15,0) "&p_cost_component15",
nvl(lc.c16,0) "&p_cost_component16",
nvl(lc.c17,0) "&p_cost_component17",
nvl(lc.c18,0) "&p_cost_component18",
nvl(lc.c19,0) "&p_cost_component19",
nvl(lc.c20,0) "&p_cost_component20",
nvl(lc.c21,0) "&p_cost_component21",
nvl(lc.c22,0) "&p_cost_component22",
nvl(lc.c23,0) "&p_cost_component23",
nvl(lc.c24,0) "&p_cost_component24",
nvl(lc.c25,0) "&p_cost_component25",
nvl(lc.c26,0) "&p_cost_component26",
nvl(lc.c27,0) "&p_cost_component27",
nvl(lc.c28,0) "&p_cost_component28",
nvl(lc.c29,0) "&p_cost_component29",
nvl(lc.c30,0) "&p_cost_component30",
nvl(lc.other_costs,0) other_costs,
nvl(lc.total_item_cost,0) total_item_cost
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
fm_form_mst_vl ffmv,
&p_latest_formula_table
gmd_status_vl gsv,
gmd_formula_class_vl gfcv,
fm_matl_dtl fmd,
mtl_system_items_vl msiv,
mtl_system_items_vl msiv2,
mtl_uom_conversions_view mucv,
&p_show_more_dtl_tables
lc
where
31=31 and
32=32 and
34=34 and
37=37 and
38=38 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.process_enabled_flag='Y' and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
sysdate<nvl(haouv.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=ffmv.owner_organization_id and
ffmv.delete_mark=0 and
ffmv.formula_status=gsv.status_code and
ffmv.formula_class=gfcv.formula_class(+) and
ffmv.formula_id=fmd.formula_id and
mp.organization_id=msiv.organization_id and
msiv.inventory_item_id=(select max(fmd2.inventory_item_id) from fm_matl_dtl fmd2 where ffmv.formula_id=fmd2.formula_id and fmd2.line_type=1) and
fmd.organization_id=msiv2.organization_id and
fmd.inventory_item_id=msiv2.inventory_item_id and
fmd.organization_id=mucv.organization_id and
fmd.inventory_item_id=mucv.inventory_item_id and
fmd.detail_uom=mucv.uom_code and
fmd.organization_id=lc.organization_id(+) and
fmd.inventory_item_id=lc.inventory_item_id(+)
&p_latest_formula_joins
&p_show_more_dtl_joins
order by
ledger,
operating_unit,
org_code,
formula_number,
formula_version,
formula_item_type desc,
product_item_number,
fmd.line_no,
line_item_number
