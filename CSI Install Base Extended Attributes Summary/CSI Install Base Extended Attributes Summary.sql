/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CSI Install Base Extended Attributes Summary
-- Excel Examle Output: https://www.enginatics.com/example/csi-install-base-extended-attributes-summary
-- Library Link: https://www.enginatics.com/reports/csi-install-base-extended-attributes-summary
-- Run Report: https://demo.enginatics.com/


select
count(*) count,
initcap(ciea.attribute_level) attribute_level,
ciea.attribute_name,
ciea.description,
ciea.attribute_category
from
csi_iea_values civ,
csi_i_extended_attribs ciea
where
ciea.attribute_id=civ.attribute_id
group by
ciea.attribute_level,
ciea.attribute_name,
ciea.description,
ciea.attribute_category
order by
count(*) desc