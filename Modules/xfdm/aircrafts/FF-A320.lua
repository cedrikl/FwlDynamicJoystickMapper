require("xfdm.base")

if (string.find(PLANE_ICAO, "A320")) then

  xfdm:requestConnector("nose_light_pos", xfdmLinkDataref, "model/controls/light_nose")

  xfdm:requestConnector("landing_lights", xfdmLinkDataref, "N/A")
  xfdm:requestConnector("taxi_lights",    xfdmLinkDataref, "N/A")
  --xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_nose_light")
end

function xfdm_set_nose_light()
end