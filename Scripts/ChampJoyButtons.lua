logMsg("Champion Info: Start of script")

-- AXIS    are in 25  blocks
-- Buttons are in 160 blocks


-- Declare a global instance of the DB in which we will publish the discovered device position from X-Plane Joystick Settings.prf
device_DB = require("champ_joy_auto_detect")

device_DB.detect("C:/Games/X-Plane 11/Output/preferences/X-Plane Joystick Settings.prf")

--for HID_device = 1,device_DB.size,1
--do
--  logMsg(device_DB.db[HID_device]["vid"])
--  logMsg(device_DB.db[HID_device]["pid"])
--  logMsg(device_DB.db[HID_device]["name"])
--  logMsg(device_DB.db[HID_device]["modu"])
--  logMsg("\n")
--end

-- Script to map 1 button to different assignments based on aircraft
local TPR  = require("champ_joy_tpr")
local scgl = require("champ_joy_scg_l")
local stq  = require("champ_joy_saitek_tq")
local btq  = require("champ_joy_bravo")
--TPR.map(1)
--scgl.map(2)
--stq.map(0)

for HID_device = 1,device_DB.size,1
do
  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_tpr" == device_DB.db[HID_device]["modu"])) then
    TPR.map(device_DB.db[HID_device]["xpos"])
  end

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_scg_l" == device_DB.db[HID_device]["modu"])) then
    scgl.map(device_DB.db[HID_device]["xpos"])
  end

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_bravo" == device_DB.db[HID_device]["modu"])) then
    btq.map(device_DB.db[HID_device]["xpos"])
  end
end



----------------------------
-- Common Axis Mapping --
----------------------------

function ChampComAxis()

  clear_all_axis_assignments()

  set_axis_assignment(scgl.axis_roll , "roll" , "normal")
  set_axis_assignment(scgl.axis_pitch, "pitch", "normal")

  set_axis_assignment(TPR.yaw    , "yaw"            , "normal")
  set_axis_assignment(TPR.brake_l, "left toe brake" , "reverse")
  set_axis_assignment(TPR.brake_r, "right toe brake", "reverse")
  
  set_axis_assignment(btq.axis1, "speedbrakes", "normal")

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

  set_button_assignment(btq.sw1_up,         "sim/flight_controls/brakes_max")
  set_button_assignment(btq.flaps_up,       "sim/flight_controls/flaps_up")
  set_button_assignment(btq.flaps_dn,       "sim/flight_controls/flaps_down")
  set_button_assignment(btq.gear_up,        "sim/flight_controls/landing_gear_up")
  set_button_assignment(btq.gear_dn,        "sim/flight_controls/landing_gear_down")

end


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


function ChampComEngine()
  ChampNbEngines = get("sim/aircraft/engine/acf_num_engines")
  logMsg(string.format("The number of engines is %i", ChampNbEngines))
  
  if ChampNbEngines == 2 then
    set_axis_assignment(btq.axis3, "throttle 1", "reverse")
    set_axis_assignment(btq.axis4, "throttle 2", "reverse")

    set_button_assignment(btq.axis3_rev_zone, "sim/engines/thrust_reverse_toggle_1")
    set_button_assignment(btq.axis4_rev_zone, "sim/engines/thrust_reverse_toggle_2")

    do_every_frame("normal_reverser_handler()")

  elseif ChampNbEngines >= 3 then

    set_axis_assignment(btq.axis2, "throttle 1", "reverse")
    set_axis_assignment(btq.axis3, "throttle 2", "reverse")
    set_axis_assignment(btq.axis4, "throttle 3", "reverse")
    set_axis_assignment(btq.axis5, "throttle 4", "reverse")

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

------------------------------
-- Specific Buttons Mapping --
------------------------------

function ChampAcSpecific()

  logMsg(string.format("Champion Info: Currently Detected A/C Type is %s", PLANE_ICAO))

  if (PLANE_ICAO == "B738") then
    set_button_assignment(scgl.A2,       "laminar/B738/autopilot/capt_disco_press")
    set_button_assignment(btq.axis3_toga, "laminar/B738/autopilot/left_toga_press")
    set_button_assignment(scgl.Trig_Aft, "laminar/B738/autopilot/left_at_dis_press")
    set_axis_assignment(btq.axis1, "speedbrakes", "reverse")
  elseif (PLANE_ICAO == "B762" or PLANE_ICAO == "B763") then
    set_button_assignment(scgl.A2,       "1-sim/comm/AP/ap_disc")
    set_button_assignment(scgl.Trig_Aft, "1-sim/comm/AP/at_disc")
    set_button_assignment(scgl.Trig_Fwd, "1-sim/comm/AP/at_toga")
  elseif (PLANE_ICAO == "A320") then
    set_button_assignment(scgl.A2,       "a320/Panel/SidestickTakeoverL_button")
    set_button_assignment(scgl.Trig_Aft, "a320/Pedestal/EngineDisconnect1_button")
  elseif (PLANE_ICAO == "B772" or PLANE_ICAO == "B77W" or PLANE_ICAO == "B77L") then
    set_button_assignment(scgl.A2,       "777/ap_disc")
    set_button_assignment(scgl.Trig_Aft, "777/at_disc")
    set_button_assignment(scgl.Trig_Fwd, "777/at_toga")
  end
end


--------------------------------------------------
-- Auto Adjust for A/C with more than 2 engines --
----------------------------------------------------

--function Champ2AxisToMultiEngine()
--  ChampNbEngines = get("sim/aircraft/engine/acf_num_engines")
--  logMsg(string.format("The number of engines is %i", ChampNbEngines))
--  if ChampNbEngines == 3 then
--    --set_axis_assignment(X55T_axis_R,"throttle 3","normal")
--    do_every_frame([[
--      Throttle1Pos = get("sim/cockpit2/engine/actuators/throttle_ratio",0)
--      Throttle3Pos = get("sim/cockpit2/engine/actuators/throttle_ratio",2)
--      CalculatedCenterThrottlePos = (Throttle1Pos + Throttle3Pos) / 2
--      set_array("sim/cockpit2/engine/actuators/throttle_ratio", 1, CalculatedCenterThrottlePos)
--    ]])
--  elseif ChampNbEngines == 4 then
--    --set_axis_assignment(X55T_axis_R,"throttle 4","normal")
--    do_every_frame([[
--      Throttle1Pos = get("sim/cockpit2/engine/actuators/throttle_ratio",0)
--      Throttle4Pos = get("sim/cockpit2/engine/actuators/throttle_ratio",3)
--      CalculatedCenterThrottlePos = (Throttle1Pos + Throttle4Pos) / 2
--      set_array("sim/cockpit2/engine/actuators/throttle_ratio", 1, CalculatedCenterThrottlePos)
--      set_array("sim/cockpit2/engine/actuators/throttle_ratio", 2, CalculatedCenterThrottlePos)
--    ]])
--  end
--end


function check_specific_datarefs()
  local ac_ready = false
  if PLANE_ICAO == "A320" then
    if XPLMFindCommand("a320/Panel/SidestickTakeoverL_button")   ~= nil and
       XPLMFindCommand("a320/Pedestal/EngineDisconnect1_button") ~= nil then
      ac_ready = true
    end
  elseif PLANE_ICAO == "B737" or PLANE_ICAO == "B738" or PLANE_ICAO == "B739" then
    if XPLMFindCommand("laminar/B738/autopilot/capt_disco_press")  ~= nil and
       XPLMFindCommand("laminar/B738/autopilot/left_at_dis_press") ~= nil and
       XPLMFindCommand("laminar/B738/autopilot/left_toga_press")   ~= nil then
      ac_ready = true
    end
  elseif PLANE_ICAO == "B762" or PLANE_ICAO == "B763" then
    if XPLMFindCommand("1-sim/comm/AP/ap_disc") ~= nil and
       XPLMFindCommand("1-sim/comm/AP/at_disc") ~= nil and
       XPLMFindCommand("1-sim/comm/AP/at_toga") ~= nil then
      ac_ready = true
    end
  elseif PLANE_ICAO == "B772" or PLANE_ICAO == "B77W" or PLANE_ICAO == "B77L" then
    if XPLMFindCommand("777/ap_disc") ~= nil and
       XPLMFindCommand("777/at_disc") ~= nil and
       XPLMFindCommand("777/at_toga") ~= nil then
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
      ChampAcSpecific()
      --Champ2AxisToMultiEngine()
      init_completed = true
    else
      draw_string_Helvetica_18(50, 500, "Waiting on ac specific commands/datarefs to be created!")
    end
  end
end

local init_completed = false

if init_completed == false then
  do_every_draw("monitor()")
else
  do_sometimes("monitor()")
end

logMsg("Champion Info: End of script")














