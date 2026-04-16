/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Movement Statistics
-- Description: Imported from BI Publisher
Description: Movement Statistics Report (INTRASTAT Report)
Application: Inventory
Source: Movement Statistics Report (XML)
Short Name: INVSTMVT_XML
DB package: INV_INVSTMVT_XMLP_PKG
Reports movement statistics for EU Intrastat compliance including arrivals, dispatches, and adjustments with detailed commodity, territory, and trader information.
-- Excel Examle Output: https://www.enginatics.com/example/inv-movement-statistics/
-- Library Link: https://www.enginatics.com/reports/inv-movement-statistics/
-- Run Report: https://demo.enginatics.com/

select distinct
x.*,
-- Report Title based on Movement Type and Report Option
case
when :p_report_option in ('S/S','O/S') and x.movement_type='A' then 'Arrival Movement Statistics Summary'
when :p_report_option='S/D' and x.movement_type='A' then 'Arrival Movement Statistics Detail'
when :p_report_option in ('S/S','O/S') and x.movement_type='AA' then 'Arrival Adjustment Movement Statistics Summary'
when :p_report_option='S/D' and x.movement_type='AA' then 'Arrival Adjustment Movement Statistics Detail'
when :p_report_option in ('S/S','O/S') and x.movement_type='D' then 'Dispatch Movement Statistics Summary'
when :p_report_option='S/D' and x.movement_type='D' then 'Dispatch Movement Statistics Detail'
when :p_report_option in ('S/S','O/S') and x.movement_type='DA' then 'Dispatch Adjustment Movement Statistics Summary'
when :p_report_option='S/D' and x.movement_type='DA' then 'Dispatch Adjustment Movement Statistics Detail'
end report_title,
-- Legal Entity Information
gllv.legal_entity_name,
hl.address_line_1 entity_address_line_1,
hl.address_line_2 entity_address_line_2,
hl.address_line_3 entity_address_line_3,
hl.telephone_number_1,
hl.telephone_number_2,
ppf.full_name contact_person_name,
inv_mgd_mvt_utils_pkg.get_org_vat_number(x.legal_entity_id,sysdate) vat_registration_number,
gllv.ledger_name set_of_books_name,
-- Tax Office Information
mstu.tax_office_name,
mstu.weight_uom_code standard_uom,
nvl(hlt.address_line_1,hzl.address1) tax_office_address_line_1,
nvl(hlt.address_line_2,hzl.address2) tax_office_address_line_2,
nvl(hlt.address_line_3,hzl.address3) tax_office_address_line_3,
-- Period Information
gp.start_date period_start_date,
gp.end_date period_end_date,
-- Parameter Display Values
(select mezv.zone_display_name from mtl_economic_zones_vl mezv where mezv.zone_code=x.zone_code) zone_name,
(select
flv_rep.meaning
from
fnd_lookup_values flv_rep
where
flv_rep.lookup_type='INTRASTAT_REPORT_OPTION' and
flv_rep.lookup_code=:p_report_option and
flv_rep.language=userenv('LANG')
) report_option_meaning,
(select flv_mv.meaning from fnd_lookups flv_mv where flv_mv.lookup_type='MVT_MOVEMENT_TYPE' and flv_mv.lookup_code=x.movement_type) movement_type_meaning,
flv_usage.meaning usage_type_meaning,
flv_stat.meaning stat_type_meaning,
:p_currency_code currency_code,
:p_exchange_rate exchange_rate
from
(
select
mms.parent_movement_id,
mms.invoice_id,
mms.movement_id,
mms.transaction_nature,
mms.delivery_terms,
mms.period_name,
mms.entity_org_id legal_entity_id,
mms.usage_type,
mms.stat_type,
mms.zone_code,
    -- Territory codes with Germany special handling
    case
         when (mms.movement_type in ('A','DA') and mms.destination_territory_code='DE') or
              (mms.movement_type in ('D','AA') and mms.dispatch_territory_code='DE')
         then mms.dispatch_territory_code
         else mms.dispatch_territory_eu_code||'-'||mms.dispatch_territory_code
    end dispatch_terr_eu_code,
    case
         when (mms.movement_type in ('A','DA') and mms.destination_territory_code='DE') or
              (mms.movement_type in ('D','AA') and mms.dispatch_territory_code='DE')
         then mms.destination_territory_code
         else mms.destination_territory_eu_code||'-'||mms.destination_territory_code
    end destination_terr_eu_code,
    case
         when (mms.movement_type in ('A','DA') and mms.destination_territory_code='DE') or
              (mms.movement_type in ('D','AA') and mms.dispatch_territory_code='DE')
         then mms.origin_territory_code
         else mms.origin_territory_eu_code||'-'||mms.origin_territory_code
    end origin_terr_eu_code,
    -- Parent Movement Territory Code
    case
      when mms.movement_type in ('A','DA') then
        case when substr(mms.destination_territory_eu_code||'-'||mms.destination_territory_code,
                         instr(mms.destination_territory_eu_code||'-'||mms.destination_territory_code,'-',1,1)+1)='DE'
             then substr(mms.dispatch_territory_eu_code||'-'||mms.dispatch_territory_code,
                        instr(mms.dispatch_territory_eu_code||'-'||mms.dispatch_territory_code,'-',1,1)+1)
             else mms.dispatch_territory_eu_code||'-'||mms.dispatch_territory_code
        end
      when mms.movement_type in ('D','AA') then
        case when substr(mms.dispatch_territory_eu_code||'-'||mms.dispatch_territory_code,
                         instr(mms.dispatch_territory_eu_code||'-'||mms.dispatch_territory_code,'-',1,1)+1)='DE'
             then substr(mms.destination_territory_eu_code||'-'||mms.destination_territory_code,
                        instr(mms.destination_territory_eu_code||'-'||mms.destination_territory_code,'-',1,1)+1)
             else mms.destination_territory_eu_code||'-'||mms.destination_territory_code
        end
    end parent_mvt_terr_code,
mms.area,
mms.port,
mms.inventory_item_id,
mms.organization_id,
mms.document_source_type,
round((mms.item_cost*:p_exchange_rate),nvl(fc.extended_precision,2)) item_cost,
mms.item_description,
mms.document_reference,
mms.document_line_reference,
mms.invoice_batch_reference,
mms.invoice_reference,
mms.invoice_line_reference,
mms.transaction_date,
mms.transaction_uom_code,
round((mms.currency_conversion_rate*:p_exchange_rate),5) currency_conversion_rate,
mms.currency_code movement_currency_code,
mms.outside_code,
mms.customer_vat_number vat_num,
mms.report_reference,
mms.transport_mode,
mms.customer_name,
mms.transacting_from_org,
mms.transacting_to_org,
mms.vendor_name,
mms.ship_to_customer_id,
mms.ship_to_site_use_id,
mms.vendor_id,
mms.vendor_site_id,
mms.from_organization_id,
mms.to_organization_id,
mms.customer_number,
mms.vendor_number,
mms.customer_location,
mms.vendor_site,
mms.po_header_id,
mms.order_header_id,
mms.po_line_id,
mms.order_line_id,
mms.invoice_batch_id,
mms.alternate_uom_code,
mms.movement_status,
mms.shipment_reference,
mms.po_line_location_id,
mms.shipment_line_reference,
mms.shipment_line_id,
mms.receipt_reference,
mms.pick_slip_reference,
mms.picking_line_id,
mms.invoice_date_reference,
mms.shipment_header_id,
mms.comments,
mms.container_type_code container,
mms.statistical_procedure_code statistical_procedure,
mms.customer_trx_line_id,
mms.movement_type,
mms.requisition_header_id,
mms.requisition_line_id,
mms.mtl_transaction_id,
mms.distribution_line_number,
mms.rcv_transaction_id,
mms.commodity_code,
mms.commodity_description,
msi.primary_uom_code,
   mstl.description item_desc,
    fl.meaning document_source_meaning,
    msi.concatenated_segments item_flex,
    pr.release_num release_number,
    nvl(fc2.precision,2) precision_trx,
    nvl(sum(mms.alternate_quantity) over (partition by mms.parent_movement_id),
        sum(mms.transaction_quantity) over (partition by mms.parent_movement_id)) parent_mvt_quantity,
    nvl(mms.alternate_uom_code,mms.transaction_uom_code) parent_mvt_uom,
    sum(mms.transaction_quantity) over(partition by mms.parent_movement_id) transaction_quantity,
    sum(mms.alternate_quantity) over(partition by mms.parent_movement_id) alternate_quantity,
    sum(mms.primary_quantity) over(partition by mms.parent_movement_id) primary_quantity,
    sum(mms.invoice_quantity) over(partition by mms.parent_movement_id) invoice_quantity,
    case
         when (mms.movement_type in ('A','DA') and mms.destination_territory_code='DE') or
              (mms.movement_type in ('D','AA') and mms.dispatch_territory_code='DE')
         then inv_mgd_mvt_utils_pkg.round_number(sum(mms.total_weight) over(partition by mms.parent_movement_id),0,'NORMAL')
         else inv_mgd_mvt_utils_pkg.round_number(sum(mms.total_weight) over(partition by mms.parent_movement_id),:p_rep_precision,:p_rep_rounding)
    end total_weight,
    sum(mms.invoice_line_ext_value) over(partition by mms.parent_movement_id) invoice_line_ext_value,
    sum(mms.document_line_ext_value) over(partition by mms.parent_movement_id) document_line_ext_value,
    sum(mms.outside_ext_value) over(partition by mms.parent_movement_id) outside_ext_value,
    case
         when (mms.movement_type in ('A','DA') and mms.destination_territory_code='DE') or
              (mms.movement_type in ('D','AA') and mms.dispatch_territory_code='DE')
         then case
                   when ((sum(mms.movement_amount) over (partition by mms.parent_movement_id))*:p_exchange_rate) between 0 and 0.5
                   then 1
                   else inv_mgd_mvt_utils_pkg.round_number((sum(mms.movement_amount) over (partition by mms.parent_movement_id))*:p_exchange_rate,0,'NORMAL')
              end
         else inv_mgd_mvt_utils_pkg.round_number((sum(mms.movement_amount) over (partition by mms.parent_movement_id))*:p_exchange_rate,:p_rep_precision,:p_rep_rounding)
    end transaction_value,
    case
         when (mms.movement_type in ('A','DA') and mms.destination_territory_code='DE') or
              (mms.movement_type in ('D','AA') and mms.dispatch_territory_code='DE')
         then case
                 when ((sum(mms.stat_ext_value) over (partition by mms.parent_movement_id))*:p_exchange_rate) between 0 and 0.5
                 then 1
                 else inv_mgd_mvt_utils_pkg.round_number((sum(mms.stat_ext_value) over (partition by mms.parent_movement_id))*:p_exchange_rate,0,'NORMAL')
              end
         else inv_mgd_mvt_utils_pkg.round_number((sum(mms.stat_ext_value) over (partition by mms.parent_movement_id))*:p_exchange_rate,:p_rep_precision,:p_rep_rounding)
    end statistical_value,
    round(sum(mms.outside_ext_value) over (partition by mms.parent_movement_id),nvl(fc2.precision,2)) outside_value_r,
    round(sum(mms.document_line_ext_value) over (partition by mms.parent_movement_id),nvl(fc2.precision,2)) document_line_ext_val_r,
    round(sum(mms.invoice_line_ext_value) over (partition by mms.parent_movement_id),nvl(fc2.precision,2)) invoice_line_ext_val_r,
    -- Trader Type
    case
      when :p_report_option='S/D' then
        case
          when mms.document_source_type in ('SO','RMA') then 'Customer'
          when mms.document_source_type in ('PO','RTV') then 'Vendor'
          when mms.document_source_type in ('IO','INV','IRET') then 'Organization'
          when mms.document_source_type='MISC' then
            case
              when mms.customer_name is not null then 'Customer'
              when mms.vendor_name is not null then 'Vendor'
              when mms.transacting_from_org is not null or mms.transacting_to_org is not null then 'Organization'
            end
        end
    end trader_type,
    case
      when :p_report_option='S/D' then
        case
          when mms.document_source_type in ('SO','RMA') then nvl(mms.customer_number,hca.account_number)
          when mms.document_source_type in ('PO','RTV') then mms.vendor_number
          when mms.document_source_type='MISC' then nvl(mms.customer_number,mms.vendor_number)
        end
    end trader_number,
    case
      when :p_report_option='S/D' then
        case
          when mms.document_source_type in ('SO','RMA') then nvl(mms.customer_location,hcsu.location)
          when mms.document_source_type in ('PO','RTV') then mms.vendor_site
          when mms.document_source_type='MISC' then
            case when mms.customer_name is not null then mms.customer_location
                 when mms.vendor_name is not null then mms.vendor_site
            end
        end
    end trader_site,
    case
      when :p_report_option='S/D' then
        case
          when mms.document_source_type in ('SO','RMA') then nvl(mms.customer_name,hp.party_name)
          when mms.document_source_type in ('PO','RTV') then mms.vendor_name
          when mms.document_source_type in ('IO','INV') then
            case when mms.movement_type in ('A','AA') then hou_from.name
            else hou_to.name
            end
          when mms.document_source_type='IRET' then
            case when mms.movement_type in ('D','AA') then hou_to.name
            else hou_from.name
            end
          when mms.document_source_type='MISC' then
            coalesce(mms.customer_name,mms.vendor_name,mms.transacting_from_org,mms.transacting_to_org)
        end
    end trader_name,
    case
      when :p_report_option='S/D' then
        case
          when mms.document_source_type='MISC' then mms.document_reference
          when mms.document_source_type in ('PO','RTV') then ph.segment1
          when mms.document_source_type in ('SO','RMA') then to_char(oh.order_number)
          when mms.document_source_type='IO' then
            case when mms.movement_type='A' then prh.segment1
            else to_char(oh.order_number)
            end
          when mms.document_source_type='IRET' then
            case when mms.movement_type in ('D','AA') then prh.segment1
            else to_char(oh.order_number)
            end
          when mms.document_source_type='INV' then to_char(mms.mtl_transaction_id)
        end
    end source_number,
    case
      when :p_report_option='S/D' then
        case
          when mms.document_source_type='MISC' then mms.document_line_reference
          when mms.document_source_type in ('PO','RTV') then to_char(pl.line_num)
          when mms.document_source_type in ('SO','RMA') then to_char(ol.line_number)
          when mms.document_source_type='IO' then
            case when mms.movement_type='A' then to_char(prl.line_num)
            else to_char(ol.line_number)
            end
          when mms.document_source_type='IRET' then
            case when mms.movement_type in ('D','AA') then to_char(prl.line_num)
            else to_char(ol.line_number)
            end
        end
    end source_line_number,
    case
      when :p_report_option='S/D' then
        case
          when mms.document_source_type='MISC' then mms.invoice_reference
          when mms.document_source_type in ('PO','RTV') and mms.invoice_id is not null then ai.invoice_num
          when mms.document_source_type in ('SO','RMA') and mms.invoice_id is not null then
            nvl(rct.trx_number,
                case when mms.movement_type='A' then ai.invoice_num end)
          when mms.document_source_type='IO' and mms.movement_type='A' and mms.invoice_id is not null then ai.invoice_num
          when mms.document_source_type='IO' and mms.movement_type='D' and mms.invoice_id is not null then rct.trx_number
          when mms.document_source_type='IRET' and mms.movement_type in ('D','AA') and mms.invoice_id is not null then ai.invoice_num
          when mms.document_source_type='IRET' and mms.movement_type in ('A','DA') and mms.invoice_id is not null then rct.trx_number
        end
    end invoice_number,
    case
      when :p_report_option='S/D' then
        case
          when mms.document_source_type='MISC' then
            case when mms.movement_type in ('A','AA') then mms.receipt_reference else mms.pick_slip_reference end
          when mms.document_source_type in ('PO','RTV','RMA') and mms.shipment_header_id is not null then rsh.receipt_num
          when mms.document_source_type='SO' then mms.shipment_reference
        end
    end receipt_number,
    case
      when :p_report_option='S/D' then
        case
          when mms.document_source_type='MISC' then mms.shipment_reference
          when mms.document_source_type in ('PO','RTV') then to_char(pll.shipment_num)
        end
    end shipment_number,
    case
      when :p_report_option='S/D' then
        case
          when mms.document_source_type='MISC' then mms.shipment_line_reference
          when mms.document_source_type in ('PO','RTV') then to_char(rsl.line_num)
        end
    end shipment_line,
    case
      when :p_report_option='S/D' then
        nvl(rctl.uom_code,mms.transaction_uom_code)
    end invoice_uom_code,
    case
      when :p_report_option='S/D' then
        case
          when mms.document_source_type='MISC' then mms.invoice_line_reference
          when mms.document_source_type in ('PO','RTV') or (mms.document_source_type='SO' and mms.movement_type='A') then
            to_char(mms.distribution_line_number)
          when mms.document_source_type='RMA' or (mms.document_source_type='SO' and mms.movement_type='D') then
            to_char(rctl.line_number)
          when (mms.document_source_type='IO' and mms.movement_type='A') or (mms.document_source_type='IRET' and mms.movement_type in ('D','AA')) then
            to_char(mms.distribution_line_number)
          when (mms.document_source_type='IO' and mms.movement_type='D') or (mms.document_source_type='IRET' and mms.movement_type in ('A','DA')) then
            to_char(rctl.line_number)
        end
    end invoice_line_number
from
mtl_movement_statistics mms,
mtl_system_items_kfv msi,
fnd_lookups fl,
mtl_system_items_tl mstl,
fnd_currencies fc,
fnd_currencies fc2,
rcv_transactions rt,
po_releases_all pr,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsu,
hr_organization_units hou_from,
hr_organization_units hou_to,
po_headers_all ph,
oe_order_headers_all oh,
po_requisition_headers_all prh,
po_lines_all pl,
oe_order_lines_all ol,
po_requisition_lines_all prl,
ap_invoices_all ai,
ra_customer_trx_all rct,
rcv_shipment_headers rsh,
po_line_locations_all pll,
rcv_shipment_lines rsl,
ra_customer_trx_lines_all rctl
where
mms.inventory_item_id=msi.inventory_item_id(+) and
mms.organization_id=msi.organization_id(+) and
msi.inventory_item_id=mstl.inventory_item_id(+) and
msi.organization_id=mstl.organization_id(+) and
mstl.language(+)=userenv('LANG') and
fl.lookup_type='MVT_SOURCE_DOCUMENT_TYPES' and
fl.lookup_code=mms.document_source_type and
fc2.currency_code(+)=mms.currency_code and
rt.transaction_id(+)=mms.rcv_transaction_id and
pr.po_release_id(+)=rt.po_release_id and
hca.cust_account_id(+)=mms.ship_to_customer_id and
hp.party_id(+)=hca.party_id and
hcsu.site_use_id(+)=mms.ship_to_site_use_id and
hou_from.organization_id(+)=mms.from_organization_id and
hou_to.organization_id(+)=mms.to_organization_id and
ph.po_header_id(+)=mms.po_header_id and
oh.header_id(+)=mms.order_header_id and
prh.requisition_header_id(+)=mms.requisition_header_id and
pl.po_line_id(+)=mms.po_line_id and
ol.line_id(+)=mms.order_line_id and
prl.requisition_line_id(+)=mms.requisition_line_id and
ai.invoice_id(+)=mms.invoice_id and
rct.customer_trx_id(+)=mms.invoice_id and
rsh.shipment_header_id(+)=mms.shipment_header_id and
pll.line_location_id(+)=mms.po_line_location_id and
rsl.shipment_line_id(+)=mms.shipment_line_id and
rctl.customer_trx_line_id(+)=mms.customer_trx_line_id and
1=1 and
mms.movement_status in ('O','V') and
(
  (mms.movement_type in ('A','D') and mms.parent_movement_id=mms.movement_id)
  or
  (mms.movement_type not in ('A','D') and mms.movement_id=(
select min(mms2.movement_id)
from mtl_movement_statistics mms2
where mms2.parent_movement_id=mms.parent_movement_id and
mms2.movement_type=mms.movement_type
  ))
)
) x,
gl_ledger_le_v gllv,
hr_locations_no_join hl,
per_people_f ppf,
mtl_stat_type_usages mstu,
hr_locations_no_join hlt,
hz_locations hzl,
gl_periods gp,
fnd_lookups flv_usage,
fnd_lookups flv_stat
where
2=2 and
gp.period_name=x.period_name and
mstu.stat_type=x.stat_type and
mstu.usage_type=x.usage_type and
mstu.zone_code=x.zone_code and
flv_usage.lookup_type='MVT_USAGE_TYPES' and
flv_usage.lookup_code=mstu.usage_type and
flv_stat.lookup_type='MVT_STAT_TYPES' and
mstu.stat_type=flv_stat.lookup_code and
gllv.legal_entity_id=x.legal_entity_id and
gllv.legal_entity_id=mstu.legal_entity_id and
gllv.ledger_category_code='PRIMARY' and
gllv.location_id=hl.location_id(+) and
hl.designated_receiver_id=ppf.person_id(+) and
mstu.tax_office_location_id=hlt.location_id(+) and
mstu.tax_office_location_id=hzl.location_id(+)
order by
x.commodity_code,
x.parent_movement_id,
x.movement_id,
x.transport_mode,
x.transaction_nature,
x.dispatch_terr_eu_code,
x.destination_terr_eu_code