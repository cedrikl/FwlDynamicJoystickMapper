require("xfdm.base")
require("xfdm.joysticks.honeycomb_bravo")

xfdm.aircrafts = {}
xfdm.aircrafts.ffa320 = {}
xfdm.aircrafts.ffa320.pushPullEndQueue = {}

if (string.find(PLANE_ICAO, "A320")) then
xfdm:requestConnector("bravo_ap_dial_hdg_cw",    xfdmConOutSimCommand, "a320/Panel/FCU_Lateral_switch+")
xfdm:requestConnector("bravo_ap_dial_hdg_ccw",   xfdmConOutSimCommand, "a320/Panel/FCU_Lateral_switch-")
xfdm:requestConnector("bravo_ap_dial_crs_cw",    xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_dial_crs_ccw",   xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_dial_alt_cw",    xfdmConOutSimCommand, "a320/Panel/FCU_Altitude_switch+")
xfdm:requestConnector("bravo_ap_dial_alt_ccw",   xfdmConOutSimCommand, "a320/Panel/FCU_Altitude_switch-")
xfdm:requestConnector("bravo_ap_dial_ver_cw",    xfdmConOutSimCommand, "a320/Panel/FCU_Vertical_switch+")
xfdm:requestConnector("bravo_ap_dial_ver_ccw",   xfdmConOutSimCommand, "a320/Panel/FCU_Vertical_switch-")
xfdm:requestConnector("bravo_ap_dial_ias_cw",    xfdmConOutSimCommand, "a320/Panel/FCU_Speed_switch+")
xfdm:requestConnector("bravo_ap_dial_ias_ccw",   xfdmConOutSimCommand, "a320/Panel/FCU_Speed_switch-")

--Acceleration Tuning
xfdm.joysticks.honeycomb_bravo.sAccelThreshold  = 4
xfdm.joysticks.honeycomb_bravo.sAccelMultiplier = 2
xfdm.joysticks.honeycomb_bravo.sAccelMaxMultiplier = 3

xfdm:requestConnector("bravo_ap_button_hdg_short", xfdmConOutSimCommand, "a320/Panel/FCU_LateralMode_switch_push")
xfdm:requestConnector("bravo_ap_button_nav_short", xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_apr_short", xfdmConOutSimCommand, "a320/Panel/FCU_Approach_button")
xfdm:requestConnector("bravo_ap_button_rev_short", xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_alt_short", xfdmConOutSimCommand, "a320/Panel/FCU_AltitudeMode_switch_push")
xfdm:requestConnector("bravo_ap_button_vs_short",  xfdmConOutSimCommand, "a320/Panel/FCU_VerticalMode_switch_push")
xfdm:requestConnector("bravo_ap_button_ias_short", xfdmConOutSimCommand, "a320/Panel/FCU_SpeedMode_switch_push")
xfdm:requestConnector("bravo_ap_button_cmd_short", xfdmConOutSimCommand, "a320/Panel/FCU_AutoPilot1_button")

xfdm:requestConnector("bravo_ap_button_hdg_long",  xfdmConOutSimCommand, "a320/Panel/FCU_LateralMode_switch_pull")
xfdm:requestConnector("bravo_ap_button_nav_long",  xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_apr_long",  xfdmConOutSimCommand, "a320/Panel/FCU_Localizer_button")
xfdm:requestConnector("bravo_ap_button_rev_long",  xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_alt_long",  xfdmConOutSimCommand, "a320/Panel/FCU_AltitudeMode_switch_pull")
xfdm:requestConnector("bravo_ap_button_vs_long",   xfdmConOutSimCommand, "a320/Panel/FCU_VerticalMode_switch_pull")
xfdm:requestConnector("bravo_ap_button_ias_long",  xfdmConOutSimCommand, "a320/Panel/FCU_SpeedMode_switch_pull")
xfdm:requestConnector("bravo_ap_button_cmd_long",  xfdmConOutSimCommand, "a320/Panel/FCU_AutoPilot2_button")

xfdm:requestConnector("anti_ice_wing_on",          xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("anti_ice_wing_off",         xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("a320_eng1_anti_ice_pos",    xfdmConOutRoDataref,  "model/controls/heat_engine1")
xfdm:requestConnector("a320_eng2_anti_ice_pos",    xfdmConOutRoDataref,  "model/controls/heat_engine2")
xfdm:requestConnector("a320_eng1_anti_ice_tog",    xfdmConOutSimCommand, "a320/Overhead/HeatEngine1_button")
xfdm:requestConnector("a320_eng2_anti_ice_tog",    xfdmConOutSimCommand, "a320/Overhead/HeatEngine2_button")
xfdm:requestConnector("anti_ice_eng_on",           xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("anti_ice_eng_off",          xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("a320_wing_anti_ice_pos",    xfdmConOutRoDataref, "model/controls/heat_wing")
xfdm:requestConnector("a320_wing_anti_ice_tog",    xfdmConOutSimCommand, "a320/Overhead/HeatWing_button")
xfdm:requestConnector("lights_strobe_on",          xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("lights_strobe_off",         xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("a320_strobe_toggle",        xfdmConOutSimCommand, "a320/Overhead/LightStrobe_switch+")
xfdm:requestConnector("a320_strobe_pos",           xfdmConOutRoDataref,  "model/controls/light_strobe")

xfdm:requestConnector("lights_ldg_on",             xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("lights_ldg_off",            xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("l_ldg_light_toggle",        xfdmConOutSimCommand, "a320/Overhead/LightLandL_switch+")
xfdm:requestConnector("r_ldg_light_toggle",        xfdmConOutSimCommand, "a320/Overhead/LightLandR_switch+")
xfdm:requestConnector("l_ldg_light_pos",           xfdmConOutRoDataref, "model/controls/light_land1")
xfdm:requestConnector("r_ldg_light_pos",           xfdmConOutRoDataref, "model/controls/light_land2")

xfdm:requestConnector("lights_taxi_on",            xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("lights_taxi_off",           xfdmConOutSimCommand, xfdmNullLink)
xfdm:requestConnector("nose_light_toggle",         xfdmConOutSimCommand, "a320/Overhead/LightNose_switch+")
xfdm:requestConnector("nose_light_pos",            xfdmConOutRoDataref, "model/controls/light_nose")

function xfdm_set_eai()
  local tCockpitPos1 = xfdm:readConnectorDest("a320_eng1_anti_ice_pos")
  local tCockpitPos2 = xfdm:readConnectorDest("a320_eng2_anti_ice_pos")
  local tSwPos = xfdm:readConnectorSrc("anti_ice_eng_on")

  if (tSwPos and (tCockpitPos1 < 0.0001)) then
    xfdm:driveConnectorDest("a320_eng1_anti_ice_tog")
  elseif (not(tSwPos) and (tCockpitPos1 > 0.4999)) then
    xfdm:driveConnectorDest("a320_eng1_anti_ice_tog")
  end

  if (tSwPos and (tCockpitPos2 < 0.0001)) then
    xfdm:driveConnectorDest("a320_eng2_anti_ice_tog")
  elseif (not(tSwPos) and (tCockpitPos2 > 0.4999)) then
    xfdm:driveConnectorDest("a320_eng2_anti_ice_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_eai()")

function xfdm_set_wai()
  local tCockpitPos = xfdm:readConnectorDest("a320_wing_anti_ice_pos")
  local tSwPos = xfdm:readConnectorSrc("anti_ice_wing_on")

  if (tSwPos and (tCockpitPos < 0.0001)) then
    xfdm:driveConnectorDest("a320_wing_anti_ice_tog")
  elseif (not(tSwPos) and (tCockpitPos > 0.4999)) then
    xfdm:driveConnectorDest("a320_wing_anti_ice_tog")
  end
end
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_wai()")

function xfdm_set_strobe_lights()
  local tCockpitPos = xfdm:readConnectorDest("a320_strobe_pos")
  local tSwPos = xfdm:readConnectorSrc("lights_strobe_on")
  
  local tSwInGate = (tCockpitPos <= 0.0001) or ((tCockpitPos >= 0.4999) and (tCockpitPos <= 0.5001)) or (tCockpitPos >= 0.9999)

  if (tSwPos and (tCockpitPos < 0.9999) and tSwInGate) then
    xfdm:driveConnectorDest("a320_strobe_toggle")
  elseif (not(tSwPos) and (tCockpitPos > 0.0001) and tSwInGate) then
    xfdm:driveConnectorDest("a320_strobe_toggle")
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm_set_strobe_lights()")

function xfdm_set_ldg_lights()
  local tJoyLdgOn  = xfdm:readConnectorSrc("lights_ldg_on")
  local tJoyTaxiOn = xfdm:readConnectorSrc("lights_taxi_on")

  local tSimNosePos = xfdm:readConnectorDest("nose_light_pos")
  local tNoseInGate = (tSimNosePos <= 0.0001) or ((tSimNosePos >= 0.4999) and (tSimNosePos <= 0.5001)) or (tSimNosePos >= 0.9999)
  if (tJoyLdgOn and (tSimNosePos < 0.9999) and tNoseInGate) then
    xfdm:driveConnectorDest("nose_light_toggle")
  elseif (not(tJoyLdgOn) and tJoyTaxiOn and ((tSimNosePos > 0.5001) or (tSimNosePos < 0.4999)) and tNoseInGate) then
    xfdm:driveConnectorDest("nose_light_toggle")
  elseif (not(tJoyLdgOn) and not(tJoyTaxiOn) and (tSimNosePos > 0.0001) and tNoseInGate) then
    xfdm:driveConnectorDest("nose_light_toggle")
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

function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_hdg_short() xfdm:beginConnectorDest("bravo_ap_button_hdg_short") table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_hdg_short"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_nav_short() xfdm:beginConnectorDest("bravo_ap_button_nav_short") table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_nav_short"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_apr_short() xfdm:beginConnectorDest("bravo_ap_button_apr_short") table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_apr_short"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_rev_short() xfdm:beginConnectorDest("bravo_ap_button_rev_short") table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_rev_short"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_alt_short() xfdm:beginConnectorDest("bravo_ap_button_alt_short") table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_alt_short"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_vs_short()  xfdm:beginConnectorDest("bravo_ap_button_vs_short")  table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_vs_short"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_ias_short() xfdm:beginConnectorDest("bravo_ap_button_ias_short") table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_ias_short"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_cmd_short() xfdm:beginConnectorDest("bravo_ap_button_cmd_short") table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_cmd_short"}) end

function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_hdg_long() xfdm:beginConnectorDest("bravo_ap_button_hdg_long")  table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_hdg_long"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_nav_long() xfdm:beginConnectorDest("bravo_ap_button_nav_long")  table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_nav_long"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_apr_long() xfdm:beginConnectorDest("bravo_ap_button_apr_long")  table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_apr_long"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_rev_long() xfdm:beginConnectorDest("bravo_ap_button_rev_long")  table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_rev_long"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_alt_long() xfdm:beginConnectorDest("bravo_ap_button_alt_long")  table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_alt_long"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_vs_long()  xfdm:beginConnectorDest("bravo_ap_button_vs_long")   table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_vs_long"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_ias_long() xfdm:beginConnectorDest("bravo_ap_button_ias_long")  table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_ias_long"}) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_cmd_long() xfdm:beginConnectorDest("bravo_ap_button_cmd_long")  table.insert(xfdm.aircrafts.ffa320.pushPullEndQueue, {cName="bravo_ap_button_cmd_long"}) end

function xfdm.aircrafts.ffa320:apButtonRunner()
  if table.getn(xfdm.aircrafts.ffa320.pushPullEndQueue) ~= 0 then
      local tCurrentTime = get("sim/time/total_running_time_sec")

      if (tCurrentTime - xfdm.lastBeginTime > 0.35) then
        logMsg(lastFFa320ButtonTime)
        --logMsg(tprint(xfdm.aircrafts.ffa320.pushPullEndQueue))
        for k,v in pairs(xfdm.aircrafts.ffa320.pushPullEndQueue) do
          --logMsg(v.cName)
          xfdm:endConnectorDest(v.cName)
        end
        xfdm.aircrafts.ffa320.pushPullEndQueue = nil
        xfdm.aircrafts.ffa320.pushPullEndQueue = {}
      end
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.aircrafts.ffa320:apButtonRunner()")

end