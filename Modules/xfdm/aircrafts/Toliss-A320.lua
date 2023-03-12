require("xfdm.base")
require("xfdm.joysticks.honeycomb_bravo")

if string.find(PLANE_ICAO, "A319") or
   string.find(PLANE_ICAO, "A321") or
   string.find(PLANE_ICAO, "A21N") then


xfdm:requestConnector("eng_1_rev_toggle",              xfdmConOutSimCommand, "sim/engines/thrust_reverse_toggle_1")
xfdm:requestConnector("eng_2_rev_toggle",              xfdmConOutSimCommand, "sim/engines/thrust_reverse_toggle_2")
xfdm:requestConnector("eng_throttle_ratio",            xfdmConOutRoDataref, "toliss_airbus/joystick/throttle/rawLeverPos")
xfdm:requestConnector("throttle_beta_rev_ratio",       xfdmConOutRoDataref, "AirbusFBW/throttle_input")
xfdm:requestConnector("anti_ice_wing_on",              xfdmConOutSimCommand, "toliss_airbus/antiicecommands/WingOn")
xfdm:requestConnector("anti_ice_wing_off",             xfdmConOutSimCommand, "toliss_airbus/antiicecommands/WingOff")
xfdm:requestConnector("anti_ice_eng_on",               xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("anti_ice_eng_off",              xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("toliss_a320_anti_ice_eng1_pos", xfdmConOutRwDataref, "AirbusFBW/ENG1AISwitch")
xfdm:requestConnector("toliss_a320_anti_ice_eng2_pos", xfdmConOutRwDataref, "AirbusFBW/ENG2AISwitch")
xfdm:requestConnector("toliss_a320_anti_ice_eng1_on",  xfdmConOutSimCommand, "toliss_airbus/antiicecommands/ENG1On")
xfdm:requestConnector("toliss_a320_anti_ice_eng1_off", xfdmConOutSimCommand, "toliss_airbus/antiicecommands/ENG1Off")
xfdm:requestConnector("toliss_a320_anti_ice_eng2_on",  xfdmConOutSimCommand, "toliss_airbus/antiicecommands/ENG2On")
xfdm:requestConnector("toliss_a320_anti_ice_eng2_off", xfdmConOutSimCommand, "toliss_airbus/antiicecommands/ENG2Off")
function xfdm_set_anti_ice()
  local tEng1Pos = xfdm:readConnectorDest("toliss_a320_anti_ice_eng1_pos")
  local tEng2Pos = xfdm:readConnectorDest("toliss_a320_anti_ice_eng2_pos")
  local tSwPos = xfdm:readConnectorSrc("anti_ice_eng_on")

  if         (tSwPos  and (tEng1Pos ~= 1)) then xfdm:driveConnectorDest("toliss_a320_anti_ice_eng1_on")
  elseif (not(tSwPos) and (tEng1Pos == 1)) then xfdm:driveConnectorDest("toliss_a320_anti_ice_eng1_off")
  end
  
  if         (tSwPos  and (tEng2Pos ~= 1)) then xfdm:driveConnectorDest("toliss_a320_anti_ice_eng2_on")
  elseif (not(tSwPos) and (tEng2Pos == 1)) then xfdm:driveConnectorDest("toliss_a320_anti_ice_eng2_off")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_anti_ice()")


function xfdm_set_jet_reversers()
  -- Jets (Spoilers/ENG1/ENG2/ENG3/ENG4/Flaps)
  local tThrottle1Rev = xfdm:readConnectorSrc("bravo_axis_2_rev_handle")
  local tThrottle2Rev = xfdm:readConnectorSrc("bravo_axis_3_rev_handle")

  local tEng1LeverPos = xfdm:readConnectorDest("eng_throttle_ratio", 0)
  local tEng2LeverPos = xfdm:readConnectorDest("eng_throttle_ratio", 1)

  local tEng1Rev = xfdm:readConnectorDest("throttle_beta_rev_ratio", 0)
  local tEng2Rev = xfdm:readConnectorDest("throttle_beta_rev_ratio", 1)

  if         (tThrottle1Rev  and (tEng1Rev > -0.1)  and (tEng1LeverPos < 0.05)) then
    xfdm:driveConnectorDest("eng_1_rev_toggle")
  elseif (not(tThrottle1Rev) and (tEng1Rev <= -0.1) and (tEng1LeverPos < 0.05)) then
    xfdm:driveConnectorDest("eng_1_rev_toggle")
  end

  if         (tThrottle2Rev  and (tEng2Rev > -0.1)  and (tEng2LeverPos < 0.05)) then
    xfdm:driveConnectorDest("eng_2_rev_toggle")
  elseif (not(tThrottle2Rev) and (tEng2Rev <= -0.1) and (tEng2LeverPos < 0.05)) then
    xfdm:driveConnectorDest("eng_2_rev_toggle")
  end
end

xfdm:requestConnector("bravo_ap_button_hdg_short", xfdmConOutSimCommand, "AirbusFBW/PushHDGSel")
xfdm:requestConnector("bravo_ap_button_nav_short", xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_apr_short", xfdmConOutSimCommand, "AirbusFBW/APPRbutton")
xfdm:requestConnector("bravo_ap_button_rev_short", xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_alt_short", xfdmConOutSimCommand, "AirbusFBW/PushAltitude")
xfdm:requestConnector("bravo_ap_button_vs_short",  xfdmConOutSimCommand, "AirbusFBW/PushVSSel")
xfdm:requestConnector("bravo_ap_button_ias_short", xfdmConOutSimCommand, "AirbusFBW/PushSPDSel")
xfdm:requestConnector("bravo_ap_button_cmd_short", xfdmConOutSimCommand, "toliss_airbus/ap1_push")

xfdm:requestConnector("bravo_ap_button_hdg_long",  xfdmConOutSimCommand, "AirbusFBW/PullHDGSel")
xfdm:requestConnector("bravo_ap_button_nav_long",  xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_apr_long",  xfdmConOutSimCommand, "AirbusFBW/LOCbutton")
xfdm:requestConnector("bravo_ap_button_rev_long",  xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_alt_long",  xfdmConOutSimCommand, "AirbusFBW/PullAltitude")
xfdm:requestConnector("bravo_ap_button_vs_long",   xfdmConOutSimCommand, "AirbusFBW/PullVSSel")
xfdm:requestConnector("bravo_ap_button_ias_long",  xfdmConOutSimCommand, "AirbusFBW/PullSPDSel")
xfdm:requestConnector("bravo_ap_button_cmd_long",  xfdmConOutSimCommand, "toliss_airbus/ap2_push")

xfdm:requestConnector("bravo_ap_dial_crs_cw",    xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_dial_crs_ccw",   xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_dial_ver_cw",    xfdmConOutSimCommand, "sim/autopilot/vertical_speed_up")
xfdm:requestConnector("bravo_ap_dial_ver_ccw",   xfdmConOutSimCommand, "sim/autopilot/vertical_speed_down")

--BravoLights
xfdm:requestConnector("ap_hdg_mode", xfdmConOutRoDataref, "AirbusFBW/APLateralMode")
function xfdm.joysticks.honeycomb_bravo.leds:checkHdg()
  if (xfdm:readConnectorDest("ap_hdg_mode") == 101) then
    xfdm:driveConnectorDest("bravo_led_hdg", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_hdg", nil, 0)
  end
end

xfdm:requestConnector("ap_nav_mode", xfdmConOutRoDataref, "AirbusFBW/APLateralMode")
function xfdm.joysticks.honeycomb_bravo.leds:checkNav()
  if (xfdm:readConnectorDest("ap_nav_mode") == 2) then
    xfdm:driveConnectorDest("bravo_led_nav", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_nav", nil, 0)
  end
end

xfdm:requestConnector("ap_loc_mode", xfdmConOutRoDataref, "AirbusFBW/LOCilluminated")
xfdm:requestConnector("ap_apr_mode", xfdmConOutRoDataref, "AirbusFBW/APPRilluminated")
function xfdm.joysticks.honeycomb_bravo.leds:checkApr()
  if ((xfdm:readConnectorDest("ap_loc_mode") == 1) or
      (xfdm:readConnectorDest("ap_apr_mode") == 1)) then
    xfdm:driveConnectorDest("bravo_led_apr", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_apr", nil, 0)
  end
end

xfdm:requestConnector("ap_alt_mode", xfdmConOutRoDataref, "AirbusFBW/APVerticalMode")
function xfdm.joysticks.honeycomb_bravo.leds:checkApAlt()
  if ((xfdm:readConnectorDest("ap_alt_mode") == 2) or
      (xfdm:readConnectorDest("ap_alt_mode") == 101) or
      (xfdm:readConnectorDest("ap_alt_mode") == 102)) then
    xfdm:driveConnectorDest("bravo_led_alt", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_alt", nil, 0)
  end
end

function xfdm.joysticks.honeycomb_bravo.leds:checkApVs()
  if (xfdm:readConnectorDest("ap_alt_mode") == 107) then
    xfdm:driveConnectorDest("bravo_led_vs", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_vs", nil, 0)
  end
end

xfdm:requestConnector("ap_master1", xfdmConOutRoDataref, "AirbusFBW/AP1Engage")
xfdm:requestConnector("ap_master2", xfdmConOutRoDataref, "AirbusFBW/AP2Engage")
function xfdm.joysticks.honeycomb_bravo.leds:checkApMaster()
  if ((xfdm:readConnectorDest("ap_master1") == 1) or
      (xfdm:readConnectorDest("ap_master2") == 1)) then
    xfdm:driveConnectorDest("bravo_led_ap", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_ap", nil, 0)
  end
end

xfdm:requestConnector("toliss_a320_master_warning_status", xfdmConOutRoDataref, "AirbusFBW/MasterWarn")
function xfdm.joysticks.honeycomb_bravo.leds:checkMasterWarning()
  if (xfdm:readConnectorDest("toliss_a320_master_warning_status") == 1) then
    xfdm:driveConnectorDest("bravo_led_mwar", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_mwar", nil, 0)
  end
end

xfdm:requestConnector("toliss_a320_master_caution_status", xfdmConOutRoDataref, "AirbusFBW/MasterCaut")
function xfdm.joysticks.honeycomb_bravo.leds:checkMasterCaution()
  if (xfdm:readConnectorDest("toliss_a320_master_caution_status") == 1) then
    xfdm:driveConnectorDest("bravo_led_mcau", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_mcau", nil, 0)
  end
end

xfdm:requestConnector("toliss_a320_fire_eng1_ovh", xfdmConOutRoDataref, "ckpt/lamp/303")
xfdm:requestConnector("toliss_a320_fire_eng1_ped", xfdmConOutRoDataref, "ckpt/lamp/311")
xfdm:requestConnector("toliss_a320_fire_apu",      xfdmConOutRoDataref, "AirbusFBW/APUOnFire")
xfdm:requestConnector("toliss_a320_fire_eng2_ovh", xfdmConOutRoDataref, "ckpt/lamp/304")
xfdm:requestConnector("toliss_a320_fire_eng2_ped", xfdmConOutRoDataref, "ckpt/lamp/313")
function xfdm.joysticks.honeycomb_bravo.leds:checkFire()
  if ((xfdm:readConnectorDest("toliss_a320_fire_eng1_ovh") == 1) or
      (xfdm:readConnectorDest("toliss_a320_fire_eng1_ped") == 1) or
      (xfdm:readConnectorDest("toliss_a320_fire_apu") == 1) or
      (xfdm:readConnectorDest("toliss_a320_fire_eng2_ovh") == 1) or
      (xfdm:readConnectorDest("toliss_a320_fire_eng2_ped") == 1)
     ) then
    xfdm:driveConnectorDest("bravo_led_fire", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_fire", nil, 0)
  end
end

xfdm:requestConnector("toliss_a320_press_oil", xfdmConOutRoDataref, "AirbusFBW/ENGOilPressArray")
function xfdm.joysticks.honeycomb_bravo.leds:checkOil()
  if ((xfdm:readConnectorDest("toliss_a320_press_oil", 0) < 0.246) or
      (xfdm:readConnectorDest("toliss_a320_press_oil", 1) < 0.246)
     ) then
    xfdm:driveConnectorDest("bravo_led_oil", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_oil", nil, 0)
  end
end

xfdm:requestConnector("toliss_a320_press_hyd", xfdmConOutRoDataref, "AirbusFBW/HydSysPressArray")
function xfdm.joysticks.honeycomb_bravo.leds:checkHyd()
  if ((xfdm:readConnectorDest("toliss_a320_press_hyd", 0) < 1450.0) or
      (xfdm:readConnectorDest("toliss_a320_press_hyd", 1) < 1450.0) or
      (xfdm:readConnectorDest("toliss_a320_press_hyd", 2) < 1450.0)
     ) then
    xfdm:driveConnectorDest("bravo_led_hyd", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_hyd", nil, 0)
  end
end

--function xfdm.joysticks.honeycomb_bravo.leds:checkFuel()
--  if ((xfdm:readConnectorDest("annun_fuel_press", 0) == 1) or
--      (xfdm:readConnectorDest("annun_fuel_press", 1) == 1) or
--      (xfdm:readConnectorDest("annun_fuel_press", 2) == 1) or
--      (xfdm:readConnectorDest("annun_fuel_press", 3) == 1)
--     ) then
--    xfdm:driveConnectorDest("bravo_led_fuelp", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_fuelp", nil, 0)
--  end
--end
--
--function xfdm.joysticks.honeycomb_bravo.leds:checkPump()
--  if ((xfdm:readConnectorDest("annun_pump_l") == 1) or
--      (xfdm:readConnectorDest("annun_pump_r") == 1)
--    ) then
--    xfdm:driveConnectorDest("bravo_led_pump", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_pump", nil, 0)
--  end
--end

xfdm:requestConnector("toliss_a320_anti_ice_engine1_status", xfdmConOutRoDataref, "AirbusFBW/ENG1AILights")
xfdm:requestConnector("toliss_a320_anti_ice_engine2_status", xfdmConOutRoDataref, "AirbusFBW/ENG2AILights")
xfdm:requestConnector("toliss_a320_anti_ice_wing_status",    xfdmConOutRoDataref, "AirbusFBW/WAILights")
function xfdm.joysticks.honeycomb_bravo.leds:checkAntiIce()
  if ((xfdm:readConnectorDest("toliss_a320_anti_ice_engine1_status") >= 1) or
      (xfdm:readConnectorDest("toliss_a320_anti_ice_engine2_status") >= 1) or
      (xfdm:readConnectorDest("toliss_a320_anti_ice_wing_status") >= 1)
     ) then
    xfdm:driveConnectorDest("bravo_led_ice", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_ice", nil, 0)
  end
end

xfdm:requestConnector("toliss_a320_apu_starter_status",       xfdmConOutRwDataref, "AirbusFBW/APUStarter")
xfdm:requestConnector("toliss_a320_apu_starter_valve_status", xfdmConOutRoDataref, "AirbusFBW/StartValveArray")
xfdm:requestConnector("toliss_a320_apu_eng_mode_switch",      xfdmConOutRwDataref, "AirbusFBW/ENGModeSwitch")
function xfdm.joysticks.honeycomb_bravo.leds:checkStart()
  if ((xfdm:readConnectorDest("toliss_a320_apu_starter_status") == 1) or
      (xfdm:readConnectorDest("toliss_a320_apu_starter_valve_status", 0) == 1) or
      (xfdm:readConnectorDest("toliss_a320_apu_starter_valve_status", 1) == 1) or
      (xfdm:readConnectorDest("toliss_a320_apu_starter_valve_status", 2) == 1) or
      (xfdm:readConnectorDest("toliss_a320_apu_starter_valve_status", 3) == 1) or
      (xfdm:readConnectorDest("toliss_a320_apu_eng_mode_switch") < 0.1) or
      (xfdm:readConnectorDest("toliss_a320_apu_eng_mode_switch") > 1.9)
     ) then
    xfdm:driveConnectorDest("bravo_led_start", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_start", nil, 0)
  end
end

xfdm:requestConnector("toliss_a320_batt_volts", xfdmConOutRoDataref, "AirbusFBW/BatVolts")
function xfdm.joysticks.honeycomb_bravo.leds:checkBat()
  if ((xfdm:readConnectorDest("toliss_a320_batt_volts", 0) < 25.0) or
      (xfdm:readConnectorDest("toliss_a320_batt_volts", 1) < 25.0)
     ) then
    xfdm:driveConnectorDest("bravo_led_batt", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_batt", nil, 0)
  end
end

xfdm:requestConnector("toliss_a320_apu_master", xfdmConOutRwDataref, "AirbusFBW/APUMaster")
function xfdm.joysticks.honeycomb_bravo.leds:checkApu()
  if (xfdm:readConnectorDest("toliss_a320_apu_master") == 1) then
    xfdm:driveConnectorDest("bravo_led_apu", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_apu", nil, 0)
  end
end

xfdm:requestConnector("toliss_a320_door_cargo", xfdmConOutRoDataref, "AirbusFBW/CargoDoorArray")
xfdm:requestConnector("toliss_a320_door_pax",   xfdmConOutRoDataref, "AirbusFBW/PaxDoorArray")
function xfdm.joysticks.honeycomb_bravo.leds:checkDoor()
  if ((xfdm:readConnectorDest("toliss_a320_door_cargo", 0) > 0.1) or
      (xfdm:readConnectorDest("toliss_a320_door_cargo", 1) > 0.1) or
      (xfdm:readConnectorDest("toliss_a320_door_cargo", 2) > 0.1) or
      (xfdm:readConnectorDest("toliss_a320_door_cargo", 3) > 0.1) or
      (xfdm:readConnectorDest("toliss_a320_door_pax",   0) > 0.1) or
      (xfdm:readConnectorDest("toliss_a320_door_pax",   1) > 0.1) or
      (xfdm:readConnectorDest("toliss_a320_door_pax",   2) > 0.1) or
      (xfdm:readConnectorDest("toliss_a320_door_pax",   3) > 0.1) or
      (xfdm:readConnectorDest("toliss_a320_door_pax",   4) > 0.1) or
      (xfdm:readConnectorDest("toliss_a320_door_pax",   5) > 0.1) or
      (xfdm:readConnectorDest("toliss_a320_door_pax",   6) > 0.1) or
      (xfdm:readConnectorDest("toliss_a320_door_pax",   7) > 0.1)
  ) then
    xfdm:driveConnectorDest("bravo_led_door", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_door", nil, 0)
  end
end

xfdm:requestConnector("toliss_a320_ElecOHPArray", xfdmConOutRwDataref, "AirbusFBW/ElecOHPArray")
function xfdm.joysticks.honeycomb_bravo.leds:checkPower()
  if( (
        (xfdm:readConnectorDest("toliss_a320_ElecOHPArray", 5) == 0) or
        (xfdm:readConnectorDest("toliss_a320_ElecOHPArray", 6) == 0)
      ) and (xfdm:readConnectorDest("toliss_a320_ElecOHPArray", 3) == 0)
    ) then self.raw = 0
  end
end

end