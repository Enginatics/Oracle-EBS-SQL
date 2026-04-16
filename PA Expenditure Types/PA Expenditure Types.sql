/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Expenditure Types
-- Description: Listing of project expenditure types with their category, type class, unit of measure, and active dates.
-- Excel Examle Output: https://www.enginatics.com/example/pa-expenditure-types/
-- Library Link: https://www.enginatics.com/reports/pa-expenditure-types/
-- Run Report: https://demo.enginatics.com/

select
pet.expenditure_type,
pet.description,
pet.expenditure_category,
(select psl.meaning from pa_system_linkages psl where psl.function=pet.system_linkage_function) expenditure_type_class,
pet.system_linkage_function,
pet.revenue_category_code,
pet.unit_of_measure,
xxen_util.meaning(pet.cost_rate_flag,'YES_NO',0) cost_rate,
pet.start_date_active,
pet.end_date_active,
xxen_util.user_name(pet.created_by) created_by,
pet.creation_date,
xxen_util.user_name(pet.last_updated_by) last_updated_by,
pet.last_update_date
from
pa_expenditure_types pet
where
1=1
order by
pet.expenditure_type