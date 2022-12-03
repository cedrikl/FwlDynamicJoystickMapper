function ChampBravoEngine_A321_toliss()
  do_every_frame([[
    if (button(]]..btq.axis2_rev_handle..[[)            and (get("AirbusFBW/throttle_input", 0) > -0.1) and (get("toliss_airbus/joystick/throttle/rawLeverPos", 0) < 0.05)) then
      command_once("sim/engines/thrust_reverse_toggle_1")
    elseif ((not(button(]]..btq.axis2_rev_handle..[[))) and (get("AirbusFBW/throttle_input", 0) <= -0.1) and (get("toliss_airbus/joystick/throttle/rawLeverPos", 0) < 0.05)) then
      command_once("sim/engines/thrust_reverse_toggle_1")
    end

    if (button(]]..btq.axis3_rev_handle..[[)            and (get("AirbusFBW/throttle_input", 1) > -0.1) and (get("toliss_airbus/joystick/throttle/rawLeverPos", 1) < 0.05)) then
      command_once("sim/engines/thrust_reverse_toggle_2")
    elseif ((not(button(]]..btq.axis3_rev_handle..[[))) and (get("AirbusFBW/throttle_input", 1) <= -0.1) and (get("toliss_airbus/joystick/throttle/rawLeverPos", 1) < 0.05)) then
      command_once("sim/engines/thrust_reverse_toggle_2")
    end
  ]])
end

function ChampBravoMapping_A321_toliss()
  function bravo_Ap_VsInc(numticks) set("AirbusFBW/FCUVSKnobRotation", get("AirbusFBW/FCUVSKnobRotation") + 1) end
  function bravo_Ap_VsDec(numticks) set("AirbusFBW/FCUVSKnobRotation", get("AirbusFBW/FCUVSKnobRotation") - 1) end

  set_button_assignment(btq.ap_hdg, "sim/none/none")
  function apPanelCockpitHdgShort(status)
    if (status == "begin") then command_begin("AirbusFBW/PushHDGSel") elseif (status == "end") then command_end("AirbusFBW/PushHDGSel") end
  end
  function apPanelCockpitHdgLong(status)
    if (status == "begin") then command_begin("AirbusFBW/PullHDGSel") elseif (status == "end") then command_end("AirbusFBW/PullHDGSel") end
  end

  set_button_assignment(btq.ap_nav,    "sim/none/none")
  function apPanelCockpitNavShort(status) end
  function apPanelCockpitNavLong(status)  end

  set_button_assignment(btq.ap_apr,    "sim/none/none")
  function apPanelCockpitAprShort(status) 
    if (status == "begin") then command_begin("AirbusFBW/APPRbutton") elseif (status == "end") then command_end("AirbusFBW/APPRbutton") end
  end
  function apPanelCockpitAprLong(status) 
    if (status == "begin") then command_begin("AirbusFBW/LOCbutton") elseif (status == "end") then command_end("AirbusFBW/LOCbutton") end
  end

  set_button_assignment(btq.ap_rev,    "sim/none/none")
  function apPanelCockpitRevShort(status) end
  function apPanelCockpitRevLong(status)  end

  set_button_assignment(btq.ap_alt,    "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then command_begin("AirbusFBW/PushAltitude") elseif (status == "end") then command_end("AirbusFBW/PushAltitude") end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then command_begin("AirbusFBW/PullAltitude") elseif (status == "end") then command_end("AirbusFBW/PullAltitude") end
  end

  set_button_assignment(btq.ap_vs,     "sim/none/none")
  function apPanelCockpitVsShort(status)
    if (status == "begin") then command_begin("AirbusFBW/PushVSSel") elseif (status == "end") then command_end("AirbusFBW/PushVSSel") end
  end
  function apPanelCockpitVsLong(status)
    if (status == "begin") then command_begin("AirbusFBW/PullVSSel") elseif (status == "end") then command_end("AirbusFBW/PullVSSel") end
  end

  set_button_assignment(btq.ap_ias,    "sim/none/none")
  function apPanelCockpitIasShort(status)
    if (status == "begin") then command_begin("AirbusFBW/PushSPDSel") elseif (status == "end") then command_end("AirbusFBW/PushSPDSel") end
  end
  function apPanelCockpitIasLong(status)
    if (status == "begin") then command_begin("AirbusFBW/PullSPDSel") elseif (status == "end") then command_end("AirbusFBW/PullSPDSel") end
  end

  set_button_assignment(btq.ap_master, "sim/none/none")
  function apPanelCockpitMasterShort(status)
    if (status == "begin") then command_begin("toliss_airbus/ap1_push") elseif (status == "end") then command_end("toliss_airbus/ap1_push") end
  end
  function apPanelCockpitMasterLong(status)
    if (status == "begin") then command_begin("AirbusFBW/ATHRbutton") elseif (status == "end") then command_end("AirbusFBW/ATHRbutton") end
  end

  do_every_frame("apPanelDualHandler()")

  set_button_assignment(btq.axis12_2nd_func, "sim/none/none")
  set_button_assignment(btq.axis3_2nd_func, "sim/none/none")

  set_button_assignment(btq.sw1_up, "sim/none/none")
  set_button_assignment(btq.sw1_dn, "sim/none/none")
  do_often([[
    ParkPos = get("AirbusFBW/ParkBrakeAnim")
    SwPos = button(]]..btq.sw1_up..[[)

    if (SwPos and (ParkPos < 0.0001)) then
      command_once("toliss_airbus/park_brake_set")
    elseif (not(SwPos) and (ParkPos > 0.9999)) then
      command_once("toliss_airbus/park_brake_release")
    end
  ]])
  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_often([[
    AcPos1 = get("ckpt/lamp/119")
    AcPos2 = get("ckpt/lamp/121")
    JoyPos = button(]]..btq.sw2_up..[[)
  
  
    if (JoyPos and (AcPos1 < 0.1)) then
      command_once("toliss_airbus/antiicecommands/ENG1On")
    elseif (not(JoyPos) and (AcPos1 > 0.9)) then
      command_once("toliss_airbus/antiicecommands/ENG1Off")
    end
  
    if (JoyPos and (AcPos2 < 0.1)) then
      command_once("toliss_airbus/antiicecommands/ENG2On")
    elseif (not(JoyPos) and (AcPos2 > 0.9)) then
      command_once("toliss_airbus/antiicecommands/ENG2Off")
    end
  ]])
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
  do_often([[
    AcPos1 = get("ckpt/lamp/117")
    JoyPos = button(]]..btq.sw3_up..[[)
  
  
    if (JoyPos and (AcPos1 < 0.1)) then
      command_once("toliss_airbus/antiicecommands/WingOn")
    elseif (not(JoyPos) and (AcPos1 > 0.9)) then
      command_once("toliss_airbus/antiicecommands/WingOff")
    end
  ]])


  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_often([[
      AcPos1 = get("ckpt/oh/strobeLight/anim")
      JoyPos = button(]]..btq.sw5_up..[[)
  
  
      if (JoyPos and (AcPos1 < 1.0001)) then
        command_once("toliss_airbus/lightcommands/StrobeLightUp")
      elseif (not(JoyPos) and (AcPos1 > 1.9999)) then
        command_once("toliss_airbus/lightcommands/StrobeLightDown")
      end
    ]])
  set_button_assignment(btq.sw6_up,    "sim/none/none")
  set_button_assignment(btq.sw6_dn,    "sim/none/none")
  set_button_assignment(btq.sw7_up,    "sim/none/none")
  set_button_assignment(btq.sw7_dn,    "sim/none/none")
  do_often([[
    L_Pos = get("ckpt/oh/ladningLightLeft/anim")
    C_Pos = get("ckpt/oh/taxiLight/anim")
    R_Pos = get("ckpt/oh/ladningLightRight/anim")
    SwPos6 = button(]]..btq.sw6_up..[[)
    SwPos7 = button(]]..btq.sw7_up..[[)
    
    if (SwPos7 and (L_Pos ~= 2)) then
      command_once("toliss_airbus/lightcommands/LLandLightUp")
    elseif (not(SwPos7) and (L_Pos ~= 0)) then
      command_once("toliss_airbus/lightcommands/LLandLightDown")
    end

    if (SwPos7 and (R_Pos ~= 2)) then
      command_once("toliss_airbus/lightcommands/RLandLightUp")
    elseif (not(SwPos7) and (R_Pos ~= 0)) then
      command_once("toliss_airbus/lightcommands/RLandLightDown")
    end

    if (SwPos7 and (C_Pos ~= 2)) then
      command_once("toliss_airbus/lightcommands/NoseLightUp")
    elseif (SwPos6 and not(SwPos7) and (C_Pos < 1)) then
      command_once("toliss_airbus/lightcommands/NoseLightUp")
    elseif (SwPos6 and not(SwPos7) and (C_Pos > 1)) then
      command_once("toliss_airbus/lightcommands/NoseLightDown")
    elseif (not(SwPos6) and not(SwPos7) and (C_Pos ~= 0)) then
      command_once("toliss_airbus/lightcommands/NoseLightDown")
    end
  ]])
end


function ChampBravoLed_A321_toliss()
  btq_led.led_check((get("AirbusFBW/APLateralMode") == 101), btq_led, 'A', btq_led.block_A_LED.HEADING)
  btq_led.led_check((get("AirbusFBW/APLateralMode") == 2),   btq_led, 'A', btq_led.block_A_LED.NAV)
  btq_led.led_check(
    (
      (get("AirbusFBW/LOCilluminated") == 1) or
      (get("AirbusFBW/APPRilluminated") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.APR)
  btq_led.led_check(
    (
      (get("AirbusFBW/APVerticalMode") == 2) or
      (get("AirbusFBW/APVerticalMode") == 101) or
      (get("AirbusFBW/APVerticalMode") == 102)
    ), btq_led, 'A', btq_led.block_A_LED.ALT)

  btq_led.led_check((get("AirbusFBW/APVerticalMode") == 107), btq_led, 'A', btq_led.block_A_LED.VS)
  btq_led.led_check(
    (
      (get("AirbusFBW/AP1Engage") == 1) or
      (get("AirbusFBW/AP2Engage") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.AP)

  btq_led.led_check((get("AirbusFBW/MasterWarn") == 1), btq_led, 'B', btq_led.block_B_LED.MASTER_WARNING)
  btq_led.led_check((get("AirbusFBW/MasterCaut") == 1), btq_led, 'C', btq_led.block_C_LED.MASTER_CAUTION)
  btq_led.led_check(
    (
      (get("ckpt/lamp/303") > 0.1) or
      (get("ckpt/lamp/311") > 0.1) or
      (get("AirbusFBW/APUOnFire") > 0.1) or
      (get("ckpt/lamp/304") > 0.1) or
      (get("ckpt/lamp/313") > 0.1)
    ), btq_led, 'B', btq_led.block_B_LED.ENGINE_FIRE)
  btq_led.led_check(
    (
      (get("AirbusFBW/ENGOilPressArray", 0) < 0.246) or
      (get("AirbusFBW/ENGOilPressArray", 1) < 0.246)
    ), btq_led, 'C', btq_led.block_C_LED.LOW_OIL_PRESS)
  btq_led.led_check(
    (
      (get("AirbusFBW/HydSysPressArray", 0) < 1450.0) or
      (get("AirbusFBW/HydSysPressArray", 1) < 1450.0) or
      (get("AirbusFBW/HydSysPressArray", 2) < 1450.0)
    ), btq_led, 'C', btq_led.block_C_LED.LOW_HYD_PRESS)
  btq_led.led_check(
    (
      (get("AirbusFBW/WAISwitch") == 1)    or
      (get("AirbusFBW/ENG1AISwitch") == 1) or
      (get("AirbusFBW/ENG2AISwitch") == 1)
    ), btq_led, 'C', btq_led.block_C_LED.ANTI_ICE)
  btq_led.led_check((get("AirbusFBW/ParkBrake") == 1), btq_led, 'D', btq_led.block_D_LED.PARKING_BRAKE)
  btq_led.led_check(
    (
      (get("AirbusFBW/APUStarter")         == 1)  or
      (get("AirbusFBW/StartValveArray", 0) == 1)  or
      (get("AirbusFBW/StartValveArray", 1) == 1)  or
      (get("AirbusFBW/StartValveArray", 2) == 1)  or
      (get("AirbusFBW/StartValveArray", 3) == 1)  or
      (get("AirbusFBW/ENGModeSwitch")      < 0.1) or
      (get("AirbusFBW/ENGModeSwitch")      > 1.9)
    ), btq_led, 'C', btq_led.block_C_LED.STARTER)
  btq_led.led_check(
    (
      (get("AirbusFBW/BatVolts", 0) < 25.0) or
      (get("AirbusFBW/BatVolts", 1) < 25.0)
    ), btq_led, 'D', btq_led.block_D_LED.LOW_VOLTS)
  btq_led.led_check(
    (
      (get("AirbusFBW/APUMaster") == 1)
    ), btq_led, 'C', btq_led.block_C_LED.APU)
  btq_led.led_check(
    (
      (get("AirbusFBW/CargoDoorArray", 0) > 0.1) or
      (get("AirbusFBW/CargoDoorArray", 1) > 0.1) or
      (get("AirbusFBW/CargoDoorArray", 2) > 0.1) or
      (get("AirbusFBW/CargoDoorArray", 3) > 0.1) or
      (get("AirbusFBW/PaxDoorArray",   0) > 0.1) or
      (get("AirbusFBW/PaxDoorArray",   1) > 0.1) or
      (get("AirbusFBW/PaxDoorArray",   2) > 0.1) or
      (get("AirbusFBW/PaxDoorArray",   3) > 0.1) or
      (get("AirbusFBW/PaxDoorArray",   4) > 0.1) or
      (get("AirbusFBW/PaxDoorArray",   5) > 0.1) or
      (get("AirbusFBW/PaxDoorArray",   6) > 0.1) or
      (get("AirbusFBW/PaxDoorArray",   7) > 0.1)
    ), btq_led, 'D', btq_led.block_D_LED.DOOR)
  if (
      ((get("AirbusFBW/ElecOHPArray", 5) == 0) or
       (get("AirbusFBW/ElecOHPArray", 6) == 0)
      ) and
      (get("AirbusFBW/ElecOHPArray", 3) == 0)
     ) then setAllToOff()
  end
end


function ChampBravoCheck_A321_toliss()
  if (--AP Panel
      XPLMFindDataRef("AirbusFBW/FCUVSKnobRotation")                     ~= nil and
      XPLMFindCommand("AirbusFBW/PushHDGSel")                            ~= nil and
      XPLMFindCommand("AirbusFBW/PullHDGSel")                            ~= nil and
      XPLMFindCommand("AirbusFBW/APPRbutton")                            ~= nil and
      XPLMFindCommand("AirbusFBW/LOCbutton")                             ~= nil and
      XPLMFindCommand("AirbusFBW/PushAltitude")                          ~= nil and
      XPLMFindCommand("AirbusFBW/PullAltitude")                          ~= nil and
      XPLMFindCommand("AirbusFBW/PushVSSel")                             ~= nil and
      XPLMFindCommand("AirbusFBW/PullVSSel")                             ~= nil and
      XPLMFindCommand("AirbusFBW/PushSPDSel")                            ~= nil and
      XPLMFindCommand("AirbusFBW/PullSPDSel")                            ~= nil and
      XPLMFindCommand("toliss_airbus/ap1_push")                          ~= nil and
      XPLMFindCommand("AirbusFBW/ATHRbutton")                            ~= nil and
      --Axis
      XPLMFindDataRef("toliss_airbus/joystick/throttle/rawLeverPos")     ~= nil and
      XPLMFindDataRef("AirbusFBW/throttle_input")                        ~= nil and
      
      --Switches
      XPLMFindDataRef("AirbusFBW/ParkBrakeAnim")                         ~= nil and
      XPLMFindCommand("toliss_airbus/park_brake_set")                    ~= nil and
      XPLMFindCommand("toliss_airbus/park_brake_release")                ~= nil and
      XPLMFindDataRef("ckpt/lamp/119")                                   ~= nil and
      XPLMFindCommand("toliss_airbus/antiicecommands/ENG1On")            ~= nil and
      XPLMFindCommand("toliss_airbus/antiicecommands/ENG1Off")           ~= nil and
      XPLMFindDataRef("ckpt/lamp/121")                                   ~= nil and
      XPLMFindCommand("toliss_airbus/antiicecommands/ENG2On")            ~= nil and
      XPLMFindCommand("toliss_airbus/antiicecommands/ENG2Off")           ~= nil and
      XPLMFindDataRef("ckpt/lamp/117")                                   ~= nil and
      XPLMFindCommand("toliss_airbus/antiicecommands/WingOn")            ~= nil and
      XPLMFindCommand("toliss_airbus/antiicecommands/WingOff")           ~= nil and
      XPLMFindDataRef("ckpt/oh/strobeLight/anim")                        ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/StrobeLightUp")       ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/StrobeLightDown")     ~= nil and
      XPLMFindDataRef("ckpt/oh/ladningLightLeft/anim")                   ~= nil and
      XPLMFindDataRef("ckpt/oh/ladningLightRight/anim")                  ~= nil and
      XPLMFindDataRef("ckpt/oh/taxiLight/anim")                          ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/LLandLightUp")        ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/LLandLightDown")      ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/RLandLightUp")        ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/RLandLightDown")      ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/NoseLightUp")         ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/NoseLightDown")       ~= nil and
      --LEDs
      XPLMFindDataRef("AirbusFBW/APLateralMode")                         ~= nil and
      XPLMFindDataRef("AirbusFBW/APVerticalMode")                        ~= nil and
      XPLMFindDataRef("AirbusFBW/LOCilluminated")                        ~= nil and
      XPLMFindDataRef("AirbusFBW/APPRilluminated")                       ~= nil and
      XPLMFindDataRef("AirbusFBW/AP1Engage")                             ~= nil and
      XPLMFindDataRef("AirbusFBW/AP2Engage")                             ~= nil and

      XPLMFindDataRef("AirbusFBW/MasterWarn")                            ~= nil and
      XPLMFindDataRef("AirbusFBW/MasterCaut")                            ~= nil and
      XPLMFindDataRef("ckpt/lamp/303")                                   ~= nil and
      XPLMFindDataRef("ckpt/lamp/311")                                   ~= nil and
      XPLMFindDataRef("AirbusFBW/APUOnFire")                             ~= nil and
      XPLMFindDataRef("ckpt/lamp/304")                                   ~= nil and
      XPLMFindDataRef("ckpt/lamp/313")                                   ~= nil and
      XPLMFindDataRef("AirbusFBW/ENGOilPressArray")                      ~= nil and
      XPLMFindDataRef("AirbusFBW/HydSysPressArray")                      ~= nil and
      XPLMFindDataRef("AirbusFBW/WAISwitch")                             ~= nil and
      XPLMFindDataRef("AirbusFBW/ENG1AISwitch")                          ~= nil and
      XPLMFindDataRef("AirbusFBW/ENG2AISwitch")                          ~= nil and
      XPLMFindDataRef("AirbusFBW/StartValveArray")                       ~= nil and
      XPLMFindDataRef("AirbusFBW/ENGModeSwitch")                         ~= nil and
      XPLMFindDataRef("AirbusFBW/BatVolts")                              ~= nil and
      XPLMFindDataRef("AirbusFBW/APUMaster")                             ~= nil and
      XPLMFindDataRef("AirbusFBW/PaxDoorArray")                          ~= nil and
      XPLMFindDataRef("AirbusFBW/CargoDoorArray")                        ~= nil and
      XPLMFindDataRef("AirbusFBW/ElecOHPArray")                          ~= nil
     ) then return true
  else
    return false
  end
end
