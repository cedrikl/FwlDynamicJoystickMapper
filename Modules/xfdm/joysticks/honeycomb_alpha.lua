require("xfdm.joysticks.base")

xfdm.joysticks.honeycomb_alpha = {}

local vid = 0x294b
local pid = 0x1900

local device_pointer = hid_open(vid, pid)

if (device_pointer == nil) then
  xfdm.joysticks.honeycomb_alpha.state = xfdmJoyNc
  logMsg("XFDM - Joysticks(warning): Could not detect a Honeycomb Alpha.")
else
  hid_close(device_pointer)
  xfdm.joysticks.honeycomb_alpha.state = xfdmJoyOk

  local start_axis   = xfdm.joysticks.detect(vid, pid) * 25
  local start_button = xfdm.joysticks.detect(vid, pid) * 160

  logMsg(string.format("XFDM - Joysticks: Mapping a Honeycomb Alpha starting at (Axis=%i Buttons=%i)", start_axis, start_button))

  --Axis
  xfdm.joysticks.honeycomb_alpha.axis_pitch    = start_axis
  xfdm.joysticks.honeycomb_alpha.axis_roll     = start_axis + 1

  --Buttons
  xfdm.joysticks.honeycomb_alpha.l_trig         = start_button
  xfdm.joysticks.honeycomb_alpha.l_btn_white    = start_button + 1
  xfdm.joysticks.honeycomb_alpha.r_btn_white    = start_button + 2
  xfdm.joysticks.honeycomb_alpha.r_btn_red      = start_button + 3
  xfdm.joysticks.honeycomb_alpha.l_trim_1dn     = start_button + 4
  xfdm.joysticks.honeycomb_alpha.l_trim_1up     = start_button + 5
  xfdm.joysticks.honeycomb_alpha.l_trim_2dn     = start_button + 6
  xfdm.joysticks.honeycomb_alpha.l_trim_2up     = start_button + 7
  xfdm.joysticks.honeycomb_alpha.r_trim_1left   = start_button + 8
  xfdm.joysticks.honeycomb_alpha.r_trim_1right  = start_button + 9
  xfdm.joysticks.honeycomb_alpha.r_trim_2left   = start_button + 10
  xfdm.joysticks.honeycomb_alpha.r_trim_2right  = start_button + 11

  xfdm.joysticks.honeycomb_alpha.sw_alt_on      = start_button + 12
  xfdm.joysticks.honeycomb_alpha.sw_alt_off     = start_button + 13
  xfdm.joysticks.honeycomb_alpha.sw_batt_on     = start_button + 14
  xfdm.joysticks.honeycomb_alpha.sw_batt_off    = start_button + 15
  xfdm.joysticks.honeycomb_alpha.sw_bus1_on     = start_button + 16
  xfdm.joysticks.honeycomb_alpha.sw_bus1_off    = start_button + 17
  xfdm.joysticks.honeycomb_alpha.sw_bus2_on     = start_button + 18
  xfdm.joysticks.honeycomb_alpha.sw_bus2_off    = start_button + 19
  xfdm.joysticks.honeycomb_alpha.sw_bcn_on      = start_button + 20
  xfdm.joysticks.honeycomb_alpha.sw_bcn_off     = start_button + 21
  xfdm.joysticks.honeycomb_alpha.sw_land_on     = start_button + 22
  xfdm.joysticks.honeycomb_alpha.sw_land_off    = start_button + 23
  xfdm.joysticks.honeycomb_alpha.sw_taxi_on     = start_button + 24
  xfdm.joysticks.honeycomb_alpha.sw_taxi_off    = start_button + 25
  xfdm.joysticks.honeycomb_alpha.sw_nav_on      = start_button + 26
  xfdm.joysticks.honeycomb_alpha.sw_nav_off     = start_button + 27
  xfdm.joysticks.honeycomb_alpha.sw_strobe_on   = start_button + 28
  xfdm.joysticks.honeycomb_alpha.sw_strobe_off  = start_button + 29
  xfdm.joysticks.honeycomb_alpha.sw_start_off   = start_button + 30
  xfdm.joysticks.honeycomb_alpha.sw_start_right = start_button + 31
  xfdm.joysticks.honeycomb_alpha.sw_start_left  = start_button + 32
  xfdm.joysticks.honeycomb_alpha.sw_start_both  = start_button + 33
  xfdm.joysticks.honeycomb_alpha.sw_start_start = start_button + 34

  xfdm.joysticks.honeycomb_alpha.hatsw_up         = start_button + 35
  xfdm.joysticks.honeycomb_alpha.hatsw_up_right   = start_button + 36
  xfdm.joysticks.honeycomb_alpha.hatsw_right      = start_button + 37
  xfdm.joysticks.honeycomb_alpha.hatsw_down_right = start_button + 38
  xfdm.joysticks.honeycomb_alpha.hatsw_down       = start_button + 39
  xfdm.joysticks.honeycomb_alpha.hatsw_down_left  = start_button + 40
  xfdm.joysticks.honeycomb_alpha.hatsw_left       = start_button + 41
  xfdm.joysticks.honeycomb_alpha.hatsw_up_left    = start_button + 42
end

return xfdm.joysticks.honeycomb_alpha
