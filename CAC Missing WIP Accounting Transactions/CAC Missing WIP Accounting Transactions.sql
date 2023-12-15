/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Missing WIP Accounting Transactions
-- Description: Report to find work in process (WIP) accounting entries where the WIP transaction has been created but the WIP accounting entries do not exist.  If you enter Yes for "Only Costed Resources" the report ignores WIP transactions where the resource code is defined as not allowing costs (not costed).  If you enter No for "Only Costed Resources" the report includes WIP transactions where the resource code does not allow costs as well as costed resources.  And to get all transactions which are missing the WIP accounting entries, even for transactions where the resources are not costed, set the "Only Costed Resources" to No and the Minimum Transaction Amount to zero (0).

/* +=============================================================================+
-- |  Copyright 2022 Douglas Volz Consulting, Inc.                               |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  missing_wip_accounting_transactions.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from         -- Starting transaction date, mandatory
-- |  p_trx_date_to           -- Ending transaction date, mandatory
-- |  p_minimum_amount        -- The absolute smallest transaction amount to be reported
-- |  p_only_costed_resources -- Only include transactions where the resource code is costed. 
-- |  p_org_code              -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit        -- Operating Unit you wish to report, leave blank for all
-- |                             operating units (optional) 
-- |  p_ledger                -- general ledger you wish to report, leave blank for all
-- |                             ledgers (optional)
-- |
-- |  Description:
-- |  Report to find WIP accounting entries where the WIP accounting entries do not
-- |  exist.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     21 Jul 2022 Douglas Volz   Initial Coding based on missing_material_accounting_transactions.sql
-- |  1.1     23 Jul 2022 Douglas Volz   Added Ledger and Operating Unit columns. 
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-missing-wip-accounting-transactions/
-- Library Link: https://www.enginatics.com/reports/cac-missing-wip-accounting-transactions/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
-- ================================================================
-- First get the resource and overhead transactions
-- ================================================================
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 oap.period_name Period_Name,
 mtst.transaction_source_type_name Transaction_Source,
 ml1.meaning Transaction_Type,
 wt.transaction_id Transaction_Id,
 wt.transaction_date Transaction_Date,
 wt.creation_date Creation_Date,
 ml7.meaning WIP_Type,
 we.wip_entity_name WIP_Job,
 wt.operation_seq_num Operation_Seq_Number,
 wt.resource_seq_num Resource_Seq_Number,
 br.resource_code Resource_Code,
 br.description Resource_Description,
 cce.cost_element Cost_Element,
 msiv.concatenated_segments Outside_Processing_Item,
 msiv.description Outside_Processing_Description,
 xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) Outside_Processing_Item_Type,
 ml2.meaning Resource_Type,
 ml3.meaning Charge_Type,
 ml4.meaning Basis_Type,
 ml5.meaning Allow_Costs,
 br.unit_of_measure UOM_Code,
 wt.primary_quantity Primary_Quantity,
 ml6.meaning Standard_Rate,
 gl.currency_code Currency_Code,
 wt.actual_resource_rate Actual_Resource_Rate,
 wt.standard_resource_rate Standard_Resource_Rate,
 wt.usage_rate_or_amount Usage_Rate_or_Amount,
 decode(br.standard_rate_flag,
  1, round(nvl(wt.primary_quantity,0) * nvl(wt.usage_rate_or_amount,0) * nvl(wt.standard_resource_rate,0),2),
  2, round(nvl(wt.primary_quantity,0) * nvl(wt.usage_rate_or_amount,0) * nvl(wt.actual_resource_rate,0),2)
       ) Extended_WIP_Amount,
 (select cct.cost_type
  from cst_cost_types cct
  where cct.cost_type_id = mp.primary_cost_method) Cost_Method,
 (select crc.resource_rate
  from cst_resource_costs crc
  where crc.resource_id       = wt.resource_id
  and crc.organization_id   = wt.organization_id
  and crc.cost_type_id      = decode(mp.primary_cost_method, 1,1, avg_rates_cost_type_id)) Current_Resource_Cost
from wip_transactions wt,
 wip_entities we,
 bom_resources br,
 cst_cost_elements cce,
 mtl_system_items_vl msiv,
 mtl_txn_source_types mtst,
 org_acct_periods oap,
 mtl_parameters mp,
 mfg_lookups ml1, -- WIP Transaction Type
 mfg_lookups ml2, -- 'BOM_RESOURCE_TYPE'
 mfg_lookups ml3, -- Charge Type
 mfg_lookups ml4, -- Basis Type
 mfg_lookups ml5, -- Allow Costs
 mfg_lookups ml6, -- Standard Rate Flag
 mfg_lookups ml7, -- WIP Entity Type
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl
-- ========================================================
-- WIP Transaction, org and item joins
-- ========================================================
where we.wip_entity_id                 = wt.wip_entity_id
and br.resource_id                   = wt.resource_id
and br.purchase_item_id              = msiv.inventory_item_id (+)
and br.organization_id               = msiv.organization_id (+)
and br.cost_element_id               = cce.cost_element_id
and mtst.transaction_source_type_id  = 5 -- WIP
and mp.organization_id               = wt.organization_id
and oap.acct_period_id               = wt.acct_period_id
and ml1.lookup_type                  = 'WIP_TRANSACTION_TYPE_SHORT'
and ml1.lookup_code                  = wt.transaction_type
and ml2.lookup_type                  = 'BOM_RESOURCE_TYPE'
and ml2.lookup_code                  = br.resource_type
and ml3.lookup_type                  = 'BOM_AUTOCHARGE_TYPE'
and ml3.lookup_code                  = br.autocharge_type
and ml4.lookup_type                  = 'CST_BASIS'
and ml4.lookup_code                  = br.default_basis_type
and ml5.lookup_type                  = 'SYS_YES_NO'
and ml5.lookup_code                  = br.allow_costs_flag
and ml6.lookup_type                  = 'SYS_YES_NO'
and ml6.lookup_code                  = br.standard_rate_flag
and ml7.lookup_type                  = 'WIP_ENTITY'
and ml7.lookup_code                  = we.entity_type
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and hoi.org_information_context      = 'Accounting Information'
and hoi.organization_id              = mp.organization_id
and hoi.organization_id              = haou.organization_id   -- this gets the organization name
and haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
-- ========================================================
-- Find missing accounting entries
-- ========================================================
and wt.resource_id is not null
and not exists
 (select 'x'
  from wip_transaction_accounts wta
  where wt.transaction_id   = wta.transaction_id)
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                             -- p_trx_date_from, p_trx_date_to, p_org_code, p_operating_unit, p_ledger
and 2=2                             -- only_costed_resources, nvl(br.allow_costs_flag,2) = 1
group by
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, -- Operating Unit  
 mp.organization_code,
 oap.period_name,
 mtst.transaction_source_type_name,
 ml1.meaning, -- WIP transaction type
 wt.transaction_id,
 wt.transaction_date,
 wt.creation_date,
 ml7.meaning, -- WIP Type
 we.wip_entity_name, -- WIP Job
 wt.operation_seq_num, -- Operation Seq Number
 wt.resource_seq_num, -- Resource Seq Number
 br.resource_code, -- Resource Code
 br.description, -- Resource Description
 cce.cost_element, -- Cost Element
 msiv.concatenated_segments, -- Outside Processing Item
 msiv.description, -- Outside Processing Description
 msiv.item_type, -- user_item_type,
 ml2.meaning, -- Resource Type
 ml3.meaning, -- Charge Type
 ml4.meaning, -- Basis Type
 ml5.meaning, -- Allow Costs
 br.unit_of_measure, -- UOM Code
 wt.primary_quantity, -- Primary Quantity
 ml6.meaning, -- Standard Rate Flag
 gl.currency_code, -- Currency Code
 wt.actual_resource_rate, -- Actual Resource Rate
 wt.standard_resource_rate, -- Standard Resource Rate
 wt.usage_rate_or_amount, -- Usage Rate or Amount
 decode(br.standard_rate_flag,
  1, round(nvl(wt.primary_quantity,0) * nvl(wt.usage_rate_or_amount,0) * nvl(wt.standard_resource_rate,0),2),
  2, round(nvl(wt.primary_quantity,0) * nvl(wt.usage_rate_or_amount,0) * nvl(wt.actual_resource_rate,0),2)
       ), -- Extended WIP Amount
 wt.organization_id,
 mp.primary_cost_method,
 wt.resource_id,
 mp.avg_rates_cost_type_id,
 br.standard_rate_flag
having  abs(decode(br.standard_rate_flag,
   1, round(nvl(wt.primary_quantity,0) * nvl(wt.usage_rate_or_amount,0) * nvl(wt.standard_resource_rate,0),2),
   2, round(nvl(wt.primary_quantity,0) * nvl(wt.usage_rate_or_amount,0) * nvl(wt.actual_resource_rate,0),2)
    )
    ) >= :p_minimum_amount -- Extended_Material_Amount
union all
-- ================================================================
-- Then get the cost update, variance and period close transactions
-- ================================================================
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 oap.period_name Period_Name,
 mtst.transaction_source_type_name Transaction_Source,
 ml1.meaning Transaction_Type,
 wt.transaction_id Transaction_Id,
 wt.transaction_date Transaction_Date,
 wt.creation_date Creation_Date,
 ml7.meaning WIP_Type,
 we.wip_entity_name WIP_Job,
 wt.operation_seq_num Operation_Seq_Number,
 wt.resource_seq_num Resource_Seq_Number,
 null Resource_Code,
 null Resource_Description,
 null Cost_Element,
 null Outside_Processing_Item,
 null Outside_Processing_Description,
 null Outside_Processing_Item_Type,
 null Resource_Type,
 null Charge_Type,
 null Basis_Type,
 null Allow_Costs,
 null UOM_Code,
 wt.primary_quantity Primary_Quantity,
 null  Standard_Rate,
 gl.currency_code Currency_Code,
 wt.actual_resource_rate Actual_Resource_Rate,
 wt.standard_resource_rate Standard_Resource_Rate,
 wt.usage_rate_or_amount Usage_Rate_or_Amount,
 round(nvl(wt.primary_quantity,0) * nvl(wt.usage_rate_or_amount,0) * nvl(wt.standard_resource_rate,0),2) Extended_WIP_Amount,
 (select cct.cost_type
  from cst_cost_types cct
  where cct.cost_type_id = mp.primary_cost_method) Cost_Method,
 (select crc.resource_rate
  from cst_resource_costs crc
  where crc.resource_id       = wt.resource_id
  and crc.organization_id   = wt.organization_id
  and crc.cost_type_id      = decode(mp.primary_cost_method, 1,1, avg_rates_cost_type_id)) Current_Resource_Cost
from wip_transactions wt,
 wip_entities we,
 mtl_txn_source_types mtst,
 org_acct_periods oap,
 mtl_parameters mp,
 mfg_lookups ml1, -- WIP Transaction Type
 mfg_lookups ml7, -- WIP Entity Type
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl
-- ========================================================
-- WIP Transaction, org and item joins
-- ========================================================
where we.wip_entity_id                 = wt.wip_entity_id
and mtst.transaction_source_type_id  = 5 -- WIP
and mp.organization_id               = wt.organization_id
and oap.acct_period_id               = wt.acct_period_id
and ml1.lookup_type                  = 'WIP_TRANSACTION_TYPE_SHORT'
and ml1.lookup_code                  = wt.transaction_type
and ml7.lookup_type                  = 'WIP_ENTITY'
and ml7.lookup_code                  = we.entity_type
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and hoi.org_information_context      = 'Accounting Information'
and hoi.organization_id              = mp.organization_id
and hoi.organization_id              = haou.organization_id   -- this gets the organization name
and haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
-- ========================================================
-- Find missing accounting entries
-- ========================================================
and wt.resource_id is null
and not exists
 (select 'x'
  from wip_transaction_accounts wta
  where wt.transaction_id   = wta.transaction_id)
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                             -- p_trx_date_from, p_trx_date_to, p_org_code, p_operating_unit, p_ledger
group by 
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, -- Operating Unit  
 mp.organization_code,
 oap.period_name,
 mtst.transaction_source_type_name,
 ml1.meaning, -- WIP transaction type
 wt.transaction_id,
 wt.transaction_date,
 wt.creation_date,
 ml7.meaning, -- WIP Type
 we.wip_entity_name, -- WIP Job
 wt.operation_seq_num, -- Operation Seq Number
 wt.resource_seq_num, -- Resource Seq Number
 null, -- Resource Code
 null, -- Resource Description
 null, -- Cost Element
 null, -- Outside Processing Item
 null, -- Outside Processing Description
 null, -- Outside_Processing_Item_Type
 null, -- Resource Type
 null, -- Charge Type
 null, -- Basis Type
 null, -- Allow Costs
 null, -- UOM Code
 wt.primary_quantity, -- Primary Quantity
 null, -- Standard Rate Flag
 gl.currency_code, -- Currency Code
 wt.actual_resource_rate, -- Actual Resource Rate
 wt.standard_resource_rate, -- Standard Resource Rate
 wt.usage_rate_or_amount, -- Usage Rate or Amount
 round(nvl(wt.primary_quantity,0) * nvl(wt.usage_rate_or_amount,0),2), -- Extended WIP Amount
 wt.organization_id,
 mp.primary_cost_method,
 wt.resource_id,
 mp.avg_rates_cost_type_id,
 null
having  abs(round(nvl(wt.primary_quantity,0) * nvl(wt.usage_rate_or_amount,0) * nvl(wt.standard_resource_rate,0),2)
    ) >= :p_minimum_amount -- Extended_Material_Amount
order by 1,2,3,4,6,8