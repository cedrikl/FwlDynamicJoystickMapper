local rift = {}

function rift.map(joy_l_num, joy_r_num)

  start_l_axis   = joy_l_num * 25
  start_l_button = joy_l_num * 160
  start_r_axis   = joy_r_num * 25
  start_r_button = joy_r_num * 160

  logMsg(string.format("Champion Info: Mapping a Oculus Rift Left Controller starting at (Axis=%i Buttons=%i)", start_l_axis, start_l_button))
  logMsg(string.format("Champion Info: Mapping a Oculus Rift Rightt Controller starting at (Axis=%i Buttons=%i)", start_r_axis, start_r_button))

  --Axis
  --Oculus_L_Joy_X      = 75                 Oculus_R_Joy_X      = 100
  rift.L_Joy_X      = start_l_axis
  rift.L_Joy_Y      = start_l_axis + 1
  rift.L_Joy_Index  = start_l_axis + 2
  rift.L_Joy_Middle = start_l_axis + 3

  rift.R_Joy_X      = start_r_axis
  rift.R_Joy_Y      = start_r_axis + 1
  rift.R_Joy_Index  = start_r_axis + 2
  rift.R_Joy_Middle = start_r_axis + 3


  --Oculus_L_Y        = 480             Oculus_R_Y        = 640
  rift.L_Y        = start_l_button           
  rift.L_Middle   = start_l_button + 1
  rift.L_X        = start_l_button + 2
  rift.L_Touchpad = start_l_button + 3
  rift.L_Index    = start_l_button + 4

  rift.R_Y        = start_r_button
  rift.R_Middle   = start_r_button + 1
  rift.R_X        = start_r_button + 2
  rift.R_Touchpad = start_r_button + 3
  rift.R_Index    = start_r_button + 4

end

return rift