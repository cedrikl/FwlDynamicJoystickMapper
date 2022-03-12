logMsg("Champion Info: Start of script")

local device_DB = require("champ_joy_auto_detect")

rift      = require("champ_joy_rift")
reverbG2  = require("champ_joy_reverbG2")
pedals    = require("champ_joy_ChPedals")
yoke      = require("champ_joy_ChYoke")
x55j      = require("champ_joy_x55j")
TPR       = require("champ_joy_tpr")
scgl      = require("champ_joy_scg_l")
stq       = require("champ_joy_saitek_tq")
afy       = require("champ_joy_alpha")
btq       = require("champ_joy_bravo")
btq_led   = require("champ_joy_bravo_leds")

require("champ_joy_bravo_A310_ini")
require("champ_joy_bravo_A320_FF")
require("champ_joy_bravo_A321_toliss")
require("champ_joy_bravo_B350_airfoillabs")
require("champ_joy_bravo_B738_zibo")
require("champ_joy_bravo_B767_FF")
require("champ_joy_bravo_B777_FF")
require("champ_joy_bravo_DH8D_FlyJSim")
require("champ_joy_bravo_SF34_les")
require("champ_joy_bravo_TBM9_hotstart")

ac_ready = false

function ChampInit()
  clear_all_axis_assignments()
  clear_all_button_assignments()

  -- AXIS    are in 25  blocks
  -- Buttons are in 160 blocks

  -- Declare a global instance of the DB in which we will publish the discovered device position from X-Plane Joystick Settings.prf

  device_DB.detect()

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
  --reverbG2.map(3,4, false)


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

    if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_alpha" == device_DB.db[HID_device]["modu"])) then
      afy.map(device_DB.db[HID_device]["xpos"], device_DB.db[HID_device]["hidp"])
    end

    if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_bravo" == device_DB.db[HID_device]["modu"])) then
      btq.map(device_DB.db[HID_device]["xpos"], device_DB.db[HID_device]["hidp"])
      btq.ap_panel_main()
    end
  end
end

-------------------------
-- Common Axis Mapping --
-------------------------

function ChampComAxis()
  set_axis_assignment(afy.axis_roll , "roll", "normal")
  set_axis_assignment(afy.axis_pitch, "pitch", "normal")

  set_axis_assignment(pedals.yaw    , "yaw", "normal")
  set_axis_assignment(pedals.brake_l, "left toe brake", "normal")
  set_axis_assignment(pedals.brake_r, "right toe brake", "normal")

  set_axis_assignment(btq.axis1,      "speedbrakes", "normal")
  set_axis_assignment(btq.axis6,      "flaps", "reverse")
end

---------------------------
-- Common Engine Mapping --
---------------------------

function ChampComEngine()
  ChampBravoEngine()
end

----------------------------
-- Common Buttons Mapping --
----------------------------

function ChampComButtons()
  rift.mapDefault()
  --reverbG2.mapDefault()

  set_button_assignment(afy.L_Hat_Up,      "sim/general/hat_switch_up")
  set_button_assignment(afy.L_Hat_UpRight, "sim/general/hat_switch_up_right")
  set_button_assignment(afy.L_Hat_Right,   "sim/general/hat_switch_right")
  set_button_assignment(afy.L_Hat_DnRight, "sim/general/hat_switch_down_right")
  set_button_assignment(afy.L_Hat_Dn,      "sim/general/hat_switch_down")
  set_button_assignment(afy.L_Hat_DnLeft,  "sim/general/hat_switch_down_left")
  set_button_assignment(afy.L_Hat_Left,    "sim/general/hat_switch_left")
  set_button_assignment(afy.L_Hat_UpLeft,  "sim/general/hat_switch_up_left")
  set_button_assignment(afy.L_Trim1Up,     "sim/flight_controls/pitch_trimA_up")
  set_button_assignment(afy.L_Trim1Dn,     "sim/flight_controls/pitch_trimA_down")
  set_button_assignment(afy.L_Trim2Up,     "sim/flight_controls/pitch_trimB_up")
  set_button_assignment(afy.L_Trim2Dn,     "sim/flight_controls/pitch_trimB_down")
  set_button_assignment(afy.L_WhiteBtn,    "sim/autopilot/servos_off_any")
  set_button_assignment(afy.R_Red_button, "sim/view/default_view")
  set_button_assignment(afy.R_WhiteBtn,   "sim/view/circle")
  set_button_assignment(afy.R_Trim1Left,  "sim/flight_controls/aileron_trim_left")
  set_button_assignment(afy.R_Trim1Right, "sim/flight_controls/aileron_trim_right")
  set_button_assignment(afy.R_Trim2Left,  "sim/flight_controls/rudder_trim_left")
  set_button_assignment(afy.R_Trim2Right, "sim/flight_controls/rudder_trim_right")

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
  --set_button_assignment(btq.trim_dn,        "sim/flight_controls/pitch_trim_down")
  --set_button_assignment(btq.trim_up,        "sim/flight_controls/pitch_trim_up")
  if (("B738" ~= PLANE_ICAO) and ("A321" ~= PLANE_ICAO) and ("A21N" ~= PLANE_ICAO)) then
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
  set_button_assignment(btq.sw2_up, "sim/ice/inlet_heat_on")
  set_button_assignment(btq.sw2_dn, "sim/ice/inlet_heat_off")
  set_button_assignment(btq.sw3_up, "sim/ice/wing_heat_on")
  set_button_assignment(btq.sw3_dn, "sim/ice/wing_heat_off")
  do_every_frame([[
    LightPos = get("sim/graphics/misc/white_flashlight_on")
    SwPos = button(]]..btq.sw4_up..[[)

    if (SwPos and (LightPos < 0.0001)) then
      command_once("sim/view/flashlight_wht")
    elseif (not(SwPos) and (LightPos > 0.9999)) then
      command_once("sim/view/flashlight_wht")
    end
  ]])
  set_button_assignment(btq.sw5_up, "sim/lights/strobe_lights_on")
  set_button_assignment(btq.sw5_dn, "sim/lights/strobe_lights_off")
  set_button_assignment(btq.sw6_up, "sim/lights/taxi_lights_on")
  set_button_assignment(btq.sw6_dn, "sim/lights/taxi_lights_off")
  set_button_assignment(btq.sw7_up, "sim/lights/landing_lights_on")
  set_button_assignment(btq.sw7_dn, "sim/lights/landing_lights_off")

  set_button_assignment(btq.ap_hdg, "sim/autopilot/heading")
  set_button_assignment(btq.ap_nav, "sim/autopilot/hdg_nav")
  set_button_assignment(btq.ap_apr, "sim/autopilot/approach")
  set_button_assignment(btq.ap_rev, "sim/autopilot/back_course")
  set_button_assignment(btq.ap_alt, "sim/autopilot/altitude_hold")
  set_button_assignment(btq.ap_vs, "sim/autopilot/vertical_speed")
  set_button_assignment(btq.ap_ias, "sim/autopilot/autothrottle_toggle")
  set_button_assignment(btq.ap_master, "sim/autopilot/servos_toggle")
end


------------------------------
-- Specific Buttons Mapping --
------------------------------

-- We should always ensure the required datarefs exist before attempting to map
-- The associated function is check_specific_datarefs()

function ChampAcSpecific()
  logMsg(string.format("Champion Info: Currently Detected A/C Type is %s", PLANE_ICAO))

  if ((PLANE_ICAO == "A306") or (PLANE_ICAO == "A310")) then
    set_button_assignment(afy.L_WhiteBtn,       "A300/MCDU/yoke_ap_disconnect_captain")
    ChampBravoMapping_A310_ini()
  elseif (string.find(PLANE_ICAO, 'A3%w%w') or string.find(PLANE_ICAO, 'A2%wN')) then
    --Airbus Sidesticks
    set_axis_assignment(afy.axis_roll,  "none", "normal")
    set_axis_assignment(afy.axis_pitch, "none", "normal")
    set_axis_assignment(x55j.roll,  "roll", "normal")
    set_axis_assignment(x55j.pitch, "pitch", "normal")
    if ((PLANE_ICAO == "A319") or (PLANE_ICAO == "A321") or (PLANE_ICAO == "A21N")) then
      set_button_assignment(x55j.V, "toliss_airbus/ap_disc_left_stick")
      ChampBravoMapping_A321_toliss()
    elseif (PLANE_ICAO == "A320") then
      --Flight Factor A320 Ultimate
      set_button_assignment(x55j.V, "a320/Panel/SidestickTakeoverL_button")
      ChampBravoMapping_A320_FF()
    elseif (PLANE_ICAO == "A330") then
      --TBD
    end
  elseif (PLANE_ICAO == "B738") then
    set_button_assignment(afy.L_WhiteBtn, "laminar/B738/autopilot/capt_disco_press")
    ChampBravoMapping_B738_zibo()
  elseif (PLANE_ICAO == "B38M") then
    --Ben hack for VAC, placeholder for future max which may not be zibo so keeping separate
    set_button_assignment(afy.L_WhiteBtn, "laminar/B738/autopilot/capt_disco_press")
    ChampBravoMapping_B738_zibo()
  elseif (PLANE_ICAO == "B748") then
    --SSG 747
    set_button_assignment(afy.L_WhiteBtn,  "SSG/UFMC/AP_discon_Button")
    --set_button_assignment(yoke.Sw_L_Dn, "SSG/UFMC/AP_ARM_AT_Switch")
    --set_button_assignment(yoke.Red_Dn,  "SSG/UFMC/TOGA_Button")
  elseif (string.find(PLANE_ICAO, "B75%w") or string.find(PLANE_ICAO, "B76%w")) then
    --Flight Factor 767
    set_button_assignment(yoke.Red_Up,  "1-sim/comm/AP/ap_disc")
    ChampBravoMapping_B767_FF()
  elseif string.find(PLANE_ICAO, "B77%w") then
    set_button_assignment(yoke.Red_Up,  "777/ap_disc")
    ChampBravoMapping_B777_FF()
  elseif (PLANE_ICAO == "B789") then
    --TBD
  elseif (PLANE_ICAO == "DH8D") then
    set_button_assignment(afy.L_WhiteBtn, "FJS/Q4XP/Autopilot/AUTOPILOT_DISCONNECT")
    --set_button_assignment(scgl.Trig_Aft, "FJS/Q4XP/Autopilot/TCS_Engage")
    ChampBravoMapping_DH8D_FlyJSim()
  elseif (PLANE_ICAO == "UH1") then
    --Nimbus UH1?
    set_axis_assignment(afy.axis_roll,  "none",  "normal")
    set_axis_assignment(afy.axis_pitch, "none",  "normal")

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
  if (PLANE_ICAO == "A306" or PLANE_ICAO == "A310")                                   then ChampBravoLed_A310_ini()
  elseif ((PLANE_ICAO == "A319") or (PLANE_ICAO == "A321") or (PLANE_ICAO == "A21N")) then ChampBravoLed_A321_toliss()
  elseif (PLANE_ICAO == "A320")                                                       then ChampBravoLed_A320_FF()
  elseif (PLANE_ICAO == "B738")                                                       then ChampBravoLed_B738_zibo()
  elseif (PLANE_ICAO == "B38M")                                                       then ChampBravoLed_B738_zibo()
  elseif (string.find(PLANE_ICAO, "B75%w") or string.find(PLANE_ICAO, "B76%w"))       then ChampBravoLed_B767_FF()
  elseif string.find(PLANE_ICAO, "B77%w")                                             then ChampBravoLed_B777_FF()
  elseif string.find(PLANE_ICAO, "DH8D")                                              then ChampBravoLed_DH8D_FlyJSim()
  end
end

---------------------------------
-- Specific Buttons Checks --
---------------------------------

-- We should always ensure the required datarefs exist before attempting to map them in ChampAcSpecific() and ChampLedSpecificCheck()

function check_specific_datarefs()

  if (PLANE_ICAO == "A306" or PLANE_ICAO == "A310") then
    if (ChampBravoCheck_A310_ini() and
        XPLMFindCommand("A300/MCDU/yoke_ap_disconnect_captain") ~= nil
       ) then ac_ready = true
    end
  elseif ((PLANE_ICAO == "A319") or (PLANE_ICAO == "A321") or (PLANE_ICAO == "A21N")) then
    if (ChampBravoCheck_A321_toliss()                                    and
        XPLMFindCommand("toliss_airbus/ap_disc_left_stick")   ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "A320") then
    if (ChampBravoCheck_A320_FF()                                        and
        XPLMFindCommand("a320/Panel/SidestickTakeoverL_button")   ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "B738") then 
    if (ChampBravoCheck_B738_zibo()                                        and
        XPLMFindCommand("laminar/B738/autopilot/capt_disco_press")  ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "B38M") then 
    if (ChampBravoCheck_B738_zibo()                                        and
        XPLMFindCommand("laminar/B738/autopilot/capt_disco_press")  ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "B748") then
    --SSG 747
    if (XPLMFindCommand("SSG/UFMC/AP_discon_Button") ~= nil and
        XPLMFindCommand("SSG/UFMC/AP_ARM_AT_Switch") ~= nil and
        XPLMFindCommand("SSG/UFMC/TOGA_Button")      ~= nil) then
      ac_ready = true
    end
  elseif (string.find(PLANE_ICAO, "B75%w") or string.find(PLANE_ICAO, "B76%w")) then
    if (ChampBravoCheck_B767_FF()                       and
        XPLMFindCommand("1-sim/comm/AP/ap_disc") ~= nil
       ) then ac_ready = true
    end
  elseif string.find(PLANE_ICAO, "B77%w") then
    if (ChampBravoCheck_B777_FF() and
        XPLMFindCommand("777/ap_disc") ~= nil
       ) then ac_ready = true
    end
  elseif string.find(PLANE_ICAO, "DH8D") then
    if (ChampBravoCheck_DH8D_FlyJSim() and
        XPLMFindCommand("FJS/Q4XP/Autopilot/AUTOPILOT_DISCONNECT") ~= nil and
        XPLMFindCommand("FJS/Q4XP/Autopilot/TCS_Engage")           ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "SF34") then
    if (ChampBravoCheck_SF34_les()
       ) then ac_ready = true
    end
  else
    ac_ready = true
  end
  return ac_ready
end


function utc_check()
  if (0 == get("sim/time/use_system_time")) then

    draw_string_Helvetica_10(10, 30, "Sim is not synced to real time!")
    draw_string_Helvetica_10(10, 20, string.format("Real time (UTC): %s", os.date("!%H:%M")))
    draw_string_Helvetica_10(10, 10, string.format("Sim time (UTC): %s", os.date("!%H:%M", get("sim/time/zulu_time_sec"))))
  end
end


function monitor()
  if not init_completed then
    if check_specific_datarefs() then
      ChampComAxis()
      ChampComButtons()
      ChampComEngine()
      ChampAcSpecific()
      btq_led.bravo_led_main()
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
do_every_draw("utc_check()")

logMsg("Champion Info: End of script")