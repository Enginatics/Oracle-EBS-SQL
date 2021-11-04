/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QP Customer Pricing Engine Request
-- Description: This report requests Item Selling Price information by Customer across Price Lists from the Pricing Engine.

The report also displays the Items Costs for the specified Organization, and based on the Unit Selling Price and Item Cost, displays a Margin Analysis.

The report can be run in Summary or Detail Mode.

In Summary Mode, the report will display a summary of Applied Price Lists, List Price, Adjustment Amount, Final Unit Selling Price, Accrual Amount, Charge Amount, Item Cost, and Margin per Customer, requested Price List and Item. Summary Records can be identified in the report with Record Type=Summary

In Detail Mode, in additional to the summary information, the report will include the following reocrd types:
- Detail Record Type which provides a break down of the Price List and Modifier Lines the pricing engine has applied in the calculation of the final unit selling price
- Pricing Attribute Record Type provides details of the Pricing Attributes considered by the Pricing Engine in selecting a specified Price List or Modifier
- Qualifer Attribute Record Type provides details of any Qualifier Attributes considered by the Pricing Engine in selecting a specific Price List or Modifier

Detail Record Types follow the Summary Record Type they apply to
Pricing Attribute and Qualifier Attribute Record Types follow the Detail Record Type they apply to.

Additionally, the report supports the following options

- Use Secondary Price Lists (Yes/No)
  When No, the report will restrict to displaying Prices on the requested Price Lists only
  When Yes, then the report will check for the price on any secondary price lists defined for the requested Price List 

- Expand Price Breaks (Yes/No)
  When No, the report will display the pricing based on the requested Pricing Only
  When Yes, the report will display one line per Price Break to provide an indication of the the unit selling price will vary across the Price Breaks and the impact that may have on margins

- Display Promotional Goods (Buy One Get One free type Promotions))
  When No, the report will not display any Promotional Goods the Customer maybe eligibe to receive
  When Yes, the report will display any Promotional Goods the Customer maybe eligible to receive

- Display Site Pricing Differences
  When No, the report will only check the Pricing Based on the specified Customer Accounts
  When Yes, the report will also check the Pricing based on the specified Ship To/Bill To Locations. 

  If the pricing at the Customer Site is the same as at the Customer Level, only the Customer Level pricing is displayed in the report
  If the pricing at the Customer Site differs to the pricing at the Customer Level, then both the Customer Pricing and Site Pricing is included in the report.
  If a Ship To or Bill To location is not specified, and the Display Site Pricing Differences is set to Yes, the the report will check all active ship to sites for the Customer within the specified Operating Units.

It is also possible to specify some additional Order Qualifiers to be considered by the Pricing Engine. These are: 
- Organization - this is used as the Shipping Warehouse, It also determines from which Items can be slected and also determines the Organization from which the Item Costs are derived.
- Sales Agreement
- Order Source
- Order Type

Lastly the user can specify
- Pricing Request Date
- Pricing Request Quantity
- Currency Code

Unit Selling Price, Item Costs, and extended amounts are all displayed in the specified currency. The user can only select a currency that is supported by the selected Price Lists.

-- Excel Examle Output: https://www.enginatics.com/example/qp-customer-pricing-engine-request/
-- Library Link: https://www.enginatics.com/reports/qp-customer-pricing-engine-request/
-- Run Report: https://demo.enginatics.com/

with xxen_qp_preq_data as
(select
  xml_req.*,
  xml_res.*
 from
  xmltable
    ( '/PRICING_DATA/REQUEST'
      passing xmltype(xxen_qp_preq.get_report_xml_clob)
      columns
        line_number                         number          path 'LNUM',
        customer_or_site                    varchar2(10)    path 'CSFL',
        cust_account_id                     integer         path 'CAID',
        ship_to_site_use_id                 integer         path 'STID',
        bill_to_site_use_id                 integer         path 'BTID',
        item_id                             integer         path 'ITMID',
        -- optional order qualifiers
        order_type_id                       integer         path 'OTID',
        ship_from_org_id                    integer         path 'SFOID',
        payment_term_id                     integer         path 'PTID',
        -- Pricing Request
        price_list_id                       integer         path 'PLID',
        price_list_line_id                  number          path 'PLLID',
        pricing_qty                         number          path 'QTY',
        pricing_qty_uom_code                varchar2(3)     path 'UOM',
        results_xml                         xmltype         path 'RESULTS'
    ) xml_req,
  xmltable
    ( '/RESULTS/ROW'
      passing xml_req.results_xml
      columns
        line_detail_seq                     number          path 'LDSEQ',
        applied_price_list_id               number          path 'APLID',
        secondary_price_list_flag           varchar2(1)     path 'SPLFL',
        promotional_goods_flag              varchar2(1)     path 'PRGFL',
        promotional_goods_item_id           number          path 'PRGID',
        record_type                         varchar2(30)    path 'RT',
        created_from_list_header_id         number          path 'LSTID',
        created_from_list_line_id           number          path 'LLNID',
        line_qty_or_amt                     number          path 'LQTY',
        priced_qty                          number          path 'PQTY',
        priced_uom                          varchar2(3)     path 'PUOM',
        unit_price                          number          path 'PUP',
        adjustment_amount                   number          path 'PADJ',
        adjusted_unit_price                 number          path 'PAUP',
        extended_amount                     number          path 'PEAMT',
        charges_amount                      number          path 'PCAMT',
        accrual_amount                      number          path 'PAAMT',
        cogs_amount                         number          path 'PCOGS',
        benefit                             varchar2(80)    path 'BENFT',
        benefit_method                      varchar2(4000)  path 'BENMT',
        benefit_value                       varchar2(4000)  path 'BENVL',
        benefit_item                        varchar2(360)   path 'BENIT',
        benefit_qty                         number          path 'BENQT',
        operand                             varchar2(80)    path 'OPR',
        operand_value                       number          path 'OPRV',
        price_formula                       varchar2(250)   path 'PFRM',
        currency                            varchar2(3)     path 'CUR',
        base_currency                       varchar2(3)     path 'BCUR',
        multi_currency_flag                 varchar2(1)     path 'MCFL',
        exchange_rate_type                  varchar2(30)    path 'XRTT',
        exchange_rate                       number          path 'XRT',
        product_precedence                  number          path 'PPREC',
        automatic_flag                      varchar2(1)     path 'ATMFL',
        override_flag                       varchar2(1)     path 'OVRFL',
        accrual_flag                        varchar2(1)     path 'ACCFL',
        attribute_level                     varchar2(10)    path 'ALVL',
        attribute_grouping_num              number          path 'AGPN',
        attribute_context                   varchar2(80)    path 'ACTX',
        attribute                           varchar2(80)    path 'ANME',
        attribute_operator                  varchar2(30)    path 'AOPR',
        attribute_value_from                varchar2(240)   path 'AVLFR',
        attribute_value_to                  varchar2(240)   path 'AVTO',
        attribute_precedence                number          path 'APREC'
    ) xml_res
)
--
-- Main Query Starts Here
--
select
  x.*
from
(
select
-- customer
  xxqpd.customer_or_site,
  hp.party_name customer_name,
  hca.account_number account_number,
  hp.party_name || ' - ' || hca.account_number customer_name_and_account,
  nvl(xxen_util.meaning(hp.category_code,'CUSTOMER_CATEGORY',222),hp.category_code) customer_category,
  nvl(xxen_util.meaning(hca.customer_class_code,'CUSTOMER CLASS',222),hca.customer_class_code) customer_class,
  nvl(xxen_util.meaning(hca.sales_channel_code,'SALES_CHANNEL',660),hca.sales_channel_code) sales_channel,
  hcpc.name customer_profile,
  nvl(hcp.discount_terms,'N') customer_allow_discount,
  (select rtv.name
   from   ra_terms_vl rtv
   where  rtv.term_id = nvl(hca.payment_term_id,hcp.standard_terms)
  ) customer_payment_term,
  (select qslhv.name
   from   qp_secu_list_headers_vl qslhv
   where  qslhv.list_header_id = hca.price_list_id
  ) customer_price_list,
-- ship_to/bill to OU
  nvl(haouv1.name,haouv2.name) operating_unit,
-- ship_to site
  hcsua1.location ship_to_location_code,
  hcsua1.location || ' ' || hl1.address1 || ' ' || hl1.address2 || ' ' || hl1.address3 ship_to_location,
  hcsua1.primary_flag ship_to_primary_flag,
  hcpc1.name ship_to_profile,
  (select mp.organization_code
   from mtl_parameters mp
   where mp.organization_id = hcsua1.warehouse_id
  ) ship_to_ship_from_warehouse,
  (select ottt.name
   from   oe_transaction_types_tl  ottt
   where  ottt.transaction_type_id = hcsua1.order_type_id
   and    ottt.language = userenv('lang')
  ) ship_to_order_type,
  (select rtv.name
   from   ra_terms_vl rtv
   where  rtv.term_id = hcsua1.payment_term_id
  )  ship_to_payment_term,
  (select qslhv.name
   from   qp_secu_list_headers_vl qslhv
   where  qslhv.list_header_id = hcsua1.price_list_id
  )  ship_to_price_list,
-- bill_to site
  hcsua2.location bill_to_location_code,
  hcsua2.location || ' ' || hl2.address1 || ' ' || hl2.address2 || ' ' || hl2.address3 bill_to_location,
  hcsua2.primary_flag bill_to_primary_flag,
  hcpc2.name bill_to_profile,
  (select mp.organization_code
   from mtl_parameters mp
   where mp.organization_id = hcsua2.warehouse_id
  ) bill_to_ship_from_warehouse,
  (select ottt.name
   from   oe_transaction_types_tl  ottt
   where  ottt.transaction_type_id = hcsua2.order_type_id
   and    ottt.language = userenv('lang')
  ) bill_to_order_type,
  (select rtv.name
   from   ra_terms_vl rtv
   where  rtv.term_id = hcsua2.payment_term_id
  )  bill_to_payment_term,
  (select qslhv.name
   from   qp_secu_list_headers_vl qslhv
   where  qslhv.list_header_id = hcsua2.price_list_id
  )  bill_to_price_list,
--
hp.party_name        || ' - ' ||
  hca.account_number ||
  nvl2(nvl(hcsua1.location,hcsua2.location),
       ' - ' || nvl(hcsua1.location || ' ' || hl1.address1 || ' ' || hl1.address2 || ' ' || hl1.address3,
                    hcsua2.location || ' ' || hl2.address1 || ' ' || hl2.address2 || ' ' || hl2.address3) ||
       ' - ' || '(' || nvl(haouv1.name,haouv2.name) || ')',
      ''
      ) customer_and_site_org_desc,
-- Price List
  qslhv1.name price_list,
  qslhv1.description price_list_description,
  xxen_util.meaning(qslhv1.list_type_code,'LIST_TYPE_CODE',661) price_list_type,
  qslhv1.currency_code price_list_currency,
  nvl(qslhv1.global_flag,'N') price_list_global_flag,
  haouv3.name price_list_operating_unit,
  (select rtv.name
   from   ra_terms_vl rtv
   where  rtv.term_id = qslhv1.terms_id
  ) price_list_payment_term,
-- pricing request
-- item
  msik.concatenated_segments pricing_item_code,
  msik.description pricing_item_description,
  msik.concatenated_segments || ' - ' || msik.description pricing_item_code_and_descr,
  xxen_qp_preq.get_pricing_date pricing_date,
  xxqpd.pricing_qty,
  xxqpd.pricing_qty_uom_code,
  decode(qll1.list_line_type_code,'PBH','Y') price_break_flag,
  xxen_qp_preq.get_pricing_currency pricing_currency_code,
-- order qualifiers
  xxen_qp_preq.get_agreement_name pricing_agreement_name,
  xxen_qp_preq.get_order_source pricing_order_source,
  (select ottt.name
   from   oe_transaction_types_tl  ottt
   where  ottt.transaction_type_id = xxqpd.order_type_id
   and    ottt.language = userenv('lang')
  ) pricing_order_type,
  (select mp.organization_code
   from mtl_parameters mp
   where mp.organization_id = xxqpd.ship_from_org_id
  ) pricing_warehouse,
  (select rtv.name
   from   ra_terms_vl rtv
   where  rtv.term_id = xxqpd.payment_term_id
  ) pricing_payment_term,
--
-- Pricing Engine Results
--
  qslhv2.name applied_price_list,
  xxqpd.secondary_price_list_flag,
  xxqpd.promotional_goods_flag,
  msik2.concatenated_segments  priced_item,
  msik2.description priced_item_descscription,
  nvl2(xxqpd.promotional_goods_flag,msik.concatenated_segments || ' (P) ','') || msik2.concatenated_segments || ' - ' || msik2.description priced_item_code_and_descr,
  msik2.primary_uom_code priced_item_primary_uom_code,
  xxen_util.meaning(msik.bom_item_type,'BOM_ITEM_TYPE',700) bom_item_type,
  xxen_qp_preq.get_category_set_name category_set,
  &category_set_columns
  cst_cost_api.get_item_cost(1,msik2.inventory_item_id,xxen_qp_preq.get_cost_organization_id,null,xxen_qp_preq.get_cost_type_id,null) priced_item_cost,
  xxen_qp_preq.get_cost_organization_code item_cost_organization,
  case xxqpd.record_type
  when 'S'  then 'Summary'
  when 'D'  then 'Detail'
  when 'QA' then 'Qualifier Attribute'
  when 'PA' then 'Pricing Attribute'
  else xxqpd.record_type
  end record_type,
  qslhv3.name list_name,
  nvl(qll3.list_line_no,xxqpd.created_from_list_line_id) list_line_num,
  xxen_util.meaning(qslhv3.list_type_code,'LIST_TYPE_CODE',661) list_type,
  xxen_util.meaning(qll3.list_line_type_code,'LIST_LINE_TYPE_CODE',661) line_type,
  xxqpd.line_qty_or_amt,
  xxqpd.priced_qty,
  xxqpd.priced_uom,
  xxqpd.unit_price,
  xxqpd.adjustment_amount,
  xxqpd.adjusted_unit_price,
  xxqpd.extended_amount,
  xxqpd.charges_amount,
  xxqpd.accrual_amount,
  xxqpd.cogs_amount,
  case when nvl(xxqpd.cogs_amount,0) = 0
  then to_number(null)
  else (xxqpd.extended_amount - xxqpd.cogs_amount)
  end margin_pre_accrual,
  case when nvl(xxqpd.cogs_amount,0) = 0
  then to_number(null)
  else round((xxqpd.extended_amount - xxqpd.cogs_amount) / xxqpd.cogs_amount * 100,2)
  end margin_pre_accrual_pct,
  case when nvl(xxqpd.cogs_amount,0) = 0
  then to_number(null)
  else (xxqpd.extended_amount + nvl(xxqpd.accrual_amount,0) - xxqpd.cogs_amount)
  end margin_post_accrual,
  case when nvl(xxqpd.cogs_amount,0) = 0
  then to_number(null)
  else round((xxqpd.extended_amount + nvl(xxqpd.accrual_amount,0) - xxqpd.cogs_amount) / xxqpd.cogs_amount * 100,2)
  end margin_post_accrual_pct,
  xxen_util.meaning(qpbv3.price_break_type_code,'PRICE_BREAK_TYPE_CODE',661) pb_type,
  qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING', qpbv3.pricing_attribute_context, qpbv3.pricing_attribute) pb_attribute,
  xxen_util.meaning(qpbv3.comparison_operator_code,'COMPARISON_OPERATOR',661) pb_operator,
  qpbv3.pricing_attr_value_from_number pb_from,
  qpbv3.pricing_attr_value_to_number pb_to,
  xxqpd.benefit,
  xxqpd.benefit_method,
  xxqpd.benefit_value,
  xxqpd.benefit_item,
  xxqpd.benefit_qty,
  xxqpd.operand,
  xxqpd.operand_value,
  xxqpd.price_formula,
  xxqpd.currency,
  xxqpd.base_currency,
  xxqpd.multi_currency_flag,
  xxqpd.exchange_rate_type,
  xxqpd.exchange_rate,
  xxqpd.product_precedence,
  xxqpd.automatic_flag,
  xxqpd.override_flag,
  xxqpd.accrual_flag,
  xxqpd.attribute_level,
  xxqpd.attribute_grouping_num,
  xxqpd.attribute_context,
  xxqpd.attribute,
  xxqpd.attribute_operator,
  xxqpd.attribute_value_from,
  xxqpd.attribute_value_to,
  xxqpd.attribute_precedence,
  -- record sequencing columns
  xxqpd.line_number,
  xxqpd.line_detail_seq
from
  xxen_qp_preq_data            xxqpd,
  -- customer
  hz_cust_accounts             hca,
  hz_parties                   hp,
  hz_customer_profiles         hcp,
  hz_cust_profile_classes      hcpc,
  -- ship to site
  hz_cust_site_uses_all        hcsua1,
  hz_cust_acct_sites_all       hcasa1,
  hz_party_sites               hps1,
  hz_locations                 hl1,
  hr_all_organization_units_vl haouv1,
  hz_customer_profiles         hcp1,
  hz_cust_profile_classes      hcpc1,
  -- bill to site
  hz_cust_site_uses_all        hcsua2,
  hz_cust_acct_sites_all       hcasa2,
  hz_party_sites               hps2,
  hz_locations                 hl2,
  hr_all_organization_units_vl haouv2,
  hz_customer_profiles         hcp2,
  hz_cust_profile_classes      hcpc2,
  -- items
  mtl_system_items_kfv         msik,
  mtl_system_items_kfv         msik2,
  -- requested price list
  qp_secu_list_headers_vl      qslhv1,
  hr_all_organization_units_vl haouv3,
  qp_list_lines                qll1,
  -- applied Price List
  qp_secu_list_headers_vl      qslhv2,
  -- PE PLL/Modifier List headers/list lines
  qp_secu_list_headers_vl      qslhv3,
  qp_list_lines                qll3,
  qp_price_breaks_v            qpbv3
where
-- customer
    hca.cust_account_id           = xxqpd.cust_account_id
and hp.party_id                   = hca.party_id
and hcp.cust_account_id       (+) = hca.cust_account_id
and nvl(hcp.site_use_id,-1)       = -1
and hcpc.profile_class_id     (+) = hcp.profile_class_id
-- ship to site
and hcsua1.site_use_id        (+) = xxqpd.ship_to_site_use_id
and hcasa1.cust_acct_site_id  (+) = hcsua1.cust_acct_site_id
and hps1.party_site_id        (+) = hcasa1.party_site_id
and hl1.location_id           (+) = hps1.location_id
and haouv1.organization_id    (+) = hcsua1.org_id
and hcp1.site_use_id          (+) = hcsua1.site_use_id
and hcpc1.profile_class_id    (+) = hcp1.profile_class_id
-- bill to site
and hcsua2.site_use_id        (+) = xxqpd.bill_to_site_use_id
and hcasa2.cust_acct_site_id  (+) = hcsua2.cust_acct_site_id
and hps2.party_site_id        (+) = hcasa2.party_site_id
and hl2.location_id           (+) = hps2.location_id
and haouv2.organization_id    (+) = hcsua2.org_id
and hcp2.site_use_id          (+) = hcsua2.site_use_id
and hcpc2.profile_class_id    (+) = hcp2.profile_class_id
-- item msik = requested item, msik2 = priced item
and msik.inventory_item_id        = xxqpd.item_id
and msik.organization_id          = xxen_qp_preq.get_item_organization_id
and msik2.inventory_item_id       = nvl(xxqpd.promotional_goods_item_id,xxqpd.item_id)
and msik2.organization_id         = xxen_qp_preq.get_item_organization_id
-- requested price list
and qslhv1.list_header_id         = xxqpd.price_list_id
and haouv3.organization_id    (+) = qslhv1.orig_org_id
and qll1.list_line_id             = xxqpd.price_list_line_id
-- applied price list
and qslhv2.list_header_id     (+) = xxqpd.applied_price_list_id
-- PE PLL/Modifier List headers/list lines
and qslhv3.list_header_id     (+) = xxqpd.created_from_list_header_id
and qll3.list_header_id       (+) = xxqpd.created_from_list_header_id
and qll3.list_line_id         (+) = xxqpd.created_from_list_line_id
and qpbv3.list_header_id      (+) = xxqpd.created_from_list_header_id
and qpbv3.list_line_id        (+) = xxqpd.created_from_list_line_id
) x
where
1=1
order by
  x.customer_name,
  x.account_number,
  x.pricing_item_code,
  x.price_list,
  x.customer_or_site,
  x.operating_unit,
  x.ship_to_location,
  x.bill_to_location,
  x.line_number,
  x.line_detail_seq