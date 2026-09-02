---
layout: default
title: 'INV Item Cross Reference Upload | Oracle EBS SQL Report'
description: 'Creates, updates and deletes item cross references - the Cross Reference Types form (Inventory > Setup > Items > Cross-Reference Types), also reached from…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, INV, Item, Cross, Reference, mtl_cross_references_vl, mtl_system_items_vl, mtl_parameters'
permalink: /INV%20Item%20Cross%20Reference%20Upload/
---

# INV Item Cross Reference Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-cross-reference-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Creates, updates and deletes item cross references - the Cross Reference Types form (Inventory > Setup > Items > Cross-Reference Types), also reached from the Item form via Tools > Cross References.

A cross reference is either organization independent (Applicable To All Organizations is set and Org is blank) or specific to one organization (Org is entered). The organization must be one the item is assigned to.

Revision and Unit of Measure only apply to the GTIN cross reference type named by the profile option INV: GTIN Cross Reference Type, and Revision additionally requires an organization. Entering them for any other type is rejected.

Descriptions are translatable and are downloaded in the session language.

To remove a cross reference, enter Yes in Delete Cross Reference on a downloaded row.

## Report Parameters
Upload Mode, Item, Cross Reference Type, Cross Reference, Organization Code

## Oracle EBS Tables Used
[mtl_cross_references_vl](https://www.enginatics.com/library/?pg=1&find=mtl_cross_references_vl), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_item_revisions_b](https://www.enginatics.com/library/?pg=1&find=mtl_item_revisions_b), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Where Used by Cost Type](/CAC%20Where%20Used%20by%20Cost%20Type/ "CAC Where Used by Cost Type Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item User Defined Attribute Upload](/INV%20Item%20User%20Defined%20Attribute%20Upload/ "INV Item User Defined Attribute Upload Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status But Not Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20But%20Not%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status But Not Ready for Close Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status Which Are Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20Which%20Are%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status Which Are Ready for Close Oracle EBS SQL Report"), [CAC Inventory to G/L Reconciliation (Restricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Restricted by Org Access) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/inv-item-cross-reference-upload/) |
| Blitz Report™ XML Import | [INV_Item_Cross_Reference_Upload.xml](https://www.enginatics.com/xml/inv-item-cross-reference-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-cross-reference-upload/](https://www.enginatics.com/reports/inv-item-cross-reference-upload/) |



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
