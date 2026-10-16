# Case Study & Technical Analysis: FND OAF Personalizations

## Executive Summary
This report lists Oracle Application Framework (OAF) page personalizations stored in the Metadata Services (MDS) repository, with the level at which each one applies and the page it customizes. Application developers, technical consultants and upgrade teams use it to see which pages are personalized, by whom and at which level, before an upgrade or a migration to another instance. It runs in Excel through Blitz Report™.

## Business Challenge
*   **Hidden customization:** OAF personalizations change how pages look and behave for a responsibility, user, operating unit or function, but they are stored in the repository and not visible in the forms.
*   **Upgrade impact:** Before a patch or upgrade, the personalizations of each page must be known so that they can be retested.
*   **Migration:** Personalizations are moved between instances as documents, and the team needs a list of the documents to export.
*   **Governance:** Administrators need to know who created or last changed a personalization and when.

## The Solution
*   Lists each personalization document with its path, the base document it customizes and the personalization level.
*   Resolves the level value to a readable name, such as the responsibility name, user name, operating unit name or function name.
*   Shows the creator, creation date, last updater and last update date of each document, with user identifiers converted to user names where possible.
*   Filters by level, by text contained in the document and by the last update date, so that recent or specific personalizations can be reviewed.

## Technical Architecture (High Level)
### Primary Tables
*   `JDR_PATHS`: the repository path tree, where each document is a path of type DOCUMENT with its name and owner.
*   `JDR_COMPONENTS`: the components that make up each document, identified here by the customization element.
*   `JDR_ATTRIBUTES`: the attributes of each path, including the base document a customization applies to.
*   `FND_RESPONSIBILITY_VL`, `FND_USER`, `HR_ALL_ORGANIZATION_UNITS_VL` and `FND_FORM_FUNCTIONS_VL`: the names of the responsibility, user, operating unit and function that a level value identifies.
*   `DUAL`: used to obtain the root document identifier.

### Logical Relationships
1.  The path tree is walked from the top path named customizations, following the parent-child links of `JDR_PATHS`.
2.  The full document name is built by joining the root document name to the path of each document.
3.  Documents are kept only where the path is a document and its identifier is a customization component of sequence zero in `JDR_COMPONENTS`.
4.  The base document of each personalization is read from its customizes attribute in `JDR_ATTRIBUTES`.
5.  The personalization level and level value are extracted from the document path, and the level value is matched to the responsibility, user, organization or function that it identifies.
6.  Creator and last updater identifiers are converted to user names where they are numeric, and the results are ordered by base document, level and level name.

## Parameters & Filtering
*   **Level:** restricts the output to one personalization level, such as responsibility, user, organization or function.
*   **Document contains:** restricts the output to personalization documents whose content matches the text entered.
*   **Last Update Date From:** restricts the output to personalizations updated on or after the date given.

## Performance & Optimization
*   The hierarchical query over `JDR_PATHS` starts at the customizations path and follows the parent links, so it reads only the subtree of personalizations rather than the whole repository.
*   The document filter on `JDR_COMPONENTS` is a semi-join on the component identifier, which avoids repeating the path walk for each component.
*   The level name is resolved by a correlated subquery against the matching table for each row, so the cost grows with the number of personalizations listed.
*   Filtering by level and date before the export keeps the list manageable on instances with many personalized pages.

## FAQ
**Q: How can an OAF personalization be exported for migration?**
A: The document can be exported with the JDRUTILS.printDocument procedure or with the XMLExporter utility, using the document path shown in the report.

**Q: What does the Level Name column show?**
A: It shows the responsibility name, user name, operating unit name or function name that the level value identifies, or the stored level value itself where it is not an identifier, for example for localization or portlet levels.

**Q: Which pages does a personalization apply to?**
A: The Base Document column shows the page or region that the personalization customizes, taken from the customizes attribute of the document.
