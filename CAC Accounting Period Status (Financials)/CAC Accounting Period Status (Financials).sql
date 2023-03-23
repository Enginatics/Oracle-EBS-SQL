/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Accounting Period Status (Financials)
-- Description: Accounting period status of all application modules for all or a selected list of ledgers, operating units and inventory organizations.  To see if an accounting period should be opened, use the CAC Accounting Period Status report, as it has more reporting options and features.
-- Excel Examle Output: https://www.enginatics.com/example/cac-accounting-period-status-financials/
-- Library Link: https://www.enginatics.com/reports/cac-accounting-period-status-financials/
-- Run Report: https://demo.enginatics.com/

select
y.application_name,
y.period_name,
y.ledger,
y.operating_unit,
y.organization_code,
y.organization_name,
decode
(y.application_id,401,
  nvl2(oap.acct_period_id,xxen_util.meaning(nvl2(oap.period_close_date,decode(oap.open_flag,'P',2,'N',decode(oap.summarized_flag,'N',65,66),4),3),'MTL_ACCT_PERIOD_STATUS',700),null),
  y.status) status,
xxen_util.meaning(decode(oap.summarized_flag,'Y','Y'),'YES_NO',0) summarized,
xxen_util.user_name(decode(y.application_id,401,oap.created_by,y.created_by)) created_by,
xxen_util.client_time(decode(y.application_id,401,oap.creation_date,y.creation_date)) creation_date,
xxen_util.user_name(decode(y.application_id,401,oap.last_updated_by,y.last_updated_by)) last_updated_by,
xxen_util.client_time(decode(y.application_id,401,oap.last_update_date,y.last_update_date)) last_update_date
from
(
select
x.*,
ood.organization_id,
ood.organization_code,
ood.organization_name,
xxen_util.meaning(gps.closing_status,case when gps.application_id in (200,275) then 'CLOSING STATUS' else 'CLOSING_STATUS' end,case when gps.application_id in (200,275,222) then gps.application_id else 101 end) status,
gps.created_by,
gps.creation_date,
gps.last_updated_by,
gps.last_update_date
from
(
select
fav.application_name,
gl.name ledger,
hou.name operating_unit,
gp.period_name,
fav.application_id,
gl.ledger_id,
decode(fav.application_id,401,hou.organization_id) inv_ou_id,
gp.start_date,
gp.period_year*10000+gp.period_num effective_period_num
from
fnd_application_vl fav,
gl_ledgers gl,
hr_operating_units hou,
gl_periods gp
where
1=1 and
fav.application_id in (222,8405,8721,283,201,200,101,275,540,401) and
gl.ledger_id=hou.set_of_books_id and
gl.period_set_name=gp.period_set_name and
gl.accounted_period_type=gp.period_type and
(gp.adjustment_period_flag='N' or fav.application_id=101)
) x,
gl_period_statuses gps,
org_organization_definitions ood
where
2=2 and
x.application_id=gps.application_id(+) and
x.ledger_id=gps.ledger_id(+) and
x.period_name=gps.period_name(+) and
x.inv_ou_id=ood.operating_unit(+) and
nvl(ood.disable_date(+),sysdate)>=sysdate
) y,
org_acct_periods oap
where
3=3 and
y.organization_id=oap.organization_id(+) and
y.period_name=oap.period_name(+)
order by
y.application_name,
y.start_date desc,
y.effective_period_num desc,
y.ledger,
y.operating_unit,
y.organization_code