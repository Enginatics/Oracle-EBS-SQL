/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Menu Entry Upload
-- Description: Upload to create, update and delete the entries of existing menus, as in the Menus form.
-- Upload Mode Create opens an empty sheet for new entries. Create, Update downloads the entries of the menus selected by the parameters; new rows can be added to the same file.
-- User Menu Name and Menu Name select the menu and default each other. An entry is identified by the menu and its Entry Sequence, which defaults to the next multiple of ten above the highest sequence of the menu. Changing the Entry Sequence of a downloaded row creates a new entry and keeps the old one; delete the old entry with Delete Record Yes.
-- Either Sub Menu or Function Name is required. A blank Grant Flag makes the entry not grantable.
-- Excel Example Output: https://www.enginatics.com/example/fnd-menu-entry-upload/
-- Library Link: https://www.enginatics.com/reports/fnd-menu-entry-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
fmv.user_menu_name,
fmv.menu_name,
fmv.description menu_description,
xxen_util.meaning(fmv.type,'MENU_TYPE',0) type,
fme.entry_sequence,
fmet.prompt,
fmv2.user_menu_name sub_menu,
fffv.user_function_name function_name,
fmet.description entry_description,
xxen_util.yes(fme.grant_flag) grant_flag,
to_char(null) delete_record,
row_number() over (order by fmv.menu_name, fme.entry_sequence) upload_row
from
fnd_menus_vl fmv,
fnd_menu_entries fme,
fnd_menu_entries_tl fmet,
fnd_menus_vl fmv2,
fnd_form_functions_vl fffv
where
1=1 and
fmv.menu_id=fme.menu_id and
fme.menu_id=fmet.menu_id and
fme.entry_sequence=fmet.entry_sequence and
fmet.language=userenv('lang') and
fme.sub_menu_id=fmv2.menu_id(+) and
fme.function_id=fffv.function_id(+)
