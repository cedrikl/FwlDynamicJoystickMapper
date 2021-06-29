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

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_saitek_tq" == device_DB.db[HID_device]["modu"])) then
    stq.map(device_DB.db[HID_device]["xpos"])
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

  set_axis_assignment(stq.axis_l, "throttle", "normal")
  set_axis_assignment(stq.axis_m, "prop",     "reverse")
  set_axis_assignment(stq.axis_r, "mixture",  "reverse")

end

----------------------------
-- Common Buttons Mapping --
----------------------------

function ChampComButtons()
  clear_all_button_assignments()

  set_button_assignment(scgl.A2           , "sim/autopilot/servos_off_any")
  set_button_assignment(scgl.A1_Up        , "sim/general/hat_switch_up")
  set_button_assignment(scgl.A1_Up_Right  , "sim/general/hat_switch_up_right")
  set_button_assignment(scgl.A1_Right     , "sim/general/hat_switch_right")
  set_button_assignment(scgl.A1_Down_Right, "sim/general/hat_switch_down_right")
  set_button_assignment(scgl.A1_Down      , "sim/general/hat_switch_down")
  set_button_assignment(scgl.A1_Down_Left , "sim/general/hat_switch_down_left")
  set_button_assignment(scgl.A1_Left      , "sim/general/hat_switch_left")
  set_button_assignment(scgl.A1_Up_Left   , "sim/general/hat_switch_up_left")
  set_button_assignment(scgl.B1           , "sim/view/default_view")
  set_button_assignment(scgl.D1           , "sim/view/circle")
  set_button_assignment(scgl.A3_Up        , "sim/flight_controls/pitch_trim_down")
  set_button_assignment(scgl.A3_Down      , "sim/flight_controls/pitch_trim_up")
  set_button_assignment(scgl.A3_Left      , "sim/flight_controls/rudder_trim_left")
  set_button_assignment(scgl.A3_Right     , "sim/flight_controls/rudder_trim_right")

  set_button_assignment(stq.T2,      "sim/flight_controls/brakes_toggle_max")
  set_button_assignment(stq.T5,      "sim/flight_controls/flaps_up")
  set_button_assignment(stq.T6,      "sim/flight_controls/flaps_down")
  set_button_assignment(stq.T3,      "sim/flight_controls/landing_gear_up")
  set_button_assignment(stq.T4,      "sim/flight_controls/landing_gear_down")
  set_button_assignment(stq.l_click, "sim/engines/thrust_reverse_toggle")
  set_button_assignment(stq.T1,      "sim/engines/thrust_reverse_toggle")

end


------------------------------
-- Specific Buttons Mapping --
------------------------------

function ChampAcSpecific()

  logMsg(string.format("Champion Info: Currently Detected A/C Type is %s", PLANE_ICAO))

  if (PLANE_ICAO == "B738") then
    set_button_assignment(scgl.A2,       "laminar/B738/autopilot/capt_disco_press")
    set_button_assignment(scgl.Trig_Fwd, "laminar/B738/autopilot/left_toga_press")
    set_button_assignment(scgl.Trig_Aft, "laminar/B738/autopilot/left_at_dis_press")
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
--------------------------------------------------

function ChampMultiEngine()
  ChampNbEngines = get("sim/aircraft/engine/acf_num_engines")
  logMsg(string.format("The number of engines is %i", ChampNbEngines))
  if ChampNbEngines == 3 then
    --set_axis_assignment(X55T_axis_R,"throttle 3","normal")
    do_every_frame([[
      Throttle1Pos = get("sim/cockpit2/engine/actuators/throttle_ratio",0)
      Throttle3Pos = get("sim/cockpit2/engine/actuators/throttle_ratio",2)
      CalculatedCenterThrottlePos = (Throttle1Pos + Throttle3Pos) / 2
      set_array("sim/cockpit2/engine/actuators/throttle_ratio", 1, CalculatedCenterThrottlePos)
    ]])
  elseif ChampNbEngines == 4 then
    --set_axis_assignment(X55T_axis_R,"throttle 4","normal")
    do_every_frame([[
      Throttle1Pos = get("sim/cockpit2/engine/actuators/throttle_ratio",0)
      Throttle4Pos = get("sim/cockpit2/engine/actuators/throttle_ratio",3)
      CalculatedCenterThrottlePos = (Throttle1Pos + Throttle4Pos) / 2
      set_array("sim/cockpit2/engine/actuators/throttle_ratio", 1, CalculatedCenterThrottlePos)
      set_array("sim/cockpit2/engine/actuators/throttle_ratio", 2, CalculatedCenterThrottlePos)
    ]])
  end
end

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
      ChampAcSpecific()
      --ChampMultiEngine()
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














