---
layout: default
last_modified_at: 2026-10-16
title: 'DIS Workbook Export Script | Oracle EBS SQL Report'
description: 'https://youtu.be/17Au11IBE Use this report to migrate Discoverer workbooks to Blitz Report. The migration process is described in the following link…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Discoverer, Enginatics, DIS, Workbook, Export, Script, eul5_documents, eul5_qpp_stats'
permalink: /DIS%20Workbook%20Export%20Script/
report_name: 'DIS Workbook Export Script'
report_web_name: dis-workbook-export-script
module: 'Discoverer'
module_url: /modules/discoverer/
---

# DIS Workbook Export Script – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-workbook-export-script/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script).
**Oracle EBS module:** [Discoverer](/modules/discoverer/ "Oracle EBS Discoverer reports") · [all Discoverer reports](/modules/discoverer/)  

## Overview
<a href="https://youtu.be/17_Au_11IBE" rel="nofollow" target="_blank">https://youtu.be/17_Au_11IBE</a>
Use this report to migrate Discoverer workbooks to Blitz Report.
The migration process is described in the following link: <a href="https://www.enginatics.com/blog/discoverer-replacement-with-blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script" rel="nofollow" target="_blank">https://www.enginatics.com/blog/discoverer-replacement-with-blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script</a>

1. Run this report 'DIS Workbook Export Script' to generate a list of commands to export xmls for all recently used Discoverer workbooks.
2. Create a new folder on a windows machine having the Discoverer Admin executable dis51adm.exe installed (contact Enginatics if you need help with the installation).
3. Open a Command Prompt window, cd to the new folder, and execute (copy and paste) the commands generated in step 1. This will start individual processes to export the workbooks as .eex files. Depending on your client capacity, you can run 100-200 export processes at the same time. In case of errors, delete all zero size .eex files and rerun the script.
4. Zip together all generated (non-zero size) workbook_*.eex files. Do not include the generated *.log files. Note that the .zip needs to be created with older Windows10 compression methods, as the latest Windows11 method cannot be processed by the Oracle 19c database yet.
5. If you have more than one EUL, set the profile option 'Blitz Report Discoverer Default EUL' to the end user layer for which you run the migration
6. Navigate to Setup>Tools>Import>XML Upload and upload the .zip file generated in step 4. You will see a message with the count of uploaded xml files.
7. Run concurrent program 'Blitz Report Discoverer Import' from the System Administrator responsibility, and specify a report name prefix to easily distinguish the migrated reports.
8. Verify the migration result by running reports:
'Blitz Report Parameter Uniqueness Validation' and correct the nonunique parameter names.
'Blitz Report LOV SQL Validation' and correct errors plus change slow 'distinct' style ones to fast SQLs
'Blitz Report SQL Validation' and correct problems
'Blitz Report Parameter Bind Variable Validation'
'DIS Migration identify missing EulConditions'
'Blitz Report Parameter Table Alias Validation'
'Blitz Reports' for Discoverer check for column 'required_parameters'
'Blitz Report Parameter Default Values' for discoverer check for default value having partition
'Blitz Report Templates' and search for Subtotals: Y in the description and train the users to switch compact pivot to tabular format


Workbooks without EUL usage statistics are not listed by default. Set 'Ignore Access History' to Yes to export those as well, optionally restricted by 'Workbook' or 'Workbook Id'.
'Blitz Report Discoverer Import' converts the workbooks selected in the 'DIS Workbook Conversion Selection' upload regardless of access history.


In case you need to completely re-run the Discoverer import, for example with a different cut-off date parameter, you can use the following script to purge the previously imported data:

declare
l_eul varchar2(30):='eul_us';
begin
  --Delete staging tables
  delete xxen_discoverer_workbook_xmls xdwx where xdwx.eul=l_eul;
  delete from xxen_discoverer_fnd_user xdfu where xdfu.eul=l_eul;
  delete from xxen_discoverer_pivot_fields xdpf where xdpf.eul=l_eul;
  delete from xxen_discoverer_sheets xds where xds.eul=l_eul;
  delete from xxen_discoverer_workbooks xdw where xdw.eul=l_eul;
  --Delete all reports from category 'Discoverer' and their related LOVs
  for c in (select xrca.report_id from xxen_report_categories_v xrcv, xxen_report_category_assigns xrca where xrcv.category='Discoverer' and xrcv.category_id=xrca.category_id) loop
    xxen_api.delete_report(c.report_id,'Y');
  end loop;
  for c in (select xrplv.lov_id from xxen_report_parameter_lovs_v xrplv where xrplv.description=upper(xrplv.description) and xrplv.lov_id not in (select xrp.lov_id from xxen_report_parameters xrp where xrp.parameter_type='LOV' and xrp.lov_id is not null)) loop
    xxen_api.delete_lov(c.lov_id);
  end loop;
  commit;
end;

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Accessed After, Ignore Access History, Workbook Owner, Workbook, Workbook Id, End User Layer, End User Layer Password, Executable Path, DB Service Name, Not yet imported only

## Oracle EBS Tables Used
[eul5_documents](https://www.enginatics.com/library/?pg=1&find=eul5_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script), [eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script)

## Related Reports
[DIS Converter Diagnostic Dump](/DIS%20Converter%20Diagnostic%20Dump/ "DIS Converter Diagnostic Dump Oracle EBS SQL Report"), [DIS Workbook Conversion Selection](/DIS%20Workbook%20Conversion%20Selection/ "DIS Workbook Conversion Selection Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Worksheet Execution Summary](/DIS%20Worksheet%20Execution%20Summary/ "DIS Worksheet Execution Summary Oracle EBS SQL Report"), [DIS Worksheet SQLs](/DIS%20Worksheet%20SQLs/ "DIS Worksheet SQLs Oracle EBS SQL Report"), [DIS Business Areas](/DIS%20Business%20Areas/ "DIS Business Areas Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Workbook%20Export%20Script/DIS%20Workbook%20Export%20Script.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Workbook Export Script 28-Mar-2026 080920.xlsx](https://www.enginatics.com/example/dis-workbook-export-script/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script) |
| Blitz Report™ XML Import | [DIS_Workbook_Export_Script.xml](https://www.enginatics.com/xml/dis-workbook-export-script/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script) |
| SQL Source | [DIS Workbook Export Script.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Workbook%20Export%20Script/DIS%20Workbook%20Export%20Script.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dis-workbook-export-script/](https://www.enginatics.com/reports/dis-workbook-export-script/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script) |

## Case Study & Technical Analysis

### Abstract
The **DIS Workbook Export Script** is an automation utility designed to facilitate the mass migration of Discoverer content. Instead of requiring an administrator to manually open and export workbooks one by one, this report generates a Windows batch script. When executed on a machine with the Discoverer Administrator client (`dis51adm.exe`), this script bulk-exports the selected workbooks into XML (`.eex`) format, ready for import into Blitz Report.

### Technical Analysis

#### Core Logic
*   **Command Generation**: Constructs the precise command-line syntax required by `dis51adm.exe` for each workbook (e.g., `/connect user/pwd@db /export workbook_name /xml file.eex`).
*   **Filtering**: Allows filtering by "Accessed After" date to avoid exporting thousands of obsolete reports that haven't been used in years.
*   **Parallelism**: The generated script is designed to run multiple export processes in parallel to maximize throughput.

#### Operational Use Cases
*   **Mass Migration**: The primary tool for moving an entire organization's reporting catalog (thousands of reports) to a new platform in a single weekend.
*   **Backup**: Creating a complete XML backup of the Discoverer EUL for disaster recovery or archival purposes.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-export-script)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
