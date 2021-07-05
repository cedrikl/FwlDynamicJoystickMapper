local x55j = {}

function x55j.map(joy_num)

  start_axis   = joy_num * 25
  start_button = joy_num * 160

logMsg(string.format("Champion Info: Mapping a Saitek X55 Joystick starting at (Axis=%i Buttons=%i)", start_axis, start_button))

  -- AXIS
  x55j.pitch = start_axis
  x55j.roll  = start_axis + 1
  x55j.yaw   = start_axis + 2

  -- BUTTONS
  x55j.trigger   = start_button
  x55j.A         = start_button + 1
  x55j.B         = start_button + 2
  x55j.V         = start_button + 3
  x55j.D         = start_button + 4
  x55j.pinkytrig = start_button + 5

  x55j.H1_0      = start_button + 6
  x55j.H1_90     = start_button + 7
  x55j.H1_180    = start_button + 8
  x55j.H1_270    = start_button + 9

  x55j.H2_0      = start_button + 10
  x55j.H2_90     = start_button + 11
  x55j.H2_180    = start_button + 12
  x55j.H2_270    = start_button + 13

  x55j.pov_0     = start_button + 17
  x55j.pov_45    = start_button + 18
  x55j.pov_90    = start_button + 19
  x55j.pov_135   = start_button + 20
  x55j.pov_180   = start_button + 21
  x55j.pov_225   = start_button + 22
  x55j.pov_270   = start_button + 23
  x55j.pov_315   = start_button + 24

end

return x55j