--SSG EJET 195

function ChampBravoEngine_E195_SSG()

end

function ChampBravoMapping_E195_SSG()
  --function bravo_Ap_AltInc(numticks) bravo_command_multiple("SSG/UFMC/Alt_UP", numticks) end
  --function bravo_Ap_AltDec(numticks) bravo_command_multiple("SSG/UFMC/Alt_Down", numticks) end
  --function bravo_Ap_VsInc(numticks)  bravo_command_multiple("SSG/UFMC/VS_UP", numticks) end
  --function bravo_Ap_VsDec(numticks)  bravo_command_multiple("SSG/UFMC/VS_Down", numticks) end
  --function bravo_Ap_HdgInc(numticks) bravo_command_multiple("SSG/UFMC/HDG_UP", numticks) end
  --function bravo_Ap_HdgDec(numticks) bravo_command_multiple("SSG/UFMC/HDG_Down", numticks) end
  --function bravo_Ap_IasInc(numticks) bravo_command_multiple("SSG/UFMC/Speed_UP", numticks) end
  --function bravo_Ap_IasDec(numticks) bravo_command_multiple("SSG/UFMC/Speed_Down", numticks) end
  --
  --set_button_assignment(btq.ap_hdg,    "sim/none/none")
  --function apPanelCockpitHdgShort(status) 
  --  if (status == "begin") then command_begin("SSG/UFMC/AP_HDG_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_HDG_Button") end
  --end
  --function apPanelCockpitHdgLong(status) 
  --  if (status == "begin") then command_begin("SSG/UFMC/AP_HDGHOLD_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_HDGHOLD_Button") end
  --end
  --
  --set_button_assignment(btq.ap_nav,    "sim/none/none")
  --function apPanelCockpitNavShort(status) 
  --  if (status == "begin") then command_begin("SSG/UFMC/AP_LNAV_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_LNAV_Button") end
  --end
  --function apPanelCockpitNavLong(status) 
  --  if (status == "begin") then command_begin("SSG/UFMC/AP_VNAV_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_VNAV_Button") end
  --end
  --
  --set_button_assignment(btq.ap_apr,    "sim/none/none")
  --function apPanelCockpitAprShort(status) 
  --  if (status == "begin") then command_begin("SSG/UFMC/AP_APP_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_APP_Button") end
  --end
  --function apPanelCockpitAprLong(status) 
  --  if (status == "begin") then command_begin("SSG/UFMC/AP_VORLOC_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_VORLOC_Button") end
  --end
  --
  ----set_button_assignment(btq.ap_rev,    "sim/none/none")
  ----function apPanelCockpitRevShort(status)    end
  ----function apPanelCockpitRevLong(status)     end
  --
  --set_button_assignment(btq.ap_alt,    "sim/none/none")
  --function apPanelCockpitAltShort(status)
  --  if (status == "begin") then command_begin("SSG/UFMC/AP_LVLCHG_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_LVLCHG_Button") end
  --end
  --function apPanelCockpitAltLong(status)
  --  if (status == "begin") then command_begin("sim/autopilot/altitude_hold") elseif (status == "end") then command_end("sim/autopilot/altitude_hold") end
  --end
  --
  --set_button_assignment(btq.ap_vs,     "SSG/UFMC/AP_VS_Button")
  ----function apPanelCockpitVsShort(status)
  ----  if (status == "begin") then command_begin(") elseif (status == "end") then command_end("") end
  ----end
  ----function apPanelCockpitVsLong(status)
  ----  if (status == "begin") then command_begin("") elseif (status == "end") then command_end("") end
  ----end
  --
  --set_button_assignment(btq.ap_ias,    "sim/none/none")
  --function apPanelCockpitIasShort(status)
  --  if (status == "begin") then command_begin("SSG/UFMC/AP_SPD_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_SPD_Button") end
  --end
  --function apPanelCockpitIasLong(status)
  --  if (status == "begin") then command_begin("SSG/UFMC/AP_N1_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_N1_Button") end
  --end
  --
  --set_button_assignment(btq.ap_master, "sim/none/none")
  --function apPanelCockpitMasterShort(status)
  --  if (status == "begin") then command_begin("SSG/UFMC/AP_CMDA_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_CMDA_Button") end
  --end
  --function apPanelCockpitMasterLong(status)
  --  if (status == "begin") then command_begin("SSG/UFMC/AP_ARM_AT_Switch") elseif (status == "end") then command_end("SSG/UFMC/AP_ARM_AT_Switch") end
  --end
  --
  --do_every_frame("apPanelDualHandler()")

  -------------------------
  -- Axis --
  -------------------------

  --set_button_assignment(btq.axis12_2nd_func, "SSG/UFMC/AT_Discon")
  --set_button_assignment(btq.axis3_2nd_func,  "SSG/UFMC/TOGA_Button")

  set_axis_assignment(btq.axis1,  "none",  "normal")
  do_every_frame([[
    joy_pos = get("sim/joystick/joystick_axis_values", ]]..btq.axis1..[[)
    set("SSG/B748/speed_brk_hand", 1-joy_pos)
  ]])
  -----------------
  --PANEL BUTTONS--
  -----------------

  --Eng Anti-Ice
  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_often([[
    Eng1failpos = get("SSG/EJET/ANTICE/ice_eng1_fail")
    Eng2failpos = get("SSG/EJET/ANTICE/ice_eng2_fail")
    SwPos2 = button(]]..btq.sw2_up..[[)
    
    if (SwPos2 and (Eng1failpos ~= 0)) then
      set("SSG/EJET/ANTICE/ice_eng1_sw", 1)
    elseif (not(SwPos2) and (Eng1failpos ~= 1)) then
      set("SSG/EJET/ANTICE/ice_eng1_sw", 1)
    end
    
    if (SwPos2 and (Eng2failpos ~= 0)) then
      set("SSG/EJET/ANTICE/ice_eng2_sw", 1)
    elseif (not(SwPos2) and (Eng2failpos ~= 1)) then
      set("SSG/EJET/ANTICE/ice_eng2_sw", 1)
    end
  ]])
  --Wing anti-ice
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
  do_often([[
    Wingfailpos = get("SSG/EJET/ANTICE/ice_wing_fail")
    SwPos3 = button(]]..btq.sw3_up..[[)
    
    if (SwPos3 and (Wingfailpos ~= 0)) then
      set("SSG/EJET/ANTICE/ice_wing_sw", 1)
    elseif (not(SwPos3) and (Wingfailpos ~= 1)) then
      set("SSG/EJET/ANTICE/ice_wing_sw", 1)
    end
  ]])
  --Strobe light
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_often([[
    Str1Pos = get("SSG/EJET/LIGHTS/strobe_lights_sw")
    SwPos5 = button(]]..btq.sw5_up..[[)
    
    if (SwPos5 and (Str1Pos ~= 1)) then
      set("SSG/EJET/LIGHTS/strobe_lights_sw", 1)
    elseif (not(SwPos5) and (Str1Pos >= 1)) then
      set("SSG/EJET/LIGHTS/strobe_lights_sw", 0)
    end
  ]])
  --Taxi light
  set_button_assignment(btq.sw6_up,    "sim/none/none")
  set_button_assignment(btq.sw6_dn,    "sim/none/none")
  do_often([[
    TaxiPos = get("SSG/EJET/LIGHTS/taxi_nose_lights_sw")
    SwPos6 = button(]]..btq.sw6_up..[[)

    if ((SwPos6) and (TaxiPos ~= 1)) then
      set("SSG/EJET/LIGHTS/taxi_nose_lights_sw", 1)
    elseif (not(SwPos6) and (TaxiPos >= 1)) then
      set("SSG/EJET/LIGHTS/taxi_nose_lights_sw", 0)
    end
  ]])
  --Landing light
  set_button_assignment(btq.sw7_up,    "sim/none/none")
  set_button_assignment(btq.sw7_dn,    "sim/none/none")
  do_often([[
    Land1Pos = get("SSG/EJET/LIGHTS/land_left_lights_sw")
    SwPos7 = button(]]..btq.sw7_up..[[)
    
    if (SwPos7 and (Land1Pos ~= 1)) then
      set("SSG/EJET/LIGHTS/land_left_lights_sw", 1)
      elseif (not(SwPos7) and (Land1Pos >= 1)) then
      set("SSG/EJET/LIGHTS/land_left_lights_sw", 0)
    end

    if (SwPos7 and (Land1Pos ~= 1)) then
      set("SSG/EJET/LIGHTS/land_nose_lights_sw", 1)
      elseif (not(SwPos7) and (Land1Pos >= 1)) then
      set("SSG/EJET/LIGHTS/land_nose_lights_sw", 0)
    end

    if (SwPos7 and (Land1Pos ~= 1)) then
      set("SSG/EJET/LIGHTS/land_right_lights_sw", 1)
      elseif (not(SwPos7) and (Land1Pos >= 1)) then
      set("SSG/EJET/LIGHTS/land_right_lights_sw", 0)
    end
  ]])
end

function ChampBravoCheck_E195_SSG()
  if (--AP Panel rotary
      XPLMFindCommand("SSG/UFMC/Alt_UP")                         ~= nil and
      XPLMFindCommand("SSG/UFMC/Alt_Down")                       ~= nil and
      XPLMFindCommand("SSG/UFMC/VS_UP")                          ~= nil and
      XPLMFindCommand("SSG/UFMC/VS_Down")                        ~= nil and
      XPLMFindCommand("SSG/UFMC/HDG_UP")                         ~= nil and
      XPLMFindCommand("SSG/UFMC/HDG_Down")                       ~= nil and
      XPLMFindCommand("SSG/UFMC/Speed_UP")                       ~= nil and
      XPLMFindCommand("SSG/UFMC/Speed_Down")                     ~= nil and
      --AP Panel Buttons
      XPLMFindCommand("SSG/UFMC/AP_HDG_Button")                  ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_HDGHOLD_Button")              ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_LNAV_Button")                 ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_VNAV_Button")                 ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_APP_Button")                  ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_VORLOC_Button")               ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_discon_Button")               ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_VS_Button")                   ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_LVLCHG_Button")               ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_SPD_Button")                  ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_N1_Button")                   ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_CMDA_Button")                 ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_ARM_AT_Switch")               ~= nil and
      ----Axis
      XPLMFindCommand("SSG/UFMC/AT_Discon")                      ~= nil and
      XPLMFindCommand("SSG/UFMC/TOGA_Button")                    ~= nil and
      XPLMFindDataref("SSG/B748/speed_brk_hand")                 ~= nil and
      ----Switches
      XPLMFindDataRef("SSG/EJET/ANTICE/ice_eng1_fail")           ~= nil and
      XPLMFindDataRef("SSG/EJET/ANTICE/ice_eng2_fail")           ~= nil and
      XPLMFindDataRef("SSG/EJET/ANTICE/ice_eng1_sw")             ~= nil and
      XPLMFindDataRef("SSG/EJET/ANTICE/ice_eng2_sw")             ~= nil and
      XPLMFindDataRef("SSG/EJET/ANTICE/ice_wing_fail")           ~= nil and
      XPLMFindDataRef("SSG/EJET/ANTICE/ice_wing_sw")             ~= nil and
      XPLMFindDataRef("SSG/EJET/LIGHTS/strobe_lights_sw")        ~= nil and
      XPLMFindDataRef("SSG/EJET/LIGHTS/taxi_nose_lights_sw")     ~= nil and
      XPLMFindDataRef("SSG/EJET/LIGHTS/taxi_side_lights_sw")     ~= nil and
      XPLMFindDataRef("SSG/EJET/LIGHTS/land_left_lights_sw")     ~= nil and
      XPLMFindDataRef("SSG/EJET/LIGHTS/land_nose_lights_sw")     ~= nil and
      XPLMFindDataRef("SSG/EJET/LIGHTS/land_right_lights_sw")    ~= nil
     ) then return true
  else
    return false
  end
end
