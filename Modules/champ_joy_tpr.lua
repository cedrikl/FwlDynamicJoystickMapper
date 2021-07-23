local tpr = {}

function tpr.map(joy_num, joy_hid_pointer)

  start_axis = joy_num * 25

  tpr.connected = false
  if (nil ~= joy_hid_pointer) then
    tpr.connected = true
  end

  logMsg(string.format("Champion Info: Mapping a Thrustmaster TPR starting at %i", start_axis))

  tpr.yaw     = start_axis
  tpr.brake_l = start_axis + 1
  tpr.brake_r = start_axis + 2

end

return tpr