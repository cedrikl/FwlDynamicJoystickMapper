require("xfdm.base")

xfdm:requestConnector("cmd_ap_disc",             xfdmConOutSimCommand, "sim/autopilot/servos_off_any")
xfdm:requestConnector("cmd_ap_toga",             xfdmConOutSimCommand, "sim/autopilot/take_off_go_around")
xfdm:requestConnector("cmd_pitch_trim_down",     xfdmConOutSimCommand, "sim/flight_controls/pitch_trim_down")
xfdm:requestConnector("cmd_pitch_trim_up",       xfdmConOutSimCommand, "sim/flight_controls/pitch_trim_up")
xfdm:requestConnector("cmd_at_toga",             xfdmConOutSimCommand, "sim/engines/TOGA_power")
xfdm:requestConnector("cmd_at_disc",             xfdmConOutSimCommand, "sim/autopilot/autothrottle_off")

xfdm:requestConnector("eng_1_rev_toggle",        xfdmConOutSimCommand, "sim/engines/beta_toggle_1")
xfdm:requestConnector("eng_2_rev_toggle",        xfdmConOutSimCommand, "sim/engines/beta_toggle_2")
xfdm:requestConnector("eng_propmode",            xfdmConOutRwDataref, "sim/flightmodel/engine/ENGN_propmode")
xfdm:requestConnector("eng_throttle_ratio",      xfdmConOutRwDataref, "sim/cockpit2/engine/actuators/throttle_ratio")
xfdm:requestConnector("throttle_beta_rev_ratio", xfdmConOutRwDataref, "sim/cockpit2/engine/actuators/throttle_beta_rev_ratio")

xfdm:requestConnector("landing_lights",          xfdmConOutSimCommand, "sim/lights/landing_lights_on")
xfdm:requestConnector("taxi_lights",             xfdmConOutSimCommand, "sim/lights/taxi_lights_on")
xfdm:requestConnector("white_flashlight",        xfdmConOutRwDataref,  "sim/graphics/misc/white_flashlight_on")
xfdm:requestConnector("white_flashlight_toggle", xfdmConOutSimCommand, "sim/view/flashlight_wht")
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_white_flashlight()")
xfdm:requestConnector("park_brake",              xfdmConOutRwDataref, "sim/cockpit2/controls/parking_brake_ratio")
xfdm:requestConnector("park_brake_toggle",       xfdmConOutSimCommand, "sim/flight_controls/brakes_toggle_max")
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_parking_brake()")

xfdm:requestConnector("elec_bus_voltage",             xfdmConOutRwDataref, "sim/cockpit2/electrical/bus_volts")
xfdm:requestConnector("ap_hdg_mode",                  xfdmConOutRoDataref, "sim/cockpit2/autopilot/heading_mode")
xfdm:requestConnector("ap_nav_mode",                  xfdmConOutRoDataref, "sim/cockpit2/autopilot/nav_status")
xfdm:requestConnector("ap_apr_mode",                  xfdmConOutRoDataref, "sim/cockpit2/autopilot/approach_status")
xfdm:requestConnector("ap_backcrs_mode",              xfdmConOutRoDataref, "sim/cockpit2/autopilot/backcourse_status")
xfdm:requestConnector("ap_alt_mode",                  xfdmConOutRoDataref, "sim/cockpit2/autopilot/altitude_hold_status")
xfdm:requestConnector("ap_vs_mode",                   xfdmConOutRoDataref, "sim/cockpit2/autopilot/vvi_status")
xfdm:requestConnector("ap_ias_mode",                  xfdmConOutRoDataref, "sim/cockpit2/autopilot/speed_status")
xfdm:requestConnector("ap_master",                    xfdmConOutRoDataref, "sim/cockpit2/autopilot/servos_on")
xfdm:requestConnector("ldg_gear_pos",                 xfdmConOutRoDataref, "sim/flightmodel2/gear/deploy_ratio")
xfdm:requestConnector("annun_master_warning",         xfdmConOutRoDataref, "sim/cockpit2/annunciators/master_warning")
xfdm:requestConnector("annun_fire",                   xfdmConOutRoDataref, "sim/cockpit2/annunciators/engine_fires")
xfdm:requestConnector("annun_oil_press",              xfdmConOutRoDataref, "sim/cockpit2/annunciators/oil_pressure_low")
xfdm:requestConnector("annun_fuel_press",             xfdmConOutRoDataref, "sim/cockpit2/annunciators/fuel_pressure_low")
xfdm:requestConnector("anti_ice_engine",              xfdmConOutRwDataref, "sim/cockpit/switches/anti_ice_inlet_heat_per_engine")
xfdm:requestConnector("anti_ice_wing",                xfdmConOutRwDataref, "sim/cockpit/switches/anti_ice_surf_heat")
xfdm:requestConnector("anti_ice_wing_left",           xfdmConOutRwDataref, "sim/cockpit/switches/anti_ice_surf_heat_left")
xfdm:requestConnector("anti_ice_wing_right",          xfdmConOutRwDataref, "sim/cockpit/switches/anti_ice_surf_heat_right")
xfdm:requestConnector("starters",                     xfdmConOutRoDataref, "sim/cockpit2/engine/actuators/starter_hit")
xfdm:requestConnector("apu_state",                    xfdmConOutRwDataref, "sim/cockpit/engine/APU_running")
xfdm:requestConnector("annun_master_caution",         xfdmConOutRoDataref, "sim/cockpit2/annunciators/master_caution")
xfdm:requestConnector("annun_vacuum",                 xfdmConOutRoDataref, "sim/cockpit2/annunciators/low_vacuum")
xfdm:requestConnector("annun_hydpress",               xfdmConOutRwDataref, "sim/cockpit/warnings/annunciators/hydraulic_pressure")
xfdm:requestConnector("annun_pump_l",                 xfdmConOutRwDataref, "sim/cockpit2/fuel/transfer_pump_left")
xfdm:requestConnector("annun_pump_r",                 xfdmConOutRwDataref, "sim/cockpit2/fuel/transfer_pump_right")
xfdm:requestConnector("annun_parkbrake",              xfdmConOutRwDataref, "sim/flightmodel/controls/parkbrake")
xfdm:requestConnector("annun_low_volt",               xfdmConOutRwDataref, "sim/cockpit2/annunciators/low_voltage")
xfdm:requestConnector("annun_door",                   xfdmConOutRwDataref, "sim/cockpit2/switches/door_open")

xfdm:requestConnector("axis_pitch",                   xfdmConOutSimAxis, "Pitch")
xfdm:requestConnector("axis_roll",                    xfdmConOutSimAxis, "Roll")
xfdm:requestConnector("axis_yaw",                     xfdmConOutSimAxis, "Yaw")
xfdm:requestConnector("axis_throttle",                xfdmConOutSimAxis, "Throttle")
xfdm:requestConnector("axis_collective",              xfdmConOutSimAxis, "Collective")
xfdm:requestConnector("axis_left_toe_brake",          xfdmConOutSimAxis, "Left toe brake")
xfdm:requestConnector("axis_right_toe_brake",         xfdmConOutSimAxis, "Right toe brake")
xfdm:requestConnector("axis_prop",                    xfdmConOutSimAxis, "Prop")
xfdm:requestConnector("axis_mixture",                 xfdmConOutSimAxis, "Mixture")
xfdm:requestConnector("axis_carb_heat",               xfdmConOutSimAxis, "Carb heat")
xfdm:requestConnector("axis_flaps",                   xfdmConOutSimAxis, "Flaps")
xfdm:requestConnector("axis_thrust_vector",           xfdmConOutSimAxis, "Thrust vector")
xfdm:requestConnector("axis_wing_sweep",              xfdmConOutSimAxis, "Wing sweep")
xfdm:requestConnector("axis_speedbrakes",             xfdmConOutSimAxis, "Speedbrakes")
xfdm:requestConnector("axis_displacement",            xfdmConOutSimAxis, "Displacement")
xfdm:requestConnector("axis_reverse",                 xfdmConOutSimAxis, "Reverse")
xfdm:requestConnector("axis_elevator_trim",           xfdmConOutSimAxis, "Elevator trim")
xfdm:requestConnector("axis_aileron_trim",            xfdmConOutSimAxis, "Aileron trim")
xfdm:requestConnector("axis_rudder_trim",             xfdmConOutSimAxis, "Rudder trim")
xfdm:requestConnector("axis_throttle_1",              xfdmConOutSimAxis, "Throttle 1")
xfdm:requestConnector("axis_throttle_2",              xfdmConOutSimAxis, "Throttle 2")
xfdm:requestConnector("axis_throttle_3",              xfdmConOutSimAxis, "Throttle 3")
xfdm:requestConnector("axis_throttle_4",              xfdmConOutSimAxis, "Throttle 4")
xfdm:requestConnector("axis_prop_1",                  xfdmConOutSimAxis, "Prop 1")
xfdm:requestConnector("axis_prop_2",                  xfdmConOutSimAxis, "Prop 2")
xfdm:requestConnector("axis_prop_3",                  xfdmConOutSimAxis, "Prop 3")
xfdm:requestConnector("axis_prop_4",                  xfdmConOutSimAxis, "Prop 4")
xfdm:requestConnector("axis_mixture_1",               xfdmConOutSimAxis, "Mixture 1")
xfdm:requestConnector("axis_mixture_2",               xfdmConOutSimAxis, "Mixture 2")
xfdm:requestConnector("axis_mixture_3",               xfdmConOutSimAxis, "Mixture 3")
xfdm:requestConnector("axis_mixture_4",               xfdmConOutSimAxis, "Mixture 4")
xfdm:requestConnector("axis_reverse_1",               xfdmConOutSimAxis, "Reverse 1")
xfdm:requestConnector("axis_reverse_2",               xfdmConOutSimAxis, "Reverse 2")
xfdm:requestConnector("axis_reverse_3",               xfdmConOutSimAxis, "Reverse 3")
xfdm:requestConnector("axis_reverse_4",               xfdmConOutSimAxis, "Reverse 4")
xfdm:requestConnector("axis_landing_gear",            xfdmConOutSimAxis, "Landing gear")
xfdm:requestConnector("axis_nosewheel_tiller",        xfdmConOutSimAxis, "Nosewheel tiller")
xfdm:requestConnector("axis_backup_throttle",         xfdmConOutSimAxis, "Backup throttle")
xfdm:requestConnector("axis_auto_roll",               xfdmConOutSimAxis, "Auto roll")
xfdm:requestConnector("axis_auto_pitch",              xfdmConOutSimAxis, "Auto pitch")
xfdm:requestConnector("axis_cowl_flaps",              xfdmConOutSimAxis, "Cowl flaps")
xfdm:requestConnector("axis_view_left_right",         xfdmConOutSimAxis, "View left/right")
xfdm:requestConnector("axis_view_up_down",            xfdmConOutSimAxis, "View up/down")
xfdm:requestConnector("axis_view_zoom",               xfdmConOutSimAxis, "View zoom")
xfdm:requestConnector("axis_camera_left_right",       xfdmConOutSimAxis, "Camera left/right")
xfdm:requestConnector("axis_camera_up_down",          xfdmConOutSimAxis, "Camera up/down")
xfdm:requestConnector("axis_camera_zoom",             xfdmConOutSimAxis, "Camera zoom")
xfdm:requestConnector("axis_gun_bomb_left_right",     xfdmConOutSimAxis, "Gun/bomb left/right")
xfdm:requestConnector("axis_gun_bomb_up_down",        xfdmConOutSimAxis, "Gun/bomb up/down")
xfdm:requestConnector("axis_vr_touchpad_x",           xfdmConOutSimAxis, "VR Touchpad X")
xfdm:requestConnector("axis_vr_touchpad_y",           xfdmConOutSimAxis, "VR Touchpad Y")
xfdm:requestConnector("axis_vr_trigger",              xfdmConOutSimAxis, "VR Trigger")
xfdm:requestConnector("axis_custom_command",          xfdmConOutSimAxis, "Custom command(s)")
xfdm:requestConnector("axis_throttle_5",              xfdmConOutSimAxis, "Throttle 5")
xfdm:requestConnector("axis_throttle_6",              xfdmConOutSimAxis, "Throttle 6")
xfdm:requestConnector("axis_throttle_7",              xfdmConOutSimAxis, "Throttle 7")
xfdm:requestConnector("axis_throttle_8",              xfdmConOutSimAxis, "Throttle 8")
xfdm:requestConnector("axis_cowl_flaps_1",            xfdmConOutSimAxis, "Cowl flaps 1")
xfdm:requestConnector("axis_cowl_flaps_2",            xfdmConOutSimAxis, "Cowl flaps 2")
xfdm:requestConnector("axis_cowl_flaps_3",            xfdmConOutSimAxis, "Cowl flaps 3")
xfdm:requestConnector("axis_cowl_flaps_4",            xfdmConOutSimAxis, "Cowl flaps 4")
xfdm:requestConnector("axis_cowl_flaps_5",            xfdmConOutSimAxis, "Cowl flaps 5")
xfdm:requestConnector("axis_cowl_flaps_6",            xfdmConOutSimAxis, "Cowl flaps 6")
xfdm:requestConnector("axis_cowl_flaps_7",            xfdmConOutSimAxis, "Cowl flaps 7")
xfdm:requestConnector("axis_cowl_flaps_8",            xfdmConOutSimAxis, "Cowl flaps 8")
xfdm:requestConnector("axis_throttle_vertical",       xfdmConOutSimAxis, "Throttle Vertical")
xfdm:requestConnector("axis_throttle_horizontal",     xfdmConOutSimAxis, "Throttle Horizontal")
xfdm:requestConnector("axis_copilot_pitch",           xfdmConOutSimAxis, "Copilot Pitch")
xfdm:requestConnector("axis_copilot_roll",            xfdmConOutSimAxis, "Copilot Roll")
xfdm:requestConnector("axis_copilot_yaw",             xfdmConOutSimAxis, "Copilot Yaw")
xfdm:requestConnector("axis_copilot_left_toe_brake",  xfdmConOutSimAxis, "Copilot Left toe brake")
xfdm:requestConnector("axis_copilot_right_toe_brake", xfdmConOutSimAxis, "Copilot Right toe brake")

--Special provisions for the Honeycomb Bravo
xfdm:requestConnector("bravo_led_hdg",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_nav",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_apr",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_rev",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_alt",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_vs",    xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_ias",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_ap",    xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_lgg",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_lgr",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_ngg",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_ngr",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_rgg",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_rgr",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_mwar",  xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_fire",  xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_oil",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_fuelp", xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_ice",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_start", xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_apu",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_mcau",  xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_vac",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_hyd",   xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_pump",  xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_park",  xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_batt",  xfdmConOutRwDataref, xfdmNullLink)
xfdm:requestConnector("bravo_led_door",  xfdmConOutRwDataref, xfdmNullLink)

function xfdm_set_white_flashlight()
  local tLightPos = xfdm:readConnectorDest("white_flashlight")
  local tSwPos = xfdm:readConnectorSrc("white_flashlight")
  if (tSwPos and (tLightPos < 0.0001)) then
    xfdm:driveConnectorDest("white_flashlight_toggle")
  elseif (not(tSwPos) and (tLightPos > 0.9999)) then
    xfdm:driveConnectorDest("white_flashlight_toggle")
  end
end

function xfdm_set_parking_brake()
  local tParkPos = xfdm:readConnectorDest("park_brake")
  local tSwPos = xfdm:readConnectorSrc("park_brake")

  if (tSwPos and (tParkPos < 0.0001)) then
    xfdm:driveConnectorDest("park_brake_toggle")
  elseif (not(tSwPos) and (tParkPos > 0.9999)) then
    xfdm:driveConnectorDest("park_brake_toggle")
  end
end