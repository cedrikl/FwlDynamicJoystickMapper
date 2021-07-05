local ch_pedals = {}

function ch_pedals.map(joy_num)

  start_axis   = joy_num * 25
  start_button = joy_num * 160

  logMsg(string.format("Champion Info: Mapping a CH Products Pro Pedals starting at %i", start_axis))

  ch_pedals.yaw     = start_axis
  ch_pedals.brake_r = start_axis + 1
  ch_pedals.brake_l = start_axis + 2

end

return ch_pedals