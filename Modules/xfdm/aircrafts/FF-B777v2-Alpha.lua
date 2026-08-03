require("xfdm.base")

if(string.find(PLANE_ICAO, "B772") or
	 string.find(PLANE_ICAO, "B77W")
  ) then
  
  logMsg("XFDM - Aircrafts: Creating Mapping FF B777v2 Alpha Additions.")

xfdm:requestConnector("b777_lgen_pos",                xfdmConOutRwDataref,   "1-sim/ckpt/leftGenButton/anim")
xfdm:requestConnector("b777_lbgen_pos",                xfdmConOutRwDataref,   "1-sim/ckpt/leftBackupGenButton/anim")
xfdm:requestConnector("b777_rbgen_pos",                xfdmConOutRwDataref,   "1-sim/ckpt/rightBackupGenButton/anim")
xfdm:requestConnector("b777_rgen_pos",                xfdmConOutRwDataref,   "1-sim/ckpt/rightGenButton/anim")
xfdm:requestConnector("elec_gen_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("elec_gen_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_lgen_tog",               xfdmConOutSimCommand,  "1-sim/command/leftGenButton_button")
xfdm:requestConnector("b777_lbgen_tog",               xfdmConOutSimCommand,  "1-sim/command/leftBackupGenButton_button")
xfdm:requestConnector("b777_rbgen_tog",               xfdmConOutSimCommand,  "1-sim/command/rightBackupGenButton_button")
xfdm:requestConnector("b777_rgen_tog",               xfdmConOutSimCommand,  "1-sim/command/rightGenButton_button")

xfdm:requestConnector("b777_bat_pos",                xfdmConOutRwDataref,   "1-sim/ckpt/batteryButton/anim")
xfdm:requestConnector("elec_bat_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("elec_bat_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_bat_tog",                xfdmConOutSimCommand,  "1-sim/command/batteryButton_button")
--Bus Ties are pushed always
--xfdm:requestConnector("b777_bus1_tog",               xfdmConOutSimCommand,  "1-sim/command/leftBusTieButton_button")
--xfdm:requestConnector("b777_bus2_tog",               xfdmConOutSimCommand,  "1-sim/command/rightBusTieButton_button")

xfdm:requestConnector("b777_irs_pos",                xfdmConOutRwDataref,   "1-sim/ckpt/adiruSwitch/anim")
xfdm:requestConnector("nav_irs1_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("nav_irs1_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_irs_tog",                xfdmConOutSimCommand,  "1-sim/command/adiruSwitch_button")
--Simply unmap irs2 since only 1 button
xfdm:requestConnector("nav_irs2_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("nav_irs2_off",                xfdmConOutSimCommand,  xfdmNullLink)

xfdm:requestConnector("lights_bcn_pos",                xfdmConOutRwDataref, "1-sim/ckpt/beaconLightSwitch/anim")
xfdm:requestConnector("lights_bcn_on",               xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_bcn_off",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_bcn_tog",                xfdmConOutSimCommand,  "1-sim/command/beaconLightSwitch_button")

xfdm:requestConnector("lights_logo_pos",                xfdmConOutRwDataref,  "1-sim/ckpt/logoLightSwitch/anim")
xfdm:requestConnector("lights_logo_on",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_logo_off",             xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_logo_tog",               xfdmConOutSimCommand,  "1-sim/command/logoLightSwitch_button")

xfdm:requestConnector("lights_rwy_turnoff_on",       xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_rwy_turnoff_off",      xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_rwy1_pos",               xfdmConOutRoDataref,   "1-sim/ckpt/runwayTurnoffLeftSwitch/anim")
xfdm:requestConnector("b777_rwy2_pos",               xfdmConOutRoDataref,   "1-sim/ckpt/runwayTurnoffRightSwitch/anim")
xfdm:requestConnector("b777_rwy1_tog",               xfdmConOutSimCommand,  "1-sim/command/runwayTurnoffLeftSwitch_trigger")
xfdm:requestConnector("b777_rwy2_tog",               xfdmConOutSimCommand,  "1-sim/command/runwayTurnoffRightSwitch_trigger")

xfdm:requestConnector("lights_nav_pos",                xfdmConOutRwDataref,  "1-sim/ckpt/navLightSwitch/anim")
xfdm:requestConnector("lights_nav_on",               xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_nav_off",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_nav_tog",                xfdmConOutSimCommand,  "1-sim/command/navLightSwitch_button")

xfdm:requestConnector("lights_wing_pos",                xfdmConOutRwDataref,  "1-sim/ckpt/wingLightSwitch/anim")
xfdm:requestConnector("lights_inspect_on",           xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_inspect_off",          xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_wing_tog",               xfdmConOutSimCommand,  "1-sim/command/wingLightSwitch_button")

--Adiru
function xfdm_set_adiru()
  local tCockpitPos1 = xfdm:readConnectorDest("b777_irs_pos")
  local tSwPos       = xfdm:readConnectorSrc("nav_irs1_on")

  if (tSwPos and (tCockpitPos1 < 0.01)) then
    xfdm:driveConnectorDest("b777_irs_tog")
  elseif (not(tSwPos) and (tCockpitPos1 > 0.99)) then
    xfdm:driveConnectorDest("b777_irs_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_adiru()")

--Battery
function xfdm_set_battery()
  local tCockpitPos1 = xfdm:readConnectorDest("b777_bat_pos")
  local tSwPos       = xfdm:readConnectorSrc("elec_bat_on")

  if (tSwPos and (tCockpitPos1 < 0.01)) then
    xfdm:driveConnectorDest("b777_bat_tog")
  elseif (not(tSwPos) and (tCockpitPos1 > 0.99)) then
    xfdm:driveConnectorDest("b777_bat_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_battery()")

--Generators
function xfdm_set_generators()
  local tCockpitPos1 = xfdm:readConnectorDest("b777_lgen_pos")
  local tCockpitPos1 = xfdm:readConnectorDest("b777_lbgen_pos")
  local tCockpitPos1 = xfdm:readConnectorDest("b777_rbgen_pos")
  local tCockpitPos1 = xfdm:readConnectorDest("b777_rgen_pos")
  local tSwPos       = xfdm:readConnectorSrc("elec_gen_on")

  if (tSwPos and (tCockpitPos1 < 0.01)) then
    xfdm:driveConnectorDest("b777_lgen_tog")
  elseif (not(tSwPos) and (tCockpitPos1 > 0.99)) then
    xfdm:driveConnectorDest("b777_lgen_tog")
  end
  if (tSwPos and (tCockpitPos1 < 0.01)) then
    xfdm:driveConnectorDest("b777_lbgen_tog")
  elseif (not(tSwPos) and (tCockpitPos1 > 0.99)) then
    xfdm:driveConnectorDest("b777_lbgen_tog")
  end
    if (tSwPos and (tCockpitPos1 < 0.01)) then
    xfdm:driveConnectorDest("b777_rbgen_tog")
  elseif (not(tSwPos) and (tCockpitPos1 > 0.99)) then
    xfdm:driveConnectorDest("b777_rbgen_tog")
  end
    if (tSwPos and (tCockpitPos1 < 0.01)) then
    xfdm:driveConnectorDest("b777_rgen_tog")
  elseif (not(tSwPos) and (tCockpitPos1 > 0.99)) then
    xfdm:driveConnectorDest("b777_rgen_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_generators()")

--beacon Light Switch
function xfdm_set_beacon()
  local tCockpitPos1 = xfdm:readConnectorDest("lights_bcn_pos")
  local tSwPos       = xfdm:readConnectorSrc("lights_bcn_on")

  if (tSwPos and (tCockpitPos1 < 0.01)) then
    xfdm:driveConnectorDest("b777_bcn_tog")
  elseif (not(tSwPos) and (tCockpitPos1 > 0.99)) then
    xfdm:driveConnectorDest("b777_bcn_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_beacon()")

--Logo Light Switch
function xfdm_set_logo()
  local tCockpitPos1 = xfdm:readConnectorDest("lights_logo_pos")
  local tSwPos       = xfdm:readConnectorSrc("lights_logo_on")

  if (tSwPos and (tCockpitPos1 < 0.01)) then
    xfdm:driveConnectorDest("b777_logo_tog")
  elseif (not(tSwPos) and (tCockpitPos1 > 0.99)) then
    xfdm:driveConnectorDest("b777_logo_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_logo()")

--Nav Light Switch
function xfdm_set_nav()
  local tCockpitPos1 = xfdm:readConnectorDest("lights_nav_pos")
  local tSwPos       = xfdm:readConnectorSrc("lights_nav_on")

  if (tSwPos and (tCockpitPos1 < 0.01)) then
    xfdm:driveConnectorDest("b777_nav_tog")
  elseif (not(tSwPos) and (tCockpitPos1 > 0.99)) then
    xfdm:driveConnectorDest("b777_nav_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_nav()")

--Wing Light Switch
function xfdm_set_wing()
  local tCockpitPos1 = xfdm:readConnectorDest("lights_wing_pos")
  local tSwPos       = xfdm:readConnectorSrc("lights_inspect_on")

  if (tSwPos and (tCockpitPos1 < 0.01)) then
    xfdm:driveConnectorDest("b777_wing_tog")
  elseif (not(tSwPos) and (tCockpitPos1 > 0.99)) then
    xfdm:driveConnectorDest("b777_wing_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_wing()")

--Turnoff Light Switch
function xfdm_set_turnoff_light()
  local tCockpitPos1 = xfdm:readConnectorDest("b777_rwy1_pos")
  local tCockpitPos2 = xfdm:readConnectorDest("b777_rwy2_pos")
  local tSwPos      = xfdm:readConnectorSrc("lights_rwy_turnoff_on")

  if (tSwPos and (tCockpitPos1 > 0)) then
    xfdm:driveConnectorDest("b777_rwy1_tog")
  elseif (not(tSwPos) and (tCockpitPos1 < 1)) then
    xfdm:driveConnectorDest("b777_rwy1_tog")
  end

  if (tSwPos and (tCockpitPos2 > 0)) then
    xfdm:driveConnectorDest("b777_rwy2_tog")
  elseif (not(tSwPos) and (tCockpitPos2 < 1)) then
    xfdm:driveConnectorDest("b777_rwy2_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_turnoff_light()")
end