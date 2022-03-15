--Zibo 737-800

function ChampBravoMapping_B738_zibo()
  function bravo_Ap_CrsInc(numticks) bravo_command_multiple("laminar/B738/autopilot/course_pilot_up", numticks) end
  function bravo_Ap_CrsDec(numticks) bravo_command_multiple("laminar/B738/autopilot/course_pilot_dn", numticks) end

  set_button_assignment(btq.ap_hdg, "laminar/B738/autopilot/hdg_sel_press")

  set_button_assignment(btq.ap_nav, "sim/none/none")
  function apPanelCockpitNavShort(status) 
    if (status == "begin") then command_begin("laminar/B738/autopilot/lnav_press") elseif (status == "end") then command_end("laminar/B738/autopilot/lnav_press") end
  end
  function apPanelCockpitNavLong(status) 
    if (status == "begin") then command_begin("laminar/B738/autopilot/vnav_press") elseif (status == "end") then command_end("laminar/B738/autopilot/vnav_press") end
  end

  set_button_assignment(btq.ap_apr, "sim/none/none")
  function apPanelCockpitAprShort(status) 
    if (status == "begin") then command_begin("laminar/B738/autopilot/app_press") elseif (status == "end") then command_end("laminar/B738/autopilot/app_press") end
  end
  function apPanelCockpitAprLong(status) 
    if (status == "begin") then command_begin("laminar/B738/autopilot/vorloc_press") elseif (status == "end") then command_end("laminar/B738/autopilot/vorloc_press") end
  end

  set_button_assignment(btq.ap_rev, "sim/none/none")

  set_button_assignment(btq.ap_alt, "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then command_begin("laminar/B738/autopilot/lvl_chg_press") elseif (status == "end") then command_end("laminar/B738/autopilot/lvl_chg_press") end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then command_begin("laminar/B738/autopilot/alt_hld_press") elseif (status == "end") then command_end("laminar/B738/autopilot/alt_hld_press") end
  end

  set_button_assignment(btq.ap_vs, "laminar/B738/autopilot/vs_press")

  set_button_assignment(btq.ap_ias, "sim/none/none")
  function apPanelCockpitIasShort(status)
    if (status == "begin") then command_begin("laminar/B738/autopilot/speed_press") elseif (status == "end") then command_end("laminar/B738/autopilot/speed_press") end
  end
  function apPanelCockpitIasLong(status)
    if (status == "begin") then command_begin("laminar/B738/autopilot/n1_press") elseif (status == "end") then command_end("laminar/B738/autopilot/n1_press") end
  end

  set_button_assignment(btq.ap_master, "sim/none/none")
  function apPanelCockpitMasterShort(status)
    if (status == "begin") then command_begin("laminar/B738/autopilot/cmd_a_press") elseif (status == "end") then command_end("laminar/B738/autopilot/cmd_a_press") end
  end
  function apPanelCockpitMasterLong(status)
    if (status == "begin") then command_begin("laminar/B738/autopilot/cws_a_press") elseif (status == "end") then command_end("laminar/B738/autopilot/cws_a_press") end
  end

  do_every_frame("apPanelDualHandler()")

  set_axis_assignment(btq.axis1, "speedbrakes", "reverse")
  set_button_assignment(btq.axis12_2nd_func, "laminar/B738/autopilot/left_at_dis_press")
  set_button_assignment(btq.axis3_2nd_func, "laminar/B738/autopilot/left_toga_press")

  set_button_assignment(btq.sw1_up, "sim/none/none")
  set_button_assignment(btq.sw1_dn, "sim/none/none")
  do_often([[
      ParkPos = get("sim/cockpit2/controls/parking_brake_ratio")
      ChockStatus = get("laminar/B738/fms/chock_status")
      SwPos = button(]]..btq.sw1_up..[[)
      if (ChockStatus < 0.9) then
        if (SwPos and (ParkPos < 0.0001)) then
          command_once("sim/flight_controls/brakes_toggle_max")
        elseif (not(SwPos) and (ParkPos > 0.9999)) then
          command_once("sim/flight_controls/brakes_toggle_max")
        end
      end
    ]])
  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_often([[
      AcPos1 = get("laminar/B738/antiice_sw", 0)
      AcPos2 = get("laminar/B738/antiice_sw", 1)
      JoyPos = button(]]..btq.sw2_up..[[)


      if (JoyPos and (AcPos1 < 0.0001)) then
        command_once("laminar/B738/toggle_switch/eng1_heat")
      elseif (not(JoyPos) and (AcPos1 > 0.9999)) then
        command_once("laminar/B738/toggle_switch/eng1_heat")
      end

      if (JoyPos and (AcPos2 < 0.0001)) then
        command_once("laminar/B738/toggle_switch/eng2_heat")
      elseif (not(JoyPos) and (AcPos2 > 0.9999)) then
        command_once("laminar/B738/toggle_switch/eng2_heat")
      end
    ]])
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
  do_often([[
      AcPos1 = get("laminar/B738/antiice_sw", 2)
      JoyPos = button(]]..btq.sw3_up..[[)


      if (JoyPos and (AcPos1 < 0.0001)) then
        command_once("laminar/B738/toggle_switch/wing_heat")
      elseif (not(JoyPos) and (AcPos1 > 0.9999)) then
        command_once("laminar/B738/toggle_switch/wing_heat")
      end
    ]])
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_often([[
      AcPos1 = get("laminar/B738/lights_sw", 0)
      JoyPos = button(]]..btq.sw5_up..[[)


      if (JoyPos and (AcPos1 < 0.0001)) then
        command_once("laminar/B738/toggle_switch/position_light_up")
      elseif (not(JoyPos) and (AcPos1 > 0.9999)) then
        command_once("laminar/B738/toggle_switch/position_light_down")
        command_once("laminar/B738/toggle_switch/position_light_down")
      end
    ]])
  set_button_assignment(btq.sw6_up,     "laminar/B738/toggle_switch/taxi_light_brightness_on")
  set_button_assignment(btq.sw6_dn,     "laminar/B738/toggle_switch/taxi_light_brightness_off")
end


function ChampBravoLed_B738_zibo()
  btq_led.led_check((get("laminar/B738/autopilot/hdg_sel_status") == 1), btq_led, 'A', btq_led.block_A_LED.HEADING)
  btq_led.led_check(
    (
      (get("laminar/B738/autopilot/lnav_status") == 1) or
      (get("laminar/B738/autopilot/vnav_status1") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.NAV)
  btq_led.led_check(
    (
      (get("laminar/B738/autopilot/vorloc_status") == 1) or
      (get("laminar/B738/autopilot/app_status") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.APR)
  btq_led.led_check(
    (
      (get("laminar/B738/autopilot/vorloc_status") == 1) or
      (get("laminar/B738/autopilot/app_status") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.ALT)

  btq_led.led_check(false, btq_led, 'B', btq_led.block_B_LED.MASTER_WARNING)
  btq_led.led_check((get("laminar/B738/annunciator/master_caution_light") == 1), btq_led, 'C', btq_led.block_C_LED.MASTER_CAUTION)
  btq_led.led_check((get("laminar/B738/annunciator/fire_bell_annun") == 1), btq_led, 'B', btq_led.block_B_LED.ENGINE_FIRE)
  btq_led.led_check(
    (
      (get("laminar/B738/system/eng_inlet_valve", 0) > 0.25)   or
      (get("laminar/B738/system/eng_inlet_valve", 1) > 0.25)   or
      (get("laminar/B738/system/wing_anti_ice_valve", 0) == 1) or
      (get("laminar/B738/system/wing_anti_ice_valve", 1) == 1)
    ), btq_led, 'C', btq_led.block_C_LED.ANTI_ICE)
  btq_led.led_check((get("laminar/autopilot/ap_on") == 1), btq_led, 'A', btq_led.block_A_LED.AP)
  btq_led.led_check(
    (
      (get("laminar/B738/autopilot/vorloc_status") == 1) or
      (get("laminar/B738/autopilot/app_status") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.APR)
  btq_led.led_check(
    (
      (get("laminar/B738/air/engine1/starter_valve") > 0.25) or
      (get("laminar/B738/air/engine2/starter_valve") > 0.25)
    ), btq_led, 'C', btq_led.block_C_LED.STARTER)
  btq_led.led_check(
    (
      (get("737u/doors/aft1")      > 0.1) or
      (get("737u/doors/aft2")      > 0.1) or
      (get("737u/doors/aft_Cargo") > 0.1) or
      (get("737u/doors/emerg1")    > 0.1) or
      (get("737u/doors/emerg2")    > 0.1) or
      (get("737u/doors/emerg3")    > 0.1) or
      (get("737u/doors/emerg4")    > 0.1) or
      (get("737u/doors/Fwd_Cargo") > 0.1) or
      (get("737u/doors/L1")        > 0.1) or
      (get("737u/doors/L2")        > 0.1) or
      (get("737u/doors/L_mid")     > 0.1) or
      (get("737u/doors/R1")        > 0.1) or
      (get("737u/doors/R2")        > 0.1) or
      (get("737u/doors/R_mid")     > 0.1)
    ), btq_led, 'D', btq_led.block_D_LED.DOOR)
end


function ChampBravoCheck_B738_zibo()
  if (--AP Panel
      XPLMFindCommand("laminar/B738/autopilot/course_pilot_up")               ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/course_pilot_dn")               ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/hdg_sel_press")                 ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/lnav_press")                    ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/vnav_press")                    ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/app_press")                     ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/vorloc_press")                  ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/lvl_chg_press")                 ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/alt_hld_press")                 ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/vs_press")                      ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/speed_press")                   ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/n1_press")                      ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/cmd_a_press")                   ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/cws_a_press")                   ~= nil and
      --Axis
      XPLMFindCommand("laminar/B738/autopilot/left_toga_press")               ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/left_at_dis_press")             ~= nil and
      --Switches
      XPLMFindDataRef("laminar/B738/fms/chock_status")                        ~= nil and
      XPLMFindDataRef("laminar/B738/antiice_sw")                              ~= nil and
      XPLMFindCommand("laminar/B738/toggle_switch/eng1_heat")                 ~= nil and
      XPLMFindCommand("laminar/B738/toggle_switch/eng2_heat")                 ~= nil and
      XPLMFindDataRef("laminar/B738/antiice_sw")                              ~= nil and
      XPLMFindCommand("laminar/B738/toggle_switch/wing_heat")                 ~= nil and
      XPLMFindDataRef("laminar/B738/lights_sw")                               ~= nil and
      XPLMFindCommand("laminar/B738/toggle_switch/position_light_up")         ~= nil and
      XPLMFindCommand("laminar/B738/toggle_switch/position_light_down")       ~= nil and
      XPLMFindCommand("laminar/B738/toggle_switch/taxi_light_brightness_on")  ~= nil and
      XPLMFindCommand("laminar/B738/toggle_switch/taxi_light_brightness_off") ~= nil and
      --LEDs
      XPLMFindDataRef("laminar/B738/autopilot/hdg_sel_status")                ~= nil and
      XPLMFindDataRef("laminar/B738/autopilot/lnav_status")                   ~= nil and
      XPLMFindDataRef("laminar/B738/autopilot/vnav_status1")                  ~= nil and
      XPLMFindDataRef("laminar/B738/autopilot/vorloc_status")                 ~= nil and
      XPLMFindDataRef("laminar/B738/autopilot/app_status")                    ~= nil and
      XPLMFindDataRef("laminar/autopilot/ap_on")                              ~= nil and

      XPLMFindDataRef("laminar/B738/annunciator/master_caution_light")        ~= nil and
      XPLMFindDataRef("laminar/B738/annunciator/fire_bell_annun")             ~= nil and
      XPLMFindDataRef("laminar/B738/system/eng_inlet_valve")                  ~= nil and
      XPLMFindDataRef("laminar/B738/system/wing_anti_ice_valve")              ~= nil and
      XPLMFindDataRef("laminar/B738/air/engine1/starter_valve")               ~= nil and
      XPLMFindDataRef("laminar/B738/air/engine2/starter_valve")               ~= nil and
      XPLMFindDataRef("737u/doors/aft1")                                      ~= nil and
      XPLMFindDataRef("737u/doors/aft2")                                      ~= nil and
      XPLMFindDataRef("737u/doors/aft_Cargo")                                 ~= nil and
      XPLMFindDataRef("737u/doors/emerg1")                                    ~= nil and
      XPLMFindDataRef("737u/doors/emerg2")                                    ~= nil and
      XPLMFindDataRef("737u/doors/emerg3")                                    ~= nil and
      XPLMFindDataRef("737u/doors/emerg4")                                    ~= nil and
      XPLMFindDataRef("737u/doors/Fwd_Cargo")                                 ~= nil and
      XPLMFindDataRef("737u/doors/L1")                                        ~= nil and
      XPLMFindDataRef("737u/doors/L2")                                        ~= nil and
      XPLMFindDataRef("737u/doors/L_mid")                                     ~= nil and
      XPLMFindDataRef("737u/doors/R1")                                        ~= nil and
      XPLMFindDataRef("737u/doors/R2")                                        ~= nil and
      XPLMFindDataRef("737u/doors/R_mid")                                     ~= nil
     ) then return true
  else
    return false
  end
end
