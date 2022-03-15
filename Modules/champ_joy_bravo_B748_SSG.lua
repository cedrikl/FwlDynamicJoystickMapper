--SSG 747-8

function ChampBravoEngine_B748_SSG()

end

function ChampBravoMapping_B748_SSG()
  function bravo_Ap_AltInc(numticks) bravo_command_multiple("SSG/UFMC/Alt_UP", numticks) end
  function bravo_Ap_AltDec(numticks) bravo_command_multiple("SSG/UFMC/Alt_Down", numticks) end
  function bravo_Ap_VsInc(numticks)  bravo_command_multiple("SSG/UFMC/VS_UP", numticks) end
  function bravo_Ap_VsDec(numticks)  bravo_command_multiple("SSG/UFMC/VS_Down", numticks) end
  function bravo_Ap_HdgInc(numticks) bravo_command_multiple("SSG/UFMC/HDG_UP", numticks) end
  function bravo_Ap_HdgDec(numticks) bravo_command_multiple("SSG/UFMC/HDG_Down", numticks) end
  function bravo_Ap_IasInc(numticks) bravo_command_multiple("SSG/UFMC/Speed_UP", numticks) end
  function bravo_Ap_IasDec(numticks) bravo_command_multiple("SSG/UFMC/Speed_Down", numticks) end


  set_button_assignment(btq.ap_hdg,    "sim/none/none")
  function apPanelCockpitHdgShort(status) 
    if (status == "begin") then command_begin("SSG/UFMC/AP_HDG_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_HDG_Button") end
  end
  function apPanelCockpitHdgLong(status) 
    if (status == "begin") then command_begin("SSG/UFMC/AP_HDGHOLD_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_HDGHOLD_Button") end
  end

  set_button_assignment(btq.ap_nav,    "sim/none/none")
  function apPanelCockpitNavShort(status) 
    if (status == "begin") then command_begin("SSG/UFMC/AP_LNAV_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_LNAV_Button") end
  end
  function apPanelCockpitNavLong(status) 
    if (status == "begin") then command_begin("SSG/UFMC/AP_VNAV_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_VNAV_Button") end
  end

  set_button_assignment(btq.ap_apr,    "sim/none/none")
  function apPanelCockpitAprShort(status) 
    if (status == "begin") then command_begin("SSG/UFMC/AP_APP_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_APP_Button") end
  end
  function apPanelCockpitAprLong(status) 
    if (status == "begin") then command_begin("SSG/UFMC/AP_VORLOC_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_VORLOC_Button") end
  end

  --set_button_assignment(btq.ap_rev,    "sim/none/none")
  --function apPanelCockpitRevShort(status)    end
  --function apPanelCockpitRevLong(status)     end

  set_button_assignment(btq.ap_alt,    "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then command_begin("SSG/UFMC/AP_LVLCHG_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_LVLCHG_Button") end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then command_begin("sim/autopilot/altitude_hold") elseif (status == "end") then command_end("sim/autopilot/altitude_hold") end
  end

  set_button_assignment(btq.ap_vs,     "SSG/UFMC/AP_VS_Button")
  --function apPanelCockpitVsShort(status)
  --  if (status == "begin") then command_begin(") elseif (status == "end") then command_end("") end
  --end
  --function apPanelCockpitVsLong(status)
  --  if (status == "begin") then command_begin("") elseif (status == "end") then command_end("") end
  --end

  set_button_assignment(btq.ap_ias,    "sim/none/none")
  function apPanelCockpitIasShort(status)
    if (status == "begin") then command_begin("SSG/UFMC/AP_SPD_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_SPD_Button") end
  end
  function apPanelCockpitIasLong(status)
    if (status == "begin") then command_begin("SSG/UFMC/AP_N1_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_N1_Button") end
  end

  --set_button_assignment(btq.ap_master, "sim/none/none")
  --function apPanelCockpitMasterShort(status)
  --  if (status == "begin") then command_begin("AP1") elseif (status == "end") then command_end("a320/Panel/FCU_AutoPilot1_button") end
  --end
  --function apPanelCockpitMasterLong(status)
  --  if (status == "begin") then command_begin("AT ARM") elseif (status == "end") then command_end("a320/Panel/FCU_AutoThrust_button") end
  --end

  do_every_frame("apPanelDualHandler()")


  set_button_assignment(btq.axis12_2nd_func, "SSG/UFMC/AP_ARM_AT_Switch")
  set_button_assignment(btq.axis3_2nd_func,  "SSG/UFMC/TOGA_Button")

  --set_button_assignment(btq.sw2_up, "sim/none/none")
  --set_button_assignment(btq.sw2_dn, "sim/none/none")
  --do_often([[
  --    AcPos1 = get("model/controls/heat_engine1")
  --    AcPos2 = get("model/controls/heat_engine2")
  --    JoyPos = button(]]..btq.sw2_up..[[)
  --
  --    if (JoyPos and (AcPos1 < 0.0001)) then
  --      command_once("a320/Overhead/HeatEngine1_button")
  --    elseif (not(JoyPos) and (AcPos1 > 0.4999)) then
  --      command_once("a320/Overhead/HeatEngine1_button")
  --    end
  --
  --    if (JoyPos and (AcPos2 < 0.0001)) then
  --      command_once("a320/Overhead/HeatEngine2_button")
  --    elseif (not(JoyPos) and (AcPos2 > 0.4999)) then
  --      command_once("a320/Overhead/HeatEngine2_button")
  --    end
  --  ]])
  --set_button_assignment(btq.sw3_up, "sim/none/none")
  --set_button_assignment(btq.sw3_dn, "sim/none/none")
  --do_often([[
  --    AcPos1 = get("model/controls/heat_wing")
  --    JoyPos = button(]]..btq.sw3_up..[[)
  --
  --
  --    if (JoyPos and (AcPos1 < 0.0001)) then
  --      command_once("a320/Overhead/HeatWing_button")
  --    elseif (not(JoyPos) and (AcPos1 > 0.4999)) then
  --      command_once("a320/Overhead/HeatWing_button")
  --    end
  --  ]])
  --set_button_assignment(btq.sw5_up, "sim/none/none")
  --set_button_assignment(btq.sw5_dn, "sim/none/none")
  --do_often([[
  --    AcPos1 = get("model/controls/light_strobe")
  --    JoyPos = button(]]..btq.sw5_up..[[)
  --
  --
  --    if (JoyPos and (AcPos1 < 0.5001)) then
  --      command_once("a320/Overhead/LightStrobe_switch+")
  --    elseif (not(JoyPos) and (AcPos1 > 0.9999)) then
  --      command_once("a320/Overhead/LightStrobe_switch+")
  --    end
  --  ]])
  --set_button_assignment(btq.sw6_up,    "sim/none/none")
  --set_button_assignment(btq.sw6_dn,    "sim/none/none")
  --do_often([[
  --  L_Pos = get("model/controls/light_land1")
  --  LinGate = (L_Pos == 0.0) or (L_Pos == 0.5) or (L_Pos == 1.0)
  --  C_Pos = get("model/controls/light_nose")
  --  CinGate = (C_Pos == 0.0) or (C_Pos == 0.5) or (C_Pos == 1.0)
  --  R_Pos = get("model/controls/light_land2")
  --  RinGate = (R_Pos == 0.0) or (R_Pos == 0.5) or (R_Pos == 1.0)
  --  SwPos6 = button(]]..btq.sw6_up..[[)
  --  SwPos7 = button(]]..btq.sw7_up..[[)
  --  
  --  if (SwPos7 and (L_Pos ~= 1) and LinGate) then
  --    command_once("a320/Overhead/LightLandL_switch+")
  --  elseif (not(SwPos7) and (L_Pos ~= 0) and LinGate) then
  --    command_once("a320/Overhead/LightLandL_switch+")
  --  end
  --
  --  if (SwPos7 and (R_Pos ~= 1) and RinGate) then
  --    command_once("a320/Overhead/LightLandR_switch+")
  --  elseif (not(SwPos7) and (R_Pos ~= 0) and RinGate) then
  --    command_once("a320/Overhead/LightLandR_switch+")
  --  end
  --
  --  if (SwPos7 and (C_Pos ~= 1) and CinGate) then
  --    command_once("a320/Overhead/LightNose_switch+")
  --  elseif (SwPos6 and not(SwPos7) and (C_Pos ~= 0.5) and CinGate) then
  --    command_once("a320/Overhead/LightNose_switch+")
  --  elseif (not(SwPos6) and not(SwPos7) and (C_Pos ~= 0) and CinGate) then
  --    command_once("a320/Overhead/LightNose_switch+")
  --  end
  --]])
  set_button_assignment(btq.sw7_up,    "sim/none/none")
  set_button_assignment(btq.sw7_dn,    "sim/none/none")
  do_often([[
    INL_Pos =  get("SSG/LGT/lgt_inL_sw")
    INR_Pos =  get("SSG/LGT/lgt_inL_sw")
    OUTL_Pos = get("SSG/LGT/lgt_outL_sw")
    OUTR_Pos = get("SSG/LGT/lgt_outR_sw")
    SwPos7 = button(]]..btq.sw7_up..[[)
    
    if (SwPos7 and (INL_Pos ~= 1)) then
      command_once("SSG/Lights/Land_INL")
    elseif (not(SwPos7) and (INL_Pos ~= 0)) then
      command_once("SSG/Lights/Land_INL")
    end

    if (SwPos7 and (INR_Pos ~= 1)) then
      command_once("SSG/Lights/Land_INR")
    elseif (not(SwPos7) and (INR_Pos ~= 0)) then
      command_once("SSG/Lights/Land_INR")
    end

    if (SwPos7 and (OUTL_Pos ~= 1)) then
      command_once("SSG/Lights/Land_OUTL")
    elseif (not(SwPos7) and (OUTL_Pos ~= 0)) then
      command_once("SSG/Lights/Land_OUTL")
    end

    if (SwPos7 and (OUTR_Pos ~= 1)) then
      command_once("SSG/Lights/Land_OUTR")
    elseif (not(SwPos7) and (OUTR_Pos ~= 0)) then
      command_once("SSG/Lights/Land_OUTR")
    end
  ]])
end


function ChampBravoLed_B748_SSG()
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


function ChampBravoCheck_B748_SSG()
  if (--XPLMFindDataRef("a320/Aircraft/Electric/BCL1/Powered")     ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Electric/BCL2/Powered")     ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Electric/GCU1/Powered")     ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Electric/GCU2/Powered")     ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Electric/GCU3/Powered")     ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Electric/MGCU/Powered")     ~= nil and
      --AP Panel
      XPLMFindCommand("SSG/UFMC/Alt_UP")                         ~= nil and
      XPLMFindCommand("SSG/UFMC/Alt_Down")                       ~= nil and
      XPLMFindCommand("SSG/UFMC/VS_UP")                          ~= nil and
      XPLMFindCommand("SSG/UFMC/VS_Down")                        ~= nil and
      XPLMFindCommand("SSG/UFMC/HDG_UP")                         ~= nil and
      XPLMFindCommand("SSG/UFMC/HDG_Down")                       ~= nil and
      XPLMFindCommand("SSG/UFMC/Speed_UP")                       ~= nil and
      XPLMFindCommand("SSG/UFMC/Speed_Down")                     ~= nil and

      XPLMFindCommand("SSG/UFMC/AP_HDG_Button")                  ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_HDGHOLD_Button")              ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_LNAV_Button")                 ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_VNAV_Button")                 ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_APP_Button")                  ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_VORLOC_Button")               ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_discon_Button")               ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_VS_Button")                   ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_LVLCHG_Button")               ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_SPD_Button")                  ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_N1_Button")                   ~= nil and
      ----Axis
      XPLMFindCommand("SSG/UFMC/AP_ARM_AT_Switch")               ~= nil and
      XPLMFindCommand("SSG/UFMC/TOGA_Button")                    ~= nil and
      ----Switches
      --XPLMFindDataRef("model/controls/heat_engine1")             ~= nil and
      --XPLMFindDataRef("model/controls/heat_engine1")             ~= nil and
      --XPLMFindCommand("a320/Overhead/HeatEngine1_button")        ~= nil and
      --XPLMFindCommand("a320/Overhead/HeatEngine2_button")        ~= nil and
      --XPLMFindDataRef("model/controls/heat_wing")                ~= nil and
      --XPLMFindCommand("a320/Overhead/HeatWing_button")           ~= nil and
      --XPLMFindDataRef("model/controls/light_strobe")             ~= nil and
      --XPLMFindCommand("a320/Overhead/LightStrobe_switch+")       ~= nil and

      --XPLMFindDataRef("model/controls/light_nose")               ~= nil and
      --XPLMFindCommand("SSG/Lights/beacon")                       ~= nil and
      --XPLMFindCommand("SSG/Lights/Nav")                          ~= nil and
      --XPLMFindCommand("a320/Overhead/LightNose_switch+")                             ~= nil and

      XPLMFindDataRef("SSG/LGT/lgt_inL_sw")                      ~= nil and
      XPLMFindDataRef("SSG/LGT/lgt_inL_sw")                      ~= nil and
      XPLMFindDataRef("SSG/LGT/lgt_outL_sw")                     ~= nil and
      XPLMFindDataRef("SSG/LGT/lgt_outR_sw")                     ~= nil and
      XPLMFindCommand("SSG/Lights/Land_INL")                     ~= nil and
      XPLMFindCommand("SSG/Lights/Land_INR")                     ~= nil and
      XPLMFindCommand("SSG/Lights/Land_OUTL")                    ~= nil and
      XPLMFindCommand("SSG/Lights/Land_OUTR")                    ~= nil and
      ----LEDs
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_LateralDigit4/State")         ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_LocalizerLight/State")        ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_ApproachLight/State")         ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_AltitudeDigit6/State")        ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_VerticalDigit6/State")        ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_SpeedDigit5/State")           ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight1/State")       ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight2/State")       ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastCautLightLA/Intensity") ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastCautLightLB/Intensity") ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastCautLightRA/Intensity") ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastCautLightRB/Intensity") ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightLA/Intensity") ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightLB/Intensity") ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightRA/Intensity") ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Panel/ShieldMastWarnLightRB/Intensity") ~= nil and 
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/FireEngine1_LightA/Intensity") ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/FireEngine1_LightB/Intensity") ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/FireAPU_LightA/Intensity")     ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/FireAPU_LightB/Intensity")     ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/FireEngine2_LightA/Intensity") ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/FireEngine2_LightB/Intensity") ~= nil and
      --XPLMFindDataRef("a320/Aircraft/PowerPlant/EngineL/StarterValve/Position")      ~= nil and
      --XPLMFindDataRef("a320/Aircraft/PowerPlant/EngineR/StarterValve/Position")      ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Cockpit/Overhead/APU_MasterOn/Intensity")       ~= nil and
      --XPLMFindDataRef("a320/Aircraft/PowerPlant/APU/APU_Rate")                       ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/DoorClosedLF")                  ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/DoorClosedRF")                  ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/CargoClosedF")                  ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/DoorClosedLB")                  ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/DoorClosedRB")                  ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Pneumatic/Cabin/CargoClosedB")                  ~= nil
      true
     ) then return true
  else
    return false
  end
end
