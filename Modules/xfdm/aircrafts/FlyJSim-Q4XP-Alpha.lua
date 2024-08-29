require("xfdm.base")

if string.find(PLANE_ICAO, "DH8D") then

xfdm:requestConnector("q4xp_switch_pos",             xfdmConOutRwDataref,   "FJS/Q4XP/Manips/TwoSwitch_Anim")
xfdm:requestConnector("q4xp_switch_lk_pos",          xfdmConOutRwDataref,   "FJS/Q4XP/Manips/TwoSwitchLock_Anim")

xfdm:requestConnector("elec_gen_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("elec_gen_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("elec_bat_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("elec_bat_off",                xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("nav_irs1_on",                 xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("nav_irs1_off",                xfdmConOutSimCommand,  xfdmNullLink)

xfdm:requestConnector("lights_bcn_on",               xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_bcn_off",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_logo_on",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_logo_off",             xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_rwy_turnoff_on",       xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_rwy_turnoff_off",      xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_nav_on",               xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_nav_off",              xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_inspect_on",           xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_inspect_off",          xfdmConOutSimCommand,  xfdmNullLink)

function xfdm_set_alpha_gen()
  local tCockpitPos1 = xfdm:readConnectorDest("q4xp_switch_pos", 3)
  local tCockpitPos2 = xfdm:readConnectorDest("q4xp_switch_pos", 4)
  local tCockpitPos3 = xfdm:readConnectorDest("q4xp_switch_pos", 27)
  local tCockpitPos4 = xfdm:readConnectorDest("q4xp_switch_pos", 28)
  local tSwPos       = xfdm:readConnectorSrc("elec_gen_on")

  if (tSwPos and (tCockpitPos1 < 1)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 3, 1)
  elseif not(tSwPos) and (tCockpitPos1 > 0.99) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 3, 0)
  end
  
  if (tSwPos and (tCockpitPos2 < 1)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 4, 1)
  elseif not(tSwPos) and (tCockpitPos2 > 0.99) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 4, 0)
  end
  
  if (tSwPos and (tCockpitPos3 < 1)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 27, 1)
  elseif not(tSwPos) and (tCockpitPos3 > 0.99) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 27, 0)
  end
  
  if (tSwPos and (tCockpitPos4 < 1)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 28, 1)
  elseif not(tSwPos) and (tCockpitPos4 > 0.99) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 28, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_alpha_gen()")

function xfdm_set_alpha_batt()
  local tCockpitPos1 = xfdm:readConnectorDest("q4xp_switch_pos", 0)
  local tCockpitPos2 = xfdm:readConnectorDest("q4xp_switch_pos", 1)
  local tCockpitPos3 = xfdm:readConnectorDest("q4xp_switch_pos", 2)
  local tCockpitPos4 = xfdm:readConnectorDest("q4xp_switch_lk_pos", 0)
  local tSwPos       = xfdm:readConnectorSrc("elec_bat_on")

  if (tSwPos and (tCockpitPos1 < 1)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 0, 1)
  elseif not(tSwPos) and (tCockpitPos1 > 0.99) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 0, 0)
  end
  
  if (tSwPos and (tCockpitPos2 < 1)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 1, 1)
  elseif not(tSwPos) and (tCockpitPos2 > 0.99) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 1, 0)
  end
  
  if (tSwPos and (tCockpitPos3 < 1)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 2, 1)
  elseif not(tSwPos) and (tCockpitPos3 > 0.99) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 2, 0)
  end
  
  if (tSwPos and (tCockpitPos4 < 1)) then
    xfdm:driveConnectorDest("q4xp_switch_lk_pos", 0, 1)
  elseif not(tSwPos) and (tCockpitPos4 > 0.99) then
    xfdm:driveConnectorDest("q4xp_switch_lk_pos", 0, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_alpha_batt()")

function xfdm_set_bcn_light()
  local tCockpitPos = xfdm:readConnectorDest("q4xp_switch_pos", 23)
  local tSwPos      = xfdm:readConnectorSrc("lights_bcn_on")

  if (tSwPos and (tCockpitPos < 0.0001) and (tCockpitPos > -0.9)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 23, -1)
  elseif (not(tSwPos) and (tCockpitPos < -0.9)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 23, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_bcn_light()")

function xfdm_set_logo_light()
  local tCockpitPos = xfdm:readConnectorDest("q4xp_switch_pos", 25)
  local tSwPos      = xfdm:readConnectorSrc("lights_logo_on")

  if (tSwPos and (tCockpitPos < 1)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 25, 1)
  elseif (not(tSwPos) and (tCockpitPos > 0)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 25, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_logo_light()")

function xfdm_set_nav_light()
  local tCockpitPos = xfdm:readConnectorDest("q4xp_switch_pos", 24)
  local tSwPos      = xfdm:readConnectorSrc("lights_nav_on")

  if (tSwPos and (tCockpitPos < 1)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 24, 1)
  elseif (not(tSwPos) and (tCockpitPos > 0)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 24, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_nav_light()")

function xfdm_set_inspect_light()
  local tCockpitPos = xfdm:readConnectorDest("q4xp_switch_pos", 22)
  local tSwPos      = xfdm:readConnectorSrc("lights_inspect_on")

  if (tSwPos and (tCockpitPos < 1)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 22, 1)
  elseif (not(tSwPos) and (tCockpitPos > 0)) then
    xfdm:driveConnectorDest("q4xp_switch_pos", 22, 0)
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_inspect_light()")
end