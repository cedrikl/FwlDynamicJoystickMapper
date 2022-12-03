logMsg("Champion Info: Start of script")

local device_DB = require("champ_joy_auto_detect")

rift      = require("champ_joy_rift")
reverbG2  = require("champ_joy_reverbG2")
pedals    = require("champ_joy_ChPedals")
yoke      = require("champ_joy_ChYoke")
x55j      = require("champ_joy_x55j")
TPR       = require("champ_joy_tpr")
vpcl      = require("champ_joy_cm3_aprime_l")
scgl      = require("champ_joy_scg_l")
stq       = require("champ_joy_saitek_tq")
afy       = require("champ_joy_alpha")
btq       = require("champ_joy_bravo")
btq_led   = require("champ_joy_bravo_leds")

require("champ_joy_bravo_A310_ini")
require("champ_joy_alpha_A320_FF")
require("champ_joy_bravo_A320_FF")
require("champ_joy_alpha_A321_toliss")
require("champ_joy_bravo_A321_toliss")
require("champ_joy_alpha_A330_JD")
require("champ_joy_bravo_A330_JD")
require("champ_joy_bravo_B350_airfoillabs")
require("champ_joy_alpha_B738_zibo")
require("champ_joy_bravo_B738_zibo")
require("champ_joy_alpha_B748_SSG")
require("champ_joy_bravo_B748_SSG")
require("champ_joy_alpha_B767_FF")
require("champ_joy_bravo_B767_FF")
require("champ_joy_alpha_B777_FF")
require("champ_joy_bravo_B777_FF")
require("champ_joy_alpha_C172_Carenado")
require("champ_joy_bravo_CL60_hotstart")
require("champ_joy_alpha_CRJ_AD")
require("champ_joy_bravo_CRJ_AD")
require("champ_joy_alpha_DH8D_FlyJSim")
require("champ_joy_bravo_DH8D_FlyJSim")
require("champ_joy_alpha_E195_SSG")
require("champ_joy_bravo_E195_SSG")
require("champ_joy_bravo_MD11_Rotate")
require("champ_joy_bravo_SF34_les")
require("champ_joy_alpha_TBM9_hotstart")
require("champ_joy_bravo_TBM9_hotstart")

ac_ready = false

function champ_set_axis_assignment(index, CommandRequested, ReverseOrNot)

  universalCommand = string.lower(CommandRequested)

      if (universalCommand == "none")                    then CommandWanted = "none"
  elseif (universalCommand == "pitch")                   then CommandWanted = "Pitch"
  elseif (universalCommand == "roll")                    then CommandWanted = "Roll"
  elseif (universalCommand == "yaw")                     then CommandWanted = "Yaw"
  elseif (universalCommand == "throttle")                then CommandWanted = "Throttle"
  elseif (universalCommand == "collective")              then CommandWanted = "Collective"
  elseif (universalCommand == "left toe brake")          then CommandWanted = "Left toe brake"
  elseif (universalCommand == "right toe brake")         then CommandWanted = "Right toe brake"
  elseif (universalCommand == "prop")                    then CommandWanted = "Prop"
  elseif (universalCommand == "mixture")                 then CommandWanted = "Mixture"
  elseif (universalCommand == "carb heat")               then CommandWanted = "Carb heat"
  elseif (universalCommand == "flaps")                   then CommandWanted = "Flaps"
  elseif (universalCommand == "thrust vector")           then CommandWanted = "Thrust vector"
  elseif (universalCommand == "wing sweep")              then CommandWanted = "Wing sweep"
  elseif (universalCommand == "speedbrakes")             then CommandWanted = "Speedbrakes"
  elseif (universalCommand == "displacement")            then CommandWanted = "Displacement"
  elseif (universalCommand == "reverse")                 then CommandWanted = "Reverse"
  elseif (universalCommand == "elevator trim")           then CommandWanted = "Elevator trim"
  elseif (universalCommand == "aileron trim")            then CommandWanted = "Aileron trim"
  elseif (universalCommand == "rudder trim")             then CommandWanted = "Rudder trim"
  elseif (universalCommand == "throttle 1")              then CommandWanted = "Throttle 1"
  elseif (universalCommand == "throttle 2")              then CommandWanted = "Throttle 2"
  elseif (universalCommand == "throttle 3")              then CommandWanted = "Throttle 3"
  elseif (universalCommand == "throttle 4")              then CommandWanted = "Throttle 4"
  elseif (universalCommand == "prop 1")                  then CommandWanted = "Prop 1"
  elseif (universalCommand == "prop 2")                  then CommandWanted = "Prop 2"
  elseif (universalCommand == "prop 3")                  then CommandWanted = "Prop 3"
  elseif (universalCommand == "prop 4")                  then CommandWanted = "Prop 4"
  elseif (universalCommand == "mixture 1")               then CommandWanted = "Mixture 1"
  elseif (universalCommand == "mixture 2")               then CommandWanted = "Mixture 2"
  elseif (universalCommand == "mixture 3")               then CommandWanted = "Mixture 3"
  elseif (universalCommand == "mixture 4")               then CommandWanted = "Mixture 4"
  elseif (universalCommand == "reverse 1")               then CommandWanted = "Reverse 1"
  elseif (universalCommand == "reverse 2")               then CommandWanted = "Reverse 2"
  elseif (universalCommand == "reverse 3")               then CommandWanted = "Reverse 3"
  elseif (universalCommand == "reverse 4")               then CommandWanted = "Reverse 4"
  elseif (universalCommand == "landing gear")            then CommandWanted = "Landing gear"
  elseif (universalCommand == "nosewheel tiller")        then CommandWanted = "Nosewheel tiller"
  elseif (universalCommand == "backup throttle")         then CommandWanted = "Backup throttle"
  elseif (universalCommand == "auto roll")               then CommandWanted = "Auto roll"
  elseif (universalCommand == "auto pitch")              then CommandWanted = "Auto pitch"
  elseif (universalCommand == "cowl flaps")              then CommandWanted = "Cowl flaps"
  elseif (universalCommand == "view left/right")         then CommandWanted = "View left/right"
  elseif (universalCommand == "view up/down")            then CommandWanted = "View up/down"
  elseif (universalCommand == "view zoom")               then CommandWanted = "View zoom"
  elseif (universalCommand == "camera left/right")       then CommandWanted = "Camera left/right"
  elseif (universalCommand == "camera up/down")          then CommandWanted = "Camera up/down"
  elseif (universalCommand == "camera zoom")             then CommandWanted = "Camera zoom"
  elseif (universalCommand == "gun/bomb left/right")     then CommandWanted = "Gun/bomb left/right"
  elseif (universalCommand == "gun/bomb up/down")        then CommandWanted = "Gun/bomb up/down"
  elseif (universalCommand == "vr touchpad x")           then CommandWanted = "VR Touchpad X"
  elseif (universalCommand == "vr touchpad y")           then CommandWanted = "VR Touchpad Y"
  elseif (universalCommand == "vr trigger")              then CommandWanted = "VR Trigger"
  elseif (universalCommand == "custom command(s)")       then CommandWanted = "Custom command(s)"
  elseif (universalCommand == "throttle 5")              then CommandWanted = "Throttle 5"
  elseif (universalCommand == "throttle 6")              then CommandWanted = "Throttle 6"
  elseif (universalCommand == "throttle 7")              then CommandWanted = "Throttle 7"
  elseif (universalCommand == "throttle 8")              then CommandWanted = "Throttle 8"
  elseif (universalCommand == "cowl flaps 1")            then CommandWanted = "Cowl flaps 1"
  elseif (universalCommand == "cowl flaps 2")            then CommandWanted = "Cowl flaps 2"
  elseif (universalCommand == "cowl flaps 3")            then CommandWanted = "Cowl flaps 3"
  elseif (universalCommand == "cowl flaps 4")            then CommandWanted = "Cowl flaps 4"
  elseif (universalCommand == "cowl flaps 5")            then CommandWanted = "Cowl flaps 5"
  elseif (universalCommand == "cowl flaps 6")            then CommandWanted = "Cowl flaps 6"
  elseif (universalCommand == "cowl flaps 7")            then CommandWanted = "Cowl flaps 7"
  elseif (universalCommand == "cowl flaps 8")            then CommandWanted = "Cowl flaps 8"
  elseif (universalCommand == "throttle vertical")       then CommandWanted = "Throttle Vertical"
  elseif (universalCommand == "throttle horizontal")     then CommandWanted = "Throttle Horizontal"
  elseif (universalCommand == "copilot pitch")           then CommandWanted = "Copilot Pitch"
  elseif (universalCommand == "copilot roll")            then CommandWanted = "Copilot Roll"
  elseif (universalCommand == "copilot yaw")             then CommandWanted = "Copilot Yaw"
  elseif (universalCommand == "copilot left toe brake")  then CommandWanted = "Copilot Left toe brake"
  elseif (universalCommand == "copilot right toe brake") then CommandWanted = "Copilot Right toe brake"
  end

  set_axis_assignment(index, CommandWanted, ReverseOrNot)
end

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
  --rift.map(6,7, true)
  --reverbG2.map(4,3, false)


  for HID_device = 1,device_DB.size,1
  do
    if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_tpr" == device_DB.db[HID_device]["modu"])) then
      TPR.map(device_DB.db[HID_device]["xpos"], device_DB.db[HID_device]["hidp"])
    end

    if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_cm3_aprime_l" == device_DB.db[HID_device]["modu"])) then
      vpcl.map(device_DB.db[HID_device]["xpos"], device_DB.db[HID_device]["hidp"])
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
  champ_set_axis_assignment(vpcl.axis_roll,   "Roll" ,           "normal")
  champ_set_axis_assignment(vpcl.axis_pitch,  "Pitch",           "normal")
  champ_set_axis_assignment(vpcl.axis_view_y, "View up/down",    "normal")
  champ_set_axis_assignment(vpcl.axis_view_x, "View left/right", "normal")

  champ_set_axis_assignment(TPR.yaw    , "Yaw"            , "normal")
  champ_set_axis_assignment(TPR.brake_l, "Left toe brake" , "reverse")
  champ_set_axis_assignment(TPR.brake_r, "Right toe brake", "reverse")

  champ_set_axis_assignment(btq.axis1,      "Speedbrakes", "normal")
  --champ_set_axis_assignment(btq.axis6,      "Flaps", "reverse")
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
  --rift.mapDefault()
  --reverbG2.mapDefault()

  set_button_assignment(vpcl.tr_button,      "sim/autopilot/servos_off_any")
  set_button_assignment(vpcl.br_hat_up,      "sim/flight_controls/pitch_trim_down")
  set_button_assignment(vpcl.br_hat_down,    "sim/flight_controls/pitch_trim_up")
  --set_button_assignment(vpcl.br_hat_left,    "sim/flight_controls/rudder_trim_left")
  --set_button_assignment(vpcl.br_hat_right,   "sim/flight_controls/rudder_trim_right")
  set_button_assignment(vpcl.side_hat_press, "SRS/X-Camera/Select_View_ID_1")
  set_button_assignment(vpcl.pinkie,         "SRS/X-Camera/Select_View_ID_6")
  set_button_assignment(vpcl.side_hat_up,    "sim/general/up_slow")
  set_button_assignment(vpcl.side_hat_down,  "sim/general/down_slow")
  set_button_assignment(vpcl.thb_hat_up,     "sim/general/forward_slow")
  set_button_assignment(vpcl.thb_hat_right,  "sim/general/right_slow")
  set_button_assignment(vpcl.thb_hat_down,   "sim/general/backward_slow")
  set_button_assignment(vpcl.thb_hat_left,   "sim/general/left_slow")
  set_button_assignment(vpcl.tl_hat_press,   "bgood/xchecklist/reload_checklist")
  set_button_assignment(vpcl.tl_hat_down,    "bgood/xchecklist/check_item")
  set_button_assignment(vpcl.tl_hat_up,      "bgood/xchecklist/toggle_checklist")
  set_button_assignment(vpcl.tl_hat_right,   "bgood/xchecklist/next_checklist")
  set_button_assignment(vpcl.tl_hat_left,    "bgood/xchecklist/prev_checklist")

  set_button_assignment(btq.flaps_up,        "sim/flight_controls/flaps_up")
  set_button_assignment(btq.flaps_dn,        "sim/flight_controls/flaps_down")
  set_button_assignment(btq.gear_up,         "sim/flight_controls/landing_gear_up")
  set_button_assignment(btq.gear_dn,         "sim/flight_controls/landing_gear_down")
  set_button_assignment(btq.trim_dn,         "sim/flight_controls/pitch_trim_down")
  set_button_assignment(btq.trim_up,         "sim/flight_controls/pitch_trim_up")
  if (("A321" ~= PLANE_ICAO) and ("A21N" ~= PLANE_ICAO) and ("B738" ~= PLANE_ICAO) and ("CL60" ~= PLANE_ICAO) and ("MD11" ~= PLANE_ICAO) and ("TBM9" ~= PLANE_ICAO)) then
    do_often([[
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
  do_often([[
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
  ap_disc_button = vpcl.tr_button

  if ((PLANE_ICAO == "A306") or (PLANE_ICAO == "A310")) then
    set_button_assignment(ap_disc_button, "A300/MCDU/yoke_ap_disconnect_captain")
    ChampBravoMapping_A310_ini()
  elseif (string.find(PLANE_ICAO, 'A3%w%w') or string.find(PLANE_ICAO, 'A2%wN')) then
    --Airbus Sidesticks
    --champ_set_axis_assignment(afy.axis_roll,  "none", "normal")
    --champ_set_axis_assignment(afy.axis_pitch, "none", "normal")
    --champ_set_axis_assignment(x55j.roll,  "roll", "normal")
    --champ_set_axis_assignment(x55j.pitch, "pitch", "normal")
    if ((PLANE_ICAO == "A319") or (PLANE_ICAO == "A321") or (PLANE_ICAO == "A21N")) then
      set_button_assignment(ap_disc_button, "toliss_airbus/ap_disc_left_stick")
      --ChampAlphaMapping_A321_toliss()
      ChampBravoMapping_A321_toliss()
    elseif (PLANE_ICAO == "A320") then
      set_button_assignment(ap_disc_button, "a320/Panel/SidestickTakeoverL_button")
      --ChampAlphaMapping_A320_FF()
      ChampBravoMapping_A320_FF()
    elseif (PLANE_ICAO == "A330") then
      set_button_assignment(ap_disc_button, "jd/ap/takeover")
      --ChampAlphaMapping_A330_JD()
      ChampBravoMapping_A330_JD()
    end
  elseif (PLANE_ICAO == "B738") then
    set_button_assignment(ap_disc_button, "laminar/B738/autopilot/capt_disco_press")
    --ChampAlphaMapping_B738_zibo()
    ChampBravoMapping_B738_zibo()
  elseif (PLANE_ICAO == "B38M") then
    --Ben hack for VAC, placeholder for future max which may not be zibo so keeping separate
    set_button_assignment(ap_disc_button, "laminar/B738/autopilot/capt_disco_press")
    --ChampAlphaMapping_B738_zibo()
    ChampBravoMapping_B738_zibo()
  elseif (PLANE_ICAO == "B748") then
    set_button_assignment(ap_disc_button,  "SSG/UFMC/AP_discon_Button")
    --ChampAlphaMapping_B748_SSG()
    ChampBravoMapping_B748_SSG()
  elseif (string.find(PLANE_ICAO, "B75%w") or string.find(PLANE_ICAO, "B76%w")) then
    set_button_assignment(ap_disc_button, "1-sim/comm/AP/ap_disc")
    --ChampAlphaMapping_B767_FF()
    ChampBravoMapping_B767_FF()
  elseif string.find(PLANE_ICAO, "B77%w") then
    set_button_assignment(ap_disc_button, "777/ap_disc")
    --ChampAlphaMapping_B777_FF()
    ChampBravoMapping_B777_FF()
  elseif (PLANE_ICAO == "B789") then
    --TBD
  elseif (PLANE_ICAO == "C172") then
    --SET ASSIGNMENT AP DISCONNECT
    --ChampAlphaMapping_C172_Carenado()
  elseif (PLANE_ICAO == "CL60") then
    ChampBravoMapping_CL60_hotstart()
    set_button_assignment(vpcl.tl_hat_down,  "CL650/checklist/check_item")
    set_button_assignment(vpcl.tl_hat_up,    "CL650/checklist/skip_item")
    set_button_assignment(vpcl.tl_hat_right, "CL650/checklist/next_checklist")
    set_button_assignment(vpcl.tl_hat_left,  "CL650/checklist/prev_checklist")
  elseif (PLANE_ICAO == "CRJ9") then
    set_button_assignment(ap_disc_button, "crj900/command/autopilot/ap_disc")
    --ChampAlphaMapping_CRJ_AD()
    ChampBravoMapping_CRJ_AD()
  elseif string.find(PLANE_ICAO, "DH8D") then
    set_button_assignment(ap_disc_button, "FJS/Q4XP/Autopilot/AUTOPILOT_DISCONNECT")
    set_button_assignment(vpcl.fliptrig_ctr,  "FJS/Q4XP/Autopilot/TCS_Engage")
    --ChampAlphaMapping_DH8D_FlyJSim()
    ChampBravoMapping_DH8D_FlyJSim()
  elseif ((PLANE_ICAO == "E170") or (PLANE_ICAO == "E195")) then
    --ChampAlphaMapping_E195_SSG()
    ChampBravoMapping_E195_SSG()
  elseif (PLANE_ICAO == "MD11") then
    set_button_assignment(ap_disc_button, "Rotate/aircraft/controls_c/ap_disc_l")
    --ChampAlphaMapping_TBM9_hotstart()
    ChampBravoMapping_MD11_Rotate()
  elseif (PLANE_ICAO == "TBM9") then
    --ChampAlphaMapping_TBM9_hotstart()
    ChampBravoMapping_TBM9_hotstart()
  elseif (PLANE_ICAO == "UH1") then
    --Nimbus UH1?
    --champ_set_axis_assignment(afy.axis_roll,  "none",  "normal")
    --champ_set_axis_assignment(afy.axis_pitch, "none",  "normal")
    --champ_set_axis_assignment(x55j.roll,       "roll",  "normal")
    --champ_set_axis_assignment(x55j.pitch,      "pitch", "normal")
  end
end


--------------------------
-- Specific LED Mapping --
--------------------------

-- We should always ensure the required datarefs exist before attempting to map
-- The associated function is check_specific_datarefs()

function ChampLedSpecificCheck()
  if     ((PLANE_ICAO == "A306") or (PLANE_ICAO == "A310"))                           then ChampBravoLed_A310_ini()
  elseif ((PLANE_ICAO == "A319") or (PLANE_ICAO == "A321") or (PLANE_ICAO == "A21N")) then ChampBravoLed_A321_toliss()
  elseif ((PLANE_ICAO == "A320"))                                                     then ChampBravoLed_A320_FF()
  elseif ((PLANE_ICAO == "B738"))                                                     then ChampBravoLed_B738_zibo()
  elseif ((PLANE_ICAO == "B38M"))                                                     then ChampBravoLed_B738_zibo()
  elseif (string.find(PLANE_ICAO, "B75%w") or string.find(PLANE_ICAO, "B76%w"))       then ChampBravoLed_B767_FF()
  elseif (string.find(PLANE_ICAO, "B77%w"))                                           then ChampBravoLed_B777_FF()
  elseif (string.find(PLANE_ICAO, "DH8D"))                                            then ChampBravoLed_DH8D_FlyJSim()
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
    if (ChampAlphaCheck_A321_toliss()                              and
        ChampBravoCheck_A321_toliss()                              and
        XPLMFindCommand("toliss_airbus/ap_disc_left_stick") ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "A320") then
    if (ChampAlphaCheck_A320_FF()                                      and
        ChampBravoCheck_A320_FF()                                      and
        XPLMFindCommand("a320/Panel/SidestickTakeoverL_button") ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "A330") then
    if (ChampAlphaCheck_A330_JD()                                      and
        ChampBravoCheck_A330_JD()                                      and
        XPLMFindCommand("jd/ap/takeover") ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "B738") then
    if (ChampBravoCheck_B738_zibo()                                       and
        XPLMFindCommand("laminar/B738/autopilot/capt_disco_press") ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "B38M") then
    if (ChampBravoCheck_B738_zibo()                                       and
        XPLMFindCommand("laminar/B738/autopilot/capt_disco_press") ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "B748") then
    if (ChampAlphaCheck_B748_SSG()                          and
        ChampBravoCheck_B748_SSG()                          and
        XPLMFindCommand("SSG/UFMC/AP_discon_Button") ~= nil
       ) then ac_ready = true
    end
  elseif (string.find(PLANE_ICAO, "B75%w") or string.find(PLANE_ICAO, "B76%w")) then
    if (ChampAlphaCheck_B767_FF()                       and
        ChampBravoCheck_B767_FF()                       and
        XPLMFindCommand("1-sim/comm/AP/ap_disc") ~= nil
       ) then ac_ready = true
    end
  elseif string.find(PLANE_ICAO, "B77%w") then
    if (ChampAlphaCheck_B777_FF()             and
        ChampBravoCheck_B777_FF()             and
        XPLMFindCommand("777/ap_disc") ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "C172") then
    if (--ChampAlphaCheck_C172_Carenado()                     ~= nil
        true
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "CL60") then
    if (ChampBravoCheck_CL60_hotstart()                   and
        XPLMFindCommand("CL650/checklist/check_item")     and
        XPLMFindCommand("CL650/checklist/skip_item")      and
        XPLMFindCommand("CL650/checklist/next_checklist") and
        XPLMFindCommand("CL650/checklist/prev_checklist") and
        true
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "CRJ9") then
    if (ChampAlphaCheck_CRJ_AD()             and
        ChampBravoCheck_CRJ_AD()             and
        XPLMFindCommand("crj900/command/autopilot/ap_disc") ~= nil
       ) then ac_ready = true
    end
  elseif string.find(PLANE_ICAO, "DH8D") then
    if (ChampAlphaCheck_DH8D_FlyJSim() and
        ChampBravoCheck_DH8D_FlyJSim() and
        XPLMFindCommand("FJS/Q4XP/Autopilot/AUTOPILOT_DISCONNECT") ~= nil and
        XPLMFindCommand("FJS/Q4XP/Autopilot/TCS_Engage")           ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "E195") then
    if (ChampAlphaCheck_E195_SSG()                          and
        ChampBravoCheck_E195_SSG()
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "MD11") then
    if (ChampBravoCheck_MD11_Rotate()                                  and
        XPLMFindCommand("Rotate/aircraft/controls_c/ap_disc_l") ~= nil
       ) then ac_ready = true
    end
  elseif (PLANE_ICAO == "TBM9") then
    if (ChampAlphaCheck_TBM9_hotstart()                          and
        ChampBravoCheck_TBM9_hotstart()
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
