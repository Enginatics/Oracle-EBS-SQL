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
 mrs.attribute_category rule_attribute_category,
 mrs.attribute1 rule_attribute1,
 mrs.attribute2 rule_attribute2,
 mrs.attribute3 rule_attribute3,
 mrs.attribute5 rule_attribute4,
 mrs.attribute4 rule_attribute5,
 mrs.attribute6 rule_attribute6,
 mrs.attribute7 rule_attribute7,
 mrs.attribute8 rule_attribute8,
 mrs.attribute9 rule_attribute9,
 mrs.attribute10 rule_attribute10,
 mrs.attribute11 rule_attribute11,
 mrs.attribute12 rule_attribute12,
 mrs.attribute13 rule_attribute13,
 mrs.attribute14 rule_attribute14,
 mrs.attribute15 rule_attribute15,
 --
 msrov.attribute_category receipt_attribute_category,
 msrov.attribute1 receipt_attribute1,
 msrov.attribute2 receipt_attribute2,
 msrov.attribute3 receipt_attribute3,
 msrov.attribute4 receipt_attribute4,
 msrov.attribute5 receipt_attribute5,
 msrov.attribute6 receipt_attribute6,
 msrov.attribute7 receipt_attribute7,
 msrov.attribute8 receipt_attribute8,
 msrov.attribute9 receipt_attribute9,
 msrov.attribute10 receipt_attribute10,
 msrov.attribute11 receipt_attribute11,
 msrov.attribute12 receipt_attribute12,
 msrov.attribute13 receipt_attribute13,
 msrov.attribute14 receipt_attribute14,
 msrov.attribute15 receipt_attribute15,
 --
 mssov.attribute_category ship_attribute_category,
 mssov.attribute1 ship_attribute1,
 mssov.attribute2 ship_attribute2,
 mssov.attribute3 ship_attribute3,
 mssov.attribute4 ship_attribute4,
 mssov.attribute5 ship_attribute5,
 mssov.attribute6 ship_attribute6,
 mssov.attribute7 ship_attribute7,
 mssov.attribute8 ship_attribute8,
 mssov.attribute9 ship_attribute9,
 mssov.attribute10 ship_attribute10,
 mssov.attribute11 ship_attribute11,
 mssov.attribute12 ship_attribute12,
 mssov.attribute13 ship_attribute13,
 mssov.attribute14 ship_attribute14,
 mssov.attribute15 ship_attribute15,
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
 sr.rule_attribute1,
 sr.rule_attribute2,
 sr.rule_attribute3,
 sr.rule_attribute4,
 sr.rule_attribute5,
 sr.rule_attribute6,
 sr.rule_attribute7,
 sr.rule_attribute8,
 sr.rule_attribute9,
 sr.rule_attribute10,
 sr.rule_attribute11,
 sr.rule_attribute12,
 sr.rule_attribute13,
 sr.rule_attribute14,
 sr.rule_attribute15,
 --
 sr.receipt_attribute_category,
 sr.receipt_attribute1,
 sr.receipt_attribute2,
 sr.receipt_attribute3,
 sr.receipt_attribute4,
 sr.receipt_attribute5,
 sr.receipt_attribute6,
 sr.receipt_attribute7,
 sr.receipt_attribute8,
 sr.receipt_attribute9,
 sr.receipt_attribute10,
 sr.receipt_attribute11,
 sr.receipt_attribute12,
 sr.receipt_attribute13,
 sr.receipt_attribute14,
 sr.receipt_attribute15,
 --
 sr.ship_attribute_category,
 sr.ship_attribute1,
 sr.ship_attribute2,
 sr.ship_attribute3,
 sr.ship_attribute4,
 sr.ship_attribute5,
 sr.ship_attribute6,
 sr.ship_attribute7,
 sr.ship_attribute8,
 sr.ship_attribute9,
 sr.ship_attribute10,
 sr.ship_attribute11,
 sr.ship_attribute12,
 sr.ship_attribute13,
 sr.ship_attribute14,
 sr.ship_attribute15,
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