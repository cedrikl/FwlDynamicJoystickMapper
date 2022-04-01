--HotStart TBM9 Alpha Mappings
function ChampAlphaMapping_TBM9_hotstart()
---------------
--DC CONTROLS--
---------------
--Emergency Handle Bar
  set_button_assignment(afy.B_Bus1On,    "sim/none/none")
  set_button_assignment(afy.B_Bus1Off,   "sim/none/none")
  do_often([[
    EmHa_Pos = get("tbm900/switches/elec/emerg_handle_raw")
    SwBusPos = button(]]..afy.B_Bus1On..[[)

    if (SwBusPos and (EmHa_Pos ~= 0)) then
      command_once("tbm900/actuators/elec/emerg_handle_up")
    elseif (not(SwBusPos) and (EmHa_Pos == 0)) then
      command_once("tbm900/actuators/elec/emerg_handle_down")
    end
  ]])
--Source Switch
  set_button_assignment(afy.B_BattOn,    "sim/none/none")
  set_button_assignment(afy.B_BattOff,   "sim/none/none")
  do_often([[
  BattSrc_Pos = get("tbm900/switches/elec/source")
  GpuPwr = get("tbm900/objects/misc/gpu_rpm")
  SwInGate = (Sw_Pos == 0.0) or (Sw_Pos == 1.0) or (Sw_Pos == 2.0)
  SwBattPos = button(]]..afy.B_BattOn..[[)  
  
    if (GpuPwr > 0.8) then
      if (SwBattPos and (BattSrc_Pos ~= 2.0) and SwInGate) then
        command_once("tbm900/actuators/elec/source_up")
      elseif (not(SwBattPos) and (BattSrc_Pos ~= 0.0) and SwInGate) then
        command_once("tbm900/actuators/elec/source_down")
      end
    elseif (GpuPwr < 0.7) then      
      if (SwBattPos and (BattSrc_Pos < 1.0) and SwInGate) then
        command_once("tbm900/actuators/elec/source_up")
      elseif (SwBattPos and (BattSrc_Pos > 1.0) and SwInGate) then
        command_once("tbm900/actuators/elec/source_down")
      elseif (not(SwBattPos) and (BattSrc_Pos ~= 0.0) and SwInGate) then
        command_once("tbm900/actuators/elec/source_down")
      end
    end
  ]])
--Generator Switch
  set_button_assignment(afy.B_AltOn,    "sim/none/none")
  set_button_assignment(afy.B_AltOff,   "sim/none/none")
  do_often([[
    GenSw_Pos = get("tbm900/switches/elec/generator_raw")
    SwAltPos = button(]]..afy.B_AltOn..[[)

    if (SwAltPos and (GenSw_Pos ~= 1)) then
      command_once("tbm900/actuators/elec/gen_up")
    elseif (not(SwAltPos) and (GenSw_Pos == 1)) then
      command_once("tbm900/actuators/elec/gen_down")
    end
    ]])

---------------------
----EXTERIOR LIGHTS--
---------------------
--NAV light Button
  set_button_assignment(afy.B_NavOn,         "sim/none/none")
  set_button_assignment(afy.B_NavOff,        "sim/none/none")
  do_often([[
    NavPos =  get("tbm900/lights/nav", 0)
    SwNavPos = button(]]..afy.B_NavOn..[[)
    
    if (SwNavPos and (NavPos ~= 1)) then
      command_once("sim/lights/nav_lights_toggle")
    elseif (not(SwNavPos) and (NavPos == 1)) then
      command_once("sim/lights/nav_lights_toggle")
    end
  ]])
end

function ChampAlphaCheck_TBM9_hotstart()
  if(

     XPLMFindDataRef("tbm900/switches/elec/emerg_handle_raw")        ~= nil and
     XPLMFindDataRef("tbm900/switches/elec/source")                  ~= nil and
     XPLMFindDataRef("tbm900/switches/elec/generator_raw")           ~= nil and
     XPLMFindDataRef("tbm900/objects/misc/gpu_rpm")                  ~= nil and
     XPLMFindDataRef("tbm900/lights/nav")                            ~= nil and

     XPLMFindCommand("tbm900/actuators/elec/emerg_handle_up")        ~= nil and
     XPLMFindCommand("tbm900/actuators/elec/emerg_handle_down")      ~= nil and
     XPLMFindCommand("tbm900/actuators/elec/source_up")              ~= nil and
     XPLMFindCommand("tbm900/actuators/elec/source_down")            ~= nil and
     XPLMFindCommand("tbm900/actuators/elec/gen_up")                 ~= nil and
     XPLMFindCommand("tbm900/actuators/elec/gen_down")               ~= nil
    ) then return true
  else
    return false
  end
end
