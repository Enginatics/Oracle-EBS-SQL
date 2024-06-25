# [DBA AWR System Wait Class by Time](https://www.enginatics.com/reports/dba-awr-system-wait-class-by-time/)

## Description: 
Non idle session wait times by wait class over time.
Each row shows the system-wide wait time per wait class of one AWR snapshot interval to identify unusual wait events that occured at specific times.
Use the Session Type parameter to restrict either to foreground, background or all server processes.

## Parameters
Date From, Date To, Session Type, Diagnostic Pack enabled, Container Data

## Used tables
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [dba_hist_system_event](https://www.enginatics.com/library/?pg=1&find=dba_hist_system_event)

## Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related reports
[DBA AWR System Wait Event Summary](/DBA%20AWR%20System%20Wait%20Event%20Summary/)

## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).

# Example Report 
[DBA AWR System Wait Class by Time 26-Nov-2018 195624.xlsx](https://www.enginatics.com/example/dba-awr-system-wait-class-by-time/)

# Report SQL
[www.enginatics.com/reports/dba-awr-system-wait-class-by-time/](https://www.enginatics.com/reports/dba-awr-system-wait-class-by-time/)

# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[DBA_AWR_System_Wait_Class_by_Time.xml](https://www.enginatics.com/xml/dba-awr-system-wait-class-by-time/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

## Blitz Report™ [YouTube Tutorials](https://www.youtube.com/@enginatics)

<table>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=qLlkBcuvbBQ">Oracle Enterprise Command Center (ECC) installation and integration with Oracle EBS 12.2</a>
            </td>
            <td>
                This video describes Oracle Enterprise Command Center Framework (ECC) installation and integration with Oracle EBS 12.2. It is based on the following blog post: https://www.enginatics.com/blog/oracle-enterprise-command-center-framework-release-12-2-installation-and-integration-with-oracle-ebs-12-2-8/
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=DTtPpLbX7lM">How to quickly create or modify Oracle E-Business Suite BI Publisher based reports</a>
            </td>
            <td>
                BI publisher is used extensively in Oracle E-Business Suite. The standard Oracle design for the report layout often prevents the report from being exported to Excel in a usable format. Making changes to the displayed columns or parameters usually requires the submission of time consuming change requests that often sit in long queues waiting for development resource availability.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=jfa92Ik-aao">Blitz Report™ - Simple, effective Excel reporting for Oracle EBS R12 and 11i</a>
            </td>
            <td>
                Blitz Report™ is the easiest and quickest way to export Oracle Applications R12 or 11i data into MS Excel.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=lR6Ib4iIBMI">ECC report generation in Oracle EBS tutorial</a>
            </td>
            <td>
                This video provides instructions for rapid report development using standardized Oracle ECC SQL queries that generate Excel reports, in real time from EBS. These can be attached to any EBS form using the 'Zoom' toolbar option to replace the slow and inconvenient CSV export function. Benefits This method enables rapid report development using the same queries used by the ECC dashboards. Since these have been tested and approved by Oracle the output is assured.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=MAr2AxCxsGM">Oracle E-Business Suite - Concurrent Request Monitoring and Alert Reporting</a>
            </td>
            <td>
                Concurrent Request Management Critical concurrent requests should be monitored at all times to prevent problems in downstream processes. The standard method is to use Oracle Alert and email the output to the support or database teams. Other techniques involve running SQL with time based schedules handled by Cron. The alert method is somewhat out-dated, emails are in text format and Excel exception files cannot be sent.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=P8P4zR1Ggso">How to develop proven EBS reports using Oracle Enterprise Command Center SQL’s in under 5 minutes</a>
            </td>
            <td>
                Introduction Oracle Enterprise Command Center Framework provides information discovery, visualization, and exploration capabilities embedded within the Oracle E-Business Suite Dashboards are provided for functional areas such as General Ledger, Receivables, Payables, Project Accounting, Service Contracts, and Supply Chain modules. This article provides instructions for rapid report development using standardized Oracle ECC SQL queries within EBS.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=e9O64A1wZPk">Oracle Discoverer replacement. How to Import Oracle Discoverer Reports to EBS - Blitz Report™.</a>
            </td>
            <td>
                Task: Oracle Discoverer replacement Audience: DBA’s, IT consultants and business operations Background: Oracle de-supported Discoverer in 2017. Recognizing that this is a significant and challenging step for EBS customers to undertake, the Enginatics team has developed an Oracle Discoverer replacement procedure with automated functionality to import Discoverer worksheets together with their security assignments and parameters.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=DyxKYXNNF9g">Introduction to Blitz Report for Oracle EBS with the ERPStuff community</a>
            </td>
            <td>
                Showing Blitz Report for SQL management and Excel reporting directly out of EBS
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=IdhONHweiLo">Blitz Report in 15 minutes</a>
            </td>
            <td>
                Quick introduction to the world's fastest reporting tool for Oracle E-Business Suite
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=IIZfdbuhfQg">Asset tracking integration with Install Base and Inventory</a>
            </td>
            <td>
                Audience: EBS architects, consultants, and business analysts for asset planning and tracking Article Summary: Understanding the asset integrations, including the Enterprise Command Center and troubleshooting transactions with Blitz Report.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=Hq1llpYq2YU">Data management and Enterprise Command Center enhancements (ECC)</a>
            </td>
            <td>
                Support of ECC dashboards processes can be challenging at the best of times. In this tutorial, we cover the Blitz Report data governance reporting and managing the Enterprise Command Centers We also support EBS Excel dashboard output with unlimited record size from the EBS instance. This video is based on the session run by Webinar at the Oracle User Group for Scotland, the full version of that is available on the UKOUG site per the 11th June 2020.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=aOHsz3Pj-kE">Blitz Report - E-Business Suite SQL to Excel Reporting for Non Developers</a>
            </td>
            <td>
                This recorded interactive session shows how easy it is for non-developers to get great results from Oracle EBS with Blitz Report.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=yfSA9UHZ8C4">How to create a DIFOT Sales Order Shipping Metric in Oracle E-Business Suite</a>
            </td>
            <td>
                Why measure your supply chain performance? The delivered in full on time, or DIFOT, metric quantifies the number of successfully fulfilled sales orders. It is important to monitor this metric to quantify the performance of your supply chain. There are several factors that causes an adverse DIFOT rating in your supply chain.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=YYh_PgYxLn4">The optimal way to analyse Automatic Workload Repository - AWR for Oracle EBS</a>
            </td>
            <td>
                The Oracle’s Automatic Workload Repository (AWR) collects and maintains performance statistics for problem detection and self-tuning purposes.The report generated by AWR is typically large and requires significant years of experience to fully understand all aspects. The process is made harder by the fact that short module codes are used and it is not clear which package and line of code needs attention.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=1H4d66iZdog">Blitz Report™ Tutorial - Running Blitz Report</a>
            </td>
            <td>
                Blitz Report™ is the easiest and quickest way to export Oracle Applications R12 or 11i data into MS Excel.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=EIYIdD2IUE0">Oracle E-Business Suite - How to Audit Master Data Changes with Blitz Report™</a>
            </td>
            <td>
                Tracking changes to Oracle EBS master data can be challenging using the standard Oracle reports and hence it is never implemented. Here we demonstrate how this can be easily done using the Blitz Report™ toolkit. The example used in this video is for supplier name / bank changes, but can be applied to any data element available in the Oracle. Blog: https://www.enginatics.com/blog/how-to-track-master-data-changes-using-oracle-ebs-audit-function-with-blitz-report/
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=07ERPSomaww">Find the SQL behind an Oracle EBS standard form</a>
            </td>
            <td>
                How to find the SQL queries behind an Oracle EBS standard form without running a trace
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=WNPJJtyow6g">Blitz Report™ Tutorial - Building a Blitz Report</a>
            </td>
            <td>
                Blitz Report™ is the easiest and quickest way to export Oracle Applications R12 or 11i data into MS Excel.
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=u_lL6rWbPPY">Find the SQL behind an OA Framework page in Oracle EBS</a>
            </td>
            <td>How to find the SQL query behind and OAF page in Oracle EBS
</td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=AnNMzmayOdQ">Blitz Report and Upload in 20 minutes</a>
            </td>
            <td>
                Introduction to Blitz Report, the fastest and easiest reporting and data upload for Oracle EBS.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=qUqp8ljZPOM">Supply Chain Hub - Detailed Overview</a>
            </td>
            <td>
                This is a complete focal hub for supply chain planners, everything a planner needs from Oracle EBS is provided in our central SCM hub with rapid output of any data to fully formatted Excel, but without the hour-glass’ waits per std form exports. There is no need to navigate out of the hub form for analysis or reporting as there is a full suite of PO, OM, Item, Material and MRP reports available within the hub. Even change org is available within the form.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=F7kLU0iKGkE">Oracle E-Business Suite Inventory Period-End Optimization / Close</a>
            </td>
            <td>
                The inventory period close process can often be challenging with the volume of stuck transactions typically faced. Oracle provide a pending transactions view with mandatory recommended resolutions. Inventory period close is towards the closure process which means it can often hold up the General Ledger accounting process and or other related modules.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=4dtdBhtKxW0">Blitz Report™ Tutorial - Sending Blitz Report Output to Email and Scheduling a Report</a>
            </td>
            <td>
                Blitz Report™ is the easiest and quickest way to export Oracle Applications R12 or 11i data into MS Excel.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=ScL6GBIUIuc">Blitz Report™ Tutorial - Report parameters and output formats</a>
            </td>
            <td>
                Blitz Report™ is the easiest and quickest way to export Oracle Applications R12 or 11i data into MS Excel.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=vpIkZxxM_GI">Blitz Report™ – World’s fastest reporting for Oracle E-Business Suite</a>
            </td>
            <td>
                Real-time data from all EBS operational areas, including reconciliation, alert reporting and performance tuning
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=g9LXNN95aeQ">Helping ASCP planners to achieve better planning results</a>
            </td>
            <td>
                Many customers of the Oracle module – Advanced Supply Chain Planning (ASCP) are disappointed or just cannot get the planners to use the Planner Workbench (PWB). But what if there was an easier way? Finally, there is, we provide a full suite of planning reports completely free to use that run directly within the workbench. Delivering plan data to Excel in a much faster method than any other EBS reporting tool. There are no hourglass waits, or CSV files to reformat and no data limitations.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=q0AaSPb24Ts">Oracle E-Business Suite - Sales Order Management - Order Organizer Optimization</a>
            </td>
            <td>
                In this short video, we demonstrate how to optimize your Oracle Order Management processes and allow your customer services teams to get on with the real order entry work. The concept can be applied to any Oracle form. Having worked with customer services teams for many years, a common problem is quickly responding to order queries and or exporting large volumes of order line and header information from the order organizer.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=n_uKYDjj6lQ">Supply Chain Hub in 4 minutes</a>
            </td>
            <td>
                Introduction to Supply Chain Hub, a very useful tool for anyone working with the Oracle EBS Supply Chain and Manufacturing modules.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=IjLecU9tQ2s">Blitz Report™ Tutorial - Creating Report Parameters</a>
            </td>
            <td>
                Blitz Report™ is the easiest and quickest way to export Oracle Applications R12 or 11i data into MS Excel.
            </td>
        </tr>
        <tr>
            <td>
                <a href="https://www.youtube.com/watch?v=Bgjx6EZBUCc">Oracle ASCP - Plan by exception with Blitz Report™</a>
            </td>
            <td>
                Reviewing the exceptions generated by a plan allows planners to quickly pinpoint issues in the supply chain, this is usually done in a proactive way. The key challenge with this is that the standard Oracle Planner Workbench tools are not efficient and tend to be ad-hoc rather than automated. For each exception type displayed in the Planner Workbench, it is possible to drill into the detailed information about the nature of the exception.
            </td>
        </tr>
    </table>

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/blitz-report-developer-guide/#bi-publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

The Filters, Columns, Rows and Values fields are used to create and deliver the data in pivot table format with full drill down to details.

![Blitz Report Pivots](https://www.enginatics.com/wp-content/uploads/Oracle-EBS-data-delivered-directly-in-Excel-2-1-1.png) 

The Excel template upload functionality in Blitz Report allows users to create their own layouts by uploading an Excel template with additional sheets and charts, automatically refreshed when the report runs again. This allows to create custom dashboards and more advanced visualizations of report data.

![Blitz Report Dashboard](https://www.enginatics.com/wp-content/uploads/Blitz-Report-Dashboard.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/blitz-report-user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

<link href="/style.css" rel="stylesheet">
<table border="0" width="100%"><tbody><tr><td><b>Alert</b></td><td><b>CRM Foundation</b></td></tr><tr><td><ul><li><a href="/ALR%20Alerts/">ALR Alerts</a></li></ul></td><td><ul><li><a href="/JTF%20Grid%20Datasources/">JTF Grid Datasources</a></li></ul></td></tr><tr><td><b>Contracts Core</b></td><td><b>Lease and Finance Management</b></td></tr><tr><td><ul><li><a href="/OKC%20Contract%20Lines%20Summary/">OKC Contract Lines Summary</a></li></ul></td><td><ul><li><a href="/OKL%20Termination%20Quotes/">OKL Termination Quotes</a></li></ul></td></tr><tr><td><b>Payments</b></td><td><b>Process Manufacturing</b></td></tr><tr><td><ul><li><a href="/IBY%20Payment%20Process%20Request%20Details/">IBY Payment Process Request Details</a></li></ul></td><td><ul><li><a href="/OPM%20Reconcilation/">OPM Reconcilation</a></li></ul></td></tr><tr><td><b>Process Manufacturing Inventory</b></td><td><b>Public Sector Financials</b></td></tr><tr><td><ul><li><a href="/GMI%20Cycle%20Count%20Forms/">GMI Cycle Count Forms</a></li></ul></td><td><ul><li><a href="/PSA%20Budgetary%20Control%20Transactions/">PSA Budgetary Control Transactions</a></li></ul></td></tr><tr><td><b>Shipping Execution</b></td><td><b>XML Publisher</b></td></tr><tr><td><ul><li><a href="/WSH%20Shipping-Delivery%20Transactions/">WSH Shipping/Delivery Transactions</a></li></ul></td><td><ul><li><a href="/XDO%20Publisher%20Data%20Definitions/">XDO Publisher Data Definitions</a></li></ul></td></tr><tr><td><b>Capacity</b></td><td><b>Legal Entity Configurator</b></td></tr><tr><td><ul><li><a href="/CRP%20Available%20Resources/">CRP Available Resources</a></li><li><a href="/CRP%20Resource%20Plan/">CRP Resource Plan</a></li></ul></td><td><ul><li><a href="/XLE%20Establishment%20and%20Legal%20Entity%20Associations/">XLE Establishment and Legal Entity Associations</a></li><li><a href="/XLE%20Legal%20Entities/">XLE Legal Entities</a></li></ul></td></tr><tr><td><b>Projects</b></td><td><b>Service Contracts</b></td></tr><tr><td><ul><li><a href="/PA%20Capital%20Project%20Summary%20with%20Asset%20Detail/">PA Capital Project Summary with Asset Detail</a></li><li><a href="/PA%20Task%20Schedule/">PA Task Schedule</a></li></ul></td><td><ul><li><a href="/OKS%20Service%20Contracts%20Billing%20History/">OKS Service Contracts Billing History</a></li><li><a href="/OKS%20Service%20Contracts%20Billing%20Schedule/">OKS Service Contracts Billing Schedule</a></li></ul></td></tr><tr><td><b>Advanced Pricing</b></td><td><b>Applications DBA</b></td></tr><tr><td><ul><li><a href="/QP%20Customer%20Pricing%20Engine%20Request/">QP Customer Pricing Engine Request</a></li><li><a href="/QP%20Modifier%20Details/">QP Modifier Details</a></li><li><a href="/QP%20Price%20Lists/">QP Price Lists</a></li></ul></td><td><ul><li><a href="/AD%20Applied%20Patches/">AD Applied Patches</a></li><li><a href="/AD%20Applied%20Patches%2011i/">AD Applied Patches 11i</a></li><li><a href="/AD%20Applied%20Patches%20R12-2/">AD Applied Patches R12.2</a></li></ul></td></tr><tr><td><b>Enterprise Asset Management</b></td><td><b>Installed Base</b></td></tr><tr><td><ul><li><a href="/EAM%20Assets/">EAM Assets</a></li><li><a href="/EAM%20Weekly%20Schedule/">EAM Weekly Schedule</a></li><li><a href="/EAM%20Work%20Orders/">EAM Work Orders</a></li></ul></td><td><ul><li><a href="/CSI%20Customer%20Products%20Summary/">CSI Customer Products Summary</a></li><li><a href="/CSI%20Installed%20Base%20Extended%20Attributes%20Summary/">CSI Installed Base Extended Attributes Summary</a></li><li><a href="/CSI%20Installed%20Base%20Summary%20by%20Organization/">CSI Installed Base Summary by Organization</a></li></ul></td></tr><tr><td><b>Payroll</b></td><td><b>Subledger Accounting</b></td></tr><tr><td><ul><li><a href="/PAY%20Costing%20Detail/">PAY Costing Detail</a></li><li><a href="/PAY%20Employee%20Payroll%20History/">PAY Employee Payroll History</a></li><li><a href="/PAY%20Payroll%20Element%20Details/">PAY Payroll Element Details</a></li></ul></td><td><ul><li><a href="/XLA%20Distribution%20Links%20Summary/">XLA Distribution Links Summary</a></li><li><a href="/XLA%20Entity%20ID%20Mappings/">XLA Entity ID Mappings</a></li><li><a href="/XLA%20Subledger%20Period%20Close%20Exceptions/">XLA Subledger Period Close Exceptions</a></li></ul></td></tr><tr><td><b>Workflow</b></td><td><b>E-Business Tax</b></td></tr><tr><td><ul><li><a href="/WF%20Activity%20Status%20Summary/">WF Activity Status Summary</a></li><li><a href="/WF%20Business%20Events%20and%20Subscriptions/">WF Business Events and Subscriptions</a></li><li><a href="/WF%20Notifications/">WF Notifications</a></li></ul></td><td><ul><li><a href="/ZX%20Lines%20Summary/">ZX Lines Summary</a></li><li><a href="/ZX%20Party%20Tax%20Profiles/">ZX Party Tax Profiles</a></li><li><a href="/ZX%20Tax%20Accounts/">ZX Tax Accounts</a></li><li><a href="/ZX%20Tax%20Regimes/">ZX Tax Regimes</a></li></ul></td></tr><tr><td><b>Enterprise Command Center</b></td><td><b>Bills of Material</b></td></tr><tr><td><ul><li><a href="/ECC%20Admin%20-%20Concurrent%20Programs/">ECC Admin - Concurrent Programs</a></li><li><a href="/ECC%20Admin%20-%20Data%20Load%20Tracking/">ECC Admin - Data Load Tracking</a></li><li><a href="/ECC%20Admin%20-%20Data%20Sets/">ECC Admin - Data Sets</a></li><li><a href="/ECC%20Admin%20-%20Metadata%20Attributes/">ECC Admin - Metadata Attributes</a></li></ul></td><td><ul><li><a href="/BOM%20Bill%20of%20Material%20Structure/">BOM Bill of Material Structure</a></li><li><a href="/BOM%20Calendar%20Exceptions/">BOM Calendar Exceptions</a></li><li><a href="/BOM%20Calendars/">BOM Calendars</a></li><li><a href="/BOM%20Item%20Where%20Used%20GUI/">BOM Item Where Used GUI</a></li><li><a href="/BOM%20Routings/">BOM Routings</a></li></ul></td></tr><tr><td><b>Property Manager</b></td><td><b>Advanced Supply Chain Planning</b></td></tr><tr><td><ul><li><a href="/PN%20GL%20Reconciliation/">PN GL Reconciliation</a></li><li><a href="/PN%20Generate%20Lease%20Analysis/">PN Generate Lease Analysis</a></li><li><a href="/PN%20Generate%20Lease%20Details/">PN Generate Lease Details</a></li><li><a href="/PN%20Generate%20Portfolio%20Detail/">PN Generate Portfolio Detail</a></li><li><a href="/PN%20Generate%20Portfolio%20Summary/">PN Generate Portfolio Summary</a></li></ul></td><td><ul><li><a href="/MSC%20Exceptions/">MSC Exceptions</a></li><li><a href="/MSC%20Horizontal%20Plan/">MSC Horizontal Plan</a></li><li><a href="/MSC%20Pegging%20Hierarchy/">MSC Pegging Hierarchy</a></li><li><a href="/MSC%20Pegging%20Hierarchy%2011i/">MSC Pegging Hierarchy 11i</a></li><li><a href="/MSC%20Plan%20Orders/">MSC Plan Orders</a></li><li><a href="/MSC%20Vertical%20Plan/">MSC Vertical Plan</a></li></ul></td></tr><tr><td><b>Work in Process</b></td><td><b>Human Resources</b></td></tr><tr><td><ul><li><a href="/WIP%20Account%20Distribution/">WIP Account Distribution</a></li><li><a href="/WIP%20Discrete%20Job%20Shortage/">WIP Discrete Job Shortage</a></li><li><a href="/WIP%20Entities/">WIP Entities</a></li><li><a href="/WIP%20Entities%20Summary/">WIP Entities Summary</a></li><li><a href="/WIP%20Required%20Components/">WIP Required Components</a></li><li><a href="/WIP%20Value/">WIP Value</a></li></ul></td><td><ul><li><a href="/PER%20Employee%20Assignments/">PER Employee Assignments</a></li><li><a href="/PER%20Employee%20Grade%20Changes/">PER Employee Grade Changes</a></li><li><a href="/PER%20Employee%20Salary%20Change/">PER Employee Salary Change</a></li><li><a href="/PER%20Information%20Type%20Security/">PER Information Type Security</a></li><li><a href="/PER%20Organization%20Hierarchy/">PER Organization Hierarchy</a></li><li><a href="/PER%20Organizations/">PER Organizations</a></li><li><a href="/PER%20Security%20Profiles/">PER Security Profiles</a></li></ul></td></tr><tr><td><b>Master Scheduling/MRP</b></td><td><b>Order Management</b></td></tr><tr><td><ul><li><a href="/MRP%20End%20Assembly%20Pegging/">MRP End Assembly Pegging</a></li><li><a href="/MRP%20Exceptions/">MRP Exceptions</a></li><li><a href="/MRP%20Financial%20Analysis/">MRP Financial Analysis</a></li><li><a href="/MRP%20Horizontal%20Plan/">MRP Horizontal Plan</a></li><li><a href="/MRP%20Item%20Forecast/">MRP Item Forecast</a></li><li><a href="/MRP%20Pegging/">MRP Pegging</a></li><li><a href="/MRP%20Sourcing%20Rules%20and%20Bills%20of%20Distribution/">MRP Sourcing Rules and Bills of Distribution</a></li></ul></td><td><ul><li><a href="/ONT%20Cancelled%20Orders/">ONT Cancelled Orders</a></li><li><a href="/ONT%20Order%20Holds/">ONT Order Holds</a></li><li><a href="/ONT%20Orders/">ONT Orders</a></li><li><a href="/ONT%20Orders%20and%20Lines/">ONT Orders and Lines</a></li><li><a href="/ONT%20Recurring%20Billing%20Plan/">ONT Recurring Billing Plan</a></li><li><a href="/ONT%20Transaction%20Types%20Listing/">ONT Transaction Types Listing</a></li><li><a href="/ONT%20Transaction%20Types%20and%20Line%20WF%20Processes/">ONT Transaction Types and Line WF Processes</a></li></ul></td></tr><tr><td><b>Cash Management</b></td><td><b>Cost Management</b></td></tr><tr><td><ul><li><a href="/CE%20Bank%20Account%20Balances/">CE Bank Account Balances</a></li><li><a href="/CE%20Bank%20Statement%20Import%20Execution/">CE Bank Statement Import Execution</a></li><li><a href="/CE%20Bank%20Statement%20and%20Reconciliation/">CE Bank Statement and Reconciliation</a></li><li><a href="/CE%20Bank%20Transaction%20Codes%20Listing/">CE Bank Transaction Codes Listing</a></li><li><a href="/CE%20Cash%20in%20Transit/">CE Cash in Transit</a></li><li><a href="/CE%20Cleared%20Transactions/">CE Cleared Transactions</a></li><li><a href="/CE%20General%20Ledger%20Cash%20Account%20Usage/">CE General Ledger Cash Account Usage</a></li><li><a href="/CE%20General%20Ledger%20Reconciliation/">CE General Ledger Reconciliation</a></li><li><a href="/CE%20Transactions%20Available%20for%20Reconciliation/">CE Transactions Available for Reconciliation</a></li></ul></td><td><ul><li><a href="/CST%20AP%20and%20PO%20Accrual%20Reconciliation/">CST AP and PO Accrual Reconciliation</a></li><li><a href="/CST%20COGS%20Revenue%20Matching/">CST COGS Revenue Matching</a></li><li><a href="/CST%20Cost%20Groups/">CST Cost Groups</a></li><li><a href="/CST%20Detailed%20Item%20Cost/">CST Detailed Item Cost</a></li><li><a href="/CST%20Inventory%20Value%20-%20Multi-Organization%20%28Element%20Costs%29%2011i/">CST Inventory Value - Multi-Organization (Element Costs) 11i</a></li><li><a href="/CST%20Inventory%20Value%20-%20Multi-Organization%20%28Item%20Costs%29/">CST Inventory Value - Multi-Organization (Item Costs)</a></li><li><a href="/CST%20Inventory%20Value%20Report%20-%20by%20Subinventory%20%28Item%20Cost%29/">CST Inventory Value Report - by Subinventory (Item Cost)</a></li><li><a href="/CST%20Item%20Cost%20Reports/">CST Item Cost Reports</a></li><li><a href="/CST%20Miscellaneous%20Accrual%20Reconciliation/">CST Miscellaneous Accrual Reconciliation</a></li><li><a href="/CST%20Period%20Close%20Subinventory%20Value/">CST Period Close Subinventory Value</a></li><li><a href="/CST%20Period%20Close%20Subinventory%20Value%20Summary/">CST Period Close Subinventory Value Summary</a></li><li><a href="/CST%20Supply%20Chain%20Indented%20Bills%20of%20Material%20Cost/">CST Supply Chain Indented Bills of Material Cost</a></li><li><a href="/CST%20Uninvoiced%20Receipts/">CST Uninvoiced Receipts</a></li></ul></td></tr><tr><td><b>Purchasing</b></td><td><b>Discoverer</b></td></tr><tr><td><ul><li><a href="/PO%20Approval%20Assignments/">PO Approval Assignments</a></li><li><a href="/PO%20Approval%20Groups/">PO Approval Groups</a></li><li><a href="/PO%20Approved%20Supplier%20List/">PO Approved Supplier List</a></li><li><a href="/PO%20Cancelled%20Purchase%20Orders/">PO Cancelled Purchase Orders</a></li><li><a href="/PO%20Cancelled%20Requisitions/">PO Cancelled Requisitions</a></li><li><a href="/PO%20Document%20Types/">PO Document Types</a></li><li><a href="/PO%20Headers/">PO Headers</a></li><li><a href="/PO%20Headers%2011i/">PO Headers 11i</a></li><li><a href="/PO%20Headers%20and%20Lines/">PO Headers and Lines</a></li><li><a href="/PO%20Headers%20and%20Lines%2011i/">PO Headers and Lines 11i</a></li><li><a href="/PO%20Internal%20Requisitions-Deliveries%20Discrepancy/">PO Internal Requisitions/Deliveries Discrepancy</a></li><li><a href="/PO%20Invoice%20Price%20Variance/">PO Invoice Price Variance</a></li><li><a href="/PO%20Purchase%20Price%20Variance/">PO Purchase Price Variance</a></li><li><a href="/PO%20Purchase%20Requisitions%20with%20PO%20Details/">PO Purchase Requisitions with PO Details</a></li></ul></td><td><ul><li><a href="/DIS%20Access%20Privileges/">DIS Access Privileges</a></li><li><a href="/DIS%20Business%20Areas/">DIS Business Areas</a></li><li><a href="/DIS%20Discoverer%20and%20Blitz%20Report%20Users/">DIS Discoverer and Blitz Report Users</a></li><li><a href="/DIS%20End%20User%20Layers/">DIS End User Layers</a></li><li><a href="/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/">DIS Folders, Business Areas, Items and LOVs</a></li><li><a href="/DIS%20Import%20Performance/">DIS Import Performance</a></li><li><a href="/DIS%20Items-%20Folders%20and%20Formulas/">DIS Items, Folders and Formulas</a></li><li><a href="/DIS%20Migration%20identify%20missing%20EulConditions/">DIS Migration identify missing EulConditions</a></li><li><a href="/DIS%20Users/">DIS Users</a></li><li><a href="/DIS%20Workbook%20Export%20Script/">DIS Workbook Export Script</a></li><li><a href="/DIS%20Workbook%20Import%20Validation/">DIS Workbook Import Validation</a></li><li><a href="/DIS%20Workbook%20Owner%20Export%20Script/">DIS Workbook Owner Export Script</a></li><li><a href="/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/">DIS Workbooks, Folders, Items and LOVs</a></li><li><a href="/DIS%20Worksheet%20Execution%20History/">DIS Worksheet Execution History</a></li><li><a href="/DIS%20Worksheet%20Execution%20Summary/">DIS Worksheet Execution Summary</a></li><li><a href="/DIS%20Worksheet%20SQLs/">DIS Worksheet SQLs</a></li></ul></td></tr><tr><td><b>Assets</b></td><td><b>Payables</b></td></tr><tr><td><ul><li><a href="/FA%20Additions%20By%20Source/">FA Additions By Source</a></li><li><a href="/FA%20Asset%20Additions/">FA Asset Additions</a></li><li><a href="/FA%20Asset%20Book%20Details/">FA Asset Book Details</a></li><li><a href="/FA%20Asset%20Book%20Details%2011i/">FA Asset Book Details 11i</a></li><li><a href="/FA%20Asset%20Cost/">FA Asset Cost</a></li><li><a href="/FA%20Asset%20Impairments/">FA Asset Impairments</a></li><li><a href="/FA%20Asset%20Inventory/">FA Asset Inventory</a></li><li><a href="/FA%20Asset%20Inventory%20Report/">FA Asset Inventory Report</a></li><li><a href="/FA%20Asset%20Reclassification/">FA Asset Reclassification</a></li><li><a href="/FA%20Asset%20Register/">FA Asset Register</a></li><li><a href="/FA%20Asset%20Retirements/">FA Asset Retirements</a></li><li><a href="/FA%20Asset%20Summary%20%28Germany%29/">FA Asset Summary (Germany)</a></li><li><a href="/FA%20CIP%20Cost/">FA CIP Cost</a></li><li><a href="/FA%20Cost%20Adjustments/">FA Cost Adjustments</a></li><li><a href="/FA%20Depreciation%20Projection/">FA Depreciation Projection</a></li><li><a href="/FA%20Depreciation%20Reserve/">FA Depreciation Reserve</a></li><li><a href="/FA%20Journal%20Entry%20Reserve%20Ledger/">FA Journal Entry Reserve Ledger</a></li><li><a href="/FA%20Revaluation%20Reserve/">FA Revaluation Reserve</a></li><li><a href="/FA%20Tax%20Reserve%20Ledger/">FA Tax Reserve Ledger</a></li></ul></td><td><ul><li><a href="/AP%20Accounted%20Invoice%20Aging/">AP Accounted Invoice Aging</a></li><li><a href="/AP%20Cash%20Requirement/">AP Cash Requirement</a></li><li><a href="/AP%20Expenses/">AP Expenses</a></li><li><a href="/AP%20Intercompany%20Invoice%20Details/">AP Intercompany Invoice Details</a></li><li><a href="/AP%20Invoice%20Audit%20Listing/">AP Invoice Audit Listing</a></li><li><a href="/AP%20Invoice%20Payments/">AP Invoice Payments</a></li><li><a href="/AP%20Invoice%20Payments%2011i/">AP Invoice Payments 11i</a></li><li><a href="/AP%20Invoice%20on%20Hold/">AP Invoice on Hold</a></li><li><a href="/AP%20Invoices%20and%20Lines/">AP Invoices and Lines</a></li><li><a href="/AP%20Invoices%20and%20Lines%2011i/">AP Invoices and Lines 11i</a></li><li><a href="/AP%20Invoices%20with%20PO-%20Intercompany%20and%20SLA%20Details/">AP Invoices with PO, Intercompany and SLA Details</a></li><li><a href="/AP%20Negative%20Supplier%20Balance/">AP Negative Supplier Balance</a></li><li><a href="/AP%20Open%20Balances%20Revaluation/">AP Open Balances Revaluation</a></li><li><a href="/AP%20Open%20Items%20Revaluation/">AP Open Items Revaluation</a></li><li><a href="/AP%20Posted%20Invoice%20Register/">AP Posted Invoice Register</a></li><li><a href="/AP%20Posted%20Payment%20Register/">AP Posted Payment Register</a></li><li><a href="/AP%20Supplier%20Statement/">AP Supplier Statement</a></li><li><a href="/AP%20Suppliers/">AP Suppliers</a></li><li><a href="/AP%20Suppliers%2011i/">AP Suppliers 11i</a></li><li><a href="/AP%20Suppliers%20Revenue%20Summary/">AP Suppliers Revenue Summary</a></li><li><a href="/AP%20Suppliers%20Revenue%20Summary%2011i/">AP Suppliers Revenue Summary 11i</a></li><li><a href="/AP%20Trial%20Balance/">AP Trial Balance</a></li><li><a href="/AP%20Trial%20Balance%20Report%20Definitions/">AP Trial Balance Report Definitions</a></li></ul></td></tr><tr><td><b>General Ledger</b></td><td><b>Receivables</b></td></tr><tr><td><ul><li><a href="/GL%20Account%20Analysis/">GL Account Analysis</a></li><li><a href="/GL%20Account%20Analysis%20%28Distributions%29/">GL Account Analysis (Distributions)</a></li><li><a href="/GL%20Account%20Analysis%20%28Distributions%29%2011g/">GL Account Analysis (Distributions) 11g</a></li><li><a href="/GL%20Account%20Analysis%20%28Drilldown%29/">GL Account Analysis (Drilldown)</a></li><li><a href="/GL%20Account%20Analysis%2011g/">GL Account Analysis 11g</a></li><li><a href="/GL%20Account%20Analysis%2011i/">GL Account Analysis 11i</a></li><li><a href="/GL%20Balance/">GL Balance</a></li><li><a href="/GL%20Balance%20%28pivot%29/">GL Balance (pivot)</a></li><li><a href="/GL%20Balance%20Detail%20%28YTD%29/">GL Balance Detail (YTD)</a></li><li><a href="/GL%20Balance%20by%20Account%20Hierarchy/">GL Balance by Account Hierarchy</a></li><li><a href="/GL%20Code%20Combinations/">GL Code Combinations</a></li><li><a href="/GL%20Daily%20Rates/">GL Daily Rates</a></li><li><a href="/GL%20Data%20Access%20Sets/">GL Data Access Sets</a></li><li><a href="/GL%20FSG%20Reports/">GL FSG Reports</a></li><li><a href="/GL%20FSG%20Row%20Orders/">GL FSG Row Orders</a></li><li><a href="/GL%20Financial%20Statement%20and%20Drilldown%20%28FSG%29/">GL Financial Statement and Drilldown (FSG)</a></li><li><a href="/GL%20Header%20Categories%20Summary/">GL Header Categories Summary</a></li><li><a href="/GL%20Journals/">GL Journals</a></li><li><a href="/GL%20Journals%20%28Drilldown%29/">GL Journals (Drilldown)</a></li><li><a href="/GL%20Ledger%20Sets/">GL Ledger Sets</a></li><li><a href="/GL%20Ledgers%20and%20Legal%20Entities/">GL Ledgers and Legal Entities</a></li><li><a href="/GL%20Ledgers%20and%20Organizations/">GL Ledgers and Organizations</a></li><li><a href="/GL%20Rollup%20Groups/">GL Rollup Groups</a></li><li><a href="/GL%20Summary%20Templates/">GL Summary Templates</a></li><li><a href="/GL%20Trial%20Balance%20-%20Detail/">GL Trial Balance - Detail</a></li></ul></td><td><ul><li><a href="/AR%20Adjustment%20Register/">AR Adjustment Register</a></li><li><a href="/AR%20Aging/">AR Aging</a></li><li><a href="/AR%20Aging%20Buckets%20and%20Interest%20Tiers%20Setup/">AR Aging Buckets and Interest Tiers Setup</a></li><li><a href="/AR%20Applied%20Receipts/">AR Applied Receipts</a></li><li><a href="/AR%20Autoinvoice%20Interface%20Summary/">AR Autoinvoice Interface Summary</a></li><li><a href="/AR%20Customer%20Credit%20Limits/">AR Customer Credit Limits</a></li><li><a href="/AR%20Customer%20Open%20Balances%20Period%20Lookback/">AR Customer Open Balances Period Lookback</a></li><li><a href="/AR%20Customer%20Statement/">AR Customer Statement</a></li><li><a href="/AR%20Customers%20and%20Sites/">AR Customers and Sites</a></li><li><a href="/AR%20Disputed%20Invoice/">AR Disputed Invoice</a></li><li><a href="/AR%20European%20Sales%20Listing/">AR European Sales Listing</a></li><li><a href="/AR%20Incomplete%20Transactions/">AR Incomplete Transactions</a></li><li><a href="/AR%20Miscellaneous%20Receipts/">AR Miscellaneous Receipts</a></li><li><a href="/AR%20Miscellaneous%20Receipts%2011i/">AR Miscellaneous Receipts 11i</a></li><li><a href="/AR%20Open%20Balances%20Revaluation/">AR Open Balances Revaluation</a></li><li><a href="/AR%20Open%20Items%20Revaluation/">AR Open Items Revaluation</a></li><li><a href="/AR%20Past%20Due%20Invoice/">AR Past Due Invoice</a></li><li><a href="/AR%20Payment%20Terms/">AR Payment Terms</a></li><li><a href="/AR%20Receipt%20Register/">AR Receipt Register</a></li><li><a href="/AR%20Sales%20Journal%20By%20Customer/">AR Sales Journal By Customer</a></li><li><a href="/AR%20Transaction%20Register/">AR Transaction Register</a></li><li><a href="/AR%20Transactions%20and%20Lines/">AR Transactions and Lines</a></li><li><a href="/AR%20Transactions%20and%20Lines%2011i/">AR Transactions and Lines 11i</a></li><li><a href="/AR%20Transactions%20and%20Payments/">AR Transactions and Payments</a></li><li><a href="/AR%20Transactions%20and%20Payments%2011i/">AR Transactions and Payments 11i</a></li><li><a href="/AR%20Unapplied%20Receipts%20Register/">AR Unapplied Receipts Register</a></li><li><a href="/AR%20to%20GL%20Reconciliation/">AR to GL Reconciliation</a></li></ul></td></tr><tr><td><b>Inventory</b></td><td><b>Blitz Report</b></td></tr><tr><td><ul><li><a href="/INV%20Aging/">INV Aging</a></li><li><a href="/INV%20Cycle%20count%20entries%20and%20adjustments/">INV Cycle count entries and adjustments</a></li><li><a href="/INV%20Cycle%20count%20hit-miss%20analysis/">INV Cycle count hit/miss analysis</a></li><li><a href="/INV%20Cycle%20count%20listing/">INV Cycle count listing</a></li><li><a href="/INV%20Cycle%20count%20open%20requests%20listing/">INV Cycle count open requests listing</a></li><li><a href="/INV%20Cycle%20count%20schedule%20requests/">INV Cycle count schedule requests</a></li><li><a href="/INV%20Cycle%20count%20unscheduled%20items/">INV Cycle count unscheduled items</a></li><li><a href="/INV%20Cycle%20counts%20pending%20approval/">INV Cycle counts pending approval</a></li><li><a href="/INV%20Default%20Category%20Sets/">INV Default Category Sets</a></li><li><a href="/INV%20Intercompany%20Invoice%20Reconciliation/">INV Intercompany Invoice Reconciliation</a></li><li><a href="/INV%20Intercompany%20Invoice%20Reconciliation%2011i/">INV Intercompany Invoice Reconciliation 11i</a></li><li><a href="/INV%20Item%20Category%20Assignment/">INV Item Category Assignment</a></li><li><a href="/INV%20Item%20Category%20Sets/">INV Item Category Sets</a></li><li><a href="/INV%20Item%20Default%20Transaction%20Locators/">INV Item Default Transaction Locators</a></li><li><a href="/INV%20Item%20Default%20Transaction%20Subinventories/">INV Item Default Transaction Subinventories</a></li><li><a href="/INV%20Item%20Demand%20History/">INV Item Demand History</a></li><li><a href="/INV%20Item%20Import%20Performance/">INV Item Import Performance</a></li><li><a href="/INV%20Item%20Relationships/">INV Item Relationships</a></li><li><a href="/INV%20Item%20Statuses/">INV Item Statuses</a></li><li><a href="/INV%20Item%20Supply-Demand/">INV Item Supply/Demand</a></li><li><a href="/INV%20Item%20Templates/">INV Item Templates</a></li><li><a href="/INV%20Items/">INV Items</a></li><li><a href="/INV%20Lot%20Transaction%20Register/">INV Lot Transaction Register</a></li><li><a href="/INV%20Material%20Account%20Distribution%20Detail/">INV Material Account Distribution Detail</a></li><li><a href="/INV%20Material%20Transactions/">INV Material Transactions</a></li><li><a href="/INV%20Material%20Transactions%20Summary/">INV Material Transactions Summary</a></li><li><a href="/INV%20Onhand%20Quantities/">INV Onhand Quantities</a></li><li><a href="/INV%20Organization%20Access/">INV Organization Access</a></li><li><a href="/INV%20Organization%20Parameters/">INV Organization Parameters</a></li><li><a href="/INV%20Physical%20Inventory%20Adjustments/">INV Physical Inventory Adjustments</a></li><li><a href="/INV%20Print%20Cycle%20Count%20Entries%20Open%20Interface%20data/">INV Print Cycle Count Entries Open Interface data</a></li><li><a href="/INV%20Safety%20Stocks/">INV Safety Stocks</a></li><li><a href="/INV%20Stock%20Locators/">INV Stock Locators</a></li><li><a href="/INV%20Subinventories/">INV Subinventories</a></li><li><a href="/INV%20Transaction%20Historical%20Summary/">INV Transaction Historical Summary</a></li><li><a href="/INV%20Transaction%20Register/">INV Transaction Register</a></li></ul></td><td><ul><li><a href="/Blitz%20Report%20Application%20Categories/">Blitz Report Application Categories</a></li><li><a href="/Blitz%20Report%20Assignments/">Blitz Report Assignments</a></li><li><a href="/Blitz%20Report%20Assignments%20and%20Responsibilities/">Blitz Report Assignments and Responsibilities</a></li><li><a href="/Blitz%20Report%20Category%20Assignments/">Blitz Report Category Assignments</a></li><li><a href="/Blitz%20Report%20Column%20Number%20Fomat%20Comparison%20between%20environments/">Blitz Report Column Number Fomat Comparison between environments</a></li><li><a href="/Blitz%20Report%20Column%20Translation%20Comparison%20between%20environments/">Blitz Report Column Translation Comparison between environments</a></li><li><a href="/Blitz%20Report%20Column%20Translations/">Blitz Report Column Translations</a></li><li><a href="/Blitz%20Report%20Comparison%20between%20environments/">Blitz Report Comparison between environments</a></li><li><a href="/Blitz%20Report%20Default%20Templates/">Blitz Report Default Templates</a></li><li><a href="/Blitz%20Report%20Deletion%20History/">Blitz Report Deletion History</a></li><li><a href="/Blitz%20Report%20Execution%20History/">Blitz Report Execution History</a></li><li><a href="/Blitz%20Report%20Execution%20Summary/">Blitz Report Execution Summary</a></li><li><a href="/Blitz%20Report%20LOV%20Comparison%20between%20environments/">Blitz Report LOV Comparison between environments</a></li><li><a href="/Blitz%20Report%20LOV%20SQL%20Validation/">Blitz Report LOV SQL Validation</a></li><li><a href="/Blitz%20Report%20LOVs/">Blitz Report LOVs</a></li><li><a href="/Blitz%20Report%20License%20User%20History/">Blitz Report License User History</a></li><li><a href="/Blitz%20Report%20License%20Users/">Blitz Report License Users</a></li><li><a href="/Blitz%20Report%20Parameter%20Anchor%20Validation/">Blitz Report Parameter Anchor Validation</a></li><li><a href="/Blitz%20Report%20Parameter%20Comparison%20between%20reports/">Blitz Report Parameter Comparison between reports</a></li><li><a href="/Blitz%20Report%20Parameter%20Custom%20LOV%20Duplication%20Validation/">Blitz Report Parameter Custom LOV Duplication Validation</a></li><li><a href="/Blitz%20Report%20Parameter%20Default%20Values/">Blitz Report Parameter Default Values</a></li><li><a href="/Blitz%20Report%20Parameter%20Dependencies/">Blitz Report Parameter Dependencies</a></li><li><a href="/Blitz%20Report%20Parameter%20Table%20Alias%20Validation/">Blitz Report Parameter Table Alias Validation</a></li><li><a href="/Blitz%20Report%20Parameter%20Uniqueness%20Validation/">Blitz Report Parameter Uniqueness Validation</a></li><li><a href="/Blitz%20Report%20Parameters%20with%20more%20than%20one%20-bind%20variable/">Blitz Report Parameters with more than one :bind variable</a></li><li><a href="/Blitz%20Report%20Pivot%20Colums%20Validation/">Blitz Report Pivot Colums Validation</a></li><li><a href="/Blitz%20Report%20RDF%20Import%20Validation/">Blitz Report RDF Import Validation</a></li><li><a href="/Blitz%20Report%20Record%20History%20SQL%20Text%20Creation/">Blitz Report Record History SQL Text Creation</a></li><li><a href="/Blitz%20Report%20SQL%20Validation/">Blitz Report SQL Validation</a></li><li><a href="/Blitz%20Report%20Security/">Blitz Report Security</a></li><li><a href="/Blitz%20Report%20Templates/">Blitz Report Templates</a></li><li><a href="/Blitz%20Report%20Text%20Search/">Blitz Report Text Search</a></li><li><a href="/Blitz%20Report%20Translations/">Blitz Report Translations</a></li><li><a href="/Blitz%20Report%20User%20History/">Blitz Report User History</a></li><li><a href="/Blitz%20Report%20VPD%20Policy%20Setup/">Blitz Report VPD Policy Setup</a></li><li><a href="/Blitz%20Reports/">Blitz Reports</a></li><li><a href="/Blitz%20Upload%20Dependencies/">Blitz Upload Dependencies</a></li></ul></td></tr><tr><td><b>Database Administration</b></td><td><b>Application Object Library</b></td></tr><tr><td><ul><li><a href="/DBA%20AWR%20Active%20Session%20History/">DBA AWR Active Session History</a></li><li><a href="/DBA%20AWR%20Blocking%20Session%20Summary/">DBA AWR Blocking Session Summary</a></li><li><a href="/DBA%20AWR%20Latch%20Summary/">DBA AWR Latch Summary</a></li><li><a href="/DBA%20AWR%20Latch%20by%20Time/">DBA AWR Latch by Time</a></li><li><a href="/DBA%20AWR%20PGA%20History/">DBA AWR PGA History</a></li><li><a href="/DBA%20AWR%20SQL%20Execution%20Plan%20History/">DBA AWR SQL Execution Plan History</a></li><li><a href="/DBA%20AWR%20SQL%20Performance%20Summary/">DBA AWR SQL Performance Summary</a></li><li><a href="/DBA%20AWR%20Settings/">DBA AWR Settings</a></li><li><a href="/DBA%20AWR%20System%20Metrics%20Summary/">DBA AWR System Metrics Summary</a></li><li><a href="/DBA%20AWR%20System%20Time%20Percentages/">DBA AWR System Time Percentages</a></li><li><a href="/DBA%20AWR%20System%20Time%20Summary/">DBA AWR System Time Summary</a></li><li><a href="/DBA%20AWR%20System%20Wait%20Class%20by%20Time/">DBA AWR System Wait Class by Time</a></li><li><a href="/DBA%20AWR%20System%20Wait%20Event%20Summary/">DBA AWR System Wait Event Summary</a></li><li><a href="/DBA%20AWR%20System%20Wait%20Time%20Summary/">DBA AWR System Wait Time Summary</a></li><li><a href="/DBA%20AWR%20Tablespace%20Usage/">DBA AWR Tablespace Usage</a></li><li><a href="/DBA%20Alert%20Log/">DBA Alert Log</a></li><li><a href="/DBA%20Archive%20-%20Redo%20Log%20Rate/">DBA Archive / Redo Log Rate</a></li><li><a href="/DBA%20Automated%20Maintenance%20Tasks/">DBA Automated Maintenance Tasks</a></li><li><a href="/DBA%20Blocking%20Sessions/">DBA Blocking Sessions</a></li><li><a href="/DBA%20CPU%20Benchmark1/">DBA CPU Benchmark1</a></li><li><a href="/DBA%20CPU%20Benchmark2/">DBA CPU Benchmark2</a></li><li><a href="/DBA%20CPU%20Benchmark3/">DBA CPU Benchmark3</a></li><li><a href="/DBA%20DBMS%20Profiler%20Data/">DBA DBMS Profiler Data</a></li><li><a href="/DBA%20Dependencies%20%28used%20by%29/">DBA Dependencies (used by)</a></li><li><a href="/DBA%20Dependencies%20%28uses%29/">DBA Dependencies (uses)</a></li><li><a href="/DBA%20External%20Table%20Creation/">DBA External Table Creation</a></li><li><a href="/DBA%20Feature%20Usage%20Statistics/">DBA Feature Usage Statistics</a></li><li><a href="/DBA%20Index%20Columns/">DBA Index Columns</a></li><li><a href="/DBA%20Log%20Switches/">DBA Log Switches</a></li><li><a href="/DBA%20Parameters/">DBA Parameters</a></li><li><a href="/DBA%20Redo%20Log%20Files/">DBA Redo Log Files</a></li><li><a href="/DBA%20Result%20Cache%20Object%20Dependencies/">DBA Result Cache Object Dependencies</a></li><li><a href="/DBA%20Result%20Cache%20Statistics/">DBA Result Cache Statistics</a></li><li><a href="/DBA%20SGA%20Active%20Session%20History/">DBA SGA Active Session History</a></li><li><a href="/DBA%20SGA%20Blocking%20Session%20Summary/">DBA SGA Blocking Session Summary</a></li><li><a href="/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/">DBA SGA Buffer Cache Object Usage</a></li><li><a href="/DBA%20SGA%20Memory%20Allocation/">DBA SGA Memory Allocation</a></li><li><a href="/DBA%20SGA%20SQL%20Execution%20Plan%20History/">DBA SGA SQL Execution Plan History</a></li><li><a href="/DBA%20SGA%20SQL%20Performance%20Summary/">DBA SGA SQL Performance Summary</a></li><li><a href="/DBA%20SGA%20Target%20Advice/">DBA SGA Target Advice</a></li><li><a href="/DBA%20SGA-PGA%20Memory%20Configuration/">DBA SGA+PGA Memory Configuration</a></li><li><a href="/DBA%20Segments/">DBA Segments</a></li><li><a href="/DBA%20Table%20Columns/">DBA Table Columns</a></li><li><a href="/DBA%20Table%20Modifications/">DBA Table Modifications</a></li><li><a href="/DBA%20Tablespace%20Usage/">DBA Tablespace Usage</a></li><li><a href="/DBA%20Text%20Search/">DBA Text Search</a></li></ul></td><td><ul><li><a href="/FND%20Application%20Context%20File/">FND Application Context File</a></li><li><a href="/FND%20Applications/">FND Applications</a></li><li><a href="/FND%20Attached%20Documents/">FND Attached Documents</a></li><li><a href="/FND%20Attachment%20Functions/">FND Attachment Functions</a></li><li><a href="/FND%20Audit%20Setup/">FND Audit Setup</a></li><li><a href="/FND%20Audit%20Table%20Changes%20by%20Column/">FND Audit Table Changes by Column</a></li><li><a href="/FND%20Audit%20Table%20Changes%20by%20Record/">FND Audit Table Changes by Record</a></li><li><a href="/FND%20Concurrent%20Managers/">FND Concurrent Managers</a></li><li><a href="/FND%20Concurrent%20Program%20Incompatibilities/">FND Concurrent Program Incompatibilities</a></li><li><a href="/FND%20Concurrent%20Programs%20and%20Executables/">FND Concurrent Programs and Executables</a></li><li><a href="/FND%20Concurrent%20Programs%20and%20Executables%2011i/">FND Concurrent Programs and Executables 11i</a></li><li><a href="/FND%20Concurrent%20Request%20Conflicts/">FND Concurrent Request Conflicts</a></li><li><a href="/FND%20Concurrent%20Requests/">FND Concurrent Requests</a></li><li><a href="/FND%20Concurrent%20Requests%2011i/">FND Concurrent Requests 11i</a></li><li><a href="/FND%20Concurrent%20Requests%20Summary/">FND Concurrent Requests Summary</a></li><li><a href="/FND%20Descriptive%20Flexfields/">FND Descriptive Flexfields</a></li><li><a href="/FND%20FNDLOAD%20Object%20Transfer/">FND FNDLOAD Object Transfer</a></li><li><a href="/FND%20Flex%20Hierarchies%20%28Rollup%20Groups%29/">FND Flex Hierarchies (Rollup Groups)</a></li><li><a href="/FND%20Flex%20Value%20Hierarchy/">FND Flex Value Hierarchy</a></li><li><a href="/FND%20Flex%20Value%20Security%20Rules/">FND Flex Value Security Rules</a></li><li><a href="/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/">FND Flex Value Sets, Usages and Values</a></li><li><a href="/FND%20Flex%20Values/">FND Flex Values</a></li><li><a href="/FND%20Form%20Functions/">FND Form Functions</a></li><li><a href="/FND%20Forms%20Personalizations/">FND Forms Personalizations</a></li><li><a href="/FND%20Help%20Documents%20and%20Targets/">FND Help Documents and Targets</a></li><li><a href="/FND%20Key%20Flexfields/">FND Key Flexfields</a></li><li><a href="/FND%20Languages/">FND Languages</a></li><li><a href="/FND%20Lobs/">FND Lobs</a></li><li><a href="/FND%20Log%20Messages/">FND Log Messages</a></li><li><a href="/FND%20Lookup%20Search/">FND Lookup Search</a></li><li><a href="/FND%20Lookup%20Values/">FND Lookup Values</a></li><li><a href="/FND%20Lookup%20Values%20Comparison%20between%20environments/">FND Lookup Values Comparison between environments</a></li><li><a href="/FND%20Menu%20Entries/">FND Menu Entries</a></li><li><a href="/FND%20Profile%20Option%20Values/">FND Profile Option Values</a></li><li><a href="/FND%20Profile%20Options/">FND Profile Options</a></li><li><a href="/FND%20Request%20Groups/">FND Request Groups</a></li><li><a href="/FND%20Responsibility%20Access/">FND Responsibility Access</a></li><li><a href="/FND%20Responsibility%20Access%2011i/">FND Responsibility Access 11i</a></li><li><a href="/FND%20Responsibility%20Menu%20Exclusions/">FND Responsibility Menu Exclusions</a></li><li><a href="/FND%20Role%20Hierarchy/">FND Role Hierarchy</a></li><li><a href="/FND%20Roles/">FND Roles</a></li><li><a href="/FND%20Tables%20and%20Columns/">FND Tables and Columns</a></li><li><a href="/FND%20User%20Login%20History/">FND User Login History</a></li><li><a href="/FND%20User%20Login%20Page%20Favorites/">FND User Login Page Favorites</a></li><li><a href="/FND%20User%20Login%20Summary/">FND User Login Summary</a></li><li><a href="/FND%20User%20Responsibilities/">FND User Responsibilities</a></li><li><a href="/FND%20User%20Roles/">FND User Roles</a></li><li><a href="/FND%20User%20Roles%2011i/">FND User Roles 11i</a></li><li><a href="/FND%20Users/">FND Users</a></li></ul></td></tr></tbody></table>
<b><ins>Useful Links</ins></b>


[Blitz Report™ – World’s fastest reporting and data upload for Oracle EBS](https://www.enginatics.com/blitz-report/)

[Oracle Discoverer replacement – importing worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)

[Blitz Report™ Toolkits](https://www.enginatics.com/blitz-report-toolkits/)

[Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)

[Blitz Report™ customers](https://www.enginatics.com/customers/)

[Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)

[Oracle EBS Reporting](https://oracleebsreporting.com/)



© 2024 Enginatics