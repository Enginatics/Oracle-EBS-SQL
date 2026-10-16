# Case Study & Technical Analysis: QA Collection Element Upload

## Executive Summary
The QA Collection Element Upload creates, updates and deletes Oracle Quality collection elements, the user-defined characteristics that quality inspectors record in collection plans. It manages the element name, type, datatype, prompt, display length, mandatory and enabled flags, unit of measure, default value, data entry hint, validation string and sequence configuration. Quality engineers use it to build and maintain the element library from a controlled spreadsheet, for example when a new inspection standard is introduced across several plans. Blitz Report downloads the existing elements so they can be reviewed and changed in place, and the upload writes them back to the Quality characteristics table.

## Business Challenge
*   **Element library maintenance:** Collection elements are reused by many plans, so an error in an element affects every plan that uses it, and a consistent library must be kept.
*   **Setup speed:** Creating many elements in the Quality forms one at a time is slow, and a spreadsheet makes the design reviewable before it is loaded.
*   **Sequence-based identifiers:** Elements that generate numbers, such as lot-style identifiers, need prefix, suffix, separator, start, increment and padding settings to be consistent.
*   **Controlled change:** Datatypes cannot be changed once an element exists, so the team needs to see the current datatype before any change is planned.

## The Solution
*   Downloads the collection elements, with their element type, datatype, prompt, display length and decimal precision, in the Excel layout used for uploads.
*   Creates an element when its name is new, and updates the mandatory, enabled, unit of measure, default value, hint, validation string and sequence fields of an existing element.
*   Applies the sequence fields, including the prefix, suffix, separator, start, increment, length and zero padding, to elements of the Sequence datatype.
*   Marks an element for deletion through the Delete Record column, and sets the datatype only at creation.

## Technical Architecture (High Level)
### Primary Tables
*   `QA_CHARS`: the collection elements, with the name, type, datatype, display settings, flags, default value, validation and sequence settings.
*   `MTL_UNITS_OF_MEASURE`: the unit of measure of an element, looked up by its code.

### Logical Relationships
1.  The elements are read from `QA_CHARS` where the character context flag is 1, which restricts the rows to user-defined elements.
2.  `QA_CHARS` is outer joined to `MTL_UNITS_OF_MEASURE` on the unit of measure code, so an element without a unit still appears.
3.  Element type, datatype, mandatory and enabled values are translated through the meaning function for their lookup types.
4.  The character id is returned as the key that the upload uses to match an updated row to its element.

## Parameters & Filtering
*   **Upload Mode:** selects whether the rows are downloaded for update, creation or both.
*   **Collection Element From** and **Collection Element To:** bound the element names listed, in alphabetical order of the name.

## Performance & Optimization
*   The query reads one table, `QA_CHARS`, with one small outer join to the unit of measure table, so the download is fast even for a large library.
*   The context flag condition is applied in the WHERE clause, so the seeded elements that are not user-defined are not read into the output.
*   The name range parameters limit the rows before the lookups run, which is the most useful filter for a large library.
*   The report returns one row per element, so there are no aggregates and no repeated rows.

## FAQ
**Q: Can I change the datatype of an existing collection element through the upload?**
A: No. The datatype cannot be changed after the element is created, as the description states.

**Q: Are specification limits and values managed by this upload?**
A: No. Specification limits, values and actions are not managed by this upload and must be maintained in the Quality forms.

**Q: How do I delete a collection element with the upload?**
A: Set the Delete Record column for the element and upload the row. The Delete Record column is blank in the download.
