/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Project Event Upload
-- Description: PA Project Event Upload
===================
This upload can be used to create new Project Billing and Revenue Events against the Projects owned by the Operating Units accessible to the current responsibility.

If the Operating Unit parameter is specified, then the upload will be restricted to Projects within the specified Operating Unit only.

-- Excel Examle Output: https://www.enginatics.com/example/pa-project-event-upload/
-- Library Link: https://www.enginatics.com/reports/pa-project-event-upload/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
 null action_,
 null status_,
 null message_,
 null request_id_,
 to_char(pe.event_id)                        row_id,
 haouv.name                                  operating_unit,
 pp.segment1                                 project_number,
 pp.name                                     project_name,
 pt.task_number                              task_number,
 pt.task_name                                task_name,
 paa.agreement_num                           agreement_number,
 paa.agreement_type                          agreement_type,
 pcv.customer_name                           customer_name,
 pcv.customer_number                         customer_number,
 xxen_util.meaning(pe.pm_product_code,'PM_PRODUCT_CODE',275)
                                             product_source,
 pe.pm_event_reference                       event_reference,
 pe.event_type                               event_type,
 pet.event_type_classification               event_type_classification,
 to_char(pe.completion_date,'DD-Mon-YYYY')   event_date,
 pe.event_num                                event_number,
 pe.description                              description,
 pe.bill_trans_currency_code                 currency,
 pe.bill_trans_bill_amount                   bill_amount,
 pe.bill_trans_rev_amount                    revenue_amount,
 pe.bill_hold_flag                           bill_hold_flag,
 pe.revenue_hold_flag                        revenue_hold_flag,
 pe.adjusting_revenue_flag                   adjusting_revenue_flag,
 pe.bill_group                               bill_group,
 --
 pp.projfunc_currency_code                   proj_func_currency,
 pct1.user_conversion_type                   proj_func_rate_type,
 to_char(pe.projfunc_rate_date,'DD-Mon-YYYY') proj_func_rate_date,
 pe.projfunc_exchange_rate                   proj_func_exchange_rate,
 pp.project_currency_code                    project_currency,
 pct2.user_conversion_type                   project_rate_type,
 to_char(pe.project_rate_date,'DD-Mon-YYYY') project_rate_date,
 pe.project_exchange_rate                    project_exchange_rate,
 pct3.user_conversion_type                   funding_rate_type,
 to_char(pe.funding_rate_date,'DD-Mon-YYYY') funding_rate_date,
 pe.funding_exchange_rate                    funding_exchange_rate,
 --
 pe.quantity_billed                          bill_quantity,
 (select
   mp.organization_code
  from
   mtl_parameters mp
  where
   mp.organization_id = pe.inventory_org_id
 )                                           inventory_organization,
 (select
   msiv.concatenated_segments
  from
   mtl_system_items_vl msiv
  where
   msiv.organization_id   = pe.inventory_org_id and
   msiv.inventory_item_id =  pe.inventory_item_id
 )                                           inventory_item,
 pe.uom_code                                 uom,
 pe.unit_price                               unit_price,
 --
 pe.reference1                               reference1,
 pe.reference2                               reference2,
 pe.reference3                               reference3,
 pe.reference4                               reference4,
 pe.reference5                               reference5,
 pe.reference6                               reference6,
 pe.reference7                               reference7,
 pe.reference8                               reference8,
 pe.reference9                               reference9,
 pe.reference10                              reference10,
 --
 'PA_EVENTS_DESC_FLEX'                       desc_flexfield_name,
 pe.attribute_category                       attribute_category,
 pe.attribute1                               attribute1,
 pe.attribute2                               attribute2,
 pe.attribute3                               attribute3,
 pe.attribute4                               attribute4,
 pe.attribute5                               attribute5,
 pe.attribute6                               attribute6,
 pe.attribute7                               attribute7,
 pe.attribute8                               attribute8,
 pe.attribute9                               attribute9,
 pe.attribute10                              attribute10,
 --
 null                                        delivery_event,
 (select
   ppe.name
  from
   pa_proj_elements ppe
  where
   ppe.proj_element_id = pe.deliverable_id  and
   ppe.object_type      = 'PA_DELIVERABLES'
 )                                           deliverable,
 (select
   ppe.name
  from
   pa_proj_elements ppe
  where
   ppe.proj_element_id = pe.action_id  and
   ppe.object_type      = 'PA_ACTIONS'
 )                                           action,
 --
 pe.event_id                                 event_id
from
 pa_projects                  pp,
 pa_tasks                     pt,
 hr_all_organization_units_vl haouv,
 pa_events                    pe,
 pa_event_types               pet,
 pa_agreements                paa,
 pa_customers_v               pcv,
 pa_conversion_types_v        pct1,
 pa_conversion_types_v        pct2,
 pa_conversion_types_v        pct3
where
 :p_upload_mode != 'Create' and
 :p_pm_product_code = :p_pm_product_code and
 1=1 and
 haouv.organization_id = pe.organization_id and
 pe.project_id         = pp.project_id and
 pe.task_id            = pt.task_id (+) and
 pe.event_type         = pet.event_type and
 pe.agreement_id       = paa.agreement_id (+) and
 paa.customer_id       = pcv.customer_id (+) and
 pe.projfunc_rate_type = pct1.conversion_type(+) and
 pe.project_rate_type  = pct2.conversion_type(+) and
 pe.funding_rate_type  = pct3.conversion_type(+)
 &not_use_first_block
 &report_table_select &report_table_name &report_table_where_clause &success_records
 &processed_run
) x
order by
 x.operating_unit,
 x.project_number,
 x.task_number,
 to_date(x.event_date,'DD-Mon-YYYY'),
 x.event_type,
 x.event_number