require("xfdm.base")

xfdm:requestConnector("checklist_toggle",   xfdmConOutSimCommand, "bgood/xchecklist/toggle_checklist")
xfdm:requestConnector("checklist_reset",    xfdmConOutSimCommand, "bgood/xchecklist/reload_checklist")
xfdm:requestConnector("checklist_check",    xfdmConOutSimCommand, "bgood/xchecklist/check_item")
xfdm:requestConnector("checklist_previous", xfdmConOutSimCommand, "bgood/xchecklist/prev_checklist")
xfdm:requestConnector("checklist_next",     xfdmConOutSimCommand, "bgood/xchecklist/next_checklist")