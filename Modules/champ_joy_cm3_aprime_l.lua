local aprime_l = {}

function aprime_l.map(joy_num, joy_hid_pointer)

  start_axis   = joy_num * 25
  start_button = joy_num * 160

  aprime_l.connected = false
  if (nil ~= joy_hid_pointer) then
    aprime_l.connected = true
  end

  logMsg(string.format("Champion Info: Mapping a Virpil MT-50 CM3 base w/ Alpha Prime L starting at (Axis=%i Buttons=%i)", start_axis, start_button))

  --Axis
  aprime_l.axis_roll     = start_axis
  aprime_l.axis_pitch    = start_axis + 1
  aprime_l.axis_view_y   = start_axis + 2
  aprime_l.axis_view_x   = start_axis + 3
  aprime_l.axis_grip     = start_axis + 4
  aprime_l.axis_rotz     = start_axis + 5

  --Buttons
  aprime_l.fliptrig_fwd   = start_button
  aprime_l.fliptrig_ctr   = start_button + 1
  aprime_l.fliptrig_aft   = start_button + 2
  aprime_l.trig_mid       = start_button + 3
  aprime_l.trig_full      = start_button + 4
  aprime_l.view_press     = start_button + 5
  aprime_l.tr_button      = start_button + 6
  aprime_l.tl_hat_press   = start_button + 7
  aprime_l.tl_hat_up      = start_button + 8
  aprime_l.tl_hat_right   = start_button + 9
  aprime_l.tl_hat_down    = start_button + 10
  aprime_l.tl_hat_left    = start_button + 11
  aprime_l.bl_button      = start_button + 12
  aprime_l.br_hat_click   = start_button + 13
  aprime_l.br_hat_up      = start_button + 14
  aprime_l.br_hat_right   = start_button + 15
  aprime_l.br_hat_down    = start_button + 16
  aprime_l.br_hat_left    = start_button + 17
  aprime_l.wheel_half_clk = start_button + 18
  aprime_l.wheel_full_clk = start_button + 19
  aprime_l.wheel_up       = start_button + 20
  aprime_l.wheel_down     = start_button + 21
  aprime_l.thb_hat_click  = start_button + 22
  aprime_l.thb_hat_up     = start_button + 23
  aprime_l.thb_hat_right  = start_button + 24
  aprime_l.thb_hat_down   = start_button + 25
  aprime_l.thb_hat_left   = start_button + 26
  aprime_l.side_hat_press = start_button + 27
  aprime_l.side_hat_up    = start_button + 28
  aprime_l.side_hat_down  = start_button + 29
  aprime_l.pinkie         = start_button + 30
  aprime_l.squeeze        = start_button + 31

end

return aprime_l