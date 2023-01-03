/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Calendars
-- Description: Bill of material calendars and calendar dates
-- Excel Examle Output: https://www.enginatics.com/example/bom-calendars/
-- Library Link: https://www.enginatics.com/reports/bom-calendars/
-- Run Report: https://demo.enginatics.com/

select distinct
bc.calendar_code,
bc.description,
xxen_util.meaning(bc.quarterly_calendar_type,'BOM_CALENDAR_QT',700) quarterly_calendar_type,
bc.calendar_start_date,
bc.calendar_end_date,
&calendar_date
min(bcd.calendar_date) over (partition by bcd.calendar_code) min_calendar_date,
max(bcd.calendar_date) over (partition by bcd.calendar_code) max_calendar_date,
&organization_code
xxen_util.user_name(bc.created_by) created_by,
xxen_util.client_time(bc.creation_date) creation_date,
xxen_util.user_name(bc.last_updated_by) last_updated_by,
xxen_util.client_time(bc.last_update_date) last_update_date
from
bom_calendars bc,
bom_calendar_dates bcd,
(select mp.* from mtl_parameters mp where '&show_organizations'='Y') mp,
hr_all_organization_units_vl haouv
where
1=1 and
bc.calendar_code=bcd.calendar_code(+) and
bc.calendar_code=mp.calendar_code(+) and
mp.organization_id=haouv.organization_id(+)
order by
bc.calendar_code