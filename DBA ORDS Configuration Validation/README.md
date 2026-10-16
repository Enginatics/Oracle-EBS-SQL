---
layout: default
last_modified_at: 2026-10-16
title: 'DBA ORDS Configuration Validation | Oracle EBS SQL Report'
description: 'Validates the Oracle REST Data Services (ORDS) configuration for Blitz Report webservices. Checks: ORDS schema enablement and URL mapping, REST module…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, R12 only, DBA, ORDS, Configuration, Validation, ords_schemas, ords_modules, ords_url_mappings'
permalink: /DBA%20ORDS%20Configuration%20Validation/
report_name: 'DBA ORDS Configuration Validation'
report_web_name: dba-ords-configuration-validation
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA ORDS Configuration Validation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-ords-configuration-validation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Validates the Oracle REST Data Services (ORDS) configuration for Blitz Report webservices. Checks: ORDS schema enablement and URL mapping, REST module status, PL/SQL package validity, all 27 expected endpoint handlers and their ORDS template registrations, execute grants, URL-pattern privileges that intercept xxen_webservices calls and the OAuth client's role grants (catches HTTP 401 caused by pre-existing catch-all privileges), ORDS URL profile configuration with token endpoint validation, OAuth2 client_id/secret availability, and ORDS connection pool sessions. Use this report to diagnose ORDS connectivity issues including OAuth token 404 and 401 errors.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[ords_schemas](https://www.enginatics.com/library/?pg=1&find=ords_schemas&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [ords_modules](https://www.enginatics.com/library/?pg=1&find=ords_modules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [ords_url_mappings](https://www.enginatics.com/library/?pg=1&find=ords_url_mappings&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [dba_procedures](https://www.enginatics.com/library/?pg=1&find=dba_procedures&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [ords_handlers](https://www.enginatics.com/library/?pg=1&find=ords_handlers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [ords_templates](https://www.enginatics.com/library/?pg=1&find=ords_templates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [dba_tab_privs](https://www.enginatics.com/library/?pg=1&find=dba_tab_privs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [ords_privilege_mappings](https://www.enginatics.com/library/?pg=1&find=ords_privilege_mappings&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [ords_client_roles](https://www.enginatics.com/library/?pg=1&find=ords_client_roles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [fnd_profile_option_values](https://www.enginatics.com/library/?pg=1&find=fnd_profile_option_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [fnd_profile_options](https://www.enginatics.com/library/?pg=1&find=fnd_profile_options&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [gv$session](https://www.enginatics.com/library/?pg=1&find=gv%24session&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation)

## Related Reports
[Blitz Report Add-in Environment Setup](/Blitz%20Report%20Add-in%20Environment%20Setup/ "Blitz Report Add-in Environment Setup Oracle EBS SQL Report"), [DBA Object Access Privileges](/DBA%20Object%20Access%20Privileges/ "DBA Object Access Privileges Oracle EBS SQL Report"), [DBA Directories](/DBA%20Directories/ "DBA Directories Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA Text Search](/DBA%20Text%20Search/ "DBA Text Search Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20ORDS%20Configuration%20Validation/DBA%20ORDS%20Configuration%20Validation.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA ORDS Configuration Validation 25-Apr-2026 133958.xlsx](https://www.enginatics.com/example/dba-ords-configuration-validation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation) |
| Blitz Report™ XML Import | [DBA_ORDS_Configuration_Validation.xml](https://www.enginatics.com/xml/dba-ords-configuration-validation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation) |
| SQL Source | [DBA ORDS Configuration Validation.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20ORDS%20Configuration%20Validation/DBA%20ORDS%20Configuration%20Validation.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-ords-configuration-validation/](https://www.enginatics.com/reports/dba-ords-configuration-validation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation) |

## Case Study & Technical Analysis: DBA ORDS Configuration Validation

### Executive Summary
The DBA ORDS Configuration Validation report checks the Oracle REST Data Services (ORDS) configuration that Blitz Report web services depend on. It runs checks in seven sections: the ORDS schema and module, the PL/SQL packages, the REST endpoint handlers, the security grants, the URL-pattern privileges, the configuration profiles and the middleware connection pool. Each check returns a status, a detail and an OK, Warning or Error validation. Database administrators use it to diagnose connectivity problems, particularly OAuth token errors that surface as HTTP 404 or HTTP 401 responses. The report takes no parameters, so every run performs the full set of checks.

### Business Challenge
*   **Connectivity failures:** When the Blitz Report add-in cannot obtain an OAuth token or call a web service, the cause can sit in any of several ORDS objects, and each must be checked in turn.
*   **Silent privilege conflicts:** A pre-existing catch-all privilege on the ORDS URL patterns can require roles that the web service client does not hold, which returns HTTP 401 even when the endpoints are correct.
*   **Insecure transport:** OAuth2 requests over plain HTTP are refused by ORDS, and the client secret must not travel in clear text outside test systems.
*   **Upgrade and move risk:** Endpoints, grants and the ORDS URL profile must all be in place after a patch, a restore or a new instance.

### The Solution
*   Confirms that the ORDS schema and the xxen_webservices module are enabled and published, and reports the URL mapping and base path used in the request URL.
*   Checks that the two packages behind the web service are valid, and that each of the 27 expected endpoint handlers is defined in the APPS schema and registered as an ORDS template.
*   Verifies the execute grants on the web service packages and lists the URL-pattern privileges that intercept calls to the web service path.
*   Reads the connection type, the ORDS base URL, the derived URL, its HTTPS status, the OAuth client id and secret, and whether the ORDS connection pool has sessions.

### Technical Architecture (High Level)
#### Primary Tables
*   `ORDS_SCHEMAS`, `ORDS_MODULES`, `ORDS_URL_MAPPINGS`, `ORDS_TEMPLATES` and `ORDS_HANDLERS`: the ORDS metadata for the schema, module, URL mapping, template and handler of the web service.
*   `ORDS_PRIVILEGE_MAPPINGS` and `ORDS_CLIENT_ROLES`: the URL-pattern privileges and the roles held by the OAuth client.
*   `DBA_OBJECTS`, `DBA_PROCEDURES` and `DBA_TAB_PRIVS`: the validity of the packages, the handler procedures and the execute grants.
*   `FND_PROFILE_OPTION_VALUES` and `FND_PROFILE_OPTIONS`: the profile values for the connection type, ORDS URL and APEX URL.
*   `GV$SESSION`: the sessions of the ORDS public user.
*   `DUAL`: used for the static check rows.

#### Logical Relationships
1.  `ORDS_SCHEMAS` is joined to `ORDS_MODULES` on the schema id for the module xxen_webservices, and to `ORDS_URL_MAPPINGS` on the URL mapping id.
2.  `ORDS_TEMPLATES` is joined to `ORDS_MODULES` on the module id, and each template's handler count comes from `ORDS_HANDLERS`.
3.  The expected endpoint names are compared with the procedures in `DBA_PROCEDURES` for the APPS owner, with an outer join so a missing procedure shows as Missing.
4.  Privileges whose pattern is /*, /** or starts with /xxen are flagged as catch-all in `ORDS_PRIVILEGE_MAPPINGS`.
5.  The derived ORDS URL is built from the FND_APEX_URL profile when APEX is installed, otherwise from the APPS_SERVLET_AGENT profile on port 8443.

### Parameters & Filtering
This report has no parameters. Every run returns all seven sections, so the output can be compared between two instances.

### Performance & Optimization
*   The checks are small lookups on the ORDS metadata for one module, so the report returns quickly on a normal instance.
*   The endpoint list is a fixed set of names read from DUAL, so the check does not depend on a catalogue table.
*   The connection pool check counts sessions for one database user in GV$SESSION, without reading session detail.
*   The catch-all check uses a NOT EXISTS subquery, so the "none detected" row appears only when no matching privilege exists.

### FAQ
**Q: Why does the Blitz Report add-in return HTTP 401 when the ORDS endpoints are present?**
A: A URL-pattern privilege that matches the web service path requires roles the xxen_webservices client does not hold. The Catch-all Privilege rows show the privilege name and pattern, and the detail gives the query on DBA_ORDS_PRIVILEGE_ROLES that lists the required roles.

**Q: Why does an ORDS URL using HTTP fail the token request?**
A: ORDS refuses OAuth2 requests received over HTTP and returns HTTP 403, so no bearer token is issued. The check reports this as an Error, and the fix is to move ORDS to HTTPS.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-ords-configuration-validation)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
