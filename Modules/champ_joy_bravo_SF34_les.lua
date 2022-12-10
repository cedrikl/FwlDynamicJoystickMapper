function ChampBravoEngine_SF34_les()
  set_axis_assignment(btq.axis1, "none", "normal")
  set_axis_assignment(btq.axis2, "none", "normal")
  set_axis_assignment(btq.axis3, "none", "normal")
  set_axis_assignment(btq.axis4, "none", "normal")
  set_axis_assignment(btq.axis5, "none", "normal")
  set_axis_assignment(btq.axis6, "none", "normal")


  previous_axis1_rev_handle = 0
  previous_axis2_rev_handle = 0
  do_every_frame([[
    Throttle1Pos = get("sim/joystick/joystick_axis_values",]]..btq.axis1..[[)
    Throttle2Pos = get("sim/joystick/joystick_axis_values",]]..btq.axis2..[[)
    Throttle1Rev = button(]]..btq.axis1_rev_handle..[[)
    Throttle2Rev = button(]]..btq.axis2_rev_handle..[[)

    if (Throttle1Rev) then
      set("les/sf34a/acft/engn/mnp/power_lever_L", ((-41 * Throttle1Pos) + 41))
    else
      set("les/sf34a/acft/engn/mnp/power_lever_L", ((58 * Throttle1Pos) + 42))
    end

    if (Throttle1Rev and (previous_axis1_rev_handle == 0)) then
      command_begin("les/sf34a/acft/engn/mnp/pl_fi_latch_L")
      previous_axis1_rev_handle = 1
    end

    if (not(Throttle1Rev) and (previous_axis1_rev_handle == 1)) then
      command_end("les/sf34a/acft/engn/mnp/pl_fi_latch_L")
      previous_axis1_rev_handle = 0
    end

    if (Throttle2Rev) then
      set("les/sf34a/acft/engn/mnp/power_lever_R", ((-41 * Throttle2Pos) + 41))
    else
      set("les/sf34a/acft/engn/mnp/power_lever_R", ((58 * Throttle2Pos) + 42))
    end

    if (Throttle2Rev and (previous_axis2_rev_handle == 0)) then
      command_begin("les/sf34a/acft/engn/mnp/pl_fi_latch_R")
      previous_axis2_rev_handle = 1
    end

    if (not(Throttle2Rev) and (previous_axis2_rev_handle == 1)) then
      command_end("les/sf34a/acft/engn/mnp/pl_fi_latch_R")
      previous_axis2_rev_handle = 0
    end
  ]])

  do_every_frame([[
    Axis5Pos = get("sim/joystick/joystick_axis_values",]]..btq.axis5..[[)
    Axis6Pos = get("sim/joystick/joystick_axis_values",]]..btq.axis6..[[)
    Cond1Pos = get("les/sf34a/acft/engn/mnp/condition_lever_L")
    Cond2Pos = get("les/sf34a/acft/engn/mnp/condition_lever_R")

    if (Cond1Pos >= 42) then
      set("les/sf34a/acft/engn/mnp/condition_lever_L", ((48 * Axis5Pos) + 42))
    end
    
    if (Cond2Pos >= 42) then
      set("les/sf34a/acft/engn/mnp/condition_lever_R", ((48 * Axis6Pos) + 42))
    end
  ]])

end

function ChampBravoCheck_SF34_les()
  if (--XPLMFindDataRef("a320/Aircraft/Electric/BCL1/Powered")                         ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Electric/BCL2/Powered")                         ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Electric/GCU1/Powered")                         ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Electric/GCU2/Powered")                         ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Electric/GCU3/Powered")                         ~= nil and
      --XPLMFindDataRef("a320/Aircraft/Electric/MGCU/Powered")                         ~= nil and
      ----AP Panel
      --XPLMFindCommand("a320/Panel/FCU_Altitude_switch+")                             ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_Altitude_switch-")                             ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_Vertical_switch+")                             ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_Vertical_switch-")                             ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_Lateral_switch+")                              ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_Lateral_switch-")                              ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_Speed_switch+")                                ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_Speed_switch-")                                ~= nil and
      --
      --XPLMFindCommand("a320/Panel/FCU_LateralMode_switch_push")                      ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_LateralMode_switch_pull")                      ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_Localizer_button")                             ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_Approach_button")                              ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_AltitudeMode_switch_push")                     ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_AltitudeMode_switch_pull")                     ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_VerticalMode_switch_push")                     ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_VerticalMode_switch_pull")                     ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_SpeedMode_switch_push")                        ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_SpeedMode_switch_pull")                        ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_AutoPilot1_button")                            ~= nil and
      --XPLMFindCommand("a320/Panel/FCU_AutoThrust_button")                            ~= nil and

      --Axis

      XPLMFindDataRef("les/sf34a/acft/engn/mnp/power_lever_L")                       ~= nil and
      XPLMFindDataRef("les/sf34a/acft/engn/mnp/power_lever_R")                       ~= nil and
      XPLMFindCommand("les/sf34a/acft/engn/mnp/pl_fi_latch_L")                       ~= nil and
      XPLMFindCommand("les/sf34a/acft/engn/mnp/pl_fi_latch_R")                       ~= nil and
      XPLMFindDataRef("les/sf34a/acft/engn/mnp/condition_lever_L")                   ~= nil and
      XPLMFindDataRef("les/sf34a/acft/engn/mnp/condition_lever_R")                   ~= nil

      ----Switches
      --XPLMFindDataRef("model/controls/heat_engine1")                                 ~= nil and
      --XPLMFindDataRef("model/controls/heat_engine1")                                 ~= nil and
      --XPLMFindCommand("a320/Overhead/HeatEngine1_button")                            ~= nil and
      --XPLMFindCommand("a320/Overhead/HeatEngine2_button")                            ~= nil and
      --XPLMFindDataRef("model/controls/heat_wing")                                    ~= nil and
      --XPLMFindCommand("a320/Overhead/HeatWing_button")                               ~= nil and
      --XPLMFindDataRef("model/controls/light_strobe")                                 ~= nil and
      --XPLMFindCommand("a320/Overhead/LightStrobe_switch+")                           ~= nil and
      --XPLMFindDataRef("model/controls/light_nose")                                   ~= nil and
      --XPLMFindDataRef("model/controls/light_land1")                                  ~= nil and
      --XPLMFindDataRef("model/controls/light_land2")                                  ~= nil and
      --XPLMFindCommand("a320/Overhead/LightNose_switch+")                             ~= nil and
      --XPLMFindCommand("a320/Overhead/LightLandL_switch+")                            ~= nil and
      --XPLMFindCommand("a320/Overhead/LightLandR_switch+")                            ~= nil and
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
     ) then return true
  else
    return false
  end
end