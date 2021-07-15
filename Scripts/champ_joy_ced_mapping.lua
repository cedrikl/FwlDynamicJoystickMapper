logMsg("Champion Info: Start of script")

-- AXIS    are in 25  blocks
-- Buttons are in 160 blocks

-- Declare a global instance of the DB in which we will publish the discovered device position from X-Plane Joystick Settings.prf
device_DB = require("champ_joy_auto_detect")
device_DB.detect("C:/Games/X-Plane 11/Output/preferences/X-Plane Joystick Settings.prf")

-- Script to map 1 button to different assignments based on aircraft

--Rift cannot be auto mapped but the rest can
local rift    = require("champ_joy_rift")
local pedals  = require("champ_joy_ChPedals")
local yoke    = require("champ_joy_ChYoke")
local x55j    = require("champ_joy_x55j")
local TPR     = require("champ_joy_tpr")
local scgl    = require("champ_joy_scg_l")
local stq     = require("champ_joy_saitek_tq")
local btq     = require("champ_joy_bravo")
local btq_led = require("champ_joy_bravo_leds")

--Rift controllers must be manually mapped as they do not appear as a USB device to X-Plane.
--find their position by searching <X-Plane Directory>\Output\preferences\X-Plane Joystick Settings.prf
--find the lines starting with _joy_location
--the oculus rift will be obvious, use the id as such, see example:
--_joy_location5 vr/Oculus/oculus_Left/WMHD315R200HC9_Controller_Left/none
--_joy_location6 vr/Oculus/oculus_Right/WMHD315R200HC9_Controller_Right/none
--thus the left controller is as positon 5 (_joy_location5) and the right controller is at position 6 (_joy_location6)
--rift.map(6,7)


for HID_device = 1,device_DB.size,1
do
  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_tpr" == device_DB.db[HID_device]["modu"])) then
    TPR.map(device_DB.db[HID_device]["xpos"])
  end

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_scg_l" == device_DB.db[HID_device]["modu"])) then
    scgl.map(device_DB.db[HID_device]["xpos"])
  end

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_x55j" == device_DB.db[HID_device]["modu"])) then
    x55j.map(device_DB.db[HID_device]["xpos"])
  end

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_ChYoke" == device_DB.db[HID_device]["modu"])) then
    yoke.map(device_DB.db[HID_device]["xpos"])
  end

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_ChPedals" == device_DB.db[HID_device]["modu"])) then
    pedals.map(device_DB.db[HID_device]["xpos"])
  end

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_bravo" == device_DB.db[HID_device]["modu"])) then
    btq.map(device_DB.db[HID_device]["xpos"])
    btq_led.bravo_led_main()
  end
end


-------------------------
-- Common Axis Mapping --
-------------------------

function ChampComAxis()
  clear_all_axis_assignments()

  set_axis_assignment(scgl.axis_roll , "roll" , "normal")
  set_axis_assignment(scgl.axis_pitch, "pitch", "normal")

  set_axis_assignment(TPR.yaw    , "yaw"            , "normal")
  set_axis_assignment(TPR.brake_l, "left toe brake" , "reverse")
  set_axis_assignment(TPR.brake_r, "right toe brake", "reverse")

  set_axis_assignment(btq.axis1,      "speedbrakes", "normal")
  --set_axis_assignment(btq.axis6,      "flaps", "reverse")
end


----------------------------
-- Common Buttons Mapping --
----------------------------

function ChampComButtons()
  clear_all_button_assignments()

  set_button_assignment(scgl.A2,            "sim/autopilot/servos_off_any")
  set_button_assignment(scgl.A1_Up,         "sim/general/hat_switch_up")
  set_button_assignment(scgl.A1_Up_Right,   "sim/general/hat_switch_up_right")
  set_button_assignment(scgl.A1_Right,      "sim/general/hat_switch_right")
  set_button_assignment(scgl.A1_Down_Right, "sim/general/hat_switch_down_right")
  set_button_assignment(scgl.A1_Down,       "sim/general/hat_switch_down")
  set_button_assignment(scgl.A1_Down_Left,  "sim/general/hat_switch_down_left")
  set_button_assignment(scgl.A1_Left,       "sim/general/hat_switch_left")
  set_button_assignment(scgl.A1_Up_Left,    "sim/general/hat_switch_up_left")
  set_button_assignment(scgl.B1,            "sim/view/default_view")
  set_button_assignment(scgl.D1,            "sim/view/circle")
  set_button_assignment(scgl.A3_Up,         "sim/flight_controls/pitch_trim_down")
  set_button_assignment(scgl.A3_Down,       "sim/flight_controls/pitch_trim_up")
  set_button_assignment(scgl.A3_Left,       "sim/flight_controls/rudder_trim_left")
  set_button_assignment(scgl.A3_Right,      "sim/flight_controls/rudder_trim_right")

  set_button_assignment(btq.flaps_up,       "sim/flight_controls/flaps_up")
  set_button_assignment(btq.flaps_dn,       "sim/flight_controls/flaps_down")
  set_button_assignment(btq.gear_up,        "sim/flight_controls/landing_gear_up")
  set_button_assignment(btq.gear_dn,        "sim/flight_controls/landing_gear_down")

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

  if ((4 >= ChampEngineType) and (ChampNbEngines <= 2)) then  --Prop aircraft
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
    set_button_assignment(scgl.A2,       "laminar/B738/autopilot/capt_disco_press")
    set_button_assignment(scgl.Trig_Aft, "laminar/B738/autopilot/left_at_dis_press")
    set_button_assignment(btq.axis3_toga, "laminar/B738/autopilot/left_toga_press")
    set_axis_assignment(btq.axis1,      "speedbrakes", "reverse")
  elseif (PLANE_ICAO == "B762" or PLANE_ICAO == "B763") then
    --Flight Factor 767
    set_button_assignment(scgl.A2,       "1-sim/comm/AP/ap_disc")
    set_button_assignment(scgl.Trig_Aft, "1-sim/comm/AP/at_disc")
    set_button_assignment(btq.axis3_toga, "1-sim/comm/AP/at_toga")
  elseif (PLANE_ICAO == "A320") then
    --Flight Factor A320 Ultimate
    set_button_assignment(scgl.A2,       "a320/Panel/SidestickTakeoverL_button")
    set_button_assignment(scgl.Trig_Aft, "a320/Pedestal/EngineDisconnect1_button")
  elseif (PLANE_ICAO == "B772" or PLANE_ICAO == "B77W" or PLANE_ICAO == "B77L") then
    --Flight Factor 777
    set_button_assignment(scgl.A2,       "777/ap_disc")
    set_button_assignment(scgl.Trig_Aft, "777/at_disc")
    set_button_assignment(btq.axis3_toga, "777/at_toga")
  end
end


--------------------------
-- Specific LED Mapping --
--------------------------

-- We should always ensure the required datarefs exist before attempting to map
-- The associated function is check_specific_datarefs()

function ChampLedSpecificCheck()
  logMsg(string.format("Champion Info: Currently Detected A/C Type is %s", PLANE_ICAO))

  if (PLANE_ICAO == "B737" or PLANE_ICAO == "B738" or PLANE_ICAO == "B739") then
    --Zibo 737-800 or 737-700 Ultimate or 737-900 Ultimate
    btq_led.led_check(
      (
        (get("laminar/B738/system/wing_anti_ice_valve", 0) == 1) or
        (get("laminar/B738/system/wing_anti_ice_valve", 1) == 1)
      ), btq_led, 'C', btq_led.block_C_LED.ANTI_ICE)
  elseif (PLANE_ICAO == "B762" or PLANE_ICAO == "B763") then
    --Flight Factor 767
  elseif (PLANE_ICAO == "A320") then
    --Flight Factor A320 Ultimate
  elseif (PLANE_ICAO == "B772" or PLANE_ICAO == "B77W" or PLANE_ICAO == "B77L") then
    --Flight Factor 777
  end
end

------------------------------
-- Specific Buttons Mapping --
------------------------------

-- We should always ensure the required datarefs exist before attempting to map them in ChampAcSpecific() and ChampLedSpecificCheck()

function check_specific_datarefs()
  local ac_ready = false

  if (PLANE_ICAO == "A319") then
    --Toliss A319
    if (XPLMFindCommand("toliss_airbus/ap_disc_left_stick") ~= nil) then
      ac_ready = true
    end
  elseif (PLANE_ICAO == "A320") then
    --Flight Factor A320 Ultimate
    if (XPLMFindCommand("a320/Panel/SidestickTakeoverL_button")   ~= nil and
        XPLMFindCommand("a320/Pedestal/EngineDisconnect1_button") ~= nil) then
      ac_ready = true
    end
  elseif (PLANE_ICAO == "B737" or PLANE_ICAO == "B738" or PLANE_ICAO == "B739") then
    --Zibo 737-800 or 737-700 Ultimate or 737-900 Ultimate
    if (XPLMFindCommand("laminar/B738/autopilot/capt_disco_press")  ~= nil and
        XPLMFindCommand("laminar/B738/autopilot/left_at_dis_press") ~= nil and
        XPLMFindCommand("laminar/B738/autopilot/left_toga_press")   ~= nil and
        XPLMFindDataRef("laminar/B738/system/wing_anti_ice_valve")  ~= nil) then
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
        XPLMFindCommand("1-sim/comm/AP/at_toga") ~= nil) then
      ac_ready = true
    end
  elseif (PLANE_ICAO == "B772" or PLANE_ICAO == "B77W" or PLANE_ICAO == "B77L") then
    --Flight Factor 777
    if (XPLMFindCommand("777/ap_disc") ~= nil and
        XPLMFindCommand("777/at_disc") ~= nil and
        XPLMFindCommand("777/at_toga") ~= nil) then
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
      --ChampOculusRift()
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

local init_completed = false

if init_completed == false then
  do_every_draw("monitor()")
else
  do_sometimes("monitor()")
end

logMsg("Champion Info: End of script")
