require("xfdm.base")

if string.find(PLANE_ICAO, "A319") or
   string.find(PLANE_ICAO, "A321") or
   string.find(PLANE_ICAO, "A19N") or
   string.find(PLANE_ICAO, "A2[01]N")
then

xfdm:requestConnector("elec_gen_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("elec_gen_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("elec_bat_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("elec_bat_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("toliss_bat1_on",              xfdmConOutSimCommand,  "toliss_airbus/eleccommands/Bat1On")
xfdm:requestConnector("toliss_bat1_off",             xfdmConOutSimCommand,  "toliss_airbus/eleccommands/Bat1Off")
xfdm:requestConnector("toliss_bat2_on",              xfdmConOutSimCommand,  "toliss_airbus/eleccommands/Bat2On")
xfdm:requestConnector("toliss_bat2_off",             xfdmConOutSimCommand,  "toliss_airbus/eleccommands/Bat2Off")
xfdm:requestConnector("toliss_bat_status",           xfdmConOutRoDataref,   "AirbusFBW/BatOHPArray")
xfdm:requestConnector("nav_irs1_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("nav_irs1_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("toliss_sw_irs1",              xfdmConOutRwDataref,   "ckpt/oh/irs1/anim")
xfdm:requestConnector("nav_irs2_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("nav_irs2_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("toliss_sw_irs2",              xfdmConOutRwDataref,   "ckpt/oh/irs2/anim")
xfdm:requestConnector("toliss_sw_irs3",              xfdmConOutRwDataref,   "ckpt/oh/irs3/anim")

xfdm:requestConnector("lights_bcn_on",               xfdmConOutSimCommand,  "toliss_airbus/lightcommands/BeaconOn")
xfdm:requestConnector("lights_bcn_off",              xfdmConOutSimCommand,  "toliss_airbus/lightcommands/BeaconOff")
xfdm:requestConnector("lights_logo_on",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_logo_off",             xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("toliss_nav_logo_pos",         xfdmConOutRwDataref,   "ckpt/oh/navLight/anim")
xfdm:requestConnector("lights_rwy_turnoff_on",       xfdmConOutSimCommand,  "toliss_airbus/lightcommands/TurnoffLightOn")
xfdm:requestConnector("lights_rwy_turnoff_off",      xfdmConOutSimCommand,  "toliss_airbus/lightcommands/TurnoffLightOff")
xfdm:requestConnector("lights_nav_on",               xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_nav_off",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_inspect_on",           xfdmConOutSimCommand,  "toliss_airbus/lightcommands/WingLightOn")
xfdm:requestConnector("lights_inspect_off",          xfdmConOutSimCommand,  "toliss_airbus/lightcommands/WingLightOff")

function xfdm_set_alpha_batt()
  local tCockpitPos1 = xfdm:readConnectorDest("toliss_bat_status", 0)
  local tCockpitPos2 = xfdm:readConnectorDest("toliss_bat_status", 1)
  local tSwPos       = xfdm:readConnectorSrc("elec_bat_on")

  if (tSwPos and (tCockpitPos1 < 1)) then
    xfdm:driveConnectorDest("toliss_bat1_on")
  elseif not(tSwPos) and (tCockpitPos1 > 0.99) then
    xfdm:driveConnectorDest("toliss_bat1_off")
  end
  
  if (tSwPos and (tCockpitPos2 < 1)) then
    xfdm:driveConnectorDest("toliss_bat2_on")
  elseif not(tSwPos) and (tCockpitPos2 > 0.99) then
    xfdm:driveConnectorDest("toliss_bat2_off")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_alpha_batt()")

function xfdm_set_irs()
  local tCockpitPos1 = xfdm:readConnectorDest("toliss_sw_irs1")
  local tCockpitPos2 = xfdm:readConnectorDest("toliss_sw_irs2")
  local tCockpitPos3 = xfdm:readConnectorDest("toliss_sw_irs3")
  local tSw1Pos      = xfdm:readConnectorSrc("nav_irs1_on")
  local tSw2Pos      = xfdm:readConnectorSrc("nav_irs2_on")

  if (tSw1Pos and (tCockpitPos1 ~= 1)) then
    xfdm:driveConnectorDest("toliss_sw_irs1", nil, 1)
  elseif (not(tSw1Pos) and (tCockpitPos1 > 0)) then
    xfdm:driveConnectorDest("toliss_sw_irs1", nil, 0)
  end
  
  if (tSw1Pos and (tCockpitPos3 ~= 1)) then
    xfdm:driveConnectorDest("toliss_sw_irs3", nil, 1)
  elseif (not(tSw1Pos) and (tCockpitPos3 > 0)) then
    xfdm:driveConnectorDest("toliss_sw_irs3", nil, 0)
  end
  
  if (tSw2Pos and (tCockpitPos2 ~= 1)) then
    xfdm:driveConnectorDest("toliss_sw_irs2", nil, 1)
  elseif (not(tSw2Pos) and (tCockpitPos2 > 0)) then
    xfdm:driveConnectorDest("toliss_sw_irs2", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_irs()")

function xfdm_set_logo_light()
  local tCockpitPos = xfdm:readConnectorDest("toliss_nav_logo_pos")
  local tSwPos      = xfdm:readConnectorSrc("lights_logo_on")
  local tSw2Pos     = xfdm:readConnectorSrc("lights_nav_on")

  if (tSwPos and (tCockpitPos < 2)) then
    xfdm:driveConnectorDest("toliss_nav_logo_pos", nil, 2)
  elseif (not(tSwPos) and tSw2Pos and (tCockpitPos ~= 1)) then
    xfdm:driveConnectorDest("toliss_nav_logo_pos", nil, 1)
  elseif (not(tSwPos) and not(tSw2Pos) and (tCockpitPos > 0)) then
    xfdm:driveConnectorDest("toliss_nav_logo_pos", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_logo_light()")
end