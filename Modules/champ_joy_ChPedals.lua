local ch_pedals = {}

function ch_pedals.map(joy_num, joy_hid_pointer)

  start_axis   = joy_num * 25
  start_button = joy_num * 160

  ch_pedals.connected = false
  if (nil ~= joy_hid_pointer) then
    ch_pedals.connected = true
  end


  logMsg(string.format("Champion Info: Mapping a CH Product Pro Pedals starting at %i", start_axis))

  ch_pedals.yaw     = start_axis
  ch_pedals.brake_r = start_axis + 1
  ch_pedals.brake_l = start_axis + 2

end

return ch_pedals