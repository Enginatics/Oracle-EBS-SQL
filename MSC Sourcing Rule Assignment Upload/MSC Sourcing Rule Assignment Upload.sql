/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Sourcing Rule Assignment Upload
-- Description: MSC Sourcing Rule Assignment Upload
=============================
- Upload new Assignment Sets and Sourcing Rule Assignments
- Update Existing Assignment Sets and Sourcing Rule Assignments

Notes:
If an Assignment Organization is specified, then this determines the selecatable items. 
If an Assignment Organization is not specified, then the Master Organization determines the selectable Items.
The selectable Assignment Organizations is not restricted by the Master Organization. 
This is the same logic as used in the Sourcing Assignments form

-- Excel Examle Output: https://www.enginatics.com/example/msc-sourcing-rule-assignment-upload/
-- Library Link: https://www.enginatics.com/reports/msc-sourcing-rule-assignment-upload/
-- Run Report: https://demo.enginatics.com/

with sra_query as
(
select
 -- assignment set
 mas.assignment_set_name assignment_set,
 mas.description assignment_set_description,
 -- assignment
 case msav.assignment_type
 when 1 then 'Instance'
 when 2 then 'Category'
 when 3 then 'Item-Instance'
 when 4 then 'Instance-Organization'
 when 5 then 'Category-Instance-Organization'
 when 6 then 'Item-Instance-Organization'
 when 8 then 'Category-Instance-Region'
 when 7 then 'Instance-Region'
 when 9 then 'Item-Instance-Region'
 end assignment_type,
 decode(msav.assignment_type,3,null,msc_get_name.org_code(msav.organization_id, msav.sr_instance_id)) organization,
 msav.organization_code organization_code,
 case when msav.assignment_type in (3,6,9)
 then msav.entity_name
 else null
 end item,
 case when msav.assignment_type in (2,5,8)
 then msav.entity_name
 else null
 end category,
 msav.description description,
 msav.customer_name,
 hca.partner_number customer_number,
 hcsua.location customer_site,
 xxen_util.meaning(hcsua.tp_site_code,'SITE_USE_CODE',222) customer_site_use,
 msav.ship_to_address,
 hcsua.operating_unit_name customer_site_ou,
 msav.sourcing_rule_type_text sourcing_rule_type,
 msav.sourcing_rule_name,
 mp.organization_code sourcing_rule_org,
 msav.item_type_value_text condition,
 --
 case
 when mr.region_id is null then null
 when mr.zone is not null then 'Zone'
 else 'Region'
 end zone_or_region,
 mr.zone,
 mr.country region_country,
 mr.state region_state,
 mr.city region_city,
 mr.postal_code_from region_postal_code_from,
 mr.postal_code_to region_postal_code_to,
 msav.region_code region_zone_description,
 -- attributes
 mas.attribute_category set_attribute_category,
 mas.attribute1 set_attribute1,
 mas.attribute2 set_attribute2,
 mas.attribute3 set_attribute3,
 mas.attribute4 set_attribute4,
 mas.attribute5 set_attribute5,
 mas.attribute6 set_attribute6,
 mas.attribute7 set_attribute7,
 mas.attribute8 set_attribute8,
 mas.attribute9 set_attribute9,
 mas.attribute10 set_attribute10,
 mas.attribute11 set_attribute11,
 mas.attribute12 set_attribute12,
 mas.attribute13 set_attribute13,
 mas.attribute14 set_attribute14,
 mas.attribute15 set_attribute15,
 --
 msav.attribute_category assign_attribute_category,
 msav.attribute1 assign_attribute1,
 msav.attribute2 assign_attribute2,
 msav.attribute3 assign_attribute3,
 msav.attribute4 assign_attribute4,
 msav.attribute5 assign_attribute5,
 msav.attribute6 assign_attribute6,
 msav.attribute7 assign_attribute7,
 msav.attribute8 assign_attribute8,
 msav.attribute9 assign_attribute9,
 msav.attribute10 assign_attribute10,
 msav.attribute11 assign_attribute11,
 msav.attribute12 assign_attribute12,
 msav.attribute13 assign_attribute13,
 msav.attribute14 assign_attribute14,
 msav.attribute15 assign_attribute15,
 --
 xxen_util.meaning(nvl(mas.collected_flag,2),'SYS_YES_NO',700) set_collected_flag,
 xxen_util.meaning(nvl(msav.collected_flag,2),'SYS_YES_NO',700) collected_flag,
 -- ids
 mas.sr_instance_id,
 mas.assignment_set_id,
 msav.assignment_id,
 msav.sourcing_rule_id,
 msav.assignment_type assignment_type_id,
 --
 msav.last_updated_by,
 msav.last_update_date
from
 msc_assignment_sets mas,
 msc_sr_assignments_v msav,
 msc_sourcing_rules msr,
 msc_trading_partners mp,
 msc_trading_partners hca,
 msc_trading_partner_sites hcsua,
 msc_regions mr
where
 mas.sr_instance_id = :p_sr_instance_id and
 mas.assignment_set_id = msav.assignment_set_id and
 mas.sr_instance_id = msav.sr_assignment_instance_id and
 msav.sourcing_rule_id = msr.sourcing_rule_id (+) and
 msav.sr_assignment_instance_id = msr.sr_instance_id (+) and
 --
 msr.sr_instance_id = mp.sr_instance_id (+) and
 msr.organization_id = mp.sr_tp_id (+) and
 mp.partner_type (+) = 3 and
 --
 msav.sr_assignment_instance_id = hca.sr_instance_id (+) and
 msav.customer_id = hca.partner_id (+) and
 hca.partner_type (+) = 2 and
 msav.sr_assignment_instance_id = hcsua.sr_instance_id (+) and
 msav.ship_to_site_id = hcsua.partner_site_id (+) and
 hcsua.partner_type (+) = 2 and
 msav.sr_assignment_instance_id = mr.sr_instance_id (+) and
 msav.region_id = mr.region_id (+)
)
--
-- Main Query Starts Here
--
select
x.*
from
(
select /*+ push_pred(sra) */
 null action_,
 null status_,
 null message_,
 null request_id_,
 null modified_columns_,
 null set_row_id,
 null ass_row_id,
 :p_upload_mode upload_mode,
 :p_sr_instance_code instance,
 -- assignment set
 sra.assignment_set,
 sra.assignment_set_description,
 -- assignment
 sra.assignment_type,
 sra.organization,
 sra.item,
 sra.category,
 sra.description,
 sra.customer_name,
 sra.customer_number,
 sra.customer_site,
 sra.customer_site_use,
 sra.customer_site_ou,
 sra.ship_to_address,
 --
 sra.zone_or_region,
 sra.zone,
 sra.region_country,
 sra.region_state,
 sra.region_city,
 sra.region_postal_code_from,
 sra.region_postal_code_to,
 --
 sra.sourcing_rule_type,
 sra.sourcing_rule_name,
 sra.sourcing_rule_org,
 sra.condition,
 -- attributes
 sra.set_attribute_category,
 sra.set_attribute1,
 sra.set_attribute2,
 sra.set_attribute3,
 sra.set_attribute4,
 sra.set_attribute5,
 sra.set_attribute6,
 sra.set_attribute7,
 sra.set_attribute8,
 sra.set_attribute9,
 sra.set_attribute10,
 sra.set_attribute11,
 sra.set_attribute12,
 sra.set_attribute13,
 sra.set_attribute14,
 sra.set_attribute15,
 --
 sra.assign_attribute_category,
 sra.assign_attribute1,
 sra.assign_attribute2,
 sra.assign_attribute3,
 sra.assign_attribute4,
 sra.assign_attribute5,
 sra.assign_attribute6,
 sra.assign_attribute7,
 sra.assign_attribute8,
 sra.assign_attribute9,
 sra.assign_attribute10,
 sra.assign_attribute11,
 sra.assign_attribute12,
 sra.assign_attribute13,
 sra.assign_attribute14,
 sra.assign_attribute15,
 --
 null delete_option,
 sra.collected_flag,
 -- ids
 sra.sr_instance_id,
 sra.assignment_set_id,
 sra.assignment_id,
 sra.sourcing_rule_id,
 sra.assignment_type_id,
 :p_master_org_id master_organization_id
from
 sra_query sra
where
 :p_master_org_code is not null and
 1=1
&not_use_first_block
&report_table_select
&report_table_name &report_table_where_clause
&processed_run
) x
order by
 x.assignment_set,
 x.assignment_type_id,
 x.organization,
 nvl(x.item,x.category),
 x.customer_name,
 x.customer_site,
 x.zone,
 x.region_country,
 x.region_state,
 x.region_city,
 x.region_postal_code_from,
 x.region_postal_code_to,
 x.sourcing_rule_name