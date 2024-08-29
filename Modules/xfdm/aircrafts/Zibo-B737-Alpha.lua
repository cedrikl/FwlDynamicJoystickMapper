require("xfdm.base")

if string.find(PLANE_ICAO, "B738") or -- 737-800 NG
   string.find(PLANE_ICAO, "B78M")    -- 737 Max 8
then


xfdm:requestConnector("elec_gen_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("elec_gen_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("zibo_stby_off",               xfdmConOutSimCommand,  "laminar/B738/switch/standby_bat_off")
xfdm:requestConnector("zibo_stby_cover",             xfdmConOutSimCommand,  "laminar/B738/button_switch_cover03")
xfdm:requestConnector("zibo_cover_pos",              xfdmConOutRoDataref,   "laminar/B738/button_switch/cover_position")
xfdm:requestConnector("zibo_stby_status",            xfdmConOutRoDataref,   "laminar/B738/electric/standby_bat_pos")

xfdm:requestConnector("elec_bat_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("elec_bat_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("zibo_bat_off",                xfdmConOutSimCommand,  "laminar/B738/switch/battery_up")
xfdm:requestConnector("zibo_bat_cover",              xfdmConOutSimCommand,  "laminar/B738/button_switch_cover02")
--xfdm:requestConnector("zibo_cover_pos",              xfdmConOutRoDataref,  "laminar/B738/button_switch/cover_position")
xfdm:requestConnector("zibo_bat_status",             xfdmConOutRoDataref,   "laminar/B738/electric/battery_pos")

xfdm:requestConnector("nav_irs1_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("nav_irs1_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("zibo_sw_irs1",                xfdmConOutRwDataref,   "laminar/B738/toggle_switch/irs_left")
xfdm:requestConnector("nav_irs2_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("nav_irs2_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("zibo_sw_irs2",                xfdmConOutRwDataref,   "laminar/B738/toggle_switch/irs_right")

xfdm:requestConnector("lights_bcn_on",               xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_bcn_off",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("zibo_light_bcn",              xfdmConOutRwDataref,   "sim/cockpit2/switches/beacon_on")
xfdm:requestConnector("lights_logo_on",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_logo_off",             xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("zibo_light_logo",             xfdmConOutRwDataref,   "laminar/B738/toggle_switch/logo_light")
xfdm:requestConnector("lights_rwy_turnoff_on",       xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_rwy_turnoff_off",      xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("zibo_turnoff_left",           xfdmConOutRwDataref,   "laminar/B738/toggle_switch/rwy_light_left")
xfdm:requestConnector("zibo_turnoff_right",          xfdmConOutRwDataref,   "laminar/B738/toggle_switch/rwy_light_right")
xfdm:requestConnector("lights_nav_on",               xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_nav_off",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("zibo_b738_lights_pos",        xfdmConOutRwDataref,   "laminar/B738/lights_sw")
xfdm:requestConnector("zibo_b738_lights_strobe_up",  xfdmConOutSimCommand,  "laminar/B738/toggle_switch/position_light_up")
xfdm:requestConnector("zibo_b738_lights_strobe_dn",  xfdmConOutSimCommand,  "laminar/B738/toggle_switch/position_light_down")
xfdm:requestConnector("lights_inspect_on",           xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_inspect_off",          xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("zibo_light_wheel",            xfdmConOutRwDataref,   "laminar/B738/toggle_switch/wheel_light")



function xfdm_set_alpha_gen()
  local tCockpitPos = xfdm:readConnectorDest("zibo_stby_status")
  local tCoverPos   = xfdm:readConnectorDest("zibo_cover_pos", 3)
  local tSwPos      = xfdm:readConnectorSrc("elec_gen_on")

  if (tSwPos and (tCockpitPos ~= 1)) then
    xfdm:driveConnectorDest("zibo_stby_cover")
  elseif not(tSwPos) and (tCoverPos < 0.01) then
    xfdm:driveConnectorDest("zibo_stby_cover")
  elseif not(tSwPos) and (tCoverPos > 0.99) then
    xfdm:driveConnectorDest("zibo_stby_off")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_alpha_gen()")

function xfdm_set_alpha_batt()
  local tCockpitPos = xfdm:readConnectorDest("zibo_bat_status")
  local tCoverPos   = xfdm:readConnectorDest("zibo_cover_pos", 2)
  local tSwPos      = xfdm:readConnectorSrc("elec_bat_on")

  if (tSwPos and (tCockpitPos ~= 1)) then
    xfdm:driveConnectorDest("zibo_bat_cover")
  elseif not(tSwPos) and (tCoverPos < 0.01) then
    xfdm:driveConnectorDest("zibo_bat_cover")
  elseif not(tSwPos) and (tCoverPos > 0.99) then
    xfdm:driveConnectorDest("zibo_bat_off")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_alpha_batt()")

function xfdm_set_irs()
  local tCockpitPos1 = xfdm:readConnectorDest("zibo_sw_irs1")
  local tCockpitPos2 = xfdm:readConnectorDest("zibo_sw_irs2")
  local tSw1Pos      = xfdm:readConnectorSrc("nav_irs1_on")
  local tSw2Pos      = xfdm:readConnectorSrc("nav_irs2_on")

  if (tSw1Pos and (tCockpitPos1 ~= 1)) then
    xfdm:driveConnectorDest("zibo_sw_irs1", nil, 2)
  elseif (not(tSw1Pos) and (tCockpitPos1 > 0)) then
    xfdm:driveConnectorDest("zibo_sw_irs1", nil, 0)
  end
  
  if (tSw2Pos and (tCockpitPos2 ~= 1)) then
    xfdm:driveConnectorDest("zibo_sw_irs2", nil, 2)
  elseif (not(tSw2Pos) and (tCockpitPos2 > 0)) then
    xfdm:driveConnectorDest("zibo_sw_irs2", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_irs()")

function xfdm_set_bcn_light()
  local tCockpitPos = xfdm:readConnectorDest("zibo_light_bcn")
  local tSwPos      = xfdm:readConnectorSrc("lights_bcn_on")

  if (tSwPos and (tCockpitPos ~= 1)) then
    xfdm:driveConnectorDest("zibo_light_bcn", nil, 1)
  elseif (not(tSwPos) and (tCockpitPos > 0)) then
    xfdm:driveConnectorDest("zibo_light_bcn", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_bcn_light()")

function xfdm_set_logo_light()
  local tCockpitPos = xfdm:readConnectorDest("zibo_light_logo")
  local tSwPos      = xfdm:readConnectorSrc("lights_logo_on")

  if (tSwPos and (tCockpitPos ~= 1)) then
    xfdm:driveConnectorDest("zibo_light_logo", nil, 1)
  elseif (not(tSwPos) and (tCockpitPos > 0)) then
    xfdm:driveConnectorDest("zibo_light_logo", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_logo_light()")

function xfdm_set_turnoff_light()
  local tCockpitPos1 = xfdm:readConnectorDest("zibo_turnoff_left")
  local tCockpitPos2 = xfdm:readConnectorDest("zibo_turnoff_right")
  local tSwPos       = xfdm:readConnectorSrc("lights_rwy_turnoff_on")

  if (tSwPos and (tCockpitPos1 ~= 1)) then
    xfdm:driveConnectorDest("zibo_turnoff_left", nil, 1)
  elseif (not(tSwPos) and (tCockpitPos1 > 0)) then
    xfdm:driveConnectorDest("zibo_turnoff_left", nil, 0)
  end
  
  if (tSwPos and (tCockpitPos2 ~= 1)) then
    xfdm:driveConnectorDest("zibo_turnoff_right", nil, 1)
  elseif (not(tSwPos) and (tCockpitPos2 > 0)) then
    xfdm:driveConnectorDest("zibo_turnoff_right", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_turnoff_light()")

function xfdm_set_nav_light()
  local tStrobePos = xfdm:readConnectorDest("zibo_b738_lights_pos", 0)
  local tSwPos     = xfdm:readConnectorSrc("lights_nav_on")
  local tSw2Pos    = xfdm:readConnectorSrc("lights_strobe_on")

  if (tSwPos and not(tSw2Pos) and (tStrobePos < 0.0001) and (tStrobePos > -0.0001)) then
    xfdm:driveConnectorDest("zibo_b738_lights_strobe_dn")
  elseif (not(tSwPos) and not(tSw2Pos) and (tStrobePos < 0)) then
    xfdm:driveConnectorDest("zibo_b738_lights_strobe_up")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_nav_light()")

function xfdm_set_inspect_light()
  local tCockpitPos = xfdm:readConnectorDest("zibo_light_wheel")
  local tSwPos      = xfdm:readConnectorSrc("lights_inspect_on")

  if (tSwPos and (tCockpitPos ~= 1)) then
    xfdm:driveConnectorDest("zibo_light_wheel", nil, 1)
  elseif (not(tSwPos) and (tCockpitPos > 0)) then
    xfdm:driveConnectorDest("zibo_light_wheel", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_inspect_light()")

end