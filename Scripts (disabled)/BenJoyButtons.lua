logMsg("Champion Info: Start of script")

local rift      = require("champ_joy_rift")
local pedals    = require("champ_joy_ChPedals")
local yoke      = require("champ_joy_ChYoke")
local x55j      = require("champ_joy_x55j")
local TPR       = require("champ_joy_tpr")
local scgl      = require("champ_joy_scg_l")
local stq       = require("champ_joy_saitek_tq")
local btq       = require("champ_joy_bravo")
local btq_led   = require("champ_joy_bravo_leds")

local device_DB = require("champ_joy_auto_detect")

function ChampInit()
  clear_all_axis_assignments()
  clear_all_button_assignments()

  -- AXIS    are in 25  blocks
  -- Buttons are in 160 blocks

  -- Declare a global instance of the DB in which we will publish the discovered device position from X-Plane Joystick Settings.prf

  device_DB.detect("X:/SteamLibrary/steamapps/common/X-Plane 11/Output/preferences/X-Plane Joystick Settings.prf")

  -- Script to map 1 button to different assignments based on aircraft
  --Rift cannot be auto mapped but the rest can

  --Rift controllers must be manually mapped as they do not appear as a USB device to X-Plane.
  --find their position by searching <X-Plane Directory>\Output\preferences\X-Plane Joystick Settings.prf
  --find the lines starting with _joy_location
  --the oculus rift will be obvious, use the id as such, see example:
  --_joy_location5 vr/Oculus/oculus_Left/WMHD315R200HC9_Controller_Left/none
  --_joy_location6 vr/Oculus/oculus_Right/WMHD315R200HC9_Controller_Right/none
  --thus the left controller is as positon 5 (_joy_location5) and the right controller is at position 6 (_joy_location6)
  rift.map(6,7, true)


  for HID_device = 1,device_DB.size,1
  do
    if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_tpr" == device_DB.db[HID_device]["modu"])) then
      TPR.map(device_DB.db[HID_device]["xpos"], device_DB.db[HID_device]["hidp"])
    end

    if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_scg_l" == device_DB.db[HID_device]["modu"])) then
      scgl.map(device_DB.db[HID_device]["xpos"], device_DB.db[HID_device]["hidp"])
    end

    if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_x55j" == device_DB.db[HID_device]["modu"])) then
      x55j.map(device_DB.db[HID_device]["xpos"], device_DB.db[HID_device]["hidp"])
    end

    if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_ChYoke" == device_DB.db[HID_device]["modu"])) then
      yoke.map(device_DB.db[HID_device]["xpos"], device_DB.db[HID_device]["hidp"])
    end

    if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_ChPedals" == device_DB.db[HID_device]["modu"])) then
      pedals.map(device_DB.db[HID_device]["xpos"], device_DB.db[HID_device]["hidp"])
    end

    if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_bravo" == device_DB.db[HID_device]["modu"])) then
      btq.map(device_DB.db[HID_device]["xpos"], device_DB.db[HID_device]["hidp"])
      btq.ap_panel_main()
      btq_led.bravo_led_main()
    end
  end
end

-------------------------
-- Common Axis Mapping --
-------------------------

function ChampComAxis()
  set_axis_assignment(yoke.axis_roll , "roll", "normal")
  set_axis_assignment(yoke.axis_pitch, "pitch", "normal")
  set_axis_assignment(yoke.axis_2    , "prop", "reverse")
  set_axis_assignment(yoke.axis_3    , "mixture", "reverse")

  set_axis_assignment(pedals.yaw    , "yaw", "normal")
  set_axis_assignment(pedals.brake_l, "left toe brake", "normal")
  set_axis_assignment(pedals.brake_r, "right toe brake", "normal")

  set_axis_assignment(btq.axis1,      "speedbrakes", "normal")
  set_axis_assignment(btq.axis6,      "flaps", "reverse")
end


----------------------------
-- Common Buttons Mapping --
----------------------------

function ChampComButtons()
  set_button_assignment(yoke.Red_Up,        "sim/autopilot/servos_off_any")
  set_button_assignment(yoke.Red_Dn,        "sim/engines/TOGA_power")
  set_button_assignment(yoke.Hat_Up,        "sim/general/hat_switch_up")
  set_button_assignment(yoke.Hat_UpR,       "sim/general/hat_switch_up_right")
  set_button_assignment(yoke.Hat_R,         "sim/general/hat_switch_right")
  set_button_assignment(yoke.Hat_DnR,       "sim/general/hat_switch_down_right")
  set_button_assignment(yoke.Hat_Dn,        "sim/general/hat_switch_down")
  set_button_assignment(yoke.Hat_DnL,       "sim/general/hat_switch_down_left")
  set_button_assignment(yoke.Hat_L,         "sim/general/hat_switch_left")
  set_button_assignment(yoke.Hat_UpL,       "sim/general/hat_switch_up_left")
  set_button_assignment(yoke.Vert_Up,       "sim/flight_controls/pitch_trim_down")
  set_button_assignment(yoke.Verd_Dn,       "sim/flight_controls/pitch_trim_up")
  set_button_assignment(yoke.Hor_Left,      "sim/flight_controls/rudder_trim_left")
  set_button_assignment(yoke.Hor_Right,     "sim/flight_controls/rudder_trim_right")
  set_button_assignment(yoke.Sw_R_Up,       "sim/flight_controls/speed_brakes_up_one")
  set_button_assignment(yoke.Sw_L_Up,       "sim/view/circle")
  set_button_assignment(yoke.Sw_R_Dn,       "sim/flight_controls/brakes_toggle_max")

  set_button_assignment(x55j.pov_0,         "sim/general/hat_switch_up")
  set_button_assignment(x55j.pov_45,        "sim/general/hat_switch_up_right")
  set_button_assignment(x55j.pov_90,        "sim/general/hat_switch_right")
  set_button_assignment(x55j.pov_135,       "sim/general/hat_switch_down_right")
  set_button_assignment(x55j.pov_180,       "sim/general/hat_switch_down")
  set_button_assignment(x55j.pov_225,       "sim/general/hat_switch_down_left")
  set_button_assignment(x55j.pov_270,       "sim/general/hat_switch_left")
  set_button_assignment(x55j.pov_315,       "sim/general/hat_switch_up_left")

  set_button_assignment(x55j.D,             "sim/view/default_view")
  set_button_assignment(x55j.H2_0,          "sim/view/linear_spot")
  set_button_assignment(x55j.H2_90,         "sim/view/chase")
  set_button_assignment(x55j.H2_180,        "sim/view/circle")
  set_button_assignment(x55j.H2_270,        "sim/view/free_camera")

  set_button_assignment(btq.flaps_up,       "sim/flight_controls/flaps_up")
  set_button_assignment(btq.flaps_dn,       "sim/flight_controls/flaps_down")
  set_button_assignment(btq.gear_up,        "sim/flight_controls/landing_gear_up")
  set_button_assignment(btq.gear_dn,        "sim/flight_controls/landing_gear_down")
  set_button_assignment(btq.trim_dn,        "sim/flight_controls/pitch_trim_down")
  set_button_assignment(btq.trim_up,        "sim/flight_controls/pitch_trim_up")
  set_button_assignment(btq.sw6_up,         "sim/lights/taxi_lights_on")
  set_button_assignment(btq.sw6_dn,         "sim/lights/taxi_lights_off")
  set_button_assignment(btq.sw7_up,         "sim/lights/landing_lights_on")
  set_button_assignment(btq.sw7_dn,         "sim/lights/landing_lights_off")

  set_button_assignment(btq.ap_hdg, "sim/autopilot/heading")
  set_button_assignment(btq.ap_nav, "sim/autopilot/hdg_nav")
  set_button_assignment(btq.ap_apr, "sim/autopilot/approach")
  set_button_assignment(btq.ap_rev, "sim/autopilot/back_course")
  set_button_assignment(btq.ap_alt, "sim/autopilot/altitude_hold")
  set_button_assignment(btq.ap_vs, "sim/autopilot/vertical_speed")
  set_button_assignment(btq.ap_ias, "sim/autopilot/autothrottle_toggle")
  set_button_assignment(btq.ap_master, "sim/autopilot/servos_toggle")

  do_every_frame([[
    ParkPos = get("sim/cockpit2/controls/parking_brake_ratio")
    SwPos = button(]]..btq.sw1_up..[[)

    if (SwPos and (ParkPos < 0.0001)) then
      command_once("sim/flight_controls/brakes_toggle_max")
    elseif (not(SwPos) and (ParkPos > 0.9999)) then
      command_once("sim/flight_controls/brakes_toggle_max")
    end
  ]])
end


-------------------------------------
-- Common 2 engine helper function --
-------------------------------------

function normal_reverser_handler()
  if PLANE_ICAO == "A320" then
    if (button(btq.axis3_rev_handle)            and (get("model/controls/engine_reverse1") <= 0.5) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 0) < 0.05)) then
      command_once("sim/engines/thrust_reverse_toggle_1")
    elseif ((not(button(btq.axis3_rev_handle))) and (get("model/controls/engine_reverse1") >= 0.5) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 0) < 0.05)) then
      command_once("sim/engines/thrust_reverse_toggle_1")
    end

    if (button(btq.axis4_rev_handle)            and (get("model/controls/engine_reverse2") <= 0.5) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 1) < 0.05)) then
      command_once("sim/engines/thrust_reverse_toggle_2")
    elseif ((not(button(btq.axis4_rev_handle))) and (get("model/controls/engine_reverse2") >= 0.5) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 1) < 0.05)) then
      command_once("sim/engines/thrust_reverse_toggle_2")
    end
  else
    if (button(btq.axis3_rev_handle)            and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0) >= -1) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 0) < 0.05)) then
      set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, -1.0001)
    elseif ((not(button(btq.axis3_rev_handle))) and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0) < 0)   and (get("sim/cockpit2/engine/actuators/throttle_ratio", 0) < 0.05)) then
      set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, 0)
    end
    
    if (button(btq.axis4_rev_handle)            and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1) >= -1) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 1) < 0.05)) then
      set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, -1.0001)
    elseif ((not(button(btq.axis4_rev_handle))) and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1) < 0)   and (get("sim/cockpit2/engine/actuators/throttle_ratio", 1) < 0.05)) then
      set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, 0)
    end
  end
end


---------------------------
-- Common engine mapping --
---------------------------

function ChampComEngine()
  ChampNbEngines  = get("sim/aircraft/engine/acf_num_engines")
  ChampEngineType = get("sim/aircraft/prop/acf_en_type", 0)
  ChampEngineBeta = get("sim/aircraft/overflow/acf_has_beta")
  logMsg(string.format("The number of engines is %i (Type: %i)", ChampNbEngines, ChampEngineType))

  if (((4 >= ChampEngineType) and (ChampNbEngines <= 2)) or (PLANE_ICAO == "B350")) then  --Prop aircraft
    set_axis_assignment(btq.axis1, "throttle 1", "reverse")
    set_axis_assignment(btq.axis2, "throttle 2", "reverse")

    if (ChampEngineBeta) then
      set_axis_assignment(btq.axis1, "none", "normal")
      set_axis_assignment(btq.axis2, "none", "normal")
      set_button_assignment(btq.axis1_rev_zone, "sim/engines/beta_toggle_1")
      set_button_assignment(btq.axis2_rev_zone, "sim/engines/beta_toggle_2")

      do_every_frame([[
        Eng1Mode = get("sim/flightmodel/engine/ENGN_propmode", 0)
        Eng1Pos  = get("sim/cockpit2/engine/actuators/throttle_ratio", 0)
        Throttle1Pos = get("sim/joystick/joystick_axis_values",]].. btq.axis1..[[)

        if     ((Eng1Mode == 1) and (Throttle1Pos > 0.02)) then
          set_array("sim/cockpit2/engine/actuators/throttle_ratio", 0, Throttle1Pos)
        elseif ((Eng1Mode == 1) and (Throttle1Pos < 0.02) and (Eng1Pos >= 0.02)) then
          set_array("sim/cockpit2/engine/actuators/throttle_ratio", 0, 0)
        elseif (Eng1Mode > 1) then
          if (Throttle1Pos < 0.45)  then --beta range
            set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, (-2 * Throttle1Pos - 0.01))
          elseif (Throttle1Pos > 0.50) then -- reverse
            set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, (-2 * Throttle1Pos))
          end
        end
      ]])

      do_every_frame([[
        Eng2Mode = get("sim/flightmodel/engine/ENGN_propmode", 1)
        Eng2Pos  = get("sim/cockpit2/engine/actuators/throttle_ratio", 1)
        Throttle2Pos = get("sim/joystick/joystick_axis_values",]].. btq.axis2..[[)

        if     ((Eng2Mode == 1) and (Throttle2Pos > 0.02)) then
          set_array("sim/cockpit2/engine/actuators/throttle_ratio", 1, Throttle2Pos)
        elseif ((Eng2Mode == 1) and (Throttle2Pos < 0.02) and (Eng2Pos >= 0.02)) then
          set_array("sim/cockpit2/engine/actuators/throttle_ratio", 1, 0)
        elseif (Eng2Mode > 1) then
          if (Throttle2Pos < 0.45)  then --beta range
            set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, (-2 * Throttle2Pos - 0.01))
          elseif (Throttle2Pos > 0.50) then -- reverse
            set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, (-2 * Throttle2Pos))
          end
        end
      ]])

    else
      set_button_assignment(btq.axis1_rev_zone, "sim/engines/thrust_reverse_toggle_1")
      set_button_assignment(btq.axis2_rev_zone, "sim/engines/thrust_reverse_toggle_2")
    end

    set_axis_assignment(btq.axis3, "prop 1", "normal")
    set_axis_assignment(btq.axis4, "prop 2", "normal")

    set_axis_assignment(btq.axis5, "mixture 1", "normal")
    set_axis_assignment(btq.axis6, "mixture 2", "normal")

    set_button_assignment(btq.axis1_special, "sim/autopilot/take_off_go_around")
  elseif ChampNbEngines == 2 then
    set_axis_assignment(btq.axis3, "throttle 1", "reverse")
    set_axis_assignment(btq.axis4, "throttle 2", "reverse")

    set_button_assignment(btq.axis3_toga, "sim/engines/TOGA_power")
    set_button_assignment(btq.axis3_rev_zone, "sim/engines/thrust_reverse_toggle_1")
    set_button_assignment(btq.axis4_rev_zone, "sim/engines/thrust_reverse_toggle_2")

    do_every_frame("normal_reverser_handler()")
  elseif ChampNbEngines >= 3 then
    set_axis_assignment(btq.axis2, "throttle 1", "reverse")
    set_axis_assignment(btq.axis3, "throttle 2", "reverse")
    set_axis_assignment(btq.axis4, "throttle 3", "reverse")
    set_axis_assignment(btq.axis5, "throttle 4", "reverse")

    set_button_assignment(btq.axis2_toga, "sim/engines/TOGA_power")
    set_button_assignment(btq.axis2_rev_zone, "sim/engines/thrust_reverse_toggle_1")
    set_button_assignment(btq.axis3_rev_zone, "sim/engines/thrust_reverse_toggle_2")
    set_button_assignment(btq.axis4_rev_zone, "sim/engines/thrust_reverse_toggle_3")
    set_button_assignment(btq.axis5_rev_zone, "sim/engines/thrust_reverse_toggle_4")

    do_every_frame([[
      if (button(]]..btq.axis2_rev_handle..[[)            and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0) >= -1) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 0) < 0.05)) then
        set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, -1.0001)
      elseif ((not(button(]]..btq.axis2_rev_handle..[[))) and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0) < 0)   and (get("sim/cockpit2/engine/actuators/throttle_ratio", 0) < 0.05)) then
        set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, 0)
      end
      
      if (button(]]..btq.axis3_rev_handle..[[)            and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1) >= -1) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 1) < 0.05)) then
        set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, -1.0001)
      elseif ((not(button(]]..btq.axis3_rev_handle..[[))) and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1) < 0)   and (get("sim/cockpit2/engine/actuators/throttle_ratio", 1) < 0.05)) then
        set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, 0)
      end

      if (button(]]..btq.axis4_rev_handle..[[)            and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 2) >= -1) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 2) < 0.05)) then
        set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 2, -1.0001)
      elseif ((not(button(]]..btq.axis4_rev_handle..[[))) and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 2) < 0)   and (get("sim/cockpit2/engine/actuators/throttle_ratio", 2) < 0.05)) then
        set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 2, 0)
      end

      if (button(]]..btq.axis5_rev_handle..[[)            and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 3) >= -1) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 3) < 0.05)) then
        set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 3, -1.0001)
      elseif ((not(button(]]..btq.axis5_rev_handle..[[))) and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 3) < 0)   and (get("sim/cockpit2/engine/actuators/throttle_ratio", 3) < 0.05)) then
        set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 3, 0)
      end
    ]])
  end
end


function ChampOculusRift()
  set_axis_assignment(rift.L_Joy_X,      "VR Touchpad X", "normal")
  set_axis_assignment(rift.L_Joy_Y,      "VR Touchpad Y", "normal")
  set_axis_assignment(rift.L_Joy_Index , "VR Trigger",    "normal")

  set_axis_assignment(rift.R_Joy_X,      "VR Touchpad X"  , "normal")
  set_axis_assignment(rift.R_Joy_Y,      "VR Touchpad Y"  , "normal")
  set_axis_assignment(rift.R_Joy_Index,  "VR Trigger"     , "normal")

  set_button_assignment(rift.L_Y,        "sim/VR/reserved/menu")
  set_button_assignment(rift.L_X,        "sim/VR/general/reset_view")
  set_button_assignment(rift.L_Touchpad, "sim/VR/reserved/touchpad")
  set_button_assignment(rift.L_Index,    "sim/VR/reserved/select")

  set_button_assignment(rift.R_Y,        "sim/VR/reserved/menu")
  set_button_assignment(rift.R_X,        "sim/VR/quick_zoom_view")
  set_button_assignment(rift.R_Touchpad, "sim/VR/reserved/touchpad")
  set_button_assignment(rift.R_Index,    "sim/VR/reserved/select")
end

------------------------------
-- Specific Buttons Mapping --
------------------------------

-- We should always ensure the required datarefs exist before attempting to map
-- The associated function is check_specific_datarefs()

function ChampAcSpecific()
  logMsg(string.format("Champion Info: Currently Detected A/C Type is %s", PLANE_ICAO))

  if (PLANE_ICAO == "B737" or PLANE_ICAO == "B738" or PLANE_ICAO == "B739") then
    --Zibo 737-800 or 737-700 Ultimate or 737-900 Ultimate
    set_button_assignment(yoke.Red_Up,  "laminar/B738/autopilot/capt_disco_press")
    set_button_assignment(yoke.Sw_L_Dn, "laminar/B738/autopilot/left_at_dis_press")
    set_button_assignment(yoke.Red_Dn,  "laminar/B738/autopilot/left_toga_press")
    set_button_assignment(btq.ap_nav,     "laminar/B738/autopilot/lnav_press")
    set_button_assignment(btq.ap_hdg,     "laminar/B738/autopilot/hdg_sel_press")
    set_button_assignment(btq.ap_apr,     "laminar/B738/autopilot/app_press")
    set_button_assignment(btq.sw6_up,     "laminar/B738/toggle_switch/taxi_light_brightness_on")
    set_button_assignment(btq.sw6_dn,     "laminar/B738/toggle_switch/taxi_light_brightness_off")
    set_axis_assignment(btq.axis1,        "speedbrakes", "reverse")
    function bravo_Ap_CrsInc(numticks) bravo_command_multiple("laminar/B738/autopilot/course_pilot_up", numticks) end
    function bravo_Ap_CrsDec(numticks) bravo_command_multiple("laminar/B738/autopilot/course_pilot_dn", numticks) end
  elseif (PLANE_ICAO == "B762" or PLANE_ICAO == "B763") then
    --Flight Factor 767
    set_button_assignment(yoke.Red_Up,  "1-sim/comm/AP/ap_disc")
    set_button_assignment(yoke.Sw_L_Dn, "1-sim/comm/AP/at_disc")
    set_button_assignment(yoke.Red_Dn,  "1-sim/comm/AP/at_toga")
    function bravo_Ap_AltInc(numticks) bravo_dataref_multiple("757Avionics/ap/alt_act", numticks, 100) end
    function bravo_Ap_AltDec(numticks) bravo_dataref_multiple("757Avionics/ap/alt_act", numticks, -100) end
    function bravo_Ap_VsInc(numticks)  bravo_dataref_multiple("757Avionics/ap/vs_act", numticks, 10) end
    function bravo_Ap_VsDec(numticks)  bravo_dataref_multiple("757Avionics/ap/vs_act", numticks -10) end
    function bravo_Ap_HdgInc(numticks) bravo_dataref_multiple("757Avionics/ap/hdg_act", numticks, 1) end
    function bravo_Ap_HdgDec(numticks) bravo_dataref_multiple("757Avionics/ap/hdg_act", numticks, -1) end
    function bravo_Ap_CrsInc(numticks) bravo_dataref_multiple("1-sim/vor1/crsRotary", numticks, 0.01) end
    function bravo_Ap_CrsDec(numticks) bravo_dataref_multiple("1-sim/vor1/crsRotary", numticks, -0.01) end
    function bravo_Ap_IasInc(numticks) bravo_dataref_multiple("757Avionics/ap/spd_act", numticks, 1) end
    function bravo_Ap_IasDec(numticks) bravo_dataref_multiple("757Avionics/ap/spd_act", numticks, -1) end
  elseif (PLANE_ICAO == "A300" or PLANE_ICAO == "A310") then
    set_button_assignment(btq.sw7_up, "A300/LIGHTS/landing_lights_on")
    set_button_assignment(btq.sw7_dn, "A300/LIGHTS/landing_lights_off")
    do_every_frame([[
        C_Pos = get("sim/cockpit2/switches/landing_lights_switch", 1)
        CinGate = (C_Pos == 0.0) or (C_Pos == 1) or (C_Pos == 1.5)
        SwPos6 = button(]]..btq.sw6_up..[[)
        SwPos7 = button(]]..btq.sw7_up..[[)

        if (SwPos7 and (C_Pos ~= 1.5) and CinGate) then
          command_once("A300/LIGHTS/nose_light_up")
        elseif (SwPos6 and not(SwPos7) and (C_Pos ~= 1.0) and CinGate) then
          command_once("A300/LIGHTS/nose_light_taxi")
        elseif (not(SwPos6) and not(SwPos7) and (C_Pos ~= 0) and CinGate) then
          command_once("A300/LIGHTS/nose_light_down")
        end
      ]])
  elseif (PLANE_ICAO == "A319" or PLANE_ICAO == "A320" or PLANE_ICAO == "A330") then
    set_axis_assignment(yoke.axis_roll,  "none", "normal")
    set_axis_assignment(yoke.axis_pitch, "none", "normal")
    set_axis_assignment(yoke.axis_2,     "none", "reverse")
    set_axis_assignment(yoke.axis_3,     "none", "reverse")
    set_axis_assignment(x55j.roll,  "roll", "normal")
    set_axis_assignment(x55j.pitch, "pitch", "normal")
    if (PLANE_ICAO == "A319") then
      --Toliss A319
      set_button_assignment(x55j.V, "toliss_airbus/ap_disc_left_stick")
    elseif (PLANE_ICAO == "A320") then
      --Flight Factor A320 Ultimate
      set_button_assignment(x55j.V, "a320/Panel/SidestickTakeoverL_button")
      --set_button_assignment(scgl.Trig_Aft, "a320/Pedestal/EngineDisconnect1_button")
      set_button_assignment(btq.sw6_up,    "sim/none/none")
      set_button_assignment(btq.sw6_dn,    "sim/none/none")
      set_button_assignment(btq.sw7_up,    "sim/none/none")
      set_button_assignment(btq.sw7_dn,    "sim/none/none")
      do_every_frame([[
        L_Pos = get("model/controls/light_land1")
        LinGate = (L_Pos == 0.0) or (L_Pos == 0.5) or (L_Pos == 1.0)
        C_Pos = get("model/controls/light_nose")
        CinGate = (C_Pos == 0.0) or (C_Pos == 0.5) or (C_Pos == 1.0)
        R_Pos = get("model/controls/light_land2")
        RinGate = (R_Pos == 0.0) or (R_Pos == 0.5) or (R_Pos == 1.0)
        SwPos6 = button(]]..btq.sw6_up..[[)
        SwPos7 = button(]]..btq.sw7_up..[[)
        
        if (SwPos7 and (L_Pos ~= 1) and LinGate) then
          command_once("a320/Overhead/LightLandL_switch+")
        elseif (not(SwPos7) and (L_Pos ~= 0) and LinGate) then
          command_once("a320/Overhead/LightLandL_switch+")
        end

        if (SwPos7 and (R_Pos ~= 1) and RinGate) then
          command_once("a320/Overhead/LightLandR_switch+")
        elseif (not(SwPos7) and (R_Pos ~= 0) and RinGate) then
          command_once("a320/Overhead/LightLandR_switch+")
        end

        if (SwPos7 and (C_Pos ~= 1) and CinGate) then
          command_once("a320/Overhead/LightNose_switch+")
        elseif (SwPos6 and not(SwPos7) and (C_Pos ~= 0.5) and CinGate) then
          command_once("a320/Overhead/LightNose_switch+")
        elseif (not(SwPos6) and not(SwPos7) and (C_Pos ~= 0) and CinGate) then
          command_once("a320/Overhead/LightNose_switch+")
        end
      ]])
      function bravo_Ap_AltInc(numticks) bravo_command_multiple("a320/Panel/FCU_Altitude_switch+", numticks) end
      function bravo_Ap_AltDec(numticks) bravo_command_multiple("a320/Panel/FCU_Altitude_switch-", numticks) end
      function bravo_Ap_VsInc(numticks)  bravo_command_multiple("a320/Panel/FCU_Vertical_switch+", numticks) end
      function bravo_Ap_VsDec(numticks)  bravo_command_multiple("a320/Panel/FCU_Vertical_switch-", numticks) end
      function bravo_Ap_HdgInc(numticks) bravo_command_multiple("a320/Panel/FCU_Lateral_switch+", numticks) end
      function bravo_Ap_HdgDec(numticks) bravo_command_multiple("a320/Panel/FCU_Lateral_switch-", numticks) end
      function bravo_Ap_IasInc(numticks) bravo_command_multiple("a320/Panel/FCU_Speed_switch+", numticks) end
      function bravo_Ap_IasDec(numticks) bravo_command_multiple("a320/Panel/FCU_Speed_switch-", numticks) end
      set_button_assignment(btq.ap_nav, "sim/none/none")
      set_button_assignment(btq.ap_apr, "sim/none/none")
      set_button_assignment(btq.ap_rev, "sim/none/none")
      set_button_assignment(btq.ap_alt, "sim/none/none")
      set_button_assignment(btq.ap_vs, "sim/none/none")
      set_button_assignment(btq.ap_ias, "sim/none/none")
      set_button_assignment(btq.ap_master, "sim/none/none")
      function apPanelCockpitHdgShort(status) 
        --if (status == "begin") then set("a320/Panel/FCU_LateralMode", 1) elseif (status == "end") then set("a320/Panel/FCU_LateralMode", 0) end ... alternative with datarefs
        if (status == "begin") then command_begin("a320/Panel/FCU_LateralMode_switch_push") elseif (status == "end") then command_end("a320/Panel/FCU_LateralMode_switch_push") end
      end
      function apPanelCockpitHdgLong(status) 
        if (status == "begin") then command_begin("a320/Panel/FCU_LateralMode_switch_pull") elseif (status == "end") then command_end("a320/Panel/FCU_LateralMode_switch_pull") end
      end
      function apPanelCockpitNavShort(status) 
        --
      end
      function apPanelCockpitNavLong(status) 
        --
      end
      function apPanelCockpitAprShort(status) 
        if (status == "begin") then command_begin("a320/Panel/FCU_Approach_button") elseif (status == "end") then command_end("a320/Panel/FCU_Approach_button") end
      end
      function apPanelCockpitAprLong(status) 
        if (status == "begin") then command_begin("a320/Panel/FCU_Localizer_button") elseif (status == "end") then command_end("a320/Panel/FCU_Localizer_button") end
      end
      function apPanelCockpitRevShort(status)    end
      function apPanelCockpitRevLong(status)     end
      function apPanelCockpitAltShort(status)
        if (status == "begin") then command_begin("a320/Panel/FCU_AltitudeMode_switch_push") elseif (status == "end") then command_end("a320/Panel/FCU_AltitudeMode_switch_push") end
      end
      function apPanelCockpitAltLong(status)
        if (status == "begin") then command_begin("a320/Panel/FCU_AltitudeMode_switch_pull") elseif (status == "end") then command_end("a320/Panel/FCU_AltitudeMode_switch_pull") end
      end
      function apPanelCockpitVsShort(status)
        if (status == "begin") then command_begin("a320/Panel/FCU_VerticalMode_switch_push") elseif (status == "end") then command_end("a320/Panel/FCU_VerticalMode_switch_push") end
      end
      function apPanelCockpitVsLong(status)
        if (status == "begin") then command_begin("a320/Panel/FCU_VerticalMode_switch_pull") elseif (status == "end") then command_end("a320/Panel/FCU_VerticalMode_switch_pull") end
      end
      function apPanelCockpitIasShort(status)
        if (status == "begin") then command_begin("a320/Panel/FCU_SpeedMode_switch_push") elseif (status == "end") then command_end("a320/Panel/FCU_SpeedMode_switch_push") end
      end
      function apPanelCockpitIasLong(status)
        if (status == "begin") then command_begin("a320/Panel/FCU_SpeedMode_switch_pull") elseif (status == "end") then command_end("a320/Panel/FCU_SpeedMode_switch_pull") end
      end
      function apPanelCockpitMasterShort(status)
        if (status == "begin") then command_begin("a320/Panel/FCU_AutoPilot1_button") elseif (status == "end") then command_end("a320/Panel/FCU_AutoPilot1_button") end
      end
      function apPanelCockpitMasterLong(status)
        if (status == "begin") then command_begin("a320/Panel/FCU_AutoThrust_button") elseif (status == "end") then command_end("a320/Panel/FCU_AutoThrust_button") end
      end
      do_every_frame("apPanelDualHandler()")
    elseif (PLANE_ICAO == "A330") then
      --TBD
    end
  elseif (PLANE_ICAO == "B748") then
    --SSG 747
    set_button_assignment(yoke.Red_Up,  "SSG/UFMC/AP_discon_Button")
    set_button_assignment(yoke.Sw_L_Dn, "SSG/UFMC/AP_ARM_AT_Switch")
    set_button_assignment(yoke.Red_Dn,  "SSG/UFMC/TOGA_Button")
  elseif (PLANE_ICAO == "B772" or PLANE_ICAO == "B77W" or PLANE_ICAO == "B77L") then
    --Flight Factor 777
    set_button_assignment(yoke.Red_Up,  "777/ap_disc")
    set_button_assignment(yoke.Sw_L_Dn, "777/at_disc")
    set_button_assignment(yoke.Red_Dn,  "777/at_toga")

    function bravo_Ap_AltInc(numticks) bravo_command_multiple("777/spacial8", numticks) end
    function bravo_Ap_AltDec(numticks) bravo_command_multiple("777/spacial7", numticks) end
    function bravo_Ap_VsInc(numticks)  bravo_command_multiple("777/spacial6", numticks) end
    function bravo_Ap_VsDec(numticks)  bravo_command_multiple("777/spacial5", numticks) end
    function bravo_Ap_HdgInc(numticks) bravo_command_multiple("777/spacial4", numticks) end
    function bravo_Ap_HdgDec(numticks) bravo_command_multiple("777/spacial3", numticks) end
    function bravo_Ap_IasInc(numticks) bravo_command_multiple("777/spacial1", numticks) end
    function bravo_Ap_IasDec(numticks) bravo_command_multiple("777/spacial2", numticks) end
    do_every_frame([[
      T_Pos = get("anim/44/switch")
      SwPos6 = button(]]..btq.sw6_up..[[)

      if (SwPos6 and (T_Pos ~= 1)) then
        set("anim/44/switch", 1)
      elseif (not(SwPos6) and (T_Pos ~= 0)) then
        set("anim/44/switch", 0)
      end
    ]])
    do_every_frame([[
      L_Pos = get("anim/40/switch")
      C_Pos = get("anim/88/switch")
      R_Pos = get("anim/89/switch")
      SwPos7 = button(]]..btq.sw7_up..[[)

      if (SwPos7 and (L_Pos ~= 1)) then
        set("anim/40/switch", 1)
      elseif (not(SwPos7) and (L_Pos ~= 0)) then
        set("anim/40/switch", 0)
      end

      if (SwPos7 and (C_Pos ~= 1)) then
        set("anim/88/switch", 1)
      elseif (not(SwPos7) and (C_Pos ~= 0)) then
        set("anim/88/switch", 0)
      end

      if (SwPos7 and (R_Pos ~= 1)) then
        set("anim/89/switch", 1)
      elseif (not(SwPos7) and (R_Pos ~= 0)) then
        set("anim/89/switch", 0)
      end
    ]])
    set_button_assignment(btq.ap_hdg,    "sim/none/none")
    set_button_assignment(btq.ap_nav,    "sim/none/none")
    set_button_assignment(btq.ap_apr,    "sim/none/none")
    set_button_assignment(btq.ap_rev,    "sim/none/none")
    set_button_assignment(btq.ap_alt,    "sim/none/none")
    set_button_assignment(btq.ap_vs,     "sim/none/none")
    set_button_assignment(btq.ap_ias,    "sim/none/none")
    function apPanelCockpitHdgShort(status) 
      if (status == "begin") then set("anim/173/button", (1 - get("anim/173/button"))) end
    end
    function apPanelCockpitHdgLong(status) 
      if (status == "begin") then set("anim/22/button", (1 - get("anim/22/button"))) end
    end
    function apPanelCockpitNavShort(status) 
      if (status == "begin") then set("anim/16/button", (1 - get("anim/16/button"))) end
    end
    function apPanelCockpitNavLong(status) 
      if (status == "begin") then set("anim/17/button", (1 - get("anim/17/button"))) end
    end
    function apPanelCockpitAprShort(status) 
      if (status == "begin") then set("anim/27/button", (1 - get("anim/27/button"))) end
    end
    function apPanelCockpitAprLong(status) 
      if (status == "begin") then set("anim/26/button", (1 - get("anim/26/button"))) end
    end
    --function apPanelCockpitRevShort(status)    end
    --function apPanelCockpitRevLong(status)     end
    function apPanelCockpitAltShort(status)
      if (status == "begin") then set("anim/18/button", (1 - get("anim/18/button"))) end
    end
    function apPanelCockpitAltLong(status)
      if (status == "begin") then set("anim/25/button", (1 - get("anim/25/button"))) end
    end
    function apPanelCockpitVsShort(status)
      if (status == "begin") then set("anim/24/button", (1 - get("anim/24/button"))) end
    end
    function apPanelCockpitVsLong(status)
      if (status == "begin") then set("anim/14/button", (1 - get("anim/14/button"))) end
    end
    --function apPanelCockpitIasShort(status)
    --  if (status == "begin") then command_begin("a320/Panel/FCU_SpeedMode_switch_push") elseif (status == "end") then command_end("a320/Panel/FCU_SpeedMode_switch_push") end
    --end
    --function apPanelCockpitIasLong(status)
    --  if (status == "begin") then command_begin("a320/Panel/FCU_SpeedMode_switch_pull") elseif (status == "end") then command_end("a320/Panel/FCU_SpeedMode_switch_pull") end
    --end
    do_every_frame("apPanelDualHandler()")
  elseif (PLANE_ICAO == "B789") then
    --TBD
  elseif (PLANE_ICAO == "UH1") then
    --Nimbus UH1?
    set_axis_assignment(yoke.axis_roll,  "none",  "normal")
    set_axis_assignment(yoke.axis_pitch, "none",  "normal")
    set_axis_assignment(yoke.axis_2,     "none",  "reverse")
    set_axis_assignment(yoke.axis_3,     "none",  "reverse")

    set_axis_assignment(x55j.roll,       "roll",  "normal")
    set_axis_assignment(x55j.pitch,      "pitch", "normal")

  end
end


--------------------------
-- Specific LED Mapping --
--------------------------

-- We should always ensure the required datarefs exist before attempting to map
-- The associated function is check_specific_datarefs()

function ChampLedSpecificCheck()
  if (PLANE_ICAO == "B737" or PLANE_ICAO == "B738" or PLANE_ICAO == "B739") then
    --Zibo 737-800 or 737-700 Ultimate or 737-900 Ultimate
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
  elseif (PLANE_ICAO == "B762" or PLANE_ICAO == "B763") then
    --Flight Factor 767
  elseif (PLANE_ICAO == "A320") then
    --Flight Factor A320 Ultimate

    --Need to add these lines to "*\FlightFactor A320 ultimate\data\publish.txt"
    --a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight1/State
    --a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight2/State 
    --a320/Aircraft/Cockpit/Panel/FCU_LocalizerLight/State
    --a320/Aircraft/Cockpit/Panel/FCU_ApproachLight/State
    btq_led.led_check(
      (
        (get("a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight1/State") == 1) or
        (get("a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight2/State") == 1)
      ), btq_led, 'A', btq_led.block_A_LED.AP)
    btq_led.led_check(
      (
        (get("a320/Aircraft/Cockpit/Panel/FCU_LocalizerLight/State") == 1) or
        (get("a320/Aircraft/Cockpit/Panel/FCU_ApproachLight/State") == 1)
      ), btq_led, 'A', btq_led.block_A_LED.APR)
  elseif (PLANE_ICAO == "B772" or PLANE_ICAO == "B77W" or PLANE_ICAO == "B77L") then
    --Flight Factor 777
    btq_led.led_check(
      (
        (get("sim/flightmodel2/gear/deploy_ratio", 3) == 1.0)
      ), btq_led, 'B', btq_led.block_B_LED.RIGHT_GEAR_GREEN)
    btq_led.led_check(
      (
        (get("sim/flightmodel2/gear/deploy_ratio", 3) < 1.0) and
        (get("sim/flightmodel2/gear/deploy_ratio", 3) > 0)
      ), btq_led, 'B', btq_led.block_B_LED.RIGHT_GEAR_RED)
    btq_led.led_check(
      (
        (get("lamps/257") > 0.8) or
        (get("T7Avionics/ap/roll_mode_engaged") == 1) or
        (get("T7Avionics/ap/roll_mode_engaged") == 6)
      ), btq_led, 'A', btq_led.block_A_LED.HEADING)
    btq_led.led_check(
      (
        (get("lamps/253") >= 0.8) or
        (get("lamps/254") == 0.8)
      ), btq_led, 'A', btq_led.block_A_LED.NAV)
    btq_led.led_check(
      (
        (get("lamps/252") >= 0.8)
      ), btq_led, 'A', btq_led.block_A_LED.IAS)
  end
end

---------------------------------
-- Specific Buttons Checks --
---------------------------------

-- We should always ensure the required datarefs exist before attempting to map them in ChampAcSpecific() and ChampLedSpecificCheck()

function check_specific_datarefs()
  local ac_ready = false
  
  if (PLANE_ICAO == "A300" or PLANE_ICAO == "A310") then
    if (XPLMFindCommand("A300/LIGHTS/landing_lights_on")  ~= nil and
        XPLMFindCommand("A300/LIGHTS/landing_lights_off") ~= nil and
        XPLMFindCommand("A300/LIGHTS/nose_light_up")      ~= nil and
        XPLMFindCommand("A300/LIGHTS/nose_light_taxi")    ~= nil and
        XPLMFindCommand("A300/LIGHTS/nose_light_down")    ~= nil) then
      ac_ready = true
    end
  elseif (PLANE_ICAO == "A319") then
    --Toliss A319
    if (XPLMFindCommand("toliss_airbus/ap_disc_left_stick") ~= nil) then
      ac_ready = true
    end
  elseif (PLANE_ICAO == "A320") then
    --Flight Factor A320 Ultimate

    if (XPLMFindCommand("a320/Panel/SidestickTakeoverL_button")    ~= nil and
        XPLMFindCommand("a320/Pedestal/EngineDisconnect1_button")  ~= nil and
        XPLMFindCommand("a320/Panel/EFIS_BaroModeL_switch_pull")   ~= nil and
        XPLMFindCommand("a320/Panel/EFIS_BaroModeL_switch_push")   ~= nil and
        XPLMFindCommand("a320/Panel/FCU_AutoPilot1_button")        ~= nil and
        XPLMFindCommand("a320/Panel/FCU_AutoThrust_button")        ~= nil and
        XPLMFindCommand("a320/Panel/FCU_Altitude_switch+")         ~= nil and
        XPLMFindCommand("a320/Panel/FCU_Altitude_switch-")         ~= nil and
        XPLMFindCommand("a320/Panel/FCU_AltitudeMode_switch_push") ~= nil and
        XPLMFindCommand("a320/Panel/FCU_AltitudeMode_switch_pull") ~= nil and
        XPLMFindCommand("a320/Panel/FCU_Vertical_switch+")         ~= nil and
        XPLMFindCommand("a320/Panel/FCU_Vertical_switch-")         ~= nil and
        XPLMFindCommand("a320/Panel/FCU_VerticalMode_switch_push") ~= nil and
        XPLMFindCommand("a320/Panel/FCU_VerticalMode_switch_pull") ~= nil and
        XPLMFindCommand("a320/Panel/FCU_Lateral_switch+")          ~= nil and
        XPLMFindCommand("a320/Panel/FCU_Lateral_switch-")          ~= nil and
        XPLMFindCommand("a320/Panel/FCU_LateralMode_switch_push")  ~= nil and
        XPLMFindCommand("a320/Panel/FCU_LateralMode_switch_pull")  ~= nil and
        XPLMFindCommand("a320/Panel/FCU_Speed_switch+")            ~= nil and
        XPLMFindCommand("a320/Panel/FCU_Speed_switch-")            ~= nil and
        XPLMFindCommand("a320/Panel/FCU_SpeedMode_switch_push")    ~= nil and
        XPLMFindCommand("a320/Panel/FCU_SpeedMode_switch_pull")    ~= nil and
        XPLMFindCommand("a320/Panel/FCU_Localizer_button")         ~= nil and
        XPLMFindCommand("a320/Panel/FCU_Approach_button")          ~= nil and
        XPLMFindCommand("a320/Overhead/LightLandL_switch+")        ~= nil and
        XPLMFindCommand("a320/Overhead/LightLandR_switch+")        ~= nil and
        XPLMFindCommand("a320/Overhead/LightNose_switch+")         ~= nil and
        XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight1/State") ~= nil and
        XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight2/State") ~= nil and
        XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_LocalizerLight/State")  ~= nil and
        XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_ApproachLight/State")   ~= nil) then
      ac_ready = true
    end
  elseif (PLANE_ICAO == "B737" or PLANE_ICAO == "B738" or PLANE_ICAO == "B739") then
    --Zibo 737-800 or 737-700 Ultimate or 737-900 Ultimate
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
        XPLMFindDataRef("laminar/autopilot/ap_on")                              ~= nil and
        XPLMFindDataRef("laminar/B738/system/wing_anti_ice_valve")              ~= nil and
        XPLMFindDataRef("laminar/B738/autopilot/lnav_engaged")                  ~= nil and
        XPLMFindDataRef("laminar/B738/autopilot/vorloc_status")                 ~= nil and
        XPLMFindDataRef("laminar/B738/autopilot/app_status")                    ~= nil and
        XPLMFindDataRef("laminar/B738/autopilot/hdg_sel_status")                ~= nil) then
      ac_ready = true
    end
  elseif (PLANE_ICAO == "B748") then
    --SSG 747
    if (XPLMFindCommand("SSG/UFMC/AP_discon_Button") ~= nil and
        XPLMFindCommand("SSG/UFMC/AP_ARM_AT_Switch") ~= nil and
        XPLMFindCommand("SSG/UFMC/TOGA_Button")      ~= nil) then
      ac_ready = true
    end
  elseif (PLANE_ICAO == "B762" or PLANE_ICAO == "B763") then
    --Flight Factor 767
    if (XPLMFindCommand("1-sim/comm/AP/ap_disc") ~= nil and
        XPLMFindCommand("1-sim/comm/AP/at_disc") ~= nil and
        XPLMFindCommand("1-sim/comm/AP/at_toga") ~= nil and
        XPLMFindDataRef("757Avionics/ap/alt_act") ~= nil and
        XPLMFindDataRef("757Avionics/ap/alt_act") ~= nil and
        XPLMFindDataRef("757Avionics/ap/vs_act")  ~= nil and
        XPLMFindDataRef("757Avionics/ap/vs_act")  ~= nil and
        XPLMFindDataRef("757Avionics/ap/hdg_act") ~= nil and
        XPLMFindDataRef("757Avionics/ap/hdg_act") ~= nil and
        XPLMFindDataRef("1-sim/vor1/crsRotary")   ~= nil and
        XPLMFindDataRef("1-sim/vor1/crsRotary")   ~= nil and
        XPLMFindDataRef("757Avionics/ap/spd_act") ~= nil and
        XPLMFindDataRef("757Avionics/ap/spd_act") ~= nil) then
      ac_ready = true
    end
  elseif (PLANE_ICAO == "B772" or PLANE_ICAO == "B77W" or PLANE_ICAO == "B77L") then
    --Flight Factor 777
    if (XPLMFindCommand("777/ap_disc") ~= nil and
        XPLMFindCommand("777/at_disc") ~= nil and
        XPLMFindCommand("777/at_toga") ~= nil and
        XPLMFindCommand("777/spacial8") ~= nil and
        XPLMFindCommand("777/spacial7") ~= nil and
        XPLMFindCommand("777/spacial6") ~= nil and
        XPLMFindCommand("777/spacial5") ~= nil and
        XPLMFindCommand("777/spacial4") ~= nil and
        XPLMFindCommand("777/spacial3") ~= nil and
        XPLMFindCommand("777/spacial2") ~= nil and
        XPLMFindCommand("777/spacial1") ~= nil and
        XPLMFindDataRef("anim/44/switch") ~= nil and
        XPLMFindDataRef("anim/40/switch") ~= nil and
        XPLMFindDataRef("anim/88/switch") ~= nil and
        XPLMFindDataRef("anim/89/switch") ~= nil and
        XPLMFindDataRef("anim/13/button") ~= nil and
        XPLMFindDataRef("anim/176/button") ~= nil and
        XPLMFindDataRef("anim/22/button") ~= nil and
        XPLMFindDataRef("anim/173/button") ~= nil and
        XPLMFindDataRef("anim/16/button") ~= nil and
        XPLMFindDataRef("anim/17/button") ~= nil and
        XPLMFindDataRef("anim/26/button") ~= nil and
        XPLMFindDataRef("anim/27/button") ~= nil and
        XPLMFindDataRef("anim/24/button") ~= nil and
        XPLMFindDataRef("anim/14/button") ~= nil and
        XPLMFindDataRef("T7Avionics/ap/roll_mode_engaged") ~= nil and
        XPLMFindDataRef("lamps/257") ~= nil and
        XPLMFindDataRef("lamps/253") ~= nil and
        XPLMFindDataRef("lamps/254") ~= nil and
        XPLMFindDataRef("lamps/252") ~= nil) then
      ac_ready = true
    end
  else
    ac_ready = true
  end
  return ac_ready
end


function monitor()
  if not init_completed then
    if check_specific_datarefs() then
      ChampComAxis()
      ChampComButtons()
      ChampComEngine()
      ChampOculusRift()
      ChampAcSpecific()
      init_completed = true
    else
      draw_string_Helvetica_18(50, 500, "Waiting on ac specific commands/datarefs to be created!")
    end
  end
end


-------------------
-- Main Function --
-------------------

ChampInit()
if (btq.connected) then  --All devices with do_every_* loops are connected
  local init_completed = false

  if init_completed == false then
    do_every_draw("monitor()")
  else
    do_sometimes("monitor()")
  end
end

logMsg("Champion Info: End of script")