# Case Study & Technical Analysis: Blitz Report Template Sharing Upload

## Executive Summary
This upload manages who can see and use Blitz Report™ templates, the Excel layouts that run Oracle E-Business Suite reports. It lists each template with its owner and its sharing entries, and lets an administrator share a template with the whole site, with one responsibility, or with one named user, or remove an existing share. It is intended for the administrators who maintain a shared template library for finance, supply chain and HR users. Instead of opening the template setup form for each template, the administrator can review and change the sharing of many templates in one spreadsheet.

## Business Challenge
*   **Template sprawl:** Organizations build many report templates, and without sharing they stay visible only to their owners, so the same layouts are rebuilt by different teams.
*   **Scope of visibility:** A template is needed by one responsibility, by a single user or by everyone, and each level must be set deliberately.
*   **Consistent rules:** The site-wide share and the specific shares exclude each other, and changing one by hand can leave a template with conflicting entries.
*   **Audit of who shared what:** Administrators need to know when a share was created and by whom.

## The Solution
*   Lists every template from `XXEN_REPORT_TEMPLATES_V` with its report name, template name and owner, and joins each to its sharing entries from `XXEN_REPORT_TEMPLATE_SHARING_V`.
*   Shows the Sharing Level, the Shared With value and the owning application of a responsibility share, using the application name from `FND_APPLICATION_VL`.
*   Shows who created each share and when, with the user name and client time.
*   Supports creating new shares through an empty file, deleting existing shares, and copying a share to a different sharing level, with the upload applying the same rules as the template setup form.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_REPORT_TEMPLATES_V`: the Blitz Report templates, with report name, template name, owner and template identifier.
*   `XXEN_REPORT_TEMPLATE_SHARING_V`: the sharing entries of each template, with the sharing level, the level value and the creation details.
*   `FND_APPLICATION_VL`: the application that owns a responsibility, used to describe a responsibility share.

### Logical Relationships
1. `XXEN_REPORT_TEMPLATES_V` is outer joined to the sharing view on TEMPLATE_ID, so templates without any share still appear.
2. The sharing view's ID2 column is joined to `FND_APPLICATION_VL` on APPLICATION_ID, which supplies the Description column for responsibility shares.
3. When Create Empty File is Yes, the template branch returns no rows, so only a blank upload file is produced.
4. The upload writes the changed shares back by template and sharing level, and the site, responsibility and user levels are mutually exclusive for each template.

## Parameters & Filtering
*   **Upload Mode:** selects create with an empty file, or query and update of existing shares.
*   **Create Empty File:** when set to Yes, opens an empty file for entering new shares.
*   **Report Name starts with:** limits the templates to report names with the given prefix.
*   **Report Category:** limits the templates to one category.
*   **Sharing Level:** selects Site, Responsibility or User shares.
*   **Sharing Creation Date From** and **Sharing Creation Date To:** bound the date a share was created.

## Performance & Optimization
*   The template and sharing views are combined on TEMPLATE_ID with an outer join, so one query returns each template with all of its shares.
*   The application lookup is an outer join on the application identifier, so responsibility shares are described in the same query without a separate lookup.
*   The Create Empty File switch is part of the WHERE clause, so when it is Yes the report returns no existing template rows.
*   The sharing level and creation date parameters narrow the sharing entries that the report returns.

## FAQ
**Q: How do I share a Blitz Report template with one responsibility?**
A: Create a share with the Sharing Level set to Responsibility, enter the responsibility name in Shared With, and enter its owning application in Description.

**Q: What happens when I share a template with the whole site?**
A: The site share replaces any existing Responsibility or User shares of that template, because site sharing is mutually exclusive with specific shares.

**Q: Who created an existing share?**
A: The Created By and Creation Date columns show the user and the client time when the share was made.
