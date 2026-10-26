/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: JTF Salesperson Upload
-- Description: Creates and updates salespersons as in the Resources form of Resource Manager (Receivables > Setup > Transactions > Salespersons): the resource, its salesperson in an operating unit, and the salesperson territories.
-- A row updates the salesperson with the Salesperson Number in the Operating Unit, or the salesperson of the same resource in that operating unit, which is then renumbered. Otherwise it creates the salesperson. A new salesperson uses the resource of the Resource Number, or else the employee resource of the Employee Number or the resource of the Category and Resource Name, and creates that resource when it does not exist. Only resources of category Employee or Other are created; resources of other categories must exist.
-- Resource Name, Resource Start Date and Resource End Date apply to the resource and so to its salespersons in every operating unit.
-- Each row carries one territory. Enter further territories of a salesperson on further rows; a territory is end-dated with its Territory End Date, not deleted.
-- Excel Example Output: https://www.enginatics.com/example/jtf-salesperson-upload/
-- Library Link: https://www.enginatics.com/reports/jtf-salesperson-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
jrrev.resource_number,
jov.name category,
jrrev.resource_name,
jrrev.start_date_active resource_start_date,
jrrev.end_date_active resource_end_date,
(select papf.employee_number from per_all_people_f papf where jrrev.category='EMPLOYEE' and jrrev.source_id=papf.person_id and trunc(sysdate) between papf.effective_start_date and papf.effective_end_date) employee_number,
hou.name operating_unit,
jrs.salesrep_number salesperson_number,
ost.name sales_credit_type,
jrs.start_date_active start_date,
jrs.end_date_active end_date,
jrs.email_address email,
xxen_util.yes(decode(jrs.sales_tax_inside_city_limits,'1','Y')) inside_city_limits,
jrs.sales_tax_geocode geo_override,
xxen_util.yes(decode(jrs.status,'I',null,'Y')) active_for_receivables,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where jrs.gl_id_freight=gcck.code_combination_id) freight_account,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where jrs.gl_id_rev=gcck.code_combination_id) revenue_account,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where jrs.gl_id_rec=gcck.code_combination_id) receivable_account,
rtk.concatenated_segments territory,
rtk.name territory_name,
rst.start_date_active territory_start_date,
rst.end_date_active territory_end_date,
xxen_util.display_flexfield_context(690,'JTF_RS_SALESREPS',jrs.attribute_category) srp_attribute_category,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE1',jrs.rowid,jrs.attribute1) srp_attribute1,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE2',jrs.rowid,jrs.attribute2) srp_attribute2,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE3',jrs.rowid,jrs.attribute3) srp_attribute3,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE4',jrs.rowid,jrs.attribute4) srp_attribute4,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE5',jrs.rowid,jrs.attribute5) srp_attribute5,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE6',jrs.rowid,jrs.attribute6) srp_attribute6,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE7',jrs.rowid,jrs.attribute7) srp_attribute7,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE8',jrs.rowid,jrs.attribute8) srp_attribute8,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE9',jrs.rowid,jrs.attribute9) srp_attribute9,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE10',jrs.rowid,jrs.attribute10) srp_attribute10,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE11',jrs.rowid,jrs.attribute11) srp_attribute11,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE12',jrs.rowid,jrs.attribute12) srp_attribute12,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE13',jrs.rowid,jrs.attribute13) srp_attribute13,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE14',jrs.rowid,jrs.attribute14) srp_attribute14,
xxen_util.display_flexfield_value(690,'JTF_RS_SALESREPS',jrs.attribute_category,'ATTRIBUTE15',jrs.rowid,jrs.attribute15) srp_attribute15,
to_number(null) upload_row
from
hr_operating_units hou,
jtf_rs_salesreps jrs,
jtf_rs_resource_extns_vl jrrev,
jtf_objects_vl jov,
oe_sales_credit_types ost,
ra_salesrep_territories rst,
ra_territories_kfv rtk
where
1=1 and
hou.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='OU') and
hou.organization_id=jrs.org_id and
jrs.resource_id=jrrev.resource_id and
jrrev.category=jov.object_code and
jrs.sales_credit_type_id=ost.sales_credit_type_id and
jrs.salesrep_id=rst.salesrep_id(+) and
rst.territory_id=rtk.territory_id(+)
