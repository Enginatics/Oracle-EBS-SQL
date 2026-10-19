---
layout: default
last_modified_at: 2026-10-19
title: 'INV Kanban Cards | Oracle EBS SQL Report'
description: 'Kanban cards with their pull sequence, one row per card, including card type, card status, supply status and card kanban size. Replenishment Cycles and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Kanban, Cards, mtl_item_locations_kfv, mtl_kanban_card_activity, mtl_parameters'
permalink: /INV%20Kanban%20Cards/
report_name: 'INV Kanban Cards'
report_web_name: inv-kanban-cards
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Kanban Cards – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-kanban-cards/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Kanban cards with their pull sequence, one row per card, including card type, card status, supply status and card kanban size. Replenishment Cycles and Last Activity Date are derived from the card activity history. Only production pull sequences are listed, not those of kanban plans.

Pull Sequences Only lists one row per pull sequence without the cards. Show Activity adds one row per card activity (supply status change), with the document that replenished the card.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Item, Subinventory, Source Type, Supplier, Card Number, Card Status, Supply Status, Pull Sequences Only, Show Activity, Activity Date From, Activity Date To

## Oracle EBS Tables Used
[mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [mtl_kanban_card_activity](https://www.enginatics.com/library/?pg=1&find=mtl_kanban_card_activity&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [mtl_kanban_pull_sequences](https://www.enginatics.com/library/?pg=1&find=mtl_kanban_pull_sequences&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [mtl_kanban_cards](https://www.enginatics.com/library/?pg=1&find=mtl_kanban_cards&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [mtl_txn_request_headers](https://www.enginatics.com/library/?pg=1&find=mtl_txn_request_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards)

## Related Reports
[INV Move Orders](/INV%20Move%20Orders/ "INV Move Orders Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Kanban%20Cards/INV%20Kanban%20Cards.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Kanban Cards 15-Oct-2026 022614.xlsx](https://www.enginatics.com/example/inv-kanban-cards/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards) |
| Blitz Report™ XML Import | [INV_Kanban_Cards.xml](https://www.enginatics.com/xml/inv-kanban-cards/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards) |
| SQL Source | [INV Kanban Cards.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Kanban%20Cards/INV%20Kanban%20Cards.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-kanban-cards/](https://www.enginatics.com/reports/inv-kanban-cards/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards) |

## Case Study & Technical Analysis: INV Kanban Cards

### Executive Summary
The INV Kanban Cards report lists the kanban cards of production pull sequences in Oracle Inventory, one row per card. Each row shows the card number and type, the card status and supply status, the kanban size, the supplier or source of replenishment, and the replenishment cycles and last activity of the card. Materials planners and supply chain analysts use it to see which cards are waiting for supply, which cards are stalled, and how often each card has been replenished. The report runs in Excel through Blitz Report, and can optionally list the activity history of each card.

### Business Challenge
*   **Pull replenishment visibility:** Kanban cards signal when stock must be replenished, and a planner needs to know the status of every card at a glance.
*   **Stalled supply:** Cards that remain in an empty or in-process supply status show a replenishment problem that must be escalated to the supplier or production line.
*   **Replenishment history:** The number of replenishment cycles and the time since the last activity show whether a pull sequence is working as designed.
*   **Source traceability:** Each card's replenishment must be traced to the purchase order, requisition, move order or job that supplied it.

### The Solution
*   **Pull sequence base:** Production pull sequences are read with their item, subinventory, locator, source type, supplier, production line, kanban size and replenishment lead time.
*   **Card detail:** Cards are joined to their pull sequences, with their card type, status, supply status, error code, kanban size and print date.
*   **Activity summary:** The replenishment cycle count and the last activity date are derived from the card activity history.
*   **Activity detail:** When requested, each activity is listed with the document that replenished the card, which can be a purchase order, a release, a requisition, a move order or a job.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_KANBAN_PULL_SEQUENCES`: the pull sequence definitions, with source type, supplier, source organization, kanban size and lead time.
*   `MTL_KANBAN_CARDS`: the kanban cards linked to each pull sequence.
*   `MTL_KANBAN_CARD_ACTIVITY`: the activity history of each card, with the replenishing document type and ID.
*   `MTL_SYSTEM_ITEMS_VL`: the item number, description and unit of measure.
*   `MTL_ITEM_LOCATIONS_KFV`: the subinventory locator and the source locator.
*   `MTL_PARAMETERS`: the organization code and the source organization.
*   `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`: the supplier and supplier site.
*   `WIP_LINES`: the production line of the pull sequence.
*   `PO_HEADERS_ALL`, `PO_RELEASES_ALL`, `PO_REQUISITION_HEADERS_ALL` and `MTL_TXN_REQUEST_HEADERS`: the documents that can replenish a card.
*   `WIP_ENTITIES`: the job or schedule that can replenish a card.
*   `ORG_ACCESS_VIEW`: the organizations visible to the current responsibility.

#### Logical Relationships
1.  `MTL_KANBAN_PULL_SEQUENCES` joins to `MTL_PARAMETERS` on the organization ID, restricted to organizations in `ORG_ACCESS_VIEW`, and only production sequences are kept by a condition that the kanban plan ID is -1.
2.  The pull sequence joins to `MTL_SYSTEM_ITEMS_VL` on organization and item, and to the supplier and supplier site through outer joins.
3.  Cards join to their pull sequence on the pull sequence ID, and card activity joins to the card on the card ID.
4.  Each activity's document type selects one of the document tables: 1 for purchase orders, 2 for releases, 3 for requisitions, 4 for move orders, and 5 to 8 for work in process entities.
5.  Output is ordered by organization, item, subinventory, card number and activity date descending.

### Parameters & Filtering
*   **Organization Code**, **Item** and **Subinventory:** select the organization, item and subinventory of the pull sequence.
*   **Source Type** and **Supplier:** limit the sequences by source of replenishment.
*   **Card Number**, **Card Status** and **Supply Status:** filter the cards.
*   **Pull Sequences Only:** when set, the output has one row per pull sequence and no card rows.
*   **Show Activity:** when Y, one row is added for each card activity.
*   **Activity Date From** and **Activity Date To:** bound the activity rows shown when Show Activity is used.

### Performance & Optimization
*   The card and activity subqueries are conditional on the Pull Sequences Only and Show Activity parameters, so the card tables are read only when the output needs them.
*   Replenishment cycles and the last activity date are scalar subqueries keyed on the card ID, which avoids a second grouped pass over the activity table.
*   The document lookups use a `CASE` on the document type, so each activity joins only to the table that matches its document type.
*   The organization restriction is an `IN` subquery on `ORG_ACCESS_VIEW`, applied before the pull sequence joins.

### FAQ
**Q: How do I see only the pull sequences, without the cards?**
A: Set the Pull Sequences Only parameter, which returns one row per pull sequence.

**Q: How is the number of replenishment cycles calculated?**
A: It is the count of distinct replenishment cycle IDs in the card activity history for each card.

**Q: Which documents are shown for a card activity?**
A: The purchase order, release, requisition, move order or work in process job that the activity references, depending on its document type.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-kanban-cards)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
