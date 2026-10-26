/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Actual Cost Adjustment Upload
-- Description: Upload to create, update and delete OPM actual cost adjustments per organization, item, calendar period, cost type, component class, analysis code and adjustment type, as in the Actual Cost Adjustments form. The adjustments are applied by the next actual cost process.
-- Quantity applies to average cost adjustments only and is stored as zero for value and unit cost adjustments. A subledger entry is dated within the period, by default on its first day.
-- Delete marks an adjustment for purge, as the form does. Adjustments posted to GL, and those of frozen or closed periods, cannot be changed. Changing an applied adjustment sets its status to Modified.
-- Excel Example Output: https://www.enginatics.com/example/opm-actual-cost-adjustment-upload/
-- Library Link: https://www.enginatics.com/reports/opm-actual-cost-adjustment-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
x.*,
to_number(null) upload_row
from
(
select
cad.cost_adjust_id,
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
gps.calendar_code calendar,
gps.period_code period,
cmm.cost_mthd_code cost_type,
xxen_opm_upload.adjustment_type(cad.adjustment_ind) adjustment_type,
ccmv.cost_cmpntcls_code component_class,
cad.cost_analysis_code analysis_code,
cad.adjust_qty quantity,
cad.adjust_qty_uom uom,
cad.adjust_cost cost,
cad.reason_code,
xxen_util.yes(decode(cad.subledger_ind,1,'Y')) subledger_entry,
cad.adjustment_date gl_date,
xxen_opm_upload.adjustment_status(cad.adjust_status) adjustment_status,
null delete_adjustment,
xxen_util.display_flexfield_context(555,'ADJ_DTL_FLEX',cad.attribute_category) adj_attribute_category,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE1',cad.rowid,cad.attribute1) adj_attribute1,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE2',cad.rowid,cad.attribute2) adj_attribute2,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE3',cad.rowid,cad.attribute3) adj_attribute3,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE4',cad.rowid,cad.attribute4) adj_attribute4,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE5',cad.rowid,cad.attribute5) adj_attribute5,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE6',cad.rowid,cad.attribute6) adj_attribute6,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE7',cad.rowid,cad.attribute7) adj_attribute7,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE8',cad.rowid,cad.attribute8) adj_attribute8,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE9',cad.rowid,cad.attribute9) adj_attribute9,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE10',cad.rowid,cad.attribute10) adj_attribute10,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE11',cad.rowid,cad.attribute11) adj_attribute11,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE12',cad.rowid,cad.attribute12) adj_attribute12,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE13',cad.rowid,cad.attribute13) adj_attribute13,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE14',cad.rowid,cad.attribute14) adj_attribute14,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE15',cad.rowid,cad.attribute15) adj_attribute15,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE16',cad.rowid,cad.attribute16) adj_attribute16,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE17',cad.rowid,cad.attribute17) adj_attribute17,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE18',cad.rowid,cad.attribute18) adj_attribute18,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE19',cad.rowid,cad.attribute19) adj_attribute19,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE20',cad.rowid,cad.attribute20) adj_attribute20,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE21',cad.rowid,cad.attribute21) adj_attribute21,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE22',cad.rowid,cad.attribute22) adj_attribute22,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE23',cad.rowid,cad.attribute23) adj_attribute23,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE24',cad.rowid,cad.attribute24) adj_attribute24,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE25',cad.rowid,cad.attribute25) adj_attribute25,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE26',cad.rowid,cad.attribute26) adj_attribute26,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE27',cad.rowid,cad.attribute27) adj_attribute27,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE28',cad.rowid,cad.attribute28) adj_attribute28,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE29',cad.rowid,cad.attribute29) adj_attribute29,
xxen_util.display_flexfield_value(555,'ADJ_DTL_FLEX',cad.attribute_category,'ATTRIBUTE30',cad.rowid,cad.attribute30) adj_attribute30
from
mtl_parameters mp,
cm_adjs_dtl cad,
mtl_system_items_vl msiv,
gmf_period_statuses gps,
cm_mthd_mst cmm,
cm_cmpt_mst_vl ccmv
where
mp.process_enabled_flag='Y' and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=cad.organization_id and
cad.delete_mark=0 and
cad.inventory_item_id=msiv.inventory_item_id and
cad.organization_id=msiv.organization_id and
cad.period_id=gps.period_id and
cad.cost_type_id=cmm.cost_type_id and
cad.cost_cmpntcls_id=ccmv.cost_cmpntcls_id
) x
where
1=1
