# Case Study & Technical Analysis: FND Responsibility Upload

## Executive Summary
The FND Responsibility Upload report creates and updates Oracle E-Business Suite responsibilities, and maintains their menu and function exclusions. It replicates the System Administrator Responsibilities form (FNDSCRSP) in a spreadsheet. System administrators and security administrators use it when a new responsibility must be set up for many users or applications, when a responsibility's data group, menu or request group must change, or when exclusions must be applied. Because each row is either a responsibility definition or an exclusion, one file can carry an entire responsibility set-up, provided the rows are ordered correctly.

## Business Challenge
*   **Responsibility sprawl:** Large implementations need many responsibilities across applications, and defining each one in the form is slow and error-prone.
*   **Consistent access design:** Responsibilities must carry the right data group, menu, request group and effective dates, and a spreadsheet makes these attributes reviewable before they are loaded.
*   **Restricting menus and functions:** Exclusions remove functions or menus from a responsibility's menu, and many exclusions often apply across several responsibilities.
*   **Controlled retirement:** Responsibilities should not be deleted, since this affects audit history, so teams need a documented way to retire them.

## The Solution
*   **Two row types in one file:** Each row is either a Responsibility definition or a Menu/Function Exclusion, selected in the Row Type column.
*   **Create or update by key:** A responsibility is identified by application and responsibility key. It is created when that combination does not exist, and otherwise updated.
*   **Exclusion management:** Exclusion rows add a function or menu exclusion to a responsibility, and an Exclude flag removes one.
*   **Safe retirement:** Responsibilities are never deleted by the upload. Setting an Effective Date To disables a responsibility, which matches Oracle best practice.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_RESPONSIBILITY`: the responsibility definition, with its key, data group, menu, request group, dates and web host and agent names.
*   `FND_RESPONSIBILITY_TL`: the translated responsibility name and description, read in the session language.
*   `FND_APPLICATION_VL`: the owning application, used for the responsibility and for the data group and request group applications.
*   `FND_DATA_GROUPS_STANDARD_VIEW`: the data group assigned to the responsibility.
*   `FND_MENUS_VL`: the menu assigned to the responsibility, and the menu name used for menu exclusions.
*   `FND_REQUEST_GROUPS`: the request group assigned to the responsibility.
*   `FND_RESP_FUNCTIONS`: the exclusion rules for each responsibility, with rule type and action ID.
*   `FND_FORM_FUNCTIONS_VL`: the function name used for function exclusions.

### Logical Relationships
1.  The Responsibility branch joins `FND_RESPONSIBILITY` to its translation, its application, its data group, its menu and its application for the data group.
2.  The request group is outer joined to `FND_REQUEST_GROUPS`, with its application outer joined to `FND_APPLICATION_VL`, so responsibilities without a request group still appear.
3.  The Exclusion branch joins `FND_RESP_FUNCTIONS` to the responsibility on application and responsibility ID, and to the responsibility's translation and application.
4.  The exclusion name is resolved by a CASE expression: a function name for function rules and a menu name for menu rules.
5.  The two branches are combined with UNION ALL, and a row number orders the output so that Responsibility rows come before their exclusion rows.

## Parameters & Filtering
*   **Upload Mode:** Create returns an empty template. Create, Update returns existing responsibilities and their exclusions for review.
*   **Application:** Restricts the responsibilities to one owning application.
*   **Responsibility Name:** Narrows the list to a responsibility by name.

## Performance & Optimization
*   **Language filter on translations:** Responsibility names and descriptions are read in the session language, which keeps one translation per responsibility.
*   **Outer joins for optional attributes:** Request groups and their applications are outer joined, so responsibilities without a request group are not removed.
*   **Scalar name resolution:** Exclusion names are resolved with scalar subqueries against the function and menu views, so each exclusion row reads one name.
*   **Ordered row numbering:** The row number is generated over the combined result, which gives the upload its sequence, with Responsibility rows placed first.

## FAQ
**Q: How do I rename a responsibility in the upload?**
A: Change its Name. The Responsibility Key is the stable identifier and cannot be edited once the responsibility is created.
**Q: How do I add exclusions to a new responsibility in the same file?**
A: Place the Responsibility row before its exclusion rows, so the responsibility exists when the exclusions are applied.
**Q: Can this upload delete a responsibility?**
A: No. Set an Effective Date To to disable the responsibility, as the description recommends.
