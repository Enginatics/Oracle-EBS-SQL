# [FND User Login History](https://www.enginatics.com/reports/fnd-user-login-history/)
## Description: 
Audit history of application user logins.

EBS user logon audit is controlled by profile 'Sign-On:Audit Level'.
The most detailed audit level setting is 'FORM'.
Unfortunately, this audit tracks access to individual forms only, but not to different JSPs (HTML / OAF / ADF Pages).
As a workaround, the report SQL also joins to icx_sessions, which contains a record for each login (in fact, it also stores a record for each access to the login page before login. These records are marked with guest='Y').
The function retrieved from icx_session however, just shows the latest OAF function accessed by the user, not all individual JSP functions accessed within that session.
## Categories: 
[Application](https://www.enginatics.com/library/?pg=1&category[]=Application), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[FND_User_Login_History 20-Jan-2019 122653.xlsx](https://www.enginatics.com/example/fnd-user-login-history/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_FND_User_Login_History.sql](https://www.enginatics.com/export/fnd-user-login-history/)\
[rep_FND_User_Login_History.xml](https://www.enginatics.com/xml/fnd-user-login-history/)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/), which is the fastest reporting solution for Oracle EBS. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) Blitz Report and use it [free](https://www.enginatics.com/pricing/) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/), check our [blog](https://www.enginatics.com/blog/) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics