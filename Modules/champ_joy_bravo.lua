local bravo = {}

function bravo.map(joy_num)

  start_axis   = joy_num * 25
  start_button = joy_num * 160

  logMsg(string.format("Champion Info: Mapping a Honeycomb Aeronautical Bravo Throttle Quadrant at (Axis=%i Buttons=%i)", start_axis, start_button))

  bravo.axis1 = start_axis
  bravo.axis2 = start_axis + 1
  bravo.axis3 = start_axis + 2
  bravo.axis4 = start_axis + 3
  bravo.axis5 = start_axis + 4
  bravo.axis6 = start_axis + 5

  --Buttons
  bravo.ap_hdg           = start_button       --sim/autopilot/heading
  bravo.ap_nav           = start_button + 1   --sim/autopilot/hdg_nav
  bravo.ap_apr           = start_button + 2   --sim/autopilot/approach
  bravo.ap_rev           = start_button + 3   --sim/autopilot/back_course
  bravo.ap_alt           = start_button + 4   --sim/autopilot/altitude_hold
  bravo.ap_vs            = start_button + 5   --sim/autopilot/vertical_speed
  bravo.ap_ias           = start_button + 6   --sim/autopilot/autothrottle_toggle
  bravo.ap_master        = start_button + 7   --sim/autopilot/servos_toggle
  bravo.axis2_rev_handle = start_button + 8
  bravo.axis3_rev_handle = start_button + 9
  bravo.axis4_rev_handle = start_button + 10
  bravo.axis5_rev_handle = start_button + 11
  bravo.ap_incr          = start_button + 12
  bravo.ap_decr          = start_button + 13
  bravo.flaps_dn         = start_button + 14  --sim/flight_controls/flaps_down
  bravo.flaps_up         = start_button + 15  --sim/flight_controls/flaps_up
  bravo.ap_mode_ias      = start_button + 16
  bravo.ap_mode_crs      = start_button + 17
  bravo.ap_mode_hdg      = start_button + 18
  bravo.ap_mode_vs       = start_button + 19
  bravo.ap_mode_alt      = start_button + 20
  bravo.trim_dn          = start_button + 21  --sim/flight_controls/pitch_trim_down
  bravo.trim_up          = start_button + 22  --sim/flight_controls/pitch_trim_up
  bravo.axis1_rev_zone   = start_button + 23
  bravo.axis2_rev_zone   = start_button + 24
  bravo.axis3_rev_zone   = start_button + 25
  bravo.axis4_rev_zone   = start_button + 26
  bravo.axis5_rev_zone   = start_button + 27

  --These next two share electrical discrete input
  bravo.axis1_special    = start_button + 28
  bravo.axis2_toga       = start_button + 28

  bravo.axis3_toga       = start_button + 29
  bravo.gear_up          = start_button + 30  --sim/flight_controls/landing_gear_up
  bravo.gear_dn          = start_button + 31  --sim/flight_controls/landing_gear_down
  bravo.axis6_rev_zone   = start_button + 32
  bravo.sw1_up           = start_button + 33
  bravo.sw1_dn           = start_button + 34
  bravo.sw2_up           = start_button + 35
  bravo.sw2_dn           = start_button + 36
  bravo.sw3_up           = start_button + 37
  bravo.sw3_dn           = start_button + 38
  bravo.sw4_up           = start_button + 39
  bravo.sw4_dn           = start_button + 40
  bravo.sw5_up           = start_button + 41
  bravo.sw5_dn           = start_button + 42
  bravo.sw6_up           = start_button + 43
  bravo.sw6_dn           = start_button + 44
  bravo.sw7_up           = start_button + 45
  bravo.sw7_dn           = start_button + 46

end

return bravo