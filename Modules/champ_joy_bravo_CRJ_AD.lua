--AD Simulation CRJ-900
function ChampBravoMapping_CRJ_AD()
  function bravo_Ap_AltInc(numticks) bravo_command_multiple("crj900/command/autopilot/alt_lrg_up", numticks) end
  function bravo_Ap_AltDec(numticks) bravo_command_multiple("crj900/command/autopilot/alt_lrg_down", numticks) end
  function bravo_Ap_VsInc(numticks)  bravo_command_multiple("crj900/command/autopilot/vs_up", numticks) end
  function bravo_Ap_VsDec(numticks)  bravo_command_multiple("crj900/command/autopilot/vs_down", numticks) end
  function bravo_Ap_HdgInc(numticks) bravo_command_multiple("crj900/command/autopilot/hdg_lrg_up", numticks) end
  function bravo_Ap_HdgDec(numticks) bravo_command_multiple("crj900/command/autopilot/hdg_lrg_down", numticks) end
  function bravo_Ap_CrsInc(numticks) bravo_command_multiple("crj900/command/autopilot/crs1_lrg_up", numticks) end
  function bravo_Ap_CrsDec(numticks) bravo_command_multiple("crj900/command/autopilot/crs1_lrg_down", numticks) end
  function bravo_Ap_IasInc(numticks) bravo_command_multiple("crj900/command/autopilot/speed_lrg_up", numticks) end
  function bravo_Ap_IasDec(numticks) bravo_command_multiple("crj900/command/autopilot/speed_lrg_down", numticks) end
  
  set_button_assignment(btq.ap_hdg,    "sim/none/none")
  function apPanelCockpitHdgShort(status) 
    if (status == "begin") then command_begin("crj900/command/autopilot/hdg") elseif (status == "end") then command_end("crj900/command/autopilot/hdg") end
  end
  
  set_button_assignment(btq.ap_nav,    "sim/none/none")
  function apPanelCockpitNavShort(status) 
    if (status == "begin") then command_begin("crj900/command/autopilot/nav") elseif (status == "end") then command_end("crj900/command/autopilot/nav") end
  end
  --function apPanelCockpitNavLong(status) 
  --  if (status == "begin") then command_begin("") elseif (status == "end") then command_end("") end
  --end
  
  set_button_assignment(btq.ap_apr,    "sim/none/none")
  function apPanelCockpitAprShort(status) 
    if (status == "begin") then command_begin("crj900/command/autopilot/appr") elseif (status == "end") then command_end("crj900/command/autopilot/appr") end
  end
  
  set_button_assignment(btq.ap_rev,    "sim/none/none")
  function apPanelCockpitRevShort(status)
    if (status == "begin") then command_begin("crj900/command/autopilot/b_c") elseif (status == "end") then command_end("crj900/command/autopilot/b_c") end
  end
  
  set_button_assignment(btq.ap_alt,    "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then command_begin("crj900/command/autopilot/alt") elseif (status == "end") then command_end("crj900/command/autopilot/alt") end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then command_begin("crj900/command/autopilot/alt_button") elseif (status == "end") then command_end("crj900/command/autopilot/alt_button") end
  end
  
  set_button_assignment(btq.ap_vs,     "sim/none/none")
  function apPanelCockpitVsShort(status)
    if (status == "begin") then command_begin("crj900/command/autopilot/vs") elseif (status == "end") then command_end("crj900/command/autopilot/vs") end
  end
  
  set_button_assignment(btq.ap_ias,    "sim/none/none")
  function apPanelCockpitIasShort(status)
    if (status == "begin") then command_begin("crj900/command/autopilot/speed") elseif (status == "end") then command_end("crj900/command/autopilot/speed") end
  end
    
  set_button_assignment(btq.ap_master, "sim/none/none")
  function apPanelCockpitMasterShort(status)
    if (status == "begin") then command_begin("crj900/command/autopilot/ap_engage") elseif (status == "end") then command_end("crj900/command/autopilot/ap_engage") end
  end
    
  do_every_frame("apPanelDualHandler()")

  -- SPEEDBRAKES/SPOILERS: You need to check the Honeycomb option in the tablet options in the cockpit.
  set_button_assignment(btq.axis3_2nd_func, "crj900/pedestal/Throttle/Left_Toga_Detent")

  --Cowl Anti-Ice L+R
  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_often([[
    CowlAILPos = get("crj900/anti_ice/cowl_lh_animation")
    CowlAIRPos = get("crj900/anti_ice/cowl_rh_animation")
    SwPos2 = button(]]..btq.sw2_up..[[)
  
    if (SwPos2 and (CowlAILPos < 1)) then
      command_once("crj900/anti_ice/cowl_lh_down")
    elseif (not(SwPos2) and (CowlAILPos > 0)) then
      command_once("crj900/anti_ice/cowl_lh_up")
    end
  
    if (SwPos2 and (CowlAIRPos < 1)) then
      command_once("crj900/anti_ice/cowl_rh_down")
    elseif (not(SwPos2) and (CowlAIRPos > 0)) then
      command_once("crj900/anti_ice/cowl_rh_up")
    end
  ]])
  
  --Wing Anti-Ice
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
  do_often([[
    WingAI_Pos = get("crj900/anti_ice/wing_animation")
    SwPos3 = button(]]..btq.sw3_up..[[)
  
    if (SwPos3 and (WingAI_Pos < 1)) then
      command_once("crj900/anti_ice/wing_down")
    elseif (not(SwPos3) and (WingAI_Pos > 0)) then
      command_once("crj900/anti_ice/wing_up")
    end
  ]])
  
  --Strobe Lights
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_often([[
    Strobe_Pos = get("crj900/EXT_LTS/strobe_anim")
    SwPos5 = button(]]..btq.sw5_up..[[)
  
    if (SwPos5 and (Strobe_Pos < 1)) then
      command_once("crj900/EXT_LTS/strobe_down")
    elseif (not(SwPos5) and (Strobe_Pos > 0)) then
      command_once("crj900/EXT_LTS/strobe_up")
    end
  ]])
  
  --Taxi Lights
  set_button_assignment(btq.sw6_up,     "sim/none/none")
  set_button_assignment(btq.sw6_dn,     "sim/none/none")
  do_often([[
    Taxi_Pos =  get("crj900/LDG_LTS/taxi_anim")
    SwPos6 = button(]]..btq.sw6_up..[[)
    
    if (SwPos6 and (Taxi_Pos < 1)) then
      command_once("crj900/LDG_LTS/taxi_down")
    elseif (not(SwPos6) and (Taxi_Pos > 0)) then
      command_once("crj900/LDG_LTS/taxi_up")
    end
  ]])
  
  --Landing Lights
  set_button_assignment(btq.sw7_up, "sim/none/none")
  set_button_assignment(btq.sw7_dn, "sim/none/none")
  do_often([[
    C_Pos = get("crj900/LDG_LTS/nose_anim")
    L_Pos = get("crj900/LDG_LTS/left_anim")
    R_Pos = get("crj900/LDG_LTS/right_anim")
    SwPos7 = button(]]..btq.sw7_up..[[)
  
    if (SwPos7 and (C_Pos ~= 1)) then
      command_once("crj900/LDG_LTS/nose_down")
    elseif (not(SwPos7) and (C_Pos ~= 0)) then
      command_once("crj900/LDG_LTS/nose_up")
    end
  
    if (SwPos7 and (L_Pos ~= 1)) then
      command_once("crj900/LDG_LTS/left_down")
    elseif (not(SwPos7) and (L_Pos ~= 0)) then
      command_once("crj900/LDG_LTS/left_up")
    end
  
    if (SwPos7 and (R_Pos ~= 1)) then
      command_once("crj900/LDG_LTS/right_down")
    elseif (not(SwPos7) and (R_Pos ~= 0)) then
      command_once("crj900/LDG_LTS/right_up")
    end
  ]])
end


function ChampBravoLed_CRJ_AD()

end


function ChampBravoCheck_CRJ_AD()
 if (
      --Datarefs
      XPLMFindDataRef("crj900/LDG_LTS/taxi_anim")                      ~= nil and
      XPLMFindDataRef("crj900/LDG_LTS/left_anim")                      ~= nil and
      XPLMFindDataRef("crj900/LDG_LTS/nose_anim")                      ~= nil and
      XPLMFindDataRef("crj900/LDG_LTS/right_anim")                     ~= nil and
      XPLMFindDataRef("crj900/LDG_LTS/right_anim")                     ~= nil and
      XPLMFindDataRef("crj900/EXT_LTS/strobe_anim")                    ~= nil and
      XPLMFindDataRef("crj900/anti_ice/wing_animation")                ~= nil and
      XPLMFindDataRef("crj900/anti_ice/cowl_lh_animation")             ~= nil and
      XPLMFindDataRef("crj900/anti_ice/cowl_rh_animation")             ~= nil and

      --COMMANDS--
      --TOGA + Disconnect
      XPLMFindCommand("crj900/pedestal/Throttle/Left_Toga_Detent")     ~= nil and
      --Switches                                                            
      XPLMFindCommand("crj900/LDG_LTS/taxi_up")                        ~= nil and
      XPLMFindCommand("crj900/LDG_LTS/taxi_down")                      ~= nil and
      XPLMFindCommand("crj900/LDG_LTS/left_up")                        ~= nil and
      XPLMFindCommand("crj900/LDG_LTS/left_down")                      ~= nil and
      XPLMFindCommand("crj900/LDG_LTS/nose_up")                        ~= nil and
      XPLMFindCommand("crj900/LDG_LTS/nose_down")                      ~= nil and
      XPLMFindCommand("crj900/LDG_LTS/right_up")                       ~= nil and
      XPLMFindCommand("crj900/LDG_LTS/right_down")                     ~= nil and
      XPLMFindCommand("crj900/EXT_LTS/strobe_up")                      ~= nil and
      XPLMFindCommand("crj900/EXT_LTS/strobe_down")                    ~= nil and
      XPLMFindCommand("crj900/anti_ice/wing_up")                       ~= nil and
      XPLMFindCommand("crj900/anti_ice/wing_down")                     ~= nil and
      XPLMFindCommand("crj900/anti_ice/cowl_lh_up")                    ~= nil and
      XPLMFindCommand("crj900/anti_ice/cowl_lh_down")                  ~= nil and
      XPLMFindCommand("crj900/anti_ice/cowl_rh_up")                    ~= nil and
      XPLMFindCommand("crj900/anti_ice/cowl_rh_down")                  ~= nil and
      --AP Push Buttons
      XPLMFindCommand("crj900/command/autopilot/ap_engage")            ~= nil and
      XPLMFindCommand("crj900/command/autopilot/speed")                ~= nil and
      XPLMFindCommand("crj900/command/autopilot/vs")                   ~= nil and
      XPLMFindCommand("crj900/command/autopilot/alt")                  ~= nil and
      XPLMFindCommand("crj900/command/autopilot/b_c")                  ~= nil and
      XPLMFindCommand("crj900/command/autopilot/appr")                 ~= nil and
      XPLMFindCommand("crj900/command/autopilot/nav")                  ~= nil and
      XPLMFindCommand("crj900/command/autopilot/hdg")                  ~= nil and
      XPLMFindCommand("crj900/command/autopilot/alt_lrg_up")           ~= nil and
      XPLMFindCommand("crj900/command/autopilot/alt_lrg_down")         ~= nil and
      XPLMFindCommand("crj900/command/autopilot/vs_up")                ~= nil and
      XPLMFindCommand("crj900/command/autopilot/vs_down")              ~= nil and
      XPLMFindCommand("crj900/command/autopilot/hdg_lrg_up")           ~= nil and
      XPLMFindCommand("crj900/command/autopilot/hdg_lrg_down")         ~= nil and
      XPLMFindCommand("crj900/command/autopilot/crs1_lrg_up")          ~= nil and
      XPLMFindCommand("crj900/command/autopilot/crs1_lrg_down")        ~= nil and
      XPLMFindCommand("crj900/command/autopilot/speed_lrg_up")         ~= nil and
      XPLMFindCommand("crj900/command/autopilot/speed_lrg_down")       ~= nil
     ) then return true
  else
    return false
  end
end
