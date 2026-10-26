/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Accounting Period Status
-- Description: Report to show the accounting period status for General Ledger, Inventory, Lease Management, Payables, Projects, Purchasing and Receivables. You can choose All Statuses (open or closed or never opened), Closed, Open or Never Opened periods. And for process manufacturing (OPM), if your cost calendar has the same period end dates as your inventory accounting periods, this report will also display the OPM cost calendar status.
-- Note: this report automatically looks for hierarchies which might be used with the Open Period Control and the Close Period Control Oracle programs.
-- / +=============================================================================+
-- -- | SQL Code Copyright 2011-2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== =============== =========================================
-- -- | 1.0 19 Jan 2015 Douglas Volz Combined the xxxperiodopenstatusrept.sql xxxperiodclosestatusrept.sql into one report. Originally written in 2006 and 2011.
-- -- | 1.1 19 Jan 2015 Douglas Volz Added OPM Cost Calendar status and Projects.
-- -- | 1.2 19 Dec 2016 Douglas Volz Fixed list of value choices, was preventing purchasing operating units from being reported.
-- -- | 1.3 18 May 2016 Douglas Volz Minor fix for reporting the Organization Hierarchy
-- -- | 1.4 03 Dec 2018 Douglas Volz Open Periods option now checks for SummarizedFlag.
-- -- | 1.5 27 Oct 2019 Douglas Volz Condense A/R, A/P, Projects, Purchasing SQL logic
-- -- | 1.6 16 Jan 2020 Douglas Volz Add operating unit parameter
-- -- | 1.7 10 Apr 2020 Douglas Volz Made the following multi-language changes: Changed fndapplication to fndapplicationvl and changed hrallorganizationunits to hrallorganizationunitsvl
-- -- | 1.8 7 May 2020 Douglas Volz Added fndproductinstallations to only report installed applications.
-- -- | 1.9 26 May 2020 Douglas Volz Added lookup values and parameters for the organizationhierarchyname subquery.
-- -- | 1.10 28 May 2020 Douglas Volz For language translation, replaced custom Report Options LOV with compound Oracle lookup values.
-- -- | 1.11 21 Jun 2020 Douglas Volz Added Organization Hierarchy as a separate parameter
-- -- | 1.12 07 Feb 2022 Eric Clegg Added who columns using xxenutil functions.
-- -- | 1.13 13 Mar 2022 Douglas Volz Modified for financial apps, to show blank who column values if status = Never Opened.
-- -- | 1.14 11 Jun 2024 Douglas Volz Replaced tabs with spaces. Reinstalled missing parameters.
-- -- | 1.15 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-accounting-period-status/
-- Library Link: https://www.enginatics.com/reports/cac-accounting-period-status/
-- Run Report: https://demo.enginatics.com/

with h as (
select /*+ materialize*/
x.organization_id,
coalesce(max(decode(x.organization_hierarchy_name,'&p_hierarchy_name',x.organization_hierarchy_name)),max(x.organization_hierarchy_name)) hierarchy_name
from
(
select hoh.child_organization_id organization_id, hoh.organization_hierarchy_name from hrfv_organization_hierarchies hoh where hoh.organization_hierarchy_name='&p_hierarchy_name' or regexp_like(hoh.organization_hierarchy_name,'&p_name_open|&p_name_close|&p_name_period','i')
union all
select hoh.parent_organization_id organization_id, hoh.organization_hierarchy_name from hrfv_organization_hierarchies hoh where hoh.organization_hierarchy_name='&p_hierarchy_name' or regexp_like(hoh.organization_hierarchy_name,'&p_name_open|&p_name_close|&p_name_period','i')
) x
group by
x.organization_id
)
select
fav.application_name functional_area,
oap.period_name,
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
haouv.name organization_name,
xxen_util.meaning(decode(oap.open_flag||'-'||nvl(oap.summarized_flag,'N'),'N-N',65,'N-Y',66,'P-N',2,'P-Y',2,'Y-N',3,'Y-Y',3,'N-E',4,'Y-E',4,3),'MTL_ACCT_PERIOD_STATUS',700) period_status,
xxen_util.yes(oap.summarized_flag) summarized_flag,
xxen_util.meaning(opm.period_status,'CLOSING_STATUS',101) opm_period_status,
h.hierarchy_name,
xxen_util.user_name(oap.created_by) created_by,
xxen_util.client_time(oap.creation_date) creation_date,
xxen_util.user_name(oap.last_updated_by) last_updated_by,
xxen_util.client_time(oap.last_update_date) last_update_date
from
(
select
flvv.lookup_code,
flvv.meaning
from
fnd_lookup_values_vl flvv
where
flvv.lookup_type='CLOSING_STATUS' and
flvv.view_application_id=101 and
flvv.lookup_code in ('C','N','O') or
flvv.lookup_type='AUTHORIZATION STATUS' and
flvv.view_application_id=201 and
flvv.lookup_code='ALL'
) ps,
fnd_application_vl fav,
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
org_acct_periods oap,
h,
(
select
hoi.organization_id,
gps.start_date,
gps.period_status
from
mtl_parameters mp,
hr_organization_information hoi,
gmf_fiscal_policies gfp,
gmf_period_statuses gps
where
mp.process_enabled_flag='Y' and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information2)=gfp.legal_entity_id and
gfp.legal_entity_id=gps.legal_entity_id and
gfp.cost_type_id=gps.cost_type_id
) opm
where
1=1 and
5=5 and
fav.application_id=401 and
fav.application_id in (select fpi.application_id from fnd_product_installations fpi where fpi.status<>'N') and
mp.master_organization_id<>mp.organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
sysdate<nvl(haouv.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=oap.organization_id and
oap.organization_id=opm.organization_id(+) and
mp.organization_id=h.organization_id(+) and
oap.period_start_date=opm.start_date(+) and
(
oap.open_flag=decode(ps.lookup_code,'O','Y','C','N','N','X',oap.open_flag) or
nvl(opm.period_status,'Z')=decode(ps.lookup_code,'O','Y','C','C','N','X',opm.period_status) or
nvl(opm.period_status,'Z')=decode(ps.lookup_code,'O','F','X') or
nvl(oap.summarized_flag,'N')=decode(ps.lookup_code,'O','N','C','Y','N','X',nvl(oap.summarized_flag,'N'))
)
union all
select
fav.application_name functional_area,
gp.period_name,
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
haouv.name organization_name,
xxen_util.meaning('N','CLOSING_STATUS',101) period_status,
null summarized_flag,
null opm_period_status,
h.hierarchy_name,
null created_by,
to_date(null) creation_date,
null last_updated_by,
to_date(null) last_update_date
from
(
select
flvv.lookup_code,
flvv.meaning
from
fnd_lookup_values_vl flvv
where
flvv.lookup_type='CLOSING_STATUS' and
flvv.view_application_id=101 and
flvv.lookup_code in ('C','N','O') or
flvv.lookup_type='AUTHORIZATION STATUS' and
flvv.view_application_id=201 and
flvv.lookup_code='ALL'
) ps,
fnd_application_vl fav,
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
gl_periods gp,
h
where
2=2 and
5=5 and
ps.lookup_code in ('N','ALL') and
fav.application_id=401 and
fav.application_id in (select fpi.application_id from fnd_product_installations fpi where fpi.status<>'N') and
mp.master_organization_id<>mp.organization_id and
mp.organization_id not in (select oap.organization_id from org_acct_periods oap where 3=3) and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
sysdate<nvl(haouv.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
gl.period_set_name=gp.period_set_name and
gl.accounted_period_type=gp.period_type and
gp.adjustment_period_flag='N' and
gp.end_date>=mp.creation_date and
mp.organization_id=h.organization_id(+)
union all
select
fav.application_name functional_area,
gps.period_name,
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
null org_code,
null organization_name,
xxen_util.meaning(gps.closing_status,'CLOSING_STATUS',decode(gps.closing_status,'W',222,101)) period_status,
null summarized_flag,
null opm_period_status,
null hierarchy_name,
case when gps.closing_status<>'N' then xxen_util.user_name(gps.created_by) end created_by,
case when gps.closing_status<>'N' then xxen_util.client_time(gps.creation_date) end creation_date,
case when gps.closing_status<>'N' then xxen_util.user_name(gps.last_updated_by) end last_updated_by,
case when gps.closing_status<>'N' then xxen_util.client_time(gps.last_update_date) end last_update_date
from
(
select
flvv.lookup_code,
flvv.meaning
from
fnd_lookup_values_vl flvv
where
flvv.lookup_type='CLOSING_STATUS' and
flvv.view_application_id=101 and
flvv.lookup_code in ('C','N','O') or
flvv.lookup_type='AUTHORIZATION STATUS' and
flvv.view_application_id=201 and
flvv.lookup_code='ALL'
) ps,
fnd_application_vl fav,
gl_period_statuses gps,
gl_ledgers gl,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou
where
4=4 and
5=5 and
fav.application_short_name in ('SQLAP','SQLGL','AR','OKL','PO','PA') and
fav.application_id in (select fpi.application_id from fnd_product_installations fpi where fpi.status<>'N') and
fav.application_id=gps.application_id and
(ps.lookup_code='ALL' or gps.closing_status=ps.lookup_code) and
gps.ledger_id=gl.ledger_id and
gl.ledger_id=to_number(hoi.org_information3) and
hoi.org_information_context='Operating Unit Information' and
hoi.organization_id=haouv_ou.organization_id
order by
functional_area,
period_name,
ledger,
operating_unit,
org_code
