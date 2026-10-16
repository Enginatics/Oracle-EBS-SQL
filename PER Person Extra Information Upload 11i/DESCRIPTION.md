# Case Study & Technical Analysis: PER Person Extra Information Upload 11i

## Executive Summary
PER Person Extra Information Upload 11i creates and updates Person Extra Information records in Oracle HRMS, the extra information types that hold additional data about an employee or applicant beyond the standard person record. It mirrors the Extra Person Information window reached from the People form, and it covers every information type registered in the Extra Person Info flexfield. HR administrators and HRIS teams use it to load certifications, union or licence data, and other structured person information for many employees, using the same validation the form applies.

## Business Challenge
*   **Bulk Person Data:** Organizations with large workforces often hold information such as licences, certifications or yearly declarations that must be loaded for hundreds of people.
*   **Repeated Records:** One person can hold several records of the same type, such as one per year, and each must be maintained separately.
*   **Eligibility Rules:** An information type is available only to eligible people, and ineligible entries must be prevented before they are loaded.
*   **Value Set Compliance:** Segments validated against a value set must receive stored values, which are hard to recall for every type.

## The Solution
*   **Generic Information Columns:** The thirty information segments of each type are presented as columns, in the order of the type's flexfield segments.
*   **Existing Record Matching:** Existing records are matched by the hidden person extra information identifier, so repeated records of one type are updated correctly.
*   **Type Selection:** The Information Type parameter lists every enabled context of the Extra Person Info flexfield.
*   **Display Values:** Segment values are displayed through the flexfield value function, so the downloaded values match what the form shows.

## Technical Architecture (High Level)
### Primary Tables
*   `PER_BUSINESS_GROUPS`: the business group that scopes the people selected.
*   `PER_ALL_PEOPLE_F`: the person records, with employee number and full name, effective on the current date.
*   `PER_PEOPLE_EXTRA_INFO`: the extra information records, with the information category and thirty information segments.
*   `FND_DESCR_FLEX_CONTEXTS_VL`: the flexfield contexts of the Extra Person Info flexfield, which supply the information type names.

### Logical Relationships
1.  The business group in `PER_BUSINESS_GROUPS` is joined to the people in `PER_ALL_PEOPLE_F` on the business group identifier.
2.  People are restricted to records effective on the current date.
3.  Extra information records in `PER_PEOPLE_EXTRA_INFO` are joined to people on the person identifier.
4.  Each record's information category is matched to an enabled context of the Extra Person Info flexfield in `FND_DESCR_FLEX_CONTEXTS_VL`, which provides the information type name.
5.  Each information segment is decoded through the flexfield value function using the category and the segment column.

## Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update, which controls whether existing records are downloaded.
*   **Business Group:** Restricts the people to one business group. It is required.
*   **Employee Number:** Restricts the output to one employee.
*   **Information Type:** Restricts the records to one information type.

## Performance & Optimization
*   **Business Group Driven:** The business group filter is the first restriction on the people table, so the extract covers only one business group.
*   **Current Person Records:** Only person records effective today are read, which avoids duplicate rows from historical person changes.
*   **Enabled Contexts Only:** The flexfield context join keeps only enabled contexts, so disabled information types are not offered.
*   **Flexfield Decode Per Segment:** Display values are produced per segment by the value function, so the cost is proportional to the number of records and segments returned.

## FAQ
**Q: How do I add a second record of the same information type for one person?**
A: Create a new row with the same person and type and leave the hidden Person Extra Information ID blank. Existing records are matched by that identifier, not by person and type.

**Q: Why is the upload rejecting a row for an information type?**
A: The information type must be eligible for the person. The API rejects types the person is not eligible for.

**Q: Which value do I enter for a segment that is validated by a value set?**
A: Enter the stored value that the segment expects, as the description states.
