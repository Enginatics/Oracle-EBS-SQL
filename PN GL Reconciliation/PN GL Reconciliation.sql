/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PN GL Reconciliation
-- Description: Application: Property Manager
Report: PN GL Reconciliation

-- Excel Examle Output: https://www.enginatics.com/example/pn-gl-reconciliation/
-- Library Link: https://www.enginatics.com/reports/pn-gl-reconciliation/
-- Run Report: https://demo.enginatics.com/

with
q_trx as
(select
  x.*
 from
  xmltable
    ( '/TRX/ROW'
      passing xxen_pn.get_xxpnglrec_trx_xml
      columns
        line_source                      varchar2(10)   path 'line_source'
      , period                           varchar2(30)   path 'period'
      , primary_ledger                   varchar2(30)   path 'primary_ledger'
      , primary_ledger_id                number         path 'primary_ledger_id'
      , primary_ledger_curr              varchar2(3)    path 'primary_ledger_curr'
      , sla_ledger                       varchar2(30)   path 'sla_ledger'
      , sla_ledger_id                    number         path 'sla_ledger_id'
      , sla_ledger_curr                  varchar2(3)    path 'sla_ledger_curr'
      , company_code                     varchar2(30)   path 'company_code'
      , operating_unit                   varchar2(240)  path 'operating_unit'
      , org_id                           number         path 'org_id'
      , entered_curr                     varchar2(3)    path 'entered_curr'
      , lease_id                         number         path 'lease_id'
      , lease_num                        varchar2(30)   path 'lease_num'
      , lease_name                       varchar2(50)   path 'lease_name'
      , booking_date                     date           path 'booking_date'
      , approval_status                  varchar2(100)  path 'approval_status'
      , accounting_method                varchar2(100)  path 'accounting_method'
      , interest_index                   varchar2(100)  path 'interest_index'
      , interest_rate                    number         path 'interest_rate'
      , responsible_user                 varchar2(100)  path 'responsible_user'
      , commencement_date                date           path 'commencement_date'
      , termination_date                 date           path 'termination_date'
      , duration                         number         path 'duration'
      , proration_rule                   varchar2(100)  path 'proration_rule'
      , lessor_name                      varchar2(100)  path 'lessor_name'
      , pn_trx_id                        number         path 'pn_trx_id'
      , pn_trx_lease_change_id           number         path 'pn_trx_lease_change_id'
      , pn_trx_num                       varchar2(100)  path 'pn_trx_num'
      , pn_event_id                      number         path 'pn_event_id'
      , pn_trx_type                      varchar2(100)  path 'pn_trx_type'
      , pn_trx_date                      date           path 'pn_trx_date'
      , pn_trx_regime                    varchar2(100)  path 'pn_trx_regime'
      , pn_trx_status                    varchar2(100)  path 'pn_trx_status'
      , pn_trx_curr                      varchar2(100)  path 'pn_trx_curr'
      , sla_entity                       varchar2(100)  path 'sla_entity'
      , sla_event                        varchar2(100)  path 'sla_event'
      , sla_event_status                 varchar2(100)  path 'sla_event_status'
      , sla_event_process_status         varchar2(100)  path 'sla_event_process_status'
      , sla_on_hold_flag                 varchar2(100)  path 'sla_on_hold_flag'
      , sla_accounting_date              date           path 'sla_accounting_date'
      , sla_creation_date                date           path 'sla_creation_date'
      , sla_gl_tfr_status                varchar2(100)  path 'sla_gl_tfr_status'
      , sla_gl_tfr_date                  date           path 'sla_gl_tfr_date'
      , gl_jnl_batch                     varchar2(100)  path 'gl_jnl_batch'
      , gl_jnl_name                      varchar2(100)  path 'gl_jnl_name'
      , gl_jnl_source                    varchar2(100)  path 'gl_jnl_source'
      , gl_jnl_category                  varchar2(100)  path 'gl_jnl_category'
      , gl_jnl_period                    varchar2(100)  path 'gl_jnl_period'
      , gl_jnl_date_cre                  date           path 'gl_jnl_date_cre'
      , gl_jnl_posted_date               date           path 'gl_jnl_posted_date'
      , gl_jnl_curr                      varchar2(100)  path 'gl_jnl_curr'
      , gl_jnl_posted_status             varchar2(100)  path 'gl_jnl_posted_status'
    ) x
),
q_trx_amt as
(select
  x.*
 from
  xmltable
    ( '/AMT/ROW'
      passing xxen_pn.get_xxpnglrec_trx_amt_xml
      columns
        pn_trx_id                        number         path 'pn_trx_id'
      , group_id                         number         path 'group_id'
      , col_code                         varchar2(25)   path 'col_code'
      , col_name                         varchar2(500)  path 'col_name'
      , ent_amt                          number         path 'ent_amt'
      , acc_amt                          number         path 'acc_amt'
    ) x
)
--
-- Main Query Starts Here
--
select
 qt.period
,qt.primary_ledger        primary_ledger
,qt.sla_ledger            sla_ledger
,qt.primary_ledger_curr   functional_currency
,qt.sla_ledger_curr       sla_ledger_currency
,qt.line_source source
-- lease details
,qt.operating_unit
,qt.company_code
,qt.accounting_method
,xxen_util.meaning(qt.accounting_method,'PN_ACCT_METHOD_TYPE',0) representation
,qt.lease_num
,qt.lease_name
,qt.interest_index
,qt.interest_rate
,qt.responsible_user
,qt.commencement_date
,qt.termination_date
,qt.duration duration_in_months
,qt.lessor_name
-- transaction details
,qt.pn_trx_num      trx_number
,qt.pn_trx_type     trx_type_code
,xxen_util.meaning(qt.pn_trx_type,'PN_TRANSACTION_TYPE',0) trx_type
,qt.pn_trx_date     trx_date
,qt.pn_trx_regime   trx_regime
,qt.pn_trx_status   trx_status
,qt.pn_trx_curr     trx_currency
-- SLA Status Information
,nvl((select xetv.name from xla_entity_types_vl xetv where xetv.application_id = 240 and xetv.entity_code = qt.sla_entity and rownum=1)
    ,qt.sla_entity
    ) sla_entity
,nvl((select xetv.name from xla_event_types_vl xetv where xetv.application_id = 240 and xetv.event_type_code = qt.sla_event and rownum=1)
    ,qt.sla_event
    ) sla_event
,qt.sla_event_status
,qt.sla_event_process_status
,xxen_util.meaning(qt.sla_on_hold_flag,'YES_NO',0) sla_on_hold_flag
,qt.sla_accounting_date
,xxen_util.meaning(qt.sla_gl_tfr_status,'YES_NO',0) sla_tfrd_to_gl
,qt.sla_gl_tfr_date
-- GL Journal Information
,qt.gl_jnl_batch
,qt.gl_jnl_name
,qt.gl_jnl_source
,qt.gl_jnl_category
,qt.gl_jnl_period
,qt.gl_jnl_date_cre      gl_jnl_creation_date
,qt.gl_jnl_posted_date   gl_jnl_posted_date
,qt.gl_jnl_curr          gl_jnl_currency
,xxen_util.meaning(qt.gl_jnl_posted_status,'BATCH_STATUS',101) gl_jnl_status
-- Amounts
,case when :p_show_in_ledger_curr is not null
 then qt.sla_ledger_curr
 else qt.entered_curr
 end  amount_currency
,case qa.group_id
 when 100 then '1: Amounts by Payment Term Type'
 when 150 then '2: Amounts by Option Type'
 when 200 then '3: Amounts by Stream Type'
 when 400 then '4: Amounts by SLA Account Class'
 when 500 then '5: SLA Amounts by GL Account'
 when 600 then '6: GL Amounts by GL Account'
          else '7: Unknown Grouping: ' || to_char(qa.group_id)
 end           amount_group_name
,qa.col_name   amount_element_name
,case when upper(:p_show_in_ledger_curr) = 'LEDGER'
 then qa.acc_amt
 else qa.ent_amt
 end           amount
from
 q_trx     qt
,q_trx_amt qa
where
 1=1 and
 qt.pn_trx_id = qa.pn_trx_id (+)
order by
 qt.period
,qt.primary_ledger
,qt.sla_ledger
,qt.operating_unit
,qt.company_code
,qt.entered_curr
,decode(qt.line_source,'PN',1,'SLA',2,3)
,qt.pn_trx_date
,qt.pn_trx_num
,qa.group_id
,qa.col_name