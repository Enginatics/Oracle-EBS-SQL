---
layout: default
last_modified_at: 2026-10-26
title: 'FND Nodes | Oracle EBS SQL Report'
description: 'FNDNODES stores information about the nodes that are used to install and run Oracle Application at your site. Each row includes the name of the node and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Nodes, fnd_nodes'
permalink: /FND%20Nodes/
report_name: 'FND Nodes'
report_web_name: fnd-nodes
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Nodes – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-nodes/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
FND_NODES stores information about the nodes that are used to
install and run Oracle Application at your site. Each row includes
the name of the node and the platform code. The column name
NODE_NAME is the given name used to refer to the machine or node
at the site. The column PLATFORM_CODE specifies the make of the
machine or node (e.g. DEC VMS, Sequent Ptx, etc.). This
information is used to associate a concurrent manager with a
specific node to support distributed processing.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[fnd_nodes](https://www.enginatics.com/library/?pg=1&find=fnd_nodes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes)

## Related Reports
[FND Profile Option Value Upload](/FND%20Profile%20Option%20Value%20Upload/ "FND Profile Option Value Upload Oracle EBS SQL Report"), [FND Profile Option Values](/FND%20Profile%20Option%20Values/ "FND Profile Option Values Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [FND Debug and Trace Settings](/FND%20Debug%20and%20Trace%20Settings/ "FND Debug and Trace Settings Oracle EBS SQL Report"), [FND Attached Documents (Operating Unit Secured)](/FND%20Attached%20Documents%20%28Operating%20Unit%20Secured%29/ "FND Attached Documents (Operating Unit Secured) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Nodes/FND%20Nodes.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Nodes 25-Aug-2024 000300.xlsx](https://www.enginatics.com/example/fnd-nodes/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes) |
| Blitz Report™ XML Import | [FND_Nodes.xml](https://www.enginatics.com/xml/fnd-nodes/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes) |
| SQL Source | [FND Nodes.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Nodes/FND%20Nodes.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-nodes/](https://www.enginatics.com/reports/fnd-nodes/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes) |

## Executive Summary
The **FND Nodes** report lists the application tier nodes (servers) registered in the Oracle EBS topology. It is a technical infrastructure report.

## Business Challenge
*   **Infrastructure Audit:** Verifying the list of active servers in a multi-node cluster.
*   **Concurrent Processing:** Checking which nodes are configured to run concurrent managers.
*   **Cleanup:** Identifying old or decommissioned nodes that need to be purged from `FND_NODES`.

## The Solution
This Blitz Report queries `FND_NODES`:
*   **Node Name:** The hostname of the server.
*   **Platform:** The operating system (e.g., Linux, Solaris).
*   **Status:** Whether the node is active.
*   **Services:** Which services (Web, Admin, Concurrent) are running on the node.

## Technical Architecture
The report queries `FND_NODES`.

## Parameters & Filtering
*   **None:** Typically lists all nodes.

## Performance & Optimization
*   **Small Data:** Most systems have fewer than 20 nodes.

## FAQ
*   **Q: Why do I see old servers here?**
    *   A: If a server is decommissioned without running the `FND_CONC_CLONE.SETUP_CLEAN` routine, it may remain in this table.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-nodes)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
