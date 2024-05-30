require("xfdm.base")
require("xfdm.joysticks.honeycomb_bravo")

if (string.find(PLANE_ICAO, "A320")) then

  xfdm:requestConnector("nose_light_pos", xfdmConOutRoDataref, "model/controls/light_nose")
  xfdm:requestConnector("l_ldg_light_pos", xfdmConOutRoDataref, "model/controls/light_land1")
  xfdm:requestConnector("r_ldg_light_pos", xfdmConOutRoDataref, "model/controls/light_land2")

  xfdm:requestConnector("nose_light_toggle",  xfdmConOutSimCommand, "a320/Overhead/LightNose_switch+")
  xfdm:requestConnector("l_ldg_light_toggle", xfdmConOutSimCommand, "a320/Overhead/LightLandL_switch+")
  xfdm:requestConnector("r_ldg_light_toggle", xfdmConOutSimCommand, "a320/Overhead/LightLandR_switch+")
  xfdm:requestConnector("lights_taxi_on",     xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("lights_taxi_off",    xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("lights_ldg_on",      xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("lights_ldg_off",     xfdmConOutSimCommand, xfdmNullLink)

function xfdm_set_ldg_lights()
  local tJoyLdgOn  = xfdm:readConnectorSrc("lights_ldg_on")
  local tJoyTaxiOn = xfdm:readConnectorSrc("lights_taxi_on")

  local tSimNosePos = xfdm:readConnectorDest("nose_light_pos")
  local tNoseInGate = (tSimNosePos <= 0.0001) or ((tSimNosePos >= 0.4999) and (tSimNosePos <= 0.5001)) or (tSimNosePos >= 0.9999)
  if (tJoyLdgOn and (tSimNosePos ~= 1) and tNoseInGate) then
    --xfdm:driveConnectorDest("nose_light_toggle")
  elseif (tJoyTaxiOn and (tSimNosePos ~= 0.5) and tNoseInGate) then
    --xfdm:driveConnectorDest("nose_light_toggle")
  elseif (not(tJoyLdgOn) and not(tJoyTaxiOn) and (tSimNosePos ~= 0) and tNoseInGate) then
    --xfdm:driveConnectorDest("nose_light_toggle")
  end

  local tSimLdgLeftPos = xfdm:readConnectorDest("l_ldg_light_pos")
  local tLdgLeftInGate = (tSimLdgLeftPos == 0.0) or (tSimLdgLeftPos == 0.5) or (tSimLdgLeftPos == 1.0)
  if (tJoyLdgOn and (tSimLdgLeftPos ~= 1) and tLdgLeftInGate) then
    xfdm:driveConnectorDest("l_ldg_light_toggle")
  elseif (not(tJoyLdgOn) and (tSimLdgLeftPos ~= 0) and tLdgLeftInGate) then
    xfdm:driveConnectorDest("l_ldg_light_toggle")
  end

  local tSimLdgRightPos = xfdm:readConnectorDest("r_ldg_light_pos")
  local tLdgRightInGate = (tSimLdgRightPos == 0.0) or (tSimLdgRightPos == 0.5) or (tSimLdgRightPos == 1.0)
  if (tJoyLdgOn and (tSimLdgRightPos ~= 1) and tLdgRightInGate) then
    xfdm:driveConnectorDest("r_ldg_light_toggle")
  elseif (not(tJoyLdgOn) and (tSimLdgRightPos ~= 0) and tLdgRightInGate) then
    xfdm:driveConnectorDest("r_ldg_light_toggle")
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm_set_ldg_lights()")

  --Override the bravo cmd once, register a release
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_hdg_short() xfdm:driveConnectorDest("bravo_ap_button_hdg_short") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_nav_short() xfdm:driveConnectorDest("bravo_ap_button_nav_short") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_apr_short() xfdm:driveConnectorDest("bravo_ap_button_apr_short") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_rev_short() xfdm:driveConnectorDest("bravo_ap_button_rev_short") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_alt_short() xfdm:driveConnectorDest("bravo_ap_button_alt_short") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_vs_short()  xfdm:driveConnectorDest("bravo_ap_button_vs_short") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_ias_short() xfdm:driveConnectorDest("bravo_ap_button_ias_short") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_cmd_short() xfdm:driveConnectorDest("bravo_ap_button_cmd_short") end
  --
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_hdg_long() xfdm:driveConnectorDest("bravo_ap_button_hdg_long") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_nav_long() xfdm:driveConnectorDest("bravo_ap_button_nav_long") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_apr_long() xfdm:driveConnectorDest("bravo_ap_button_apr_long") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_rev_long() xfdm:driveConnectorDest("bravo_ap_button_rev_long") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_alt_long() xfdm:driveConnectorDest("bravo_ap_button_alt_long") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_vs_long()  xfdm:driveConnectorDest("bravo_ap_button_vs_long") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_ias_long() xfdm:driveConnectorDest("bravo_ap_button_ias_long") end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_cmd_long() xfdm:driveConnectorDest("bravo_ap_button_cmd_long") end
end

function xfdm_set_nose_light()
end