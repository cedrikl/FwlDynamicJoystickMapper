--iniBuilds A300-600R v2 & A310-300

function ChampBravoMapping_A310_ini()
  function bravo_Ap_AltInc(numticks) bravo_command_multiple("A300/MCDU/altitude_up", numticks) end
  function bravo_Ap_AltDec(numticks) bravo_command_multiple("A300/MCDU/altitude_down", numticks) end
  function bravo_Ap_VsInc(numticks)  bravo_command_multiple("A300/MCDU/vvi_up", numticks) end
  function bravo_Ap_VsDec(numticks)  bravo_command_multiple("A300/MCDU/vvi_down", numticks) end
  function bravo_Ap_HdgInc(numticks) bravo_command_multiple("A300/MCDU/heading_up", numticks) end
  function bravo_Ap_HdgDec(numticks) bravo_command_multiple("A300/MCDU/heading_down", numticks) end
  function bravo_Ap_CrsInc(numticks) bravo_command_multiple("A300/radios/ILS/course/dial_up", numticks) end
  function bravo_Ap_CrsDec(numticks) bravo_command_multiple("A300/radios/ILS/course/dial_down", numticks) end
  function bravo_Ap_IasInc(numticks) bravo_command_multiple("A300/MCDU/airspeed_up", numticks) end
  function bravo_Ap_IasDec(numticks) bravo_command_multiple("A300/MCDU/airspeed_down", numticks) end

  set_button_assignment(btq.ap_hdg, "A300/MCDU/heading_pull")
  function apPanelCockpitHdgShort(status) end
  function apPanelCockpitHdgLong(status) end

  set_button_assignment(btq.ap_nav, "sim/none/none")
  function apPanelCockpitNavShort(status)
    if (status == "begin") then command_begin("A300/MCDU/nav_mode") elseif (status == "end") then command_end("A300/MCDU/nav_mode") end
  end
  function apPanelCockpitNavLong(status)
    if (status == "begin") then command_begin("A300/MCDU/profile_mode") elseif (status == "end") then command_end("A300/MCDU/profile_mode") end
  end

  set_button_assignment(btq.ap_apr, "sim/none/none")
  function apPanelCockpitAprShort(status)
    if (status == "begin") then command_begin("A300/MCDU/approach_mode") elseif (status == "end") then command_end("A300/MCDU/approach_mode") end
  end
  function apPanelCockpitAprLong(status)
    if (status == "begin") then command_begin("A300/MCDU/loc_toggle") elseif (status == "end") then command_end("A300/MCDU/loc_toggle") end
  end

  set_button_assignment(btq.ap_rev, "sim/none/none")

  set_button_assignment(btq.ap_alt, "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then command_begin("A300/MCDU/level_change") elseif (status == "end") then command_end("A300/MCDU/level_change") end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then command_begin("A300/MCUD/altitude_hold_engage") elseif (status == "end") then command_end("A300/MCUD/altitude_hold_engage") end --typo MCUD instead of MCDU
  end

  set_button_assignment(btq.ap_vs, "A300/MCDU/vvi_engage")
  function apPanelCockpitVsShort(status) end
  function apPanelCockpitVsLong(status) end

  set_button_assignment(btq.ap_ias, "A300/MCDU/autothrottle_toggle")
  function apPanelCockpitIasShort(status) end
  function apPanelCockpitIasLong(status) end

  set_button_assignment(btq.ap_master, "sim/none/none")
  function apPanelCockpitMasterShort(status)
    if (status == "begin") then command_begin("A300/MCDU/ap1_engage") elseif (status == "end") then command_end("A300/MCDU/ap1_engage") end
  end
  function apPanelCockpitMasterLong(status)
    if (status == "begin") then command_begin("A300/MCDU/autothrottle_toggle") elseif (status == "end") then command_end("A300/MCDU/autothrottle_toggle") end
  end

  do_every_frame("apPanelDualHandler()")

  set_button_assignment(btq.axis12_2nd_func, "A300/MCDU/disconnect_at")
  set_button_assignment(btq.axis3_2nd_func, "A300/MCDU/takeoff_goaround_trigger")

  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_every_frame([[
      AcPos1 = get("A300/animations/buttons/ANTI_ICE_E1")
      AcPos2 = get("A300/animations/buttons/ANTI_ICE_E2")
      JoyPos = button(]]..btq.sw2_up..[[)

      if (JoyPos and (AcPos1 < 0.0001)) then
        command_once("A300/ICE/eng1_toggle")
      elseif (not(JoyPos) and (AcPos1 > 0.5434)) then
        command_once("A300/ICE/eng1_toggle")
      end
  
      if (JoyPos and (AcPos2 < 0.0001)) then
        command_once("A300/ICE/eng2_toggle")
      elseif (not(JoyPos) and (AcPos2 > 0.5434)) then
        command_once("A300/ICE/eng2_toggle")
      end
    ]])
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
  do_every_frame([[
      AcPos1 = get("A300/animations/buttons/WING_SUPPLY")
      JoyPos = button(]]..btq.sw3_up..[[)
  
      if (JoyPos and (AcPos1 < 0.0001)) then
        command_once("A300/ICE/wing_supply_toggle")
      elseif (not(JoyPos) and (AcPos1 > 0.9999)) then
        command_once("A300/ICE/wing_supply_toggle")
      end
    ]])
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_often([[
      AcPos1 = get("A300/switches/animations_current", 3)
      JoyPos = button(]]..btq.sw5_up..[[)
  
      if (JoyPos and (AcPos1 < 0.0001)) then
        command_once("A300/LIGHTS/strobe_light_up")
        command_once("A300/LIGHTS/strobe_light_up")
      elseif (not(JoyPos) and (AcPos1 > 1.9999)) then
        command_once("A300/LIGHTS/strobe_light_down")
        command_once("A300/LIGHTS/strobe_light_down")
      end
    ]])
  set_button_assignment(btq.sw6_up, "sim/none/none")
  set_button_assignment(btq.sw6_dn, "sim/none/none")
  set_button_assignment(btq.sw7_up, "sim/none/none")
  set_button_assignment(btq.sw7_dn, "sim/none/none")
  do_often([[
      C_Pos = get("A300/switches/animations_current", 0)
      L_Pos = get("A300/switches/animations_current", 7)
      R_Pos = get("A300/switches/animations_current", 8)
      SwPos6 = button(]]..btq.sw6_up..[[)
      SwPos7 = button(]]..btq.sw7_up..[[)

      CinGateDn  = C_Pos < 0.0001
      CinGateMid = (C_Pos > 0.9999) and (C_Pos < 1.0001)
      CinGateUp  = C_Pos > 1.9999

      if (SwPos7 and not(CinGateUp)) then
        command_once("A300/LIGHTS/nose_light_up")
        command_once("A300/LIGHTS/nose_light_up")
      elseif (SwPos6 and not(SwPos7) and not(CinGateMid)) then
        if (CinGateDn) then
          command_once("A300/LIGHTS/nose_light_up")
        elseif (CinGateUp) then
          command_once("A300/LIGHTS/nose_light_down")
        end
      elseif (not(SwPos6) and not(SwPos7) and not(CinGateDn)) then
        command_once("A300/LIGHTS/nose_light_down")
        command_once("A300/LIGHTS/nose_light_down")
      end

      LinGateDn  = L_Pos < 0.0001
      LinGateUp  = L_Pos > 1.9999
      RinGateDn  = R_Pos < 0.0001
      RinGateUp  = R_Pos > 1.9999

      if (SwPos7 and not(LinGateUp)) then
        command_once("A300/LIGHTS/landing_light1_up")
        command_once("A300/LIGHTS/landing_light1_up")
      elseif (not(SwPos7) and not(LinGateDn)) then
        command_once("A300/LIGHTS/landing_light1_down")
        command_once("A300/LIGHTS/landing_light1_down")
      end

      if (SwPos7 and not(RinGateUp)) then
        command_once("A300/LIGHTS/landing_light2_up")
        command_once("A300/LIGHTS/landing_light2_up")
      elseif (not(SwPos7) and not(RinGateDn)) then
        command_once("A300/LIGHTS/landing_light2_down")
        command_once("A300/LIGHTS/landing_light2_down")
      end
    ]])
end


function ChampBravoLed_A310_ini()
  btq_led.led_check(
    (
      (get("A300/MCDU/animations/lights/heading_sel") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.HEADING)
  btq_led.led_check(
    (
      (get("A300/MCDU/animations/lights/nav") == 1) or
      (get("A300/MCDU/animations/lights/profile_mode") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.NAV)
  btq_led.led_check(
    (
      (get("A300/MCDU/animations/lights/approach") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.APR)
  btq_led.led_check(
    (
      (get("A300/MCDU/animations/lights/level_change") == 1) or
      (get("A300/MCDU/animations/lights/altitude_hold") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.ALT)
  btq_led.led_check(
    (
      (false)
    ), btq_led, 'A', btq_led.block_A_LED.VS)
  btq_led.led_check(
    (
      (get("A300/MCDU/animations/lights/autothrottle") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.IAS)

  btq_led.led_check(
    (
      (get("A300/master_warning") == 1)
    ), btq_led, 'B', btq_led.block_B_LED.MASTER_WARNING)
  btq_led.led_check(
    (
      (get("A300/master_caution_light") == 1)
    ), btq_led, 'C', btq_led.block_C_LED.MASTER_CAUTION)
  btq_led.led_check(
    (
      (get("A300/FIRE/fire_handle_engine1_light") == 1) or
      (get("A300/FIRE/fire_handle_apu_light")     == 1) or
      (get("A300/FIRE/fire_handle_engine2_light") == 1)
    ), btq_led, 'B', btq_led.block_B_LED.ENGINE_FIRE)
  btq_led.led_check(
    (
      (get("A300/engine/engine1_oil_low_press_light") == 1) or
      (get("A300/engine/engine2_oil_low_press_light") == 1)
    ), btq_led, 'C', btq_led.block_C_LED.LOW_OIL_PRESS)
  btq_led.led_check(
    (
      (get("A300/HYD/hydraulic_blue_light")   == 1) or
      (get("A300/HYD/hydraulic_green1_light") == 1) or
      (get("A300/HYD/hydraulic_green2_light") == 1) or
      (get("A300/HYD/hydraulic_green3_light") == 1) or
      (get("A300/HYD/hydraulic_yellow_light") == 1)
    ), btq_led, 'C', btq_led.block_C_LED.LOW_HYD_PRESS)
  btq_led.led_check(
    (
      (get("A300/FUEL/outer_tank_pump1_left_low_pressure")  == 1 ) or
      (get("A300/FUEL/outer_tank_pump2_left_low_pressure")  == 1 ) or
      (get("A300/FUEL/outer_tank_pump1_right_low_pressure") == 1 ) or
      (get("A300/FUEL/outer_tank_pump2_right_low_pressure") == 1 ) or
      (get("A300/FUEL/center_tank_pump1_low_pressure")      == 1 ) or
      (get("A300/FUEL/center_tank_pump2_low_pressure")      == 1 ) or
      (get("A300/FUEL/inner_tank_pump1_right_low_pressure") == 1 ) or
      (get("A300/FUEL/inner_tank_pump2_right_low_pressure") == 1 ) or
      (get("A300/FUEL/inner_tank_pump2_left_low_pressure")  == 1 ) or
      (get("A300/FUEL/inner_tank_pump1_left_low_pressure")  == 1 ) or
      (get("A300/FUEL/trim_tank_pump2_low_pressure")        == 1 ) or
      (get("A300/FUEL/trim_tank_pump1_low_pressure")        == 1 )
    ), btq_led, 'C', btq_led.block_C_LED.LOW_FUEL_PRESS)
  btq_led.led_check(
    (
      (get("sim/cockpit2/ice/cowling_thermal_anti_ice_per_engine", 0) == 1) or
      (get("sim/cockpit2/ice/cowling_thermal_anti_ice_per_engine", 1) == 1) or
      (get("A300/ICE/wing_supply") == 1)
    ), btq_led, 'C', btq_led.block_C_LED.ANTI_ICE)

  btq_led.led_check(
    (
      (get("A300/APU/master_switch_button") == 1) or
      (get("A300/APU/n1") > 5.0)
    ), btq_led, 'C', btq_led.block_C_LED.APU)
  btq_led.led_check(
    (
      (get("A300/GND/doors_ratio", 0) > 0.1 ) or
      (get("A300/GND/doors_ratio", 1) > 0.1 ) or
      (get("A300/GND/doors_ratio", 2) > 0.1 ) or
      (get("A300/GND/doors_ratio", 3) > 0.1 ) or
      (get("A300/GND/doors_ratio", 4) > 0.1 ) or
      (get("A300/GND/doors_ratio", 5) > 0.1 ) or
      (get("A300/GND/doors_ratio", 6) > 0.1 ) or
      (get("A300/GND/doors_ratio", 7) > 0.1 ) or
      (get("A300/GND/doors_ratio", 8) > 0.1 ) or
      (get("A300/GND/doors_ratio", 9) > 0.1 ) 
    ), btq_led, 'D', btq_led.block_D_LED.DOOR)


  if (
      (get("A300/elec/battery_on")      == 0) and
      (get("A300/elec/dc_norm_bus_off") == 1) and
      (get("A300/elec/ac_bus1_off")     == 1) and
      (get("A300/elec/ac_bus2_off")     == 1)
     ) then setAllToOff()
  end
end

function ChampBravoCheck_A310_ini()
  if (XPLMFindDataRef("A300/elec/battery_on")                                 ~= nil and
      XPLMFindDataRef("A300/elec/dc_norm_bus_off")                            ~= nil and
      XPLMFindDataRef("A300/elec/ac_bus1_off")                                ~= nil and
      XPLMFindDataRef("A300/elec/ac_bus2_off")                                ~= nil and

      --AP Panel
      XPLMFindCommand("A300/MCDU/altitude_up")                                ~= nil and
      XPLMFindCommand("A300/MCDU/altitude_down")                              ~= nil and
      XPLMFindCommand("A300/MCDU/vvi_up")                                     ~= nil and
      XPLMFindCommand("A300/MCDU/vvi_down")                                   ~= nil and
      XPLMFindCommand("A300/MCDU/heading_up")                                 ~= nil and
      XPLMFindCommand("A300/MCDU/heading_down")                               ~= nil and
      XPLMFindCommand("A300/radios/ILS/course/dial_up")                       ~= nil and
      XPLMFindCommand("A300/radios/ILS/course/dial_down")                     ~= nil and
      XPLMFindCommand("A300/MCDU/airspeed_up")                                ~= nil and
      XPLMFindCommand("A300/MCDU/airspeed_down")                              ~= nil and

      XPLMFindCommand("A300/MCDU/heading_pull")                               ~= nil and
      XPLMFindCommand("A300/MCDU/nav_mode")                                   ~= nil and
      XPLMFindCommand("A300/MCDU/loc_toggle")                                 ~= nil and
      XPLMFindCommand("A300/MCDU/profile_mode")                               ~= nil and
      XPLMFindCommand("A300/MCDU/approach_mode")                              ~= nil and
      XPLMFindCommand("A300/MCDU/level_change")                               ~= nil and
      XPLMFindCommand("A300/MCUD/altitude_hold_engage")                       ~= nil and  --typo MCUD instead of MCDU
      XPLMFindCommand("A300/MCDU/vvi_engage")                                 ~= nil and
      XPLMFindCommand("A300/MCDU/ap1_engage")                                 ~= nil and
      XPLMFindCommand("A300/MCDU/autothrottle_toggle")                        ~= nil and

      --Axis
      XPLMFindCommand("A300/MCDU/takeoff_goaround_trigger")                   ~= nil and
      XPLMFindCommand("A300/MCDU/disconnect_at")                              ~= nil and

      --Switches
      XPLMFindDataRef("A300/animations/buttons/ANTI_ICE_E1")                  ~= nil and
      XPLMFindDataRef("A300/animations/buttons/ANTI_ICE_E2")                  ~= nil and
      XPLMFindCommand("A300/ICE/eng1_toggle")                                 ~= nil and
      XPLMFindCommand("A300/ICE/eng2_toggle")                                 ~= nil and
      XPLMFindDataRef("A300/animations/buttons/WING_SUPPLY")                  ~= nil and
      XPLMFindCommand("A300/ICE/wing_supply_toggle")                          ~= nil and
      XPLMFindDataRef("A300/switches/animations_current")                     ~= nil and
      XPLMFindCommand("A300/LIGHTS/strobe_light_up")                          ~= nil and
      XPLMFindCommand("A300/LIGHTS/strobe_light_down")                        ~= nil and
      XPLMFindCommand("A300/LIGHTS/landing_light1_up")                        ~= nil and
      XPLMFindCommand("A300/LIGHTS/landing_light2_up")                        ~= nil and
      XPLMFindCommand("A300/LIGHTS/landing_light1_down")                      ~= nil and
      XPLMFindCommand("A300/LIGHTS/landing_light2_down")                      ~= nil and
      XPLMFindCommand("A300/LIGHTS/nose_light_up")                            ~= nil and
      XPLMFindCommand("A300/LIGHTS/nose_light_down")                          ~= nil and

      --LEDs
      XPLMFindDataRef("A300/MCDU/animations/lights/heading_sel")              ~= nil and
      XPLMFindDataRef("A300/MCDU/animations/lights/nav")                      ~= nil and
      XPLMFindDataRef("A300/MCDU/animations/lights/profile_mode")             ~= nil and
      XPLMFindDataRef("A300/MCDU/animations/lights/approach")                 ~= nil and
      XPLMFindDataRef("A300/MCDU/animations/lights/level_change")             ~= nil and
      XPLMFindDataRef("A300/MCDU/animations/lights/altitude_hold")            ~= nil and

      XPLMFindDataRef("A300/master_warning")                                  ~= nil and
      XPLMFindDataRef("A300/master_caution_light")                            ~= nil and
      XPLMFindDataRef("A300/FIRE/fire_handle_engine1_light")                  ~= nil and
      XPLMFindDataRef("A300/FIRE/fire_handle_apu_light")                      ~= nil and
      XPLMFindDataRef("A300/FIRE/fire_handle_engine2_light")                  ~= nil and
      XPLMFindDataRef("A300/engine/engine1_oil_low_press_light")              ~= nil and
      XPLMFindDataRef("A300/engine/engine2_oil_low_press_light")              ~= nil and
      XPLMFindDataRef("A300/HYD/hydraulic_blue_light")                        ~= nil and
      XPLMFindDataRef("A300/HYD/hydraulic_green1_light")                      ~= nil and
      XPLMFindDataRef("A300/HYD/hydraulic_green2_light")                      ~= nil and
      XPLMFindDataRef("A300/HYD/hydraulic_green3_light")                      ~= nil and
      XPLMFindDataRef("A300/HYD/hydraulic_yellow_light")                      ~= nil and
      XPLMFindDataRef("A300/FUEL/outer_tank_pump1_left_low_pressure")         ~= nil and
      XPLMFindDataRef("A300/FUEL/outer_tank_pump2_left_low_pressure")         ~= nil and
      XPLMFindDataRef("A300/FUEL/outer_tank_pump1_right_low_pressure")        ~= nil and
      XPLMFindDataRef("A300/FUEL/outer_tank_pump2_right_low_pressure")        ~= nil and
      XPLMFindDataRef("A300/FUEL/center_tank_pump1_low_pressure")             ~= nil and
      XPLMFindDataRef("A300/FUEL/center_tank_pump2_low_pressure")             ~= nil and
      XPLMFindDataRef("A300/FUEL/inner_tank_pump1_right_low_pressure")        ~= nil and
      XPLMFindDataRef("A300/FUEL/inner_tank_pump2_right_low_pressure")        ~= nil and
      XPLMFindDataRef("A300/FUEL/inner_tank_pump2_left_low_pressure")         ~= nil and
      XPLMFindDataRef("A300/FUEL/inner_tank_pump1_left_low_pressure")         ~= nil and
      XPLMFindDataRef("A300/FUEL/trim_tank_pump2_low_pressure")               ~= nil and
      XPLMFindDataRef("A300/FUEL/trim_tank_pump1_low_pressure")               ~= nil and
      XPLMFindDataRef("sim/cockpit2/ice/cowling_thermal_anti_ice_per_engine") ~= nil and
      XPLMFindDataRef("A300/ICE/wing_supply")                                 ~= nil and
      XPLMFindDataRef("A300/APU/master_switch_button")                        ~= nil and
      XPLMFindDataRef("A300/APU/n1")                                          ~= nil and
      XPLMFindDataRef("A300/GND/doors_ratio")                                 ~= nil

     ) then return true
  else
    return false
  end
end
