--Carenado Alpha Cessna C172

function ChampAlphaMapping_C172_Carenado()
       set_button_assignment(afy.B_AltOn,     "sim/electrical/generator_1_on")
       set_button_assignment(afy.B_AltOff,    "sim/electrical/generator_1_off")
       set_button_assignment(afy.B_BattOn,    "sim/electrical/battery_1_on")
       set_button_assignment(afy.B_BattOff,   "sim/electrical/battery_1_off")

       set_button_assignment(afy.B_Bus1On,    "sim/none/none")
       set_button_assignment(afy.B_Bus1Off,   "sim/none/none")
       do_often([[
         SwBus1Pos = button(]]..afy.B_Bus1On..[[)
         
         if (SwBus1Pos) then
           set("thranda/electrical/BusSw1", 1)
         elseif (not(SwBus1Pos)) then
           set("thranda/electrical/BusSw1", 0)
         end
       ]])
       set_button_assignment(afy.B_Bus2On,    "sim/none/none")
       set_button_assignment(afy.B_Bus2Off,   "sim/none/none")
       do_often([[
         SwBus2Pos = button(]]..afy.B_Bus2On..[[)
         
         if (SwBus2Pos) then
           set("thranda/electrical/BusSw2", 1)
         elseif (not(SwBus2Pos)) then
           set("thranda/electrical/BusSw2", 0)
         end
       ]])
       --set_button_assignment(afy.B_Bus1On,    "sim/systems/avionics_on")
       --set_button_assignment(afy.B_Bus1Off,   "sim/systems/avionics_off")
       --set_button_assignment(afy.B_Bus2On,    "sim/electrical/cross_tie_on")
       --set_button_assignment(afy.B_Bus2Off,   "sim/electrical/cross_tie_off")
       
       set_button_assignment(afy.B_BcnOn,     "sim/lights/beacon_lights_on")
       set_button_assignment(afy.B_BcnOff,    "sim/lights/beacon_lights_off")
       --Fuel pumps
       set_button_assignment(afy.B_LandOn,    "sim/fuel/fuel_pumps_on")
       set_button_assignment(afy.B_LandOff,   "sim/fuel/fuel_pumps_off")
       --Pitot heat
       set_button_assignment(afy.B_TaxiOn,    "sim/ice/pitot_heat0_on")
       set_button_assignment(afy.B_TaxiOff,   "sim/ice/pitot_heat0_off")
       
       set_button_assignment(afy.B_NavOn,     "sim/lights/nav_lights_on")
       set_button_assignment(afy.B_NavOff,    "sim/lights/nav_lights_off")
       
       --set_button_assignment(afy.B_StrobeOn,  "sim/electrical/inverter_1_on")
       --set_button_assignment(afy.B_StrobeOff, "sim/electrical/inverter_1_off")
       
       set_button_assignment(afy.S_Off,       "sim/magnetos/magnetos_off")
       set_button_assignment(afy.S_Right,     "sim/magnetos/magnetos_right_1")
       set_button_assignment(afy.S_Left,      "sim/magnetos/magnetos_left_1")
       set_button_assignment(afy.S_Both,      "sim/magnetos/magnetos_both_1")
       set_button_assignment(afy.S_Start,     "sim/starters/engage_starter_1")
end


function ChampAlphaLed_C172_Carenado()

end

function ChampAlphaCheck_C172_Carenado()
  if (--Switches
      XPLMFindDataRef("thranda/electrical/BusSw1")  ~= nil and
      --XPLMFindCommand("sim/electrical/generator_1_on") ~= nil and
      --XPLMFindCommand("sim/electrical/generator_1_off" ~= nil and
      --XPLMFindCommand("sim/electrical/battery_1_on")   ~= nil and
      --XPLMFindCommand("sim/electrical/battery_1_off")  ~= nil and
      --XPLMFindCommand("sim/systems/avionics_on")       ~= nil and
      --XPLMFindCommand("sim/systems/avionics_off")      ~= nil and
      --XPLMFindCommand("sim/electrical/cross_tie_on")   ~= nil and
      --XPLMFindCommand("sim/electrical/cross_tie_off")  ~= nil and
      --XPLMFindCommand("sim/lights/beacon_lights_on")   ~= nil and
      --XPLMFindCommand("sim/lights/beacon_lights_off")  ~= nil and
      --XPLMFindCommand("sim/lights/landing_lights_on")  ~= nil and
      --XPLMFindCommand("sim/lights/landing_lights_off") ~= nil and
      --XPLMFindCommand("sim/lights/taxi_lights_on")     ~= nil and
      --XPLMFindCommand("sim/lights/taxi_lights_off")    ~= nil and
      --XPLMFindCommand("sim/lights/nav_lights_on")      ~= nil and
      --XPLMFindCommand("sim/lights/nav_lights_off")     ~= nil and
      --XPLMFindCommand("sim/lights/strobe_lights_on")   ~= nil and
      --XPLMFindCommand("sim/lights/strobe_lights_off")  ~= nil and
      --XPLMFindCommand("sim/magnetos/magnetos_off")     ~= nil and
      --XPLMFindCommand("sim/magnetos/magnetos_right_1") ~= nil and
      --XPLMFindCommand("sim/magnetos/magnetos_left_1")  ~= nil and
      --XPLMFindCommand("sim/magnetos/magnetos_both_1")  ~= nil and
      --XPLMFindCommand("sim/starters/engage_starter_1") ~= nil
      true
     ) then return true
  else
    return false
  end
end
