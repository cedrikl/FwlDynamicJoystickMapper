local alpha = {}

function alpha.map(joy_num, joy_hid_pointer)

  start_axis   = joy_num * 25
  start_button = joy_num * 160

  alpha.connected = false
  if (nil ~= joy_hid_pointer) then
    alpha.connected = true
  end

  logMsg(string.format("Champion Info: Mapping a Honeycomb Aeronautical Alpha Flight Sim Yoke starting at (Axis=%i Buttons=%i)", start_axis, start_button))

-- Axis
  alpha.axis_pitch    = start_axis
  alpha.axis_roll     = start_axis + 1

-- Buttons
  alpha.L_Trig        = start_button
  alpha.L_WhiteBtn    = start_button + 1
  alpha.R_WhiteBtn    = start_button + 2
  alpha.R_RedBtn      = start_button + 3
  alpha.L_Trim1Dn     = start_button + 4
  alpha.L_Trim1Up     = start_button + 5
  alpha.L_Trim2Dn     = start_button + 6
  alpha.L_Trim2Up     = start_button + 7

  alpha.R_Trim1Left   = start_button + 8
  alpha.R_Trim1Right  = start_button + 9
  alpha.R_Trim2Left   = start_button + 10
  alpha.R_Trim2Right  = start_button + 11

  alpha.B_AltOn       = start_button + 12
  alpha.B_AltOff      = start_button + 13
  alpha.B_BattOn      = start_button + 14
  alpha.B_BattOff     = start_button + 15
  alpha.B_Bus1On      = start_button + 16
  alpha.B_Bus1Off     = start_button + 17
  alpha.B_Bus2On      = start_button + 18
  alpha.B_Bus2Off     = start_button + 19
  alpha.B_BcnOn       = start_button + 20
  alpha.B_BcnOff      = start_button + 21
  alpha.B_LandOn      = start_button + 22
  alpha.B_LandOff     = start_button + 23
  alpha.B_TaxiOn      = start_button + 24
  alpha.B_TaxiOff     = start_button + 25
  alpha.B_NavOn       = start_button + 26
  alpha.B_NavOff      = start_button + 27
  alpha.B_StrobeOn    = start_button + 28
  alpha.B_StrobeOff   = start_button + 29

  alpha.S_Off         = start_button + 30
  alpha.S_Right       = start_button + 31
  alpha.S_Left        = start_button + 32
  alpha.S_Both        = start_button + 33
  alpha.S_Start       = start_button + 34

  alpha.L_Hat_Up      = start_button + 35
  alpha.L_Hat_UpRight = start_button + 36
  alpha.L_Hat_Right   = start_button + 37
  alpha.L_Hat_DnRight = start_button + 38
  alpha.L_Hat_Dn      = start_button + 39
  alpha.L_Hat_DnLeft  = start_button + 40
  alpha.L_Hat_Left    = start_button + 41
  alpha.L_Hat_UpLeft  = start_button + 42
end

return alpha
