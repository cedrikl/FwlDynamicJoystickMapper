function ChampBravoEngine_TBM9_hotstart()
  set_axis_assignment(btq.axis1, "none", "normal")
  set_axis_assignment(btq.axis2, "throttle 1", "reverse")
  set_axis_assignment(btq.axis3, "none", "normal")
  set_axis_assignment(btq.axis4, "none", "normal")
  set_axis_assignment(btq.axis5, "none", "normal")
  set_axis_assignment(btq.axis6, "none", "normal")

  set_button_assignment(btq.axis2_rev_handle, "sim/engines/thrust_reverse_toggle")
end
