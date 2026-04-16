/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Menu Entry Upload
-- Description: Upload to create, update and delete menu entries in FND Menus.
Useful for adding entries to existing menus, e.g. during Supply Chain Hub installation.

Upload Modes
============

Create
------
Opens an empty spreadsheet where the user can enter new menu entries.

Create, Update
--------------
Downloads existing menu entries matching the Menu Name filter for review and update.
New rows can be added to create additional entries in the same upload.

Fields
======
- User Menu Name: Display-only. Shows the translatable menu name.
- Menu Name: Required. The internal menu name (e.g. INV_NAVIGATE).
- Entry Sequence: The sequence number for the entry within the menu. Auto-assigned if not provided for new entries.
- Prompt: The display text shown in the menu for this entry.
- Entry Description: Optional description of the menu entry.
- Sub Menu: The sub-menu to navigate to. Either Sub Menu or Function Name must be specified.
- Function Name: The form function to launch. Either Sub Menu or Function Name must be specified.
- Grant Flag: Y (default) = entry is grantable via security, N = not grantable.
- Delete Record: Set to Y to delete an existing menu entry.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-menu-entry-upload/
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
xxen_util.meaning(fme.grant_flag,'YES_NO',0) grant_flag,
to_char(null) delete_record
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