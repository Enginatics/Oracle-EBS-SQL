/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GMI Cycle Count Forms
-- Description: Imported Oracle standard Cycle Count Forms Report of Oracle OPM PI report
Source: Cycle Count Forms (XML)
Short Name: PIR05_XML
DB package: GMI_PIR05_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/gmi-cycle-count-forms/
-- Library Link: https://www.enginatics.com/reports/gmi-cycle-count-forms/
-- Run Report: https://demo.enginatics.com/

select distinct
ipc.whse_code warehouse,
iwm.whse_name warehouse_description,
ich.cycle_no,
ich.cycle_desc,
item_no item_number,
item_desc1 item_description,
ilm.lot_no lot,
ilm.lot_desc lot_description,
ilm.sublot_no sublot,
ipc.location,
ipc.grade_code,
iimv.item_um item_uom,
iimv.item_um2 item_uom2,
ipc.count_no,
mod(ipc.count_no,1000) line_no,
trunc(ipc.count_no/1000) page_no,
ich.print_format
from
ic_whse_mst iwm,
ic_phys_cnt ipc,
ic_cycl_hdr ich,
ic_item_mst_vl iimv,
ic_lots_mst ilm
where
1=1 and
iwm.whse_code=ipc.whse_code and
ipc.delete_mark=0 and
ipc.cycle_id=ich.cycle_id and
ipc.item_id=iimv.item_id and
ipc.item_id=ilm.item_id and
ipc.lot_id=ilm.lot_id
order by 
count_no