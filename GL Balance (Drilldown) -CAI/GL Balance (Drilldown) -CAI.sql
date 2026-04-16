/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Balance (Drilldown) -CAI
-- Description: ** This report is used by the GL Financial Statement and Drilldown report to show Balance details by Code Combination. **

Shows opening balance, period Dr/Cr/Net, and closing balance for each code combination. Supports drill to journals for further analysis.
-- Excel Examle Output: https://www.enginatics.com/example/gl-balance-drilldown-cai/
-- Library Link: https://www.enginatics.com/reports/gl-balance-drilldown-cai/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
gl.ledger_id,
gcck.concatenated_segments,
gcck.code_combination_id,
&segment_columns
-- Balance amounts based on balance type and translated flag
sum(
case when :balance_type in ('PTD','CTD','FYS','FYE') then
  case when :translated_flag in ('T','S') then
    nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then 
      decode(gb.translated_flag,'R', nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 
             nvl(gb.begin_balance_dr_beq,0) - nvl(gb.begin_balance_cr_beq,0))
    else nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.begin_balance_dr_beq,0) - nvl(gb.begin_balance_cr_beq,0)
    else nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0) end
  end
when :balance_type='YTD' then
  case when :translated_flag in ('T','S') then
    decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then 
      decode(gb.translated_flag, 'R', 
        decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0),
        decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr_beq,0) - nvl(gb.begin_balance_cr_beq,0), 0))
    else decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then 
      decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr_beq,0) - nvl(gb.begin_balance_cr_beq,0), 0)
    else decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0) end
  end
when :balance_type in ('QTD','PJTD') then 0
end
) * nvl(:multiplier,1) opening_balance,
-- Period DR
sum(
case when :balance_type in ('PTD','CTD','FYS','FYE') then
  case when :translated_flag in ('T','S') then nvl(gb.period_net_dr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then decode(gb.translated_flag, 'R', nvl(gb.period_net_dr,0), nvl(gb.period_net_dr_beq,0))
    else nvl(gb.period_net_dr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.period_net_dr_beq,0) else nvl(gb.period_net_dr,0) end
  end
when :balance_type='YTD' then
  case when :translated_flag in ('T','S') then
    decode(gb.period_name, :period_name, nvl(gb.period_net_dr,0) + nvl(gb.begin_balance_dr,0), 0) - 
    decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr,0), 0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then
      decode(gb.translated_flag, 'R',
        decode(gb.period_name, :period_name, nvl(gb.period_net_dr,0) + nvl(gb.begin_balance_dr,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr,0), 0),
        decode(gb.period_name, :period_name, nvl(gb.period_net_dr_beq,0) + nvl(gb.begin_balance_dr_beq,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr_beq,0), 0))
    else decode(gb.period_name, :period_name, nvl(gb.period_net_dr,0) + nvl(gb.begin_balance_dr,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr,0), 0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then
      decode(gb.period_name, :period_name, nvl(gb.period_net_dr_beq,0) + nvl(gb.begin_balance_dr_beq,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr_beq,0), 0)
    else decode(gb.period_name, :period_name, nvl(gb.period_net_dr,0) + nvl(gb.begin_balance_dr,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr,0), 0) end
  end
when :balance_type='QTD' then
  case when :translated_flag in ('T','S') then nvl(gb.quarter_to_date_dr,0) + nvl(gb.period_net_dr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then decode(gb.translated_flag, 'R', nvl(gb.quarter_to_date_dr,0) + nvl(gb.period_net_dr,0), nvl(gb.quarter_to_date_dr_beq,0) + nvl(gb.period_net_dr_beq,0))
    else nvl(gb.quarter_to_date_dr,0) + nvl(gb.period_net_dr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.quarter_to_date_dr_beq,0) + nvl(gb.period_net_dr_beq,0)
    else nvl(gb.quarter_to_date_dr,0) + nvl(gb.period_net_dr,0) end
  end
when :balance_type='PJTD' then
  case when :translated_flag in ('T','S') then nvl(gb.project_to_date_dr,0) + nvl(gb.period_net_dr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then decode(gb.translated_flag, 'R', nvl(gb.project_to_date_dr,0) + nvl(gb.period_net_dr,0), nvl(gb.project_to_date_dr_beq,0) + nvl(gb.period_net_dr_beq,0))
    else nvl(gb.project_to_date_dr,0) + nvl(gb.period_net_dr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.project_to_date_dr_beq,0) + nvl(gb.period_net_dr_beq,0)
    else nvl(gb.project_to_date_dr,0) + nvl(gb.period_net_dr,0) end
  end
end
) * nvl(:multiplier,1) period_dr,
-- Period CR
sum(
case when :balance_type in ('PTD','CTD','FYS','FYE') then
  case when :translated_flag in ('T','S') then nvl(gb.period_net_cr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then decode(gb.translated_flag, 'R', nvl(gb.period_net_cr,0), nvl(gb.period_net_cr_beq,0))
    else nvl(gb.period_net_cr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.period_net_cr_beq,0) else nvl(gb.period_net_cr,0) end
  end
when :balance_type='YTD' then
  case when :translated_flag in ('T','S') then
    decode(gb.period_name, :period_name, nvl(gb.period_net_cr,0) + nvl(gb.begin_balance_cr,0), 0) - 
    decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_cr,0), 0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then
      decode(gb.translated_flag, 'R',
        decode(gb.period_name, :period_name, nvl(gb.period_net_cr,0) + nvl(gb.begin_balance_cr,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_cr,0), 0),
        decode(gb.period_name, :period_name, nvl(gb.period_net_cr_beq,0) + nvl(gb.begin_balance_cr_beq,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_cr_beq,0), 0))
    else decode(gb.period_name, :period_name, nvl(gb.period_net_cr,0) + nvl(gb.begin_balance_cr,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_cr,0), 0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then
      decode(gb.period_name, :period_name, nvl(gb.period_net_cr_beq,0) + nvl(gb.begin_balance_cr_beq,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_cr_beq,0), 0)
    else decode(gb.period_name, :period_name, nvl(gb.period_net_cr,0) + nvl(gb.begin_balance_cr,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_cr,0), 0) end
  end
when :balance_type='QTD' then
  case when :translated_flag in ('T','S') then nvl(gb.quarter_to_date_cr,0) + nvl(gb.period_net_cr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then decode(gb.translated_flag, 'R', nvl(gb.quarter_to_date_cr,0) + nvl(gb.period_net_cr,0), nvl(gb.quarter_to_date_cr_beq,0) + nvl(gb.period_net_cr_beq,0))
    else nvl(gb.quarter_to_date_cr,0) + nvl(gb.period_net_cr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.quarter_to_date_cr_beq,0) + nvl(gb.period_net_cr_beq,0)
    else nvl(gb.quarter_to_date_cr,0) + nvl(gb.period_net_cr,0) end
  end
when :balance_type='PJTD' then
  case when :translated_flag in ('T','S') then nvl(gb.project_to_date_cr,0) + nvl(gb.period_net_cr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then decode(gb.translated_flag, 'R', nvl(gb.project_to_date_cr,0) + nvl(gb.period_net_cr,0), nvl(gb.project_to_date_cr_beq,0) + nvl(gb.period_net_cr_beq,0))
    else nvl(gb.project_to_date_cr,0) + nvl(gb.period_net_cr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.project_to_date_cr_beq,0) + nvl(gb.period_net_cr_beq,0)
    else nvl(gb.project_to_date_cr,0) + nvl(gb.period_net_cr,0) end
  end
end
) * nvl(:multiplier,1) period_cr,
-- Period Net (calculated as Dr - Cr for simplicity, can also use direct period_net columns)
sum(
case when :balance_type in ('PTD','CTD','FYS','FYE') then
  case when :translated_flag in ('T','S') then nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then decode(gb.translated_flag, 'R', nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0), nvl(gb.period_net_dr_beq,0) - nvl(gb.period_net_cr_beq,0))
    else nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.period_net_dr_beq,0) - nvl(gb.period_net_cr_beq,0)
    else nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0) end
  end
when :balance_type='YTD' then
  case when :translated_flag in ('T','S') then
    decode(gb.period_name, :period_name, nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0) + nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0) -
    decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then
      decode(gb.translated_flag, 'R',
        decode(gb.period_name, :period_name, nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0) + nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0),
        decode(gb.period_name, :period_name, nvl(gb.period_net_dr_beq,0) - nvl(gb.period_net_cr_beq,0) + nvl(gb.begin_balance_dr_beq,0) - nvl(gb.begin_balance_cr_beq,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr_beq,0) - nvl(gb.begin_balance_cr_beq,0), 0))
    else decode(gb.period_name, :period_name, nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0) + nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then
      decode(gb.period_name, :period_name, nvl(gb.period_net_dr_beq,0) - nvl(gb.period_net_cr_beq,0) + nvl(gb.begin_balance_dr_beq,0) - nvl(gb.begin_balance_cr_beq,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr_beq,0) - nvl(gb.begin_balance_cr_beq,0), 0)
    else decode(gb.period_name, :period_name, nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0) + nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0) - decode(gb.period_name, xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)), nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0) end
  end
when :balance_type='QTD' then
  case when :translated_flag in ('T','S') then nvl(gb.quarter_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.quarter_to_date_cr,0) - nvl(gb.period_net_cr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then decode(gb.translated_flag, 'R', nvl(gb.quarter_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.quarter_to_date_cr,0) - nvl(gb.period_net_cr,0), nvl(gb.quarter_to_date_dr_beq,0) + nvl(gb.period_net_dr_beq,0) - nvl(gb.quarter_to_date_cr_beq,0) - nvl(gb.period_net_cr_beq,0))
    else nvl(gb.quarter_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.quarter_to_date_cr,0) - nvl(gb.period_net_cr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.quarter_to_date_dr_beq,0) + nvl(gb.period_net_dr_beq,0) - nvl(gb.quarter_to_date_cr_beq,0) - nvl(gb.period_net_cr_beq,0)
    else nvl(gb.quarter_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.quarter_to_date_cr,0) - nvl(gb.period_net_cr,0) end
  end
when :balance_type='PJTD' then
  case when :translated_flag in ('T','S') then nvl(gb.project_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.project_to_date_cr,0) - nvl(gb.period_net_cr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then decode(gb.translated_flag, 'R', nvl(gb.project_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.project_to_date_cr,0) - nvl(gb.period_net_cr,0), nvl(gb.project_to_date_dr_beq,0) + nvl(gb.period_net_dr_beq,0) - nvl(gb.project_to_date_cr_beq,0) - nvl(gb.period_net_cr_beq,0))
    else nvl(gb.project_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.project_to_date_cr,0) - nvl(gb.period_net_cr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.project_to_date_dr_beq,0) + nvl(gb.period_net_dr_beq,0) - nvl(gb.project_to_date_cr_beq,0) - nvl(gb.period_net_cr_beq,0)
    else nvl(gb.project_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.project_to_date_cr,0) - nvl(gb.period_net_cr,0) end
  end
end
) * nvl(:multiplier,1) period_net,
-- Closing Balance (Opening + Period Net)
sum(
case when :balance_type in ('PTD','CTD','FYS','FYE') then
  case when :translated_flag in ('T','S') then
    nvl(gb.begin_balance_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.begin_balance_cr,0) - nvl(gb.period_net_cr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then 
      decode(gb.translated_flag,'R', nvl(gb.begin_balance_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.begin_balance_cr,0) - nvl(gb.period_net_cr,0),
             nvl(gb.begin_balance_dr_beq,0) + nvl(gb.period_net_dr_beq,0) - nvl(gb.begin_balance_cr_beq,0) - nvl(gb.period_net_cr_beq,0))
    else nvl(gb.begin_balance_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.begin_balance_cr,0) - nvl(gb.period_net_cr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.begin_balance_dr_beq,0) + nvl(gb.period_net_dr_beq,0) - nvl(gb.begin_balance_cr_beq,0) - nvl(gb.period_net_cr_beq,0)
    else nvl(gb.begin_balance_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.begin_balance_cr,0) - nvl(gb.period_net_cr,0) end
  end
when :balance_type='YTD' then
  case when :translated_flag in ('T','S') then
    decode(gb.period_name, :period_name, nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0) + nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0)
  when :translated_flag='E' then
    decode(gb.translated_flag, 'R', 
      decode(gb.period_name, :period_name, nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0) + nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0),
      decode(gb.period_name, :period_name, nvl(gb.period_net_dr_beq,0) - nvl(gb.period_net_cr_beq,0) + nvl(gb.begin_balance_dr_beq,0) - nvl(gb.begin_balance_cr_beq,0), 0))
  when :translated_flag='C' then
    case when gb.actual_flag='A' then
      decode(gb.period_name, :period_name, nvl(gb.period_net_dr_beq,0) - nvl(gb.period_net_cr_beq,0) + nvl(gb.begin_balance_dr_beq,0) - nvl(gb.begin_balance_cr_beq,0), 0)
    else decode(gb.period_name, :period_name, nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0) + nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0), 0) end
  end
when :balance_type='QTD' then
  case when :translated_flag in ('T','S') then nvl(gb.quarter_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.quarter_to_date_cr,0) - nvl(gb.period_net_cr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then decode(gb.translated_flag, 'R', nvl(gb.quarter_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.quarter_to_date_cr,0) - nvl(gb.period_net_cr,0), nvl(gb.quarter_to_date_dr_beq,0) + nvl(gb.period_net_dr_beq,0) - nvl(gb.quarter_to_date_cr_beq,0) - nvl(gb.period_net_cr_beq,0))
    else nvl(gb.quarter_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.quarter_to_date_cr,0) - nvl(gb.period_net_cr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.quarter_to_date_dr_beq,0) + nvl(gb.period_net_dr_beq,0) - nvl(gb.quarter_to_date_cr_beq,0) - nvl(gb.period_net_cr_beq,0)
    else nvl(gb.quarter_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.quarter_to_date_cr,0) - nvl(gb.period_net_cr,0) end
  end
when :balance_type='PJTD' then
  case when :translated_flag in ('T','S') then nvl(gb.project_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.project_to_date_cr,0) - nvl(gb.period_net_cr,0)
  when :translated_flag='E' then
    case when gb.actual_flag='A' then decode(gb.translated_flag, 'R', nvl(gb.project_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.project_to_date_cr,0) - nvl(gb.period_net_cr,0), nvl(gb.project_to_date_dr_beq,0) + nvl(gb.period_net_dr_beq,0) - nvl(gb.project_to_date_cr_beq,0) - nvl(gb.period_net_cr_beq,0))
    else nvl(gb.project_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.project_to_date_cr,0) - nvl(gb.period_net_cr,0) end
  when :translated_flag='C' then
    case when gb.actual_flag='A' then nvl(gb.project_to_date_dr_beq,0) + nvl(gb.period_net_dr_beq,0) - nvl(gb.project_to_date_cr_beq,0) - nvl(gb.period_net_cr_beq,0)
    else nvl(gb.project_to_date_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.project_to_date_cr,0) - nvl(gb.period_net_cr,0) end
  end
end
) * nvl(:multiplier,1) closing_balance,
-- Drill to Journal
case when nvl(fnd_profile.value('XXEN_FSG_DRILLDOWN_TO_SAME_WORKBOOK'), 'Y')='N' then '=dd' else '=dds' end
||'("GJ","'||gl.ledger_id||','||:period_name||','||:balance_type||','||:currency_code||','||:actual_flag||','||:budget_name||','||:encumbrance_type||','||:journal_source||','||:journal_category||','||gcck.code_combination_id||'")' drill_to_journal
from
gl_ledgers gl,
gl_code_combinations_kfv gcck,
gl_balances gb
where
1=1 and
gl.ledger_id=:ledger_id and
gcck.chart_of_accounts_id=gl.chart_of_accounts_id and
gcck.summary_flag='N' and
gb.code_combination_id=gcck.code_combination_id and
gb.ledger_id=gl.ledger_id and
gb.template_id is null and
gb.actual_flag=:actual_flag and
&gl_flex_value_security
&period_filter
&currency_filter
&budget_filter
&encumbrance_filter
having (
  sum(case when :balance_type in ('PTD','CTD','FYS','FYE') then nvl(gb.begin_balance_dr,0) - nvl(gb.begin_balance_cr,0) else 0 end) <> 0 or
  sum(case when :balance_type in ('PTD','CTD','FYS','FYE') then nvl(gb.period_net_dr,0) else 0 end) <> 0 or
  sum(case when :balance_type in ('PTD','CTD','FYS','FYE') then nvl(gb.period_net_cr,0) else 0 end) <> 0 or
  sum(case when :balance_type in ('PTD','CTD','FYS','FYE') then nvl(gb.begin_balance_dr,0) + nvl(gb.period_net_dr,0) - nvl(gb.begin_balance_cr,0) - nvl(gb.period_net_cr,0) else 0 end) <> 0 or
  1=1
)
group by
gl.name,
gl.ledger_id,
gcck.concatenated_segments,
gcck.code_combination_id
&segment_group_by
order by
gcck.concatenated_segments