require("xfdm.joysticks.base")

xfdm.joysticks.ch_pedals = {}

local vid = 0x068e
local pid = 0x00f2

local device_pointer = hid_open(vid, pid)

if (device_pointer == nil) then
  xfdm.joysticks.ch_pedals.state = xfdmJoyNc
  logMsg("XFDM - Joysticks(warning): Could not detect a CH Product Pro Pedals.")
else
  hid_close(device_pointer)
  xfdm.joysticks.ch_pedals.state = xfdmJoyOk

  local start_axis = xfdm.joysticks.detect(vid, pid) * 25

  logMsg(string.format("XFDM - Joysticks: Mapping a CH Product Pro Pedals starting at (Axis=%i)", start_axis))

  xfdm.joysticks.ch_pedals.yaw     = start_axis
  xfdm.joysticks.ch_pedals.brake_r = start_axis + 1
  xfdm.joysticks.ch_pedals.brake_l = start_axis + 2
end

return xfdm.joysticks.ch_pedals
