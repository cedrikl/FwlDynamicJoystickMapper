require("xfdm.base")
require("xfdm.xplane")

require("xfdm.plugins.xchecklist")
require("xfdm.plugins.x-camera")

pedals    = require("xfdm.joysticks.thrustmaster_tpr")
sidestick = require("xfdm.joysticks.virpil_cm3_aprime_l")
throttles = require("xfdm.joysticks.honeycomb_bravo")
            require("xfdm.joysticks.honeycomb_bravo_leds")

require("xfdm.aircrafts.FF-A320")

clear_all_axis_assignments()
clear_all_button_assignments()

xfdm:requestMapping("cmd_ap_disc",            xfdmConInButton, sidestick.tr_button)
xfdm:requestMapping("checklist_toggle",       xfdmConInButton, sidestick.tl_hat_up)
xfdm:requestMapping("checklist_reset",        xfdmConInButton, sidestick.tl_hat_press)
xfdm:requestMapping("checklist_check",        xfdmConInButton, sidestick.tl_hat_down)
xfdm:requestMapping("checklist_previous",     xfdmConInButton, sidestick.tl_hat_left)
xfdm:requestMapping("checklist_next",         xfdmConInButton, sidestick.tl_hat_right)
xfdm:requestMapping("view_1",                 xfdmConInButton, sidestick.side_hat_press)
xfdm:requestMapping("view_6",                 xfdmConInButton, sidestick.pinkie)
xfdm:requestMapping("axis_roll",              xfdmConInAxis,   sidestick.axis_roll)
xfdm:requestMapping("axis_pitch",             xfdmConInAxis,   sidestick.axis_pitch)
xfdm:requestMapping("axis_view_up_down",      xfdmConInAxis,   sidestick.axis_view_y)
xfdm:requestMapping("axis_view_left_right",   xfdmConInAxis,   sidestick.axis_view_x)

xfdm:requestMapping("axis_yaw",               xfdmConInAxis,   pedals.yaw)
xfdm:requestMapping("axis_left_toe_brake",    xfdmConInAxis,   pedals.brake_l,"reverse")
xfdm:requestMapping("axis_right_toe_brake",   xfdmConInAxis,   pedals.brake_r,"reverse")

xfdm:requestMapping("park_brake",             xfdmConInButton, throttles.sw1_up)
xfdm:requestMapping("anti_ice_eng_on",        xfdmConInButton, throttles.sw2_up)
xfdm:requestMapping("anti_ice_eng_off",       xfdmConInButton, throttles.sw2_dn)
xfdm:requestMapping("anti_ice_wing_on",       xfdmConInButton, throttles.sw3_up)
xfdm:requestMapping("anti_ice_wing_off",      xfdmConInButton, throttles.sw3_dn)
xfdm:requestMapping("white_flashlight",       xfdmConInButton, throttles.sw4_up)
xfdm:requestMapping("lights_strobe_on",       xfdmConInButton, throttles.sw5_up)
xfdm:requestMapping("lights_strobe_off",      xfdmConInButton, throttles.sw5_dn)
xfdm:requestMapping("lights_taxi_on",         xfdmConInButton, throttles.sw6_up)
xfdm:requestMapping("lights_taxi_off",        xfdmConInButton, throttles.sw6_dn)
xfdm:requestMapping("lights_ldg_on",          xfdmConInButton, throttles.sw7_up)
xfdm:requestMapping("lights_ldg_off",         xfdmConInButton, throttles.sw7_dn)

xfdm:requestMapping("flaps_up",               xfdmConInButton, throttles.flaps_up)
xfdm:requestMapping("flaps_down",             xfdmConInButton, throttles.flaps_dn)
xfdm:requestMapping("gear_up",                xfdmConInButton, throttles.gear_up)
xfdm:requestMapping("gear_down",              xfdmConInButton, throttles.gear_dn)
xfdm:requestMapping("trim_pitch_up",          xfdmConInButton, throttles.trim_dn)
xfdm:requestMapping("trim_pitch_down",        xfdmConInButton, throttles.trim_up)

xfdm:requestMapping("bravo_axis_1",           xfdmConInAxis,   throttles.axis1)
xfdm:requestMapping("bravo_axis_2",           xfdmConInAxis,   throttles.axis2)
xfdm:requestMapping("bravo_axis12_2nd_func",  xfdmConInButton, throttles.axis12_2nd_func)
xfdm:requestMapping("bravo_axis_3",           xfdmConInAxis,   throttles.axis3)
xfdm:requestMapping("bravo_axis3_2nd_func",   xfdmConInButton, throttles.axis3_2nd_func)
xfdm:requestMapping("bravo_axis_4",           xfdmConInAxis,   throttles.axis4)
xfdm:requestMapping("bravo_axis_5",           xfdmConInAxis,   throttles.axis5)
xfdm:requestMapping("bravo_axis_6",           xfdmConInAxis,   throttles.axis6)

xfdm:requestMapping("bravo_axis_1_rev_zone",  xfdmConInButton, throttles.axis1_rev_zone)
xfdm:requestMapping("bravo_axis_2_rev_zone",  xfdmConInButton, throttles.axis2_rev_zone)
xfdm:requestMapping("bravo_axis_3_rev_zone",  xfdmConInButton, throttles.axis3_rev_zone)
xfdm:requestMapping("bravo_axis_4_rev_zone",  xfdmConInButton, throttles.axis4_rev_zone)
xfdm:requestMapping("bravo_axis_5_rev_zone",  xfdmConInButton, throttles.axis5_rev_zone)
xfdm:requestMapping("bravo_axis_6_rev_zone",  xfdmConInButton, throttles.axis6_rev_zone)

xfdm:requestMapping("bravo_ap_dial_cw",       xfdmConInButton, throttles.ap_incr)
xfdm:requestMapping("bravo_ap_dial_ccw",      xfdmConInButton, throttles.ap_decr)
xfdm:requestMapping("bravo_ap_button_hdg",    xfdmConInButton, throttles.ap_hdg)
xfdm:requestMapping("bravo_ap_button_nav",    xfdmConInButton, throttles.ap_nav)
xfdm:requestMapping("bravo_ap_button_apr",    xfdmConInButton, throttles.ap_apr)
xfdm:requestMapping("bravo_ap_button_rev",    xfdmConInButton, throttles.ap_rev)
xfdm:requestMapping("bravo_ap_button_alt",    xfdmConInButton, throttles.ap_alt)
xfdm:requestMapping("bravo_ap_button_vs",     xfdmConInButton, throttles.ap_vs)
xfdm:requestMapping("bravo_ap_button_ias",    xfdmConInButton, throttles.ap_ias)
xfdm:requestMapping("bravo_ap_button_cmd",    xfdmConInButton, throttles.ap_master)

xfdm:requestMapping("bravo_ap_mode_hdg",      xfdmConInButton, throttles.ap_mode_hdg)
xfdm:requestMapping("bravo_ap_mode_alt",      xfdmConInButton, throttles.ap_mode_alt)
xfdm:requestMapping("bravo_ap_mode_ver",      xfdmConInButton, throttles.ap_mode_vs)
xfdm:requestMapping("bravo_ap_mode_ias",      xfdmConInButton, throttles.ap_mode_ias)
xfdm:requestMapping("bravo_ap_mode_crs",      xfdmConInButton, throttles.ap_mode_crs)


if (pedals.state    == xfdmJoyNc or 
    sidestick.state == xfdmJoyNc or
    throttles.state == xfdmJoyNc) then
  xfdm.msg = "XFDM (Error): A required connected joystick could not be detected."
  logMsg("XFDM (Error): A required connected joystick could not be detected.")
else
  do_every_frame("xfdm:runner()")
  xfdm.joysticks.honeycomb_bravo.leds:runner()
end
