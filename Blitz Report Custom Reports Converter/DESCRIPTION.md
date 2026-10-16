# Case Study & Technical Analysis: Blitz Report Custom Reports Converter

## Executive Summary
The Blitz Report Custom Reports Converter is a discovery and collection report for organizations that want to move older Oracle EBS reporting into Blitz Report™. It lists concurrent programs that are candidates for conversion, including RDF reports, BI Publisher reports and data-extract programs, together with their run statistics. The user selects the programs to convert and uploads the file, which starts a host concurrent program that gathers each program's source artifacts into one zip file for analysis by Enginatics. Migration leads and reporting teams use it to decide which custom reports are worth converting, based on how often they run and how many users run them.

## Business Challenge
*   **Unclear conversion scope:** Custom RDF, BI Publisher and extract programs accumulate over years, and nobody holds a current list of which ones still matter.
*   **Usage-based prioritisation:** Programs that run rarely or are used by one person are poor candidates, and this needs run counts, distinct users and last-run dates.
*   **Collecting source artifacts:** Converting a report needs its executable, data definition, template, related packages and custom dependencies gathered in one place.

## The Solution
*   **Program inventory with statistics:** The report lists enabled concurrent programs with their application, executable, execution method, output format and run statistics.
*   **Program type classification:** Each program is classified as Excel4apps, BI Publisher, RDF or Data Extract, based on its executable and data source, and custom views and Noetix views are listed as their own types.
*   **Select and upload:** The Convert Program column selects which rows are collected. Uploading the file submits a host concurrent program that builds the zip.
*   **Dependency collection for views:** Selecting a custom view gathers its definition and its custom dependency closure into the same zip.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_APPLICATION_VL`: the owning application of each program.
*   `FND_CONCURRENT_PROGRAMS_VL`: the concurrent program definitions, including user name, short name, output file type and enabled flag.
*   `FND_EXECUTABLES_VL`: the executable for each program, with its execution method and file name.
*   `FND_CONCURRENT_REQUESTS`: the request history, aggregated into run counts, distinct users and first and last run dates.
*   `XDO_DS_DEFINITIONS_B`: BI Publisher data source definitions, used to recognise BI Publisher programs.
*   `DBA_VIEWS` and `DBA_OBJECTS`: custom and Noetix views, and their creation dates.

### Logical Relationships
1.  `FND_APPLICATION_VL` is joined to `FND_CONCURRENT_PROGRAMS_VL` on application ID.
2.  `FND_CONCURRENT_PROGRAMS_VL` is joined to `FND_EXECUTABLES_VL` on the executable application ID and executable ID.
3.  An inline view summarises `FND_CONCURRENT_REQUESTS` by program ID and program application ID, and is outer joined so programs that never ran still appear with zero counts.
4.  A CASE expression classifies each program as Excel4apps, BI Publisher, RDF or Data Extract.
5.  Two further branches, unioned to the program list, return custom views and Noetix views from `DBA_VIEWS` joined to `DBA_OBJECTS` on owner and name.

## Parameters & Filtering
*   **Select All Programs:** When Yes, every listed row starts with Convert Program set to Yes, so the user only clears the programs to exclude.
*   **Application, Program Type and Execution Method:** Narrow the program list by owning application, classification or execution method.
*   **User Concurrent Program Name and Concurrent Program Short Name (with the contains variants):** Find programs by display name or short name.
*   **Custom Programs Only:** Limits the list to custom programs.
*   **Minimum Run Count, Minimum Distinct Users, Last Run Date From and Last Run Date To:** Select programs by usage, which is the main prioritisation tool.
*   **Include Custom Views and Custom View prefix:** Add custom database views whose names match the custom object prefix to the list.
*   **Include Noetix Views:** Adds the NOETIX_SYS query views to the list on instances running NoetixViews.

## Performance & Optimization
*   **Usage aggregated once:** Request history is summarised in a single grouped inline view, so run statistics come from one pass over `FND_CONCURRENT_REQUESTS` rather than one query per program.
*   **Enabled programs only:** The program list keeps only programs whose enabled flag is Y or null, so retired programs are excluded early.
*   **Dictionary reads for views:** Custom and Noetix views are found through the data dictionary views, and Noetix views are filtered by naming patterns to exclude helper and base views.

## FAQ
**Q: How do I find custom RDF reports that ran at least ten times in the last year?**
A: Set Program Type to RDF, Custom Programs Only to Yes, Minimum Run Count to 10 and Last Run Date From to a date one year back.

**Q: What does the converter zip contain?**
A: For each selected program it gathers the executable, data definition, template, related packages and custom dependencies, and for a selected view it gathers the view definition and its custom dependency closure.

**Q: Which programs does Select All Programs include?**
A: Every row the filters return. Set Convert Program to No on any row you do not want collected before uploading.
