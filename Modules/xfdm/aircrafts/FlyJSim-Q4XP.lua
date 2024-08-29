require("xfdm.base")
require("xfdm.joysticks.honeycomb_bravo")

if string.find(PLANE_ICAO, "DH8D") then

xfdm:requestConnector("bravo_ap_dial_ias_cw",    xfdmConOutSimCommand, "FJS/Q4XP/Autopilot/WheelDN")
xfdm:requestConnector("bravo_ap_dial_ias_ccw",   xfdmConOutSimCommand, "FJS/Q4XP/Autopilot/WheelUP")
xfdm:requestConnector("bravo_ap_dial_ver_cw",    xfdmConOutSimCommand, "FJS/Q4XP/Autopilot/WheelDN")
xfdm:requestConnector("bravo_ap_dial_ver_ccw",   xfdmConOutSimCommand, "FJS/Q4XP/Autopilot/WheelUP")
xfdm:requestConnector("bravo_ap_dial_crs_cw",    xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_dial_crs_ccw",   xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("q4xp_crs_pos",            xfdmConOutRwDataref,  "sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot")
function xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_crs_cw(iCount)
  local tCrsPos = xfdm:readConnectorDest("q4xp_crs_pos")
  local tValue = (tCrsPos + iCount) % 360
  logMsg(tValue)
  xfdm:driveConnectorDest("q4xp_crs_pos", nil, tValue)
end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_crs_ccw(iCount)  xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_crs_cw(iCount * -1) end

--Acceleration Tuning
xfdm.joysticks.honeycomb_bravo.sAccelThreshold  = 3
xfdm.joysticks.honeycomb_bravo.sAccelMultiplier = 2
xfdm.joysticks.honeycomb_bravo.sAccelMaxMultiplier = 20

xfdm:requestConnector("bravo_ap_button_hdg_short", xfdmConOutSimCommand, "FJS/Q4XP/SoftKey/ap_hdg")
xfdm:requestConnector("bravo_ap_button_nav_short", xfdmConOutSimCommand, "FJS/Q4XP/SoftKey/ap_nav")
xfdm:requestConnector("bravo_ap_button_apr_short", xfdmConOutSimCommand, "FJS/Q4XP/SoftKey/ap_appr")
xfdm:requestConnector("bravo_ap_button_rev_short", xfdmConOutSimCommand, "FJS/Q4XP/SoftKey/ap_bc")
xfdm:requestConnector("bravo_ap_button_alt_short", xfdmConOutSimCommand, "FJS/Q4XP/SoftKey/ap_altsel")
xfdm:requestConnector("bravo_ap_button_vs_short",  xfdmConOutSimCommand, "FJS/Q4XP/SoftKey/ap_vs")
xfdm:requestConnector("bravo_ap_button_ias_short", xfdmConOutRwDataref,  xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_cmd_short", xfdmConOutSimCommand, "FJS/Q4XP/SoftKey/ap_ap")

xfdm:requestConnector("bravo_ap_button_hdg_long",  xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_nav_long",  xfdmConOutSimCommand, "FJS/Q4XP/SoftKey/ap_vnav")
xfdm:requestConnector("bravo_ap_button_apr_long",  xfdmConOutRwDataref,  xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_rev_long",  xfdmConOutRwDataref,  xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_alt_long",  xfdmConOutSimCommand, "FJS/Q4XP/SoftKey/ap_alt")
xfdm:requestConnector("bravo_ap_button_vs_long",   xfdmConOutRwDataref,  xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_ias_long",  xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_cmd_long",  xfdmConOutSimCommand, "FJS/Q4XP/SoftKey/ap_yd")

xfdm:requestConnector("cmd_ap_disc",                 xfdmConOutSimCommand, "FJS/Q4XP/Autopilot/AUTOPILOT_DISCONNECT")
xfdm:requestConnector("cmd_at_disc",                 xfdmConOutSimCommand, "FJS/Q4XP/ENGINES/PowerGatePassALL")
xfdm:requestConnector("cmd_at_cws",                  xfdmConOutSimCommand, "FJS/Q4XP/Autopilot/TCS_Engage")

xfdm:requestConnector("anti_ice_eng_on",             xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("anti_ice_eng_off",            xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("q4xp_prop_ai_pos",            xfdmConOutRwDataref,   "FJS/Q4XP/Manips/KnobWDetent_Anim")
xfdm:requestConnector("anti_ice_wing_on",            xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("anti_ice_wing_off",           xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_strobe_on",            xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_strobe_off",           xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("q4xp_lights_strobe_pos",      xfdmConOutRwDataref,   "FJS/Q4XP/Manips/TwoSwitch_Anim")

function xfdm_set_prop_ai()
  local tCockpitPos = xfdm:readConnectorDest("q4xp_prop_ai_pos", 2)
  local tSwPos = xfdm:readConnectorSrc("anti_ice_eng_on")

  if (tSwPos and (tCockpitPos ~= 1)) then
    xfdm:driveConnectorDest("q4xp_prop_ai_pos", 2, 1)
  elseif (not(tSwPos) and (tCockpitPos ~= 0)) then
    xfdm:driveConnectorDest("q4xp_prop_ai_pos", 2, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_prop_ai()")

function xfdm_set_wing_ai()
  local tCockpitPos = xfdm:readConnectorDest("q4xp_prop_ai_pos", 0)
  local tSwPos = xfdm:readConnectorSrc("anti_ice_wing_on")

  if (tSwPos and (tCockpitPos ~= 1)) then
    xfdm:driveConnectorDest("q4xp_prop_ai_pos", 0, 2)
  elseif (not(tSwPos) and (tCockpitPos ~= 0)) then
    xfdm:driveConnectorDest("q4xp_prop_ai_pos", 0, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_wing_ai()")

function xfdm_set_strobe_light()
  local tStrobePos = xfdm:readConnectorDest("q4xp_lights_strobe_pos", 23)
  local tSwPos = xfdm:readConnectorSrc("lights_strobe_on")

  if (tSwPos and (tStrobePos < 0.0001)) then
    xfdm:driveConnectorDest("q4xp_lights_strobe_pos", 23, 1)
  elseif (not(tSwPos) and (tStrobePos > 0.9999)) then
    xfdm:driveConnectorDest("q4xp_lights_strobe_pos", 23, -1)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_strobe_light()")

--BravoLights

--xfdm:requestConnector("ap_hdg_mode", xfdmConOutRoDataref, "laminar/B738/autopilot/hdg_sel_status")
--function xfdm.joysticks.honeycomb_bravo.leds:checkHdg()
--  if (xfdm:readConnectorDest("ap_hdg_mode") == 1) then
--    xfdm:driveConnectorDest("bravo_led_hdg", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_hdg", nil, 0)
--  end
--end
--
--xfdm:requestConnector("ap_lnav_mode", xfdmConOutRoDataref, "laminar/B738/autopilot/lnav_status")
--xfdm:requestConnector("ap_vnav_mode", xfdmConOutRoDataref, "laminar/B738/autopilot/vnav_status1")
--function xfdm.joysticks.honeycomb_bravo.leds:checkNav()
--  if (xfdm:readConnectorDest("ap_lnav_mode") == 1 or
--      xfdm:readConnectorDest("ap_vnav_mode") == 1) then
--    xfdm:driveConnectorDest("bravo_led_nav", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_nav", nil, 0)
--  end
--end
--
--xfdm:requestConnector("ap_loc_mode", xfdmConOutRoDataref, "laminar/B738/autopilot/vorloc_status")
--xfdm:requestConnector("ap_apr_mode", xfdmConOutRoDataref, "laminar/B738/autopilot/app_status")
--function xfdm.joysticks.honeycomb_bravo.leds:checkApr()
--  if ((xfdm:readConnectorDest("ap_loc_mode") == 1) or
--      (xfdm:readConnectorDest("ap_apr_mode") == 1)) then
--    xfdm:driveConnectorDest("bravo_led_apr", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_apr", nil, 0)
--  end
--end
--
--xfdm:requestConnector("ap_alt_chg_status", xfdmConOutRoDataref, "laminar/B738/autopilot/lvl_chg_status")
--xfdm:requestConnector("ap_alt_hld_status", xfdmConOutRoDataref, "laminar/B738/autopilot/alt_hld_status")
--function xfdm.joysticks.honeycomb_bravo.leds:checkApAlt()
--  if ((xfdm:readConnectorDest("ap_alt_chg_status") == 1) or
--      (xfdm:readConnectorDest("ap_alt_hld_status") == 1)) then
--    xfdm:driveConnectorDest("bravo_led_alt", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_alt", nil, 0)
--  end
--end
--
--xfdm:requestConnector("ap_vs_status", xfdmConOutRoDataref, "laminar/B738/autopilot/vs_status")
--function xfdm.joysticks.honeycomb_bravo.leds:checkApVs()
--  if (xfdm:readConnectorDest("ap_vs_status") == 1) then
--    xfdm:driveConnectorDest("bravo_led_vs", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_vs", nil, 0)
--  end
--end
--
--xfdm:requestConnector("ap_ias_speed_status", xfdmConOutRoDataref, "laminar/B738/autopilot/speed_status1")
--xfdm:requestConnector("ap_ias_n1_status", xfdmConOutRoDataref, "laminar/B738/autopilot/n1_status")
--function xfdm.joysticks.honeycomb_bravo.leds:checkApSpeed()
--  if ((xfdm:readConnectorDest("ap_ias_speed_status") == 1) or
--      (xfdm:readConnectorDest("ap_ias_n1_status") == 1)) then
--    xfdm:driveConnectorDest("bravo_led_ias", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_ias", nil, 0)
--  end
--end
--
--xfdm:requestConnector("ap_master", xfdmConOutRoDataref, "laminar/autopilot/ap_on")
--function xfdm.joysticks.honeycomb_bravo.leds:checkApMaster()
--  if (xfdm:readConnectorDest("ap_master") == 1) then
--    xfdm:driveConnectorDest("bravo_led_ap", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_ap", nil, 0)
--  end
--end
--
--xfdm:requestConnector("zibo_b738_master_caution_status", xfdmConOutRoDataref, "laminar/B738/annunciator/master_caution_light")
--function xfdm.joysticks.honeycomb_bravo.leds:checkMasterCaution()
--  if (xfdm:readConnectorDest("zibo_b738_master_caution_status") == 1) then
--    xfdm:driveConnectorDest("bravo_led_mcau", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_mcau", nil, 0)
--  end
--end
--
--xfdm:requestConnector("zibo_b738_fire_bell", xfdmConOutRoDataref, "laminar/B738/annunciator/fire_bell_annun")
--function xfdm.joysticks.honeycomb_bravo.leds:checkFire()
--  if (xfdm:readConnectorDest("zibo_b738_fire_bell") == 1) then
--    xfdm:driveConnectorDest("bravo_led_fire", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_fire", nil, 0)
--  end
--end
--
--xfdm:requestConnector("zibo_b738_press_oil_1", xfdmConOutRoDataref, "laminar/B738/engine/eng1_oil_press")
--xfdm:requestConnector("zibo_b738_press_oil_2", xfdmConOutRoDataref, "laminar/B738/engine/eng2_oil_press")
--function xfdm.joysticks.honeycomb_bravo.leds:checkOil()
--  if ((xfdm:readConnectorDest("zibo_b738_press_oil_1") < 13.0) or
--      (xfdm:readConnectorDest("zibo_b738_press_oil_2") < 13.0)
--     ) then
--    xfdm:driveConnectorDest("bravo_led_oil", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_oil", nil, 0)
--  end
--end
--
--xfdm:requestConnector("zibo_b738_press_hyd_1", xfdmConOutRoDataref, "laminar/B738/hydraulic/B_pressure")
--xfdm:requestConnector("zibo_b738_press_hyd_2", xfdmConOutRoDataref, "laminar/B738/hydraulic/A_pressure")
--function xfdm.joysticks.honeycomb_bravo.leds:checkHyd()
--  if ((xfdm:readConnectorDest("zibo_b738_press_hyd_1", 0) < 2200.0) or
--      (xfdm:readConnectorDest("zibo_b738_press_hyd_2", 2) < 2200.0)
--     ) then
--    xfdm:driveConnectorDest("bravo_led_hyd", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_hyd", nil, 0)
--  end
--end

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

--function xfdm.joysticks.honeycomb_bravo.leds:checkPump()
--  if ((xfdm:readConnectorDest("annun_pump_l") == 1) or
--      (xfdm:readConnectorDest("annun_pump_r") == 1)
--    ) then
--    xfdm:driveConnectorDest("bravo_led_pump", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_pump", nil, 0)
--  end
--end

--xfdm:requestConnector("zibo_b738_anti_ice_engine_status", xfdmConOutRoDataref, "laminar/B738/system/eng_inlet_valve")
--xfdm:requestConnector("zibo_b738_anti_ice_wing_status",    xfdmConOutRoDataref, "laminar/B738/system/wing_anti_ice_valve")
--function xfdm.joysticks.honeycomb_bravo.leds:checkAntiIce()
--  if ((xfdm:readConnectorDest("zibo_b738_anti_ice_engine_status", 0) >= 0.25) or
--      (xfdm:readConnectorDest("zibo_b738_anti_ice_engine_status", 1) >= 0.25) or
--      (xfdm:readConnectorDest("zibo_b738_anti_ice_wing_status", 0) == 1) or
--      (xfdm:readConnectorDest("zibo_b738_anti_ice_wing_status", 1) == 1)
--     ) then
--    xfdm:driveConnectorDest("bravo_led_ice", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_ice", nil, 0)
--  end
--end
--
--xfdm:requestConnector("zibo_b738_starter1", xfdmConOutRwDataref, "laminar/B738/air/engine1/starter_valve")
--xfdm:requestConnector("zibo_b738_starter2", xfdmConOutRoDataref, "laminar/B738/air/engine2/starter_valve")
--function xfdm.joysticks.honeycomb_bravo.leds:checkStart()
--  if ((xfdm:readConnectorDest("zibo_b738_starter1", 1) > 0.25) or
--      (xfdm:readConnectorDest("zibo_b738_starter2", 2) > 0.25)
--     ) then
--    xfdm:driveConnectorDest("bravo_led_start", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_start", nil, 0)
--  end
--end
--
--xfdm:requestConnector("zibo_b738_batt_volts", xfdmConOutRoDataref, "sim/cockpit2/electrical/battery_voltage_actual_volts")
--function xfdm.joysticks.honeycomb_bravo.leds:checkBat()
--  if ((xfdm:readConnectorDest("zibo_b738_batt_volts", 0) < 25.0) or
--      (xfdm:readConnectorDest("zibo_b738_batt_volts", 1) < 25.0) or
--      (xfdm:readConnectorDest("zibo_b738_batt_volts", 2) < 25.0)
--     ) then
--    xfdm:driveConnectorDest("bravo_led_batt", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_batt", nil, 0)
--  end
--end
--
--xfdm:requestConnector("zibo_b738_apu_running", xfdmConOutRwDataref, "sim/cockpit/engine/APU_running")
--function xfdm.joysticks.honeycomb_bravo.leds:checkApu()
--  if (xfdm:readConnectorDest("zibo_b738_apu_running") == 1) then
--    xfdm:driveConnectorDest("bravo_led_apu", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_apu", nil, 0)
--  end
--end
--
--xfdm:requestConnector("zibo_b738_door_aft1",      xfdmConOutRoDataref, "737u/doors/aft1")
--xfdm:requestConnector("zibo_b738_door_aft2",      xfdmConOutRoDataref, "737u/doors/aft2")
--xfdm:requestConnector("zibo_b738_door_aft_cargo", xfdmConOutRoDataref, "737u/doors/aft_Cargo")
--xfdm:requestConnector("zibo_b738_door_emerg1",    xfdmConOutRoDataref, "737u/doors/emerg1")
--xfdm:requestConnector("zibo_b738_door_emerg2",    xfdmConOutRoDataref, "737u/doors/emerg2")
--xfdm:requestConnector("zibo_b738_door_emerg3",    xfdmConOutRoDataref, "737u/doors/emerg3")
--xfdm:requestConnector("zibo_b738_door_emerg4",    xfdmConOutRoDataref, "737u/doors/emerg4")
--xfdm:requestConnector("zibo_b738_door_fwd_cargo", xfdmConOutRoDataref, "737u/doors/Fwd_Cargo")
--xfdm:requestConnector("zibo_b738_door_l1",        xfdmConOutRoDataref, "737u/doors/L1")
--xfdm:requestConnector("zibo_b738_door_l2",        xfdmConOutRoDataref, "737u/doors/L2")
--xfdm:requestConnector("zibo_b738_door_lm",        xfdmConOutRoDataref, "737u/doors/L_mid")
--xfdm:requestConnector("zibo_b738_door_r1",        xfdmConOutRoDataref, "737u/doors/R1")
--xfdm:requestConnector("zibo_b738_door_r2",        xfdmConOutRoDataref, "737u/doors/R2")
--xfdm:requestConnector("zibo_b738_door_rm",        xfdmConOutRoDataref, "737u/doors/R_mid")
--function xfdm.joysticks.honeycomb_bravo.leds:checkDoor()
--  if ((xfdm:readConnectorDest("zibo_b738_door_aft1")      > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_aft2")      > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_aft_cargo") > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_emerg1")    > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_emerg2")    > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_emerg3")    > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_emerg4")    > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_fwd_cargo") > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_l1")        > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_l2")        > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_lm")        > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_r1")        > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_r2")        > 0.1) or
--      (xfdm:readConnectorDest("zibo_b738_door_rm")        > 0.1)
--  ) then
--    xfdm:driveConnectorDest("bravo_led_door", nil, 1)
--  else
--    xfdm:driveConnectorDest("bravo_led_door", nil, 0)
--  end
--end
--
--xfdm:requestConnector("zibo_b738_batt_bus", xfdmConOutRwDataref, "laminar/B738/electric/batbus_status")
--function xfdm.joysticks.honeycomb_bravo.leds:checkPower()
--  if(xfdm:readConnectorDest("zibo_b738_batt_bus") == 0) then self.raw = 0 end
--end

end