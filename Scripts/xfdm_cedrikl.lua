require("xfdm.base")
require("xfdm.xplane")

require("xfdm.plugins.xchecklist")
require("xfdm.plugins.x-camera")

pedals    = require("xfdm.joysticks.thrustmaster_tpr")
sidestick = require("xfdm.joysticks.virpil_cm3_aprime_l")
throttles = require("xfdm.joysticks.honeycomb_bravo")

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

xfdm:requestMapping("white_flashlight",       xfdmConInButton, throttles.sw4_up)
xfdm:requestMapping("bravo_axis_1",           xfdmConInAxis,   throttles.axis1)
xfdm:requestMapping("bravo_axis_2",           xfdmConInAxis,   throttles.axis2)
xfdm:requestMapping("bravo_axis12_2nd_func",  xfdmConInButton, throttles.axis12_2nd_func)
xfdm:requestMapping("bravo_axis_3",           xfdmConInAxis,   throttles.axis3)
xfdm:requestMapping("bravo_axis_4",           xfdmConInAxis,   throttles.axis4)
xfdm:requestMapping("bravo_axis_5",           xfdmConInAxis,   throttles.axis5)
xfdm:requestMapping("bravo_axis_6",           xfdmConInAxis,   throttles.axis6)

if (pedals    == xfdmJoyNc or 
    sidestick == xfdmJoyNc or
    throttles == xfdmJoyNc) then
  xfdm.msg = "XFDM (Error): A required connected joystick could not be detected."
  logMsg("XFDM (Error): A required connected joystick could not be detected.")
else
  do_every_frame("xfdm:runner()")
end
