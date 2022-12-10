function ChampBravoEngine_B350_airfoillabs()
  set_axis_assignment(btq.axis1, "none", "normal")
  set_axis_assignment(btq.axis2, "none", "normal")
  set_button_assignment(btq.axis1_rev_zone, "sim/engines/beta_toggle_1")
  set_button_assignment(btq.axis2_rev_zone, "sim/engines/beta_toggle_2")

  do_every_frame([[
        Eng1Mode = get("sim/flightmodel/engine/ENGN_propmode", 0)
        Eng1Pos  = get("sim/cockpit2/engine/actuators/throttle_ratio", 0)
        Throttle1Pos = get("sim/joystick/joystick_axis_values",]].. btq.axis1..[[)

        if ((Eng1Mode == 1) and (Throttle1Pos > 0.02)) then
          --NORMAL
          set_array("sim/cockpit2/engine/actuators/throttle_ratio", 0, Throttle1Pos)
        elseif ((Eng1Mode == 1) and (Throttle1Pos < 0.02) and (Eng1Pos >= 0.02)) then
          --IDLE
          set_array("sim/cockpit2/engine/actuators/throttle_ratio", 0, 0)
        elseif (Eng1Mode > 1) then
          if (Throttle1Pos <= 0.48)  then
            --BETA RANGE
            set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, (-2 * Throttle1Pos - 0.02))
          elseif (Throttle1Pos > 0.52) then
            --REVERSE THROTTLE
            set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, (-2 * Throttle1Pos))
          end
        end
      ]])
  
    do_every_frame([[
        Eng2Mode = get("sim/flightmodel/engine/ENGN_propmode", 1)
        Eng2Pos  = get("sim/cockpit2/engine/actuators/throttle_ratio", 1)
        Throttle2Pos = get("sim/joystick/joystick_axis_values",]].. btq.axis2..[[)

        if ((Eng2Mode == 1) and (Throttle2Pos > 0.02)) then
          --NORMAL
          set_array("sim/cockpit2/engine/actuators/throttle_ratio", 1, Throttle2Pos)
        elseif ((Eng2Mode == 1) and (Throttle2Pos < 0.02) and (Eng2Pos >= 0.02)) then
          --IDLE
          set_array("sim/cockpit2/engine/actuators/throttle_ratio", 1, 0)
        elseif (Eng2Mode > 1) then
          if (Throttle2Pos <= 0.48)  then
            --BETA RANGE
            set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, (-2 * Throttle2Pos - 0.02))
          elseif (Throttle2Pos > 0.52) then
            --REVERSE THROTTLE
            set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, (-2 * Throttle2Pos))
          end
        end
      ]])
end
