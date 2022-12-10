--Rotate Sim MD-11(F)

function ChampBravoEngine_MD11_Rotate()
  do_every_frame([[
    Eng1Mode     = get("sim/flightmodel/engine/ENGN_propmode", 0)
    Eng2Mode     = get("sim/flightmodel/engine/ENGN_propmode", 1)
    Eng3Mode     = get("sim/flightmodel/engine/ENGN_propmode", 2)
    Throttle1Pos = get("sim/joystick/joystick_axis_values",]]..btq.axis2..[[)
    Throttle2Pos = get("sim/joystick/joystick_axis_values",]]..btq.axis3..[[)
    Throttle3Pos = get("sim/joystick/joystick_axis_values",]]..btq.axis4..[[)

    if ((Eng1Mode <= 1) and (Throttle1Pos <= 0.02)) then
      set_array("Rotate/aircraft/systems/throttle_handle_pos_ratio", 0, 0)
    end
    if ((Eng2Mode <= 1) and (Throttle2Pos <= 0.02)) then
      set_array("Rotate/aircraft/systems/throttle_handle_pos_ratio", 1, 0)
    end
    if ((Eng3Mode <= 1) and (Throttle3Pos <= 0.02)) then
      set_array("Rotate/aircraft/systems/throttle_handle_pos_ratio", 2, 0)
    end
  ]])
  do_often([[
    Eng1Mode     = get("sim/flightmodel/engine/ENGN_propmode", 0)
    Eng2Mode     = get("sim/flightmodel/engine/ENGN_propmode", 1)
    Eng3Mode     = get("sim/flightmodel/engine/ENGN_propmode", 2)
    Rev1State    = get("Rotate/aircraft/systems/reverser_door_pos_ratio", 0)
    Rev2State    = get("Rotate/aircraft/systems/reverser_door_pos_ratio", 1)
    Rev3State    = get("Rotate/aircraft/systems/reverser_door_pos_ratio", 2)
    Rev1Pos      = button(]]..btq.axis2_rev_handle..[[)
    Rev2Pos      = button(]]..btq.axis3_rev_handle..[[)
    Rev3Pos      = button(]]..btq.axis4_rev_handle..[[)

    if (Rev1Pos and (Eng1Mode <= 1)) then
      command_once("Rotate/aircraft/controls_c/eng_1_reverser_toggle")
    elseif (not(Rev1Pos) and (Eng1Mode > 1) and (Rev1State >= 0.99)) then
      command_once("Rotate/aircraft/controls_c/eng_1_reverser_toggle")
    end
    if (Rev2Pos and (Eng2Mode <= 1)) then
      command_once("Rotate/aircraft/controls_c/eng_2_reverser_toggle")
    elseif (not(Rev2Pos) and (Eng2Mode > 1) and (Rev2State >= 0.99)) then
      command_once("Rotate/aircraft/controls_c/eng_2_reverser_toggle")
    end
    if (Rev3Pos and (Eng3Mode <= 1)) then
      command_once("Rotate/aircraft/controls_c/eng_3_reverser_toggle")
    elseif (not(Rev3Pos) and (Eng3Mode > 1) and (Rev3State >= 0.99)) then
      command_once("Rotate/aircraft/controls_c/eng_3_reverser_toggle")
    end
  ]])
end

function ChampBravoMapping_MD11_Rotate()
  function bravo_Ap_AltInc(numticks) bravo_command_multiple("Rotate/aircraft/controls_c/fgs_alt_sel_up", numticks) end
  function bravo_Ap_AltDec(numticks) bravo_command_multiple("Rotate/aircraft/controls_c/fgs_alt_sel_dn", numticks) end
  function bravo_Ap_VsInc(numticks)  bravo_command_multiple("Rotate/aircraft/controls_c/fgs_pitch_sel_up", numticks) end
  function bravo_Ap_VsDec(numticks)  bravo_command_multiple("Rotate/aircraft/controls_c/fgs_pitch_sel_dn", numticks) end
  function bravo_Ap_HdgInc(numticks) bravo_command_multiple("Rotate/aircraft/controls_c/fgs_hdg_sel_up", numticks) end
  function bravo_Ap_HdgDec(numticks) bravo_command_multiple("Rotate/aircraft/controls_c/fgs_hdg_sel_dn", numticks) end
  --function bravo_Ap_CrsInc(numticks) bravo_command_multiple("A300/radios/ILS/course/dial_up", numticks) end
  --function bravo_Ap_CrsDec(numticks) bravo_command_multiple("A300/radios/ILS/course/dial_down", numticks) end
  function bravo_Ap_IasInc(numticks) bravo_command_multiple("Rotate/aircraft/controls_c/fgs_spd_sel_up", numticks) end
  function bravo_Ap_IasDec(numticks) bravo_command_multiple("Rotate/aircraft/controls_c/fgs_spd_sel_dn", numticks) end

  set_button_assignment(btq.ap_hdg, "sim/none/none")
  function apPanelCockpitHdgShort(status)
    if (status == "begin") then command_begin("Rotate/aircraft/controls_c/fgs_hdg_mode_sel_dn") elseif (status == "end") then command_end("Rotate/aircraft/controls_c/fgs_hdg_mode_sel_dn") end
  end
  function apPanelCockpitHdgLong(status)
    if (status == "begin") then command_begin("Rotate/aircraft/controls_c/fgs_hdg_mode_sel_up") elseif (status == "end") then command_end("Rotate/aircraft/controls_c/fgs_hdg_mode_sel_up") end
  end

  set_button_assignment(btq.ap_nav, "sim/none/none")
  function apPanelCockpitNavShort(status)
    if (status == "begin") then command_begin("Rotate/aircraft/controls_c/fgs_nav") elseif (status == "end") then command_end("Rotate/aircraft/controls_c/fgs_nav") end
  end
  function apPanelCockpitNavLong(status)
    if (status == "begin") then command_begin("Rotate/aircraft/controls_c/fgs_prof") elseif (status == "end") then command_end("Rotate/aircraft/controls_c/fgs_prof") end
  end

  set_button_assignment(btq.ap_apr, "Rotate/aircraft/controls_c/fgs_appr_land")
  function apPanelCockpitAprShort(status) end
  function apPanelCockpitAprLong(status) end

  set_button_assignment(btq.ap_rev, "sim/none/none")

  set_button_assignment(btq.ap_alt, "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then command_begin("Rotate/aircraft/controls_c/fgs_alt_mode_sel_dn") elseif (status == "end") then command_end("Rotate/aircraft/controls_c/fgs_alt_mode_sel_dn") end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then command_begin("Rotate/aircraft/controls_c/fgs_alt_mode_sel_up") elseif (status == "end") then command_end("Rotate/aircraft/controls_c/fgs_alt_mode_sel_up") end --typo MCUD instead of MCDU
  end

  set_button_assignment(btq.ap_vs, "sim/none/none")
  function apPanelCockpitVsShort(status) end
  function apPanelCockpitVsLong(status) end

  set_button_assignment(btq.ap_ias, "sim/none/none")
  function apPanelCockpitIasShort(status)
    if (status == "begin") then command_begin("Rotate/aircraft/controls_c/fgs_spd_sel_mode_up") elseif (status == "end") then command_end("Rotate/aircraft/controls_c/fgs_spd_sel_mode_up") end
  end
  function apPanelCockpitIasLong(status)
    if (status == "begin") then command_begin("Rotate/aircraft/controls_c/fgs_fms_spd") elseif (status == "end") then command_end("Rotate/aircraft/controls_c/fgs_fms_spd") end --typo MCUD instead of MCDU
  end

  set_button_assignment(btq.ap_master, "Rotate/aircraft/controls_c/fgs_autoflight")
  function apPanelCockpitMasterShort(status) end
  function apPanelCockpitMasterLong(status) end

  do_every_frame("apPanelDualHandler()")

  set_button_assignment(btq.gear_dn, "Rotate/aircraft/controls_c/gear_handle_up")
  set_button_assignment(btq.gear_up, "Rotate/aircraft/controls_c/gear_handle_dn")

  set_axis_assignment(btq.axis1, "speedbrakes", "reverse")
  set_button_assignment(btq.axis12_2nd_func, "Rotate/aircraft/controls_c/ats_disc_l")
  set_button_assignment(btq.axis3_2nd_func, "Rotate/aircraft/controls_c/to_ga")

  set_button_assignment(btq.sw1_up, "Rotate/aircraft/controls_c/park_brake_up")
  set_button_assignment(btq.sw1_dn, "Rotate/aircraft/controls_c/park_brake_dn")

  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_often([[
    AcPos1 = get("Rotate/aircraft/controls/anti_ice_eng_1")
    AcPos2 = get("Rotate/aircraft/controls/anti_ice_eng_2")
    AcPos3 = get("Rotate/aircraft/controls/anti_ice_eng_2")
    JoyPos = button(]]..btq.sw2_up..[[)
  
    if (JoyPos and (AcPos1 < 1)) then
      command_once("Rotate/aircraft/controls_c/anti_ice_eng_1")
    elseif (not(JoyPos) and (AcPos1 > 0)) then
      command_once("Rotate/aircraft/controls_c/anti_ice_eng_1")
    end
  
    if (JoyPos and (AcPos2 < 1)) then
      command_once("Rotate/aircraft/controls_c/anti_ice_eng_2")
    elseif (not(JoyPos) and (AcPos2 > 0)) then
      command_once("Rotate/aircraft/controls_c/anti_ice_eng_2")
    end

    if (JoyPos and (AcPos3 < 1)) then
      command_once("Rotate/aircraft/controls_c/anti_ice_eng_3")
    elseif (not(JoyPos) and (AcPos3 > 0)) then
      command_once("Rotate/aircraft/controls_c/anti_ice_eng_3")
    end
  ]])
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
  do_often([[
    AcPos1 = get("Rotate/aircraft/controls/anti_ice_tail")
    AcPos2 = get("Rotate/aircraft/controls/anti_ice_wing")
    JoyPos = button(]]..btq.sw3_up..[[)
  
    if (JoyPos and (AcPos1 < 1)) then
      command_once("Rotate/aircraft/controls_c/anti_ice_tail")
    elseif (not(JoyPos) and (AcPos1 > 0)) then
      command_once("Rotate/aircraft/controls_c/anti_ice_tail")
    end

    if (JoyPos and (AcPos2 < 1)) then
      command_once("Rotate/aircraft/controls_c/anti_ice_wing")
    elseif (not(JoyPos) and (AcPos2 > 0)) then
      command_once("Rotate/aircraft/controls_c/anti_ice_wing")
    end
  ]])
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_often([[
    AcPos1 = get("Rotate/aircraft/controls/strobe_lts")
    JoyPos = button(]]..btq.sw5_up..[[)
  
    if (JoyPos and (AcPos1 < 1)) then
      command_once("Rotate/aircraft/controls_c/strobe_lts")
    elseif (not(JoyPos) and (AcPos1 > 0)) then
      command_once("Rotate/aircraft/controls_c/strobe_lts")
    end
  ]])
  set_button_assignment(btq.sw6_up, "sim/none/none")
  set_button_assignment(btq.sw6_dn, "sim/none/none")
  set_button_assignment(btq.sw7_up, "sim/none/none")
  set_button_assignment(btq.sw7_dn, "sim/none/none")
  do_often([[
    C_Pos = get("Rotate/aircraft/controls/nose_lts")
    L_Pos = get("Rotate/aircraft/controls/ldg_l_lts")
    R_Pos = get("Rotate/aircraft/controls/ldg_r_lts")
    SwPos6 = button(]]..btq.sw6_up..[[)
    SwPos7 = button(]]..btq.sw7_up..[[)

    if (SwPos7 and (C_Pos < 2)) then
      command_once("Rotate/aircraft/controls_c/nose_lts_up")
      command_once("Rotate/aircraft/controls_c/nose_lts_up")
    elseif (SwPos6 and not(SwPos7) and (C_Pos < 1)) then
      command_once("Rotate/aircraft/controls_c/nose_lts_up")
    elseif (SwPos6 and not(SwPos7) and (C_Pos > 1)) then
      command_once("Rotate/aircraft/controls_c/nose_lts_dn")
    elseif (not(SwPos6) and not(SwPos7) and (C_Pos > 0)) then
      command_once("Rotate/aircraft/controls_c/nose_lts_dn")
      command_once("Rotate/aircraft/controls_c/nose_lts_dn")
    end

    if (SwPos7 and (L_Pos < 2)) then
      command_once("Rotate/aircraft/controls_c/ldg_l_lts_up")
      command_once("Rotate/aircraft/controls_c/ldg_l_lts_up")
    elseif (not(SwPos7) and (L_Pos > 0)) then
      command_once("Rotate/aircraft/controls_c/ldg_l_lts_dn")
      command_once("Rotate/aircraft/controls_c/ldg_l_lts_dn")
    end

    if (SwPos7 and (R_Pos < 2)) then
      command_once("Rotate/aircraft/controls_c/ldg_r_lts_up")
      command_once("Rotate/aircraft/controls_c/ldg_r_lts_up")
    elseif (not(SwPos7) and (R_Pos > 0)) then
      command_once("Rotate/aircraft/controls_c/ldg_r_lts_dn")
      command_once("Rotate/aircraft/controls_c/ldg_r_lts_dn")
    end
  ]])
end


function ChampBravoLed_MD11_Rotate()

end

function ChampBravoCheck_MD11_Rotate()
  if (--XPLMFindDataRef("A300/elec/battery_on")                                 ~= nil and
      --XPLMFindDataRef("A300/elec/dc_norm_bus_off")                            ~= nil and
      --XPLMFindDataRef("A300/elec/ac_bus1_off")                                ~= nil and
      --XPLMFindDataRef("A300/elec/ac_bus2_off")                                ~= nil and

      ----AP Panel
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_alt_sel_up")            ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_alt_sel_dn")            ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_pitch_sel_up")          ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_pitch_sel_dn")          ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_hdg_sel_up")            ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_hdg_sel_dn")            ~= nil and
      --XPLMFindCommand("A300/radios/ILS/course/dial_up")                       ~= nil and
      --XPLMFindCommand("A300/radios/ILS/course/dial_down")                     ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_spd_sel_up")            ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_spd_sel_dn")            ~= nil and

      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_hdg_mode_sel_up")       ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_hdg_mode_sel_dn")       ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_nav")                   ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_prof")                  ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_appr_land")             ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_alt_mode_sel_dn")       ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_alt_mode_sel_up")       ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_spd_sel_mode_up")       ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_fms_spd")               ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/fgs_autoflight")            ~= nil and

      --Axis
      XPLMFindCommand("Rotate/aircraft/controls_c/ats_disc_l")                ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/to_ga")                     ~= nil and
      XPLMFindDataRef("Rotate/aircraft/systems/reverser_door_pos_ratio")      ~= nil and
      XPLMFindDataRef("Rotate/aircraft/systems/throttle_handle_pos_ratio")    ~= nil and
      XPLMFindDataRef("sim/flightmodel/engine/ENGN_propmode")                 ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/eng_1_reverser_toggle")     ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/eng_2_reverser_toggle")     ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/eng_3_reverser_toggle")     ~= nil and

      --Switches
      XPLMFindCommand("Rotate/aircraft/controls_c/gear_handle_up")            ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/gear_handle_dn")            ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/park_brake_up")             ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/park_brake_dn")             ~= nil and
      XPLMFindDataRef("Rotate/aircraft/controls/anti_ice_eng_1")              ~= nil and
      XPLMFindDataRef("Rotate/aircraft/controls/anti_ice_eng_2")              ~= nil and
      XPLMFindDataRef("Rotate/aircraft/controls/anti_ice_eng_3")              ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/anti_ice_eng_1")            ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/anti_ice_eng_2")            ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/anti_ice_eng_3")            ~= nil and
      XPLMFindDataRef("Rotate/aircraft/controls/anti_ice_tail")               ~= nil and
      XPLMFindDataRef("Rotate/aircraft/controls/anti_ice_wing")               ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/anti_ice_tail")             ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/anti_ice_wing")             ~= nil and
      XPLMFindDataRef("Rotate/aircraft/controls/strobe_lts")                  ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/strobe_lts")                ~= nil and
      XPLMFindDataRef("Rotate/aircraft/controls/ldg_l_lts")                   ~= nil and
      XPLMFindDataRef("Rotate/aircraft/controls/ldg_r_lts")                   ~= nil and
      XPLMFindDataRef("Rotate/aircraft/controls/nose_lts")                    ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/nose_lts_up")               ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/nose_lts_dn")               ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/ldg_l_lts_up")              ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/ldg_l_lts_dn")              ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/ldg_r_lts_up")              ~= nil and
      XPLMFindCommand("Rotate/aircraft/controls_c/ldg_r_lts_dn")              ~= nil and

      --LEDs
      --XPLMFindDataRef("A300/MCDU/animations/lights/heading_sel")              ~= nil and
      --XPLMFindDataRef("A300/MCDU/animations/lights/nav")                      ~= nil and
      --XPLMFindDataRef("A300/MCDU/animations/lights/profile_mode")             ~= nil and
      --XPLMFindDataRef("A300/MCDU/animations/lights/approach")                 ~= nil and
      --XPLMFindDataRef("A300/MCDU/animations/lights/level_change")             ~= nil and
      --XPLMFindDataRef("A300/MCDU/animations/lights/altitude_hold")            ~= nil and

      --XPLMFindDataRef("A300/master_warning")                                  ~= nil and
      --XPLMFindDataRef("A300/master_caution_light")                            ~= nil and
      --XPLMFindDataRef("A300/FIRE/fire_handle_engine1_light")                  ~= nil and
      --XPLMFindDataRef("A300/FIRE/fire_handle_apu_light")                      ~= nil and
      --XPLMFindDataRef("A300/FIRE/fire_handle_engine2_light")                  ~= nil and
      --XPLMFindDataRef("A300/engine/engine1_oil_low_press_light")              ~= nil and
      --XPLMFindDataRef("A300/engine/engine2_oil_low_press_light")              ~= nil and
      --XPLMFindDataRef("A300/HYD/hydraulic_blue_light")                        ~= nil and
      --XPLMFindDataRef("A300/HYD/hydraulic_green1_light")                      ~= nil and
      --XPLMFindDataRef("A300/HYD/hydraulic_green2_light")                      ~= nil and
      --XPLMFindDataRef("A300/HYD/hydraulic_green3_light")                      ~= nil and
      --XPLMFindDataRef("A300/HYD/hydraulic_yellow_light")                      ~= nil and
      --XPLMFindDataRef("A300/FUEL/outer_tank_pump1_left_low_pressure")         ~= nil and
      --XPLMFindDataRef("A300/FUEL/outer_tank_pump2_left_low_pressure")         ~= nil and
      --XPLMFindDataRef("A300/FUEL/outer_tank_pump1_right_low_pressure")        ~= nil and
      --XPLMFindDataRef("A300/FUEL/outer_tank_pump2_right_low_pressure")        ~= nil and
      --XPLMFindDataRef("A300/FUEL/center_tank_pump1_low_pressure")             ~= nil and
      --XPLMFindDataRef("A300/FUEL/center_tank_pump2_low_pressure")             ~= nil and
      --XPLMFindDataRef("A300/FUEL/inner_tank_pump1_right_low_pressure")        ~= nil and
      --XPLMFindDataRef("A300/FUEL/inner_tank_pump2_right_low_pressure")        ~= nil and
      --XPLMFindDataRef("A300/FUEL/inner_tank_pump2_left_low_pressure")         ~= nil and
      --XPLMFindDataRef("A300/FUEL/inner_tank_pump1_left_low_pressure")         ~= nil and
      --XPLMFindDataRef("A300/FUEL/trim_tank_pump2_low_pressure")               ~= nil and
      --XPLMFindDataRef("A300/FUEL/trim_tank_pump1_low_pressure")               ~= nil and
      --XPLMFindDataRef("sim/cockpit2/ice/cowling_thermal_anti_ice_per_engine") ~= nil and
      --XPLMFindDataRef("A300/ICE/wing_supply")                                 ~= nil and
      --XPLMFindDataRef("A300/APU/master_switch_button")                        ~= nil and
      --XPLMFindDataRef("A300/APU/n1")                                          ~= nil and
      --XPLMFindDataRef("A300/GND/doors_ratio")                                 ~= nil
      true
     ) then return true
  else
    return false
  end
end
