---
layout: default
title: 'PA Task Schedule | Oracle EBS SQL Report'
description: 'Summary project report showing operating unit, project, task, scheduled start date, scheduled finish date, created by, and last updated by.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Task, Schedule, hr_all_organization_units, pa_projects_all, pa_proj_elements'
permalink: /PA%20Task%20Schedule/
---

# PA Task Schedule – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-task-schedule/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary project report showing operating unit, project, task, scheduled start date, scheduled finish date, created by, and last updated by.

## Report Parameters
Operating Unit, Project

## Oracle EBS Tables Used
[hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pa_proj_elements](https://www.enginatics.com/library/?pg=1&find=pa_proj_elements), [pa_proj_elem_ver_schedule](https://www.enginatics.com/library/?pg=1&find=pa_proj_elem_ver_schedule)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[PA Event Upload](/PA%20Event%20Upload/ "PA Event Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PA Task Schedule 04-Apr-2026 023352.xlsx](https://www.enginatics.com/example/pa-task-schedule/) |
| Blitz Report™ XML Import | [PA_Task_Schedule.xml](https://www.enginatics.com/xml/pa-task-schedule/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/pa-task-schedule/](https://www.enginatics.com/reports/pa-task-schedule/) |

## Case Study & Technical Analysis: PA Task Schedule Report

### Executive Summary

The PA Task Schedule report provides a concise yet critical overview of project task timelines within Oracle Projects. It presents key scheduling information, including scheduled start and finish dates, along with audit details like who created and last updated the task. This report is an essential tool for project managers, team leads, and project control officers to monitor task progress, identify potential schedule deviations, and ensure that projects are progressing according to plan.

### Business Challenge

Effective project management hinges on keeping tasks on schedule. However, gaining clear and timely visibility into task timelines across multiple projects or a large number of tasks can be a significant challenge in a standard ERP environment:

-   **Lack of Centralized View:** While project management software often provides Gantt charts, retrieving a simple, tabular list of all tasks with their scheduled dates from Oracle Projects for reporting or analysis is not always straightforward.
-   **Difficult Schedule Monitoring:** Manually tracking the scheduled dates for numerous tasks and comparing them against actual progress is a time-consuming and error-prone process, making it difficult to identify schedule slippages proactively.
-   **Limited Audit Trail:** Understanding who modified a task's schedule and when is crucial for accountability and troubleshooting, but this information is not always readily available in a consolidated view.
-   **Supporting Project Reviews:** During project status meetings, managers need a quick and easy way to present task schedules and highlight any critical path items or upcoming deadlines.

### The Solution

This report offers a straightforward and efficient solution for monitoring project task schedules, providing the clarity needed to manage project timelines effectively.

-   **Clear Task Timelines:** It presents each project task with its scheduled start and finish dates, providing an at-a-glance view of the planned duration and sequence of work.
-   **Essential Audit Information:** By including "Created By" and "Last Updated By" fields, the report provides a valuable audit trail, enhancing accountability and aiding in the investigation of schedule changes.
-   **Foundation for Schedule Analysis:** Project managers can export this data to Excel for further analysis, such as calculating task durations, identifying critical path dependencies, or creating simple Gantt-like visualizations.
-   **Streamlined Project Communications:** The report serves as an excellent reference for communicating project timelines to team members and stakeholders, ensuring everyone is aligned on delivery expectations.

### Technical Architecture (High Level)

The report queries the core Oracle Projects tables that store the Work Breakdown Structure and associated scheduling information.

-   **Primary Tables Involved:**
    -   `pa_projects_all` (to identify the main project).
    -   `pa_proj_elements` (this table stores the definition of project tasks and their hierarchy).
    -   `pa_proj_elem_ver_schedule` (this critical table stores the scheduled start and finish dates for each task version).
    -   `hr_all_organization_units` (to display the operating unit context).
-   **Logical Relationships:** The report establishes a link from the `pa_projects_all` table to `pa_proj_elements` to retrieve all tasks belonging to a specified project. It then joins to `pa_proj_elem_ver_schedule` to extract the relevant scheduled start and finish dates for the active version of each task.

### Parameters & Filtering

The report uses focused parameters to allow users to quickly retrieve relevant scheduling data:

-   **Operating Unit:** A standard filter to restrict the report to projects within a specific business unit.
-   **Project:** The primary parameter to select the specific project whose task schedules you wish to view.

### Performance & Optimization

As a report focused on master data (task schedules), it is designed for rapid performance.

-   **Indexed Lookups:** The query efficiently retrieves data by leveraging standard Oracle indexes on `project_id` and `element_id` (for tasks) in the underlying tables.
-   **Direct Data Access:** The report directly queries the database tables, avoiding any performance overhead associated with complex concurrent programs or intermediate data transformations.
-   **Focused Scope:** By design, it focuses on the scheduled dates, rather than aggregating large volumes of transactional data, ensuring quick execution.

### FAQ

**1. Can this report show the actual start and finish dates of a task?**
   This report primarily focuses on the *scheduled* dates. While Oracle Projects tracks actual dates in other tables (e.g., `pa_tasks`), this report is intended for a high-level view of the plan. A different report would be needed to compare scheduled vs. actual dates directly.

**2. How does the report handle different versions of a project schedule?**
   Oracle Projects allows for multiple versions of a project schedule. This report typically displays the schedule from the *currently active* or *current working* version of the project. If you need to analyze historical schedule versions, specific modifications to the report or other Oracle Project Management reporting would be required.

**3. Is it possible to see the duration of each task in this report?**
   The report provides both a scheduled start and scheduled finish date. Users can easily calculate the duration in days (or other units) by exporting the report to Excel and applying a simple formula. This allows for quick analysis of task length and resource allocation.


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
