require("xfdm.joysticks.base")

xfdm.joysticks.thrustmaster_tpr = {}

local vid = 0x044f
local pid = 0xb68f

local device_pointer = hid_open(vid, pid)

if (device_pointer == nil) then
  xfdm.joysticks.thrustmaster_tpr.state = xfdmJoyNc
  logMsg("XFDM - Joysticks(warning): Could not detect a Thrustmaster TPR.")
else
  hid_close(device_pointer)
  xfdm.joysticks.thrustmaster_tpr.state = xfdmJoyOk

  local start_axis = xfdm.joysticks.detect(vid, pid) * 25

  logMsg(string.format("XFDM - Joysticks: Mapping a Thrustmaster TPR starting at (Axis=%i)", start_axis))

  xfdm.joysticks.thrustmaster_tpr.yaw     = start_axis
  xfdm.joysticks.thrustmaster_tpr.brake_l = start_axis + 1
  xfdm.joysticks.thrustmaster_tpr.brake_r = start_axis + 2
end

return xfdm.joysticks.thrustmaster_tpr
