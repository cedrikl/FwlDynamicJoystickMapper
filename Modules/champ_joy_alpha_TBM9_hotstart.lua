--HotStart TBM9 Alpha Mappings
function ChampAlphaMapping_TBM9_hotstart()
---------------
--DC CONTROLS--
---------------
--Emergency Handle Bar
  set_button_assignment(afy.B_AltOn,    "sim/none/none")
  set_button_assignment(afy.B_AltOff,   "sim/none/none")
  do_often([[
    EmHa_Pos = get("tbm900/switches/elec/emerg_handle_raw")
    SwAltPos = button(]]..afy.B_AltOn..[[)

    if (SwAltPos and (EmHa_Pos ~= 0)) then
      command_once("tbm900/actuators/elec/emerg_handle_up")
    elseif (not(SwAltPos) and (EmHa_Pos == 0)) then
      command_once("tbm900/actuators/elec/emerg_handle_down")
    end
  ]])
--Source Switch
  set_button_assignment(afy.B_BattOn,    "sim/none/none")
  set_button_assignment(afy.B_BattOff,   "sim/none/none")
  do_often([[
    BattSrc_Pos = get("tbm900/switches/elec/source_raw")
    SwBattPos = button(]]..afy.B_BattOn..[[)

    if (SwBattPos and (BattSrc_Pos ~= 1)) then
      command_once("tbm900/actuators/elec/source_up")
    elseif (not(SwBattPos) and (BattSrc_Pos == 1)) then
      command_once("tbm900/actuators/elec/source_down")
    end
  ]])
--Generator Switch
  set_button_assignment(afy.B_Bus1On,    "sim/none/none")
  set_button_assignment(afy.B_Bus1Off,   "sim/none/none")
  do_often([[
    GenSw_Pos = get("tbm900/switches/elec/generator_raw")
    SwBusPos = button(]]..afy.B_Bus1On..[[)

    if (SwBusPos and (GenSw_Pos ~= 1)) then
      command_once("tbm900/actuators/elec/gen_up")
    elseif (not(SwBusPos) and (GenSw_Pos == 1)) then
      command_once("tbm900/actuators/elec/gen_down")
    end
    ]])
----Generator 1 & 2 Switches
--  set_button_assignment(afy.B_Bus2On,    "sim/none/none")
--  set_button_assignment(afy.B_Bus2Off,   "sim/none/none")
--  do_often([[
--    Gen1_Pos = get("FJS/Q4XP/Manips/TwoSwitch_Anim", 3)
--    Gen2_Pos = get("FJS/Q4XP/Manips/TwoSwitch_Anim", 4)
--    SwBus2Pos = button(]]..afy.B_Bus2On..[[)
--
--    if (SwBus2Pos and (Gen1_Pos ~= 1)) then
--      command_once("FJS/Q4XP/Switches/DC_GEN_1_toggle")
--    elseif (not(SwBus2Pos) and (Gen1_Pos == 1)) then
--      command_once("FJS/Q4XP/Switches/DC_GEN_1_toggle")
--    end
--
--    if (SwBus2Pos and (Gen2_Pos ~= 1)) then
--      command_once("FJS/Q4XP/Switches/DC_GEN_2_toggle")
--    elseif (not(SwBus2Pos) and (Gen2_Pos == 1)) then
--      command_once("FJS/Q4XP/Switches/DC_GEN_2_toggle")
--    end
--    ]])
---------------------
----EXTERIOR LIGHTS--
---------------------
----BCN light Switch
--
----TurnOff L&R lights
-- 
----WING Inspection light Switch
--  set_button_assignment(afy.B_TaxiOn,         "sim/none/none")
--  set_button_assignment(afy.B_TaxiOff,        "sim/none/none")
--  do_often([[
--    WingInsPos =  get("FJS/Q4XP/Manips/TwoSwitch_Anim", 22)
--    SwTaxi = button(]]..afy.B_TaxiOn..[[)
--    
--    if (SwTaxi and (WingInsPos ~= 1)) then
--      command_once("FJS/Q4XP/Switches/WING_INSP_LIGHTS")
--    elseif (not(SwTaxi) and (WingInsPos == 1)) then
--      command_once("FJS/Q4XP/Switches/WING_INSP_LIGHTS")
--    end
--  ]])
--------NAV light Button
--  set_button_assignment(afy.B_NavOn,         "sim/none/none")
--  set_button_assignment(afy.B_NavOff,        "sim/none/none")
--  do_often([[
--    PosnPos =  get("FJS/Q4XP/Manips/TwoSwitch_Anim", 24)
--    SwNavPos = button(]]..afy.B_NavOn..[[)
--    
--    if (SwNavPos and (PosnPos ~= 1)) then
--      command_once("FJS/Q4XP/Switches/POSN_LIGHTS")
--    elseif (not(SwNavPos) and (PosnPos == 1)) then
--      command_once("FJS/Q4XP/Switches/POSN_LIGHTS")
--    end
--  ]])
--  ------LOGO light Button
--  set_button_assignment(afy.B_StrobeOn,         "sim/none/none")
--  set_button_assignment(afy.B_StrobeOff,        "sim/none/none")
--  do_often([[
--    Logo_Pos =  get("FJS/Q4XP/Manips/TwoSwitch_Anim", 25)
--    SwStrobePos = button(]]..afy.B_StrobeOn..[[)
--
--    if (SwStrobePos and (Logo_Pos ~= 1)) then
--      command_once("FJS/Q4XP/Switches/LOGO_LIGHTS")
--    elseif (not(SwStrobePos) and (Logo_Pos >= 1)) then
--      command_once("FJS/Q4XP/Switches/LOGO_LIGHTS")
--    end
--  ]])
end

function ChampAlphaCheck_TBM9_hotstart()
  if(
--     XPLMFindDataRef("FJS/Q4XP/Manips/TwoSwitch_Anim")               ~= nil and
--     XPLMFindDataRef("FJS/Q4XP/Manips/TwoSwitchLock_Anim")           ~= nil and
      XPLMFindDataRef("tbm900/switches/elec/emerg_handle_raw")       ~= nil and
      XPLMFindDataRef("tbm900/switches/elec/source_raw")             ~= nil and
      XPLMFindDataRef("tbm900/switches/elec/generator_raw")          ~= nil and
--     XPLMFindDataRef("anim/52/button")                               ~= nil and
--     XPLMFindDataRef("1-sim/lights/runwayL/switch")                  ~= nil and
--     XPLMFindDataRef("1-sim/lights/runwayR/switch")                  ~= nil and

     XPLMFindCommand("tbm900/actuators/elec/emerg_handle_up")        ~= nil and
     XPLMFindCommand("tbm900/actuators/elec/emerg_handle_down")      ~= nil and
     XPLMFindCommand("tbm900/actuators/elec/source_up")              ~= nil and
     XPLMFindCommand("tbm900/actuators/elec/source_down")            ~= nil and
     XPLMFindCommand("tbm900/actuators/elec/gen_up")                 ~= nil and
     XPLMFindCommand("tbm900/actuators/elec/gen_down")               ~= nil and
--     XPLMFindCommand("FJS/Q4XP/Switches/DC_GEN_1_toggle")            ~= nil and
--     XPLMFindCommand("FJS/Q4XP/Switches/DC_GEN_2_toggle")            ~= nil and
--     XPLMFindCommand("FJS/Q4XP/Switches/ACOL_up")                    ~= nil and
--     XPLMFindCommand("FJS/Q4XP/Switches/ACOL_dn")                    ~= nil and
--     XPLMFindCommand("FJS/Q4XP/Switches/WING_INSP_LIGHTS")           ~= nil and
--     XPLMFindCommand("FJS/Q4XP/Switches/POSN_LIGHTS")                ~= nil and
--     XPLMFindCommand("FJS/Q4XP/Switches/LOGO_LIGHTS")                ~= nil and
--     XPLMFindCommand("FJS/Q4XP/Switches/WING_INSP_LIGHTS")           ~= nil and
--     XPLMFindCommand("FJS/Q4XP/Switches/WING_INSP_LIGHTS")           ~= nil and
--     XPLMFindCommand("FJS/Q4XP/Switches/WING_INSP_LIGHTS")           ~= nil and
--     XPLMFindCommand("FJS/Q4XP/Switches/BATTERY_MASTER_toggle")      ~= nil and
     true
    ) then return true
  else
    return false
  end
end
