--FlyJSim Q4XP (DH8D)

function ChampBravoMapping_DH8D_FlyJSim()
  function bravo_Ap_VsInc(numticks)  bravo_command_multiple("FJS/Q4XP/Autopilot/WheelUP", numticks) end
  function bravo_Ap_VsDec(numticks)  bravo_command_multiple("FJS/Q4XP/Autopilot/WheelDN", numticks) end
  --function bravo_Ap_CrsInc(numticks) bravo_command_multiple("TBD", numticks) end
  --function bravo_Ap_CrsDec(numticks) bravo_command_multiple("TBD", numticks) end
  function bravo_Ap_IasInc(numticks) bravo_command_multiple("FJS/Q4XP/Autopilot/WheelUP", numticks) end
  function bravo_Ap_IasDec(numticks) bravo_command_multiple("FJS/Q4XP/Autopilot/WheelDN", numticks) end

  set_button_assignment(btq.ap_alt, "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then command_begin("sim/autopilot/altitude_arm") elseif (status == "end") then command_end("sim/autopilot/altitude_arm") end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then command_begin("sim/autopilot/altitude_hold") elseif (status == "end") then command_end("sim/autopilot/altitude_hold") end
  end

  do_every_frame("apPanelDualHandler()")

  set_button_assignment(btq.axis12_2nd_func, "FJS/Q4XP/ENGINES/PowerGatePassALL")
  set_button_assignment(btq.axis3_2nd_func, "sim/autopilot/take_off_go_around")

  set_axis_assignment(btq.axis2, "throttle 1", "reverse")
  set_axis_assignment(btq.axis3, "throttle 2", "reverse")
  set_axis_assignment(btq.axis5, "prop", "normal")

  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
end


function ChampBravoLed_DH8D_FlyJSim()
  --btq_led.led_check(
  --  (
  --    (get("A300/MCDU/animations/lights/heading_sel") == 1)
  --  ), btq_led, 'A', btq_led.block_A_LED.HEADING)
  --btq_led.led_check(
  --  (
  --    (get("A300/MCDU/animations/lights/nav") == 1) or
  --    (get("A300/MCDU/animations/lights/profile_mode") == 1)
  --  ), btq_led, 'A', btq_led.block_A_LED.NAV)
  --btq_led.led_check(
  --  (
  --    (get("A300/MCDU/animations/lights/approach") == 1)
  --  ), btq_led, 'A', btq_led.block_A_LED.APR)
  --btq_led.led_check(
  --  (
  --    (get("A300/MCDU/animations/lights/level_change") == 1) or
  --    (get("A300/MCDU/animations/lights/altitude_hold") == 1)
  --  ), btq_led, 'A', btq_led.block_A_LED.ALT)
  --btq_led.led_check(
  --  (
  --    (false)
  --  ), btq_led, 'A', btq_led.block_A_LED.VS)
  --btq_led.led_check(
  --  (
  --    (get("A300/MCDU/animations/lights/autothrottle") == 1)
  --  ), btq_led, 'A', btq_led.block_A_LED.IAS)
  --
  --btq_led.led_check(
  --  (
  --    (get("A300/master_warning") == 1)
  --  ), btq_led, 'B', btq_led.block_B_LED.MASTER_WARNING)
  --btq_led.led_check(
  --  (
  --    (get("A300/master_caution_light") == 1)
  --  ), btq_led, 'C', btq_led.block_C_LED.MASTER_CAUTION)
  --btq_led.led_check(
  --  (
  --    (get("A300/FIRE/fire_handle_engine1_light") == 1) or
  --    (get("A300/FIRE/fire_handle_apu_light")     == 1) or
  --    (get("A300/FIRE/fire_handle_engine2_light") == 1)
  --  ), btq_led, 'B', btq_led.block_B_LED.ENGINE_FIRE)
  --btq_led.led_check(
  --  (
  --    (get("A300/engine/engine1_oil_low_press_light") == 1) or
  --    (get("A300/engine/engine2_oil_low_press_light") == 1)
  --  ), btq_led, 'C', btq_led.block_C_LED.LOW_OIL_PRESS)
  --btq_led.led_check(
  --  (
  --    (get("A300/HYD/hydraulic_blue_light")   == 1) or
  --    (get("A300/HYD/hydraulic_green1_light") == 1) or
  --    (get("A300/HYD/hydraulic_green2_light") == 1) or
  --    (get("A300/HYD/hydraulic_green3_light") == 1) or
  --    (get("A300/HYD/hydraulic_yellow_light") == 1)
  --  ), btq_led, 'C', btq_led.block_C_LED.LOW_HYD_PRESS)
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
  --btq_led.led_check(
  --  (
  --    (get("sim/cockpit2/ice/cowling_thermal_anti_ice_per_engine", 0) == 1) or
  --    (get("sim/cockpit2/ice/cowling_thermal_anti_ice_per_engine", 1) == 1) or
  --    (get("A300/ICE/wing_supply") == 1)
  --  ), btq_led, 'C', btq_led.block_C_LED.ANTI_ICE)
  --
  --btq_led.led_check(
  --  (
  --    (get("A300/APU/master_switch_button") == 1) or
  --    (get("A300/APU/n1") > 5.0)
  --  ), btq_led, 'C', btq_led.block_C_LED.APU)
  --btq_led.led_check(
  --  (
  --    (get("A300/GND/doors_ratio", 0) > 0.1 ) or
  --    (get("A300/GND/doors_ratio", 1) > 0.1 ) or
  --    (get("A300/GND/doors_ratio", 2) > 0.1 ) or
  --    (get("A300/GND/doors_ratio", 3) > 0.1 ) or
  --    (get("A300/GND/doors_ratio", 4) > 0.1 ) or
  --    (get("A300/GND/doors_ratio", 5) > 0.1 ) or
  --    (get("A300/GND/doors_ratio", 6) > 0.1 ) or
  --    (get("A300/GND/doors_ratio", 7) > 0.1 ) or
  --    (get("A300/GND/doors_ratio", 8) > 0.1 ) or
  --    (get("A300/GND/doors_ratio", 9) > 0.1 ) 
  --  ), btq_led, 'D', btq_led.block_D_LED.DOOR)
  --
  --
  --if (
  --    (get("A300/elec/battery_on")      == 0) and
  --    (get("A300/elec/dc_norm_bus_off") == 1) and
  --    (get("A300/elec/ac_bus1_off")     == 1) and
  --    (get("A300/elec/ac_bus2_off")     == 1)
  --   ) then setAllToOff()
  --end
end

function ChampBravoCheck_DH8D_FlyJSim()
  if (--XPLMFindDataRef("A300/elec/battery_on")                                 ~= nil and
  --    XPLMFindDataRef("A300/elec/dc_norm_bus_off")                            ~= nil and
  --    XPLMFindDataRef("A300/elec/ac_bus1_off")                                ~= nil and
  --    XPLMFindDataRef("A300/elec/ac_bus2_off")                                ~= nil and

      --AP Panel
      XPLMFindCommand("FJS/Q4XP/Autopilot/WheelUP")                            ~= nil and
      XPLMFindCommand("FJS/Q4XP/Autopilot/WheelDN")                            ~= nil and
  --    XPLMFindCommand("A300/radios/ILS/course/dial_up")                       ~= nil and
  --    XPLMFindCommand("A300/radios/ILS/course/dial_down")                     ~= nil and

      --Axis
      XPLMFindCommand("FJS/Q4XP/ENGINES/PowerGatePassALL")                    ~= nil and
  --    XPLMFindCommand("A300/MCDU/disconnect_at")                              ~= nil and

      --Switches
  --    XPLMFindDataRef("A300/animations/buttons/ANTI_ICE_E1")                  ~= nil and
  --    XPLMFindDataRef("A300/animations/buttons/ANTI_ICE_E2")                  ~= nil and
  --    XPLMFindCommand("A300/ICE/eng1_toggle")                                 ~= nil and
  --    XPLMFindCommand("A300/ICE/eng2_toggle")                                 ~= nil and
  --    XPLMFindDataRef("A300/animations/buttons/WING_SUPPLY")                  ~= nil and
  --    XPLMFindCommand("A300/ICE/wing_supply_toggle")                          ~= nil and

      --LEDs
  --    XPLMFindDataRef("A300/MCDU/animations/lights/heading_sel")              ~= nil and
  --    XPLMFindDataRef("A300/MCDU/animations/lights/nav")                      ~= nil and
  --    XPLMFindDataRef("A300/MCDU/animations/lights/profile_mode")             ~= nil and
  --    XPLMFindDataRef("A300/MCDU/animations/lights/approach")                 ~= nil and
  --    XPLMFindDataRef("A300/MCDU/animations/lights/level_change")             ~= nil and
  --    XPLMFindDataRef("A300/MCDU/animations/lights/altitude_hold")            ~= nil and
  --
  --    XPLMFindDataRef("A300/master_warning")                                  ~= nil and
  --    XPLMFindDataRef("A300/master_caution_light")                            ~= nil and
  --    XPLMFindDataRef("A300/FIRE/fire_handle_engine1_light")                  ~= nil and
  --    XPLMFindDataRef("A300/FIRE/fire_handle_apu_light")                      ~= nil and
  --    XPLMFindDataRef("A300/FIRE/fire_handle_engine2_light")                  ~= nil and
  --    XPLMFindDataRef("A300/engine/engine1_oil_low_press_light")              ~= nil and
  --    XPLMFindDataRef("A300/engine/engine2_oil_low_press_light")              ~= nil and
  --    XPLMFindDataRef("A300/HYD/hydraulic_blue_light")                        ~= nil and
  --    XPLMFindDataRef("A300/HYD/hydraulic_green1_light")                      ~= nil and
  --    XPLMFindDataRef("A300/HYD/hydraulic_green2_light")                      ~= nil and
  --    XPLMFindDataRef("A300/HYD/hydraulic_green3_light")                      ~= nil and
  --    XPLMFindDataRef("A300/HYD/hydraulic_yellow_light")                      ~= nil and
  --    XPLMFindDataRef("A300/FUEL/outer_tank_pump1_left_low_pressure")         ~= nil and
  --    XPLMFindDataRef("A300/FUEL/outer_tank_pump2_left_low_pressure")         ~= nil and
  --    XPLMFindDataRef("A300/FUEL/outer_tank_pump1_right_low_pressure")        ~= nil and
  --    XPLMFindDataRef("A300/FUEL/outer_tank_pump2_right_low_pressure")        ~= nil and
  --    XPLMFindDataRef("A300/FUEL/center_tank_pump1_low_pressure")             ~= nil and
  --    XPLMFindDataRef("A300/FUEL/center_tank_pump2_low_pressure")             ~= nil and
  --    XPLMFindDataRef("A300/FUEL/inner_tank_pump1_right_low_pressure")        ~= nil and
  --    XPLMFindDataRef("A300/FUEL/inner_tank_pump2_right_low_pressure")        ~= nil and
  --    XPLMFindDataRef("A300/FUEL/inner_tank_pump2_left_low_pressure")         ~= nil and
  --    XPLMFindDataRef("A300/FUEL/inner_tank_pump1_left_low_pressure")         ~= nil and
  --    XPLMFindDataRef("A300/FUEL/trim_tank_pump2_low_pressure")               ~= nil and
  --    XPLMFindDataRef("A300/FUEL/trim_tank_pump1_low_pressure")               ~= nil and
  --    XPLMFindDataRef("sim/cockpit2/ice/cowling_thermal_anti_ice_per_engine") ~= nil and
  --    XPLMFindDataRef("A300/ICE/wing_supply")                                 ~= nil and
  --    XPLMFindDataRef("A300/APU/master_switch_button")                        ~= nil and
  --    XPLMFindDataRef("A300/APU/n1")                                          ~= nil and
  --    XPLMFindDataRef("A300/GND/doors_ratio")                                 ~= nil
      true
    ) then return true
  else
    return false
  end
end
