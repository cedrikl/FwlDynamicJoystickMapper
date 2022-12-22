require("xfdm.joysticks.base")

xfdm.joysticks.virpil_cm3_aprime_l = {}

local vid = 0x3344
local pid = 0x838f

local device_pointer = hid_open(vid, pid)

if (device_pointer == nil) then
  xfdm.joysticks.virpil_cm3_aprime_l = xfdmJoyNc
  logMsg("XFDM - Joysticks(warning): Could not detect a Virpil MT-50 CM3 base w/ Alpha Prime L.")
else
  hid_close(device_pointer)

  local start_axis   = xfdm.joysticks.detect(vid, pid) * 25
  local start_button = xfdm.joysticks.detect(vid, pid) * 160

  logMsg(string.format("XFDM - Joysticks: Mapping a Virpil MT-50 CM3 base w/ Alpha Prime L starting at (Axis=%i Buttons=%i)", start_axis, start_button))

  --Axis
  xfdm.joysticks.virpil_cm3_aprime_l.axis_roll     = start_axis
  xfdm.joysticks.virpil_cm3_aprime_l.axis_pitch    = start_axis + 1
  xfdm.joysticks.virpil_cm3_aprime_l.axis_view_y   = start_axis + 2
  xfdm.joysticks.virpil_cm3_aprime_l.axis_view_x   = start_axis + 3
  xfdm.joysticks.virpil_cm3_aprime_l.axis_grip     = start_axis + 4
  xfdm.joysticks.virpil_cm3_aprime_l.axis_rotz     = start_axis + 5

  --Buttons
  xfdm.joysticks.virpil_cm3_aprime_l.fliptrig_fwd   = start_button
  xfdm.joysticks.virpil_cm3_aprime_l.fliptrig_ctr   = start_button + 1
  xfdm.joysticks.virpil_cm3_aprime_l.fliptrig_aft   = start_button + 2
  xfdm.joysticks.virpil_cm3_aprime_l.trig_mid       = start_button + 3
  xfdm.joysticks.virpil_cm3_aprime_l.trig_full      = start_button + 4
  xfdm.joysticks.virpil_cm3_aprime_l.view_press     = start_button + 5
  xfdm.joysticks.virpil_cm3_aprime_l.tr_button      = start_button + 6
  xfdm.joysticks.virpil_cm3_aprime_l.tl_hat_press   = start_button + 7
  xfdm.joysticks.virpil_cm3_aprime_l.tl_hat_up      = start_button + 8
  xfdm.joysticks.virpil_cm3_aprime_l.tl_hat_right   = start_button + 9
  xfdm.joysticks.virpil_cm3_aprime_l.tl_hat_down    = start_button + 10
  xfdm.joysticks.virpil_cm3_aprime_l.tl_hat_left    = start_button + 11
  xfdm.joysticks.virpil_cm3_aprime_l.bl_button      = start_button + 12
  xfdm.joysticks.virpil_cm3_aprime_l.br_hat_click   = start_button + 13
  xfdm.joysticks.virpil_cm3_aprime_l.br_hat_up      = start_button + 14
  xfdm.joysticks.virpil_cm3_aprime_l.br_hat_right   = start_button + 15
  xfdm.joysticks.virpil_cm3_aprime_l.br_hat_down    = start_button + 16
  xfdm.joysticks.virpil_cm3_aprime_l.br_hat_left    = start_button + 17
  xfdm.joysticks.virpil_cm3_aprime_l.wheel_half_clk = start_button + 18
  xfdm.joysticks.virpil_cm3_aprime_l.wheel_full_clk = start_button + 19
  xfdm.joysticks.virpil_cm3_aprime_l.wheel_up       = start_button + 20
  xfdm.joysticks.virpil_cm3_aprime_l.wheel_down     = start_button + 21
  xfdm.joysticks.virpil_cm3_aprime_l.thb_hat_click  = start_button + 22
  xfdm.joysticks.virpil_cm3_aprime_l.thb_hat_up     = start_button + 23
  xfdm.joysticks.virpil_cm3_aprime_l.thb_hat_right  = start_button + 24
  xfdm.joysticks.virpil_cm3_aprime_l.thb_hat_down   = start_button + 25
  xfdm.joysticks.virpil_cm3_aprime_l.thb_hat_left   = start_button + 26
  xfdm.joysticks.virpil_cm3_aprime_l.side_hat_press = start_button + 27
  xfdm.joysticks.virpil_cm3_aprime_l.side_hat_up    = start_button + 28
  xfdm.joysticks.virpil_cm3_aprime_l.side_hat_down  = start_button + 29
  xfdm.joysticks.virpil_cm3_aprime_l.pinkie         = start_button + 30
  xfdm.joysticks.virpil_cm3_aprime_l.squeeze        = start_button + 31
end

return xfdm.joysticks.virpil_cm3_aprime_l
