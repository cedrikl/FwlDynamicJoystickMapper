-- Toliss A321 Neo Alpha Mappings

function ChampAlphaMapping_A321_toliss()
--Batt switches
  set_button_assignment(afy.B_BattOn,    "sim/none/none")
  set_button_assignment(afy.B_BattOff,   "sim/none/none")
  do_often([[
    Batt1_Pos = get("sim/cockpit2/electrical/battery_on", 0)
    Batt2_Pos = get("sim/cockpit2/electrical/battery_on", 1)
    SwBattPos = button(]]..afy.B_BattOn..[[)

    if (SwBattPos and (Batt1_Pos ~= 1)) then
      command_once("toliss_airbus/eleccommands/Bat1On")
    elseif (not(SwBattPos) and (Batt1_Pos ~= 0)) then
      command_once("toliss_airbus/eleccommands/Bat1Off")
    end

    if (SwBattPos and (Batt2_Pos ~= 1)) then
      command_once("toliss_airbus/eleccommands/Bat2On")
    elseif (not(SwBattPos) and (Batt2_Pos ~= 0)) then
      command_once("toliss_airbus/eleccommands/Bat2Off")
    end
  ]])
--Beacon switch
  set_button_assignment(afy.B_BcnOn,    "sim/none/none")
  set_button_assignment(afy.B_BcnOff,   "sim/none/none")
  do_often([[
    Bcn_Pos = get("ckpt/oh/beaconLight/anim")
    SwBcnPos = button(]]..afy.B_BcnOn..[[)

    if (SwBcnPos and (Bcn_Pos ~= 1)) then
      command_once("toliss_airbus/lightcommands/BeaconOn")
    elseif (not(SwBcnPos) and (Bcn_Pos == 1)) then
      command_once("toliss_airbus/lightcommands/BeaconOff")
    end
  ]])
--TurnOff switch
  set_button_assignment(afy.B_LandOn,    "sim/none/none")
  set_button_assignment(afy.B_LandOff,   "sim/none/none")
  do_often([[
    Turn_Pos = get("ckpt/oh/rwyTurnOff/anim")
    SwLandPos = button(]]..afy.B_LandOn..[[)

    if (SwLandPos and (Turn_Pos ~= 1)) then
      command_once("toliss_airbus/lightcommands/TurnoffLightOn")
    elseif (not(SwLandPos) and (Turn_Pos == 1)) then
      command_once("toliss_airbus/lightcommands/TurnoffLightOff")
    end
  ]])
--Wing Lights switch
  set_button_assignment(afy.B_TaxiOn,    "sim/none/none")
  set_button_assignment(afy.B_TaxiOff,   "sim/none/none")
  do_often([[
    Wing_Pos = get("ckpt/oh/wingLight/anim")
    SwTaxiPos = button(]]..afy.B_TaxiOn..[[)

    if (SwTaxiPos and (Wing_Pos ~= 1)) then
      command_once("toliss_airbus/lightcommands/WingLightOn")
    elseif (not(SwTaxiPos) and (Wing_Pos == 1)) then
      command_once("toliss_airbus/lightcommands/WingLightOff")
    end
  ]])
  --Nav and Logo Light switch
  set_button_assignment(afy.B_NavOn,       "sim/none/none")
  set_button_assignment(afy.B_NavOff,      "sim/none/none")
  set_button_assignment(afy.B_StrobeOn,    "sim/none/none")
  set_button_assignment(afy.B_StrobeOff,   "sim/none/none")
  do_often([[
    Logo_Pos = get("ckpt/oh/navLight/anim")
    LinGate = (L_Pos == 0.0) or (L_Pos == 1.0) or (L_Pos == 2.0)
    SwNavPos = button(]]..afy.B_NavOn..[[)
    SwStrobePos = button(]]..afy.B_StrobeOn..[[)

    if (SwStrobePos and (Logo_Pos < 2.0) and LinGate) then
      command_once("toliss_airbus/lightcommands/NavLightUp")
    elseif (SwNavPos and not(SwStrobePos) and (Logo_Pos > 1.0) and LinGate) then
      command_once("toliss_airbus/lightcommands/NavLightDown")
    elseif (SwNavPos and not(SwStrobePos) and (Logo_Pos < 1.0) and LinGate) then
      command_once("toliss_airbus/lightcommands/NavLightUp")
    elseif (not(SwNavPos) and not (SwStrobePos) and (Logo_Pos > 0)and LinGate) then
      command_once("toliss_airbus/lightcommands/NavLightDown")
    end
  ]])
end

function ChampAlphaCheck_A321_toliss()
  if (XPLMFindDataRef("ckpt/oh/beaconLight/anim")                         ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/BeaconOn")             ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/BeaconOff")            ~= nil and
      XPLMFindCommand("toliss_airbus/eleccommands/Bat1On")                ~= nil and
      XPLMFindCommand("toliss_airbus/eleccommands/Bat1Off")               ~= nil and
      XPLMFindCommand("toliss_airbus/eleccommands/Bat2On")                ~= nil and
      XPLMFindCommand("toliss_airbus/eleccommands/Bat2Off")               ~= nil and
      XPLMFindDataRef("ckpt/oh/rwyTurnOff/anim")                          ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/TurnoffLightOn")       ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/TurnoffLightOff")      ~= nil and
      XPLMFindDataRef("ckpt/oh/wingLight/anim")                           ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/WingLightOn")          ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/WingLightOff")         ~= nil and
      XPLMFindDataRef("ckpt/oh/navLight/anim")                            ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/NavLightUp")           ~= nil and
      XPLMFindCommand("toliss_airbus/lightcommands/NavLightDown")         ~= nil
     ) then return true
  else
    return false
  end
end
