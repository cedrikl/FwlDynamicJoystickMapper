--Flight Factor A320 Ultimate Alpha Mappings

function ChampAlphaMapping_A320_FF()
--Batt switches
  set_button_assignment(afy.B_BattOn,    "sim/none/none")
  set_button_assignment(afy.B_BattOff,   "sim/none/none")
  do_often([[
    Batt1_Pos = get("model/controls/elec_bat1")
    Batt2_Pos = get("model/controls/elec_bat2")
    SwBattPos = button(]]..afy.B_BattOn..[[)

    if (SwBattPos and (Batt1_Pos ~= 0.5)) then
      command_once("a320/Overhead/ElecBat1_button")
    elseif (not(SwBattPos) and (Batt1_Pos == 0.5)) then
      command_once("a320/Overhead/ElecBat1_button")
    end

    if (SwBattPos and (Batt2_Pos ~= 0.5)) then
      command_once("a320/Overhead/ElecBat2_button")
    elseif (not(SwBattPos) and (Batt2_Pos == 0.5)) then
      command_once("a320/Overhead/ElecBat2_button")
    end
    ]])
--Beacon switch
  set_button_assignment(afy.B_BcnOn,    "sim/none/none")
  set_button_assignment(afy.B_BcnOff,   "sim/none/none")
  do_often([[
    Bcn_Pos = get("model/controls/light_beacon")
    SwBcnPos = button(]]..afy.B_BcnOn..[[)

    if (SwBcnPos and (Bcn_Pos ~= 1)) then
      command_once("a320/Overhead/LightBeacon_switch+")
    elseif (not(SwBcnPos) and (Bcn_Pos == 1)) then
      command_once("a320/Overhead/LightBeacon_switch+")
    end
    ]])
--TurnOff switch
  set_button_assignment(afy.B_LandOn,    "sim/none/none")
  set_button_assignment(afy.B_LandOff,   "sim/none/none")
  do_often([[
    Turn_Pos = get("model/controls/light_turn")
    SwLandPos = button(]]..afy.B_LandOn..[[)

    if (SwLandPos and (Turn_Pos ~= 1)) then
      command_once("a320/Overhead/LightTurn_switch+")
    elseif (not(SwLandPos) and (Turn_Pos == 1)) then
      command_once("a320/Overhead/LightTurn_switch+")
    end
    ]])
--Wing Lights switch
  set_button_assignment(afy.B_TaxiOn,    "sim/none/none")
  set_button_assignment(afy.B_TaxiOff,   "sim/none/none")
  do_often([[
    Wing_Pos = get("model/controls/light_wing")
    SwTaxiPos = button(]]..afy.B_TaxiOn..[[)

    if (SwTaxiPos and (Wing_Pos ~= 1)) then
      command_once("a320/Overhead/LightWing_switch+")
    elseif (not(SwTaxiPos) and (Wing_Pos == 1)) then
      command_once("a320/Overhead/LightWing_switch+")
    end
    ]])
--Nav and Logo Light switch
  set_button_assignment(afy.B_NavOn,       "sim/none/none")
  set_button_assignment(afy.B_NavOff,      "sim/none/none")
  set_button_assignment(afy.B_StrobeOn,    "sim/none/none")
  set_button_assignment(afy.B_StrobeOff,   "sim/none/none")
  do_often([[
    Logo_Pos = get("model/controls/light_logo")
    LinGate = (L_Pos == 0.0) or (L_Pos == 0.5) or (L_Pos == 1.0)
    SwNavPos = button(]]..afy.B_NavOn..[[)
    SwStrobePos = button(]]..afy.B_StrobeOn..[[)

    if (SwStrobePos and (Logo_Pos ~= 1) and LinGate) then
      command_once("a320/Overhead/LightLogo_switch+")
    elseif (SwNavPos and not(SwStrobePos) and (Logo_Pos ~= 0.5) and LinGate) then
      command_once("a320/Overhead/LightLogo_switch+")
    elseif (not(SwNavPos) and not (SwStrobePos) and (Logo_Pos ~= 0)and LinGate) then
      command_once("a320/Overhead/LightLogo_switch+")
    end
    ]])
end

function ChampAlphaCheck_A320_FF()
  if (
      XPLMFindDataRef("model/controls/elec_bat1")                         ~= nil and
      XPLMFindDataRef("model/controls/elec_bat2")                         ~= nil and
      XPLMFindDataRef("model/controls/light_beacon")                      ~= nil and
      XPLMFindDataRef("model/controls/light_turn")                        ~= nil and
      XPLMFindDataRef("model/controls/light_wing")                        ~= nil and
      XPLMFindDataRef("model/controls/light_logo")                        ~= nil and

      XPLMFindCommand("a320/Overhead/ElecBat2_button")                    ~= nil and
      XPLMFindCommand("a320/Overhead/LightBeacon_switch+")                ~= nil and
      XPLMFindCommand("a320/Overhead/LightTurn_switch+")                  ~= nil and
      XPLMFindCommand("a320/Overhead/LightWing_switch+")                  ~= nil and
      XPLMFindCommand("a320/Overhead/LightLogo_switch+")                  ~= nil and
      true
     ) then return true
  else
    return false
  end
end
