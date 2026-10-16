/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: XLA Subledger Accounting Rules Detail Listing
-- Description: Lists the complete Subledger Accounting rule setup in one flat grid, combining the seven separate queries of the Oracle standard XLASARDLR Subledger Accounting Rules Detail Listing BI Publisher report.
-- There is one row per journal line type and account derivation rule priority, so the accounting method, application accounting definition, event class and type, journal line definition, journal line type, segment, derivation rule, its priority, condition and derived value all sit on the same row and can be filtered and pivoted directly.
-- Journal line type and account derivation rule conditions are rendered as readable text up to 8000 characters. Header and line descriptions are shown by name, with their priorities, conditions and detail aggregated into a single cell.
-- The Oracle report requires one application and one accounting method per run. Here every parameter is optional and accepts multiple values, so leaving them blank lists the whole instance.
-- Excel Example Output: https://www.enginatics.com/example/xla-subledger-accounting-rules-detail-listing/
-- Library Link: https://www.enginatics.com/reports/xla-subledger-accounting-rules-detail-listing/
-- Run Report: https://demo.enginatics.com/

with desc_detail as
(
select
d.application_id,
d.amb_context_code,
d.description_type_code,
d.description_code,
xxen_util.xml_unescape_clob(xmlagg(xmlelement(e,d.detail_line||chr(10)) order by d.user_sequence).extract('//text()').getclobval()) description_detail
from
(
select 
desp.application_id,
desp.amb_context_code,
desp.description_type_code,
desp.description_code,
desp.user_sequence,
desp.user_sequence||'. '||
case when xla_conditions_pkg.display_condition_substr(desf.application_id,desf.amb_context_code,null,null,null,null,null,desp.description_prio_id,null,'D',1,4000) is not null
then 'Condition: '||xla_conditions_pkg.display_condition_substr(desf.application_id,desf.amb_context_code,null,null,null,null,null,desp.description_prio_id,null,'D',1,4000)||' -> ' end||
xla_descript_details_pkg.display_desc_prio_details(desp.description_prio_id,desf.transaction_coa_id) detail_line
from
xla_descriptions_fvl desf,
xla_desc_priorities desp
where
desf.application_id=desp.application_id and
desf.amb_context_code=desp.amb_context_code and
desf.description_type_code=desp.description_type_code and
desf.description_code=desp.description_code and
desf.enabled_flag='Y'
) d
group by
d.application_id,
d.amb_context_code,
d.description_type_code,
d.description_code
)
select
x.application_name application,
x.accounting_method_owner,
x.accounting_method,
x.accounting_method_code,
x.accounting_method_description,
x.amb_context_code amb_context,
x.start_date_active effective_from,
x.end_date_active effective_to,
x.aad_name application_acctg_definition,
x.aad_owner,
x.product_rule_code aad_code,
x.product_rule_version aad_version,
x.aad_description,
x.aad_compile_status,
x.aad_transaction_coa_name aad_trx_chart_of_accounts,
x.aad_accounting_coa_name aad_acctg_chart_of_accounts,
x.event_class_name event_class,
x.event_type_name event_type,
x.event_class_code,
x.event_type_code,
x.jld_name journal_line_definition,
x.jld_owner,
x.line_definition_code journal_line_definition_code,
x.jld_description journal_line_definition_desc,
x.jld_enabled,
x.jld_validation_status,
x.budgetary_control,
x.header_description,
x.header_description_owner,
hdesc.description_detail header_description_detail,
x.jlt_name journal_line_type,
x.jlt_owner,
x.accounting_line_code journal_line_type_code,
x.jlt_description journal_line_type_description,
x.accounting_class,
x.balance_type,
x.natural_side,
x.gl_transfer_mode,
x.switch_side,
x.subledger_gain_loss,
x.merge_duplicates,
x.rounding_class,
x.business_flow_method,
x.business_flow_class,
x.mpa_option,
x.encumbrance_type,
x.jlt_transaction_coa_name jlt_trx_chart_of_accounts,
x.jlt_active,
x.jlt_inherit_description,
to_clob(x.jlt_condition)||case when lengthb(x.jlt_condition)=4000 then xla_conditions_pkg.display_condition_substr(x.application_id,x.amb_context_code,x.entity_code,x.event_class_code,x.accounting_line_type_code,x.accounting_line_code,null,null,null,'A',4001,4000) end journal_line_type_condition,
x.line_description,
x.line_description_owner,
ldesc.description_detail line_description_detail,
da.side_code_dsp side,
da.flexfield_segment_name segment,
da.segment_rule_name account_derivation_rule,
da.segment_rule_owner adr_owner,
da.segment_rule_code adr_code,
da.segment_rule_desc adr_description,
xxen_util.yes(da.inherit_adr_flag) inherit_adr,
adr.segment_rule_type_dsp adr_rule_type,
adr.flexfield_assign_mode adr_assignment_mode,
adr.flex_value_set_name adr_value_set,
adr.adr_priority,
adr.adr_value_type,
adr.adr_value,
adr.adr_input_source,
adr.adr_value_segment,
adr.adr_condition
from
(
select 
slam.application_id,
slam.application_name,
slam.amb_context_code,
slam.start_date_active,
slam.end_date_active,
slam2.accounting_method_type_dsp accounting_method_owner,
slam2.name accounting_method,
slam2.accounting_method_code,
slam2.description accounting_method_description,
aad.name aad_name,
aad.product_rule_type_dsp aad_owner,
aad.product_rule_code,
aad.product_rule_version,
aad.description aad_description,
aad.compile_status_dsp aad_compile_status,
aad.transaction_coa_name aad_transaction_coa_name,
aad.accounting_coa_name aad_accounting_coa_name,
ec.event_class_name,
et.name event_type_name,
ld.event_class_code,
ld.event_type_code,
ld.name jld_name,
decode(ld.line_definition_owner_code,'S',xxen_util.meaning('S','XLA_OWNER_TYPE',602),'Oracle','User') jld_owner,
ld.line_definition_code,
ld.description jld_description,
xxen_util.yes(ld.enabled_flag) jld_enabled,
ld.validation_status_code jld_validation_status,
xxen_util.yes(ld.budgetary_control_flag) budgetary_control,
des.header_desc_name header_description,
des.header_desc_type_dsp header_description_owner,
des.header_desc_code,
des.header_desc_type_code,
lt.name jlt_name,
lt.accounting_line_type_dsp jlt_owner,
lt.accounting_line_code,
lt.accounting_line_type_code,
lt.entity_code,
lt.description jlt_description,
lt.accounting_class_dsp accounting_class,
decode(lt.accounting_entry_type_code,'A','Actual','E','Encumbrance','B','Budget') balance_type,
decode(lt.natural_side_code,'D','Debit','C','Credit','Gain/Loss') natural_side,
decode(lt.gl_transfer_mode_code,'D','Detail','S','Summary') gl_transfer_mode,
xxen_util.yes(lt.switch_side_flag) switch_side,
xxen_util.yes(lt.gain_or_loss_flag) subledger_gain_loss,
lt.merge_duplicate_dsp merge_duplicates,
lt.rounding_class_dsp rounding_class,
decode(lt.business_method_code,'NONE','None','SAME_ENTRY','Same Entry','PRIOR_ENTRY','Prior Entry') business_flow_method,
lt.business_class_name business_flow_class,
decode(lt.mpa_option_code,'ACCRUAL','Accrual','RECOGNITION','Recognition','NONE','None') mpa_option,
lt.encumbrance_type,
lt.transaction_coa_name jlt_transaction_coa_name,
xxen_util.yes(ljta.active_flag) jlt_active,
xxen_util.yes(ljta.inherit_desc_flag) jlt_inherit_description,
ljta.line_definition_owner_code,
xla_conditions_pkg.display_condition_substr(ljta.application_id,ljta.amb_context_code,lt.entity_code,ljta.event_class_code,ljta.accounting_line_type_code,ljta.accounting_line_code,null,null,null,'A',1,4000) jlt_condition,
jdes.name line_description,
jdes.description_type_code_dsp line_description_owner,
ljta.description_code,
ljta.description_type_code
from
xla_acctg_method_rules_fvl slam,
xla_acctg_methods_fvl slam2,
xla_product_rules_fvl aad,
xla_aad_line_defn_assgns lda,
xla_line_definitions_vl ld,
xla_prod_header_desc_fvl des,
xla_event_classes_fvl ec,
xla_event_types_vl et,
xla_line_defn_jlt_assgns ljta,
xla_acct_line_types_fvl lt,
xla_descriptions_fvl jdes
where
1=1 and
trunc(sysdate) between slam.start_date_active and trunc(nvl(slam.end_date_active,to_date('31/12/9714','DD/MM/YYYY'))) and
slam.accounting_method_code=slam2.accounting_method_code and
slam.accounting_method_type_code=slam2.accounting_method_type_code and
slam.application_id=aad.application_id and
slam.amb_context_code=aad.amb_context_code and
slam.product_rule_type_code=aad.product_rule_type_code and
slam.product_rule_code=aad.product_rule_code and
aad.enabled_flag='Y' and
aad.application_id=lda.application_id and
aad.amb_context_code=lda.amb_context_code and
aad.product_rule_type_code=lda.product_rule_type_code and
aad.product_rule_code=lda.product_rule_code and
lda.application_id=ld.application_id and
lda.amb_context_code=ld.amb_context_code and
lda.event_class_code=ld.event_class_code and
lda.event_type_code=ld.event_type_code and
lda.line_definition_owner_code=ld.line_definition_owner_code and
lda.line_definition_code=ld.line_definition_code and
ld.enabled_flag='Y' and
lda.application_id=des.application_id(+) and
lda.amb_context_code=des.amb_context_code(+) and
lda.product_rule_type_code=des.product_rule_type_code(+) and
lda.product_rule_code=des.product_rule_code(+) and
lda.event_class_code=des.event_class_code(+) and
lda.event_type_code=des.event_type_code(+) and
lda.application_id=ec.application_id and
lda.event_class_code=ec.event_class_code and
lda.application_id=et.application_id and
lda.event_class_code=et.event_class_code and
lda.event_type_code=et.event_type_code and
lda.application_id=ljta.application_id(+) and
lda.amb_context_code=ljta.amb_context_code(+) and
lda.event_class_code=ljta.event_class_code(+) and
lda.event_type_code=ljta.event_type_code(+) and
lda.line_definition_owner_code=ljta.line_definition_owner_code(+) and
lda.line_definition_code=ljta.line_definition_code(+) and
ljta.active_flag(+)='Y' and
ljta.application_id=lt.application_id(+) and
ljta.amb_context_code=lt.amb_context_code(+) and
ljta.event_class_code=lt.event_class_code(+) and
ljta.accounting_line_type_code=lt.accounting_line_type_code(+) and
ljta.accounting_line_code=lt.accounting_line_code(+) and
lt.enabled_flag(+)='Y'
 and
ljta.application_id=jdes.application_id(+) and
ljta.amb_context_code=jdes.amb_context_code(+) and
ljta.description_type_code=jdes.description_type_code(+) and
ljta.description_code=jdes.description_code(+) and
jdes.enabled_flag(+)='Y'
) x,
xla_line_defn_adr_assgns_f_v da,
(
select
z.application_id,
z.amb_context_code,
z.segment_rule_type_code,
z.segment_rule_code,
z.segment_rule_type_dsp,
z.flexfield_assign_mode,
z.flex_value_set_name,
z.adr_priority,
z.adr_value_type,
z.adr_value,
z.adr_input_source,
z.adr_value_segment,
to_clob(z.adr_condition)||case when lengthb(z.adr_condition)=4000 then xla_conditions_pkg.display_condition_substr(z.application_id,z.amb_context_code,null,null,null,null,z.segment_rule_detail_id,null,null,'S',4001,4000) end adr_condition
from
(
select 
sd.application_id,
sd.amb_context_code,
sd.segment_rule_type_code,
sd.segment_rule_code,
sd.segment_rule_detail_id,
sr.segment_rule_type_dsp,
decode(sr.flexfield_assign_mode_code,'A','Flexfield','V','Value Set','S','Segment') flexfield_assign_mode,
sr.flex_value_set_name,
sd.user_sequence adr_priority,
decode(sd.value_type_code,'A','Account Derivation Rule','S','Source','M','Mapping Set','C','Constant') adr_value_type,
case sd.value_type_code
when 'S' then (select xsv.name from xla_sources_vl xsv where xsv.application_id=sd.value_source_application_id and xsv.source_type_code=sd.value_source_type_code and xsv.source_code=sd.value_source_code)
when 'M' then (select xmsv.name from xla_mapping_sets_vl xmsv where xmsv.mapping_set_code=sd.value_mapping_set_code)
when 'A' then (select xsrv.name from xla_seg_rules_fvl xsrv where xsrv.amb_context_code=sd.amb_context_code and xsrv.application_id=sd.value_segment_rule_appl_id and xsrv.segment_rule_type_code=sd.value_segment_rule_type_code and xsrv.segment_rule_code=sd.value_segment_rule_code)
when 'C' then decode(sr.flexfield_assign_mode_code,
'S',sd.value_constant,
'V',nvl((select max(ffvv.flex_value_meaning) from fnd_flex_values_vl ffvv where ffvv.flex_value_set_id=sr.flex_value_set_id and ffvv.flex_value=sd.value_constant),sd.value_constant),
'A',fnd_flex_ext.get_segs('SQLGL','GL#',sr.accounting_coa_id,sd.value_code_combination_id))
end adr_value,
(select xsv2.name from xla_sources_vl xsv2 where xsv2.application_id=sd.input_source_application_id and xsv2.source_type_code=sd.input_source_type_code and xsv2.source_code=sd.input_source_code) adr_input_source,
nvl(nvl(xla_flex_pkg.get_flexfield_segment_name(101,'GL#',sr.transaction_coa_id,sd.value_flexfield_segment_code),xla_flex_pkg.get_qualifier_name(101,'GL#',sd.value_flexfield_segment_code)),sd.value_flexfield_segment_code) adr_value_segment,
xla_conditions_pkg.display_condition_substr(sd.application_id,sd.amb_context_code,null,null,null,null,sd.segment_rule_detail_id,null,null,'S',1,4000) adr_condition
from
xla_seg_rules_fvl sr,
xla_seg_rule_details sd
where
sr.application_id=sd.application_id and
sr.amb_context_code=sd.amb_context_code and
sr.segment_rule_type_code=sd.segment_rule_type_code and
sr.segment_rule_code=sd.segment_rule_code and
sr.enabled_flag='Y'
) z
) adr,
desc_detail hdesc,
desc_detail ldesc
where
x.application_id=da.application_id(+) and
x.amb_context_code=da.amb_context_code(+) and
x.event_class_code=da.event_class_code(+) and
x.event_type_code=da.event_type_code(+) and
x.line_definition_owner_code=da.line_definition_owner_code(+) and
x.line_definition_code=da.line_definition_code(+) and
x.accounting_line_type_code=da.accounting_line_type_code(+) and
x.accounting_line_code=da.accounting_line_code(+) and
da.segment_rule_appl_id=adr.application_id(+) and
da.amb_context_code=adr.amb_context_code(+) and
da.segment_rule_type_code=adr.segment_rule_type_code(+) and
da.segment_rule_code=adr.segment_rule_code(+) and
x.application_id=hdesc.application_id(+) and
x.amb_context_code=hdesc.amb_context_code(+) and
x.header_desc_type_code=hdesc.description_type_code(+) and
x.header_desc_code=hdesc.description_code(+) and
x.application_id=ldesc.application_id(+) and
x.amb_context_code=ldesc.amb_context_code(+) and
x.description_type_code=ldesc.description_type_code(+) and
x.description_code=ldesc.description_code(+)
order by
application,
accounting_method,
application_acctg_definition,
event_class,
event_type,
journal_line_definition,
journal_line_type,
segment,
account_derivation_rule,
adr_priority
