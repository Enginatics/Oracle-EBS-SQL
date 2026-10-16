# Case Study & Technical Analysis: FND Menu Entry Upload

## Executive Summary
FND Menu Entry Upload creates, updates and deletes the entries of Oracle Application Object Library menus, the navigation structures that connect responsibilities to forms and sub-menus. It is designed for EBS implementation and security teams who must add many menu entries at once, for example when a module such as Supply Chain Hub is installed and new functions need to appear on existing menus. The template downloads the entries of matching menus, lets the user add or change rows in Excel, and applies the changes through the menu entry API.

## Business Challenge
*   **Manual Menu Configuration:** Adding a set of functions to a menu through the Menus form requires one entry at a time, with the sequence and prompt set by hand.
*   **Consistent Navigation:** Users of the same responsibility need the same entries in the same order, and inconsistent sequences make navigation confusing.
*   **Installation Projects:** Module installations often require a defined list of entries to be added to seeded menus, and that list must be reproducible across environments.
*   **Clean Up:** Obsolete entries must be removed in a controlled way, without editing the menu record by hand.

## The Solution
*   **Menu Entry Extract:** The template downloads each menu entry with its menu name, user menu name, sequence, prompt and description, so existing entries can be reviewed before changes.
*   **Sub Menu or Function Choice:** Each row names either a sub-menu or a form function, which the upload uses to attach the entry to the menu.
*   **Grant Control:** The grant flag decides whether the entry is available to security grants, with Y as the default.
*   **Deletion Flag:** A delete column removes an existing entry when set to Y, so cleanup uses the same template as creation.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_MENUS_VL`: the menu definitions, including the menu name, user menu name and menu type. It is read for both the parent menu and the referenced sub-menu.
*   `FND_MENU_ENTRIES`: the entries of each menu, with the sequence, the function or sub-menu reference and the grant flag.
*   `FND_MENU_ENTRIES_TL`: the translated prompt and description of each entry.
*   `FND_FORM_FUNCTIONS_VL`: the form functions that an entry can launch, with their user function names.

### Logical Relationships
1.  Each row of `FND_MENUS_VL` is joined to its entries in `FND_MENU_ENTRIES` on the menu identifier.
2.  Each entry is joined to `FND_MENU_ENTRIES_TL` on the menu identifier and entry sequence, restricted to the session language.
3.  The sub-menu reference is outer joined back to `FND_MENUS_VL`, so the user menu name of the sub-menu is returned.
4.  The function reference is outer joined to `FND_FORM_FUNCTIONS_VL`, so the user function name is returned for function entries.
5.  Rows are numbered by menu name and entry sequence to give each row a stable position in the template.

## Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update. In Create and Update mode the existing entries of the selected menus are downloaded.
*   **User Menu Name:** Filters the menus by their translated name.
*   **Menu Name:** Filters the menus by their internal name, such as the seeded navigation menu code.
*   **Function Name and User Function Name:** Restrict the entries to those launching a given form function.
*   **Responsibility:** Selects the menu attached to a responsibility, so the entries of that responsibility can be maintained.

## Performance & Optimization
*   **Menu Scoped Extract:** The menu filters are applied to the menu view first, so only entries of the chosen menus are read.
*   **Language Restriction:** The translation join is limited to the session language, which keeps one prompt per entry.
*   **Outer Joins for Entries:** Sub-menu and function references are outer joined, because an entry has one or the other and not both.
*   **Create Mode Template:** In Create mode the download is suppressed, so the sheet is empty and no existing entries are read.

## FAQ
**Q: Which fields are required for a new menu entry?**
A: A menu name, an entry sequence if you want to control order, a prompt, and either a sub-menu or a function name.

**Q: Can I remove an entry with this template?**
A: Yes. Set the Delete Record column to Y on the downloaded row of the entry.

**Q: What does the Grant Flag control?**
A: It controls whether the entry is grantable through security. Y is the default, and N makes the entry not grantable.
