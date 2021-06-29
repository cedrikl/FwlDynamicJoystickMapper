local tpr = {}

function tpr.map(joy_num)

  start_axis = joy_num * 25

  logMsg(string.format("Champion Info: Mapping a Thrustmaster TPR starting at %i", start_axis))

  tpr.yaw     = start_axis
  tpr.brake_l = start_axis + 1
  tpr.brake_r = start_axis + 2

end

return tpr