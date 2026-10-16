# Case Study & Technical Analysis: PER Location Upload

## Executive Summary
The PER Location Upload report creates, updates and deletes HR Locations in Oracle E-Business Suite Human Resources from a spreadsheet. HR locations hold the physical addresses of offices, sites and buildings, and they are used across HR, Payroll, Projects and Inventory. HR administrators and implementation teams use the upload to load a new location set, to correct addresses in bulk and to set the site flags that govern shipping, receiving, billing and office use. It supports the address formats of each country and validates address fields against the style that applies.

## Business Challenge
*   **Address accuracy across countries:** Each country uses its own address layout, and a location loaded in the wrong style produces unusable addresses.
*   **Site flag consistency:** Ship-to, receiving, bill-to, office, internal and inventory organization flags interact, and an inconsistent combination breaks downstream processes.
*   **Multi-business-group security:** Locations must be visible to the right business group, while global locations are shared, so the scope of each row must be clear.
*   **Legal address protection:** Legal address locations must not be inactivated or deleted, and the upload must not change their legal status.

## The Solution
*   **Style-aware address fields:** Address fields are shown under the address style of each location, with the country-specific labels.
*   **Automatic ship-to and receiving logic:** The ship-to site flag is derived from the ship-to location relationship, and the receiving site flag follows the ship-to setting.
*   **Business group scope:** Locations are restricted to the current business group plus global locations, and a new location can be made local to the current business group.
*   **Protected records:** Legal address locations cannot be inactivated or deleted by the upload, and the legal flag is information only.

## Technical Architecture (High Level)
### Primary Tables
*   `HR_LOCATIONS_ALL`: the location record, with its code, inactive date, address style, address lines, site flags, timezone and flexfield attributes.
*   `HR_LOCATIONS_ALL_TL`: the translated location description, read in the session language.
*   `MTL_PARAMETERS`: the inventory organization linked to the location.
*   `PER_ALL_PEOPLE_F`: the designated receiver, shown as the contact.
*   `PER_BUSINESS_GROUPS`: the business group name.
*   `FND_TIMEZONES_VL`: the timezone name for the location's timezone code.

### Logical Relationships
1.  `HR_LOCATIONS_ALL` is joined to `HR_LOCATIONS_ALL_TL` on the location ID, restricted to the session language.
2.  The ship-to location is found by a second, outer joined reference to `HR_LOCATIONS_ALL` through the ship-to location ID, so the ship-to code can be shown.
3.  The inventory organization, designated receiver and business group are outer joined, so locations without them still appear.
4.  The business group filter keeps locations whose business group matches the current business group, or that are global, using the HR general business group function.
5.  The timezone name is read through a scalar subquery on the timezone code.

## Parameters & Filtering
*   **Upload Mode:** Selects create, update or delete behaviour for the downloaded locations.
*   **Default Address Style:** Sets the address style used for new locations.
*   **Location Name and Location Name Like:** Find a location by exact name or by part of the name.
*   **Location Status:** Restricts the output to active or inactive locations.
*   **Country:** Limits the locations to one country.
*   **Global:** Shows global locations, which are not assigned to a business group.
*   **Legal Address, Bill To Site, Ship To Site, Receiving Site, Internal Site and Office Site:** Filter the locations by their flags.

## Performance & Optimization
*   **Business group filter in the WHERE clause:** The business group test is applied to every location row, which limits the output to the current business group and global locations.
*   **Language restriction on descriptions:** The description join is restricted to the session language, so each location has one description row.
*   **Outer joins for optional links:** Ship-to location, inventory organization, receiver and business group are outer joined, so locations with none of these still appear.
*   **Flexfield display functions:** Address and location flexfield values are resolved through display functions, which add per-row calls on wide address styles.

## FAQ
**Q: Can I delete a legal address location with this upload?**
A: No. Legal address locations are protected from inactivation and deletion, and the upload cannot set or change the legal address flag.
**Q: Why does a new location show a receiving site flag of Yes?**
A: By default a new location is its own ship-to location. When the ship-to site is self-referencing, the ship-to flag and receiving flag are both set to Yes.
**Q: Which locations appear in the download?**
A: Locations in the current business group and global locations, so locations in other business groups are not shown.
