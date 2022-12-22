require("xfdm.base")
require("xfdm.xplane")

require("xfdm.plugins.xchecklist")

pedals    = require("xfdm.joysticks.thrustmaster_tpr")
sidestick = require("xfdm.joysticks.virpil_cm3_aprime_l")

clear_all_axis_assignments()
clear_all_button_assignments()

xfdm:requestMapping("cmd_ap_disc",            xfdmIoBbutton, sidestick.tr_button)
xfdm:requestMapping("checklist_toggle",       xfdmIoBbutton, sidestick.tl_hat_up)
xfdm:requestMapping("checklist_reset",        xfdmIoBbutton, sidestick.tl_hat_press)
xfdm:requestMapping("checklist_check",        xfdmIoBbutton, sidestick.tl_hat_down)
xfdm:requestMapping("checklist_previous",     xfdmIoBbutton, sidestick.tl_hat_left)
xfdm:requestMapping("checklist_next",         xfdmIoBbutton, sidestick.tl_hat_right)
xfdm:requestMapping("axis_roll",              xfdmIoAxis,    sidestick.axis_roll)
xfdm:requestMapping("axis_pitch",             xfdmIoAxis,    sidestick.axis_pitch)
xfdm:requestMapping("axis_view_up_down",      xfdmIoAxis,    sidestick.axis_view_y)
xfdm:requestMapping("axis_camera_left_right", xfdmIoAxis,    sidestick.axis_view_x)
xfdm:requestMapping("axis_yaw",               xfdmIoAxis,    pedals.yaw)
xfdm:requestMapping("axis_left_toe_brake",    xfdmIoAxis,    pedals.brake_l,"reverse")
xfdm:requestMapping("axis_right_toe_brake",   xfdmIoAxis,    pedals.brake_r,"reverse")

if (pedals == xfdmJoyNc or sidestick == xfdmJoyNc) then
  xfdm.msg = "XFDM (Error): A required connected joystick could not be detected."
  logMsg("XFDM (Error): A required connected joystick could not be detected.")
else
  do_every_frame("xfdm:runner()")
end
