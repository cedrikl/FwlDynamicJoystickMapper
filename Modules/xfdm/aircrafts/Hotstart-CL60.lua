require("xfdm.base")
require("xfdm.joysticks.honeycomb_bravo")

if string.find(PLANE_ICAO, "CL60") then

--Acceleration Tuning
xfdm.joysticks.honeycomb_bravo.sAccelThreshold  = 6
xfdm.joysticks.honeycomb_bravo.sAccelMultiplier = 2
xfdm.joysticks.honeycomb_bravo.sAccelMaxMultiplier = 10

xfdm:requestConnector("cmd_at_disc", xfdmConOutSimCommand, "CL650/pedestal/throttle/at_disc_L")
xfdm:requestConnector("cmd_ap_toga", xfdmConOutSimCommand, "CL650/pedestal/throttle/toga_L")
xfdm:requestConnector("cmd_at_cws",  xfdmConOutSimCommand, "CL650/contwheel/0/trim_disc")

xfdm:requestConnector("view_1", xfdmConOutSimCommand, "sim/view/default_view")
xfdm:requestConnector("view_6", xfdmConOutSimCommand, "sim/view/circle")

xfdm:requestConnector("checklist_check",    xfdmConOutSimCommand, "CL650/checklist/check_item")
xfdm:requestConnector("checklist_toggle",   xfdmConOutSimCommand, "CL650/checklist/skip_item")
xfdm:requestConnector("checklist_reset",    xfdmConOutSimCommand, "CL650/checklist/restart_cur_checklist")
xfdm:requestConnector("checklist_next",     xfdmConOutSimCommand, "CL650/checklist/next_checklist")
xfdm:requestConnector("checklist_previous", xfdmConOutSimCommand, "CL650/checklist/prev_checklist")

xfdm:requestConnector("anti_ice_eng_on",             xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("anti_ice_eng_off",            xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("anti_ice_wing_on",            xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("anti_ice_wing_off",           xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_strobe_on",            xfdmConOutSimCommand,  xfdmNullLink)
xfdm:requestConnector("lights_strobe_off",           xfdmConOutSimCommand,  xfdmNullLink)

end