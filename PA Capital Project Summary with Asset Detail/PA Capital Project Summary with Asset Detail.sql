/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Capital Project Summary with Asset Detail
-- Description: Detail project report that shows the project asset details, and combined project level costs breakdown, along with the project assets details from the Capital Summary
-- Excel Examle Output: https://www.enginatics.com/example/pa-capital-project-summary-with-asset-detail/
-- Library Link: https://www.enginatics.com/reports/pa-capital-project-summary-with-asset-detail/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit, 
  cv.project_type project_type,
  cv.project_number project_number,
  cv.project_name project_name,
  cv.project_id project_id,
  0+cv.expensed -(decode(pa_mc_currency_pkg.get_mrc_sob_type_code, 'R',0, nvl(rv.retirable_cost,0))) expensed_amount,
  0+cv.cip_cost cip_amount,
  0+cv.capitalized_cost interfaced_cip_amount,
  0+decode(pa_mc_currency_pkg.get_mrc_sob_type_code, 'R',null, nvl(rv.rwip,0))rwip_amount,
  0+ (decode(pa_mc_currency_pkg.get_mrc_sob_type_code, 'R',null, nvl(rv.retired_cost,0)))interfaced_rwip_amount,
  0+cv.total_costs total_amount,
  cv.project_organization project_organization,
  pa_pacrcaps_xmlp_pkg.cp_project_id_p cp_project_id,
  ppav.asset_name,
  ppav.project_asset_type,
  ppav.estimated_in_service_date,
  ppav.date_placed_in_service,
  ppav.total_asset_cost,
  rep_total_asset_cost,
  set_of_books_id,
  ppav.reverse_flag,
  ppav.capital_hold_flag,
  ppav.book_type_code,
  ppav.asset_number,
  ppav.asset_units,
  ppav.estimated_asset_units,
  ppav.estimated_cost,
  ppav.pm_product_code,
  ppav.pm_asset_reference,
  flk.concatenated_segments location,
  ppav.full_name employee_name,
  ppav.employee_number,
  ppav.depreciate_flag,
  ppav.amortize_flag,
  ppav.asset_description,
  ppav.manufacturer_name,
  ppav.model_number,
  ppav.serial_number,
  ppav.tag_number,
  ppav.capitalized_flag,
  ppav.capitalized_date,
  ppav.cost_adjustment_flag
from
hr_all_organization_units_vl haouv,
  fa_locations_kfv flk, 
  pa_project_assets_v ppav,
  pa_capital_projects_v cv,
  (select 
     sum(retirable_cost) retirable_cost,
     sum(retired_cost) retired_cost,
     sum(retirable_cost - retired_cost) rwip,
     project_id
   from 
     pa_retirement_costs_v 
   group by 
     project_id
  )  rv
where
1=1 and
haouv.organization_id=cv.org_id and
flk.location_id(+)=ppav.location_id
and ppav.project_id(+)=cv.project_id
  and ppav.project_asset_type (+)!='RETIREMENT_ADJUSTMENT'
  and rv.project_id(+)=cv.project_id 
order by 
  cv.project_type,
  cv.project_organization,
  cv.project_name,
  ppav.asset_name