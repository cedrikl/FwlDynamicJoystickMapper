require("xfdm.base")

if (string.find(PLANE_ICAO, "A320")) then
xfdm:requestConnector("elec_gen_on",            xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("elec_gen_off",           xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("elec_bat_on",            xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("elec_bat_off",           xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("a320_batt1_pos",         xfdmConOutRoDataref,  "model/controls/elec_bat1")
xfdm:requestConnector("a320_batt2_pos",         xfdmConOutRoDataref,  "model/controls/elec_bat2")
xfdm:requestConnector("a320_batt1_tog",         xfdmConOutSimCommand, "a320/Overhead/ElecBat1_button")
xfdm:requestConnector("a320_batt2_tog",         xfdmConOutSimCommand, "a320/Overhead/ElecBat2_button")
xfdm:requestConnector("nav_irs1_on",            xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("nav_irs1_off",           xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("a320_irs1_pos",          xfdmConOutRoDataref,  "model/controls/cdu_mode1")
xfdm:requestConnector("a320_irs1_incr",         xfdmConOutSimCommand, "a320/Overhead/CDU_Mode1_switch+")
xfdm:requestConnector("a320_irs1_decr",         xfdmConOutSimCommand, "a320/Overhead/CDU_Mode1_switch-")
xfdm:requestConnector("nav_irs2_on",            xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("nav_irs2_off",           xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("a320_irs2_pos",          xfdmConOutRoDataref,  "model/controls/cdu_mode2")
xfdm:requestConnector("a320_irs2_incr",         xfdmConOutSimCommand, "a320/Overhead/CDU_Mode2_switch+")
xfdm:requestConnector("a320_irs2_decr",         xfdmConOutSimCommand, "a320/Overhead/CDU_Mode2_switch-")
xfdm:requestConnector("nav_irs3_on",            xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("nav_irs3_off",           xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("a320_irs3_pos",          xfdmConOutRoDataref,  "model/controls/cdu_mode3")
xfdm:requestConnector("a320_irs3_incr",         xfdmConOutSimCommand, "a320/Overhead/CDU_Mode3_switch+")
xfdm:requestConnector("a320_irs3_decr",         xfdmConOutSimCommand, "a320/Overhead/CDU_Mode3_switch-")

xfdm:requestConnector("lights_bcn_on",          xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("lights_bcn_off",         xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("a320_bcn_pos",           xfdmConOutRoDataref,  "model/controls/light_beacon")
xfdm:requestConnector("a320_bcn_tog",           xfdmConOutSimCommand, "a320/Overhead/LightBeacon_switch+")

xfdm:requestConnector("lights_logo_on",         xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_logo_off",        xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("a320_nav_logo_pos",      xfdmConOutRoDataref,   "model/controls/light_logo")
xfdm:requestConnector("a320_nav_logo_tog",      xfdmConOutSimCommand,  "a320/Overhead/LightLogo_switch+")
xfdm:requestConnector("lights_rwy_turnoff_on",  xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_rwy_turnoff_off", xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("a320_rwy_turnoff_pos",   xfdmConOutRoDataref,   "model/controls/light_turn")
xfdm:requestConnector("a320_rwy_turnoff_tog",   xfdmConOutSimCommand,  "a320/Overhead/LightTurn_switch+")
xfdm:requestConnector("lights_nav_on",          xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_nav_off",         xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_inspect_on",      xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_inspect_off",     xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("a320_wing_pos",          xfdmConOutRoDataref,   "model/controls/light_wing")
xfdm:requestConnector("a320_wing_tog",          xfdmConOutSimCommand,  "a320/Overhead/LightWing_switch+")

function xfdm_set_batt()
  local tCockpitPos1 = xfdm:readConnectorDest("a320_batt1_pos")
  local tCockpitPos2 = xfdm:readConnectorDest("a320_batt2_pos")
  local tSwPos = xfdm:readConnectorSrc("elec_bat_on")

  if (tSwPos and (tCockpitPos1 < 0.0001)) then
    xfdm:driveConnectorDest("a320_batt1_tog")
  elseif (not(tSwPos) and (tCockpitPos1 > 0.4999)) then
    xfdm:driveConnectorDest("a320_batt1_tog")
  end

  if (tSwPos and (tCockpitPos2 < 0.0001)) then
    xfdm:driveConnectorDest("a320_batt2_tog")
  elseif (not(tSwPos) and (tCockpitPos2 > 0.4999)) then
    xfdm:driveConnectorDest("a320_batt2_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_batt()")

function xfdm_set_irs()
  local tCockpitPos1 = xfdm:readConnectorDest("a320_irs1_pos")
  local tCockpitPos2 = xfdm:readConnectorDest("a320_irs2_pos")
  local tCockpitPos3 = xfdm:readConnectorDest("a320_irs3_pos")
  local tSw1Pos      = xfdm:readConnectorSrc("nav_irs1_on")
  local tSw2Pos      = xfdm:readConnectorSrc("nav_irs2_on")

  if (tSw1Pos and (tCockpitPos1 < 0.4999)) then
    xfdm:driveConnectorDest("a320_irs1_incr")
  elseif (tSw1Pos and (tCockpitPos1 > 0.5001)) then
    xfdm:driveConnectorDest("a320_irs1_decr")
  elseif (not(tSw1Pos) and (tCockpitPos1 > 0.0001)) then
    xfdm:driveConnectorDest("a320_irs1_decr")
    xfdm:driveConnectorDest("a320_irs1_decr")
  end

  if (tSw1Pos and (tCockpitPos3 < 0.4999)) then
    xfdm:driveConnectorDest("a320_irs3_incr")
  elseif (tSw1Pos and (tCockpitPos3 > 0.5001)) then
    xfdm:driveConnectorDest("a320_irs3_decr")
  elseif (not(tSw1Pos) and (tCockpitPos3 > 0.0001)) then
    xfdm:driveConnectorDest("a320_irs3_decr")
    xfdm:driveConnectorDest("a320_irs3_decr")
  end

  if (tSw2Pos and (tCockpitPos2 < 0.4999)) then
    xfdm:driveConnectorDest("a320_irs2_incr")
  elseif (tSw2Pos and (tCockpitPos2 > 0.5001)) then
    xfdm:driveConnectorDest("a320_irs2_decr")
  elseif (not(tSw2Pos) and (tCockpitPos2 > 0.0001)) then
    xfdm:driveConnectorDest("a320_irs2_decr")
    xfdm:driveConnectorDest("a320_irs2_decr")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_irs()")

function xfdm_set_bcn_lights()
  local tCockpitPos = xfdm:readConnectorDest("a320_bcn_pos")
  local tSwPos = xfdm:readConnectorSrc("lights_bcn_on")
  
  if (tSwPos and (tCockpitPos < 0.9999)) then
    xfdm:driveConnectorDest("a320_bcn_tog")
  elseif (not(tSwPos) and (tCockpitPos > 0.0001)) then
    xfdm:driveConnectorDest("a320_bcn_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_bcn_lights()")

function xfdm_set_nav_lights()
  local tCockpitPos = xfdm:readConnectorDest("a320_nav_logo_pos")
  local tSwPos      = xfdm:readConnectorSrc("lights_logo_on")
  local tSw2Pos     = xfdm:readConnectorSrc("lights_nav_on")

  local tSwInGate = (tCockpitPos <= 0.0001) or ((tCockpitPos >= 0.4999) and (tCockpitPos <= 0.5001)) or (tCockpitPos >= 0.9999)
  if (tSwPos and (tCockpitPos < 0.9999) and tSwInGate) then
    xfdm:driveConnectorDest("a320_nav_logo_tog")
  elseif (not(tSwPos) and tSw2Pos and ((tCockpitPos > 0.5001) or (tCockpitPos < 0.4999)) and tSwInGate) then
    xfdm:driveConnectorDest("a320_nav_logo_tog")
  elseif (not(tSwPos) and not(tSw2Pos) and (tCockpitPos > 0.0001) and tSwInGate) then
    xfdm:driveConnectorDest("a320_nav_logo_tog")
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm_set_nav_lights()")

function xfdm_set_turnoff_lights()
  local tCockpitPos = xfdm:readConnectorDest("a320_rwy_turnoff_pos")
  local tSwPos = xfdm:readConnectorSrc("lights_rwy_turnoff_on")
  
  if (tSwPos and (tCockpitPos < 0.9999)) then
    xfdm:driveConnectorDest("a320_rwy_turnoff_tog")
  elseif (not(tSwPos) and (tCockpitPos > 0.0001)) then
    xfdm:driveConnectorDest("a320_rwy_turnoff_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_turnoff_lights()")

function xfdm_set_wing_lights()
  local tCockpitPos = xfdm:readConnectorDest("a320_wing_pos")
  local tSwPos = xfdm:readConnectorSrc("lights_inspect_on")
  
  if (tSwPos and (tCockpitPos < 0.9999)) then
    xfdm:driveConnectorDest("a320_wing_tog")
  elseif (not(tSwPos) and (tCockpitPos > 0.0001)) then
    xfdm:driveConnectorDest("a320_wing_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_wing_lights()")

end
