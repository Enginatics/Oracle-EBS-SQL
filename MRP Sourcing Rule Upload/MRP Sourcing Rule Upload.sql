/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MRP Sourcing Rule Upload
-- Description: MRP Sourcing Rule Upload
====================
- Upload new Sourcing Rules
- Update Existing Sourcing Rules
-- Excel Examle Output: https://www.enginatics.com/example/mrp-sourcing-rule-upload/
-- Library Link: https://www.enginatics.com/reports/mrp-sourcing-rule-upload/
-- Run Report: https://demo.enginatics.com/

with sr_query as
(
select
 --
 -- sourcing rule
 xxen_util.meaning(mrs.sourcing_rule_type,'MRP_SOURCING_RULE_TYPE',700) rule_type,
 mrs.sourcing_rule_name rule_name,
 mrs.description rule_description,
 xxen_util.meaning(nvl2(mp.organization_code,'2','1'),'INV_YES_NO',3) all_orgs,
 mp.organization_code  organization,
 xxen_util.meaning(mrs.status,'INV_YES_NO',3) active,
 xxen_util.meaning(decode(mrs.planning_active,1,1,null),'INV_YES_NO',3) planning_active,
 -- receiving organizations
 msrov.organization_code receipt_organization,
 msrov.customer          receipt_customer,
 msrov.address           receipt_address,
 msrov.effective_date    effective_date_from,
 msrov.disable_date      effective_date_to,
 -- shipping organization
 xxen_util.meaning(mssov.source_type,'MRP_SOURCE_TYPE',700) source_type,
 mssov.source_organization_code source_organization,
 asu.vendor_name supplier,
 asu.segment1 supplier_number,
 mssov.vendor_site supplier_site,
 haouv.name supplier_site_op_unit,
 mssov.allocation_percent allocation_percent,
 mssov.rank rank,
 mssov.ship_method ship_method,
 mssov.intransit_time intransit_time,
 -- attributes
 xxen_util.display_flexfield_context(704,'MRP_SOURCING_RULES',mrs.attribute_category) rule_attribute_category,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE1',mrs.rowid,mrs.attribute1) sr_rule_attribute1,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE2',mrs.rowid,mrs.attribute2) sr_rule_attribute2,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE3',mrs.rowid,mrs.attribute3) sr_rule_attribute3,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE4',mrs.rowid,mrs.attribute4) sr_rule_attribute4,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE5',mrs.rowid,mrs.attribute5) sr_rule_attribute5,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE6',mrs.rowid,mrs.attribute6) sr_rule_attribute6,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE7',mrs.rowid,mrs.attribute7) sr_rule_attribute7,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE8',mrs.rowid,mrs.attribute8) sr_rule_attribute8,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE9',mrs.rowid,mrs.attribute9) sr_rule_attribute9,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE10',mrs.rowid,mrs.attribute10) sr_rule_attribute10,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE11',mrs.rowid,mrs.attribute11) sr_rule_attribute11,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE12',mrs.rowid,mrs.attribute12) sr_rule_attribute12,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE13',mrs.rowid,mrs.attribute13) sr_rule_attribute13,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE14',mrs.rowid,mrs.attribute14) sr_rule_attribute14,
 xxen_util.display_flexfield_value(704,'MRP_SOURCING_RULES',mrs.attribute_category,'ATTRIBUTE15',mrs.rowid,mrs.attribute15) sr_rule_attribute15,
 --
 xxen_util.display_flexfield_context(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category) receipt_attribute_category,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE1',msrov.row_id,msrov.attribute1) sr_receipt_attribute1,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE2',msrov.row_id,msrov.attribute2) sr_receipt_attribute2,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE3',msrov.row_id,msrov.attribute3) sr_receipt_attribute3,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE4',msrov.row_id,msrov.attribute4) sr_receipt_attribute4,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE5',msrov.row_id,msrov.attribute5) sr_receipt_attribute5,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE6',msrov.row_id,msrov.attribute6) sr_receipt_attribute6,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE7',msrov.row_id,msrov.attribute7) sr_receipt_attribute7,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE8',msrov.row_id,msrov.attribute8) sr_receipt_attribute8,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE9',msrov.row_id,msrov.attribute9) sr_receipt_attribute9,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE10',msrov.row_id,msrov.attribute10) sr_receipt_attribute10,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE11',msrov.row_id,msrov.attribute11) sr_receipt_attribute11,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE12',msrov.row_id,msrov.attribute12) sr_receipt_attribute12,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE13',msrov.row_id,msrov.attribute13) sr_receipt_attribute13,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE14',msrov.row_id,msrov.attribute14) sr_receipt_attribute14,
 xxen_util.display_flexfield_value(704,'MRP_SR_RECEIPT_ORG',msrov.attribute_category,'ATTRIBUTE15',msrov.row_id,msrov.attribute15) sr_receipt_attribute15,
 --
 xxen_util.display_flexfield_context(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category) ship_attribute_category,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE1',mssov.row_id,mssov.attribute1) sr_ship_attribute1,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE2',mssov.row_id,mssov.attribute2) sr_ship_attribute2,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE3',mssov.row_id,mssov.attribute3) sr_ship_attribute3,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE4',mssov.row_id,mssov.attribute4) sr_ship_attribute4,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE5',mssov.row_id,mssov.attribute5) sr_ship_attribute5,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE6',mssov.row_id,mssov.attribute6) sr_ship_attribute6,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE7',mssov.row_id,mssov.attribute7) sr_ship_attribute7,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE8',mssov.row_id,mssov.attribute8) sr_ship_attribute8,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE9',mssov.row_id,mssov.attribute9) sr_ship_attribute9,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE10',mssov.row_id,mssov.attribute10) sr_ship_attribute10,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE11',mssov.row_id,mssov.attribute11) sr_ship_attribute11,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE12',mssov.row_id,mssov.attribute12) sr_ship_attribute12,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE13',mssov.row_id,mssov.attribute13) sr_ship_attribute13,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE14',mssov.row_id,mssov.attribute14) sr_ship_attribute14,
 xxen_util.display_flexfield_value(704,'MRP_SR_SOURCE_ORG',mssov.attribute_category,'ATTRIBUTE15',mssov.row_id,mssov.attribute15) sr_ship_attribute15,
 -- ids
 mrs.sourcing_rule_id,
 msrov.sr_receipt_id,
 mssov.sr_source_id,
 --
 mssov.last_updated_by,
 mssov.last_update_date
from
 mrp_sourcing_rules mrs,
 mtl_parameters mp,
 mrp_sr_receipt_org_v msrov,
 mrp_sr_source_org_v mssov,
 ap_suppliers asu,
 ap_supplier_sites_all assa,
 hr_all_organization_units_vl haouv
where
 mp.organization_id (+) = mrs.organization_id and
 msrov.sourcing_rule_id (+) = mrs.sourcing_rule_id and
 mssov.sr_receipt_id (+) = msrov.sr_receipt_id and
 asu.vendor_id (+) = mssov.vendor_id and
 assa.vendor_site_id (+) = mssov.vendor_site_id and
 haouv.organization_id (+) = assa.org_id and
 (mrs.organization_id is null or
  mrs.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
 )
)
--
-- Main Query Starts Here
--
select
x.*
from
(
select /*+ push_pred(sr) */
 null action_,
 null status_,
 null message_,
 null request_id_,
 null modified_columns_,
 null sr_row_id,
 null ro_row_id,
 null so_row_id,
 :p_upload_mode upload_mode,
 -- sourcing rule
 sr.rule_name,
 sr.rule_description,
 sr.rule_type,
 sr.planning_active,
 sr.all_orgs,
 -- receiving organizations
 sr.receipt_organization,
 sr.receipt_customer,
 sr.receipt_address,
 sr.effective_date_from,
 sr.effective_date_to,
 -- shipping organization
 sr.source_type,
 sr.source_organization,
 sr.supplier,
 sr.supplier_number,
 sr.supplier_site,
 sr.supplier_site_op_unit,
 sr.allocation_percent,
 sr.rank,
 sr.ship_method,
 sr.intransit_time,
 -- attributes
 sr.rule_attribute_category,
 sr.sr_rule_attribute1,
 sr.sr_rule_attribute2,
 sr.sr_rule_attribute3,
 sr.sr_rule_attribute4,
 sr.sr_rule_attribute5,
 sr.sr_rule_attribute6,
 sr.sr_rule_attribute7,
 sr.sr_rule_attribute8,
 sr.sr_rule_attribute9,
 sr.sr_rule_attribute10,
 sr.sr_rule_attribute11,
 sr.sr_rule_attribute12,
 sr.sr_rule_attribute13,
 sr.sr_rule_attribute14,
 sr.sr_rule_attribute15,
 --
 sr.receipt_attribute_category,
 sr.sr_receipt_attribute1,
 sr.sr_receipt_attribute2,
 sr.sr_receipt_attribute3,
 sr.sr_receipt_attribute4,
 sr.sr_receipt_attribute5,
 sr.sr_receipt_attribute6,
 sr.sr_receipt_attribute7,
 sr.sr_receipt_attribute8,
 sr.sr_receipt_attribute9,
 sr.sr_receipt_attribute10,
 sr.sr_receipt_attribute11,
 sr.sr_receipt_attribute12,
 sr.sr_receipt_attribute13,
 sr.sr_receipt_attribute14,
 sr.sr_receipt_attribute15,
 --
 sr.ship_attribute_category,
 sr.sr_ship_attribute1,
 sr.sr_ship_attribute2,
 sr.sr_ship_attribute3,
 sr.sr_ship_attribute4,
 sr.sr_ship_attribute5,
 sr.sr_ship_attribute6,
 sr.sr_ship_attribute7,
 sr.sr_ship_attribute8,
 sr.sr_ship_attribute9,
 sr.sr_ship_attribute10,
 sr.sr_ship_attribute11,
 sr.sr_ship_attribute12,
 sr.sr_ship_attribute13,
 sr.sr_ship_attribute14,
 sr.sr_ship_attribute15,
 --
 null delete_option,
 -- ids
 sr.organization,
 sr.active,
 sr.sourcing_rule_id,
 sr.sr_receipt_id,
 sr.sr_source_id,
 to_number(null) group_id
from
 sr_query sr
where
 :p_include_global = :p_include_global and
 1=1
&not_use_first_block
&report_table_select
&report_table_name &report_table_where_clause
&processed_run
) x
order by
 x.rule_type,
 x.rule_name,
 nvl2(x.organization,2,1),
 x.organization,
 x.receipt_organization,
 x.rank,
 x.source_organization,
 x.supplier