-- Script to map 1 button to different assignments based on aircraft

--Rift cannot be auto mapped but 
local rift      = require("champ_joy_rift")
local pedals    = require("champ_joy_ChPedals")
local yoke      = require("champ_joy_ChYoke")
local throttles = require("champ_joy_ChThrottleQuadrant")
local x55t      = require("champ_joy_x55t")
local x55j      = require("champ_joy_x55j")
local btq       = require("champ_joy_bravo")
--Old manual mapping
--x55t.map(2)
--x55j.map(4)
--throttles.map(8)
--yoke.map(9)
--pedals.map(10)

--Rift controllers must be manually mapped as they do not appear as a USB device to X-Plane.
--find their position by searching <X-Plane Directory>\Output\preferences\X-Plane Joystick Settings.prf
--find the lines starting with _joy_location
--the oculus rift will be obvious, use the id as such, see example:
--_joy_location5 vr/Oculus/oculus_Left/WMHD315R200HC9_Controller_Left/none
--_joy_location6 vr/Oculus/oculus_Right/WMHD315R200HC9_Controller_Right/none
--thus the left controller is as positon 5 (_joy_location5) and the right controller is at position 6 (_joy_location6)
rift.map(5,6)



for HID_device = 1,device_DB.size,1
do
  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_x55t" == device_DB.db[HID_device]["modu"])) then
    x55t.map(device_DB.db[HID_device]["xpos"])
  end

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_x55j" == device_DB.db[HID_device]["modu"])) then
    x55j.map(device_DB.db[HID_device]["xpos"])
  end

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_ChThrottleQuadrant" == device_DB.db[HID_device]["modu"])) then
    throttles.map(device_DB.db[HID_device]["xpos"])
  end

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_ChYoke" == device_DB.db[HID_device]["modu"])) then
    yoke.map(device_DB.db[HID_device]["xpos"])
  end

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_ChPedals" == device_DB.db[HID_device]["modu"])) then
    pedals.map(device_DB.db[HID_device]["xpos"])
  end

  if (nil ~= (device_DB.db[HID_device]["xpos"]) and ("champ_joy_bravo" == device_DB.db[HID_device]["modu"])) then
    bravo.map(device_DB.db[HID_device]["xpos"])
  end
end


--------------------------
-- Common Axis Mapping --
--------------------------

function ChampComAxis()
  clear_all_axis_assignments()

  set_axis_assignment(yoke.axis_roll , "roll"   , "normal")
  set_axis_assignment(yoke.axis_pitch, "pitch"  , "normal")
  set_axis_assignment(yoke.axis_2    , "prop"   , "reverse")
  set_axis_assignment(yoke.axis_3    , "mixture", "reverse")

  set_axis_assignment(throttles.axis_1, "speedbrakes", "normal")
  set_axis_assignment(throttles.axis_2, "throttle 1" , "normal")
  set_axis_assignment(throttles.axis_3, "throttle 2" , "normal")
  set_axis_assignment(throttles.axis_4, "throttle 3" , "normal")
  set_axis_assignment(throttles.axis_5, "throttle 4" , "normal")
  set_axis_assignment(throttles.axis_6, "flaps"      , "normal")

  set_axis_assignment(pedals.yaw    , "yaw"            , "normal")
  set_axis_assignment(pedals.brake_l, "left toe brake" , "normal")  
  set_axis_assignment(pedals.brake_r, "right toe brake", "normal")

end


----------------------------
-- Common Buttons Mapping --
----------------------------

function ChampComButtons()
  clear_all_button_assignments()

  set_button_assignment(yoke.Red_Up   , "sim/autopilot/servos_off_any")
  set_button_assignment(yoke.Red_Dn   , "sim/engines/TOGA_power")
  set_button_assignment(yoke.Hat_Up   , "sim/general/hat_switch_up")
  set_button_assignment(yoke.Hat_UpR  , "sim/general/hat_switch_up_right")
  set_button_assignment(yoke.Hat_R    , "sim/general/hat_switch_right")
  set_button_assignment(yoke.Hat_DnR  , "sim/general/hat_switch_down_right")
  set_button_assignment(yoke.Hat_Dn   , "sim/general/hat_switch_down")
  set_button_assignment(yoke.Hat_DnL  , "sim/general/hat_switch_down_left")
  set_button_assignment(yoke.Hat_L    , "sim/general/hat_switch_left")
  set_button_assignment(yoke.Hat_UpL  , "sim/general/hat_switch_up_left")
  set_button_assignment(yoke.Vert_Up  , "sim/flight_controls/pitch_trim_down")
  set_button_assignment(yoke.Verd_Dn  , "sim/flight_controls/pitch_trim_up")
  set_button_assignment(yoke.Hor_Left , "sim/flight_controls/rudder_trim_left")
  set_button_assignment(yoke.Hor_Right, "sim/flight_controls/rudder_trim_right")
  set_button_assignment(yoke.Sw_R_Up  , "sim/flight_controls/speed_brakes_up_one")
  set_button_assignment(yoke.Sw_L_Up  , "sim/view/circle")
  set_button_assignment(yoke.Sw_R_Dn  , "sim/flight_controls/brakes_toggle_max")

  set_button_assignment(x55j.pov_0    , "sim/general/hat_switch_up")
  set_button_assignment(x55j.pov_45   , "sim/general/hat_switch_up_right")
  set_button_assignment(x55j.pov_90   , "sim/general/hat_switch_right")
  set_button_assignment(x55j.pov_135  , "sim/general/hat_switch_down_right")
  set_button_assignment(x55j.pov_180  , "sim/general/hat_switch_down")
  set_button_assignment(x55j.pov_225  , "sim/general/hat_switch_down_left")
  set_button_assignment(x55j.pov_270  , "sim/general/hat_switch_left")
  set_button_assignment(x55j.pov_315  , "sim/general/hat_switch_up_left")

  set_button_assignment(x55j.D		  , "sim/view/default_view")
  set_button_assignment(x55j.H2_0	  , "sim/view/linear_spot")
  set_button_assignment(x55j.H2_90	  , "sim/view/chase")
  set_button_assignment(x55j.H2_180	  , "sim/view/circle")
  set_button_assignment(x55j.H2_270	  , "sim/view/free_camera")
  
  set_button_assignment(x55t.K1_up	  , "sim/engines/thrust_reverse_toggle")


end

function ChampOculusRift()
  set_axis_assignment(rift.L_Joy_X     , "VR Touchpad X"  , "normal")
  set_axis_assignment(rift.L_Joy_Y     , "VR Touchpad Y"  , "normal")
  set_axis_assignment(rift.L_Joy_Index , "VR Trigger"     , "normal")
  
  set_axis_assignment(rift.R_Joy_X     , "VR Touchpad X"  , "normal")
  set_axis_assignment(rift.R_Joy_Y     , "VR Touchpad Y"  , "normal")
  set_axis_assignment(rift.R_Joy_Index , "VR Trigger"     , "normal")
  
  set_button_assignment(rift.L_Y       , "sim/VR/reserved/menu")
  set_button_assignment(rift.L_X       , "sim/VR/general/reset_view")
  set_button_assignment(rift.L_Touchpad, "sim/VR/reserved/touchpad")
  set_button_assignment(rift.L_Index   , "sim/VR/reserved/select")
  
  set_button_assignment(rift.R_Y       , "sim/VR/reserved/menu")
  set_button_assignment(rift.R_X       , "sim/VR/quick_zoom_view")
  set_button_assignment(rift.R_Touchpad, "sim/VR/reserved/touchpad")
  set_button_assignment(rift.R_Index   , "sim/VR/reserved/select")
end

------------------------------
-- Specific Buttons Mapping --
------------------------------

function ChampAcSpecific()

logMsg(string.format("champion info: plane icao is %s", PLANE_ICAO))
  
  if (PLANE_ICAO == "B737" or PLANE_ICAO == "B738" or PLANE_ICAO == "B739") then
    set_button_assignment(throttles.b2_Dn, "sim/engines/thrust_reverse_toggle")
	set_button_assignment(yoke.Red_Up  , "laminar/B738/autopilot/capt_disco_press")
    set_button_assignment(yoke.Sw_L_Dn , "laminar/B738/autopilot/left_at_dis_press")
    set_button_assignment(yoke.Red_Dn  , "laminar/B738/autopilot/left_toga_press")

  elseif (PLANE_ICAO == "B762" or PLANE_ICAO == "B763") then
    
	set_button_assignment(yoke.Red_Up  , "1-sim/comm/AP/ap_disc")
    set_button_assignment(yoke.Sw_L_Dn , "1-sim/comm/AP/at_disc")
    set_button_assignment(yoke.Red_Dn  , "1-sim/comm/AP/at_toga")
	set_button_assignment(throttles.b2_Dn, "sim/engines/thrust_reverse_toggle")
    set_axis_assignment(throttles.axis_1, "speedbrakes", "reverse")

  elseif (PLANE_ICAO == "A319" or PLANE_ICAO == "A320" or PLANE_ICAO == "A330") then
    set_axis_assignment(yoke.axis_roll  , "none"  , "normal")
    set_axis_assignment(yoke.axis_pitch , "none"  , "normal")
    set_axis_assignment(yoke.axis_2     , "none"  , "reverse")
    set_axis_assignment(yoke.axis_3     , "none"  , "reverse")
    set_axis_assignment(throttles.axis_1, "none", "normal")
    set_axis_assignment(throttles.axis_2, "none", "normal")
    set_axis_assignment(throttles.axis_3, "none", "normal")
    set_axis_assignment(throttles.axis_4, "none", "normal")
    set_axis_assignment(throttles.axis_5, "none", "normal")
    set_axis_assignment(throttles.axis_6, "none", "normal")

    set_axis_assignment(x55j.roll  , "roll"  , "normal")
    set_axis_assignment(x55j.pitch , "pitch"  , "normal")
    set_axis_assignment(x55t.axis_L, "throttle 1", "normal")
    set_axis_assignment(x55t.axis_R, "throttle 2", "normal")

	set_button_assignment(x55t.E , "sim/autopilot/take_off_go_around")
	set_button_assignment(x55t.SW3, "sim/flight_controls/speed_brakes_up_one")
    set_button_assignment(x55t.SW4, "sim/flight_controls/speed_brakes_down_one")
    set_button_assignment(x55t.SW5, "sim/flight_controls/flaps_up")
    set_button_assignment(x55t.SW6, "sim/flight_controls/flaps_down")
    
    
    if (PLANE_ICAO == "A319") then
     set_button_assignment(x55j.V, "toliss_airbus/ap_disc_left_stick")
     set_button_assignment(throttles.b3_Dn, "AirbusFBW/PushSPDSel")
     set_button_assignment(throttles.b3_Up, "AirbusFBW/PullSPDSel")
     set_button_assignment(throttles.b4_Dn, "AirbusFBW/PushHDGSel")
     set_button_assignment(throttles.b4_Up, "AirbusFBW/PullHDGSel")
     set_button_assignment(throttles.b5_Dn, "AirbusFBW/PushAltitude")
     set_button_assignment(throttles.b5_Up, "AirbusFBW/PullAltitude")
     set_button_assignment(throttles.b6_Dn, "AirbusFBW/PushVSSel")
     set_button_assignment(throttles.b6_Up, "AirbusFBW/PullVSSel")
     set_button_assignment(x55t.SW2, "toliss_airbus/park_brake_toggle")
    
    
    elseif (PLANE_ICAO == "A320") then
      set_button_assignment(x55j.pinkytrig  , "sim/flight_controls/landing_gear_toggle")
	  set_button_assignment(x55j.V  , "a320/Panel/SidestickTakeoverL_button")
      set_button_assignment(throttles.b1_Up, "a320/Panel/EFIS_BaroModeL_switch_pull")
      set_button_assignment(throttles.b1_Dn, "a320/Panel/EFIS_BaroModeL_switch_push")
      set_button_assignment(throttles.b3_Up, "a320/Panel/FCU_SpeedMode_switch_pull")
      set_button_assignment(throttles.b3_Dn, "a320/Panel/FCU_SpeedMode_switch_push")
      set_button_assignment(throttles.b4_Up, "a320/Panel/FCU_LateralMode_switch_pull")
      set_button_assignment(throttles.b4_Dn, "a320/Panel/FCU_LateralMode_switch_push")
      set_button_assignment(throttles.b5_Up, "a320/Panel/FCU_AltitudeMode_switch_pull")
      set_button_assignment(throttles.b5_Dn, "a320/Panel/FCU_AltitudeMode_switch_push")
      set_button_assignment(throttles.b6_Up, "a320/Panel/FCU_VerticalMode_switch_pull")
      set_button_assignment(throttles.b6_Dn, "a320/Panel/FCU_VerticalMode_switch_push")
    
	elseif (PLANE_ICAO == "A330") then
	  set_button_assignment(throttles.b1_Up, "a320/Panel/EFIS_BaroModeL_switch_pull")
      set_button_assignment(throttles.b1_Dn, "a320/Panel/EFIS_BaroModeL_switch_push")
      set_button_assignment(throttles.b3_Up, "a320/Panel/FCU_SpeedMode_switch_pull")
      set_button_assignment(throttles.b3_Dn, "a320/Panel/FCU_SpeedMode_switch_push")
      set_button_assignment(throttles.b4_Up, "a320/Panel/FCU_LateralMode_switch_pull")
      set_button_assignment(throttles.b4_Dn, "a320/Panel/FCU_LateralMode_switch_push")
      set_button_assignment(throttles.b5_Up, "a320/Panel/FCU_AltitudeMode_switch_pull")
      set_button_assignment(throttles.b5_Dn, "sim/autopilot/altitude_arm")
      set_button_assignment(throttles.b6_Up, "a320/Panel/FCU_VerticalMode_switch_pull")
      set_button_assignment(throttles.b6_Dn, "a320/Panel/FCU_VerticalMode_switch_push")
    end
  
	elseif (PLANE_ICAO == "B772" or PLANE_ICAO == "B77W" or PLANE_ICAO == "B77L") then
      set_axis_assignment(throttles.axis_1, "speedbrakes", "reverse")
	  set_button_assignment(yoke.Red_Up   , "777/ap_disc")
      set_button_assignment(yoke.Sw_L_Dn  , "777/at_disc")
      set_button_assignment(yoke.Red_Dn   , "777/at_toga")
	  set_button_assignment(throttles.b2_Dn, "sim/engines/thrust_reverse_toggle")

	elseif (PLANE_ICAO == "B748") then
      set_axis_assignment(throttles.axis_1, "speedbrakes", "reverse")
	  set_button_assignment(yoke.Red_Up   , "SSG/UFMC/AP_discon_Button")
      set_button_assignment(yoke.Sw_L_Dn  , "SSG/UFMC/AP_ARM_AT_Switch")
      set_button_assignment(yoke.Red_Dn   , "SSG/UFMC/TOGA_Button")
	  set_button_assignment(throttles.b2_Dn, "sim/engines/thrust_reverse_toggle")
	  set_button_assignment(throttles.b6_Up, "SSG/Gear/Handle_up")
	  set_button_assignment(throttles.b6_Dn, "SSG/Gear/Handle_Down")
	  

	elseif (PLANE_ICAO == "B789") then
      set_axis_assignment(throttles.axis_1, "speedbrakes", "reverse")
      set_button_assignment(throttles.b2_Dn, "sim/engines/thrust_reverse_toggle")
	
	
	elseif (PLANE_ICAO == "UH1") then
	  set_axis_assignment(yoke.axis_roll  , "none"  , "normal")
      set_axis_assignment(yoke.axis_pitch , "none"  , "normal")
      set_axis_assignment(yoke.axis_2     , "none"  , "reverse")
      set_axis_assignment(yoke.axis_3     , "none"  , "reverse")
      set_axis_assignment(throttles.axis_1, "none", "normal")
      set_axis_assignment(throttles.axis_2, "none", "normal")
      set_axis_assignment(throttles.axis_3, "none", "normal")
      set_axis_assignment(throttles.axis_4, "none", "normal")
      set_axis_assignment(throttles.axis_5, "none", "normal")
      set_axis_assignment(throttles.axis_6, "none", "normal")

	  set_axis_assignment(x55j.roll  , "roll"  , "normal")
      set_axis_assignment(x55j.pitch , "pitch"  , "normal")
      set_axis_assignment(x55t.axis_L, "collective", "reverse")
	  set_axis_assignment(x55t.axis_F, "throttle", "reverse")
      set_button_assignment(x55t.E, "nimbus/UH-1/command/start_up_command")
	  
	end
end


function check_specific_datarefs()
  local ac_ready = false
  if PLANE_ICAO == "A320" then
    if XPLMFindCommand("a320/Panel/SidestickTakeoverL_button")    ~= nil and
       XPLMFindCommand("a320/Pedestal/EngineDisconnect1_button")  ~= nil and
       XPLMFindCommand("a320/Panel/EFIS_BaroModeL_switch_pull")   ~= nil and
       XPLMFindCommand("a320/Panel/EFIS_BaroModeL_switch_push")   ~= nil and
       XPLMFindCommand("a320/Panel/FCU_SpeedMode_switch_pull")    ~= nil and
       XPLMFindCommand("a320/Panel/FCU_SpeedMode_switch_push")    ~= nil and
       XPLMFindCommand("a320/Panel/FCU_LateralMode_switch_pull")  ~= nil and
       XPLMFindCommand("a320/Panel/FCU_LateralMode_switch_push")  ~= nil and
       XPLMFindCommand("a320/Panel/FCU_AltitudeMode_switch_pull") ~= nil and
       XPLMFindCommand("a320/Panel/FCU_AltitudeMode_switch_push") ~= nil and
       XPLMFindCommand("a320/Panel/FCU_VerticalMode_switch_pull") ~= nil and
       XPLMFindCommand("a320/Panel/FCU_VerticalMode_switch_push") ~= nil then
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
      init_completed = true
      ChampComAxis()
      ChampComButtons()
      ChampOculusRift()
      ChampAcSpecific()
    else
      do_every_draw('draw_string_Helvetica_18(50, 500, "Waiting on ac specific commands/datarefs to be created!")')
    end
  end
end

local init_completed = false

if init_completed == false then
  do_every_draw("monitor()")
else
  do_sometimes("monitor()")
end