/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CRP Available Resources
-- Description: Detail report showing the date range availability of each resource, as well as daily hours and unit capacity of the resource.
-- Excel Examle Output: https://www.enginatics.com/example/crp-available-resources/
-- Library Link: https://www.enginatics.com/reports/crp-available-resources/
-- Run Report: https://demo.enginatics.com/

select
car.compile_designator plan,
mp.organization_code,
bd.department_code,
br.resource_code,
br.description,
car.resource_hours,
car.resource_units,
car.resource_start_date,
car.resource_end_date
from
mtl_parameters mp,
crp_available_resources car,
bom_departments bd,
bom_resources br
where
1=1 and
car.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=car.organization_id and
car.department_id=bd.department_id(+) and
car.resource_id=br.resource_id(+)
order by
car.compile_designator,
mp.organization_code,
bd.department_code,
br.resource_code,
car.resource_start_date desc