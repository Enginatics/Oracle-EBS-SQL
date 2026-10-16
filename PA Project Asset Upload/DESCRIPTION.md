# Case Study & Technical Analysis: PA Project Asset Upload

## Executive Summary
The PA Project Asset Upload creates, updates and deletes project assets, and their asset-to-task assignments, for capital projects in Oracle Projects. It uses the public Project Asset API, so the spreadsheet loads assets through the same business rules as the Capital Assets form. Capital accountants and project controllers use it to load estimated and as-built assets for a project in bulk, to link them to top tasks or leaf tasks, and to maintain their descriptive flexfield values. The report runs in Excel via Blitz Report. Capitalization and reversal are not supported by this upload and must still be performed in the Capital Assets form.

## Business Challenge
*   **Bulk asset loading:** Capital projects often carry many estimated or as-built assets, and entering them one at a time is slow and error-prone.
*   **Asset-to-task traceability:** Each asset must be assigned to the task that incurs its cost, so the assignments must be correct before capitalization.
*   **Asset attributes:** Depreciation, expense account, location, employee and descriptive flexfield values must be consistent with the Fixed Assets book and the chart of accounts.
*   **Workflow boundaries:** Capitalization and reversal are workflow actions that remain in the form, so the upload must be kept to asset setup.

## The Solution
*   **Two-level row model:** Each row is one asset and assignment pair, and blank assignment columns create only the asset header.
*   **Public API processing:** Assets and assignments are created or updated through the public Projects asset API.
*   **Assignment control:** Top-task rollup or leaf-task assignments can be added, and existing assignments can be deleted.
*   **Reference data resolution:** Asset category, asset key, location, depreciation expense account and assigned employee are shown with readable segment and person names.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_PROJECT_ASSETS_ALL`: the project asset header, including asset type, name, units, estimated and actual cost, dates and flags.
*   `PA_PROJECT_ASSET_ASSIGNMENTS`: the asset-to-task assignments, with their descriptive flexfield values.
*   `PA_PROJECTS_ALL`: the project number and name.
*   `PA_TASKS`: the assigned task, with the top task identifier used to flag rollup assignments.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of the project.
*   `FA_CATEGORIES_B_KFV`, `FA_ASSET_KEYWORDS_KFV`, `FA_LOCATIONS_KFV`, `FA_ADDITIONS_V`: asset category, asset key, location and parent asset in the Fixed Assets module.
*   `GL_CODE_COMBINATIONS_KFV`: the depreciation expense account.
*   `PER_ALL_PEOPLE_F`: the assigned employee, valid on the current date.

### Logical Relationships
1. `PA_PROJECTS_ALL` is joined to `HR_ALL_ORGANIZATION_UNITS_VL` on organization, and to `PA_PROJECT_ASSETS_ALL` on project identifier.
2. Only assets of type AS-BUILT or ESTIMATED are included.
3. `PA_PROJECT_ASSETS_ALL` is outer joined to `PA_PROJECT_ASSET_ASSIGNMENTS` on project asset identifier, and the assignment to `PA_TASKS` on task identifier.
4. The category, asset key and location are outer joined from the Fixed Assets key-flexfield views on their identifiers.
5. The parent asset is outer joined to `FA_ADDITIONS_V`, and the depreciation expense account to `GL_CODE_COMBINATIONS_KFV`.
6. The assigned employee is outer joined to `PER_ALL_PEOPLE_F` with the effective date condition on the current date.

## Parameters & Filtering
*   **Upload Mode:** Create or Create, Update, which controls whether existing assets can be changed by the upload.
*   **Operating Unit:** Filters the project list of values to the chosen operating unit.
*   **Project Number:** Identifies the capital project to which the uploaded assets belong.

The SQL text does not reference these parameters through bind variables; the description states that the operating unit filters the project list of values and the project number identifies the project.

## Performance & Optimization
*   The query is restricted to one project's operating unit through the joins from the project header, so it reads only that project's assets.
*   Asset type filtering on AS-BUILT and ESTIMATED is applied in the main predicate, which excludes other asset types before the lookups.
*   Key-flexfield and employee lookups are outer joins on keyed identifiers, and the employee join is limited to the valid date range of the current day.
*   The assignment outer join returns one row per assignment, so an asset with several tasks appears on several rows, as described in the upload notes.

## FAQ
**Q: Can this upload capitalize or reverse project assets?**
A: No. The description states that capitalization and reversal are not supported and must be done in the Capital Assets form.

**Q: How do I change the descriptive flexfield on an existing asset assignment?**
A: The assignment has no update API, so the description says to delete the assignment and add it again with the new values.

**Q: How do I assign one asset to several tasks in the same upload?**
A: Repeat the asset columns on subsequent rows with different Task Numbers, leaving the asset header columns populated on each row.
