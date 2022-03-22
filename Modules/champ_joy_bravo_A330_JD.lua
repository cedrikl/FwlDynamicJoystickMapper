--JARDESIGN A330 BRAVO MAPPINGS
function ChampBravoEngine_A330_JD()

end

function ChampBravoMapping_A330_JD()
  --function bravo_Ap_AltInc(numticks) bravo_command_multiple("sim/autopilot/altitude_up", numticks) end
  --function bravo_Ap_AltDec(numticks) bravo_command_multiple("sim/autopilot/altitude_down", numticks) end
  function bravo_Ap_VsInc(numticks)  bravo_command_multiple("sim/autopilot/vertical_speed_up", numticks) end
  function bravo_Ap_VsDec(numticks)  bravo_command_multiple("sim/autopilot/vertical_speed_down", numticks) end
  --function bravo_Ap_HdgInc(numticks) bravo_command_multiple("sim/autopilot/heading_up", numticks) end
  --function bravo_Ap_HdgDec(numticks) bravo_command_multiple("sim/autopilot/heading_down", numticks) end
  --function bravo_Ap_IasInc(numticks) bravo_command_multiple("sim/autopilot/airspeed_up", numticks) end
  --function bravo_Ap_IasDec(numticks) bravo_command_multiple("sim/autopilot/airspeed_down", numticks) end

--------------------------------
--ROTARY PUSH & PULL functions--
--------------------------------
--BARO STD
  set_button_assignment(btq.ap_rev,    "sim/none/none")
  function apPanelCockpitRevShort(status) 
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/baro_push_bat", 1) elseif (status == "end") then command_end = set("sim/custom/xap/fcu/baro_push_bat", 0) end
  end
  function apPanelCockpitRevLong(status) 
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/baro_pull_bat", 1) elseif (status == "end") then command_end = set("sim/custom/xap/fcu/baro_pull_bat", 0) end
  end
--SPEED IAS
  set_button_assignment(btq.ap_ias,    "sim/none/none")
  function apPanelCockpitIasShort(status) 
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/spd_push_bat", 1) elseif (status == "end") then command_end = set("sim/custom/xap/fcu/spd_push_bat", 0) end
  end
  function apPanelCockpitIasLong(status) 
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/spd_pull_bat", 1) elseif (status == "end") then command_end = set("sim/custom/xap/fcu/spd_pull_bat", 0) end
  end
--HEADING
  set_button_assignment(btq.ap_hdg,    "sim/none/none")
  function apPanelCockpitHdgShort(status) 
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/hdg_push_bat", 1) elseif (status == "end") then command_end = set("sim/custom/xap/fcu/hdg_push_bat", 0) end
  end
  function apPanelCockpitHdgLong(status) 
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/hdg_pull_bat", 1) elseif (status == "end") then command_end = set("sim/custom/xap/fcu/hdg_pull_bat", 0) end
  end
--ALTITUDE
  set_button_assignment(btq.ap_alt,    "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/alt_push_bat", 1) elseif (status == "end") then command_end = set("sim/custom/xap/fcu/alt_push_bat", 0)end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/alt_pull_bat", 1) elseif (status == "end") then command_end = set("sim/custom/xap/fcu/alt_pull_bat", 0) end
  end
--VS
  set_button_assignment(btq.ap_vs,     "sim/none/none")
  function apPanelCockpitVsShort(status)
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/vvi_push_bat", 1) elseif (status == "end") then command_end = set("sim/custom/xap/fcu/vvi_push_bat", 0) end
  end
  function apPanelCockpitVsLong(status)
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/vvi_pull_bat", 1) elseif (status == "end") then command_end = set("sim/custom/xap/fcu/vvi_pull_bat", 0) end
  end
  
--------------------
--MCP PUSH BUTTONS--
--------------------
  
--AUTOPILOT MASTER 1 & AUTO THROTTLE ENGAGE Buttons
  set_button_assignment(btq.ap_master, "sim/none/none")
  function apPanelCockpitMasterShort(status)
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/ap1", 1) end
  end
  function apPanelCockpitMasterLong(status)
    if (status == "begin") then command_begin = set("jd/fcu/athr_pb", 1) end
  end
--ALT Button
  set_button_assignment(btq.ap_nav,    "sim/autopilot/altitude_arm")
--  function apPanelCockpitLvcShort(status) 
--    if (status == "begin") then command_begin("sim/autopilot/alt_arm") end
--  end  
--  function apPanelCockpitLvcLong(status) 
--    if (status == "begin") then command_begin("sim/autopilot/alt_hold") end
--  end
--APPROACH & LOCALISER Buttons
  set_button_assignment(btq.ap_apr,    "sim/none/none")
  function apPanelCockpitAprShort(status) 
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/appr_bat", 1) end
  end
  function apPanelCockpitAprLong(status) 
    if (status == "begin") then command_begin = set("sim/custom/xap/fcu/loc_bat", 1) end
  end

  do_every_frame("apPanelDualHandler()")


  set_button_assignment(btq.axis12_2nd_func, "sim/none/none")
  do_often([[
    ATlight = get("jd/fcu/athr_lt")
    ATDiscSw = button(]]..btq.axis12_2nd_func..[[)
    
    if (ATDiscSw and (ATlight == 1)) then
      set("jd/fcu/athr_pb", 1)
    end
  ]])
--  set_button_assignment(btq.axis3_2nd_func,  "SSG/UFMC/TOGA_Button")


--ENGINE ANTI ICE
  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_often([[
    Eng1Pos = get("sim/custom/xap/icerain/eng1_knob")
    Eng2Pos = get("sim/custom/xap/icerain/eng2_knob")
    SwPos2 = button(]]..btq.sw2_up..[[)
    
    if (SwPos2 and (Eng1Pos ~= 1)) then
      set("sim/custom/xap/icerain/eng1_knob", 1)
    elseif (not(SwPos2) and (Eng1Pos == 1)) then
      set("sim/custom/xap/icerain/eng1_knob", 0)
    end
    
    if (SwPos2 and (Eng2Pos ~= 1)) then
      set("sim/custom/xap/icerain/eng2_knob", 1)
    elseif (not(SwPos2) and (Eng2Pos == 1)) then
      set("sim/custom/xap/icerain/eng2_knob", 0)
    end
  ]])
--WING ANTI ICE switch  
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
    do_often([[
    WingPos = get("sim/custom/xap/icerain/wing_knob")
    SwPos3 = button(]]..btq.sw3_up..[[)
    
    if (SwPos3 and (WingPos ~= 1)) then
      set("sim/custom/xap/icerain/wing_knob", 1)
    elseif (not(SwPos3) and (WingPos == 1)) then
      set("sim/custom/xap/icerain/wing_knob", 0)
    end
  ]])

--STROBE Light Switch
  set_button_assignment(btq.sw5_up,   "sim/none/none")
  set_button_assignment(btq.sw5_dn,   "sim/none/none")
  do_often([[
    Strobe_Pos = get("sim/custom/xap/extlight/strobe_sw")
    SwStrPos = button(]]..btq.sw5_up..[[)
    
    if (SwStrPos and (Strobe_Pos ~= 2)) then
      set("sim/custom/xap/extlight/strobe_sw", 2)
    elseif (not(SwStrPos) and (Strobe_Pos > 0)) then
      set("sim/custom/xap/extlight/strobe_sw", 0)
    end
  ]])  
----TAxi and Landing swtiches
  set_button_assignment(btq.sw6_up,    "sim/none/none")
  set_button_assignment(btq.sw6_dn,    "sim/none/none")
  set_button_assignment(btq.sw7_up,    "sim/none/none")
  set_button_assignment(btq.sw7_dn,    "sim/none/none")
  do_often([[
    L_Pos = get("sim/custom/xap/extlight/land_sw")
    N_Pos = get("sim/custom/xap/extlight/nose_sw")
    SwPos6 = button(]]..btq.sw6_up..[[)
    SwPos7 = button(]]..btq.sw7_up..[[)
    
    if (SwPos6 and not(SwPos7) and (N_Pos ~= 1)) then
      set("sim/custom/xap/extlight/nose_sw", 1)
    elseif (SwPos6 and SwPos7 and (N_Pos ~= 2)) then
      set("sim/custom/xap/extlight/nose_sw", 2)
    elseif (not(SwPos6) and not(SwPos7) and (N_Pos ~= 0)) then
      set("sim/custom/xap/extlight/nose_sw", 0)
    end

    if (SwPos7 and (L_Pos ~= 1)) then
      set("sim/custom/xap/extlight/land_sw", 1) 
    elseif (SwPos7 and (N_Pos ~= 2)) then
      set("sim/custom/xap/extlight/nose_sw", 2)
    elseif (not(SwPos7) and (L_Pos == 1)) then
      set("sim/custom/xap/extlight/land_sw", 0)
    end
  ]]) 
end


function ChampBravoLed_A330_JD()
end


function ChampBravoCheck_A330_JD()
  if (--Switches
      XPLMFindDataRef("sim/custom/xap/extlight/strobe_sw")                     ~= nil and
      XPLMFindDataRef("sim/custom/xap/extlight/land_sw")                       ~= nil and
      XPLMFindDataRef("sim/custom/xap/extlight/nose_sw")                       ~= nil and
      XPLMFindDataRef("sim/custom/xap/icerain/eng1_knob")                      ~= nil and
      XPLMFindDataRef("sim/custom/xap/icerain/eng2_knob")                      ~= nil and
      XPLMFindDataRef("sim/custom/xap/icerain/wing_knob")                      ~= nil and
      XPLMFindDataRef("jd/fcu/athr_lt")                                        ~= nil and
      XPLMFindDataRef("jd/fcu/athr_pb")                                        ~= nil
     ) then return true
  else
    return false
  end
end
