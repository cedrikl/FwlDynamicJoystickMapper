--FlyJSim Q4XP (DH8D) Bravo Mappings

function ChampBravoMapping_DH8D_FlyJSim()
  function bravo_Ap_VsInc(numticks)  bravo_command_multiple("FJS/Q4XP/Autopilot/WheelUP", numticks) end
  function bravo_Ap_VsDec(numticks)  bravo_command_multiple("FJS/Q4XP/Autopilot/WheelDN", numticks) end
  function bravo_Ap_CrsInc(numticks) bravo_command_multiple("sim/radios/obs_HSI_up", numticks) end
  function bravo_Ap_CrsDec(numticks) bravo_command_multiple("sim/radios/obs_HSI_down", numticks) end

  set_button_assignment(btq.ap_hdg,    "sim/none/none")
    function apPanelCockpitHdgShort(status) 
      if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_hdg") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_hdg") end
    end

 set_button_assignment(btq.ap_nav,    "sim/none/none")
   function apPanelCockpitNavShort(status) 
     if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_nav") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_nav") end
   end
   function apPanelCockpitNavLong(status) 
     if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_vnav") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_vnav") end
   end
  
  set_button_assignment(btq.ap_apr,    "sim/none/none")
    function apPanelCockpitAprShort(status) 
      if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_appr") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_appr") end
    end

  set_button_assignment(btq.ap_rev,    "sim/none/none")
    function apPanelCockpitRevShort(status)
      if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_bc") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_bc") end
    end

  set_button_assignment(btq.ap_alt,    "sim/none/none")
    function apPanelCockpitAltShort(status)
      if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_altsel") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_altsel") end
    end
    function apPanelCockpitAltLong(status)
      if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_alt") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_alt") end
    end
  
  set_button_assignment(btq.ap_vs,     "sim/none/none")
    function apPanelCockpitVsShort(status)
      if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_vs") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_vs") end
    end

  set_button_assignment(btq.ap_ias,    "sim/none/none")
    function apPanelCockpitIasShort(status)
      if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_ias") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_ias") end
    end
  set_button_assignment(btq.ap_master, "sim/none/none")
    function apPanelCockpitMasterShort(status)
      if (status == "begin") then command_begin("FJS/Q4XP/SoftKey/ap_ap") elseif (status == "end") then command_end("FJS/Q4XP/SoftKey/ap_ap") end
    end
    
  do_every_frame("apPanelDualHandler()")

  set_button_assignment(btq.axis12_2nd_func, "FJS/Q4XP/ENGINES/PowerGatePassALL")
  champ_set_axis_assignment(btq.axis1, "prop", "normal")
  champ_set_axis_assignment(btq.axis4, "none", "normal")
  champ_set_axis_assignment(btq.axis5, "none", "normal")

  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
  set_button_assignment(btq.sw4_up, "sim/none/none")
  set_button_assignment(btq.sw4_dn, "sim/none/none")
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  set_button_assignment(btq.sw6_up, "sim/none/none")
  set_button_assignment(btq.sw6_dn, "sim/none/none")
  set_button_assignment(btq.sw7_up, "sim/none/none")
  set_button_assignment(btq.sw7_dn, "sim/none/none")
-----------------
--PANEL BUTTONS--
-----------------
--Strobe light
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_often([[
    Str_Pos = get("FJS/Q4XP/Manips/TwoSwitch_Anim", 23)
    SwStr = button(]]..btq.sw5_up..[[)
 
    if (SwStr and (Str_Pos ~= 1)) then
      command_once("FJS/Q4XP/Switches/ACOL_dn")
    elseif (not(SwStr) and (Str_Pos > 0)) then
      command_once("FJS/Q4XP/Switches/ACOL_up")
    end
  ]])
--Taxi light
  set_button_assignment(btq.sw6_up,    "sim/none/none")
  set_button_assignment(btq.sw6_dn,    "sim/none/none")
  do_often([[
    TaxiPos = get("FJS/Q4XP/Manips/TwoSwitch_Anim", 18)
    SwPos6 = button(]]..btq.sw6_up..[[)

    if (SwPos6 and (TaxiPos ~= 1)) then
      command_once("FJS/Q4XP/Switches/TAXI_LIGHTS")
    elseif (not(SwPos6) and (TaxiPos == 1)) then
      command_once("FJS/Q4XP/Switches/TAXI_LIGHTS")
    end
  ]])
--Landing light
  set_button_assignment(btq.sw7_up,    "sim/none/none")
  set_button_assignment(btq.sw7_dn,    "sim/none/none")
  do_often([[
    AppPos = get("FJS/Q4XP/Manips/TwoSwitch_Anim", 16)
    FlrPos = get("FJS/Q4XP/Manips/TwoSwitch_Anim", 17)
    SwPos7 = button(]]..btq.sw7_up..[[)
    
    if (SwPos7 and (AppPos ~= 1)) then
      command_once("FJS/Q4XP/Switches/APPR_LIGHTS")
    elseif (not(SwPos7) and (AppPos == 1)) then
      command_once("FJS/Q4XP/Switches/APPR_LIGHTS")
    end

    if (SwPos7 and (FlrPos ~= 1)) then
      command_once("FJS/Q4XP/Switches/FLARE_LIGHTS")
    elseif (not(SwPos7) and (FlrPos == 1)) then
      command_once("FJS/Q4XP/Switches/FLARE_LIGHTS")
    end
  ]])
end

function ChampBravoLed_DH8D_FlyJSim()
end

function ChampBravoCheck_DH8D_FlyJSim()
  if (
      --AP Panel
      XPLMFindCommand("FJS/Q4XP/Autopilot/WheelUP")           ~= nil and
      XPLMFindCommand("FJS/Q4XP/Autopilot/WheelDN")           ~= nil and

      --Axis
      XPLMFindCommand("FJS/Q4XP/ENGINES/PowerGatePassALL")    ~= nil and

      --Switches
      XPLMFindDataRef("FJS/Q4XP/Manips/TwoSwitch_Anim")       ~= nil and
                                                          
      XPLMFindCommand("FJS/Q4XP/SoftKey/ap_hdg")              ~= nil and
      XPLMFindCommand("FJS/Q4XP/SoftKey/ap_nav")              ~= nil and
      XPLMFindCommand("FJS/Q4XP/SoftKey/ap_vnav")             ~= nil and
      XPLMFindCommand("FJS/Q4XP/SoftKey/ap_appr")             ~= nil and
      XPLMFindCommand("FJS/Q4XP/SoftKey/ap_bc")               ~= nil and
      XPLMFindCommand("FJS/Q4XP/SoftKey/ap_altsel")           ~= nil and
      XPLMFindCommand("FJS/Q4XP/SoftKey/ap_alt")              ~= nil and
      XPLMFindCommand("FJS/Q4XP/SoftKey/ap_vs")               ~= nil and
      XPLMFindCommand("FJS/Q4XP/SoftKey/ap_ias")              ~= nil and
      XPLMFindCommand("FJS/Q4XP/SoftKey/ap_ap")               ~= nil and
      XPLMFindCommand("FJS/Q4XP/Switches/ACOL_up")            ~= nil and
      XPLMFindCommand("FJS/Q4XP/Switches/ACOL_dn")            ~= nil and
      XPLMFindCommand("FJS/Q4XP/Switches/TAXI_LIGHTS")        ~= nil and
      XPLMFindCommand("FJS/Q4XP/Switches/APPR_LIGHTS")        ~= nil and
      XPLMFindCommand("FJS/Q4XP/Switches/FLARE_LIGHTS")       ~= nil
    ) then return true
  else
    return false
  end
end
