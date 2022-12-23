require("xfdm.base")

xfdm:requestConnector("cmd_ap_disc",             xfdmConOutSimCommand, "sim/autopilot/servos_off_any")
xfdm:requestConnector("cmd_ap_toga",             xfdmConOutSimCommand, "sim/autopilot/take_off_go_around")
xfdm:requestConnector("cmd_pitch_trim_down",     xfdmConOutSimCommand, "sim/flight_controls/pitch_trim_down")
xfdm:requestConnector("cmd_pitch_trim_up",       xfdmConOutSimCommand, "sim/flight_controls/pitch_trim_up")
xfdm:requestConnector("landing_lights",          xfdmConOutSimCommand, "sim/lights/landing_lights_on")
xfdm:requestConnector("taxi_lights",             xfdmConOutSimCommand, "sim/lights/taxi_lights_on")
xfdm:requestConnector("white_flashlight",        xfdmConOutRwDataref,  "sim/graphics/misc/white_flashlight_on")
xfdm:requestConnector("white_flashlight_toggle", xfdmConOutSimCommand, "sim/view/flashlight_wht")
xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_white_flashlight()")

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

function xfdm_set_white_flashlight()
  local LightPos = xfdm:readConnectorDest("white_flashlight")
  local SwPos = xfdm:readConnectorSrc("white_flashlight")
  if (SwPos and (LightPos < 0.0001)) then
    xfdm:driveConnectorDest("white_flashlight_toggle")
  elseif (not(SwPos) and (LightPos > 0.9999)) then
    xfdm:driveConnectorDest("white_flashlight_toggle")
  end
end