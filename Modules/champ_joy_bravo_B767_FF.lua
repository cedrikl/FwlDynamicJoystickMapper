--Flight Factor B767 Pro Extended

function ChampBravoMapping_B767_FF()
  function bravo_Ap_AltInc(numticks) bravo_command_multiple("1-sim/comm/AP/altUP", numticks) end
  function bravo_Ap_AltDec(numticks) bravo_command_multiple("1-sim/comm/AP/altDN", numticks) end
  function bravo_Ap_VsInc(numticks)  bravo_command_multiple("1-sim/comm/AP/vviUP", numticks) end
  function bravo_Ap_VsDec(numticks)  bravo_command_multiple("1-sim/comm/AP/vviDN", numticks) end
  function bravo_Ap_HdgInc(numticks) bravo_command_multiple("1-sim/comm/AP/hdgUP", numticks) end
  function bravo_Ap_HdgDec(numticks) bravo_command_multiple("1-sim/comm/AP/hdgDN", numticks) end
  function bravo_Ap_CrsInc(numticks)
    bravo_command_multiple("1-sim/comm/vor1crsRotaryUP", numticks)
    bravo_command_multiple("1-sim/comm/ils/crsBigRotaryUP", numticks)
  end
  function bravo_Ap_CrsDec(numticks)
    bravo_command_multiple("1-sim/comm/vor1crsRotaryDN", numticks)
    bravo_command_multiple("1-sim/comm/ils/crsBigRotaryDN", numticks)
  end
  function bravo_Ap_IasInc(numticks) bravo_command_multiple("1-sim/comm/AP/spdUP", numticks) end
  function bravo_Ap_IasDec(numticks) bravo_command_multiple("1-sim/comm/AP/spdDN", numticks) end

  set_button_assignment(btq.ap_hdg, "sim/none/none")
  function apPanelCockpitHdgShort(status)
    if (status == "begin") then command_begin("1-sim/command/AP/hdgConfButton_button") elseif (status == "end") then command_end("1-sim/command/AP/hdgConfButton_button") end
  end
  function apPanelCockpitHdgLong(status)
    if (status == "begin") then command_begin("1-sim/command/AP/hdgHoldButton_button") elseif (status == "end") then command_end("1-sim/command/AP/hdgHoldButton_button") end
  end

  set_button_assignment(btq.ap_nav, "sim/none/none")
  function apPanelCockpitNavShort(status)
    if (status == "begin") then command_begin("1-sim/comm/AP/lnavButton") elseif (status == "end") then command_end("1-sim/comm/AP/lnavButton") end
  end
  function apPanelCockpitNavLong(status)
    if (status == "begin") then command_begin("1-sim/comm/AP/vnavButton") elseif (status == "end") then command_end("1-sim/comm/AP/vnavButton") end
  end

  set_button_assignment(btq.ap_apr, "sim/none/none")
  function apPanelCockpitAprShort(status)
    if (status == "begin") then command_begin("1-sim/comm/AP/appButton") elseif (status == "end") then command_end("1-sim/comm/AP/appButton") end
  end
  function apPanelCockpitAprLong(status)
    if (status == "begin") then command_begin("1-sim/comm/AP/locButton") elseif (status == "end") then command_end("1-sim/comm/AP/locButton") end
  end

  set_button_assignment(btq.ap_rev, "sim/none/none")

  set_button_assignment(btq.ap_alt, "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then command_begin("1-sim/comm/AP/flchButton") elseif (status == "end") then command_end("1-sim/comm/AP/flchButton") end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then command_begin("1-sim/command/AP/altHoldButton_button") elseif (status == "end") then command_end("1-sim/command/AP/altHoldButton_button") end
  end

  set_button_assignment(btq.ap_vs, "1-sim/comm/AP/vviButton")
  function apPanelCockpitVsShort(status) end
  function apPanelCockpitVsLong(status) end

  set_button_assignment(btq.ap_ias, "sim/none/none")
  function apPanelCockpitIasShort(status)
    if (status == "begin") then command_begin("1-sim/command/AP/spdButton_button") elseif (status == "end") then command_end("1-sim/command/AP/spdButton_button") end
  end
  function apPanelCockpitIasLong(status)
    if (status == "begin") then command_begin("1-sim/command/AP/eprButton_button") elseif (status == "end") then command_end("1-sim/command/AP/eprButton_button") end
  end

  set_button_assignment(btq.ap_master, "sim/none/none")
  function apPanelCockpitMasterShort(status)
    if (status == "begin") then command_begin("1-sim/comm/AP/CMD_L") elseif (status == "end") then command_end("1-sim/comm/AP/CMD_L") end
  end
  function apPanelCockpitMasterLong(status)
    if (status == "begin") then command_begin("1-sim/command/AP/atSwitcher_trigger") elseif (status == "end") then command_end("1-sim/command/AP/atSwitcher_trigger") end
  end

  do_every_frame("apPanelDualHandler()")

  set_button_assignment(btq.axis12_2nd_func, "1-sim/comm/AP/at_disc")
  set_button_assignment(btq.axis3_2nd_func, "1-sim/comm/AP/at_toga")

  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_often([[
      AcPos1 = get("anim/41/button")
      AcPos2 = get("anim/42/button")
      JoyPos = button(]]..btq.sw2_up..[[)
  
      if (JoyPos and (AcPos1 < 0.0001)) then
        set("anim/41/button", 1)
      elseif (not(JoyPos) and (AcPos1 > 0.9999)) then
        set("anim/41/button", 0)
      end
  
      if (JoyPos and (AcPos2 < 0.0001)) then
        set("anim/42/button", 1)
      elseif (not(JoyPos) and (AcPos2 > 0.9999)) then
        set("anim/42/button", 0)
      end
    ]])
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
  do_often([[
      AcPos = get("anim/40/button")
      JoyPos = button(]]..btq.sw3_up..[[)
  
      if (JoyPos and (AcPos < 0.0001)) then
        set("anim/40/button", 1)
      elseif (not(JoyPos) and (AcPos > 0.9999)) then
        set("anim/40/button", 0)
      end
    ]])
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_often([[
      AcPos = get("anim/45/button")
      JoyPos = button(]]..btq.sw5_up..[[)
  
      if (JoyPos and (AcPos < 0.0001)) then
        set("anim/45/button", 1)
      elseif (not(JoyPos) and (AcPos > 0.9999)) then
        set("anim/45/button", 0)
      end
    ]])
  set_button_assignment(btq.sw6_up, "sim/none/none")
  set_button_assignment(btq.sw6_dn, "sim/none/none")
  do_often([[
      C_Pos = get("1-sim/lights/taxi/switch")
      SwPos6 = button(]]..btq.sw6_up..[[)

      if (SwPos6 and (C_Pos ~= 1)) then
        command_once("1-sim/command/lights/taxi/switch_trigger")
      elseif (not(SwPos6) and (C_Pos ~= 0)) then
        command_once("1-sim/command/lights/taxi/switch_trigger")
      end
    ]])

  set_button_assignment(btq.sw7_up, "sim/none/none")
  set_button_assignment(btq.sw7_dn, "sim/none/none")
  do_often([[
      C_Pos = get("1-sim/lights/landingN/switch")
      L_Pos = get("1-sim/lights/landingL/switch")
      R_Pos = get("1-sim/lights/landingR/switch")
      SwPos7 = button(]]..btq.sw7_up..[[)

      if (SwPos7 and (C_Pos ~= 1)) then
        command_once("1-sim/command/lights/landingN/switch_trigger")
      elseif (not(SwPos7) and (C_Pos ~= 0)) then
        command_once("1-sim/command/lights/landingN/switch_trigger")
      end

      if (SwPos7 and (L_Pos ~= 1)) then
        command_once("1-sim/command/lights/landingL/switch_trigger")
      elseif (not(SwPos7) and (L_Pos ~= 0)) then
        command_once("1-sim/command/lights/landingL/switch_trigger")
      end

      if (SwPos7 and (R_Pos ~= 1)) then
        command_once("1-sim/command/lights/landingR/switch_trigger")
      elseif (not(SwPos7) and (R_Pos ~= 0)) then
        command_once("1-sim/command/lights/landingR/switch_trigger")
      end
    ]])
end


function ChampBravoLed_B767_FF()
  --btq_led.led_check(
  --  (
  --    (get("A300/MCDU/animations/lights/heading_sel") == 1)
  --  ), btq_led, 'A', btq_led.block_A_LED.HEADING)
  btq_led.led_check(
    (
      (get("1-sim/AP/lamp/3") > 0) or
      (get("1-sim/AP/lamp/4") > 0)
    ), btq_led, 'A', btq_led.block_A_LED.NAV)
  btq_led.led_check(
    (
      (get("1-sim/AP/lamp/10") > 0) or
      (get("1-sim/AP/lamp/11") > 0)
    ), btq_led, 'A', btq_led.block_A_LED.APR)
  btq_led.led_check(
    (
      (get("1-sim/AP/lamp/5") > 0) or
      (get("1-sim/AP/lamp/8") > 0)
    ), btq_led, 'A', btq_led.block_A_LED.ALT)
  btq_led.led_check(
    (
      (get("1-sim/AP/lamp/7") > 0)
    ), btq_led, 'A', btq_led.block_A_LED.VS)
  btq_led.led_check(
    (
      (get("1-sim/AP/lamp/1") > 0) or
      (get("1-sim/AP/lamp/2") > 0)
    ), btq_led, 'A', btq_led.block_A_LED.IAS)
  btq_led.led_check(
    (
      (get("1-sim/AP/lamp/12") > 0) or
      (get("1-sim/AP/lamp/13") > 0) or
      (get("1-sim/AP/lamp/14") > 0)
    ), btq_led, 'A', btq_led.block_A_LED.AP)
  btq_led.led_check(
    (
      (get("war/main/41") > 0)
    ), btq_led, 'B', btq_led.block_B_LED.MASTER_WARNING)
  btq_led.led_check(
    (
      (get("war/main/42") > 0)
    ), btq_led, 'C', btq_led.block_C_LED.MASTER_CAUTION)
  btq_led.led_check(
    (
      (get("1-sim/fireL/lamp") > 0) or
      (get("1-sim/fireR/lamp") > 0)
    ), btq_led, 'B', btq_led.block_B_LED.ENGINE_FIRE)
  --btq_led.led_check(
  --  (
  --    (get("A300/engine/engine1_oil_low_press_light") == 1) or
  --    (get("A300/engine/engine2_oil_low_press_light") == 1)
  --  ), btq_led, 'C', btq_led.block_C_LED.LOW_OIL_PRESS)
  btq_led.led_check(
    (
      (get("1-sim/hyd/pressC") < 2800) or
      (get("1-sim/hyd/pressL") < 2800) or
      (get("1-sim/hyd/pressR") < 2800)
    ), btq_led, 'C', btq_led.block_C_LED.LOW_HYD_PRESS)
  --btq_led.led_check(
  --  (
  --    (get("A300/FUEL/outer_tank_pump1_left_low_pressure")  == 1 ) or
  --    (get("A300/FUEL/outer_tank_pump2_left_low_pressure")  == 1 ) or
  --    (get("A300/FUEL/outer_tank_pump1_right_low_pressure") == 1 ) or
  --    (get("A300/FUEL/outer_tank_pump2_right_low_pressure") == 1 ) or
  --    (get("A300/FUEL/center_tank_pump1_low_pressure")      == 1 ) or
  --    (get("A300/FUEL/center_tank_pump2_low_pressure")      == 1 ) or
  --    (get("A300/FUEL/inner_tank_pump1_right_low_pressure") == 1 ) or
  --    (get("A300/FUEL/inner_tank_pump2_right_low_pressure") == 1 ) or
  --    (get("A300/FUEL/inner_tank_pump2_left_low_pressure")  == 1 ) or
  --    (get("A300/FUEL/inner_tank_pump1_left_low_pressure")  == 1 ) or
  --    (get("A300/FUEL/trim_tank_pump2_low_pressure")        == 1 ) or
  --    (get("A300/FUEL/trim_tank_pump1_low_pressure")        == 1 )
  --  ), btq_led, 'C', btq_led.block_C_LED.LOW_FUEL_PRESS)
  btq_led.led_check(
    (
      (get("anim/41/button") == 1) or
      (get("anim/42/button") == 1) or
      (get("anim/40/button") == 1)
    ), btq_led, 'C', btq_led.block_C_LED.ANTI_ICE)
  
  btq_led.led_check(
    (
      (get("anim/rhotery/9") == 0) or
      (get("anim/rhotery/8") == 0)
    ), btq_led, 'C', btq_led.block_C_LED.STARTER)
  --btq_led.led_check(
  --  (
  --    (get("A300/APU/master_switch_button") == 1) or
  --    (get("A300/APU/n1") > 5.0)
  --  ), btq_led, 'C', btq_led.block_C_LED.APU)
  btq_led.led_check(
    (
      (get("1-sim/anim/doors/BL/anim")          > 0.05) or
      (get("1-sim/anim/doors/BR/anim")          > 0.05) or
      (get("1-sim/anim/doors/FL/anim")          > 0.05) or
      (get("1-sim/anim/doors/FR/anim")          > 0.05) or
      (get("1-sim/anim/doors/cargoFront1/anim") > 0.05) or
      (get("1-sim/anim/doors/cargoBack/anim")   > 0.05)
    ), btq_led, 'D', btq_led.block_D_LED.DOOR)

  --if (
  --    (get("A300/elec/battery_on")      == 0) and
  --    (get("A300/elec/dc_norm_bus_off") == 1) and
  --    (get("A300/elec/ac_bus1_off")     == 1) and
  --    (get("A300/elec/ac_bus2_off")     == 1)
  --   ) then setAllToOff()
  --end
end


function ChampBravoCheck_B767_FF()
  if (--XPLMFindDataRef("A300/elec/battery_on")                         ~= nil and
      --XPLMFindDataRef("A300/elec/dc_norm_bus_off")                    ~= nil and

      --AP Panel
      XPLMFindCommand("1-sim/comm/AP/altUP")                          ~= nil and
      XPLMFindCommand("1-sim/comm/AP/altDN")                          ~= nil and
      XPLMFindCommand("1-sim/comm/AP/vviUP")                          ~= nil and
      XPLMFindCommand("1-sim/comm/AP/vviDN")                          ~= nil and
      XPLMFindCommand("1-sim/comm/AP/hdgUP")                          ~= nil and
      XPLMFindCommand("1-sim/comm/AP/hdgDN")                          ~= nil and
      XPLMFindCommand("1-sim/comm/vor1crsRotaryUP")                   ~= nil and
      XPLMFindCommand("1-sim/comm/vor1crsRotaryDN")                   ~= nil and
      XPLMFindCommand("1-sim/comm/ils/crsBigRotaryUP")                ~= nil and
      XPLMFindCommand("1-sim/comm/ils/crsBigRotaryDN")                ~= nil and
      XPLMFindCommand("1-sim/comm/AP/spdUP")                          ~= nil and
      XPLMFindCommand("1-sim/comm/AP/spdDN")                          ~= nil and

      XPLMFindCommand("1-sim/command/AP/hdgConfButton_button")        ~= nil and
      XPLMFindCommand("1-sim/command/AP/hdgHoldButton_button")        ~= nil and
      XPLMFindCommand("1-sim/comm/AP/lnavButton")                     ~= nil and
      XPLMFindCommand("1-sim/comm/AP/vnavButton")                     ~= nil and
      XPLMFindCommand("1-sim/comm/AP/locButton")                      ~= nil and
      XPLMFindCommand("1-sim/comm/AP/appButton")                      ~= nil and
      XPLMFindCommand("1-sim/comm/AP/flchButton")                     ~= nil and
      XPLMFindCommand("1-sim/command/AP/altHoldButton_button")        ~= nil and
      XPLMFindCommand("1-sim/comm/AP/vviButton")                      ~= nil and
      XPLMFindCommand("1-sim/command/AP/spdButton_button")            ~= nil and
      XPLMFindCommand("1-sim/command/AP/eprButton_button")            ~= nil and
      XPLMFindCommand("1-sim/comm/AP/CMD_L")                          ~= nil and
      XPLMFindCommand("1-sim/command/AP/atSwitcher_trigger")          ~= nil and

      --Axis
      XPLMFindCommand("1-sim/comm/AP/at_toga")                        ~= nil and
      XPLMFindCommand("1-sim/comm/AP/at_disc")                        ~= nil and

      --Switches
      XPLMFindDataRef("anim/41/button")                               ~= nil and
      XPLMFindDataRef("anim/42/button")                               ~= nil and
      XPLMFindDataRef("anim/40/button")                               ~= nil and
      XPLMFindDataRef("anim/45/button")                               ~= nil and
      XPLMFindDataRef("1-sim/lights/taxi/switch")                     ~= nil and
      XPLMFindCommand("1-sim/command/lights/taxi/switch_trigger")     ~= nil and
      XPLMFindDataRef("1-sim/lights/landingL/switch")                 ~= nil and
      XPLMFindDataRef("1-sim/lights/landingN/switch")                 ~= nil and
      XPLMFindDataRef("1-sim/lights/landingR/switch")                 ~= nil and
      XPLMFindCommand("1-sim/command/lights/landingL/switch_trigger") ~= nil and
      XPLMFindCommand("1-sim/command/lights/landingN/switch_trigger") ~= nil and
      XPLMFindCommand("1-sim/command/lights/landingR/switch_trigger") ~= nil and

      --LEDs
      XPLMFindDataRef("1-sim/AP/lamp/3")                              ~= nil and
      XPLMFindDataRef("1-sim/AP/lamp/4")                              ~= nil and
      XPLMFindDataRef("1-sim/AP/lamp/10")                             ~= nil and
      XPLMFindDataRef("1-sim/AP/lamp/11")                             ~= nil and
      XPLMFindDataRef("1-sim/AP/lamp/5")                              ~= nil and
      XPLMFindDataRef("1-sim/AP/lamp/8")                              ~= nil and
      XPLMFindDataRef("1-sim/AP/lamp/7")                              ~= nil and
      XPLMFindDataRef("1-sim/AP/lamp/1")                              ~= nil and
      XPLMFindDataRef("1-sim/AP/lamp/2")                              ~= nil and
      XPLMFindDataRef("1-sim/AP/lamp/12")                             ~= nil and
      XPLMFindDataRef("1-sim/AP/lamp/13")                             ~= nil and
      XPLMFindDataRef("1-sim/AP/lamp/14")                             ~= nil and

      XPLMFindDataRef("war/main/41")                                  ~= nil and
      XPLMFindDataRef("war/main/42")                                  ~= nil and
      XPLMFindDataRef("1-sim/fireL/lamp")                             ~= nil and
      XPLMFindDataRef("1-sim/fireR/lamp")                             ~= nil and
      XPLMFindDataRef("1-sim/hyd/pressC")                             ~= nil and
      XPLMFindDataRef("1-sim/hyd/pressL")                             ~= nil and
      XPLMFindDataRef("1-sim/hyd/pressR")                             ~= nil and
      XPLMFindDataRef("anim/rhotery/9")                               ~= nil and
      XPLMFindDataRef("anim/rhotery/8")                               ~= nil and
      --XPLMFindDataRef("A300/APU/master_switch_button")              ~= nil and
      --XPLMFindDataRef("A300/APU/n1")                                ~= nil and
      XPLMFindDataRef("1-sim/anim/doors/BL/anim")                     ~= nil and
      XPLMFindDataRef("1-sim/anim/doors/BR/anim")                     ~= nil and
      XPLMFindDataRef("1-sim/anim/doors/FL/anim")                     ~= nil and
      XPLMFindDataRef("1-sim/anim/doors/FR/anim")                     ~= nil and
      XPLMFindDataRef("1-sim/anim/doors/cargoFront1/anim")            ~= nil and
      XPLMFindDataRef("1-sim/anim/doors/cargoBack/anim")              ~= nil
     ) then return true
  else
    return false
  end
end
