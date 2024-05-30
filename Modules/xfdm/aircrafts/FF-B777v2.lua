require("xfdm.base")
require("xfdm.joysticks.honeycomb_bravo")

if (string.find(PLANE_ICAO, "B772")) then

  xfdm:requestConnector("cmd_at_disc",       xfdmConOutSimCommand, "1-sim/command/apDiscLeftButton_button")
  xfdm:requestConnector("cmd_at_toga",       xfdmConOutSimCommand, "1-sim/command/togaLeftButton_button")

  xfdm:requestConnector("anti_ice_eng_on",   xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("anti_ice_eng_off",  xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("anti_ice_wing_on",  xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("anti_ice_wing_off", xfdmConOutSimCommand, xfdmNullLink)

  xfdm:requestConnector("strobe_light_toggle", xfdmConOutSimCommand, "1-sim/command/strobeLightSwitch_trigger")
  xfdm:requestConnector("lights_strobe_on",    xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("lights_strobe_off",   xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("strobe_light_pos",    xfdmConOutRoDataref, "1-sim/ckpt/strobeLightSwitch/anim")
  function xfdm_set_strobe_light()
    local tJoyStrobeOn = xfdm:readConnectorSrc("lights_strobe_on")
    local tStrobePos = xfdm:readConnectorDest("strobe_light_pos")

    local tStrobeInGate = (tStrobePos == 0.0) or (tStrobePos == 1.0)
    if (tJoyStrobeOn and (tStrobePos ~= 0) and tStrobeInGate) then
      xfdm:driveConnectorDest("strobe_light_toggle")
    elseif (not(tJoyStrobeOn) and not(tJoyTaxiOn) and (tStrobePos ~= 1) and tStrobeInGate) then
      xfdm:driveConnectorDest("strobe_light_toggle")
    end
  end
  xfdm:requestCallback(xfdmCallbackAlways, "xfdm_set_strobe_light()")


  xfdm:requestConnector("taxi_light_toggle", xfdmConOutSimCommand, "1-sim/command/taxiLightSwitch_trigger")
  xfdm:requestConnector("lights_taxi_on",    xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("lights_taxi_off",   xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("taxi_light_pos",    xfdmConOutRoDataref, "1-sim/ckpt/taxiLightSwitch/anim")
  function xfdm_set_taxi_light()
    local tJoyTaxiOn = xfdm:readConnectorSrc("lights_taxi_on")
    local tTaxiPos = xfdm:readConnectorDest("taxi_light_pos")

    local tTaxiInGate = (tTaxiPos == 0.0) or (tTaxiPos == 1.0)
    if (tJoyTaxiOn and (tTaxiPos ~= 0) and tTaxiInGate) then
      xfdm:driveConnectorDest("taxi_light_toggle")
    elseif (not(tJoyTaxiOn) and not(tJoyTaxiOn) and (tTaxiPos ~= 1) and tTaxiInGate) then
      xfdm:driveConnectorDest("taxi_light_toggle")
    end
  end
  xfdm:requestCallback(xfdmCallbackAlways, "xfdm_set_taxi_light()")


  xfdm:requestConnector("nose_ldg_light_toggle", xfdmConOutSimCommand, "1-sim/command/landingLightNoseSwitch_trigger")
  xfdm:requestConnector("l_ldg_light_toggle",    xfdmConOutSimCommand, "1-sim/command/landingLightLeftSwitch_trigger")
  xfdm:requestConnector("r_ldg_light_toggle",    xfdmConOutSimCommand, "1-sim/command/landingLightRightSwitch_trigger")
  xfdm:requestConnector("lights_ldg_on",         xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("lights_ldg_off",        xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("nose_ldg_light_pos",    xfdmConOutRoDataref, "1-sim/ckpt/landingLightNoseSwitch/anim")
  xfdm:requestConnector("left_ldg_light_pos",    xfdmConOutRoDataref, "1-sim/ckpt/landingLightLeftSwitch/anim")
  xfdm:requestConnector("right_ldg_light_pos",   xfdmConOutRoDataref, "1-sim/ckpt/landingLightRightSwitch/anim")
  function xfdm_set_ldg_lights()
    local tJoyLdgOn  = xfdm:readConnectorSrc("lights_ldg_on")

    local tSimNosePos = xfdm:readConnectorDest("nose_ldg_light_pos")
    local tNoseInGate = (tSimNosePos == 0.0) or (tSimNosePos == 1.0)
    if (tJoyLdgOn and (tSimNosePos ~= 0) and tNoseInGate) then
      xfdm:driveConnectorDest("nose_ldg_light_toggle")
    elseif (not(tJoyLdgOn) and not(tJoyTaxiOn) and (tSimNosePos ~= 1) and tNoseInGate) then
      xfdm:driveConnectorDest("nose_ldg_light_toggle")
    end

    local tSimLdgLeftPos = xfdm:readConnectorDest("left_ldg_light_pos")
    local tLdgLeftInGate = (tSimLdgLeftPos == 0.0) or (tSimLdgLeftPos == 1.0)
    if (tJoyLdgOn and (tSimLdgLeftPos ~= 0) and tLdgLeftInGate) then
      xfdm:driveConnectorDest("l_ldg_light_toggle")
    elseif (not(tJoyLdgOn) and (tSimLdgLeftPos ~= 1) and tLdgLeftInGate) then
      xfdm:driveConnectorDest("l_ldg_light_toggle")
    end

    local tSimLdgRightPos = xfdm:readConnectorDest("right_ldg_light_pos")
    local tLdgRightInGate = (tSimLdgRightPos == 0.0) or (tSimLdgRightPos == 1.0)
    if (tJoyLdgOn and (tSimLdgRightPos ~= 0) and tLdgRightInGate) then
      xfdm:driveConnectorDest("r_ldg_light_toggle")
    elseif (not(tJoyLdgOn) and (tSimLdgRightPos ~= 1) and tLdgRightInGate) then
      xfdm:driveConnectorDest("r_ldg_light_toggle")
    end
  end
  xfdm:requestCallback(xfdmCallbackAlways, "xfdm_set_ldg_lights()")


  xfdm:requestConnector("bravo_ap_dial_cw",         xfdmConOutSimCommand, "1-sim/comm/HC/inc")
  xfdm:requestConnector("bravo_ap_dial_ccw",        xfdmConOutSimCommand, "1-sim/comm/HC/dec")

  xfdm:requestConnector("bravo_ap_dial_hdg_cw",     xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_dial_crs_cw",     xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_dial_alt_cw",     xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_dial_ver_cw",     xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_dial_ias_cw",     xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_dial_hdg_ccw",    xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_dial_crs_ccw",    xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_dial_alt_ccw",    xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_dial_ver_ccw",    xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_dial_ias_ccw",    xfdmConOutSimCommand, xfdmNullLink)

  xfdm:requestConnector("bravo_ap_button_hdg",      xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_nav",      xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_apr",      xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_rev",      xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_alt",      xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_vs",       xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_ias",      xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_cmd",      xfdmConOutRwDataref, xfdmNullLink)

  xfdm:requestConnector("bravo_ap_button_nav_short", xfdmConOutSimCommand, "1-sim/command/mcpLnavButton_button")
  xfdm:requestConnector("bravo_ap_button_hdg_short", xfdmConOutSimCommand, "1-sim/command/mcpHdgCelButton_button")
  xfdm:requestConnector("bravo_ap_button_apr_short", xfdmConOutSimCommand, "1-sim/command/mcpAppButton_button")
  xfdm:requestConnector("bravo_ap_button_rev_short", xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_alt_short", xfdmConOutSimCommand, "1-sim/command/mcpAltHoldButton_button")
  xfdm:requestConnector("bravo_ap_button_vs_short",  xfdmConOutSimCommand, "1-sim/comm/HC/VS")
  xfdm:requestConnector("bravo_ap_button_ias_short", xfdmConOutSimCommand, "1-sim/command/mcpFlchButton_button")
  xfdm:requestConnector("bravo_ap_button_cmd_short", xfdmConOutSimCommand, "1-sim/comm/HC/ap")

  xfdm:requestConnector("bravo_ap_button_hdg_long",  xfdmConOutSimCommand, "1-sim/command/mcpHdgHoldButton_button")
  xfdm:requestConnector("bravo_ap_button_nav_long",  xfdmConOutSimCommand, "1-sim/command/mcpVnavButton_button")
  xfdm:requestConnector("bravo_ap_button_apr_long",  xfdmConOutSimCommand, "1-sim/command/mcpLocButton_button")
  xfdm:requestConnector("bravo_ap_button_rev_long",  xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_alt_long",  xfdmConOutSimCommand, "1-sim/command/mcpAltRotary_push")
  xfdm:requestConnector("bravo_ap_button_vs_long",   xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_ias_long",  xfdmConOutSimCommand, "1-sim/command/mcpSpdRotary_push")
  xfdm:requestConnector("bravo_ap_button_cmd_long",  xfdmConOutSimCommand, xfdmNullLink)

  xfdm:requestConnector("bravo_ap_mode_hdg",         xfdmConOutSimCommand, "1-sim/comm/HC/selectorHDG")
  xfdm:requestConnector("bravo_ap_mode_alt",         xfdmConOutSimCommand, "1-sim/comm/HC/selectorALT")
  xfdm:requestConnector("bravo_ap_mode_ver",         xfdmConOutSimCommand, "1-sim/comm/HC/selectorVS")
  xfdm:requestConnector("bravo_ap_mode_ias",         xfdmConOutSimCommand, "1-sim/comm/HC/selectorIAS")
  xfdm:requestConnector("bravo_ap_mode_crs",         xfdmConOutSimCommand, xfdmNullLink)

  xfdm:requestMapping("axis_speedbrakes",xfdmConInOtherCon, "bravo_axis_1")

--1-sim/command/parkbrake_trigger
end