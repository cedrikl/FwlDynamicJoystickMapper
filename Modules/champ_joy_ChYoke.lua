local ChFlightSimYoke = {}

function ChFlightSimYoke.map(joy_num, joy_hid_pointer)

  start_axis   = joy_num * 25
  start_button = joy_num * 160

  ChFlightSimYoke.connected = false
  if (nil ~= joy_hid_pointer) then
    ChFlightSimYoke.connected = true
  end

  logMsg(string.format("Champion Info: Mapping a CH Product Flight Sim Yoke starting at (Axis=%i Buttons=%i)", start_axis, start_button))

-- Axis
  ChFlightSimYoke.axis_2		= start_axis
  ChFlightSimYoke.axis_3		= start_axis + 1
  ChFlightSimYoke.axis_1        = start_axis + 2
  ChFlightSimYoke.axis_pitch    = start_axis + 3
  ChFlightSimYoke.axis_roll     = start_axis + 4

-- Buttons
  ChFlightSimYoke.PTT_Left  = start_button
  ChFlightSimYoke.PTT_Right = start_button + 1
  ChFlightSimYoke.Hor_Left  = start_button + 2
  ChFlightSimYoke.Hor_Right = start_button + 3
  ChFlightSimYoke.Sw_L_Up   = start_button + 4
  ChFlightSimYoke.Sw_L_Dn   = start_button + 5
  ChFlightSimYoke.Sw_R_Up   = start_button + 6
  ChFlightSimYoke.Sw_R_Dn   = start_button + 7
  ChFlightSimYoke.Red_Up    = start_button + 8
  ChFlightSimYoke.Red_Dn    = start_button + 9
  ChFlightSimYoke.Vert_Up   = start_button + 10
  ChFlightSimYoke.Verd_Dn   = start_button + 11
  ChFlightSimYoke.Hat_Up    = start_button + 12
  ChFlightSimYoke.Hat_UpR   = start_button + 13
  ChFlightSimYoke.Hat_R     = start_button + 14
  ChFlightSimYoke.Hat_DnR   = start_button + 15
  ChFlightSimYoke.Hat_Dn    = start_button + 16
  ChFlightSimYoke.Hat_DnL   = start_button + 17
  ChFlightSimYoke.Hat_L     = start_button + 18
  ChFlightSimYoke.Hat_UpL   = start_button + 19

end

return ChFlightSimYoke
