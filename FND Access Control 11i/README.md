# [FND Access Control 11i](https://www.enginatics.com/reports/fnd-access-control-11i/)
## Description: 
Responsibilites and related data such as users, concurrent programs, menus, functions, forms, data access set and security profiles and associated ledgers and operating units.
This report basically answers all system access related questions. It shows which users or responsibilities have acess to which functions, forms, concurrent programs, ledgers, operating units or inventory organizations.

Depending on parameter selection, this report shows for example:

- responsibilities and related menus and request groups
- responsibilities, menus, included forms, functions and their full menu navigation path
- users and their assigned active responsibilities
- users, assigned responsibilities and the concurrent programs they have access to
- concurrent programs and the responsibilities that they can be run from
- forms or functions and the responsibilities and users that can access them
- responsibilities and navigation paths to access a certain form or function from a given user
- operating units that a particular responsibility or user has access to through MOAC security profiles or profile option 'MO: Operating Unit'

The parameters 'User', 'Form', 'Function' and 'Concurrent Program' are optional and can either be populated to filter records for a particular value only or entered with % to show all values or left blank to not show data related to that parameter. If the user parameter is left blank for example, then the report does not show any user names and shows information related to responsibility level only.

Example: To show all users having access to the user maintenance form, enter parameters as follows:
User Name: %
User Form Name: Define Application User

Please note that the SQL currently doesn't consider menu exclusions yet, which means that it's not 100% accurate as excluded functions would still show up in the report.
## Categories: 
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[FND_Access_Control_11i.xml](https://www.enginatics.com/xml/fnd-access-control-11i/)
# Oracle E-Business Suite - Reporting Library 
    
We provide an open source EBS operational and project implementation support [library](https://www.enginatics.com/library/) for rapid Excel report generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics