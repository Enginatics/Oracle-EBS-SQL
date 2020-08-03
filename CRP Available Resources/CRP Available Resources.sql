/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CRP Available Resources
-- Description: Detail report showing the date range availability of each resource, as well as daily hours and unit capacity of the resource.
-- Excel Examle Output: https://www.enginatics.com/example/crp-available-resources/
-- Library Link: https://www.enginatics.com/reports/crp-available-resources/
-- Run Report: https://demo.enginatics.com/

select
bd.department_code,
br.resource_code,
br.description,
car.resource_hours,
car.resource_units,
car.resource_start_date,
car.resource_end_date
from
crp_available_resources car,
bom_departments bd,
bom_resources br
where
1=1 and
car.department_id=bd.department_id(+) and
car.resource_id=br.resource_id(+)
order by
br.resource_code,
car.resource_start_date desc