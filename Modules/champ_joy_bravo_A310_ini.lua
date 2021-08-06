--iniBuilds A300-600R & A310-300

function ChampBravoMapping_A310_ini()
  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_every_frame([[
      AcPos1 = get("A300/animations/buttons/ANTI_ICE_E1")
      AcPos2 = get("A300/animations/buttons/ANTI_ICE_E2")
      JoyPos = button(]]..btq.sw2_up..[[)

      if (JoyPos and (AcPos1 < 0.0001)) then
        command_once("A300/ICE/eng1_toggle")
      elseif (not(JoyPos) and (AcPos1 > 0.5434)) then
        command_once("A300/ICE/eng1_toggle")
      end
  
      if (JoyPos and (AcPos2 < 0.0001)) then
        command_once("A300/ICE/eng2_toggle")
      elseif (not(JoyPos) and (AcPos2 > 0.5434)) then
        command_once("A300/ICE/eng2_toggle")
      end
    ]])
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
  do_every_frame([[
      AcPos1 = get("A300/animations/buttons/WING_SUPPLY")
      JoyPos = button(]]..btq.sw3_up..[[)
  
      if (JoyPos and (AcPos1 < 0.0001)) then
        command_once("A300/ICE/wing_supply_toggle")
      elseif (not(JoyPos) and (AcPos1 > 0.9999)) then
        command_once("A300/ICE/wing_supply_toggle")
      end
    ]])
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_often([[
      AcPos1 = get("A300/switches/animations_current", 3)
      JoyPos = button(]]..btq.sw5_up..[[)
  
      if (JoyPos and (AcPos1 < 0.0001)) then
        command_once("A300/LIGHTS/strobe_light_up")
        command_once("A300/LIGHTS/strobe_light_up")
      elseif (not(JoyPos) and (AcPos1 > 1.9999)) then
        command_once("A300/LIGHTS/strobe_light_down")
        command_once("A300/LIGHTS/strobe_light_down")
      end
    ]])
  set_button_assignment(btq.sw6_up, "sim/none/none")
  set_button_assignment(btq.sw6_dn, "sim/none/none")
  set_button_assignment(btq.sw7_up, "sim/none/none")
  set_button_assignment(btq.sw7_dn, "sim/none/none")
  do_often([[
      C_Pos = get("A300/switches/animations_current", 0)
      L_Pos = get("A300/switches/animations_current", 7)
      R_Pos = get("A300/switches/animations_current", 8)
      SwPos6 = button(]]..btq.sw6_up..[[)
      SwPos7 = button(]]..btq.sw7_up..[[)

      CinGateDn  = C_Pos < 0.0001
      CinGateMid = (C_Pos > 0.9999) and (C_Pos < 1.0001)
      CinGateUp  = C_Pos > 1.9999

      if (SwPos7 and not(CinGateUp)) then
        command_once("A300/LIGHTS/nose_light_up")
        command_once("A300/LIGHTS/nose_light_up")
      elseif (SwPos6 and not(SwPos7) and not(CinGateMid)) then
        if (CinGateDn) then
          command_once("A300/LIGHTS/nose_light_up")
        elseif (CinGateUp) then
          command_once("A300/LIGHTS/nose_light_down")
        end
      elseif (not(SwPos6) and not(SwPos7) and not(CinGateDn)) then
        command_once("A300/LIGHTS/nose_light_down")
        command_once("A300/LIGHTS/nose_light_down")
      end

      LinGateDn  = L_Pos < 0.0001
      LinGateUp  = L_Pos > 1.9999
      RinGateDn  = R_Pos < 0.0001
      RinGateUp  = R_Pos > 1.9999

      if (SwPos7 and not(LinGateUp)) then
        command_once("A300/LIGHTS/landing_light1_up")
        command_once("A300/LIGHTS/landing_light1_up")
      elseif (not(SwPos7) and not(LinGateDn)) then
        command_once("A300/LIGHTS/landing_light1_down")
        command_once("A300/LIGHTS/landing_light1_down")
      end

      if (SwPos7 and not(RinGateUp)) then
        command_once("A300/LIGHTS/landing_light2_up")
        command_once("A300/LIGHTS/landing_light2_up")
      elseif (not(SwPos7) and not(RinGateDn)) then
        command_once("A300/LIGHTS/landing_light2_down")
        command_once("A300/LIGHTS/landing_light2_down")
      end
    ]])
end


function ChampBravoLed_A310_ini()

end


function ChampBravoCheck_A310_ini()
  if (--XPLMFindDataRef("a320/Aircraft/Electric/BCL1/Powered")                         ~= nil and

      --AP Panel
      --XPLMFindCommand("a320/Panel/FCU_Altitude_switch+")                             ~= nil and

      --Axis

      --Switches
      XPLMFindDataRef("A300/animations/buttons/ANTI_ICE_E1")                       ~= nil and
      XPLMFindDataRef("A300/animations/buttons/ANTI_ICE_E2")                       ~= nil and
      XPLMFindCommand("A300/ICE/eng1_toggle")                                      ~= nil and
      XPLMFindCommand("A300/ICE/eng2_toggle")                                      ~= nil and
      XPLMFindDataRef("A300/animations/buttons/WING_SUPPLY")                       ~= nil and
      XPLMFindCommand("A300/ICE/wing_supply_toggle")                               ~= nil and
      XPLMFindDataRef("A300/switches/animations_current")                          ~= nil and
      XPLMFindCommand("A300/LIGHTS/strobe_light_up")                               ~= nil and
      XPLMFindCommand("A300/LIGHTS/strobe_light_down")                             ~= nil and
      XPLMFindCommand("A300/LIGHTS/landing_light1_up")                             ~= nil and
      XPLMFindCommand("A300/LIGHTS/landing_light2_up")                             ~= nil and
      XPLMFindCommand("A300/LIGHTS/landing_light1_down")                           ~= nil and
      XPLMFindCommand("A300/LIGHTS/landing_light2_down")                           ~= nil and
      XPLMFindCommand("A300/LIGHTS/nose_light_up")                                 ~= nil and
      XPLMFindCommand("A300/LIGHTS/nose_light_down")                               ~= nil

      --LEDs
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_LateralDigit4/State")         ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/CargoClosedB")                  ~= nil
     ) then return true
  else
    return false
  end
end
