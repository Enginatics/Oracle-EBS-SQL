/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Batches
-- Description: The primary table is GME_BATCH_HEADER. It contains basic information
regarding the batch such as plant_code, batch_number, batch_type (0 for
normal batches or 10 for firm planned orders), and batch_status. Note
batch_status translations are to be found in GEM_LOOKUPS.

Batches have many steps which are found in GME_BATCH_STEPS. It's not in the
example query; but, the operation name can be found in GMD_OPERATIONS_B
which is linked by OPRN_ID.

Steps have many activities which are found in GME_BATCH_STEP_ACTIVITIES.

Activities have many resources which are found in GME_BATCH_STEP_RESOURCESS.

Resources have many process parameters which are found in
GME_PROCESS_PARAMETERS. Process parameters is OPM's way of letting the
customer easily store information not designed into the GME schema. Think
of it like a descriptive flex field (not on steroids).

The name of the process parameter can be found in GMP_PROCESS_PARAMETERS.
-- Excel Examle Output: https://www.enginatics.com/example/opm-batches
-- Library Link: https://www.enginatics.com/reports/opm-batches
-- Run Report: https://demo.enginatics.com/


select --hou.name,
 gbh.plant_code        plant,
 --gmd.*,
 gbh.batch_no          "batch num",
 gmd.item_no,
 gmd.item_desc,
 gmd.line_type_meaning,
 flv.meaning           "Batch Status",
 --trunc(gbh.plan_start_date)   "Plan Start",
 trunc(gbh.actual_start_date) "Actual Start",
 trunc(gbh.due_date) "Due Date",
 --trunc(gbh.plan_cmplt_date) plan_complete,
 trunc(gbh.actual_cmplt_date) "Actual Comp Date",
 ffmb.attribute4 batch_type,
 gbs.batchstep_no,
 gmd.plan_qty,
 gmd.wip_plan_qty,
 gmd.actual_qty,
 -- gbs.plan_step_qty,
 gbs.actual_step_qty,
 gbs.backflush_qty,
 --gbs.plan_start_date,
 --gbs.actual_start_date,
 --gbs.due_date,
 --gbs.plan_cmplt_date,
 --gbs.actual_cmplt_date,
 --gbs.step_close_date,
 gbs.step_status,
 --gbs.priority_code,
 --gbs.priority_value,
 --gbs.delete_mark,
 --gbs.steprelease_type,
 --gbs.max_step_capacity,
 --gbs.max_step_capacity_uom,
 gbs.plan_charges,
 --gbs.actual_charges,
 --gbs.mass_ref_uom,
 --gbs.plan_mass_qty,
 --gbs.volume_ref_uom,
 --gbs.plan_volume_qty,
 gbs.text_code,
 gbs.actual_mass_qty,
 gbs.actual_volume_qty,
 --gbs.quality_status,
 --gbs.minimum_transfer_qty,
 --gbs.terminated_ind,
 gbs.mass_ref_um,
 gbs.max_step_capacity_um
  from gme_batch_header          gbh,
       gme_batch_steps_v           gbs,
       gme_material_details_v    gmd,
       hr_all_organization_units hou,
       mtl_parameters            mp,
       fnd_lookup_values         flv,
       fm_form_mst_b             ffmb
 where 1=1
   AND gbh.batch_id = gmd.batch_id
   AND gbh.batch_id = gbs.batch_id
   AND gbh.organization_id = gmd.organization_id
      -- AND gmd.line_type = '1'
      --AND gmd.line_no = 1
   and gmd.organization_id = hou.organization_id
   and gmd.organization_id = mp.organization_id
   AND flv.lookup_code = TO_CHAR(gbh.batch_status)
   AND flv.lookup_type = 'GME_BATCH_STATUS'
   AND flv.language = 'US'
   AND ffmb.formula_id = gbh.formula_id
  -- and gbh.batch_no = 130810
   and gbs.batchstep_no = 10
 order by 2