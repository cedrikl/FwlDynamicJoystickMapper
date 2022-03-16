--SSG 747-8 Alpha Flight Controls
function ChampAlphaMapping_B748_SSG()
--BCN light Button
  set_button_assignment(afy.B_BcnOn,    "sim/none/none")
  set_button_assignment(afy.B_BcnOff,   "sim/none/none")
  do_often([[
    BCN_Pos =  get("ssg/LGT/lgt_bcn_sw")
    SwBcnPos = button(]]..afy.B_BcnOn..[[)
    
    if (SwBcnPos and (BCN_Pos < 1)) then
      command_once("SSG/Lights/beacon")
    elseif (not(SwBcnPos) and (BCN_Pos > 0)) then
      command_once("SSG/Lights/beacon")
    end
  ]])  
--TurnOff L&R lights Buttons
  set_button_assignment(afy.B_LandOn,         "sim/none/none")
  set_button_assignment(afy.B_LandOff,        "sim/none/none")
  do_often([[
    TurnOffL_Pos =  get("ssg/LGT/lgt_rwyL_sw")
    TurnOffR_Pos =  get("ssg/LGT/lgt_rwyR_sw")
    SwLandPos = button(]]..afy.B_LandOn..[[)
    
    if (SwLandPos and (TurnOffL_Pos < 1)) then
      command_once("SSG/Lights/TURNOFFL")
    elseif (not(SwLandPos) and (TurnOffL_Pos > 0)) then
      command_once("SSG/Lights/TURNOFFL")
    end

    if (SwLandPos and (TurnOffR_Pos < 1)) then
      command_once("SSG/Lights/TURNOFFR")
    elseif (not(SwLandPos) and (TurnOffR_Pos > 0)) then
      command_once("SSG/Lights/TURNOFFR")
    end
  ]])
--WING light button
  set_button_assignment(afy.B_TaxiOn,         "sim/none/none")
  set_button_assignment(afy.B_TaxiOff,        "sim/none/none")
  do_often([[
    TAXI_Pos =  get("ssg/LGT/lgt_wing_sw")
    SwTaxiPos = button(]]..afy.B_TaxiOn..[[)
    
    if (SwTaxiPos and (TAXI_Pos < 1)) then
      command_once("SSG/Lights/Wing")
    elseif (not(SwTaxiPos) and (TAXI_Pos > 0)) then
      command_once("SSG/Lights/Wing")
    end
  ]])
--NAV light Button
  set_button_assignment(afy.B_NavOn,         "sim/none/none")
  set_button_assignment(afy.B_NavOff,        "sim/none/none")
  do_often([[
    NAV_Pos =  get("ssg/LGT/lgt_nav_sw")
    SwNavPos = button(]]..afy.B_NavOn..[[)
    
    if (SwNavPos and (NAV_Pos < 1)) then
      command_once("SSG/Lights/Nav")
    elseif (not(SwNavPos) and (NAV_Pos > 0)) then
      command_once("SSG/Lights/Nav")
    end
  ]])
--LOGO light Button
  set_button_assignment(afy.B_StrobeOn,         "sim/none/none")
  set_button_assignment(afy.B_StrobeOff,        "sim/none/none")
  do_often([[
    STROBE_Pos =  get("ssg/LGT/lgt_logo_sw")
    SwStrobePos = button(]]..afy.B_StrobeOn..[[)
    
    if (SwStrobePos and (STROBE_Pos < 1)) then
      command_once("SSG/Lights/Logo")
    elseif (not(SwStrobePos) and (STROBE_Pos > 0)) then
      command_once("SSG/Lights/Logo")
    end
  ]])
end

function ChampAlphaCheck_B748_SSG()
  if (--Switches
      XPLMFindDataRef("ssg/LGT/lgt_bcn_sw")         ~= nil and
      XPLMFindCommand("SSG/Lights/beacon")          ~= nil and
      XPLMFindDataRef("ssg/LGT/lgt_nav_sw")         ~= nil and
      XPLMFindCommand("SSG/Lights/Nav")             ~= nil and
      XPLMFindDataRef("ssg/LGT/lgt_rwyL_sw")        ~= nil and
      XPLMFindDataRef("ssg/LGT/lgt_rwyR_sw")        ~= nil and
      XPLMFindCommand("SSG/Lights/TURNOFFL")        ~= nil and
      XPLMFindCommand("SSG/Lights/TURNOFFR")        ~= nil and
      XPLMFindDataRef("ssg/LGT/lgt_wing_sw")        ~= nil and
      XPLMFindCommand("SSG/Lights/Wing")            ~= nil and
      XPLMFindDataRef("ssg/LGT/lgt_logo_sw")        ~= nil and
      XPLMFindCommand("SSG/Lights/Logo")            ~= nil and
      true
     ) then return true
  else
    return false
  end
end
