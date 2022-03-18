--SSG EJET 195 Alpha Flight Controls
function ChampAlphaMapping_E195_SSG()
----BATT Switches 1 & 2
  set_button_assignment(afy.B_BattOn,    "sim/none/none")
  set_button_assignment(afy.B_BattOff,   "sim/none/none")
  do_often([[
    Batt1_Pos = get("SSG/EJET/ELEC/batt1_sw")
    Batt2_Pos = get("SSG/EJET/ELEC/batt2_sw")
    SwBatPos = button(]]..afy.B_BattOn..[[)

    if (SwBatPos and (Batt1_Pos ~= 1)) then
      set("SSG/EJET/ELEC/batt1_sw", 1)
    elseif (not(SwBatPos) and (Batt1_Pos == 1)) then
      set("SSG/EJET/ELEC/batt1_sw", 0)
    end

    if (SwBatPos and (Batt2_Pos ~= 1)) then
      set("SSG/EJET/ELEC/batt2_sw", 1)
    elseif (not(SwBatPos) and (Batt2_Pos == 1)) then
      set("SSG/EJET/ELEC/batt2_sw", 0)
    end
    ]])
----Bus Switch
  set_button_assignment(afy.B_Bus1On,    "sim/none/none")
  set_button_assignment(afy.B_Bus1Off,   "sim/none/none")
  do_often([[
    Bus1_Pos = get("SSG/EJET/ELEC/dc_bus_sw")
    SwBus1Pos = button(]]..afy.B_Bus1On..[[)

    if (SwBus1Pos and (Bus1_Pos ~= 1)) then
      set("SSG/EJET/ELEC/dc_bus_sw", 1)
    elseif (not(SwBus1Pos) and (Bus1_Pos == 1)) then
      set("SSG/EJET/ELEC/dc_bus_sw", 0)
    end
    ]])
----BCN light Button
  set_button_assignment(afy.B_BcnOn,    "sim/none/none")
  set_button_assignment(afy.B_BcnOff,   "sim/none/none")
  do_often([[
    BCN_Pos =  get("SSG/EJET/LIGHTS/bcn_lights_sw")
    SwBcnPos = button(]]..afy.B_BcnOn..[[)
    
    if (SwBcnPos and (BCN_Pos ~= 1)) then
      set("SSG/EJET/LIGHTS/bcn_lights_sw", 1)
    elseif (not(SwBcnPos) and (BCN_Pos == 1)) then
      set("SSG/EJET/LIGHTS/bcn_lights_sw", 0)
    end
  ]])
----Taxi side lights
  set_button_assignment(afy.B_LandOn,         "sim/none/none")
  set_button_assignment(afy.B_LandOff,        "sim/none/none")
  do_often([[
    TaxiSidePos =  get("SSG/EJET/LIGHTS/taxi_side_lights_sw")
    SwLandPos = button(]]..afy.B_LandOn..[[)

    if ((SwLandPos) and (TaxiSidePos ~= 1)) then
      set("SSG/EJET/LIGHTS/taxi_side_lights_sw", 1)
    elseif (not(SwLandPos) and (TaxiSidePos >= 1)) then
      set("SSG/EJET/LIGHTS/taxi_side_lights_sw", 0)
    end
--  ]])
----WING light button
  set_button_assignment(afy.B_TaxiOn,         "sim/none/none")
  set_button_assignment(afy.B_TaxiOff,        "sim/none/none")
  do_often([[
    InsPos =  get("SSG/EJET/LIGHTS/insp_lights_sw")
    SwTaxiPos = button(]]..afy.B_TaxiOn..[[)
    
    if (SwTaxiPos and (InsPos ~= 1)) then
      set("SSG/EJET/LIGHTS/insp_lights_sw", 1)
    elseif (not(SwTaxiPos) and (InsPos >= 1)) then
      set("SSG/EJET/LIGHTS/insp_lights_sw", 0)
    end
  ]])
----NAV light Button
  set_button_assignment(afy.B_NavOn,         "sim/none/none")
  set_button_assignment(afy.B_NavOff,        "sim/none/none")
  do_often([[
    NAV_Pos =  get("SSG/EJET/LIGHTS/nav_lights_sw")
    SwNavPos = button(]]..afy.B_NavOn..[[)
    
    if (SwNavPos and (NAV_Pos ~= 1)) then
      set("SSG/EJET/LIGHTS/nav_lights_sw", 1)
    elseif (not(SwNavPos) and (NAV_Pos >= 1)) then
      set("SSG/EJET/LIGHTS/nav_lights_sw", 0)
    end
    ]])
    ----LOGO light Button
  set_button_assignment(afy.B_StrobeOn,         "sim/none/none")
  set_button_assignment(afy.B_StrobeOff,        "sim/none/none")
  do_often([[
    STROBE_Pos =  get("SSG/EJET/LIGHTS/logo_lights_sw")
    SwStrobePos = button(]]..afy.B_StrobeOn..[[)
    
    if (SwStrobePos and (STROBE_Pos ~= 1)) then
      set("SSG/EJET/LIGHTS/logo_lights_sw", 1)
    elseif (not(SwStrobePos) and (STROBE_Pos >= 1)) then
      set("SSG/EJET/LIGHTS/logo_lights_sw", 0)
    end
  ]])
end

function ChampAlphaCheck_E195_SSG()
  if (--Switches
      XPLMFindDataRef("SSG/EJET/ELEC/batt1_sw")                 ~= nil and
      XPLMFindDataRef("SSG/EJET/ELEC/batt2_sw")                 ~= nil and
      XPLMFindDataRef("SSG/EJET/ELEC/dc_bus_sw")                ~= nil and
      XPLMFindDataRef("SSG/EJET/LIGHTS/bcn_lights_sw")          ~= nil and
      XPLMFindDataRef("SSG/EJET/LIGHTS/taxi_side_lights_sw")    ~= nil and
      XPLMFindDataRef("SSG/EJET/LIGHTS/insp_lights_sw")         ~= nil and
      XPLMFindDataRef("SSG/EJET/LIGHTS/nav_lights_sw")          ~= nil and
      XPLMFindDataRef("SSG/EJET/LIGHTS/logo_lights_sw")         ~= nil
     ) then return true
  else
    return false
  end
end
