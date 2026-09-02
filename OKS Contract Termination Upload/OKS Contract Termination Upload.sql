/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OKS Contract Termination Upload
-- Description: Terminates service contracts (full termination), terminates individual contract lines and sublines (partial termination), and deletes lines from Entered contracts - the Terminate action of the Service Contracts Authoring form (okc_terminate_pub / okc_contract_pub).

Set Terminate Contract to Yes on any row of the contract for a full termination, Terminate Line to Yes to terminate that row's line or subline, or Delete Line to Yes to delete the line (Entered contracts only). Termination Date and Termination Reason are required for terminations.

A termination cannot be undone by this upload - statuses, credits, billing schedules and history are produced by the Oracle termination engine exactly as from the form.
-- Excel Examle Output: https://www.enginatics.com/example/oks-contract-termination-upload/
-- Library Link: https://www.enginatics.com/reports/oks-contract-termination-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
null modified_columns_,
haouv.name operating_unit,
okhab.contract_number,
okhab.contract_number_modifier contract_modifier,
osv.meaning contract_status,
okhab.start_date contract_start_date,
okhab.end_date contract_end_date,
nvl2(oklb.cle_id,oklb_p.line_number||'.',null)||oklb.line_number line_number,
olst.name line_type,
(
select
case
when oki.jtot_object1_code in ('OKX_SERVICE','OKX_USAGE') then (select msiv.concatenated_segments from mtl_system_items_vl msiv where to_number(oki.object1_id1)=msiv.inventory_item_id and to_number(oki.object1_id2)=msiv.organization_id)
when oki.jtot_object1_code='OKX_CUSTPROD' then (select cii.instance_number||' '||msiv.concatenated_segments from csi_item_instances cii, mtl_system_items_vl msiv where to_number(oki.object1_id1)=cii.instance_id and cii.inventory_item_id=msiv.inventory_item_id and cii.inv_master_organization_id=msiv.organization_id)
when oki.jtot_object1_code='OKX_COUNTER' then (select cct.name from csi_counters_tl cct where to_number(oki.object1_id1)=cct.counter_id and cct.language=userenv('lang'))
else oki.object1_id1
end
from
okc_k_items oki
where
oklb.id=oki.cle_id and
rownum=1
) item,
osv_l.meaning line_status,
oklb.start_date line_start_date,
oklb.end_date line_end_date,
oklb.price_negotiated negotiated_amount,
to_char(null) terminate_contract,
to_char(null) terminate_line,
to_date(null) termination_date,
to_char(null) termination_reason,
to_char(null) delete_line,
to_char(okhab.id) chr_id,
to_char(oklb.id) cle_id,
null upload_row
from
okc_k_headers_all_b okhab,
hr_all_organization_units_vl haouv,
okc_statuses_v osv,
okc_k_lines_b oklb,
okc_k_lines_b oklb_p,
okc_line_styles_tl olst,
okc_statuses_v osv_l
where
1=1 and
okhab.scs_code='SERVICE' and
okhab.authoring_org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
okhab.authoring_org_id=haouv.organization_id and
okhab.sts_code=osv.code and
okhab.id=oklb.dnz_chr_id and
oklb.lse_id in (1,7,8,9,10,11,12,13,14,35) and
oklb.cle_id=oklb_p.id(+) and
oklb.lse_id=olst.id and
olst.language=userenv('lang') and
oklb.sts_code=osv_l.code