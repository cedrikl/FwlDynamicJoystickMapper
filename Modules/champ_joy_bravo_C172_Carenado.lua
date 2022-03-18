--Carenado bravo Cessna C172

function ChampBravoMapping_C172_Carenado()
  --set_button_assignment(btq.sw5_up, "sim/none/none")
  --set_button_assignment(btq.sw5_dn, "sim/none/none")
  --set_button_assignment(btq.sw6_up, "sim/none/none")
  --set_button_assignment(btq.sw6_dn, "sim/none/none")
  --set_button_assignment(btq.sw7_up, "sim/none/none")
  --set_button_assignment(btq.sw7_dn, "sim/none/none")
  --
  --set_button_assignment(afy.B_AltOn,     "sim/electrical/generator_1_on")
  --set_button_assignment(afy.B_AltOff,    "sim/electrical/generator_1_off")
  --set_button_assignment(afy.B_BattOn,    "sim/electrical/battery_1_on")
  --set_button_assignment(afy.B_BattOff,   "sim/electrical/battery_1_off")
  --set_button_assignment(afy.B_Bus1On,    "sim/systems/avionics_on")
  --set_button_assignment(afy.B_Bus1Off,   "sim/systems/avionics_off")
  --set_button_assignment(afy.B_Bus2On,    "sim/electrical/cross_tie_on")
  --set_button_assignment(afy.B_Bus2Off,   "sim/electrical/cross_tie_off")
  --set_button_assignment(afy.B_BcnOn,     "sim/lights/beacon_lights_on")
  --set_button_assignment(afy.B_BcnOff,    "sim/lights/beacon_lights_off")
  --set_button_assignment(afy.B_LandOn,    "sim/lights/landing_lights_on")
  --set_button_assignment(afy.B_LandOff,   "sim/lights/landing_lights_off")
  --set_button_assignment(afy.B_TaxiOn,    "sim/lights/taxi_lights_on")
  --set_button_assignment(afy.B_TaxiOff,   "sim/lights/taxi_lights_off")
  --set_button_assignment(afy.B_NavOn,     "sim/lights/nav_lights_on")
  --set_button_assignment(afy.B_NavOff,    "sim/lights/nav_lights_off")
  --set_button_assignment(afy.B_StrobeOn,  "sim/lights/strobe_lights_on")
  --set_button_assignment(afy.B_StrobeOff, "sim/lights/strobe_lights_off")
  --
  --set_button_assignment(afy.S_Off,       "sim/magnetos/magnetos_off")
  --set_button_assignment(afy.S_Right,     "sim/magnetos/magnetos_right_1")
  --set_button_assignment(afy.S_Left,      "sim/magnetos/magnetos_left_1")
  --set_button_assignment(afy.S_Both,      "sim/magnetos/magnetos_both_1")
  --set_button_assignment(afy.S_Start,     "sim/starters/engage_starter_1")
end


function ChampAlphaBravoLed_C172_Laminar()

end

function ChampAlphaBravoCheck_C172_Laminar()
  if (--Switches
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
