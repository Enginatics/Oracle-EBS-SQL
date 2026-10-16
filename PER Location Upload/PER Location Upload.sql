/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Location Upload
-- Description: Upload to create, update, and delete HR Locations.
-- Supports all country-specific address styles with address field validation.
-- Includes site flags (Ship-To, Bill-To, Receiving, Office, Internal) with autocorrection for Ship-To and Receiving flags based on the Ship-To Location relationship.
-- Includes the Descriptive Flexfield attributes with validation.
-- Business group security restricts downloaded locations to the user's current business group plus global locations. New locations can optionally be made local by assigning the location to the user's current business group. If not assigned to a business group, the location is a global location.
-- Legal Address locations are protected from inactivation and deletion. The upload cannot set or change the Legal Address Flag. This is for information only.
-- By default, new locations are created with themselves as the ship to location (self-referencing)
-- The upload will automatically set the ship to site flag based on the ship to location. When the ship to site is self-referencing, the ship to flag and receiving flag are always set to Yes. If the ship to location references a different location, the ship to site flag will be set to No.
-- If the ship to site flag is set to Yes, the receiving site flag is also set to Yes. Otherwise, the receiving site flag will be set as specified in the upload excel.
-- Excel Example Output: https://www.enginatics.com/example/per-location-upload/
-- Library Link: https://www.enginatics.com/reports/per-location-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
hla.location_id,
hla.location_code,
hlat.description,
hla.inactive_date,
to_char(null) delete_location,
pbg.name business_group,
xxen_util.meaning(case when hla.legal_address_flag='Y' then 'Y' end,'YES_NO',0) legal_address_flag,
xxen_util.display_flexfield_context(800,'Address Location',hla.style) address_style,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'ADDRESS_LINE_1',hla.rowid,hla.address_line_1) address_line_1,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'ADDRESS_LINE_2',hla.rowid,hla.address_line_2) address_line_2,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'ADDRESS_LINE_3',hla.rowid,hla.address_line_3) address_line_3,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'TOWN_OR_CITY',hla.rowid,hla.town_or_city) town_or_city,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'REGION_1',hla.rowid,hla.region_1) region_1,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'REGION_2',hla.rowid,hla.region_2) region_2,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'REGION_3',hla.rowid,hla.region_3) region_3,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'POSTAL_CODE',hla.rowid,hla.postal_code) postal_code,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'COUNTRY',hla.rowid,hla.country) country,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'TELEPHONE_NUMBER_1',hla.rowid,hla.telephone_number_1) telephone_number_1,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'TELEPHONE_NUMBER_2',hla.rowid,hla.telephone_number_2) telephone_number_2,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'TELEPHONE_NUMBER_3',hla.rowid,hla.telephone_number_3) telephone_number_3,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'LOC_INFORMATION13',hla.rowid,hla.loc_information13) loc_information13,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'LOC_INFORMATION14',hla.rowid,hla.loc_information14) loc_information14,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'LOC_INFORMATION15',hla.rowid,hla.loc_information15) loc_information15,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'LOC_INFORMATION16',hla.rowid,hla.loc_information16) loc_information16,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'LOC_INFORMATION17',hla.rowid,hla.loc_information17) loc_information17,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'LOC_INFORMATION18',hla.rowid,hla.loc_information18) loc_information18,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'LOC_INFORMATION19',hla.rowid,hla.loc_information19) loc_information19,
xxen_util.display_flexfield_value(800,'Address Location',hla.style,'LOC_INFORMATION20',hla.rowid,hla.loc_information20) loc_information20,
hla2.location_code ship_to_location,
xxen_util.meaning(case when hla.ship_to_site_flag='Y' then 'Y' end,'YES_NO',0) ship_to_site_flag,
xxen_util.meaning(case when hla.receiving_site_flag='Y' then 'Y' end,'YES_NO',0) receiving_site_flag,
xxen_util.meaning(case when hla.bill_to_site_flag='Y' then 'Y' end,'YES_NO',0) bill_to_site_flag,
xxen_util.meaning(case when hla.office_site_flag='Y' then 'Y' end,'YES_NO',0) office_site_flag,
xxen_util.meaning(case when hla.in_organization_flag='Y' then 'Y' end,'YES_NO',0) in_organization_flag,
mp.organization_code inventory_organization,
ppf.full_name contact,
(select ftv.name from fnd_timezones_vl ftv where ftv.timezone_code=hla.timezone_code) timezone_code,
hla.ece_tp_location_code,
xxen_util.display_flexfield_context(800,'HR_LOCATIONS',hla.attribute_category) loc_attribute_category,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE1',hla.rowid,hla.attribute1) loc_attribute1,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE2',hla.rowid,hla.attribute2) loc_attribute2,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE3',hla.rowid,hla.attribute3) loc_attribute3,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE4',hla.rowid,hla.attribute4) loc_attribute4,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE5',hla.rowid,hla.attribute5) loc_attribute5,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE6',hla.rowid,hla.attribute6) loc_attribute6,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE7',hla.rowid,hla.attribute7) loc_attribute7,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE8',hla.rowid,hla.attribute8) loc_attribute8,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE9',hla.rowid,hla.attribute9) loc_attribute9,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE10',hla.rowid,hla.attribute10) loc_attribute10,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE11',hla.rowid,hla.attribute11) loc_attribute11,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE12',hla.rowid,hla.attribute12) loc_attribute12,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE13',hla.rowid,hla.attribute13) loc_attribute13,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE14',hla.rowid,hla.attribute14) loc_attribute14,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE15',hla.rowid,hla.attribute15) loc_attribute15,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE16',hla.rowid,hla.attribute16) loc_attribute16,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE17',hla.rowid,hla.attribute17) loc_attribute17,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE18',hla.rowid,hla.attribute18) loc_attribute18,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE19',hla.rowid,hla.attribute19) loc_attribute19,
xxen_util.display_flexfield_value(800,'HR_LOCATIONS',hla.attribute_category,'ATTRIBUTE20',hla.rowid,hla.attribute20) loc_attribute20,
to_number(null) upload_row
from
hr_locations_all hla,
hr_locations_all_tl hlat,
hr_locations_all hla2,
mtl_parameters mp,
per_all_people_f ppf,
per_business_groups pbg
where
1=1 and
nvl(hla.business_group_id,nvl(hr_general.get_business_group_id,-99))=nvl(hr_general.get_business_group_id,nvl(hla.business_group_id,-99)) and
hla.location_id=hlat.location_id and
hlat.language=userenv('lang') and
hla.ship_to_location_id=hla2.location_id(+) and
hla.inventory_organization_id=mp.organization_id(+) and
hla.designated_receiver_id=ppf.person_id(+) and
hla.business_group_id=pbg.business_group_id(+)
