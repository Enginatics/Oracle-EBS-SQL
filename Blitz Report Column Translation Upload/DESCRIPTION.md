# Case Study & Technical Analysis: Blitz Report Column Translation Upload

## Executive Summary
The Blitz Report Column Translation Upload is a maintenance report for the translated column headings and number formats used by Blitz Report™. It lets a support or implementation team edit, in Excel, how a report column heading appears in each language and how its values are formatted. Because translations are matched to reports by column name at run time, one row applies to every report that produces a column of that name. The report is useful when a multilingual EBS user base needs consistent headings across the whole report library, and when new or renamed columns need translations added without editing each report.

## Business Challenge
*   **Large translation volume:** The Blitz Report column library holds around twenty thousand column names, so translating them by hand in a form is impractical.
*   **Missing translations:** Users in a non-base language see English headings wherever a translation is absent, and gaps are hard to find without a list.
*   **Inconsistent number formats:** Values such as amounts, quantities and dates need one Excel format mask per column, and that mask must not drift between languages.
*   **Keeping new columns covered:** When new columns are introduced, someone needs a controlled way to enter their translations for each language.

## The Solution
*   **Language-driven download:** The language parameter is required, and the extract returns the column names and their existing translations for that language.
*   **Missing-only and empty-file modes:** A missing-translations mode returns only column names without a translation in the chosen language, and an empty-file mode allows new column names to be entered.
*   **Single number format per column:** The number format is stored once per column name and repeated on every language row, so editing it on one row is enough.
*   **Delete and audit fields:** A delete flag removes a translation, and the creator and last-update columns show who changed each entry and when.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_REPORT_COLUMNS`: the master list of column names, the column ID and the number format.
*   `XXEN_REPORT_COLUMNS_TL`: the translations, keyed by column ID and language, with the translated heading text.
*   `FND_LANGUAGES_VL`: the installed languages, used to select the language and show its description.

### Logical Relationships
1.  `FND_LANGUAGES_VL` is filtered to the selected language code.
2.  `XXEN_REPORT_COLUMNS` is outer joined to the translation rows on column ID.
3.  The translation rows are outer joined on the language code, so every column can appear with a blank translation for the language.
4.  The translation table is read only when the upload mode is not Create, so Create runs start from an empty translation set.

## Parameters & Filtering
*   **Upload Mode:** Chooses between Create and Update behaviour. Create runs do not read existing translations, and Update runs download the current ones for editing.
*   **Language:** Required. It selects the language whose translations are downloaded.
*   **Create Empty File:** When set to Yes, the file is returned with no column rows, so new column names can be entered.
*   **Missing Translations Only:** When set to Yes, only the column names that have no translation in the chosen language are returned.
*   **Column Name starts with:** Narrows the list to column names with the given prefix, which is useful for editing one family of columns.

## Performance & Optimization
*   **Language-first filter:** The language is the first restriction, so the extract is limited to one language before translations are attached.
*   **Conditional translation read:** The translation table is only read when the upload mode is not Create, which avoids a full read of translations when a clean set is wanted.
*   **Outer join for gaps:** The column list is outer joined to the translations, so columns with no translation still appear, which is what makes the missing-only mode possible.
*   **Prefix filter:** The Column Name starts with parameter narrows the column master early, which keeps the work proportional to the names being edited.

## FAQ
**Q: How do I list the Blitz Report columns that still need a French translation?**
A: Choose French as the Language and set Missing Translations Only to Yes. Only columns without a translation in that language are returned.

**Q: If I change a number format on one language row, do I need to change the others?**
A: No. The number format belongs to the column name, so it repeats on every language row and only needs to be edited on one row.

**Q: How do I remove a translation I no longer want?**
A: Set the Delete flag to Yes on that row in an Update run, and upload the file.
