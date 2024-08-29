require("xfdm.base")

if string.find(PLANE_ICAO, "E17[05]") or -- E170/E175
   string.find(PLANE_ICAO, "E19[05]")    -- E190/E195 + Lineage 1000 (E190)
then

xfdm:requestConnector("lights_inspect_on",           xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_inspect_off",          xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_logo_on",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_logo_off",             xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_rwy_turnoff_on",       xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_rwy_turnoff_off",      xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("ejet_sw_pos",                 xfdmConOutRwDataref,   "sim/cockpit2/switches/generic_lights_switch")
xfdm:requestConnector("ejet_sw_insp_pos",            xfdmConOutRwDataref,   "XCrafts/light/inspection_switch")
xfdm:requestConnector("ejet_sw_logo_pos",            xfdmConOutRwDataref,   "XCrafts/light/logo_switch")

xfdm:requestConnector("elec_bat_on",                 xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("elec_bat_off",                xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("ejet_bat1_on",                xfdmConOutSimCommand, "sim/electrical/battery_1_on")
xfdm:requestConnector("ejet_bat1_off",               xfdmConOutSimCommand, "sim/electrical/battery_1_off")
xfdm:requestConnector("ejet_bat2_on",                xfdmConOutSimCommand, "sim/electrical/battery_2_on")
xfdm:requestConnector("ejet_bat2_off",               xfdmConOutSimCommand, "sim/electrical/battery_2_off")
xfdm:requestConnector("ejet_bat_status",             xfdmConOutRoDataref,  "sim/cockpit/electrical/battery_array_on")

xfdm:requestConnector("elec_gen_on",                 xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("elec_gen_off",                xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("ejet_gen1_on",                xfdmConOutSimCommand, "sim/electrical/generator_1_on")
xfdm:requestConnector("ejet_gen1_off",               xfdmConOutSimCommand, "sim/electrical/generator_1_off")
xfdm:requestConnector("ejet_gen2_on",                xfdmConOutSimCommand, "sim/electrical/generator_2_on")
xfdm:requestConnector("ejet_gen2_off",               xfdmConOutSimCommand, "sim/electrical/generator_2_off")
xfdm:requestConnector("ejet_gen_status",             xfdmConOutRoDataref,  "sim/cockpit/electrical/generator_on")

function xfdm_set_alpha_gen()
  local tCockpitPos1 = xfdm:readConnectorDest("ejet_gen_status", 0)
  local tCockpitPos2 = xfdm:readConnectorDest("ejet_gen_status", 1)
  local tSwPos      = xfdm:readConnectorSrc("elec_gen_on")

  if (tSwPos and (tCockpitPos1 ~= 1)) then
    xfdm:driveConnectorDest("ejet_gen1_on")
  elseif (not(tSwPos) and (tCockpitPos1 > 0)) then
    xfdm:driveConnectorDest("ejet_gen1_off")
  end
  
  if (tSwPos and (tCockpitPos2 ~= 1)) then
    xfdm:driveConnectorDest("ejet_gen2_on")
  elseif (not(tSwPos) and (tCockpitPos2 > 0)) then
    xfdm:driveConnectorDest("ejet_gen2_off")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_alpha_gen()")

function xfdm_set_alpha_batt()
  local tCockpitPos1 = xfdm:readConnectorDest("ejet_bat_status", 0)
  local tCockpitPos2 = xfdm:readConnectorDest("ejet_bat_status", 1)
  local tSwPos      = xfdm:readConnectorSrc("elec_bat_on")

  if (tSwPos and (tCockpitPos1 ~= 1)) then
    xfdm:driveConnectorDest("ejet_bat1_on")
  elseif (not(tSwPos) and (tCockpitPos1 > 0)) then
    xfdm:driveConnectorDest("ejet_bat1_off")
  end
  
  if (tSwPos and (tCockpitPos2 ~= 1)) then
    xfdm:driveConnectorDest("ejet_bat2_on")
  elseif (not(tSwPos) and (tCockpitPos2 > 0)) then
    xfdm:driveConnectorDest("ejet_bat2_off")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_alpha_batt()")

function xfdm_set_logo_light()
  local tCockpitPos = xfdm:readConnectorDest("ejet_sw_logo_pos")
  local tSwPos      = xfdm:readConnectorSrc("lights_logo_on")

  if (tSwPos and (tCockpitPos ~= 1)) then
    xfdm:driveConnectorDest("ejet_sw_logo_pos", nil, 1)
  elseif (not(tSwPos) and (tCockpitPos > 0)) then
    xfdm:driveConnectorDest("ejet_sw_logo_pos", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_logo_light()")

function xfdm_set_inspect_light()
  local tCockpitPos = xfdm:readConnectorDest("ejet_sw_insp_pos")
  local tSwPos      = xfdm:readConnectorSrc("lights_inspect_on")

  if (tSwPos and (tCockpitPos ~= 1)) then
    xfdm:driveConnectorDest("ejet_sw_insp_pos", nil, 1)
  elseif (not(tSwPos) and (tCockpitPos > 0)) then
    xfdm:driveConnectorDest("ejet_sw_insp_pos", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_inspect_light()")

function xfdm_set_turnoff_light()
  local tCockpitPos = xfdm:readConnectorDest("ejet_sw_pos", 21)
  local tSwPos      = xfdm:readConnectorSrc("lights_rwy_turnoff_on")

  if (tSwPos and (tCockpitPos ~= 3)) then
    xfdm:driveConnectorDest("ejet_sw_pos", 21, 3)
  elseif (not(tSwPos) and (tCockpitPos > 0)) then
    xfdm:driveConnectorDest("ejet_sw_pos", 21, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_turnoff_light()")

end