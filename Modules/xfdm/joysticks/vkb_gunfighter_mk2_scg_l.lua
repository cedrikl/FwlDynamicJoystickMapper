require("xfdm.joysticks.base")

xfdm.joysticks.vkb_gunfighter_mk2_scg_l = {}

local vid = 0x231d
local pid = 0x0127

local device_pointer = hid_open(vid, pid)

if (device_pointer == nil) then
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.state = xfdmJoyNc
  logMsg("XFDM - Joysticks(warning): Could not detect a VKB Gunfighter Mk.2 w/ SCG Premium L.")
else
  hid_close(device_pointer)
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.state = xfdmJoyOk

  local start_axis   = xfdm.joysticks.detect(vid, pid) * 25
  local start_button = xfdm.joysticks.detect(vid, pid) * 160

  logMsg(string.format("XFDM - Joysticks: Mapping a VKB Gunfighter Mk.2 w/ SCG Premium L starting at (Axis=%i Buttons=%i)", start_axis, start_button))

  --Axis
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.axis_roll  = start_axis
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.axis_pitch = start_axis + 1
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.axis_3     = start_axis + 2
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.axis_4     = start_axis + 3
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.axis_yaw   = start_axis + 2
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.axis_6     = start_axis + 3
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.axis_7     = start_axis + 4
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.axis_8     = start_axis + 5

  --Buttons
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.btn_red      = start_button
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.btn_a2       = start_button + 2
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.btn_b1       = start_button + 3
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.btn_d1       = start_button + 4

  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a4_up    = start_button + 5
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a4_right = start_button + 6
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a4_down  = start_button + 7
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a4_left  = start_button + 8
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a4_press = start_button + 9

  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a3_up    = start_button + 10
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a3_right = start_button + 11
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a3_down  = start_button + 12
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a3_left  = start_button + 13
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a3_press = start_button + 14

  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_c1_up    = start_button + 20
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_c1_right = start_button + 21
  xfdm.joysticks.vkb_gunfighter_mk2_scg_lhat_c1_down   = start_button + 22
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_c1_left  = start_button + 23
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_c1_press = start_button + 24

  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.trig_fwd     = start_button + 25
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.trig_aft     = start_button + 26

  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a1_up         = start_button + 128
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a1_up_right   = start_button + 129
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a1_right      = start_button + 130
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a1_down_right = start_button + 131
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a1_down       = start_button + 132
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a1_down_left  = start_button + 133
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a1_left       = start_button + 134
  xfdm.joysticks.vkb_gunfighter_mk2_scg_l.hat_a1_up_left    = start_button + 135
end

return xfdm.joysticks.vkb_gunfighter_mk2_scg_l
