require("xfdm.joysticks.base")

xfdmNullTimestamp = -1

xfdm.joysticks.honeycomb_bravo = {}
xfdm.joysticks.honeycomb_bravo.ap = {}

xfdmApModeNull = -1
xfdmApModeAlt = 1
xfdmApModeVs  = 2
xfdmApModeHdg = 3
xfdmApModeCrs = 4
xfdmApModeIas = 5
xfdm.joysticks.honeycomb_bravo.ap["bravo_ap_button_dial"] = {cPreDir = 0, cAccel = 1, cPreMode = xfdmApModeNull, cLastTickTime = xfdmNullTimestamp}

xfdm.joysticks.honeycomb_bravo.ap["bravo_ap_button_hdg"] = {cPressTimestamp = xfdmNullTimestamp, cReleaseTimestamp = xfdmNullTimestamp}
xfdm.joysticks.honeycomb_bravo.ap["bravo_ap_button_nav"] = {cPressTimestamp = xfdmNullTimestamp, cReleaseTimestamp = xfdmNullTimestamp}
xfdm.joysticks.honeycomb_bravo.ap["bravo_ap_button_apr"] = {cPressTimestamp = xfdmNullTimestamp, cReleaseTimestamp = xfdmNullTimestamp}
xfdm.joysticks.honeycomb_bravo.ap["bravo_ap_button_rev"] = {cPressTimestamp = xfdmNullTimestamp, cReleaseTimestamp = xfdmNullTimestamp}
xfdm.joysticks.honeycomb_bravo.ap["bravo_ap_button_alt"] = {cPressTimestamp = xfdmNullTimestamp, cReleaseTimestamp = xfdmNullTimestamp}
xfdm.joysticks.honeycomb_bravo.ap["bravo_ap_button_vs"]  = {cPressTimestamp = xfdmNullTimestamp, cReleaseTimestamp = xfdmNullTimestamp}
xfdm.joysticks.honeycomb_bravo.ap["bravo_ap_button_ias"] = {cPressTimestamp = xfdmNullTimestamp, cReleaseTimestamp = xfdmNullTimestamp}
xfdm.joysticks.honeycomb_bravo.ap["bravo_ap_button_cmd"] = {cPressTimestamp = xfdmNullTimestamp, cReleaseTimestamp = xfdmNullTimestamp}

local vid = 0x294b
local pid = 0x1901

local device_pointer = hid_open(vid, pid)

if (device_pointer == nil) then
  xfdm.joysticks.honeycomb_bravo.state = xfdmJoyNc
  logMsg("XFDM - Joysticks(warning): Could not detect a Honeycomb Aeronautical Bravo Throttle Quadrant.")
else
  hid_close(device_pointer)
  xfdm.joysticks.honeycomb_bravo.state = xfdmJoyOk

  local start_axis   = xfdm.joysticks.detect(vid, pid) * 25
  local start_button = xfdm.joysticks.detect(vid, pid) * 160

  logMsg(string.format("XFDM - Joysticks: Mapping a Honeycomb Aeronautical Bravo Throttle Quadrant starting at (Axis=%i Buttons=%i)", start_axis, start_button))

  --Axis
  xfdm.joysticks.honeycomb_bravo.axis1 = start_axis
  xfdm.joysticks.honeycomb_bravo.axis2 = start_axis + 1
  xfdm.joysticks.honeycomb_bravo.axis3 = start_axis + 2
  xfdm.joysticks.honeycomb_bravo.axis4 = start_axis + 3
  xfdm.joysticks.honeycomb_bravo.axis5 = start_axis + 4
  xfdm.joysticks.honeycomb_bravo.axis6 = start_axis + 5

  --Buttons
  xfdm.joysticks.honeycomb_bravo.ap_hdg           = start_button       --sim/autopilot/heading
  xfdm.joysticks.honeycomb_bravo.ap_nav           = start_button + 1   --sim/autopilot/hdg_nav
  xfdm.joysticks.honeycomb_bravo.ap_apr           = start_button + 2   --sim/autopilot/approach
  xfdm.joysticks.honeycomb_bravo.ap_rev           = start_button + 3   --sim/autopilot/back_course
  xfdm.joysticks.honeycomb_bravo.ap_alt           = start_button + 4   --sim/autopilot/altitude_hold
  xfdm.joysticks.honeycomb_bravo.ap_vs            = start_button + 5   --sim/autopilot/vertical_speed
  xfdm.joysticks.honeycomb_bravo.ap_ias           = start_button + 6   --sim/autopilot/autothrottle_toggle
  xfdm.joysticks.honeycomb_bravo.ap_master        = start_button + 7   --sim/autopilot/servos_toggle
  xfdm.joysticks.honeycomb_bravo.axis2_rev_handle = start_button + 8
  xfdm.joysticks.honeycomb_bravo.axis3_rev_handle = start_button + 9
  xfdm.joysticks.honeycomb_bravo.axis4_rev_handle = start_button + 10
  xfdm.joysticks.honeycomb_bravo.axis5_rev_handle = start_button + 11
  xfdm.joysticks.honeycomb_bravo.ap_incr          = start_button + 12
  xfdm.joysticks.honeycomb_bravo.ap_decr          = start_button + 13
  xfdm.joysticks.honeycomb_bravo.flaps_dn         = start_button + 14  --sim/flight_controls/flaps_down
  xfdm.joysticks.honeycomb_bravo.flaps_up         = start_button + 15  --sim/flight_controls/flaps_up
  xfdm.joysticks.honeycomb_bravo.ap_mode_ias      = start_button + 16
  xfdm.joysticks.honeycomb_bravo.ap_mode_crs      = start_button + 17
  xfdm.joysticks.honeycomb_bravo.ap_mode_hdg      = start_button + 18
  xfdm.joysticks.honeycomb_bravo.ap_mode_vs       = start_button + 19
  xfdm.joysticks.honeycomb_bravo.ap_mode_alt      = start_button + 20
  xfdm.joysticks.honeycomb_bravo.trim_dn          = start_button + 21  --sim/flight_controls/pitch_trim_down
  xfdm.joysticks.honeycomb_bravo.trim_up          = start_button + 22  --sim/flight_controls/pitch_trim_up
  xfdm.joysticks.honeycomb_bravo.axis1_rev_zone   = start_button + 23
  xfdm.joysticks.honeycomb_bravo.axis2_rev_zone   = start_button + 24
  xfdm.joysticks.honeycomb_bravo.axis3_rev_zone   = start_button + 25
  xfdm.joysticks.honeycomb_bravo.axis4_rev_zone   = start_button + 26
  xfdm.joysticks.honeycomb_bravo.axis5_rev_zone   = start_button + 27

  --Axis 1-2 share the same alternate digital input
  xfdm.joysticks.honeycomb_bravo.axis12_2nd_func  = start_button + 28
  xfdm.joysticks.honeycomb_bravo.axis1_rev_handle = start_button + 28

  xfdm.joysticks.honeycomb_bravo.axis3_2nd_func   = start_button + 29
  xfdm.joysticks.honeycomb_bravo.gear_up          = start_button + 30  --sim/flight_controls/landing_gear_up
  xfdm.joysticks.honeycomb_bravo.gear_dn          = start_button + 31  --sim/flight_controls/landing_gear_down
  xfdm.joysticks.honeycomb_bravo.axis6_rev_zone   = start_button + 32
  xfdm.joysticks.honeycomb_bravo.sw1_up           = start_button + 33
  xfdm.joysticks.honeycomb_bravo.sw1_dn           = start_button + 34
  xfdm.joysticks.honeycomb_bravo.sw2_up           = start_button + 35
  xfdm.joysticks.honeycomb_bravo.sw2_dn           = start_button + 36
  xfdm.joysticks.honeycomb_bravo.sw3_up           = start_button + 37
  xfdm.joysticks.honeycomb_bravo.sw3_dn           = start_button + 38
  xfdm.joysticks.honeycomb_bravo.sw4_up           = start_button + 39
  xfdm.joysticks.honeycomb_bravo.sw4_dn           = start_button + 40
  xfdm.joysticks.honeycomb_bravo.sw5_up           = start_button + 41
  xfdm.joysticks.honeycomb_bravo.sw5_dn           = start_button + 42
  xfdm.joysticks.honeycomb_bravo.sw6_up           = start_button + 43
  xfdm.joysticks.honeycomb_bravo.sw6_dn           = start_button + 44
  xfdm.joysticks.honeycomb_bravo.sw7_up           = start_button + 45
  xfdm.joysticks.honeycomb_bravo.sw7_dn           = start_button + 46

  xfdm.joysticks.honeycomb_bravo.axis4_2nd_func   = start_button + 47
end

xfdm:requestConnector("bravo_axis_1",          xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_2",          xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis12_2nd_func", xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_3",          xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis3_2nd_func",  xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_4",          xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_5",          xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_6",          xfdmConOutRwDataref, xfdmNullLink)

xfdm:requestConnector("bravo_axis_1_rev_zone", xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_2_rev_zone", xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_3_rev_zone", xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_4_rev_zone", xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_5_rev_zone", xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_6_rev_zone", xfdmConOutRwDataref, xfdmNullLink)

xfdm:requestConnector("bravo_axis_2_rev_handle", xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_3_rev_handle", xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_4_rev_handle", xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_axis_5_rev_handle", xfdmConOutRwDataref, xfdmNullLink)

xfdm:requestConnector("bravo_ap_dial_cw",        xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_dial_ccw",       xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_dial_hdg_cw",    xfdmConOutSimCommand, "sim/autopilot/heading_up")
xfdm:requestConnector("bravo_ap_dial_crs_cw",    xfdmConOutSimCommand, "sim/GPS/g1000n1_crs_up")
xfdm:requestConnector("bravo_ap_dial_alt_cw",    xfdmConOutSimCommand, "sim/autopilot/altitude_up")
xfdm:requestConnector("bravo_ap_dial_ver_cw",    xfdmConOutSimCommand, "sim/autopilot/vertical_speed_up")
xfdm:requestConnector("bravo_ap_dial_ias_cw",    xfdmConOutSimCommand, "sim/autopilot/airspeed_up")
xfdm:requestConnector("bravo_ap_dial_hdg_ccw",   xfdmConOutSimCommand, "sim/autopilot/heading_down")
xfdm:requestConnector("bravo_ap_dial_crs_ccw",   xfdmConOutSimCommand, "sim/GPS/g1000n1_crs_down")
xfdm:requestConnector("bravo_ap_dial_alt_ccw",   xfdmConOutSimCommand, "sim/autopilot/altitude_down")
xfdm:requestConnector("bravo_ap_dial_ver_ccw",   xfdmConOutSimCommand, "sim/autopilot/vertical_speed_down")
xfdm:requestConnector("bravo_ap_dial_ias_ccw",   xfdmConOutSimCommand, "sim/autopilot/airspeed_down")

xfdm:requestConnector("bravo_ap_button_hdg",      xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_nav",      xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_apr",      xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_rev",      xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_alt",      xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_vs",       xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_ias",      xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_cmd",      xfdmConOutRwDataref, xfdmNullLink)

xfdm:requestConnector("bravo_ap_button_hdg_short", xfdmConOutSimCommand, "sim/autopilot/heading")
xfdm:requestConnector("bravo_ap_button_nav_short", xfdmConOutSimCommand, "sim/autopilot/hdg_nav")
xfdm:requestConnector("bravo_ap_button_apr_short", xfdmConOutSimCommand, "sim/autopilot/approach")
xfdm:requestConnector("bravo_ap_button_rev_short", xfdmConOutSimCommand, "sim/autopilot/back_course")
xfdm:requestConnector("bravo_ap_button_alt_short", xfdmConOutSimCommand, "sim/autopilot/level_change")
xfdm:requestConnector("bravo_ap_button_vs_short",  xfdmConOutSimCommand, "sim/autopilot/vertical_speed")
xfdm:requestConnector("bravo_ap_button_ias_short", xfdmConOutRwDataref,  xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_cmd_short", xfdmConOutSimCommand, "sim/autopilot/servos_toggle")

xfdm:requestConnector("bravo_ap_button_hdg_long",  xfdmConOutSimCommand, "sim/autopilot/heading_hold")
xfdm:requestConnector("bravo_ap_button_nav_long",  xfdmConOutSimCommand, "sim/autopilot/vnav")
xfdm:requestConnector("bravo_ap_button_apr_long",  xfdmConOutRwDataref,  xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_rev_long",  xfdmConOutRwDataref,  xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_alt_long",  xfdmConOutSimCommand, "sim/autopilot/altitude_hold")
xfdm:requestConnector("bravo_ap_button_vs_long",   xfdmConOutRwDataref,  xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_ias_long",  xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_button_cmd_long",  xfdmConOutSimCommand, "sim/autopilot/CWSA")

xfdm:requestConnector("bravo_ap_mode_hdg",      xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_mode_alt",      xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_mode_ver",      xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_mode_ias",      xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_ap_mode_crs",      xfdmConOutRwDataref, xfdmNullLink)


local xfdmAcNbEngines  = get("sim/aircraft/engine/acf_num_engines")
local xfdmAcEngineType = get("sim/aircraft/prop/acf_en_type", 0)
local xfdmAcEngineBeta = get("sim/aircraft/overflow/acf_has_beta")
logMsg(string.format("XFDM - Honeycomb Bravo: The number of engines is %i (ICAO: %s Type: %i, Beta: %s)", xfdmAcNbEngines, PLANE_ICAO, xfdmAcEngineType, xfdmAcEngineBeta))

if (((xfdmAcEngineType <= 4) and (xfdmAcNbEngines <= 2)) or
      (PLANE_ICAO == "B350") or (PLANE_ICAO == "BE9L")) then
  --Prop aircraft
  xfdm:requestMapping("axis_throttle_1", xfdmConInOtherCon, "bravo_axis_1", "reverse")
  xfdm:requestMapping("axis_throttle_2", xfdmConInOtherCon, "bravo_axis_2", "reverse")
  xfdm:requestMapping("axis_prop_1",     xfdmConInOtherCon, "bravo_axis_3")
  xfdm:requestMapping("axis_prop_2",     xfdmConInOtherCon, "bravo_axis_4")
  xfdm:requestMapping("axis_mixture_1",  xfdmConInOtherCon, "bravo_axis_5")
  xfdm:requestMapping("axis_mixture_2",  xfdmConInOtherCon, "bravo_axis_6")
  xfdm:requestMapping("cmd_ap_toga",     xfdmConInOtherCon, "bravo_axis12_2nd_func")
  if (xfdmAcEngineBeta) then
    xfdm:requestConnector("bravo_axis_1",   xfdmConOutSimAxis, xfdmNullLink)
    xfdm:requestConnector("bravo_axis_2",   xfdmConOutSimAxis, xfdmNullLink)
    xfdm:requestMapping("axis_throttle_1",  xfdmConInAxis, xfdmNullLink)
    xfdm:requestMapping("axis_throttle_2",  xfdmConInAxis, xfdmNullLink)
    xfdm:requestMapping("eng_1_rev_toggle", xfdmConInOtherCon, "bravo_axis_1_rev_zone")
    xfdm:requestMapping("eng_2_rev_toggle", xfdmConInOtherCon, "bravo_axis_2_rev_zone")
    xfdm:requestCallback(xfdmCallbackAlways, "xfdm_set_beta_reversers()")
  else
    set_button_assignment(btq.axis1_rev_zone, "sim/engines/thrust_reverse_toggle_1")
    set_button_assignment(btq.axis2_rev_zone, "sim/engines/thrust_reverse_toggle_2")
  end
else
  --Jets
  xfdm:requestMapping("axis_throttle_1", xfdmConInOtherCon, "bravo_axis_2", "reverse")
  xfdm:requestMapping("axis_throttle_2", xfdmConInOtherCon, "bravo_axis_3", "reverse")
  xfdm:requestMapping("axis_throttle_3", xfdmConInOtherCon, "bravo_axis_4", "reverse")
  xfdm:requestMapping("axis_throttle_4", xfdmConInOtherCon, "bravo_axis_5", "reverse")
  xfdm:requestMapping("cmd_at_disc",     xfdmConInOtherCon, "bravo_axis12_2nd_func")
  xfdm:requestMapping("cmd_at_toga",     xfdmConInOtherCon, "bravo_axis3_2nd_func")
  xfdm:requestCallback(xfdmCallbackAlways, "xfdm_set_jet_reversers()")
end


function xfdm_set_beta_reversers()
  local tEng1Mode = xfdm:readConnectorDest("eng_propmode", 0)
  local tEng1Pos  = xfdm:readConnectorDest("eng_throttle_ratio", 0)
  local tThrottle1Pos = xfdm:readConnectorSrc("bravo_axis_1")

  if     ((tEng1Mode <= 1) and (tThrottle1Pos > 0.02)) then
    xfdm:driveConnectorDest("eng_throttle_ratio", 0, tThrottle1Pos)
  elseif ((tEng1Mode <= 1) and (tThrottle1Pos < 0.02) and (tEng1Pos >= 0.02)) then
    xfdm:driveConnectorDest("eng_throttle_ratio", 0, 0)
  elseif (tEng1Mode > 1) then
    if (tThrottle1Pos < 0.45)  then --beta range
      xfdm:driveConnectorDest("throttle_beta_rev_ratio", 0, (-2 * tThrottle1Pos - 0.01))
    elseif (tThrottle1Pos > 0.50) then -- reverse
      xfdm:driveConnectorDest("throttle_beta_rev_ratio", 0, (-2 * tThrottle1Pos - 0.01))
    end
  end

  local tEng2Mode = xfdm:readConnectorDest("eng_propmode", 1)
  local tEng2Pos  = xfdm:readConnectorDest("eng_throttle_ratio", 1)
  local tThrottle2Pos = xfdm:readConnectorSrc("bravo_axis_2")

  if     ((tEng2Mode <= 1) and (tThrottle2Pos > 0.02)) then
    xfdm:driveConnectorDest("eng_throttle_ratio", 1, tThrottle2Pos)
  elseif ((tEng2Mode <= 1) and (tThrottle2Pos < 0.02) and (tEng2Pos >= 0.02)) then
    xfdm:driveConnectorDest("eng_throttle_ratio", 1, 0)
  elseif (tEng2Mode > 1) then
    if (tThrottle2Pos < 0.45)  then --beta range
      xfdm:driveConnectorDest("throttle_beta_rev_ratio", 1, (-2 * tThrottle2Pos - 0.01))
    elseif (tThrottle2Pos > 0.50) then -- reverse
      xfdm:driveConnectorDest("throttle_beta_rev_ratio", 1, (-2 * tThrottle2Pos - 0.01))
    end
  end
end


function xfdm_set_jet_reversers()
  -- Jets (Spoilers/ENG1/ENG2/ENG3/ENG4/Flaps)

  local tThrottle1Rev = xfdm:readConnectorSrc("bravo_axis_2_rev_handle")
  local tThrottle2Rev = xfdm:readConnectorSrc("bravo_axis_3_rev_handle")
  local tThrottle3Rev = xfdm:readConnectorSrc("bravo_axis_4_rev_handle")
  local tThrottle4Rev = xfdm:readConnectorSrc("bravo_axis_5_rev_handle")

  local tEng1LeverPos = xfdm:readConnectorDest("eng_throttle_ratio", 0)
  local tEng2LeverPos = xfdm:readConnectorDest("eng_throttle_ratio", 1)
  local tEng3LeverPos = xfdm:readConnectorDest("eng_throttle_ratio", 2)
  local tEng4LeverPos = xfdm:readConnectorDest("eng_throttle_ratio", 3)

  local tEng1Rev = xfdm:readConnectorDest("throttle_beta_rev_ratio", 0)
  local tEng2Rev = xfdm:readConnectorDest("throttle_beta_rev_ratio", 1)
  local tEng3Rev = xfdm:readConnectorDest("throttle_beta_rev_ratio", 2)
  local tEng4Rev = xfdm:readConnectorDest("throttle_beta_rev_ratio", 3)

  if   ((tEng1Rev >= -1) and (tEng1LeverPos < 0.05) and (tThrottle1Rev)) then
    xfdm:driveConnectorDest("throttle_beta_rev_ratio", 0, -1.0001)
  elseif ((tEng1Rev < 0) and (tEng1LeverPos < 0.05) and not(tThrottle1Rev)) then
    xfdm:driveConnectorDest("throttle_beta_rev_ratio", 0, 0)
  end

  if   ((tEng2Rev >= -1) and (tEng2LeverPos < 0.05) and (tThrottle2Rev)) then
    xfdm:driveConnectorDest("throttle_beta_rev_ratio", 1, -1.0001)
  elseif ((tEng2Rev < 0) and (tEng2LeverPos < 0.05) and not(tThrottle2Rev)) then
    xfdm:driveConnectorDest("throttle_beta_rev_ratio", 1, 0)
  end

  if   ((tEng3Rev >= -1) and (tEng3LeverPos < 0.05) and (tThrottle3Rev)) then
    xfdm:driveConnectorDest("throttle_beta_rev_ratio", 2, -1.0001)
  elseif ((tEng3Rev < 0) and (tEng3LeverPos < 0.05) and not(tThrottle3Rev)) then
    xfdm:driveConnectorDest("throttle_beta_rev_ratio", 2, 0)
  end

  if   ((tEng4Rev >= -1) and (tEng4LeverPos < 0.05) and (tThrottle4Rev == 1)) then
    xfdm:driveConnectorDest("throttle_beta_rev_ratio", 3, -1.0001)
  elseif ((tEng4Rev < 0) and (tEng4LeverPos < 0.05) and not(tThrottle4Rev ~= 1)) then
    xfdm:driveConnectorDest("throttle_beta_rev_ratio", 3, 0)
  end
end

function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_hdg_short() xfdm:driveConnectorDest("bravo_ap_button_hdg_short") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_nav_short() xfdm:driveConnectorDest("bravo_ap_button_nav_short") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_apr_short() xfdm:driveConnectorDest("bravo_ap_button_apr_short") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_rev_short() xfdm:driveConnectorDest("bravo_ap_button_rev_short") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_alt_short() xfdm:driveConnectorDest("bravo_ap_button_alt_short") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_vs_short()  xfdm:driveConnectorDest("bravo_ap_button_vs_short") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_ias_short() xfdm:driveConnectorDest("bravo_ap_button_ias_short") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_cmd_short() xfdm:driveConnectorDest("bravo_ap_button_cmd_short") end

function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_hdg_long() xfdm:driveConnectorDest("bravo_ap_button_hdg_long") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_nav_long() xfdm:driveConnectorDest("bravo_ap_button_nav_long") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_apr_long() xfdm:driveConnectorDest("bravo_ap_button_apr_long") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_rev_long() xfdm:driveConnectorDest("bravo_ap_button_rev_long") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_alt_long() xfdm:driveConnectorDest("bravo_ap_button_alt_long") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_vs_long()  xfdm:driveConnectorDest("bravo_ap_button_vs_long") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_ias_long() xfdm:driveConnectorDest("bravo_ap_button_ias_long") end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_cmd_long() xfdm:driveConnectorDest("bravo_ap_button_cmd_long") end

function xfdm.joysticks.honeycomb_bravo:checkApButton(iApButton, iCurrentTime)
  local tButtonShortPressLimit = 0.6
  local tApButton = xfdm:readConnectorSrc(iApButton) --(xfdm:readConnectorSrc(iApButton) == 0)

  if (tApButton and (self.ap[iApButton].cPressTimestamp == xfdmNullTimestamp)) then
    --Rising Edge
    self.ap[iApButton].cPressTimestamp = iCurrentTime
  elseif (not(tApButton) and (self.ap[iApButton].cPressTimestamp ~= xfdmNullTimestamp)) then
    --Falling Edge
    if (iCurrentTime - self.ap[iApButton].cPressTimestamp < tButtonShortPressLimit) then
      --Short press
      if     (iApButton == "bravo_ap_button_hdg") then self:bravo_ap_button_hdg_short()
      elseif (iApButton == "bravo_ap_button_nav") then self:bravo_ap_button_nav_short()
      elseif (iApButton == "bravo_ap_button_apr") then self:bravo_ap_button_apr_short()
      elseif (iApButton == "bravo_ap_button_rev") then self:bravo_ap_button_rev_short()
      elseif (iApButton == "bravo_ap_button_alt") then self:bravo_ap_button_alt_short()
      elseif (iApButton == "bravo_ap_button_vs")  then self:bravo_ap_button_vs_short()
      elseif (iApButton == "bravo_ap_button_ias") then self:bravo_ap_button_ias_short()
      elseif (iApButton == "bravo_ap_button_cmd") then self:bravo_ap_button_cmd_short()
      end
      self.ap[iApButton].cPressTimestamp = xfdmNullTimestamp
    else
      --Long press
      if     (iApButton == "bravo_ap_button_hdg") then self:bravo_ap_button_hdg_long()
      elseif (iApButton == "bravo_ap_button_nav") then self:bravo_ap_button_nav_long()
      elseif (iApButton == "bravo_ap_button_apr") then self:bravo_ap_button_apr_long()
      elseif (iApButton == "bravo_ap_button_rev") then self:bravo_ap_button_rev_long()
      elseif (iApButton == "bravo_ap_button_alt") then self:bravo_ap_button_alt_long()
      elseif (iApButton == "bravo_ap_button_vs")  then self:bravo_ap_button_vs_long()
      elseif (iApButton == "bravo_ap_button_ias") then self:bravo_ap_button_ias_long()
      elseif (iApButton == "bravo_ap_button_cmd") then self:bravo_ap_button_cmd_long()
      end
      self.ap[iApButton].cPressTimestamp = xfdmNullTimestamp
    end
  end
end


function xfdm.joysticks.honeycomb_bravo:apButtonRunner()
  local tCurrentTime = get("sim/time/total_running_time_sec")

  self:checkApButton("bravo_ap_button_hdg", tCurrentTime)
  self:checkApButton("bravo_ap_button_nav", tCurrentTime)
  self:checkApButton("bravo_ap_button_apr", tCurrentTime)
  self:checkApButton("bravo_ap_button_rev", tCurrentTime)
  self:checkApButton("bravo_ap_button_alt", tCurrentTime)
  self:checkApButton("bravo_ap_button_vs",  tCurrentTime)
  self:checkApButton("bravo_ap_button_ias", tCurrentTime)
  self:checkApButton("bravo_ap_button_cmd", tCurrentTime)
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo:apButtonRunner()")

function xfdm.joysticks.honeycomb_bravo:command_multiple(iCommand, iCount)
  local tRemaining = iCount
  while (tRemaining > 0)
  do
    xfdm:driveConnectorDest(iCommand)
    tRemaining = tRemaining - 1
  end
end

function xfdm.joysticks.honeycomb_bravo:getApMode()
  if    (xfdm:readConnectorSrc("bravo_ap_mode_hdg")) then return xfdmApModeHdg
  elseif(xfdm:readConnectorSrc("bravo_ap_mode_alt")) then return xfdmApModeAlt
  elseif(xfdm:readConnectorSrc("bravo_ap_mode_ver")) then return xfdmApModeVs
  elseif(xfdm:readConnectorSrc("bravo_ap_mode_ias")) then return xfdmApModeIas
  elseif(xfdm:readConnectorSrc("bravo_ap_mode_crs")) then return xfdmApModeCrs
  else return xfdmApModeNull
  end
end

function xfdm.joysticks.honeycomb_bravo:callApDialFunction(iDir, iCount, iMode)
  if    (iDir == 1) then
    if     (iMode == xfdmApModeAlt) then self:bravo_ap_dial_alt_cw(iCount)
    elseif (iMode == xfdmApModeVs)  then self:bravo_ap_dial_ver_cw(iCount)
    elseif (iMode == xfdmApModeHdg) then self:bravo_ap_dial_hdg_cw(iCount)
    elseif (iMode == xfdmApModeCrs) then self:bravo_ap_dial_crs_cw(iCount)
    elseif (iMode == xfdmApModeIas) then self:bravo_ap_dial_ias_cw(iCount)
    end
  elseif(iDir == -1) then
    if     (iMode == xfdmApModeAlt) then self:bravo_ap_dial_alt_ccw(iCount)
    elseif (iMode == xfdmApModeVs)  then self:bravo_ap_dial_ver_ccw(iCount)
    elseif (iMode == xfdmApModeHdg) then self:bravo_ap_dial_hdg_ccw(iCount)
    elseif (iMode == xfdmApModeCrs) then self:bravo_ap_dial_crs_ccw(iCount)
    elseif (iMode == xfdmApModeIas) then self:bravo_ap_dial_ias_ccw(iCount)
    end
  end
end

function xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_hdg_cw(iCount)  self:command_multiple("bravo_ap_dial_hdg_cw",  iCount) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_crs_cw(iCount)  self:command_multiple("bravo_ap_dial_crs_cw",  iCount) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_alt_cw(iCount)  self:command_multiple("bravo_ap_dial_alt_cw",  iCount) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_ver_cw(iCount)  self:command_multiple("bravo_ap_dial_ver_cw",  iCount) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_ias_cw(iCount)  self:command_multiple("bravo_ap_dial_ias_cw",  iCount) end

function xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_hdg_ccw(iCount) self:command_multiple("bravo_ap_dial_hdg_ccw", iCount) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_crs_ccw(iCount) self:command_multiple("bravo_ap_dial_crs_ccw", iCount) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_alt_ccw(iCount) self:command_multiple("bravo_ap_dial_alt_ccw", iCount) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_ver_ccw(iCount) self:command_multiple("bravo_ap_dial_ver_ccw", iCount) end
function xfdm.joysticks.honeycomb_bravo:bravo_ap_dial_ias_ccw(iCount) self:command_multiple("bravo_ap_dial_ias_ccw", iCount) end

--xfdm.joysticks.honeycomb_bravo.ap["bravo_ap_button_dial"] = {cPreDir = 0, cAccel = 1, cPreMode = xfdmApModeNull, cLastTickTime = xfdmNullTimestamp}
--bravo_ap_dial_cw
--bravo_ap_dial_ccw

function xfdm.joysticks.honeycomb_bravo:apDialAccel(iCurDir, iTimeInterval)
  if (self.ap["bravo_ap_button_dial"].cPreDir ~= iCurDir) then
    return 1
  else
    --TO DO: Build acceleration logic
    return 1
  end
end

function xfdm.joysticks.honeycomb_bravo:apDialInvoke(iCmd, iCnt)
  
end

function xfdm.joysticks.honeycomb_bravo:apDialRunner()
  local tCurrentTime = get("sim/time/total_running_time_sec")
  local tApMode = self:getApMode()
  local tDialTimeout = 1.5
  local tCurDir = 0

  if     xfdm:readConnectorSrc("bravo_ap_dial_cw")  then tCurDir = 1
  elseif xfdm:readConnectorSrc("bravo_ap_dial_ccw") then tCurDir = -1
  end

  if ((self.ap["bravo_ap_button_dial"].cLastTickTime ~= xfdmNullTimestamp) and ((tCurrentTime - self.ap["bravo_ap_button_dial"].cLastTickTime) > tDialTimeout)) then
    --Reset state
    self.ap["bravo_ap_button_dial"].cLastTickTime = xfdmNullTimestamp
    self.ap["bravo_ap_button_dial"].cPreMode      = xfdmApModeNull
    self.ap["bravo_ap_button_dial"].cAccel  = 0
    self.ap["bravo_ap_button_dial"].cPreDir = 0
  end

  if (tCurDir ~= 0) then
    local tCommandCount = self:apDialAccel(tCurDir, tCurrentTime - self.ap["bravo_ap_button_dial"].cLastTickTime)
    self:callApDialFunction(tCurDir, tCommandCount, tApMode)
  end

end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo:apDialRunner()")

return xfdm.joysticks.honeycomb_bravo