/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE Bank and Branch Upload
-- Description: CE Bank and Branch Upload
==========================
Creates or updates banks and bank branches in Oracle Cash Management (CE) using the ce_bank_pub API (TCA-based).

Each row represents one bank branch. If the bank does not exist it is created automatically. The branch is then created or updated within that bank.

Upload Mode
===========

Create
------
Opens an empty spreadsheet to enter new banks and branches.

Create, Update
--------------
Returns existing bank branches. Edit fields and re-upload to update.

Required Fields
===============
- Country: Country of the bank (e.g. United States, Australia).
- Bank Name: Name of the bank. Used together with Country to identify an existing bank.
- Branch Name: Name of the branch. Used together with Bank Name and Country to identify an existing branch.

Optional Fields
===============
- Bank Number: Routing or institution number for the bank.
- Short Bank Name: Abbreviated bank name.
- Alternate Bank Name: Phonetic or alternate-language bank name.
- Branch Number: Branch routing or BSB number.
- Branch Type: Routing/clearing type. Options: ABA, CHIPS, SWIFT, Other. Leave blank if not applicable.
- BIC / SWIFT Code: Bank Identifier Code (ISO 9362).
- EFT Number: Electronic Funds Transfer user number.
- Alternate Branch Name: Phonetic or alternate-language branch name.
- Description: Free text description of the branch.
- DFF Columns (Attribute Category, Attribute 1-24): Descriptive Flexfield segments on the branch party (HZ_PARTIES).

Notes
=====
- Bank is matched by Country + Bank Name (+ Bank Number if provided). If no match is found, a new bank is created.
- Branch is matched by Bank + Branch Name. If no match is found, a new branch is created within the bank.
- Bank fields (Short Bank Name, Alternate Bank Name) are only applied on bank creation, not on update.
- Country-specific routing number format validation is bypassed to allow loading data across all countries.
-- Excel Examle Output: https://www.enginatics.com/example/ce-bank-and-branch-upload/
-- Library Link: https://www.enginatics.com/reports/ce-bank-and-branch-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
to_char(null) row_id,
(select ft.territory_short_name from fnd_territories_vl ft where ft.territory_code=cbbv.bank_home_country) country,
cbbv.bank_name,
cbbv.bank_number,
cbbv.short_bank_name,
cbbv.bank_name_alt alternate_bank_name,
cbbv.bank_branch_name branch_name,
cbbv.branch_number,
xxen_util.meaning(cbbv.bank_branch_type,'BANK_BRANCH_TYPE',222) branch_type,
cbbv.eft_swift_code bic_swift_code,
cbbv.eft_user_number eft_number,
cbbv.bank_branch_name_alt alternate_branch_name,
cbbv.description,
hp.attribute_category,
hp.attribute1,
hp.attribute2,
hp.attribute3,
hp.attribute4,
hp.attribute5,
hp.attribute6,
hp.attribute7,
hp.attribute8,
hp.attribute9,
hp.attribute10,
hp.attribute11,
hp.attribute12,
hp.attribute13,
hp.attribute14,
hp.attribute15,
hp.attribute16,
hp.attribute17,
hp.attribute18,
hp.attribute19,
hp.attribute20,
hp.attribute21,
hp.attribute22,
hp.attribute23,
hp.attribute24,
hpb.attribute_category bank_attribute_category,
hpb.attribute1 bank_attribute1,
hpb.attribute2 bank_attribute2,
hpb.attribute3 bank_attribute3,
hpb.attribute4 bank_attribute4,
hpb.attribute5 bank_attribute5,
hpb.attribute6 bank_attribute6,
hpb.attribute7 bank_attribute7,
hpb.attribute8 bank_attribute8,
hpb.attribute9 bank_attribute9,
hpb.attribute10 bank_attribute10,
hpb.attribute11 bank_attribute11,
hpb.attribute12 bank_attribute12,
hpb.attribute13 bank_attribute13,
hpb.attribute14 bank_attribute14,
hpb.attribute15 bank_attribute15,
hpb.attribute16 bank_attribute16,
hpb.attribute17 bank_attribute17,
hpb.attribute18 bank_attribute18,
hpb.attribute19 bank_attribute19,
hpb.attribute20 bank_attribute20,
hpb.attribute21 bank_attribute21,
hpb.attribute22 bank_attribute22,
hpb.attribute23 bank_attribute23,
hpb.attribute24 bank_attribute24
from
ce_bank_branches_v cbbv,
hz_parties hp,
hz_parties hpb
where
1=1 and
cbbv.branch_party_id=hp.party_id and
cbbv.bank_party_id=hpb.party_id