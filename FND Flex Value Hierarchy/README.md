# [FND Flex Value Hierarchy](https://www.enginatics.com/reports/fnd-flex-value-hierarchy/)
## Description: 
Flexfield value hierarchy showing a hierarchical tree of parent and child relations and child ranges.
Parameter 'Parents without Child only' can be used to validate the hierarchy for nodes where the child range does not include a single child value.

The query is based on a treewalk through table fnd_flex_value_norm_hierarchy, which contains one record for every parent node, and a range_attribute column to indicate if the child value low/high range should match either parent nodes or child values.

Where table fnd_flex_value_norm_hierarchy contains one record for each hierarchy node, table fnd_flex_value_hierarchies shows a flat representation of all hierarchy nodes and their lowest child ranges (range_attribute=C). For any lowest child range value, it contains one record for every higher hierarchy, that this child range is included in, up to the topmost hierarchy node. It can be used for example, to validate directly, if a child value is included in a top level hierarchy node.
## Categories: 
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[FND_Flex_Value_Hierarchy 25-Aug-2018 110433.xlsx](https://www.enginatics.com/example/fnd-flex-value-hierarchy/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[FND_Flex_Value_Hierarchy.xml](https://www.enginatics.com/xml/fnd-flex-value-hierarchy/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics