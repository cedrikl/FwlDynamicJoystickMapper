require("xfdm.joysticks.base")

xfdm.joysticks.oculus_quest3 = {}

local l_id, r_id = xfdm.joysticks.detect_oculus()

if (l_id == -1 or r_id == -1 or l_id == nil or r_id == nil) then
  xfdm.joysticks.oculus_quest3.state = xfdmJoyNc
  logMsg("XFDM - Joysticks(warning): Could not detect Oculus Quest remotes.")
else
  local start_l_axis   = l_id * 25
  local start_l_button = l_id * 160
  local start_r_axis   = r_id * 25
  local start_r_button = r_id * 160

  xfdm.joysticks.oculus_quest3.state = xfdmJoyOk

  logMsg(string.format("XFDM - Joysticks: Mapping a Oculus Quest3 Left Controller starting at (Axis=%i Buttons=%i)", start_l_axis, start_l_button))
  logMsg(string.format("XFDM - Joysticks: Mapping a Oculus Quest3 Right Controller starting at (Axis=%i Buttons=%i)", start_r_axis, start_r_button))

  --Axis
  --Oculus_L_Joy_X      = 75                 Oculus_R_Joy_X      = 100
  xfdm.joysticks.oculus_quest3.L_Joy_X      = start_l_axis
  xfdm.joysticks.oculus_quest3.L_Joy_Y      = start_l_axis + 1
  xfdm.joysticks.oculus_quest3.L_Joy_Index  = start_l_axis + 2
  xfdm.joysticks.oculus_quest3.L_Joy_Middle = start_l_axis + 3

  xfdm.joysticks.oculus_quest3.R_Joy_X      = start_r_axis
  xfdm.joysticks.oculus_quest3.R_Joy_Y      = start_r_axis + 1
  xfdm.joysticks.oculus_quest3.R_Joy_Index  = start_r_axis + 2
  xfdm.joysticks.oculus_quest3.R_Joy_Middle = start_r_axis + 3


  --Oculus_L_Y        = 480             Oculus_R_Y        = 640
  xfdm.joysticks.oculus_quest3.L_B        = start_l_button           
  xfdm.joysticks.oculus_quest3.L_Middle   = start_l_button + 1
  xfdm.joysticks.oculus_quest3.L_A        = start_l_button + 2
  xfdm.joysticks.oculus_quest3.L_Touchpad = start_l_button + 3
  xfdm.joysticks.oculus_quest3.L_Index    = start_l_button + 4

  xfdm.joysticks.oculus_quest3.R_B        = start_r_button
  xfdm.joysticks.oculus_quest3.R_Middle   = start_r_button + 1
  xfdm.joysticks.oculus_quest3.R_A        = start_r_button + 2
  xfdm.joysticks.oculus_quest3.R_Touchpad = start_r_button + 3
  xfdm.joysticks.oculus_quest3.R_Index    = start_r_button + 4
end

return xfdm.joysticks.oculus_quest3
