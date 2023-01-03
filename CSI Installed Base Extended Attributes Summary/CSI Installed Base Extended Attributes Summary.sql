/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CSI Installed Base Extended Attributes Summary
-- Description: Master data report of extended Installed Base attribute levels and names
-- Excel Examle Output: https://www.enginatics.com/example/csi-installed-base-extended-attributes-summary/
-- Library Link: https://www.enginatics.com/reports/csi-installed-base-extended-attributes-summary/
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