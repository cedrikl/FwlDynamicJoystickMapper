--HOTSTART TBM9 (Socata TBM 900)
function ChampBravoEngine_TBM9_hotstart()
  set_axis_assignment(btq.axis1, "none", "normal")
  set_axis_assignment(btq.axis2, "throttle 1", "reverse")
  set_axis_assignment(btq.axis3, "none", "normal")
  set_axis_assignment(btq.axis4, "none", "normal")
  set_axis_assignment(btq.axis5, "none", "normal")
  set_axis_assignment(btq.axis6, "none", "normal")
--Taxi speed and thrust reverser
  set_button_assignment(btq.axis2_rev_handle, "sim/engines/thrust_reverse_toggle")
--Side to Side Thruster shift
  set_button_assignment(btq.axis3_rev_handle, "sim/none/none")
  do_often([[
  LvrSidePos = get("tbm900/anim/throttle_side2side")
  HdlRanPos = get("tbm900/systems/engine/range")
  AxHanPos = button(]]..btq.axis3_rev_handle..[[)
    
    if (AxHanPos and (LvrSidePos ~= 1)) then
      command_once("sim/engines/mixture_down")
      command_once("sim/engines/mixture_down")
    elseif (not(AxHanPos) and (LvrSidePos == 1) and (HdlRanPos == 2)) then
      command_once("sim/engines/mixture_up")
    elseif (not(AxHanPos) and (LvrSidePos == 1) and (HdlRanPos == 1)) then
      command_once("sim/engines/mixture_up")
      command_once("sim/engines/mixture_up")
    end
  ]])
  
  set_button_assignment(btq.axis3_rev_zone, "sim/none/none")
  do_often([[
  HdlRanPos = get("tbm900/systems/engine/range")
  Ax3RevPos = button(]]..btq.axis3_rev_zone..[[)
  
    if(Ax3RevPos and (HdlRanPos ~= 0)) then
      command_once("sim/engines/mixture_down")
    elseif (not(Ax3RevPos) and (HdlRanPos == 0)) then
      command_once("sim/engines/mixture_up")
    end
  ]])    
end

function ChampBravoMapping_TBM9_hotstart()
  function bravo_Ap_VsInc(numticks)  bravo_command_multiple("tbm900/actuators/ap/nose_up", numticks) end
  function bravo_Ap_VsDec(numticks)  bravo_command_multiple("tbm900/actuators/ap/nose_down", numticks) end
--  function bravo_Ap_IasDec(numticks) bravo_command_multiple("SSG/EJET/MCP/CRS_P_UP", numticks) end
--  function bravo_Ap_IasDec(numticks) bravo_command_multiple("SSG/EJET/MCP/CRS_P_Down", numticks) end

  set_button_assignment(btq.ap_hdg,    "sim/none/none")
  function apPanelCockpitHdgShort(status) 
    if (status == "begin") then command_begin("sim/GPS/g1000n1_hdg") elseif (status == "end") then command_end("sim/GPS/g1000n1_hdg") end
  end
  function apPanelCockpitHdgLong(status) 
    if (status == "begin") then command_begin("sim/autopilot/heading_sync") elseif (status == "end") then command_end("sim/autopilot/heading_sync3") end
  end

  set_button_assignment(btq.ap_nav,    "sim/none/none")
  function apPanelCockpitNavShort(status) 
    if (status == "begin") then command_begin("tbm900/actuators/ap/nav") elseif (status == "end") then command_end("tbm900/actuators/ap/nav") end
  end
  function apPanelCockpitNavLong(status) 
    if (status == "begin") then command_begin("tbm900/actuators/ap/crs1_dr") elseif (status == "end") then command_end("tbm900/actuators/ap/crs1_dr") end
  end

  set_button_assignment(btq.ap_apr,    "sim/none/none")
  function apPanelCockpitAprShort(status) 
    if (status == "begin") then command_begin("tbm900/actuators/ap/apr") elseif (status == "end") then command_end("tbm900/actuators/ap/apr") end
  end
--  function apPanelCockpitAprLong(status) 
--    if (status == "begin") then command_begin("tbm900/actuators/ap/bc") elseif (status == "end") then command_end("tbm900/actuators/ap/bc") end
--  end

  set_button_assignment(btq.ap_rev,    "sim/none/none")
  function apPanelCockpitRevShort(status) 
    if (status == "begin") then command_begin("tbm900/actuators/ap/bc") elseif (status == "end") then command_end("tbm900/actuators/ap/bc") end
  end
--  function apPanelCockpitRevLong(status)     end

  set_button_assignment(btq.ap_alt,    "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then command_begin("tbm900/actuators/ap/alt") elseif (status == "end") then command_end("tbm900/actuators/ap/alt") end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then command_begin("tbm900/actuators/ap/flc") elseif (status == "end") then command_end("tbm900/actuators/ap/flc") end
  end

  set_button_assignment(btq.ap_vs,     "sim/none/none")
    function apPanelCockpitVsShort(status)
      if (status == "begin") then command_begin("tbm900/actuators/ap/vs") elseif (status == "end") then command_end("tbm900/actuators/ap/vs") end
    end
    --function apPanelCockpitVsLong(status)
    --  if (status == "begin") then command_begin("") elseif (status == "end") then command_end("") end
    --end

  set_button_assignment(btq.ap_ias,    "sim/none/none")
  function apPanelCockpitIasShort(status)
    if (status == "begin") then command_begin("tbm900/actuators/ap/spd") elseif (status == "end") then command_end("tbm900/actuators/ap/spd") end
  end
--  function apPanelCockpitIasLong(status)
--    if (status == "begin") then command_begin("SSG/EJET/MCP/AT_COMM") elseif (status == "end") then command_end("SSG/EJET/MCP/AT_COMM") end
--  end

  set_button_assignment(btq.ap_master, "sim/none/none")
  function apPanelCockpitMasterShort(status)
    if (status == "begin") then command_begin("sim/GPS/g1000n1_ap") elseif (status == "end") then command_end("sim/GPS/g1000n1_ap") end
  end
--  function apPanelCockpitMasterLong(status)
--    if (status == "begin") then command_begin("SSG/EJET/MCP/AT_COMM") elseif (status == "end") then command_end("SSG/EJET/MCP/AT_COMM") end
--  end

  do_every_frame("apPanelDualHandler()")
--  -----------------
--  --PANEL BUTTONS--
--  -----------------
--Parking Brake
  set_button_assignment(btq.sw1_up, "sim/none/none")
  set_button_assignment(btq.sw1_dn, "sim/none/none")
  do_often([[
    ParkPos = get("tbm900/switches/gear/park_brake")
    Chock1Status = get("tbm900/controls/gear/brake_req", 0)
    Chock2Status = get("tbm900/controls/gear/brake_req", 1)
    SwPos = button(]]..btq.sw1_up..[[)

    if ((Chock1Status) and (Chock2Status) < 0.9) then
      if (SwPos and (ParkPos < 0.0001)) then
        set("tbm900/switches/gear/park_brake", 1)
      elseif (not(SwPos) and (ParkPos > 0.9999)) then
        set("tbm900/switches/gear/park_brake", 0)
      end
    end
    ]])
--Eng Anti-Ice
  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_often([[
    PropIcePos = get("tbm900/switches/ice/prop_deice")
    SwPos2 = button(]]..btq.sw2_up..[[)
    
    if (SwPos2 and (PropIcePos ~= 1)) then
      command_once("tbm900/actuators/ice/prop_deice")
    elseif (not(SwPos2) and (PropIcePos == 1)) then
      command_once("tbm900/actuators/ice/prop_deice")
    end
  ]])
--Wing anti-ice
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
  do_often([[
    WingIcepos = get("tbm900/switches/ice/airframe_deice")
    SwPos3 = button(]]..btq.sw3_up..[[)
    
    if (SwPos3 and (WingIcepos ~= 1)) then
      command_once("tbm900/actuators/ice/airframe_deice")
    elseif (not(SwPos3) and (WingIcepos == 1)) then
      command_once("tbm900/actuators/ice/airframe_deice")
    end
  ]])
--Strobe light
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_often([[
    Str1Pos = get("sim/cockpit/electrical/strobe_lights_on")
    SwPos5 = button(]]..btq.sw5_up..[[)
    
    if (SwPos5 and (Str1Pos ~= 1)) then
      command_once("sim/lights/strobe_lights_toggle")
    elseif (not(SwPos5) and (Str1Pos >= 1)) then
      command_once("sim/lights/strobe_lights_toggle")
    end
  ]])
--Taxi and Landing light switch
  set_button_assignment(btq.sw6_up,    "sim/none/none")
  set_button_assignment(btq.sw6_dn,    "sim/none/none")
  set_button_assignment(btq.sw7_up,    "sim/none/none")
  set_button_assignment(btq.sw7_dn,    "sim/none/none")
  do_often ([[
    Sw_Pos = get("tbm900/switches/lights/landing_lights")
    SwInGate = (Sw_Pos == 0.0) or (Sw_Pos == 1.0) or (Sw_Pos == 2.0)
  
    SwPos6 = button(]]..btq.sw6_up..[[)
    SwPos7 = button(]]..btq.sw7_up..[[)
  
    if (SwPos7 and (Sw_Pos ~= 2.0) and SwInGate) then
      command_once("tbm900/actuators/lights/landing_lights_ldg")
    elseif (not(SwPos7) and SwPos6 and (Sw_Pos ~= 1.0) and SwInGate) then
      command_once("tbm900/actuators/lights/landing_lights_taxi")
    elseif (not(SwPos7) and not(SwPos6) and (Sw_Pos ~= 0.0) and SwInGate) then
      command_once("tbm900/actuators/lights/landing_lights_off")
    end
  ]])
end

function ChampBravoCheck_TBM9_hotstart()
  if (
--    axis 
      XPLMFindDataRef("tbm900/anim/throttle_side2side")              ~= nil and
      XPLMFindDataRef("tbm900/systems/engine/range")                 ~= nil and
      XPLMFindDataRef("tbm900/anim/throttle_fwd_back")               ~= nil and
--AUTOPILOT
--    rotary
      XPLMFindCommand("tbm900/actuators/ap/nose_up")                 ~= nil and
      XPLMFindCommand("tbm900/actuators/ap/nose_down")               ~= nil and
--    buttons
      XPLMFindCommand("tbm900/actuators/ap/nav")                     ~= nil and
      XPLMFindCommand("tbm900/actuators/ap/crs1_dr")                 ~= nil and
      XPLMFindCommand("tbm900/actuators/ap/apr")                     ~= nil and
      XPLMFindCommand("tbm900/actuators/ap/bc")                      ~= nil and
      XPLMFindCommand("tbm900/actuators/ap/alt")                     ~= nil and
      XPLMFindCommand("tbm900/actuators/ap/flc")                     ~= nil and
      XPLMFindCommand("tbm900/actuators/ap/vs")                      ~= nil and
      XPLMFindCommand("tbm900/actuators/ap/spd")                     ~= nil and
      XPLMFindCommand("sim/GPS/g1000n1_ap")                          ~= nil and
--SWITCHES
--    ParkBrake
      XPLMFindDataRef("tbm900/switches/gear/park_brake")             ~= nil and
      XPLMFindDataRef("tbm900/controls/gear/brake_req")              ~= nil and
--    prop deice
      XPLMFindDataRef("tbm900/switches/ice/prop_deice")              ~= nil and
      XPLMFindCommand("tbm900/actuators/ice/prop_deice")             ~= nil and
--    Wing deice
      XPLMFindDataRef("tbm900/switches/ice/airframe_deice")          ~= nil and
      XPLMFindCommand("tbm900/actuators/ice/airframe_deice")         ~= nil and
--    landing
      XPLMFindDataRef("tbm900/switches/lights/landing_lights")       ~= nil and
      XPLMFindCommand("tbm900/actuators/lights/landing_lights_taxi") ~= nil and
      XPLMFindCommand("tbm900/actuators/lights/landing_lights_ldg")  ~= nil and
      XPLMFindCommand("tbm900/actuators/lights/landing_lights_off")  ~= nil
     ) then return true
  else
    return false
  end
end
