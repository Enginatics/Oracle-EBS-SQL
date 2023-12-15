/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Security
-- Description: Shows all Enginatics reports and their security, for example parameter or SQL restrictions.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-security/
-- Library Link: https://www.enginatics.com/reports/blitz-report-security/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
xrv.report_name,
xrv.category,
nvl2(xrpv1.report_id,'Ledger',null) ledger_parameter,
nvl2(xrpv2.report_id,'Operating Unit',null) operating_unit_parameter,
nvl2(xrpv3.report_id,'Organization Code',null) inv_org_parameter,
xxen_util.meaning(nvl(xrpv1.required,case when lower(xrv.required_parameters) like '%:ledger is not null%' then 'Y' end),'YES_NO',0) gl_required,
xxen_util.meaning(nvl(xrpv2.required,case when lower(xrv.required_parameters) like '%:operating_unit is not null%' then 'Y' end),'YES_NO',0) ou_required,
xxen_util.meaning(nvl(xrpv3.required,case when lower(xrv.required_parameters) like '%:organization_code is not null%' then 'Y' end),'YES_NO',0) inv_required,
case when xrv.sql_text_full like '%gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v%' or xrv.sql_text_full like '%gl_access_set_assignments%' then xxen_util.meaning('Y','YES_NO',0) end gl_restricted,
case when xrv.sql_text_full like '%from mo_glob_org_access_tmp mgoat%' then xxen_util.meaning('Y','YES_NO',0) end ou_restricted,
case when xrv.sql_text_full like '%from org_access_view oav%' then xxen_util.meaning('Y','YES_NO',0) end inv_restricted,
xrv.required_parameters advanced_required_parameters
from
xxen_reports_v xrv,
(select xrpv.* from xxen_report_parameters_v xrpv where xrpv.lov_name in ('GL Ledger','GL Ledger (Asset Book Secured)','GL Ledger (restricted by AR System Parameters)')) xrpv1,
(select xrpv.* from xxen_report_parameters_v xrpv where xrpv.lov_name in ('HR Operating Unit')) xrpv2,
(select xrpv.* from xxen_report_parameters_v xrpv where xrpv.lov_name in ('INV Organization Code','INV Organization Code (including master)')) xrpv3
where
1=1 and
xrv.type is null and
xrv.report_name not like 'AD %' and
xrv.report_name not like 'Blitz Report%' and
xrv.report_name not like 'DBA %' and
xrv.report_name not like 'DIS %' and
xrv.report_name not like 'ECC %' and
xrv.report_name not like 'FND %' and
xrv.report_name not like 'JTF Grid %' and
xrv.report_name not like 'WF %' and
xrv.report_name not like 'XDO %' and
xrv.report_name not like 'XLA %' and
xrv.report_name not like 'XLE %' and
xrv.report_name not like 'ZX %' and
xrv.report_id=xrpv1.report_id(+) and
xrv.report_id=xrpv2.report_id(+) and
xrv.report_id=xrpv3.report_id(+)
) x
where
2=2
order by
x.report_name