--JARDESIGN A330 APLHA MAPPINGS
function ChampAlphaMapping_A330_JD()
  --BATT switches
  set_button_assignment(afy.B_BattOn,    "sim/none/none")
  set_button_assignment(afy.B_BattOff,   "sim/none/none")
  do_often([[
    Batt1_Pos =  get("sim/custom/xap/elec/bat1_on")
    Batt2_Pos =  get("sim/custom/xap/elec/bat2_on")
    Batt3_Pos =  get("sim/custom/xap/elec/bat3_on")
    SwBattPos = button(]]..afy.B_BattOn..[[)
    
    if (SwBattPos and (Batt1_Pos ~= 1)) then
      set("sim/custom/xap/elec/bat1_on", 1)
    elseif (not(SwBattPos) and (Batt1_Pos == 1)) then
      set("sim/custom/xap/elec/bat1_on", 0)
    end
    
    if (SwBattPos and (Batt2_Pos ~= 1)) then
      set("sim/custom/xap/elec/bat2_on", 1)
    elseif (not(SwBattPos) and (Batt2_Pos == 1)) then
      set("sim/custom/xap/elec/bat2_on", 0)
    end
    
    if (SwBattPos and (Batt3_Pos ~= 1)) then
      set("sim/custom/xap/elec/bat3_on", 1)
    elseif (not(SwBattPos) and (Batt3_Pos == 1)) then
      set("sim/custom/xap/elec/bat3_on", 0)
    end    
  ]])
  --BCN light Button
  set_button_assignment(afy.B_BcnOn,    "sim/none/none")
  set_button_assignment(afy.B_BcnOff,   "sim/none/none")
  do_often([[
    BCN_Pos =  get("sim/custom/xap/extlight/beacon_sw")
    SwBcnPos = button(]]..afy.B_BcnOn..[[)
    
    if (SwBcnPos and (BCN_Pos ~= 1)) then
      set("sim/custom/xap/extlight/beacon_sw", 1)
    elseif (not(SwBcnPos) and (BCN_Pos == 1)) then
      set("sim/custom/xap/extlight/beacon_sw", 0)
    end
  ]])  
  --Runway TurnOff lights
  set_button_assignment(afy.B_LandOn,         "sim/none/none")
  set_button_assignment(afy.B_LandOff,        "sim/none/none")
  do_often([[
    TurnoffPos =  get("sim/custom/xap/extlight/rwyturn_sw")
    SwLandPos = button(]]..afy.B_LandOn..[[)

    if (SwLandPos and (TurnoffPos ~= 1)) then
      set("sim/custom/xap/extlight/rwyturn_sw", 1)
    elseif (not(SwLandPos) and (TurnoffPos == 1)) then
      set("sim/custom/xap/extlight/rwyturn_sw", 0)
    end
  ]])
  --WING light button
  set_button_assignment(afy.B_TaxiOn,         "sim/none/none")
  set_button_assignment(afy.B_TaxiOff,        "sim/none/none")
  do_often([[
    WingPos =  get("sim/custom/xap/extlight/wing_sw")
    SwTaxiPos = button(]]..afy.B_TaxiOn..[[)
    
    if (SwTaxiPos and (WingPos ~= 1)) then
      set("sim/custom/xap/extlight/wing_sw", 1)
    elseif (not(SwTaxiPos) and (WingPos == 1)) then
      set("sim/custom/xap/extlight/wing_sw", 0)
    end
  ]])
  --Nav & Logo switches
  set_button_assignment(afy.B_NavOn,       "sim/none/none")
  set_button_assignment(afy.B_NavOff,      "sim/none/none")
  set_button_assignment(afy.B_StrobeOn,    "sim/none/none")
  set_button_assignment(afy.B_StrobeOff,   "sim/none/none")
  do_often([[
    Logo_Pos = get("sim/custom/xap/extlight/navlogo_sw")
    SwNavPos = button(]]..afy.B_NavOn..[[)
    SwStrobePos = button(]]..afy.B_StrobeOn..[[)

    if (SwStrobePos and (Logo_Pos ~= 2.0)) then
      set("sim/custom/xap/extlight/navlogo_sw", 2)
    elseif (SwNavPos and not(SwStrobePos) and (Logo_Pos ~= 1.0)) then
      set("sim/custom/xap/extlight/navlogo_sw", 1)
    elseif (not(SwNavPos) and not (SwStrobePos) and (Logo_Pos ~= 0)) then
      set("sim/custom/xap/extlight/navlogo_sw", 0)
    end
  ]])
  
  set_axis_assignment(btq.axis1,      "speedbrakes", "reverse")
end

function ChampAlphaCheck_A330_JD()
  if (--Switches
      XPLMFindDataRef("sim/custom/xap/extlight/beacon_sw")          ~= nil and
      XPLMFindDataRef("sim/custom/xap/extlight/rwyturn_sw")         ~= nil and
      XPLMFindDataRef("sim/custom/xap/extlight/wing_sw")            ~= nil and
      XPLMFindDataRef("sim/custom/xap/extlight/navlogo_sw")         ~= nil and
      XPLMFindDataRef("sim/custom/xap/elec/bat1_on")                ~= nil and
      XPLMFindDataRef("sim/custom/xap/elec/bat2_on")                ~= nil and
      XPLMFindDataRef("sim/custom/xap/elec/bat3_on")                ~= nil
     ) then return true
  else
    return false
  end
end
