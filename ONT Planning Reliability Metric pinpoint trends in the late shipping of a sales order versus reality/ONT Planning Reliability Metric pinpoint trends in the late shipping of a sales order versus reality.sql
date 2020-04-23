/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT - Planning Reliability Metric - pinpoint trends in the late shipping of a sales order versus reality
-- Description: Legging metric for trend / plan relaibility analysis on schedule ship date and promise date

Use this to pinpoint trends in the late shipping of a sales order versus reality
-- Excel Examle Output: https://www.enginatics.com/example/ont-planning-reliability-metric-pinpoint-trends-in-the-late-shipping-of-a-sales-order-versus-reality/
-- Library Link: https://www.enginatics.com/reports/ont-planning-reliability-metric-pinpoint-trends-in-the-late-shipping-of-a-sales-order-versus-reality/
-- Run Report: https://demo.enginatics.com/

 SELECT OEH.ORDER_NUMBER ,
       OEL.LINE_NUMBER LINE,
       OEL.ORDERED_ITEM ,
       MSI.PLANNER_CODE PLANNER,
       OEL.SCHEDULE_SHIP_DATE SSD_NOW,
       lag(AUD.schedule_ship_date, 1) OVER(ORDER BY AUD.line_id) HISTORICAL_SHIP_DATE,
       lag(AUD.promise_date, 1) OVER(ORDER BY AUD.line_id) HISTORICAL_PROMISE_DATE

  FROM OE_ORDER_HEADERS_ALL   OEH,
       OE_ORDER_LINES_ALL_AC1 AUD, -- Audit View
       OE_ORDER_LINES_ALL     OEL,
       MTL_SYSTEM_ITEMS_B MSI

 WHERE 1=1     
   AND AUD.LINE_ID = OEL.LINE_ID
   AND OEL.HEADER_ID = OEH.HEADER_ID
   AND MSI.SEGMENT1=OEL.ORDERED_ITEM
   AND MSI.ORGANIZATION_ID = OEL.SHIP_FROM_ORG_ID
   AND OEL.schedule_arrival_date IS NOT NULL
  -- AND OEL.LINE_NUMBER = 2
   --AND ORDER_NUMBER='69362'