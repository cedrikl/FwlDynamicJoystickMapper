--Flight Factor B767 Pro Extended Alpha Mappings

function ChampAlphaMapping_B767_FF()
--Battery Cover & Button
  set_button_assignment(afy.B_BattOn,    "sim/none/none")
  set_button_assignment(afy.B_BattOff,   "sim/none/none")
  do_often([[
    Batt2_Pos = get("anim/14/button")
    SwBattPos = button(]]..afy.B_BattOn..[[)

    if (SwBattPos and (Batt2_Pos ~= 1)) then
      set("anim/14/button", 1)
    elseif (not(SwBattPos) and (Batt2_Pos == 1)) then
      set("anim/14/button", 0)
    end
    ]])
----BCN light Button
  set_button_assignment(afy.B_BcnOn,    "sim/none/none")
  set_button_assignment(afy.B_BcnOff,   "sim/none/none")
  do_often([[
    BCN_Pos =  get("anim/44/button")
    SwBcnPos = button(]]..afy.B_BcnOn..[[)
    
    if (SwBcnPos and (BCN_Pos ~= 1)) then
      set("anim/44/button", 1)
    elseif (not(SwBcnPos) and (BCN_Pos == 1)) then
      set("anim/44/button", 0)
    end
  ]])
----TurnOff L&R lights
  set_button_assignment(afy.B_LandOn,         "sim/none/none")
  set_button_assignment(afy.B_LandOff,        "sim/none/none")
  do_often([[
      TurnLPos = get("1-sim/lights/runwayL/switch")
      TurnRPos = get("1-sim/lights/runwayR/switch")
      SwTurnPos = button(]]..afy.B_LandOn..[[)

      if (SwTurnPos and (TurnLPos ~= 1)) then
        command_once("1-sim/command/lights/runwayL/switch_trigger")
      elseif (not(SwTurnPos) and (TurnLPos ~= 0)) then
        command_once("1-sim/command/lights/runwayL/switch_trigger")
      end
      
      if (SwTurnPos and (TurnRPos ~= 1)) then
        command_once("1-sim/command/lights/runwayR/switch_trigger")
      elseif (not(SwTurnPos) and (TurnRPos ~= 0)) then
        command_once("1-sim/command/lights/runwayR/switch_trigger")
      end
    ]])
----WING light button
  set_button_assignment(afy.B_TaxiOn,         "sim/none/none")
  set_button_assignment(afy.B_TaxiOff,        "sim/none/none")
  do_often([[
    InsPos =  get("anim/46/button")
    SwTaxiPos = button(]]..afy.B_TaxiOn..[[)
    
    if (SwTaxiPos and (InsPos ~= 1)) then
      set("anim/46/button", 1)
    elseif (not(SwTaxiPos) and (InsPos >= 1)) then
      set("anim/46/button", 0)
    end
  ]])
----NAV light Button
  set_button_assignment(afy.B_NavOn,         "sim/none/none")
  set_button_assignment(afy.B_NavOff,        "sim/none/none")
  do_often([[
    NAV_Pos =  get("anim/43/button")
    SwNavPos = button(]]..afy.B_NavOn..[[)
    
    if (SwNavPos and (NAV_Pos ~= 1)) then
      set("anim/43/button", 1)
    elseif (not(SwNavPos) and (NAV_Pos >= 1)) then
      set("anim/43/button", 0)
    end
    ]])
----LOGO light Button
  set_button_assignment(afy.B_StrobeOn,         "sim/none/none")
  set_button_assignment(afy.B_StrobeOff,        "sim/none/none")
  do_often([[
    STROBE_Pos =  get("anim/52/button")
    SwStrobePos = button(]]..afy.B_StrobeOn..[[)

    if (SwStrobePos and (STROBE_Pos ~= 1)) then
      set("anim/52/button", 1)
    elseif (not(SwStrobePos) and (STROBE_Pos >= 1)) then
      set("anim/52/button", 0)
    end
    ]])
end

function ChampAlphaCheck_B767_FF()
  if (
      XPLMFindDataRef("anim/14/button")                               ~= nil and
      XPLMFindDataRef("anim/43/button")                               ~= nil and
      XPLMFindDataRef("anim/44/button")                               ~= nil and
      XPLMFindDataRef("anim/46/button")                               ~= nil and
      XPLMFindDataRef("anim/52/button")                               ~= nil and
      XPLMFindDataRef("1-sim/lights/runwayL/switch")                  ~= nil and
      XPLMFindDataRef("1-sim/lights/runwayR/switch")                  ~= nil and

      XPLMFindCommand("1-sim/command/lights/runwayL/switch_trigger")  ~= nil and
      XPLMFindCommand("1-sim/command/lights/runwayR/switch_trigger")  ~= nil and
      true
     ) then return true
  else
    return false
  end
end
