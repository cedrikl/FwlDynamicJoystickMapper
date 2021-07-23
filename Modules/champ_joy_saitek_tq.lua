local stq = {}

function stq.map(joy_num, joy_hid_pointer)

  start_axis   = joy_num * 25
  start_button = joy_num * 160

  stq.connected = false
  if (nil ~= joy_hid_pointer) then
    stq.connected = true
  end

  logMsg(string.format("Champion Info: Mapping a Saitek Throttle Quadrant starting at (Axis=%i Buttons=%i)", start_axis, start_button))

  --Axis
  stq.axis_r  = start_axis
  stq.axis_m  = start_axis + 1
  stq.axis_l  = start_axis + 2

  --Buttons
  stq.T1      = start_button
  stq.T2      = start_button + 1
  stq.T3      = start_button + 2
  stq.T4      = start_button + 3
  stq.T5      = start_button + 4
  stq.T6      = start_button + 5
  
  stq.l_click = start_button + 6
  stq.m_click = start_button + 7
  stq.r_click = start_button + 8

end

return stq