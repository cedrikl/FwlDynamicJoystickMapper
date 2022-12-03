local reverbG2 = {}

function reverbG2.map(joy_l_num, joy_r_num, joy_hid_pointer)

  start_l_axis   = joy_l_num * 25
  start_l_button = joy_l_num * 160
  start_r_axis   = joy_r_num * 25
  start_r_button = joy_r_num * 160

  reverbG2.connected = false
  if (nil ~= joy_hid_pointer) then
    reverbG2.connected = true
  end

  logMsg(string.format("Champion Info: Mapping a HP Reverb G2 Left Controller starting at (Axis=%i Buttons=%i)", start_l_axis, start_l_button))
  logMsg(string.format("Champion Info: Mapping a HP Reverb G2 Rightt Controller starting at (Axis=%i Buttons=%i)", start_r_axis, start_r_button))

  --Axis

  reverbG2.L_Joy_Index = start_l_axis + 2
  reverbG2.L_Joy_X     = start_l_axis + 3
  reverbG2.L_Joy_Y     = start_l_axis + 4
  reverbG2.L_Joy_Thumb = start_l_axis + 5

  reverbG2.R_Joy_Index = start_r_axis + 2
  reverbG2.R_Joy_X     = start_r_axis + 3
  reverbG2.R_Joy_Y     = start_r_axis + 4
  reverbG2.R_Joy_Thumb = start_r_axis + 5

  reverbG2.L_Menu     = start_l_button
  reverbG2.L_X        = start_l_button + 1
  reverbG2.L_Y        = start_l_button + 2
  reverbG2.L_Index    = start_l_button + 3
  reverbG2.L_JoyClick = start_l_button + 4

  reverbG2.R_Menu     = start_r_button
  reverbG2.R_A        = start_r_button + 1
  reverbG2.R_B        = start_r_button + 2
  reverbG2.R_Index    = start_r_button + 3
  reverbG2.R_JoyClick = start_r_button + 4

end

function reverbG2.mapDefault()
  champ_set_axis_assignment(reverbG2.L_Joy_X,      "VR Touchpad X", "normal")
  champ_set_axis_assignment(reverbG2.L_Joy_Y,      "VR Touchpad Y", "normal")
  champ_set_axis_assignment(reverbG2.L_Joy_Index , "VR Trigger",    "normal")

  champ_set_axis_assignment(reverbG2.R_Joy_X,      "VR Touchpad X"  , "normal")
  champ_set_axis_assignment(reverbG2.R_Joy_Y,      "VR Touchpad Y"  , "normal")
  champ_set_axis_assignment(reverbG2.R_Joy_Index,  "VR Trigger"     , "normal")

  set_button_assignment(reverbG2.L_Menu,     "sim/VR/reserved/menu")
  --set_button_assignment(reverbG2.L_X,        "sim/VR/general/reset_view")
  set_button_assignment(reverbG2.L_JoyClick, "sim/VR/reserved/touchpad")
  set_button_assignment(reverbG2.L_Index,    "sim/VR/reserved/select")

  --set_button_assignment(reverbG2.R_Menu,     "sim/VR/reserved/menu")
  set_button_assignment(reverbG2.R_B,     "sim/VR/reserved/menu")
  --set_button_assignment(reverbG2.R_X,        "sim/VR/quick_zoom_view")
  set_button_assignment(reverbG2.R_JoyClick, "sim/VR/reserved/touchpad")
  set_button_assignment(reverbG2.R_Index,    "sim/VR/reserved/select")
end

return reverbG2