# [FND User Login History](https://www.enginatics.com/reports/fnd-user-login-history/)
## Description: 
Audit history of application user logins.

EBS user logon audit is controlled by profile 'Sign-On:Audit Level'.
The most detailed audit level setting is 'FORM'.
Unfortunately, this audit tracks access to individual forms only, but not to different JSPs (HTML / OAF / ADF Pages).
As a workaround, the report SQL also joins to icx_sessions, which contains a record for each login (in fact, it also stores a record for each access to the login page before login. These records are marked with guest='Y').
The function retrieved from icx_session however, just shows the latest OAF function accessed by the user, not all individual JSP functions accessed within that session.
## Categories: 
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[FND_User_Login_History 20-Jan-2019 122653.xlsx](https://www.enginatics.com/example/fnd-user-login-history/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[FND_User_Login_History.xml](https://www.enginatics.com/xml/fnd-user-login-history/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics