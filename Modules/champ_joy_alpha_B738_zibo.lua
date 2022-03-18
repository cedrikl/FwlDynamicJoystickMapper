--Zibo 737-800

function ChampAlphaMapping_B738_zibo()

--Batt Switch
  set_button_assignment(afy.B_BattOn,         "sim/none/none")
  set_button_assignment(afy.B_BattOff,        "sim/none/none")
  do_often ([[
    Batt_Pos =  get("laminar/B738/electric/battery_pos")
    SwSBattPos = button(]]..afy.B_BattOn..[[)
    
    if (SwSBattPos and (Batt_Pos < 1)) then
      command_once("laminar/B738/button_switch_cover02")
      command_once("laminar/B738/switch/battery_dn")
    elseif (not(SwSBattPos) and (Batt_Pos > 0)) then
      command_once("laminar/B738/button_switch_cover02")
      command_once("laminar/B738/switch/battery_up")
    end
  ]])

--LIGHT CONTROLS
  --BCN Button
  set_button_assignment(afy.B_BcnOn,         "sim/none/none")
  set_button_assignment(afy.B_BcnOff,        "sim/none/none")
  do_often([[
    Bcn_Pos =  get("sim/cockpit/electrical/beacon_lights_on")
    SwSBcnPos = button(]]..afy.B_BcnOn..[[)

    if (SwSBcnPos and (Bcn_Pos < 1)) then
      command_once("sim/lights/beacon_lights_toggle")
    elseif (not(SwSBcnPos) and (Bcn_Pos > 0)) then
      command_once("sim/lights/beacon_lights_toggle")
    end
  ]])
  --Runway Turnoff
  set_button_assignment(afy.B_LandOn,         "sim/none/none")
  set_button_assignment(afy.B_LandOff,        "sim/none/none")
  do_often([[
    Land_Pos =   get("laminar/B738/toggle_switch/rwy_light_left")
    SwSLandPos  = button(]]..afy.B_LandOn..[[)

    if (SwSLandPos and (Land_Pos < 1)) then
      command_once("laminar/B738/switch/rwy_light_left_on")
    elseif (not(SwSLandPos) and (Land_Pos > 0)) then
      command_once("laminar/B738/switch/rwy_light_left_off")
    end
  ]])
  do_often([[
    Land_Pos =  get("laminar/B738/toggle_switch/rwy_light_right")
    SwSLandPos = button(]]..afy.B_LandOn..[[)
    
    if (SwSLandPos and (Land_Pos < 1)) then
      command_once("laminar/B738/switch/rwy_light_right_on")
    elseif (not(SwSLandPos) and (Land_Pos > 0)) then
      command_once("laminar/B738/switch/rwy_light_right_off")
    end
  ]])
  --Wing Lights
  set_button_assignment(afy.B_TaxiOn,         "laminar/B738/switch/wing_light_on")
  set_button_assignment(afy.B_TaxiOff,        "laminar/B738/switch/wing_light_off")
  --Wheel Lights
  set_button_assignment(afy.B_NavOff,          "laminar/B738/switch/wheel_light_on")
  set_button_assignment(afy.B_NavOn,         "laminar/B738/switch/wheel_light_off")
  --LOGO light Button
  set_button_assignment(afy.B_StrobeOn,       "laminar/B738/switch/logo_light_on")
  set_button_assignment(afy.B_StrobeOff,      "laminar/B738/switch/logo_light_off")

end

function ChampAlphaCheck_B738_zibo()
  if (--AP Panel
      XPLMFindDataRef("sim/cockpit/electrical/beacon_lights_on")                ~= nil and
      XPLMFindDataRef("laminar/B738/toggle_switch/rwy_light_left")              ~= nil and
      XPLMFindDataRef("laminar/B738/toggle_switch/rwy_light_right")             ~= nil and
      XPLMFindDataRef("laminar/B738/electric/battery_pos")                      ~= nil and
      XPLMFindDataRef("laminar/B738/button_switch/cover_position")              ~= nil and
      
      
      XPLMFindCommand("laminar/B738/switch/battery_up")                         ~= nil and
      XPLMFindCommand("laminar/B738/switch/battery_dn")                         ~= nil and
      XPLMFindCommand("laminar/B738/button_switch_cover02")                     ~= nil and
      XPLMFindCommand("sim/lights/beacon_lights_toggle")                        ~= nil and
      XPLMFindCommand("laminar/B738/switch/rwy_light_left_on")                  ~= nil and
      XPLMFindCommand("laminar/B738/switch/rwy_light_left_off")                 ~= nil and
      XPLMFindCommand("laminar/B738/switch/rwy_light_right_on")                 ~= nil and
      XPLMFindCommand("laminar/B738/switch/rwy_light_right_off")                ~= nil and
      XPLMFindCommand("laminar/B738/switch/wing_light_on")                      ~= nil and
      XPLMFindCommand("laminar/B738/switch/wing_light_off")                     ~= nil and
      XPLMFindCommand("laminar/B738/switch/wheel_light_on")                     ~= nil and
      XPLMFindCommand("laminar/B738/switch/wheel_light_off")                    ~= nil and
      XPLMFindCommand("laminar/B738/switch/logo_light_on")                      ~= nil and
      XPLMFindCommand("laminar/B738/switch/logo_light_off")                     ~= nil
     ) then return true
  else
    return false
  end
end

