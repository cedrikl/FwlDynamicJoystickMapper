require("xfdm.joysticks.base")

if not xfdm.joysticks.honeycomb_bravo then
  xfdm.joysticks.honeycomb_bravo = {}
end

local vid = 0x294b
local pid = 0x1901

local device_pointer = hid_open(vid, pid)

if (device_pointer == nil) then
  xfdm.joysticks.honeycomb_bravo = xfdmJoyNc
  logMsg("XFDM - Joysticks(warning): Could not detect a Honeycomb Aeronautical Bravo Throttle Quadrant.")
else
  hid_close(device_pointer)

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
  --xfdm:requestCallback(xfdmCallbackAlways, "xfdm_set_jet_reversers()")
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

return xfdm.joysticks.honeycomb_bravo