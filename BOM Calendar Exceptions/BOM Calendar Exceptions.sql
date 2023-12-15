/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Calendar Exceptions
-- Description: Master data report showing bill of material exceptions dates, exception types and organization code.
-- Excel Examle Output: https://www.enginatics.com/example/bom-calendar-exceptions/
-- Library Link: https://www.enginatics.com/reports/bom-calendar-exceptions/
-- Run Report: https://demo.enginatics.com/

select
bce.calendar_code,
bce.exception_date,
to_char(bce.exception_date,'Day') weekday,
xxen_util.meaning(bce.exception_type,'BOM_ON_OFF',700) exception_type,
mp.organization_code,
haouv.name organization
from
hr_all_organization_units_vl haouv,
mtl_parameters mp,
bom_calendar_exceptions bce
where
1=1 and
mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
haouv.organization_id=mp.organization_id and
mp.calendar_code=bce.calendar_code
order by
bce.calendar_code,
mp.organization_code,
bce.exception_date