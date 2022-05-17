--AD Simulation CRJ-900

function ChampAlphaMapping_CRJ_AD()

--DC Service
  set_button_assignment(afy.B_AltOn,         "sim/none/none")
  set_button_assignment(afy.B_AltOff,        "sim/none/none")
  do_often ([[
    DC_Pos =  get("crj900/electrical/dc_service_animation")
    SwSAltPos = button(]]..afy.B_AltOn..[[)
    
    if (SwSAltPos and (DC_Pos < 1)) then
      command_once("crj900/electrical/dc_service_down")
    elseif (not(SwSAltPos) and (DC_Pos > 0)) then
      command_once("crj900/electrical/dc_service_up")
    end
  ]])
--Batt Master
  set_button_assignment(afy.B_BattOn,         "sim/none/none")
  set_button_assignment(afy.B_BattOff,        "sim/none/none")
  do_often ([[
    Batt_Pos =  get("crj900/electrical/batt_master_animation")
    SwSBattPos = button(]]..afy.B_BattOn..[[)
    
    if (SwSBattPos and (Batt_Pos < 1)) then
      command_once("crj900/electrical/batt_master_down")
    elseif (not(SwSBattPos) and (Batt_Pos > 0)) then
      command_once("crj900/electrical/batt_master_up")
    end
  ]])
--AC Power
  set_button_assignment(afy.B_Bus1On,         "sim/none/none")
  set_button_assignment(afy.B_Bus1Off,        "sim/none/none")
  do_often ([[
    AC_Avai =  get("crj900/electrical/ac_power_available_lit")
    AC_InUse =  get("crj900/electrical/ac_power_in_use_lit")
    AC_Pos =  get("crj900/electrical/ac_power_animation")
    SwSBus1Pos = button(]]..afy.B_Bus1On..[[)
    
    if (SwSBus1Pos and (AC_Avai == 1)) then
      command_once("crj900/electrical/ac_power")
    elseif (not(SwSBus1Pos) and (AC_InUse == 1)) then
      command_once("crj900/electrical/ac_power")
    end
  ]])

--LIGHT CONTROLS
  --BCN Button
  set_button_assignment(afy.B_BcnOn,         "sim/none/none")
  set_button_assignment(afy.B_BcnOff,        "sim/none/none")
  do_often([[
    Bcn_Pos =  get("crj900/EXT_LTS/beacon_anim")
    SwSBcnPos = button(]]..afy.B_BcnOn..[[)

    if (SwSBcnPos and (Bcn_Pos < 1)) then
      command_once("crj900/EXT_LTS/beacon_down")
    elseif (not(SwSBcnPos) and (Bcn_Pos > 0)) then
      command_once("crj900/EXT_LTS/beacon_up")
    end
  ]])
--WING light button
  set_button_assignment(afy.B_TaxiOn,         "sim/none/none")
  set_button_assignment(afy.B_TaxiOff,        "sim/none/none")
  do_often([[
    TAXI_Pos =  get("crj900/EXT_LTS/wing_anim")
    SwTaxiPos = button(]]..afy.B_TaxiOn..[[)
    
    if (SwTaxiPos and (TAXI_Pos < 1)) then
      command_once("crj900/EXT_LTS/wing_down")
    elseif (not(SwTaxiPos) and (TAXI_Pos > 0)) then
      command_once("crj900/EXT_LTS/wing_up")
    end
  ]])
--NAV light Button
  set_button_assignment(afy.B_NavOn,         "sim/none/none")
  set_button_assignment(afy.B_NavOff,        "sim/none/none")
  do_often([[
    NAV_Pos =  get("crj900/EXT_LTS/nav_anim")
    SwNavPos = button(]]..afy.B_NavOn..[[)
    
    if (SwNavPos and (NAV_Pos < 1)) then
      command_once("crj900/EXT_LTS/nav_down")
    elseif (not(SwNavPos) and (NAV_Pos > 0)) then
      command_once("crj900/EXT_LTS/nav_up")
    end
  ]])
--LOGO light Button
  set_button_assignment(afy.B_StrobeOn,         "sim/none/none")
  set_button_assignment(afy.B_StrobeOff,        "sim/none/none")
  do_often([[
    STROBE_Pos =  get("crj900/EXT_LTS/logo_anim")
    SwStrobePos = button(]]..afy.B_StrobeOn..[[)
    
    if (SwStrobePos and (STROBE_Pos < 1)) then
      command_once("crj900/EXT_LTS/logo_down")
    elseif (not(SwStrobePos) and (STROBE_Pos > 0)) then
      command_once("crj900/EXT_LTS/logo_up")
    end
  ]])
end

function ChampAlphaCheck_CRJ_AD()
  if (
--Datarefs
      XPLMFindDataRef("crj900/electrical/batt_master_animation")      ~= nil and
      XPLMFindDataRef("crj900/electrical/dc_service_animation")       ~= nil and
      XPLMFindDataRef("crj900/electrical/ac_power_animation")         ~= nil and
      XPLMFindDataRef("crj900/electrical/ac_power_available_lit")     ~= nil and
      XPLMFindDataRef("crj900/electrical/ac_power_in_use_lit")        ~= nil and
      XPLMFindDataRef("crj900/EXT_LTS/beacon_anim")                   ~= nil and
      XPLMFindDataRef("crj900/EXT_LTS/wing_anim")                     ~= nil and
      XPLMFindDataRef("crj900/EXT_LTS/nav_anim")                      ~= nil and
      XPLMFindDataRef("crj900/EXT_LTS/logo_anim")                     ~= nil and
     
--Commands  
      XPLMFindCommand("crj900/electrical/batt_master_up")             ~= nil and
      XPLMFindCommand("crj900/electrical/batt_master_down")           ~= nil and
      XPLMFindCommand("crj900/electrical/dc_service_up")              ~= nil and
      XPLMFindCommand("crj900/electrical/dc_service_down")            ~= nil and
      XPLMFindCommand("crj900/electrical/ac_power")                   ~= nil and
      XPLMFindCommand("crj900/EXT_LTS/beacon_up")                     ~= nil and
      XPLMFindCommand("crj900/EXT_LTS/beacon_down")                   ~= nil and
      XPLMFindCommand("crj900/EXT_LTS/wing_up")                       ~= nil and
      XPLMFindCommand("crj900/EXT_LTS/wing_down")                     ~= nil and
      XPLMFindCommand("crj900/EXT_LTS/nav_up")                        ~= nil and
      XPLMFindCommand("crj900/EXT_LTS/nav_down")                      ~= nil and
      XPLMFindCommand("crj900/EXT_LTS/logo_up")                       ~= nil and
      XPLMFindCommand("crj900/EXT_LTS/logo_down")                     ~= nil and
      XPLMFindCommand("crj900/command/autopilot/ap_disc")             ~= nil
     ) then return true
  else
    return false
  end
end

