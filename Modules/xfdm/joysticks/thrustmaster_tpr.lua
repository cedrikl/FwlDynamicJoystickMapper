require("xfdm.joysticks.base")

xfdm.joysticks.tpr = {}

local vid = 0x044f
local pid = 0xb68f

local device_pointer = hid_open(vid, pid)

if (device_pointer == nil) then
  xfdm.joysticks.tpr = xfdmJoyNc
  logMsg("XFDM - Joysticks(warning): Could not detect a Thrustmaster TPR.")
else
  hid_close(device_pointer)
  local start_axis = xfdm.joysticks.detect(vid, pid) * 25

  logMsg(string.format("XFDM - Joysticks: Mapping a Thrustmaster TPR starting at (Axis=%i)", start_axis))

  xfdm.joysticks.tpr.yaw     = start_axis
  xfdm.joysticks.tpr.brake_l = start_axis + 1
  xfdm.joysticks.tpr.brake_r = start_axis + 2
end

return xfdm.joysticks.tpr
