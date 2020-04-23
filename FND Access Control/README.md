# [FND Access Control](https://www.enginatics.com/reports/fnd-access-control/)
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
[Application](https://www.enginatics.com/library/?pg=1&category[]=Application), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12+only), [Setup](https://www.enginatics.com/library/?pg=1&category[]=Setup)
# Report Example
[FND_Access_Control 11-May-2017 081848.xlsx](https://www.enginatics.com/example/fnd-access-control/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_FND_Access_Control.sql](https://www.enginatics.com/export/fnd-access-control/)\
[rep_FND_Access_Control.xml](https://www.enginatics.com/xml/fnd-access-control/)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/), which is the fastest reporting solution for Oracle EBS. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) Blitz Report and use it [free](https://www.enginatics.com/pricing/) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/), check our [blog](https://www.enginatics.com/blog/) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/)

© 2020 Enginatics