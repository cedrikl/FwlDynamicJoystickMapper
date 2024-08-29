require("xfdm.base")
require("xfdm.joysticks.honeycomb_bravo")

if string.find(PLANE_ICAO, "E17[05]") or -- E170/E175
   string.find(PLANE_ICAO, "E19[05]")    -- E190/E195 + Lineage 1000 (E190)
then

xfdm:requestConnector("cmd_at_cws",                  xfdmConOutSimCommand, "XCrafts/ERJ/TCS")

xfdm:requestConnector("anti_ice_wing_on",            xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("anti_ice_wing_off",           xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("ejet_wai_pos",                xfdmConOutRoDataref,   "sim/cockpit2/ice/ice_tail_hot_bleed_air_on")
xfdm:requestConnector("ejet_wai1_on",                xfdmConOutSimCommand,  "sim/ice/wing_tai0_on")
xfdm:requestConnector("ejet_wai1_off",               xfdmConOutSimCommand,  "sim/ice/wing_tai0_off")
xfdm:requestConnector("ejet_wai2_on",                xfdmConOutSimCommand,  "sim/ice/wing_tai1_on")
xfdm:requestConnector("ejet_wai2_off",               xfdmConOutSimCommand,  "sim/ice/wing_tai1_off")

xfdm:requestConnector("anti_ice_eng_on",             xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("anti_ice_eng_off",            xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("ejet_eai_pos",                xfdmConOutRoDataref,   "sim/cockpit2/ice/cowling_thermal_anti_ice_per_engine")
xfdm:requestConnector("ejet_eai1_on",                xfdmConOutSimCommand,  "sim/ice/inlet_eai0_on")
xfdm:requestConnector("ejet_eai1_off",               xfdmConOutSimCommand,  "sim/ice/inlet_eai0_off")
xfdm:requestConnector("ejet_eai2_on",                xfdmConOutSimCommand,  "sim/ice/inlet_eai1_on")
xfdm:requestConnector("ejet_eai2_off",               xfdmConOutSimCommand,  "sim/ice/inlet_eai1_off")

function xfdm_set_eng_anti_ice()
  local tEai1Pos = xfdm:readConnectorDest("ejet_eai_pos", 0)
  local tEai2Pos = xfdm:readConnectorDest("ejet_eai_pos", 1)
  local tSwPos   = xfdm:readConnectorSrc("anti_ice_eng_on")

  if (tSwPos and (tEai1Pos ~= 1)) then
    xfdm:driveConnectorDest("ejet_eai1_on")
  elseif (not(tSwPos) and (tEai1Pos > 0)) then
    xfdm:driveConnectorDest("ejet_eai1_off")
  end

  if (tSwPos and (tEai2Pos ~= 1)) then
    xfdm:driveConnectorDest("ejet_eai2_on")
  elseif (not(tSwPos) and (tEai2Pos > 0)) then
    xfdm:driveConnectorDest("ejet_eai2_off")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_eng_anti_ice()")

function xfdm_set_wing_anti_ice()
  local tWaiPos = xfdm:readConnectorDest("ejet_wai_pos")
  local tSwPos   = xfdm:readConnectorSrc("anti_ice_wing_on")

  if (tSwPos and (tWaiPos ~= 1)) then
    xfdm:driveConnectorDest("ejet_wai1_on")
    xfdm:driveConnectorDest("ejet_wai2_on")
  elseif (not(tSwPos) and (tWaiPos > 0)) then
    xfdm:driveConnectorDest("ejet_wai1_off")
    xfdm:driveConnectorDest("ejet_wai2_off")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_wing_anti_ice()")

xfdm:requestConnector("bravo_ap_button_nav_short", xfdmConOutSimCommand, "XCrafts/ERJ/LNAV")
xfdm:requestConnector("bravo_ap_button_apr_short", xfdmConOutSimCommand, "XCrafts/ERJ/APPCH")
xfdm:requestConnector("bravo_ap_button_rev_short", xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_alt_short", xfdmConOutSimCommand, "XCrafts/ERJ/FLCH")
xfdm:requestConnector("bravo_ap_button_vs_short",  xfdmConOutSimCommand, "XCrafts/ERJ/VS")
xfdm:requestConnector("bravo_ap_button_ias_short", xfdmConOutSimCommand, "sim/autopilot/speed_hold")
--xfdm:requestConnector("bravo_ap_button_cmd_short", xfdmConOutSimCommand, "laminar/B738/autopilot/cmd_a_press")

xfdm:requestConnector("bravo_ap_button_hdg_long",  xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_nav_long",  xfdmConOutSimCommand, "XCrafts/ERJ/VNAV")
xfdm:requestConnector("bravo_ap_button_apr_long",  xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_rev_long",  xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_alt_long",  xfdmConOutSimCommand, "XCrafts/ERJ/alt_hold")
xfdm:requestConnector("bravo_ap_button_vs_long",   xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_ias_long",  xfdmConOutSimCommand, xfdmNullLink)
--xfdm:requestConnector("bravo_ap_button_cmd_long",  xfdmConOutSimCommand, "laminar/B738/autopilot/cws_a_press")

--Acceleration Tuning
xfdm.joysticks.honeycomb_bravo.sAccelThreshold  = 3
xfdm.joysticks.honeycomb_bravo.sAccelMultiplier = 2
xfdm.joysticks.honeycomb_bravo.sAccelMaxMultiplier = 10

xfdm:requestConnector("bravo_ap_dial_cw",        xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_dial_ccw",       xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_dial_alt_cw",    xfdmConOutSimCommand, "XCrafts/ERJ/ALT_up_100")
xfdm:requestConnector("bravo_ap_dial_ver_cw",    xfdmConOutSimCommand, "XCrafts/ERJ/VS_up_10")
xfdm:requestConnector("bravo_ap_dial_ias_cw",    xfdmConOutSimCommand, "XCrafts/ERJ/SPD_up_1")
xfdm:requestConnector("bravo_ap_dial_alt_ccw",   xfdmConOutSimCommand, "XCrafts/ERJ/ALT_dn_100")
xfdm:requestConnector("bravo_ap_dial_ver_ccw",   xfdmConOutSimCommand, "XCrafts/ERJ/VS_dn_10")
xfdm:requestConnector("bravo_ap_dial_ias_ccw",   xfdmConOutSimCommand, "XCrafts/ERJ/SPD_dn_1")

----BravoLights
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