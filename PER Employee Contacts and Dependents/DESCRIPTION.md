# Case Study & Technical Analysis: PER Employee Contacts and Dependents

## Executive Summary
This report lists the contact relationships of employees in Oracle Human Resources, including dependents, beneficiaries and emergency contacts. For each relationship it shows the employee, the organization and location, the contact person's details and address, the relationship type, and flags for dependent, beneficiary, emergency contact and third party payment. HR administrators use it for benefits administration, where dependents and beneficiaries must be confirmed for enrolment, and for emergency preparedness, where the people to call for an employee must be known. It also supports employee records management by giving one current list of contact relationships across the business group.

## Business Challenge
*   **Benefits eligibility:** Benefit plans depend on which contacts are registered as dependents or beneficiaries, and these must be checked against the records.
*   **Emergency response:** During an incident, HR must reach the emergency contacts of the affected employees quickly.
*   **Third party payments:** Contacts flagged for third party payment must be identified for payroll and benefits review.
*   **Scattered contact data:** Phone numbers, e-mail addresses and postal addresses of a contact are held in separate records, and they must be read together.

## The Solution
*   Lists each contact relationship of each employee, with the relationship type, primary contact flag, and the dependent, beneficiary, emergency contact and third party payment flags shown as Yes where they apply.
*   Shows the contact's name, date of birth, gender and e-mail address.
*   Shows the contact's current phone numbers, each with its phone type, and the primary address with its street lines, city, region, postal code and country.
*   Shows the employee's organization and location from the primary employee assignment, and the business group.
*   Shows the relationship start and end dates, and only includes relationships that have not ended.

## Technical Architecture (High Level)
### Primary Tables
*   `PER_CONTACT_RELATIONSHIPS`: the contact relationship, with its type, flags, dates and sequence number.
*   `PER_ALL_PEOPLE_F`: the employee and the contact person, each effective on the run date.
*   `PER_ALL_ASSIGNMENTS_F`: the employee's primary employee assignment, with the organization and location.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group and the employee's organization.
*   `HR_LOCATIONS_ALL`: the location of the assignment.
*   `PER_PHONES`: the contact person's phone numbers.
*   `PER_ADDRESSES`: the contact person's primary address.
*   `FND_TERRITORIES_VL`: the country name of the address.

### Logical Relationships
1. The employee is joined to the relationship on the person identifier, and to the business group in `HR_ALL_ORGANIZATION_UNITS_VL`.
2. The contact person is joined to the relationship on the contact person identifier.
3. The employee's primary employee assignment is outer joined, and its organization and location are joined to the assignment.
4. The contact's primary address is outer joined, and its country code is translated through `FND_TERRITORIES_VL`.
5. The contact's current phone numbers are aggregated into one text value per contact.
6. The result is ordered by business group, employee name, sequence number and contact name.

## Parameters & Filtering
*   **Business Group:** limits the employees to one business group.
*   **Employee Name:** selects an employee by name.
*   **Relationship Type:** selects one type of contact, such as a dependent or an emergency contact.
*   **Organization:** limits the employees to one organization on their primary assignment.

## Performance & Optimization
*   The employee and contact person records are restricted to the current date, so historical records of people are not returned.
*   Only primary addresses that are current on the run date are joined, so superseded addresses are not returned.
*   Phone numbers are aggregated for each contact, which keeps one row per relationship in the output.
*   Relationships whose end date has passed are excluded in the relationship filter, so ended contacts are not listed.

## FAQ
**Q: How do I list the dependents of all employees in a business group?**
A: Select the Business Group and set Relationship Type to the dependent type. The dependent flag and the contact details of each dependent are shown.

**Q: Why does a contact appear without an address?**
A: The address columns are taken from the primary address that is current on the run date. A contact without a current primary address is still listed, with those columns blank.

**Q: Are ended relationships included?**
A: No. Only relationships whose end date is empty or after the run date are listed.
