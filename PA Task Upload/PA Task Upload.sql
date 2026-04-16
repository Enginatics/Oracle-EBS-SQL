/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Task Upload
-- Description: PA Task Upload
======================
Create new tasks or update existing task attributes within Oracle Projects using APIs pa_project_pub.add_task and pa_project_pub.update_task.

This upload does not create projects — it operates on tasks within existing projects.

Supported Actions:
- Create: Add new top-level tasks, child tasks under existing parents, or entire parent-child hierarchies
- Update: Modify attributes of existing tasks (organization, manager, work type, flags, schedules, etc.)

Report Parameters:
- Upload Mode: 'Create' for new tasks only, or 'Create, Update' for both
- Operating Unit: Filter download to a specific operating unit
- Project Number: Filter download to a specific project
- Project Name: Filter download to a specific project by name
- Project Type: Filter download to a specific project type
- Project Status: Filter download to a specific project status

Uploadable Columns:
- Task Identity: Task Number, Task Name, Long Task Name, Task Description
- Hierarchy: Parent Task Number (to create child tasks or reparent)
- Dates: Task Start Date, Task Completion Date
- Organization: Carrying Out Organization, Task Manager
- Classification: Service Type, Work Type
- Flags: Chargeable, Billable, Receive Project Invoice, Ready to Bill, Ready to Distribute, Limit to Txn Controls, Allow Cross Charge, Retirement Cost, Capital Interest (CINT) Eligible
- Labor Billing: Labor Schedule Type, Labor Std Bill Rate Schedule, Labor Schedule Fixed Date, Labor Schedule Discount, Employee Bill Rate Schedule, Labor Cost Multiplier
- Non-Labor Billing: NL Schedule Type, NL Bill Rate Org, NL Std Bill Rate Schedule, NL Schedule Fixed Date, NL Schedule Discount, Job Bill Rate Schedule, Non-Labor Std Bill Rate Schedule
- Burden Schedules: Cost/Revenue/Invoice Burden Schedule and Fixed Dates
- Transfer Pricing: Labor/NL TP Schedule and Fixed Dates, Intercompany Labor/NL TP Schedule and Fixed Dates, CC Process Labor/NL Flags
- Rate Info: Project Rate Type/Date, Task Functional Cost Rate Type/Date
- Revenue/Invoice: Invoice Method, Customer Name, Gen ETC Source Code, CINT Stop Date
- Address: Task Address
- DFF: Attribute Category, Attributes 1-10
- Publish Structure: Set to 'Yes' on the last task row of a project to publish the working structure version after upload

Structure Version Handling:
- For projects without workplan versioning: tasks are added/updated directly — no special handling needed
- For versioned projects with a WORKING structure version: the upload uses the WORKING version automatically
- For versioned projects with only a PUBLISHED version (no WORKING version): task add/update is NOT supported and records will be errored

Unsupported Project Configurations:
- Projects with workplan versioning enabled (Workplan Attributes > Enable Versioning = Yes) that have no WORKING structure version will fail with: "The structure version cannot be updated"
- This typically affects projects where:
  a) All structure versions have been published and none are in working/draft status
  b) Auto-publish is enabled and no manual working version has been created

Workaround for Unsupported Projects:
1. Navigate to Projects > Project Super User > Projects
2. Query the project and go to the Workplan tab
3. Click "Update Workplan" to create a new WORKING structure version
4. Re-run the upload — it will now pick up the WORKING version and succeed
5. After the upload completes, publish the working version from the Workplan tab if needed

Notes:
- To modify tasks on projects owned by other users, the profile option 'PA: Cross Project User -- Update' must be enabled at the responsibility level
- Tasks with existing expenditure items cannot have new subtasks created below them
- When updating tasks, the task number itself is not modified — only other attributes are updated
- The PM Product Code must be a valid value registered in the PA_LOOKUPS lookup type PM_PRODUCT_CODE (e.g., MSPROJECT, PRIMAVERA)
-- Excel Examle Output: https://www.enginatics.com/example/pa-task-upload/
-- Library Link: https://www.enginatics.com/reports/pa-task-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
-- operating unit
haouv.name operating_unit,
-- project
ppv.segment1 project_number,
ppv.name project_name,
ppv.project_type,
ppv.project_status_m project_status,
ppf0.full_name project_manager,
-- task
pt.task_id,
pt.task_number,
pt.task_name,
pt.long_task_name,
pt.description,
lpad(' ',2*(pt.wbs_level-1))||pt.wbs_level wbs_level,
pt2.task_number parent_task_number,
-- task dates
pt.start_date,
pt.completion_date end_date,
-- organization
haouv2.name organization,
-- task manager
ppf.full_name task_manager,
-- service type
xxen_util.meaning(pt.service_type_code,'SERVICE TYPE',275) service_type,
-- work type
pwtv.name work_type,
-- flags
decode(pt.chargeable_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) allow_charges,
decode(pt.billable_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) billable,
decode(pt.ready_to_bill_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) ready_to_bill,
decode(pt.ready_to_distribute_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) ready_to_distribute,
decode(pt.limit_to_txn_controls_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) limit_to_txn_controls,
decode(pt.receive_project_invoice_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) receive_inter_project_invoices,
decode(pt.retirement_cost_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) retirement_cost,
-- billing schedules
xxen_util.meaning(pt.labor_sch_type,'PROJECT SCHEDULE TYPE',275) labor_schedule_type,
psbrsa4.std_bill_rate_schedule labor_std_bill_rate_schedule,
pt.labor_schedule_fixed_date,
pt.labor_schedule_discount,
xxen_util.meaning(pt.labor_disc_reason_code,'RATE AND DISCOUNT REASON',275) labor_discount_reason,
xxen_util.meaning(pt.non_labor_sch_type,'PROJECT SCHEDULE TYPE',275) non_labor_schedule_type,
haouv4.name non_labor_bill_rate_org,
psbrsa5.std_bill_rate_schedule non_labor_std_bill_rate_sched,
pt.non_labor_schedule_fixed_date,
pt.non_labor_schedule_discount,
xxen_util.meaning(pt.non_labor_disc_reason_code,'RATE AND DISCOUNT REASON',275) non_labor_discount_reason,
pt.labor_cost_multiplier_name,
psbrsa1.std_bill_rate_schedule employee_bill_rate_schedule,
psbrsa2.std_bill_rate_schedule job_bill_rate_schedule,
psbrsa3.std_bill_rate_schedule non_labor_bill_rate_schedule,
xxen_util.meaning(pt.invoice_method,'INVOICE METHOD',275) invoice_method,
xxen_util.meaning(pt.gen_etc_source_code,'PA_TASK_LVL_ETC_SRC',275) generate_etc_source,
xxen_util.meaning(pt.adj_on_std_inv,'PA_ADJ_ON_STD_INV',275) adjust_on_standard_invoice,
-- burden schedules
pirsab1.ind_rate_sch_name cost_burden_schedule,
pt.cost_ind_sch_fixed_date cost_ind_schedule_fixed_date,
pirsab2.ind_rate_sch_name revenue_burden_schedule,
pt.rev_ind_sch_fixed_date revenue_ind_sched_fixed_dt,
pirsab3.ind_rate_sch_name invoice_burden_schedule,
pt.inv_ind_sch_fixed_date invoice_ind_sched_fixed_dt,
-- cross charge
decode(pt.allow_cross_charge_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) allow_cross_charge,
decode(pt.cc_process_labor_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) cross_charge_process_labor,
decode(pt.cc_process_nl_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) cross_charge_process_non_labor,
pctsb1.name labor_transfer_price_schedule,
pt.labor_tp_fixed_date labor_transfer_price_fixed_dt,
pctsb2.name non_labor_transfer_price_sched,
pt.nl_tp_fixed_date non_labor_trans_price_fxd_dt,
-- intercompany
pctsb3.name ic_labor_transfer_price_sched,
pt.ic_labor_tp_fixed_date ic_labor_trans_price_fxd_dt,
pctsb4.name ic_non_lab_trans_price_sched,
pt.ic_nl_tp_fixed_date ic_non_lab_trans_price_fxd_dt,
-- rate info
gdct1.user_conversion_type project_rate_type,
pt.project_rate_date,
gdct2.user_conversion_type task_functional_cost_rate_type,
pt.taskfunc_cost_rate_date task_functional_cost_rate_date,
-- capital interest
decode(pt.cint_eligible_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) capital_interest_eligible,
pt.cint_stop_date capital_interest_stop_date,
-- address
hl.address1||nvl2(hl.city,', '||hl.city,null)||nvl2(hl.state,', '||hl.state,null)||nvl2(hl.country,', '||hl.country,null) address,
-- customer
hp.party_name customer_name,
-- DFF
xxen_util.display_flexfield_context(275,'PA_TASKS_DESC_FLEX',pt.attribute_category) attribute_category,
xxen_util.display_flexfield_value(275,'PA_TASKS_DESC_FLEX',pt.attribute_category,'ATTRIBUTE1',pt.rowid,pt.attribute1) attribute1,
xxen_util.display_flexfield_value(275,'PA_TASKS_DESC_FLEX',pt.attribute_category,'ATTRIBUTE2',pt.rowid,pt.attribute2) attribute2,
xxen_util.display_flexfield_value(275,'PA_TASKS_DESC_FLEX',pt.attribute_category,'ATTRIBUTE3',pt.rowid,pt.attribute3) attribute3,
xxen_util.display_flexfield_value(275,'PA_TASKS_DESC_FLEX',pt.attribute_category,'ATTRIBUTE4',pt.rowid,pt.attribute4) attribute4,
xxen_util.display_flexfield_value(275,'PA_TASKS_DESC_FLEX',pt.attribute_category,'ATTRIBUTE5',pt.rowid,pt.attribute5) attribute5,
xxen_util.display_flexfield_value(275,'PA_TASKS_DESC_FLEX',pt.attribute_category,'ATTRIBUTE6',pt.rowid,pt.attribute6) attribute6,
xxen_util.display_flexfield_value(275,'PA_TASKS_DESC_FLEX',pt.attribute_category,'ATTRIBUTE7',pt.rowid,pt.attribute7) attribute7,
xxen_util.display_flexfield_value(275,'PA_TASKS_DESC_FLEX',pt.attribute_category,'ATTRIBUTE8',pt.rowid,pt.attribute8) attribute8,
xxen_util.display_flexfield_value(275,'PA_TASKS_DESC_FLEX',pt.attribute_category,'ATTRIBUTE9',pt.rowid,pt.attribute9) attribute9,
xxen_util.display_flexfield_value(275,'PA_TASKS_DESC_FLEX',pt.attribute_category,'ATTRIBUTE10',pt.rowid,pt.attribute10) attribute10,
null publish_structure,
0 upload_row
from
pa_projects_v ppv,
pa_tasks pt,
pa_tasks pt2,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv2,
hr_all_organization_units_vl haouv4,
per_all_people_f ppf,
per_all_people_f ppf0,
pa_project_parties ppp,
pa_work_types_vl pwtv,
pa_std_bill_rate_schedules_all psbrsa1,
pa_std_bill_rate_schedules_all psbrsa2,
pa_std_bill_rate_schedules_all psbrsa3,
pa_std_bill_rate_schedules_all psbrsa4,
pa_std_bill_rate_schedules_all psbrsa5,
pa_ind_rate_schedules_all_bg pirsab1,
pa_ind_rate_schedules_all_bg pirsab2,
pa_ind_rate_schedules_all_bg pirsab3,
pa_cc_tp_schedules_bg pctsb1,
pa_cc_tp_schedules_bg pctsb2,
pa_cc_tp_schedules_bg pctsb3,
pa_cc_tp_schedules_bg pctsb4,
gl_daily_conversion_types gdct1,
gl_daily_conversion_types gdct2,
hz_party_sites hps,
hz_locations hl,
hz_cust_accounts hca,
hz_parties hp
where
1=1 and
ppv.template_flag='N' and
ppv.org_id=haouv.organization_id and
ppv.project_id=pt.project_id and
pt.parent_task_id=pt2.task_id(+) and
pt.carrying_out_organization_id=haouv2.organization_id and
pt.task_manager_person_id=ppf.person_id(+) and
trunc(sysdate) between ppf.effective_start_date(+) and ppf.effective_end_date(+) and
ppv.project_id=ppp.project_id(+) and
ppp.project_role_id(+)=1 and
nvl(ppp.end_date_active(+),sysdate)>=sysdate and
ppp.resource_source_id=ppf0.person_id(+) and
trunc(sysdate) between ppf0.effective_start_date(+) and ppf0.effective_end_date(+) and
pt.work_type_id=pwtv.work_type_id(+) and
pt.emp_bill_rate_schedule_id=psbrsa1.bill_rate_sch_id(+) and
pt.job_bill_rate_schedule_id=psbrsa2.bill_rate_sch_id(+) and
pt.non_lab_std_bill_rt_sch_id=psbrsa3.bill_rate_sch_id(+) and
pt.labor_std_bill_rate_schdl=psbrsa4.std_bill_rate_schedule(+) and
pt.labor_bill_rate_org_id=psbrsa4.org_id(+) and
pt.non_labor_std_bill_rate_schdl=psbrsa5.std_bill_rate_schedule(+) and
pt.non_labor_bill_rate_org_id=psbrsa5.org_id(+) and
pt.cost_ind_rate_sch_id=pirsab1.ind_rate_sch_id(+) and
pt.rev_ind_rate_sch_id=pirsab2.ind_rate_sch_id(+) and
pt.inv_ind_rate_sch_id=pirsab3.ind_rate_sch_id(+) and
pt.non_labor_bill_rate_org_id=haouv4.organization_id(+) and
pt.labor_tp_schedule_id=pctsb1.tp_schedule_id(+) and
pt.nl_tp_schedule_id=pctsb2.tp_schedule_id(+) and
pt.ic_labor_tp_schedule_id=pctsb3.tp_schedule_id(+) and
pt.ic_nl_tp_schedule_id=pctsb4.tp_schedule_id(+) and
pt.project_rate_type=gdct1.conversion_type(+) and
pt.taskfunc_cost_rate_type=gdct2.conversion_type(+) and
pt.address_id=hps.party_site_id(+) and
hps.location_id=hl.location_id(+) and
pt.customer_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+)