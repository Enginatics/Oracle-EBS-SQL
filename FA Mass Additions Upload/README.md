---
layout: default
title: 'FA Mass Additions Upload | Oracle EBS SQL Report'
description: 'Maintains Oracle Assets Prepare Mass Additions queue lines. Use the Operation column to choose what each row does: Update (change fields and/or Queue)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Mass, Additions, fa_lookups, fa_categories_b_kfv, gl_code_combinations_kfv'
permalink: /FA%20Mass%20Additions%20Upload/
---

# FA Mass Additions Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-mass-additions-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Maintains Oracle Assets Prepare Mass Additions queue lines.

Use the Operation column to choose what each row does: Update (change fields and/or Queue), Create (add a new mass addition line), Merge, Split, Unsplit, Add to Asset or Undo Add to Asset.

Queue (Post, On Hold, Delete, On-Review) sets the posting status of the line on an Update.

Merge combines the lines that share a Merge Group label into the one row marked Primary Line = Yes; that line is kept as the asset and accumulates the cost of the other lines (and their units when Sum Units = Yes), and is set to On Hold.

After uploading, run the standard Post Mass Additions program to create the assets, exactly as today. Existing lines are matched on Book plus Invoice Number, Distribution Line and Invoice Line.

## Report Parameters
Upload Mode, Book

## Oracle EBS Tables Used
[fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [fa_locations_kfv](https://www.enginatics.com/library/?pg=1&find=fa_locations_kfv), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b), [fa_mass_additions](https://www.enginatics.com/library/?pg=1&find=fa_mass_additions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report"), [FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PA Project Asset Upload](/PA%20Project%20Asset%20Upload/ "PA Project Asset Upload Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/fa-mass-additions-upload/) |
| Blitz Report™ XML Import | [FA_Mass_Additions_Upload.xml](https://www.enginatics.com/xml/fa-mass-additions-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-mass-additions-upload/](https://www.enginatics.com/reports/fa-mass-additions-upload/) |



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
