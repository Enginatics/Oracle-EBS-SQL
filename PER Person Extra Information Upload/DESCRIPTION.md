# Case Study & Technical Analysis: PER Person Extra Information Upload

## Executive Summary
This upload maintains the Person Extra Information types (EITs) of Oracle Human Resources, the records held in the People form under Others, Extra Information, Extra Person Information. It downloads the existing extra information records of employees in a business group, and lets an HR administrator create new records and update existing ones in a spreadsheet, for any information type registered in the Extra Person Info flexfield. HR specialists use it to load certifications, licence details, language skills or other personal data that the business records for each employee, when the data comes from an external system or from an HR survey. Blitz Report™ provides the spreadsheet in which the segment values are entered.

## Business Challenge
*   **Bulk personal data:** Many employees need the same kind of extra information, such as a certification, and entering each record through the People form takes too long.
*   **Several records of one type:** A person can hold several records of the same type, for example one per year, so the existing rows must be identified correctly.
*   **Eligibility and value rules:** Each information type is eligible only for certain persons, and segments can be validated against value sets, so the entered values must follow those rules.
*   **Consistent layout:** The segments of each information type are stored in a fixed order, and the spreadsheet must present them in that order.

## The Solution
*   Downloads each extra information record of the employees in a business group, with the employee number, name, business group and information type.
*   Shows the Information 1 to Information 30 segments of each record, with their values resolved through the flexfield segment labels.
*   Keeps the Person Extra Information identifier on each row, so an updated row is matched to its existing record and not to the person and type.
*   Lists every enabled information type of the Extra Person Info flexfield, so a new record can be created for any eligible type.
*   Treats a row without a Person Extra Information identifier as a new record to create.

## Technical Architecture (High Level)
### Primary Tables
*   `PER_BUSINESS_GROUPS`: the business group that the employees belong to.
*   `PER_ALL_PEOPLE_F`: the employee, with employee number and full name, effective on the run date.
*   `PER_PEOPLE_EXTRA_INFO`: the extra information records, with the information type category and the 30 information segments.
*   `FND_DESCR_FLEX_CONTEXTS_VL`: the contexts of the Extra Person Info flexfield, which are the registered information types.

### Logical Relationships
1. `PER_BUSINESS_GROUPS` restricts the employees to the chosen business group.
2. `PER_ALL_PEOPLE_F` is joined to the business group, and limited to the person record effective on the run date.
3. `PER_PEOPLE_EXTRA_INFO` is joined to the employee on the person identifier.
4. The information type of each record is found in `FND_DESCR_FLEX_CONTEXTS_VL`, where the context code equals the information category of the record and the flexfield is the Extra Person Info flexfield of the Human Resources application.
5. Only enabled contexts are shown, so disabled information types do not appear.

## Parameters & Filtering
*   **Upload Mode:** selects create only, or create and update with existing records downloaded.
*   **Business Group:** limits the employees to one business group.
*   **Employee Number:** selects one employee.
*   **Information Type:** selects one registered information type.

## Performance & Optimization
*   The employee record is limited to the person version effective on the run date, so historical versions of each person are not returned.
*   The context lookup joins on the information category of each record and on enabled contexts only, so the value translation uses the matching flexfield context.
*   The segment values are translated through the flexfield display function for each of the 30 segments, using the row's own category.
*   Filtering by information type on download reduces the number of records and the flexfield translations performed.

## FAQ
**Q: Why do I need the Person Extra Information ID on each row?**
A: A person can hold several records of the same information type, so an update must identify the exact record. The ID does this; the person and type alone do not.

**Q: What value should I enter for a segment that uses a value set?**
A: Enter the stored value the segment expects, as the value set is validated when the record is created or updated.

**Q: Why is an information type missing from the Information Type list?**
A: Only enabled contexts of the Extra Person Info flexfield are listed, so a disabled information type does not appear.
