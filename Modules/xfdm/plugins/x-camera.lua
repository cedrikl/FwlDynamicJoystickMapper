require("xfdm.base")

xfdm:requestConnector("view_1", xfdmConOutSimCommand, "SRS/X-Camera/Select_View_ID_1")
xfdm:requestConnector("view_6", xfdmConOutSimCommand, "SRS/X-Camera/Select_View_ID_6")

xfdm:requestConnector("toggle_trackir", xfdmConOutSimCommand, "SRS/X-Camera/Toggle_TrackIR_on_or_off_for_this_camera")