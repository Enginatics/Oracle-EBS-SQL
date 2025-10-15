/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QP Pricing Attribute Definitions
-- Description: Lists the Pricing and Qualifiers Attributes defined for use by Advanced Pricing
-- Excel Examle Output: https://www.enginatics.com/example/qp-pricing-attribute-definitions/
-- Library Link: https://www.enginatics.com/reports/qp-pricing-attribute-definitions/
-- Run Report: https://demo.enginatics.com/

select
x.context_type,
x.context_code,
x.context_value,
x.attribute,
x.attribute_value,
x.description,
x.enabled,
x.segment_level,
fnd_global.resp_name responsibility,
fnd_profile.value('QP_SOURCE_SYSTEM_CODE') source_system,
fnd_profile.value('QP_PRICING_TRANSACTION_ENTITY') pte_code,
(select mp.organization_code from mtl_parameters mp where mp.organization_id = fnd_profile.value('QP_ORGANIZATION_ID')) qp_validation_org,
qp_util.attrmgr_installed attribute_manager_installed,
xxen_util.meaning(qp_util.get_qp_status,'FND_PRODUCT_STATUS',0) qp_appln_status
from
xmltable
('/ATTRIBUTE/ROW'
 passing xxen_qp_upload.get_attributes_lov('ORDFUL')
 columns
 context_type varchar2(240) path 'CONTEXT_TYPE',
 context_code varchar2(240) path 'CONTEXT_CODE',
 context_value varchar2(240) path 'CONTEXT_VALUE',
 attribute varchar2(240) path 'ID',
 attribute_value varchar2(240) path 'VALUE',
 description varchar2(240) path 'DESCRIPTION',
 enabled varchar2(1) path 'ENABLED',
 segment_level varchar2(10) path 'SEGMENT_LEVEL'
 ) x
order by
x.context_type,
x.context_code,
to_number(replace(replace(x.attribute,'PRICING_ATTRIBUTE',''),'QUALIFIER_ATTRIBUTE',''))