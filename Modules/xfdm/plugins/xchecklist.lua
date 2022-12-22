require("xfdm.base")

xfdm:requestConnector("checklist_toggle",   xfdmLinkCommand, "bgood/xchecklist/toggle_checklist")
xfdm:requestConnector("checklist_reset",    xfdmLinkCommand, "bgood/xchecklist/reload_checklist")
xfdm:requestConnector("checklist_check",    xfdmLinkCommand, "bgood/xchecklist/check_item")
xfdm:requestConnector("checklist_previous", xfdmLinkCommand, "bgood/xchecklist/prev_checklist")
xfdm:requestConnector("checklist_next",     xfdmLinkCommand, "bgood/xchecklist/next_checklist")