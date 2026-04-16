---
layout: default
title: 'FA Asset Upload | Oracle EBS SQL Report'
description: 'Upload to create, update, and retire fixed assets using FA Public APIs. New assets are created via faadditionpub.doaddition. Existing assets are updated…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Asset, fa_lookups, fa_additions_vl, fa_books'
permalink: /FA%20Asset%20Upload/
---

# FA Asset Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Upload to create, update, and retire fixed assets using FA Public APIs.
New assets are created via fa_addition_pub.do_addition. Existing assets are updated via fa_asset_desc_pub.update_desc, fa_reclass_pub.do_reclass, and fa_adjustment_pub.do_adjustment.
Asset retirements are processed via fa_retirement_pub.do_retirement.
Use the Record Type column to select Addition or Retirement processing.

## Report Parameters
Upload Mode, Book, Asset Number, Category, From Category, To Category, Asset Type, Net Book Value Greater Than, Net Book Value Less Than

## Oracle EBS Tables Used
[fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups), [fa_additions_vl](https://www.enginatics.com/library/?pg=1&find=fa_additions_vl), [fa_books](https://www.enginatics.com/library/?pg=1&find=fa_books), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers), [fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv), [fa_category_books](https://www.enginatics.com/library/?pg=1&find=fa_category_books), [fa_deprn_summary](https://www.enginatics.com/library/?pg=1&find=fa_deprn_summary), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [fa_locations_kfv](https://www.enginatics.com/library/?pg=1&find=fa_locations_kfv), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [fa_asset_keywords_kfv](https://www.enginatics.com/library/?pg=1&find=fa_asset_keywords_kfv), [fa_add_warranties](https://www.enginatics.com/library/?pg=1&find=fa_add_warranties), [fa_warranties](https://www.enginatics.com/library/?pg=1&find=fa_warranties), [fa_leases](https://www.enginatics.com/library/?pg=1&find=fa_leases), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods), [fa_additions_tl](https://www.enginatics.com/library/?pg=1&find=fa_additions_tl), [fa_retirements](https://www.enginatics.com/library/?pg=1&find=fa_retirements)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report"), [FA Asset Book Details 11i](/FA%20Asset%20Book%20Details%2011i/ "FA Asset Book Details 11i Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [FA Cost Adjustments](/FA%20Cost%20Adjustments/ "FA Cost Adjustments Oracle EBS SQL Report"), [FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report"), [FA Asset Retirements](/FA%20Asset%20Retirements/ "FA Asset Retirements Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fa-asset-upload/) |
| Blitz Report™ XML Import | [FA_Asset_Upload.xml](https://www.enginatics.com/xml/fa-asset-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-asset-upload/](https://www.enginatics.com/reports/fa-asset-upload/) |



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
