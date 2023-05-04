/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Capital Project Summary with Asset Detail
-- Description: Detail project report that shows the project asset details, and combined project level costs breakdown, along with the project assets details from the Capital Summary
-- Excel Examle Output: https://www.enginatics.com/example/pa-capital-project-summary-with-asset-detail/
-- Library Link: https://www.enginatics.com/reports/pa-capital-project-summary-with-asset-detail/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
 haouv.name operating_unit,
 cv.project_type,
 cv.project_number,
 cv.project_name,
 (select ppa.long_name from pa_projects_all ppa where ppa.project_id = cv.project_id) long_name,
 (select pps.project_status_name from pa_project_statuses pps where pps.project_status_code = cv.project_status_code) project_status,
 cv.project_id,
 cv.expensed -(decode(pa_mc_currency_pkg.get_mrc_sob_type_code,'R',0, nvl(rv.retirable_cost,0))) expensed_amount,
 cv.cip_cost cip_amount,
 cv.capitalized_cost interfaced_cip_amount,
 decode(pa_mc_currency_pkg.get_mrc_sob_type_code,'R',null, nvl(rv.rwip,0))rwip_amount,
 decode(pa_mc_currency_pkg.get_mrc_sob_type_code, 'R',null, nvl(rv.retired_cost,0))interfaced_rwip_amount,
 cv.total_costs total_amount,
 cv.project_organization,
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
 ppav.cost_adjustment_flag,
 (select distinct listagg(ppc.class_category || ' > ' || ppc.class_code,', ') within group(order by ppc.class_category,ppc.class_code)
  from pa_project_classes ppc
  where ppc.project_id = cv.project_id
 ) project_class_category_class,
 fth.transaction_date_entered asset_trx_entered_date,
 fdp.period_name asset_trx_entered_period,
 fth.date_effective asset_date_effective,
 fdp2.period_name asset_date_effective_period,
 -- unidentified asset line columns
 null asset_line_type,
 null asset_line_description,
 null asset_line_task_number,
 null asset_line_task_name,
 to_number(null) asset_line_amount,
 to_number(null) asset_line_original_amount,
 to_number(null) asset_line_split_percent,
 null asset_line_cip_account,
 null asset_line_fa_period,
 null asset_line_status,
 null asset_line_rejection_reason
from
 hr_all_organization_units_vl haouv,
 fa_locations_kfv flk,
 pa_project_assets_v ppav,
 pa_capital_projects_v cv,
 (select
   sum(prcv.retirable_cost) retirable_cost,
   sum(prcv.retired_cost) retired_cost,
   sum(prcv.retirable_cost - retired_cost) rwip,
   prcv.project_id
  from
   pa_retirement_costs_v prcv
  where
   4=4
  group by
   prcv.project_id
 ) rv,
 fa_transaction_headers fth,
 fa_deprn_periods fdp,
 fa_deprn_periods fdp2
where
    1=1
and 2=2
and haouv.organization_id=cv.org_id
and flk.location_id(+)=ppav.location_id
and ppav.project_id(+)=cv.project_id
and ppav.project_asset_type(+) != 'RETIREMENT_ADJUSTMENT'
and rv.project_id(+)=cv.project_id
and fth.asset_id(+)=ppav.fa_asset_id
and fth.book_type_code(+)=ppav.book_type_code
and fth.transaction_type_code(+)='ADDITION'
and fdp.book_type_code(+)=fth.book_type_code
and fdp.calendar_period_open_date(+)<=trunc(fth.transaction_date_entered)
and fdp.calendar_period_close_date(+)>=trunc(fth.transaction_date_entered)
and fdp2.book_type_code(+)=fth.book_type_code
and fdp2.period_open_date(+)<=fth.date_effective
and nvl(fdp2.period_close_date(+),sysdate)>=fth.date_effective
--
union -- unassigned asset lines
--
select
 haouv.name operating_unit,
 cv.project_type,
 cv.project_number,
 cv.project_name,
 (select ppa.long_name from pa_projects_all ppa where ppa.project_id = cv.project_id) long_name,
 (select pps.project_status_name from pa_project_statuses pps where pps.project_status_code = cv.project_status_code) project_status,
 cv.project_id,
 cv.expensed -(decode(pa_mc_currency_pkg.get_mrc_sob_type_code,'R',0, nvl(rv.retirable_cost,0))) expensed_amount,
 cv.cip_cost cip_amount,
 cv.capitalized_cost interfaced_cip_amount,
 decode(pa_mc_currency_pkg.get_mrc_sob_type_code,'R',null, nvl(rv.rwip,0))rwip_amount,
 decode(pa_mc_currency_pkg.get_mrc_sob_type_code, 'R',null, nvl(rv.retired_cost,0))interfaced_rwip_amount,
 cv.total_costs total_amount,
 cv.project_organization,
 ppalv.asset_name,
 null project_asset_type,
 to_date(null) estimated_in_service_date,
 to_date(null) date_placed_in_service,
 to_number(null) total_asset_cost,
 to_number(null) rep_total_asset_cost,
 to_number(null) set_of_books_id,
 null reverse_flag,
 null capital_hold_flag,
 null book_type_code,
 null asset_number,
 to_number(null) asset_units,
 to_number(null) estimated_asset_units,
 to_number(null) estimated_cost,
 null pm_product_code,
 null pm_asset_reference,
 null location,
 null employee_name,
 null employee_number,
 null depreciate_flag,
 null amortize_flag,
 null asset_description,
 null manufacturer_name,
 null model_number,
 null serial_number,
 null tag_number,
 null capitalized_flag,
 null capitalized_date,
 null cost_adjustment_flag,
 (select distinct listagg(ppc.class_category || ' > ' || ppc.class_code,', ') within group(order by ppc.class_category,ppc.class_code)
  from pa_project_classes ppc
  where ppc.project_id = cv.project_id
 ) project_class_category_class,
 to_date(null) asset_trx_entered_date,
 null asset_trx_entered_period,
 to_date(null) asset_date_effective,
 null asset_date_effective_period,
 -- unassigned asset lines columns
 decode(ppalv.line_type,'C','Capital Asset Line','R','Retirement Cost Line',ppalv.line_type) asset_line_type,
 ppalv.description asset_line_description,
 ppalv.task_number asset_line_task_number,
 ppalv.task_name asset_line_task_name,
 ppalv.current_asset_cost asset_line_amount,
 ppalv.original_asset_cost asset_line_original_amount,
 case when nvl(ppalv.original_asset_cost,0) != 0
 then round(ppalv.current_asset_cost / ppalv.original_asset_cost * 100,2)
 else to_number(null)
 end asset_line_split_percentage,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = ppalv.cip_ccid) asset_line_cip_account,
 ppalv.fa_period_name asset_line_fa_period,
 ppalv.transfer_status_m asset_line_transfer_status,
 ppalv.transfer_rejection_reason_m asset_line_rejection_reason
from
 hr_all_organization_units_vl haouv,
 pa_project_asset_lines_v ppalv,
 pa_capital_projects_v cv,
 (select
   sum(prcv.retirable_cost) retirable_cost,
   sum(prcv.retired_cost) retired_cost,
   sum(prcv.retirable_cost - retired_cost) rwip,
   prcv.project_id
  from
   pa_retirement_costs_v prcv
  where
   4=4
  group by
   prcv.project_id
 ) rv
where
    :p_incl_unassigned_lines is not null
and 1=1
and 3=3 
and haouv.organization_id=cv.org_id
and ppalv.project_id=cv.project_id
and ppalv.project_asset_id=0
and rv.project_id(+)=cv.project_id
) x
order by
 x.project_type,
 x.project_organization,
 x.project_name,
 x.asset_name