--FlyJSim Q4XP (DH8D) Alpha Mappings

function ChampAlphaMapping_DH8D_FlyJSim()
---------------
--DC CONTROLS--
---------------
--External power switch
  set_button_assignment(afy.B_AltOn,    "sim/none/none")
  set_button_assignment(afy.B_AltOff,   "sim/none/none")
  do_often([[
    ExtPw_Pos = get("FJS/Q4XP/Manips/TwoSwitch_Anim", 6)
    SwAltPos = button(]]..afy.B_AltOn..[[)

    if (SwAltPos and (ExtPw_Pos ~= 1)) then
      command_once("FJS/Q4XP/Switches/EXT_PWR_toggle")
    elseif (not(SwAltPos) and (ExtPw_Pos == 1)) then
      command_once("FJS/Q4XP/Switches/EXT_PWR_toggle")
    end
    ]])
--Battery Switches
  set_button_assignment(afy.B_BattOn,    "sim/none/none")
  set_button_assignment(afy.B_BattOff,   "sim/none/none")
  do_often([[
    BattMas_Pos = get("sim/cockpit2/electrical/battery_on", 3)
    BattMai_Pos = get("sim/cockpit2/electrical/battery_on", 0)
    BattAux_Pos = get("sim/cockpit2/electrical/battery_on", 1)
    BattStb_Pos = get("sim/cockpit2/electrical/battery_on", 2)
    SwBattPos = button(]]..afy.B_BattOn..[[)

    if (SwBattPos and (BattMas_Pos ~= 1)) then
      command_once("FJS/Q4XP/Switches/BATTERY_MASTER_toggle")
    elseif (not(SwBattPos) and (BattMas_Pos == 1)) then
      command_once("FJS/Q4XP/Switches/BATTERY_MASTER_toggle")
    end

    if (SwBattPos and (BattMai_Pos ~= 1)) then
      command_once("FJS/Q4XP/Switches/MAIN_BATT_toggle")
    elseif (not(SwBattPos) and (BattMai_Pos == 1)) then
      command_once("FJS/Q4XP/Switches/MAIN_BATT_toggle")
    end

    if (SwBattPos and (BattAux_Pos ~= 1)) then
      command_once("FJS/Q4XP/Switches/AUX_BATT_toggle")
    elseif (not(SwBattPos) and (BattAux_Pos == 1)) then
      command_once("FJS/Q4XP/Switches/AUX_BATT_toggle")
    end

    if (SwBattPos and (BattStb_Pos ~= 1)) then
      command_once("FJS/Q4XP/Switches/STBY_BATT_toggle")
    elseif (not(SwBattPos) and (BattStb_Pos == 1)) then
      command_once("FJS/Q4XP/Switches/STBY_BATT_toggle")
    end
    ]])
--Main Bus Tie Switch
  set_button_assignment(afy.B_Bus1On,    "sim/none/none")
  set_button_assignment(afy.B_Bus1Off,   "sim/none/none")
  do_often([[
    BusSw_Pos = get("FJS/Q4XP/Manips/TwoSwitchLock_Anim", 1)
    SwBusPos = button(]]..afy.B_Bus1On..[[)

    if (SwBusPos and (BusSw_Pos ~= 1)) then
      command_once("FJS/Q4XP/Switches/MAIN_BUSTIE_toggle")
    elseif (not(SwBusPos) and (BusSw_Pos == 1)) then
      command_once("FJS/Q4XP/Switches/MAIN_BUSTIE_toggle")
    end
    ]])
--Generator 1 & 2 Switches
  set_button_assignment(afy.B_Bus2On,    "sim/none/none")
  set_button_assignment(afy.B_Bus2Off,   "sim/none/none")
  do_often([[
    Gen1_Pos = get("FJS/Q4XP/Manips/TwoSwitch_Anim", 3)
    Gen2_Pos = get("FJS/Q4XP/Manips/TwoSwitch_Anim", 4)
    SwBus2Pos = button(]]..afy.B_Bus2On..[[)

    if (SwBus2Pos and (Gen1_Pos ~= 1)) then
      command_once("FJS/Q4XP/Switches/DC_GEN_1_toggle")
    elseif (not(SwBus2Pos) and (Gen1_Pos == 1)) then
      command_once("FJS/Q4XP/Switches/DC_GEN_1_toggle")
    end

    if (SwBus2Pos and (Gen2_Pos ~= 1)) then
      command_once("FJS/Q4XP/Switches/DC_GEN_2_toggle")
    elseif (not(SwBus2Pos) and (Gen2_Pos == 1)) then
      command_once("FJS/Q4XP/Switches/DC_GEN_2_toggle")
    end
    ]])
-------------------
--EXTERIOR LIGHTS--
-------------------
--BCN light Switch

--TurnOff L&R lights
 
--WING Inspection light Switch
  set_button_assignment(afy.B_TaxiOn,         "sim/none/none")
  set_button_assignment(afy.B_TaxiOff,        "sim/none/none")
  do_often([[
    WingInsPos =  get("FJS/Q4XP/Manips/TwoSwitch_Anim", 22)
    SwTaxi = button(]]..afy.B_TaxiOn..[[)
    
    if (SwTaxi and (WingInsPos ~= 1)) then
      command_once("FJS/Q4XP/Switches/WING_INSP_LIGHTS")
    elseif (not(SwTaxi) and (WingInsPos == 1)) then
      command_once("FJS/Q4XP/Switches/WING_INSP_LIGHTS")
    end
  ]])
------NAV light Button
  set_button_assignment(afy.B_NavOn,         "sim/none/none")
  set_button_assignment(afy.B_NavOff,        "sim/none/none")
  do_often([[
    PosnPos =  get("FJS/Q4XP/Manips/TwoSwitch_Anim", 24)
    SwNavPos = button(]]..afy.B_NavOn..[[)
    
    if (SwNavPos and (PosnPos ~= 1)) then
      command_once("FJS/Q4XP/Switches/POSN_LIGHTS")
    elseif (not(SwNavPos) and (PosnPos == 1)) then
      command_once("FJS/Q4XP/Switches/POSN_LIGHTS")
    end
  ]])
  ------LOGO light Button
  set_button_assignment(afy.B_StrobeOn,         "sim/none/none")
  set_button_assignment(afy.B_StrobeOff,        "sim/none/none")
  do_often([[
    Logo_Pos =  get("FJS/Q4XP/Manips/TwoSwitch_Anim", 25)
    SwStrobePos = button(]]..afy.B_StrobeOn..[[)

    if (SwStrobePos and (Logo_Pos ~= 1)) then
      command_once("FJS/Q4XP/Switches/LOGO_LIGHTS")
    elseif (not(SwStrobePos) and (Logo_Pos >= 1)) then
      command_once("FJS/Q4XP/Switches/LOGO_LIGHTS")
    end
  ]])
end

function ChampAlphaCheck_DH8D_FlyJSim()
  if(
     XPLMFindDataRef("FJS/Q4XP/Manips/TwoSwitch_Anim")               ~= nil and
     XPLMFindDataRef("FJS/Q4XP/Manips/TwoSwitchLock_Anim")           ~= nil and

     XPLMFindCommand("FJS/Q4XP/Switches/EXT_PWR_toggle")             ~= nil and
     XPLMFindCommand("FJS/Q4XP/Switches/BATTERY_MASTER_toggle")      ~= nil and
     XPLMFindCommand("FJS/Q4XP/Switches/MAIN_BATT_toggle")           ~= nil and
     XPLMFindCommand("FJS/Q4XP/Switches/AUX_BATT_toggle")            ~= nil and
     XPLMFindCommand("FJS/Q4XP/Switches/STBY_BATT_toggle")           ~= nil and
     XPLMFindCommand("FJS/Q4XP/Switches/MAIN_BUSTIE_toggle")         ~= nil and
     XPLMFindCommand("FJS/Q4XP/Switches/DC_GEN_1_toggle")            ~= nil and
     XPLMFindCommand("FJS/Q4XP/Switches/DC_GEN_2_toggle")            ~= nil and
     XPLMFindCommand("FJS/Q4XP/Switches/WING_INSP_LIGHTS")           ~= nil and
     XPLMFindCommand("FJS/Q4XP/Switches/POSN_LIGHTS")                ~= nil and
     XPLMFindCommand("FJS/Q4XP/Switches/LOGO_LIGHTS")                ~= nil
    ) then return true
  else
    return false
  end
end
