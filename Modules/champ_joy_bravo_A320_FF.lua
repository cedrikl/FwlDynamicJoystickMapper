--Flight Factor A320 Ultimate

function ChampBravoMapping_A320_FF()
  function bravo_Ap_AltInc(numticks) bravo_command_multiple("a320/Panel/FCU_Altitude_switch+", numticks) end
  function bravo_Ap_AltDec(numticks) bravo_command_multiple("a320/Panel/FCU_Altitude_switch-", numticks) end
  function bravo_Ap_VsInc(numticks)  bravo_command_multiple("a320/Panel/FCU_Vertical_switch+", numticks) end
  function bravo_Ap_VsDec(numticks)  bravo_command_multiple("a320/Panel/FCU_Vertical_switch-", numticks) end
  function bravo_Ap_HdgInc(numticks) bravo_command_multiple("a320/Panel/FCU_Lateral_switch+", numticks) end
  function bravo_Ap_HdgDec(numticks) bravo_command_multiple("a320/Panel/FCU_Lateral_switch-", numticks) end
  function bravo_Ap_IasInc(numticks) bravo_command_multiple("a320/Panel/FCU_Speed_switch+", numticks) end
  function bravo_Ap_IasDec(numticks) bravo_command_multiple("a320/Panel/FCU_Speed_switch-", numticks) end

  set_button_assignment(btq.ap_hdg,    "sim/none/none")
  function apPanelCockpitHdgShort(status) 
    --if (status == "begin") then set("a320/Panel/FCU_LateralMode", 1) elseif (status == "end") then set("a320/Panel/FCU_LateralMode", 0) end ... alternative with datarefs
    if (status == "begin") then command_begin("a320/Panel/FCU_LateralMode_switch_push") elseif (status == "end") then command_end("a320/Panel/FCU_LateralMode_switch_push") end
  end
  function apPanelCockpitHdgLong(status) 
    if (status == "begin") then command_begin("a320/Panel/FCU_LateralMode_switch_pull") elseif (status == "end") then command_end("a320/Panel/FCU_LateralMode_switch_pull") end
  end

  set_button_assignment(btq.ap_nav,    "sim/none/none")
  function apPanelCockpitNavShort(status) 
    --
  end
  function apPanelCockpitNavLong(status) 
    --
  end

  set_button_assignment(btq.ap_apr,    "sim/none/none")
  function apPanelCockpitAprShort(status) 
    if (status == "begin") then command_begin("a320/Panel/FCU_Approach_button") elseif (status == "end") then command_end("a320/Panel/FCU_Approach_button") end
  end
  function apPanelCockpitAprLong(status) 
    if (status == "begin") then command_begin("a320/Panel/FCU_Localizer_button") elseif (status == "end") then command_end("a320/Panel/FCU_Localizer_button") end
  end

  set_button_assignment(btq.ap_rev,    "sim/none/none")
  function apPanelCockpitRevShort(status)    end
  function apPanelCockpitRevLong(status)     end

  set_button_assignment(btq.ap_alt,    "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then command_begin("a320/Panel/FCU_AltitudeMode_switch_push") elseif (status == "end") then command_end("a320/Panel/FCU_AltitudeMode_switch_push") end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then command_begin("a320/Panel/FCU_AltitudeMode_switch_pull") elseif (status == "end") then command_end("a320/Panel/FCU_AltitudeMode_switch_pull") end
  end

  set_button_assignment(btq.ap_vs,     "sim/none/none")
  function apPanelCockpitVsShort(status)
    if (status == "begin") then command_begin("a320/Panel/FCU_VerticalMode_switch_push") elseif (status == "end") then command_end("a320/Panel/FCU_VerticalMode_switch_push") end
  end
  function apPanelCockpitVsLong(status)
    if (status == "begin") then command_begin("a320/Panel/FCU_VerticalMode_switch_pull") elseif (status == "end") then command_end("a320/Panel/FCU_VerticalMode_switch_pull") end
  end

  set_button_assignment(btq.ap_ias,    "sim/none/none")
  function apPanelCockpitIasShort(status)
    if (status == "begin") then command_begin("a320/Panel/FCU_SpeedMode_switch_push") elseif (status == "end") then command_end("a320/Panel/FCU_SpeedMode_switch_push") end
  end
  function apPanelCockpitIasLong(status)
    if (status == "begin") then command_begin("a320/Panel/FCU_SpeedMode_switch_pull") elseif (status == "end") then command_end("a320/Panel/FCU_SpeedMode_switch_pull") end
  end

  set_button_assignment(btq.ap_master, "sim/none/none")
  function apPanelCockpitMasterShort(status)
    if (status == "begin") then command_begin("a320/Panel/FCU_AutoPilot1_button") elseif (status == "end") then command_end("a320/Panel/FCU_AutoPilot1_button") end
  end
  function apPanelCockpitMasterLong(status)
    if (status == "begin") then command_begin("a320/Panel/FCU_AutoThrust_button") elseif (status == "end") then command_end("a320/Panel/FCU_AutoThrust_button") end
  end

  do_every_frame("apPanelDualHandler()")

  set_button_assignment(btq.axis3_2nd_func, "a320/Pedestal/EngineDisconnect1_button")
  set_button_assignment(btq.axis4_2nd_func, "sim/none/none")

  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_every_frame([[
      AcPos1 = get("model/controls/heat_engine1")
      AcPos2 = get("model/controls/heat_engine2")
      JoyPos = button(]]..btq.sw2_up..[[)

      if (JoyPos and (AcPos1 < 0.0001)) then
        command_once("a320/Overhead/HeatEngine1_button")
      elseif (not(JoyPos) and (AcPos1 > 0.4999)) then
        command_once("a320/Overhead/HeatEngine1_button")
      end
  
      if (JoyPos and (AcPos2 < 0.0001)) then
        command_once("a320/Overhead/HeatEngine2_button")
      elseif (not(JoyPos) and (AcPos2 > 0.4999)) then
        command_once("a320/Overhead/HeatEngine2_button")
      end
    ]])
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
  do_every_frame([[
      AcPos1 = get("model/controls/heat_wing")
      JoyPos = button(]]..btq.sw3_up..[[)
  
  
      if (JoyPos and (AcPos1 < 0.0001)) then
        command_once("a320/Overhead/HeatWing_button")
      elseif (not(JoyPos) and (AcPos1 > 0.4999)) then
        command_once("a320/Overhead/HeatWing_button")
      end
    ]])
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_every_frame([[
      AcPos1 = get("model/controls/light_strobe")
      JoyPos = button(]]..btq.sw5_up..[[)
  
  
      if (JoyPos and (AcPos1 < 0.5001)) then
        command_once("a320/Overhead/LightStrobe_switch+")
      elseif (not(JoyPos) and (AcPos1 > 0.9999)) then
        command_once("a320/Overhead/LightStrobe_switch+")
      end
    ]])
  set_button_assignment(btq.sw6_up,    "sim/none/none")
  set_button_assignment(btq.sw6_dn,    "sim/none/none")
  set_button_assignment(btq.sw7_up,    "sim/none/none")
  set_button_assignment(btq.sw7_dn,    "sim/none/none")
  --model/controls/light_strobe
  do_every_frame([[
    L_Pos = get("model/controls/light_land1")
    LinGate = (L_Pos == 0.0) or (L_Pos == 0.5) or (L_Pos == 1.0)
    C_Pos = get("model/controls/light_nose")
    CinGate = (C_Pos == 0.0) or (C_Pos == 0.5) or (C_Pos == 1.0)
    R_Pos = get("model/controls/light_land2")
    RinGate = (R_Pos == 0.0) or (R_Pos == 0.5) or (R_Pos == 1.0)
    SwPos6 = button(]]..btq.sw6_up..[[)
    SwPos7 = button(]]..btq.sw7_up..[[)
    
    if (SwPos7 and (L_Pos ~= 1) and LinGate) then
      command_once("a320/Overhead/LightLandL_switch+")
    elseif (not(SwPos7) and (L_Pos ~= 0) and LinGate) then
      command_once("a320/Overhead/LightLandL_switch+")
    end

    if (SwPos7 and (R_Pos ~= 1) and RinGate) then
      command_once("a320/Overhead/LightLandR_switch+")
    elseif (not(SwPos7) and (R_Pos ~= 0) and RinGate) then
      command_once("a320/Overhead/LightLandR_switch+")
    end

    if (SwPos7 and (C_Pos ~= 1) and CinGate) then
      command_once("a320/Overhead/LightNose_switch+")
    elseif (SwPos6 and not(SwPos7) and (C_Pos ~= 0.5) and CinGate) then
      command_once("a320/Overhead/LightNose_switch+")
    elseif (not(SwPos6) and not(SwPos7) and (C_Pos ~= 0) and CinGate) then
      command_once("a320/Overhead/LightNose_switch+")
    end
  ]])
end


function ChampBravoLed_A320_FF()
  --Need to add these lines to "*\FlightFactor A320 ultimate\data\publish.txt"

  --a320/Aircraft/Electric/BCL1/Powered
  --a320/Aircraft/Electric/BCL2/Powered
  --a320/Aircraft/Electric/GCU1/Powered
  --a320/Aircraft/Electric/GCU2/Powered
  --a320/Aircraft/Electric/GCU3/Powered
  --a320/Aircraft/Electric/MGCU/Powered

  --a320/Aircraft/Cockpit/Panel/FCU_LateralDigit4/State
  --a320/Aircraft/Cockpit/Panel/FCU_LateralDigit4/State
  --a320/Aircraft/Cockpit/Panel/FCU_LocalizerLight/State
  --a320/Aircraft/Cockpit/Panel/FCU_ApproachLight/State
  --a320/Aircraft/Cockpit/Panel/FCU_AltitudeDigit6/State
  --a320/Aircraft/Cockpit/Panel/FCU_VerticalDigit6/State
  --a320/Aircraft/Cockpit/Panel/FCU_SpeedDigit5/State
  --a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight1/State
  --a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight2/State

  --a320/Aircraft/Cockpit/Panel/ShieldMastCautLightLA/Intensity
  --a320/Aircraft/Cockpit/Panel/ShieldMastCautLightLB/Intensity
  --a320/Aircraft/Cockpit/Panel/ShieldMastCautLightRA/Intensity
  --a320/Aircraft/Cockpit/Panel/ShieldMastCautLightRB/Intensity
  --a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightLA/Intensity
  --a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightLB/Intensity
  --a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightRA/Intensity
  --a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightRB/Intensity
  --a320/Aircraft/Cockpit/Overhead/FireEngine1_LightA/Intensity
  --a320/Aircraft/Cockpit/Overhead/FireEngine1_LightB/Intensity
  --a320/Aircraft/Cockpit/Overhead/FireAPU_LightA/Intensity
  --a320/Aircraft/Cockpit/Overhead/FireAPU_LightB/Intensity
  --a320/Aircraft/Cockpit/Overhead/FireEngine2_LightA/Intensity
  --a320/Aircraft/Cockpit/Overhead/FireEngine2_LightB/Intensity
  --a320/Aircraft/PowerPlant/EngineL/StarterValve/Position
  --a320/Aircraft/PowerPlant/EngineR/StarterValve/Position
  --a320/Aircraft/Cockpit/Overhead/APU_MasterOn/Intensity
  --a320/Aircraft/PowerPlant/APU/APU_Rate
  --a320/Aircraft/Pneumatic/Cabin/DoorClosedLF
  --a320/Aircraft/Pneumatic/Cabin/DoorClosedRF
  --a320/Aircraft/Pneumatic/Cabin/CargoClosedF
  --a320/Aircraft/Pneumatic/Cabin/DoorClosedLB
  --a320/Aircraft/Pneumatic/Cabin/DoorClosedRB
  --a320/Aircraft/Pneumatic/Cabin/CargoClosedB

  btq_led.led_check(
    (
      (get("a320/Aircraft/Cockpit/Panel/FCU_LateralDigit4/State") == 0)
    ), btq_led, 'A', btq_led.block_A_LED.HEADING)
  btq_led.led_check(
    (
      (get("a320/Aircraft/Cockpit/Panel/FCU_LateralDigit4/State") ~= 0)
    ), btq_led, 'A', btq_led.block_A_LED.NAV)
  btq_led.led_check(
    (
      (get("a320/Aircraft/Cockpit/Panel/FCU_LocalizerLight/State") == 1) or
      (get("a320/Aircraft/Cockpit/Panel/FCU_ApproachLight/State") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.APR)
  btq_led.led_check(
    (
      (get("a320/Aircraft/Cockpit/Panel/FCU_AltitudeDigit6/State") ~= 0)
    ), btq_led, 'A', btq_led.block_A_LED.ALT)
  btq_led.led_check(
    (
      (get("a320/Aircraft/Cockpit/Panel/FCU_VerticalDigit6/State") ~= 13)
    ), btq_led, 'A', btq_led.block_A_LED.VS)
  btq_led.led_check(
    (
      (get("a320/Aircraft/Cockpit/Panel/FCU_SpeedDigit5/State") ~= 0)
    ), btq_led, 'A', btq_led.block_A_LED.IAS)
  btq_led.led_check(
    (
      (get("a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight1/State") == 1) or
      (get("a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight2/State") == 1)
    ), btq_led, 'A', btq_led.block_A_LED.AP)

  btq_led.led_check(
    (
      (get("a320/Aircraft/Cockpit/Panel/ShieldMastCautLightLA/Intensity") > 0.1) or
      (get("a320/Aircraft/Cockpit/Panel/ShieldMastCautLightLB/Intensity") > 0.1) or
      (get("a320/Aircraft/Cockpit/Panel/ShieldMastCautLightRA/Intensity") > 0.1) or
      (get("a320/Aircraft/Cockpit/Panel/ShieldMastCautLightRB/Intensity") > 0.1)
    ), btq_led, 'C', btq_led.block_C_LED.MASTER_CAUTION)
  btq_led.led_check(
    (
      (get("a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightLA/Intensity") > 0.1) or
      (get("a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightLB/Intensity") > 0.1) or
      (get("a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightRA/Intensity") > 0.1) or
      (get("a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightRB/Intensity") > 0.1)
    ), btq_led, 'B', btq_led.block_B_LED.MASTER_WARNING)
  btq_led.led_check(
    (
      (get("a320/Aircraft/Cockpit/Overhead/FireEngine1_LightA/Intensity") > 0.1) or
      (get("a320/Aircraft/Cockpit/Overhead/FireEngine1_LightB/Intensity") > 0.1) or
      (get("a320/Aircraft/Cockpit/Overhead/FireAPU_LightA/Intensity")     > 0.1) or
      (get("a320/Aircraft/Cockpit/Overhead/FireAPU_LightB/Intensity")     > 0.1) or
      (get("a320/Aircraft/Cockpit/Overhead/FireEngine2_LightA/Intensity") > 0.1) or
      (get("a320/Aircraft/Cockpit/Overhead/FireEngine2_LightB/Intensity") > 0.1)
    ), btq_led, 'B', btq_led.block_B_LED.ENGINE_FIRE)
  btq_led.led_check(
    (
      (get("a320/Aircraft/PowerPlant/EngineL/StarterValve/Position") > 0.9) or
      (get("a320/Aircraft/PowerPlant/EngineR/StarterValve/Position") > 0.9)
    ), btq_led, 'C', btq_led.block_C_LED.STARTER)
  btq_led.led_check(
    (
      (get("a320/Aircraft/Cockpit/Overhead/APU_MasterOn/Intensity") > 0.1) or
      (get("a320/Aircraft/PowerPlant/APU/APU_Rate") > 0.01)
    ), btq_led, 'C', btq_led.block_C_LED.APU)
  btq_led.led_check(
    (
      (get("a320/Aircraft/Pneumatic/Cabin/DoorClosedLF") ~= 1.0) or
      (get("a320/Aircraft/Pneumatic/Cabin/DoorClosedRF") ~= 1.0) or
      (get("a320/Aircraft/Pneumatic/Cabin/CargoClosedF") ~= 1.0) or
      (get("a320/Aircraft/Pneumatic/Cabin/DoorClosedLB") ~= 1.0) or
      (get("a320/Aircraft/Pneumatic/Cabin/DoorClosedRB") ~= 1.0) or
      (get("a320/Aircraft/Pneumatic/Cabin/CargoClosedB") ~= 1.0)
    ), btq_led, 'D', btq_led.block_D_LED.DOOR)
  if (
      get("a320/Aircraft/Electric/BCL1/Powered") == 0 and
      get("a320/Aircraft/Electric/BCL2/Powered") == 0 and
      get("a320/Aircraft/Electric/GCU1/Powered") == 0 and
      get("a320/Aircraft/Electric/GCU2/Powered") == 0 and
      get("a320/Aircraft/Electric/GCU3/Powered") == 0 and
      get("a320/Aircraft/Electric/MGCU/Powered") == 0
     ) then setAllToOff()
  end
end


function ChampBravoCheck_A320_FF()
  if (XPLMFindDataRef("a320/Aircraft/Electric/BCL1/Powered")                         ~= nil and
      XPLMFindDataRef("a320/Aircraft/Electric/BCL2/Powered")                         ~= nil and
      XPLMFindDataRef("a320/Aircraft/Electric/GCU1/Powered")                         ~= nil and
      XPLMFindDataRef("a320/Aircraft/Electric/GCU2/Powered")                         ~= nil and
      XPLMFindDataRef("a320/Aircraft/Electric/GCU3/Powered")                         ~= nil and
      XPLMFindDataRef("a320/Aircraft/Electric/MGCU/Powered")                         ~= nil and
      --AP Panel
      XPLMFindCommand("a320/Panel/FCU_Altitude_switch+")                             ~= nil and
      XPLMFindCommand("a320/Panel/FCU_Altitude_switch-")                             ~= nil and
      XPLMFindCommand("a320/Panel/FCU_Vertical_switch+")                             ~= nil and
      XPLMFindCommand("a320/Panel/FCU_Vertical_switch-")                             ~= nil and
      XPLMFindCommand("a320/Panel/FCU_Lateral_switch+")                              ~= nil and
      XPLMFindCommand("a320/Panel/FCU_Lateral_switch-")                              ~= nil and
      XPLMFindCommand("a320/Panel/FCU_Speed_switch+")                                ~= nil and
      XPLMFindCommand("a320/Panel/FCU_Speed_switch-")                                ~= nil and

      XPLMFindCommand("a320/Panel/FCU_LateralMode_switch_push")                      ~= nil and
      XPLMFindCommand("a320/Panel/FCU_LateralMode_switch_pull")                      ~= nil and
      XPLMFindCommand("a320/Panel/FCU_Localizer_button")                             ~= nil and
      XPLMFindCommand("a320/Panel/FCU_Approach_button")                              ~= nil and
      XPLMFindCommand("a320/Panel/FCU_AltitudeMode_switch_push")                     ~= nil and
      XPLMFindCommand("a320/Panel/FCU_AltitudeMode_switch_pull")                     ~= nil and
      XPLMFindCommand("a320/Panel/FCU_VerticalMode_switch_push")                     ~= nil and
      XPLMFindCommand("a320/Panel/FCU_VerticalMode_switch_pull")                     ~= nil and
      XPLMFindCommand("a320/Panel/FCU_SpeedMode_switch_push")                        ~= nil and
      XPLMFindCommand("a320/Panel/FCU_SpeedMode_switch_pull")                        ~= nil and
      XPLMFindCommand("a320/Panel/FCU_AutoPilot1_button")                            ~= nil and
      XPLMFindCommand("a320/Panel/FCU_AutoThrust_button")                            ~= nil and
      --Axis
      XPLMFindCommand("a320/Pedestal/EngineDisconnect1_button")                      ~= nil and

      --Switches
      XPLMFindDataRef("model/controls/heat_engine1")                                 ~= nil and
      XPLMFindDataRef("model/controls/heat_engine1")                                 ~= nil and
      XPLMFindCommand("a320/Overhead/HeatEngine1_button")                            ~= nil and
      XPLMFindCommand("a320/Overhead/HeatEngine2_button")                            ~= nil and
      XPLMFindDataRef("model/controls/heat_wing")                                    ~= nil and
      XPLMFindCommand("a320/Overhead/HeatWing_button")                               ~= nil and
      XPLMFindDataRef("model/controls/light_strobe")                                 ~= nil and
      XPLMFindCommand("a320/Overhead/LightStrobe_switch+")                           ~= nil and
      XPLMFindDataRef("model/controls/light_nose")                                   ~= nil and
      XPLMFindDataRef("model/controls/light_land1")                                  ~= nil and
      XPLMFindDataRef("model/controls/light_land2")                                  ~= nil and
      XPLMFindCommand("a320/Overhead/LightNose_switch+")                             ~= nil and
      XPLMFindCommand("a320/Overhead/LightLandL_switch+")                            ~= nil and
      XPLMFindCommand("a320/Overhead/LightLandR_switch+")                            ~= nil and
      --LEDs
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_LateralDigit4/State")         ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_LocalizerLight/State")        ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_ApproachLight/State")         ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_AltitudeDigit6/State")        ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_VerticalDigit6/State")        ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_SpeedDigit5/State")           ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight1/State")       ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight2/State")       ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastCautLightLA/Intensity") ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastCautLightLB/Intensity") ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastCautLightRA/Intensity") ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastCautLightRB/Intensity") ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightLA/Intensity") ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightLB/Intensity") ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightRA/Intensity") ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightRB/Intensity") ~= nil and 
      XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/FireEngine1_LightA/Intensity") ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/FireEngine1_LightB/Intensity") ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/FireAPU_LightA/Intensity")     ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/FireAPU_LightB/Intensity")     ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/FireEngine2_LightA/Intensity") ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/FireEngine2_LightB/Intensity") ~= nil and
      XPLMFindDataRef("a320/Aircraft/PowerPlant/EngineL/StarterValve/Position")      ~= nil and
      XPLMFindDataRef("a320/Aircraft/PowerPlant/EngineR/StarterValve/Position")      ~= nil and
      XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/APU_MasterOn/Intensity")       ~= nil and
      XPLMFindDataRef("a320/Aircraft/PowerPlant/APU/APU_Rate")                       ~= nil and
      XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/DoorClosedLF")                  ~= nil and
      XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/DoorClosedRF")                  ~= nil and
      XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/CargoClosedF")                  ~= nil and
      XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/DoorClosedLB")                  ~= nil and
      XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/DoorClosedRB")                  ~= nil and
      XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/CargoClosedB")                  ~= nil
     ) then return true
  else
    return false
  end
end
