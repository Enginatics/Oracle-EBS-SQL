/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
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
lot_no lot,
lot_desc lot_description,
sublot_no sublot,
ipc.location,
grade_code,
iim.item_um item_uom,
iim.item_um2 item_uom2,
ipc.count_no,
mod(ipc.count_no,1000) line_no,
trunc(ipc.count_no/1000) page_no,
ich.print_format
from
ic_phys_cnt ipc,
ic_item_mst iim,
ic_lots_mst ilm,
ic_cycl_hdr ich,
ic_whse_mst iwm
where
1=1 and
iwm.whse_code=ipc.whse_code and
ipc.cycle_id=ich.cycle_id and
ipc.item_id=iim.item_id and
ipc.lot_id=ilm.lot_id  and
ipc.delete_mark=0 and
ilm.item_id=iim.item_id
order by 
&f_order_by