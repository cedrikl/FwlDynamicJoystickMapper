local x55t = {}

function x55t.map(joy_num, joy_hid_pointer)

  start_axis   = joy_num * 25
  start_button = joy_num * 160

  x55t.connected = false
  if (nil ~= joy_hid_pointer) then
    x55t.connected = true
  end

  logMsg(string.format("Champion Info: Mapping a Saitek X55 Throttle starting at (Axis=%i Buttons=%i)", start_axis, start_button))

  -- AXIS
  x55t.axis_L         = start_axis
  x55t.axis_R         = start_axis + 1
  x55t.axis_RTY3      = start_axis + 2
  x55t.axis_RTY4      = start_axis + 3
  x55t.axis_G         = start_axis + 4
  x55t.axis_F         = start_axis + 5
  x55t.axis_X         = start_axis + 6
  x55t.axis_Y         = start_axis + 7

  -- BUTTONS
  x55t.E              = start_button
  x55t.F              = start_button + 1
  x55t.G              = start_button + 2
  x55t.H              = start_button + 3
  x55t.I              = start_button + 4

  x55t.SW1            = start_button + 5
  x55t.SW2            = start_button + 6
  x55t.SW3            = start_button + 7
  x55t.SW4            = start_button + 8
  x55t.SW5            = start_button + 9
  x55t.SW6            = start_button + 10

  x55t.TGL1_Up        = start_button + 11
  x55t.TGL1_Dn        = start_button + 12
  x55t.TGL2_Up        = start_button + 13
  x55t.TGL2_Dn        = start_button + 14
  x55t.TGL3_Up        = start_button + 15
  x55t.TGL3_Dn        = start_button + 16
  x55t.TGL4_Up        = start_button + 17
  x55t.TGL4_Dn        = start_button + 18

  x55t.hat_H3_Up      = start_button + 19
  x55t.hat_H3_Right   = start_button + 20
  x55t.hat_H3_Down    = start_button + 21
  x55t.hat_H3_Left    = start_button + 22

  x55t.hat_H4_Up      = start_button + 23
  x55t.hat_H4_Right   = start_button + 24
  x55t.hat_H4_Down    = start_button + 25
  x55t.hat_H4_Left    = start_button + 26

  x55t.K1_up          = start_button + 27
  x55t.K1_dn          = start_button + 28

  x55t.scroll_fwd     = start_button + 29
  x55t.scroll_aft     = start_button + 30

  x55t.M1             = start_button + 31
  x55t.M2             = start_button + 32
  x55t.M3             = start_button + 33

  x55t.Sld            = start_button + 34

end

return x55t