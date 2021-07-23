local scg_l = {}

function scg_l.map(joy_num, joy_hid_pointer)

  start_axis   = joy_num * 25
  start_button = joy_num * 160

  scg_l.connected = false
  if (nil ~= joy_hid_pointer) then
    scg_l.connected = true
  end

  logMsg(string.format("Champion Info: Mapping a VKB Gunfighter Mk.2 w/ SCG Premium L starting at (Axis=%i Buttons=%i)", start_axis, start_button))

  --Axis
  scg_l.axis_roll     = start_axis
  scg_l.axis_pitch    = start_axis + 1
  scg_l.axis_2        = start_axis + 2
  scg_l.axis_3        = start_axis + 3
  scg_l.axis_yaw      = start_axis + 4
  scg_l.axis_4        = start_axis + 5
  scg_l.axis_5        = start_axis + 6
  scg_l.axis_6        = start_axis + 7
  scg_l.axis_7        = start_axis + 8

  --Buttons
  scg_l.Fire          = start_button

  scg_l.A2            = start_button + 2
  scg_l.B1            = start_button + 3
  scg_l.D1            = start_button + 4

  scg_l.A4_Up         = start_button + 5
  scg_l.A4_Right      = start_button + 6
  scg_l.A4_Down       = start_button + 7
  scg_l.A4_Left       = start_button + 8
  scg_l.A4_Click      = start_button + 9

  scg_l.A3_Up         = start_button + 10
  scg_l.A3_Right      = start_button + 11
  scg_l.A3_Down       = start_button + 12
  scg_l.A3_Left       = start_button + 13
  scg_l.A3_Click      = start_button + 14

  scg_l.C1_Up         = start_button + 20
  scg_l.C1_Right      = start_button + 21
  scg_l.C1_Down       = start_button + 22
  scg_l.C1_Left       = start_button + 23
  scg_l.C1_Click      = start_button + 24

  scg_l.Trig_Fwd      = start_button + 25
  scg_l.Trig_Aft      = start_button + 26

  scg_l.A1_Up         = start_button  + 128
  scg_l.A1_Up_Right   = start_button  + 129
  scg_l.A1_Right      = start_button  + 130
  scg_l.A1_Down_Right = start_button  + 131
  scg_l.A1_Down       = start_button  + 132
  scg_l.A1_Down_Left  = start_button  + 133
  scg_l.A1_Left       = start_button  + 134
  scg_l.A1_Up_Left    = start_button  + 135

end

return scg_l