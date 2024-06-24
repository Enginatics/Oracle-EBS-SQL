/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Lookup Upload
-- Description: This upload allows the user to
- download and update lookup codes against existing Lookup Types.
- add new lookup codes to existing Lookup Types.
- create new Lookup Types and upload the lookup codes against these new Lookup Types. 

The upload of FND Lookup Types and Lookup Codes is in the users current language.

Only User and Extensible Lookup Types can be maintained by this upload.
For Extensible Lookup Types, seeded Lookup Codes canot be updated.

For Creating/Updating Lookup Codes only against an existing Lookup Type, use template: 
Lookup Codes - Create/Update Lookup Codes only

For Creating New Lookup Types and/or updating Lookup Type level information, as well as the Lookup Codes, use  template:
Lookup Types - Create/Update Lookup Types and Codes
-- Excel Examle Output: https://www.enginatics.com/example/fnd-lookup-upload/
-- Library Link: https://www.enginatics.com/reports/fnd-lookup-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
to_char(null) mode_,
fltv.lookup_type,
fav1.application_name view_application,
fltv.meaning type_meaning,
fltv.description type_description,
fav2.application_name owning_application,
flvv.lookup_code,
flvv.meaning,
flvv.description,
flvv.tag,
xxen_util.meaning(flvv.enabled_flag,'YES_NO',0) enabled_flag,
flvv.start_date_active start_date_active,
flvv.end_date_active end_date_active,
flvv.attribute_category lookup_attribute_category,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE1',flvv.row_id,flvv.attribute1)  fnd_lkp_attribute1,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE2',flvv.row_id,flvv.attribute2)  fnd_lkp_attribute2,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE3',flvv.row_id,flvv.attribute3)  fnd_lkp_attribute3,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE4',flvv.row_id,flvv.attribute4)  fnd_lkp_attribute4,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE5',flvv.row_id,flvv.attribute5)  fnd_lkp_attribute5,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE6',flvv.row_id,flvv.attribute6)  fnd_lkp_attribute6,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE7',flvv.row_id,flvv.attribute7)  fnd_lkp_attribute7,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE8',flvv.row_id,flvv.attribute8)  fnd_lkp_attribute8,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE9',flvv.row_id,flvv.attribute9)  fnd_lkp_attribute9,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE10',flvv.row_id,flvv.attribute10)  fnd_lkp_attribute10,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE11',flvv.row_id,flvv.attribute11)  fnd_lkp_attribute11,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE12',flvv.row_id,flvv.attribute12)  fnd_lkp_attribute12,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE13',flvv.row_id,flvv.attribute13)  fnd_lkp_attribute13,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE14',flvv.row_id,flvv.attribute14)  fnd_lkp_attribute14,
xxen_util.display_flexfield_value(0,'FND_COMMON_LOOKUPS',flvv.attribute_category,'ATTRIBUTE15',flvv.row_id,flvv.attribute15)  fnd_lkp_attribute15,
flvv.territory_code,
fsg.security_group_key security_group,
fav1.application_short_name || ':' || fltv.lookup_type old_lookup_type_key,
flvv.lookup_code old_lookup_code
from
  fnd_lookup_types_vl  fltv,
  fnd_lookup_values_vl flvv,
  fnd_application_vl   fav1,
  fnd_application_vl   fav2,
  fnd_security_groups  fsg
where
    :p_mode in (xxen_upload.action_meaning(xxen_upload.action_create)||', '||xxen_upload.action_meaning(xxen_upload.action_update),xxen_upload.action_meaning(xxen_upload.action_update))
and fav1.application_name=:p_view_appl
and 1=1
and fltv.view_application_id   = fav1.application_id
and fltv.application_id        = fav2.application_id
and fltv.security_group_id     = fsg.security_group_id
and fltv.customization_level  in ('U','E')
and fltv.security_group_id     = fnd_global.security_group_id
and fltv.lookup_type           = flvv.lookup_type
and fltv.view_application_id   = flvv.view_application_id
and fltv.security_group_id     = flvv.security_group_id
&not_use_first_block
&report_table_select &report_table_name &report_table_where_clause &success_records
&processed_run
order by
 lookup_type,
 lookup_code