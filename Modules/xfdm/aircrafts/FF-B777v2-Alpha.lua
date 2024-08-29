require("xfdm.base")

if (string.find(PLANE_ICAO, "B772")) then

xfdm:requestConnector("elec_gen_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("elec_gen_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_gen1_tog",               xfdmConOutSimCommand,  "1-sim/command/leftGenButton_button")
xfdm:requestConnector("b777_gen2_tog",               xfdmConOutSimCommand,  "1-sim/command/rightGenButton_button")

xfdm:requestConnector("elec_bat_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("elec_bat_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_bat_tog",                xfdmConOutSimCommand,  "1-sim/command/batteryButton_button")
xfdm:requestConnector("b777_bus1_tog",               xfdmConOutSimCommand,  "1-sim/command/leftBusTieButton_button")
xfdm:requestConnector("b777_bus2_tog",               xfdmConOutSimCommand,  "1-sim/command/rightBusTieButton_button")

xfdm:requestConnector("nav_irs1_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("nav_irs1_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_irs_tog",                xfdmConOutSimCommand,  "1-sim/command/adiruSwitch_button")
xfdm:requestConnector("nav_irs2_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("nav_irs2_off",                xfdmConOutSimCommand,  xfdmNullLink)

xfdm:requestConnector("lights_bcn_on",               xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_bcn_off",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_bcn_tog",                xfdmConOutSimCommand,  "1-sim/command/beaconLightSwitch_button")
xfdm:requestConnector("lights_logo_on",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_logo_off",             xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_logo_tog",               xfdmConOutSimCommand,  "1-sim/command/logoLightSwitch_button")
xfdm:requestConnector("lights_rwy_turnoff_on",       xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_rwy_turnoff_off",      xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_rwy1_pos",               xfdmConOutRoDataref,   "1-sim/ckpt/runwayTurnoffLeftSwitch/anim")
xfdm:requestConnector("b777_rwy2_pos",               xfdmConOutRoDataref,   "1-sim/ckpt/runwayTurnoffRightSwitch/anim")
xfdm:requestConnector("b777_rwy1_tog",               xfdmConOutSimCommand,  "1-sim/command/runwayTurnoffLeftSwitch_trigger")
xfdm:requestConnector("b777_rwy2_tog",               xfdmConOutSimCommand,  "1-sim/command/runwayTurnoffRightSwitch_trigger")
xfdm:requestConnector("lights_nav_on",               xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_nav_off",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_nav_tog",                xfdmConOutSimCommand,  "1-sim/command/navLightSwitch_button")
xfdm:requestConnector("lights_inspect_on",           xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_inspect_off",          xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("b777_wing_tog",               xfdmConOutSimCommand,  "1-sim/command/wingLightSwitch_button")

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