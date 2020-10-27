# [OKS Service Contracts Billing History](https://www.enginatics.com/reports/oks-service-contracts-billing-history/)
## Description: 
Service Contracts billing history with invoicing and accounting rules, bill action, billed period dates, amounts and counter reading details for usage billing.
When running service contracts billing, there is always a full set of records created in the following billing history tables: 

oks_bill_cont_lines obcl
oks_bill_sub_lines obsl
oks_bill_sub_line_dtls obsld
oks_bill_transactions obt
oks_bill_txn_lines obtl

This set of records is complete down to subline level obsl/obsld, regardless if the billed contract line type has a subline or not.
For subscription lines (lse_id=46, lty_code='SUBSCRIPTION') without a subline, for example, both obcl and obsl point their cle_id to the same line in okc_k_lines_b instead of different line and subline.

Unique identifier for the billing entry is obtl.bill_instance_number, which links to receivables line rctla.interface_line_attribute3.
When driving queries from the OKS side, make sure to include a to_char() conversion for the numeric obtl.bill_instance_number, to enable index use on character type rctla.interface_line_attribute3.

The OKS billing history does not have a link to the originating billing schedule record in oks_level_elements (see https://www.enginatics.com/reports/oks-service-contracts-billing-schedule/)

An overview of oracle service contracts and other line types can be found here: https://www.enginatics.com/reports/okc-contract-lines-summary/

oks_billing_history_v
## Categories: 
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[OKS_Service_Contracts_Billing_History 14-Oct-2020 080331.xlsx](https://www.enginatics.com/example/oks-service-contracts-billing-history/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[OKS_Service_Contracts_Billing_History.xml](https://www.enginatics.com/xml/oks-service-contracts-billing-history/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics