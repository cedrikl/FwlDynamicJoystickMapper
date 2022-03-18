--Zibo 737-800

function ChampAlphaMapping_B777_FF()
--Battery Cover & Button
  set_button_assignment(afy.B_BattOn,    "sim/none/none")
  set_button_assignment(afy.B_BattOff,   "sim/none/none")
  do_often([[
    Batt2_Pos = get("anim/90/button")
    SwBattPos = button(]]..afy.B_BattOn..[[)

    if (SwBattPos and (Batt2_Pos ~= 1)) then
      set("anim/90/button", 1)
    elseif (not(SwBattPos) and (Batt2_Pos == 1)) then
      set("anim/90/button", 0)
    end
    ]])
----BCN light Button
  set_button_assignment(afy.B_BcnOn,    "sim/none/none")
  set_button_assignment(afy.B_BcnOff,   "sim/none/none")
  do_often([[
    BCN_Pos =  get("anim/129/button")
    SwBcnPos = button(]]..afy.B_BcnOn..[[)

    if (SwBcnPos and (BCN_Pos ~= 1)) then
      set("anim/129/button", 1)
    elseif (not(SwBcnPos) and (BCN_Pos == 1)) then
      set("anim/129/button", 0)
    end
  ]])
----TurnOff L&R lights
  set_button_assignment(afy.B_LandOn,         "sim/none/none")
  set_button_assignment(afy.B_LandOff,        "sim/none/none")
  do_often([[
      TurnLPos = get("anim/42/switch")
      TurnRPos = get("anim/43/switch")
      SwTurnPos = button(]]..afy.B_LandOn..[[)

      if (SwTurnPos and (TurnLPos ~= 1)) then
        set("anim/42/switch", 1)
      elseif (not(SwTurnPos) and (TurnLPos ~= 0)) then
        set("anim/42/switch", 0)
      end

      if (SwTurnPos and (TurnRPos ~= 1)) then
        set("anim/43/switch", 1)
      elseif (not(SwTurnPos) and (TurnRPos ~= 0)) then
        set("anim/43/switch", 0)
      end
    ]])
----WING light button
  set_button_assignment(afy.B_TaxiOn,         "sim/none/none")
  set_button_assignment(afy.B_TaxiOff,        "sim/none/none")
  do_often([[
    InsPos =  get("anim/132/button")
    SwTaxiPos = button(]]..afy.B_TaxiOn..[[)
    
    if (SwTaxiPos and (InsPos ~= 1)) then
      set("anim/132/button", 1)
    elseif (not(SwTaxiPos) and (InsPos >= 1)) then
      set("anim/132/button", 0)
    end
  ]])
----NAV light Button
  set_button_assignment(afy.B_NavOn,         "sim/none/none")
  set_button_assignment(afy.B_NavOff,        "sim/none/none")
  do_often([[
    NAV_Pos =  get("anim/130/button")
    SwNavPos = button(]]..afy.B_NavOn..[[)
    
    if (SwNavPos and (NAV_Pos ~= 1)) then
      set("anim/130/button", 1)
    elseif (not(SwNavPos) and (NAV_Pos >= 1)) then
      set("anim/130/button", 0)
    end
    ]])
----LOGO light Button
  set_button_assignment(afy.B_StrobeOn,         "sim/none/none")
  set_button_assignment(afy.B_StrobeOff,        "sim/none/none")
  do_often([[
    STROBE_Pos =  get("anim/131/button")
    SwStrobePos = button(]]..afy.B_StrobeOn..[[)

    if (SwStrobePos and (STROBE_Pos ~= 1)) then
      set("anim/131/button", 1)
    elseif (not(SwStrobePos) and (STROBE_Pos >= 1)) then
      set("anim/131/button", 0)
    end
    ]])
end

function ChampAlphaCheck_B777_FF()
  if (
      XPLMFindDataRef("anim/42/button")                              ~= nil and
      XPLMFindDataRef("anim/43/button")                              ~= nil and
      XPLMFindDataRef("anim/90/button")                              ~= nil and
      XPLMFindDataRef("anim/129/button")                             ~= nil and
      XPLMFindDataRef("anim/130/button")                             ~= nil and
      XPLMFindDataRef("anim/131/button")                             ~= nil and
      XPLMFindDataRef("anim/132/button")                             ~= nil and
     true
     ) then return true
  else
    return false
  end
end
