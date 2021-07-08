local ChThrottleQuadrant = {}

function ChThrottleQuadrant.map(joy_num)

  start_axis   = joy_num * 25
  start_button = joy_num * 160

  logMsg(string.format("Champion Info: Mapping a CH Product Throttle Quadrant starting at (Axis=%i Buttons=%i)", start_axis, start_button))

--Axis
  ChThrottleQuadrant.axis_6 = start_axis
  ChThrottleQuadrant.axis_5 = start_axis + 1
  ChThrottleQuadrant.axis_4 = start_axis + 2
  ChThrottleQuadrant.axis_3 = start_axis + 3
  ChThrottleQuadrant.axis_2 = start_axis + 4
  ChThrottleQuadrant.axis_1 = start_axis + 5

--Buttons
  ChThrottleQuadrant.b1_Up = start_button
  ChThrottleQuadrant.b1_Dn = start_button + 1
  ChThrottleQuadrant.b2_Up = start_button + 2
  ChThrottleQuadrant.b2_Dn = start_button + 3
  ChThrottleQuadrant.b3_Up = start_button + 4
  ChThrottleQuadrant.b3_Dn = start_button + 5
  ChThrottleQuadrant.b4_Up = start_button + 6
  ChThrottleQuadrant.b4_Dn = start_button + 7
  ChThrottleQuadrant.b5_Up = start_button + 8
  ChThrottleQuadrant.b5_Dn = start_button + 9
  ChThrottleQuadrant.b6_Up = start_button + 10
  ChThrottleQuadrant.b6_Dn = start_button + 11

end

return ChThrottleQuadrant