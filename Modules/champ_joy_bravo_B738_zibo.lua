--Zibo 737-800

function ChampAcSpecific_B738_zibo()
  set_button_assignment(scgl.A2,        "laminar/B738/autopilot/capt_disco_press")
  set_button_assignment(scgl.Trig_Aft,  "laminar/B738/autopilot/left_at_dis_press")
  set_button_assignment(btq.axis3_toga, "laminar/B738/autopilot/left_toga_press")
  set_button_assignment(btq.ap_nav,     "laminar/B738/autopilot/lnav_press")
  set_button_assignment(btq.ap_hdg,     "laminar/B738/autopilot/hdg_sel_press")
  set_button_assignment(btq.ap_apr,     "laminar/B738/autopilot/app_press")
  set_button_assignment(btq.sw6_up,     "laminar/B738/toggle_switch/taxi_light_brightness_on")
  set_button_assignment(btq.sw6_dn,     "laminar/B738/toggle_switch/taxi_light_brightness_off")
  set_axis_assignment(btq.axis1,        "speedbrakes", "reverse")
  function bravo_Ap_CrsInc(numticks) bravo_command_multiple("laminar/B738/autopilot/course_pilot_up", numticks) end
  function bravo_Ap_CrsDec(numticks) bravo_command_multiple("laminar/B738/autopilot/course_pilot_dn", numticks) end
  do_every_frame([[
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
end

function ChampLedSpecificCheck_B738_zibo()
  btq_led.led_check(
    (
      (get("laminar/B738/system/wing_anti_ice_valve", 0) == 1) or
      (get("laminar/B738/system/wing_anti_ice_valve", 1) == 1)
    ), btq_led, 'C', btq_led.block_C_LED.ANTI_ICE)
  btq_led.led_check((get("laminar/B738/autopilot/hdg_sel_status") == 1), btq_led, 'A', btq_led.block_A_LED.HEADING)
  btq_led.led_check((get("laminar/B738/autopilot/lnav_engaged") == 1), btq_led, 'A', btq_led.block_A_LED.NAV)
  btq_led.led_check((get("laminar/autopilot/ap_on") == 1), btq_led, 'A', btq_led.block_A_LED.AP)
  btq_led.led_check(
    (
      (get("laminar/B738/autopilot/vorloc_status") == 1) or
      (get("laminar/B738/autopilot/app_status") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.APR)
end

function check_specific_datarefs_B738_zibo()
  if (XPLMFindCommand("laminar/B738/autopilot/capt_disco_press")              ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/left_at_dis_press")             ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/left_toga_press")               ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/course_pilot_up")               ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/course_pilot_dn")               ~= nil and
      XPLMFindCommand("laminar/B738/toggle_switch/taxi_light_brightness_on")  ~= nil and
      XPLMFindCommand("laminar/B738/toggle_switch/taxi_light_brightness_off") ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/lnav_press")                    ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/hdg_sel_press")                 ~= nil and
      XPLMFindCommand("laminar/B738/autopilot/app_press")                     ~= nil and
      XPLMFindDataRef("laminar/B738/fms/chock_status")                        ~= nil and
      XPLMFindDataRef("laminar/autopilot/ap_on")                              ~= nil and
      XPLMFindDataRef("laminar/B738/system/wing_anti_ice_valve")              ~= nil and
      XPLMFindDataRef("laminar/B738/autopilot/lnav_engaged")                  ~= nil and
      XPLMFindDataRef("laminar/B738/autopilot/vorloc_status")                 ~= nil and
      XPLMFindDataRef("laminar/B738/autopilot/app_status")                    ~= nil and
      XPLMFindDataRef("laminar/B738/autopilot/hdg_sel_status")                ~= nil) then
      ac_ready = true
  end
end