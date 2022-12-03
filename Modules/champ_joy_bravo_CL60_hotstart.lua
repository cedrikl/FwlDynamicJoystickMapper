function ChampBravoMapping_CL60_hotstart()
  --function bravo_Ap_VsInc(numticks)  bravo_command_multiple("FJS/Q4XP/Autopilot/WheelUP", numticks) end
  --function bravo_Ap_VsDec(numticks)  bravo_command_multiple("FJS/Q4XP/Autopilot/WheelDN", numticks) end
  --function bravo_Ap_CrsInc(numticks) bravo_command_multiple("sim/radios/obs_HSI_up", numticks) end
  --function bravo_Ap_CrsDec(numticks) bravo_command_multiple("sim/radios/obs_HSI_down", numticks) end
  --
  --set_button_assignment(btq.ap_hdg,    "sim/none/none")
  --  function apPanelCockpitHdgShort(status) 
  --    if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_hdg") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_hdg") end
  --  end
  --
  --set_button_assignment(btq.ap_nav,    "sim/none/none")
  -- function apPanelCockpitNavShort(status) 
  --   if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_nav") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_nav") end
  -- end
  -- function apPanelCockpitNavLong(status) 
  --   if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_vnav") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_vnav") end
  -- end
  --
  --set_button_assignment(btq.ap_apr,    "sim/none/none")
  --  function apPanelCockpitAprShort(status) 
  --    if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_appr") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_appr") end
  --  end
  --
  --set_button_assignment(btq.ap_rev,    "sim/none/none")
  --  function apPanelCockpitRevShort(status)
  --    if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_bc") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_bc") end
  --  end
  --
  --set_button_assignment(btq.ap_alt,    "sim/none/none")
  --  function apPanelCockpitAltShort(status)
  --    if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_altsel") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_altsel") end
  --  end
  --  function apPanelCockpitAltLong(status)
  --    if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_alt") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_alt") end
  --  end
  --
  --set_button_assignment(btq.ap_vs,     "sim/none/none")
  --  function apPanelCockpitVsShort(status)
  --    if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_vs") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_vs") end
  --  end
  --
  --set_button_assignment(btq.ap_ias,    "sim/none/none")
  --  function apPanelCockpitIasShort(status)
  --    if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_ias") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_ias") end
  --  end
  --set_button_assignment(btq.ap_master, "sim/none/none")
  --  function apPanelCockpitMasterShort(status)
  --    if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_ap") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_ap") end
  --  end
  --  
  --do_every_frame("apPanelDualHandler()")

  champ_set_axis_assignment(btq.axis1, "speedbrakes", "reverse")
  set_button_assignment(btq.axis12_2nd_func, "CL650/pedestal/throttle/at_disc_L")
  set_button_assignment(btq.axis3_2nd_func, "CL650/pedestal/throttle/toga_L")

  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
-----------------
--PANEL BUTTONS--
-----------------
--Strobe light
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
--Taxi light
  set_button_assignment(btq.sw6_up,    "sim/none/none")
  set_button_assignment(btq.sw6_dn,    "sim/none/none")
--Landing light
  set_button_assignment(btq.sw7_up,    "sim/none/none")
  set_button_assignment(btq.sw7_dn,    "sim/none/none")
end

function ChampBravoLed_CL60_hotstart()
end

function ChampBravoCheck_CL60_hotstart()
  if (
      --AP Panel

      --Axis
      XPLMFindCommand("CL650/pedestal/throttle/at_disc_L") ~= nil and
      XPLMFindCommand("CL650/pedestal/throttle/toga_L")    ~= nil and

      --Switches
      --XPLMFindCommand("FJS/Q4XP/SoftKey/ap_hdg")              ~= nil and
      --XPLMFindCommand("FJS/Q4XP/SoftKey/ap_nav")              ~= nil and
      --XPLMFindCommand("FJS/Q4XP/SoftKey/ap_vnav")             ~= nil and
      --XPLMFindCommand("FJS/Q4XP/SoftKey/ap_appr")             ~= nil and
      --XPLMFindCommand("FJS/Q4XP/SoftKey/ap_bc")               ~= nil and
      --XPLMFindCommand("FJS/Q4XP/SoftKey/ap_altsel")           ~= nil and
      --XPLMFindCommand("FJS/Q4XP/SoftKey/ap_alt")              ~= nil and
      --XPLMFindCommand("FJS/Q4XP/SoftKey/ap_vs")               ~= nil and
      --XPLMFindCommand("FJS/Q4XP/SoftKey/ap_ias")              ~= nil and
      --XPLMFindCommand("FJS/Q4XP/SoftKey/ap_ap")               ~= nil and
      --XPLMFindCommand("FJS/Q4XP/Switches/ACOL_up")            ~= nil and
      --XPLMFindCommand("FJS/Q4XP/Switches/ACOL_dn")            ~= nil and
      --XPLMFindCommand("FJS/Q4XP/Switches/TAXI_LIGHTS")        ~= nil and
      --XPLMFindCommand("FJS/Q4XP/Switches/APPR_LIGHTS")        ~= nil and
      --XPLMFindCommand("FJS/Q4XP/Switches/FLARE_LIGHTS")       ~= nil
      true
    ) then return true
  else
    return false
  end
end
