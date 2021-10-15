------------------------------------
-- Common reverse helper function --
------------------------------------

function reverser_handler()
  ChampNbEngines  = get("sim/aircraft/engine/acf_num_engines")
  ChampEngineType = get("sim/aircraft/prop/acf_en_type", 0)
  ChampEngineBeta = get("sim/aircraft/overflow/acf_has_beta")

  if (PLANE_ICAO == "A320") then
    ChampBravoEngine_A320_FF()
  elseif ((PLANE_ICAO == "A321") or (PLANE_ICAO == "A21N")) then
    ChampBravoEngine_A321_toliss()
  elseif ((PLANE_ICAO == "B350") and (ChampEngineType == 9)) then
    ChampBravoEngine_B350_airfoillabs()
  elseif (PLANE_ICAO == "SF34") then
    ChampBravoEngine_SF34_les()
  elseif (PLANE_ICAO == "TBM9") then
    ChampBravoEngine_TBM9_hotstart()
  else
    if (((ChampEngineType <= 4) and (ChampNbEngines <= 2))) then
      -- (Turbo)Props (ENG1/ENG2/PROP1/PROP2/MIX1/MIX2)
      if (ChampEngineBeta) then
        set_axis_assignment(btq.axis1, "none", "normal")
        set_axis_assignment(btq.axis2, "none", "normal")
        set_button_assignment(btq.axis1_rev_zone, "sim/engines/beta_toggle_1")
        set_button_assignment(btq.axis2_rev_zone, "sim/engines/beta_toggle_2")

        do_every_frame([[
          Eng1Mode = get("sim/flightmodel/engine/ENGN_propmode", 0)
          Eng1Pos  = get("sim/cockpit2/engine/actuators/throttle_ratio", 0)
          Throttle1Pos = get("sim/joystick/joystick_axis_values",]]..btq.axis1..[[)

          if     ((Eng1Mode <= 1) and (Throttle1Pos > 0.02)) then
            set_array("sim/cockpit2/engine/actuators/throttle_ratio", 0, Throttle1Pos)
          elseif ((Eng1Mode <= 1) and (Throttle1Pos < 0.02) and (Eng1Pos >= 0.02)) then
            set_array("sim/cockpit2/engine/actuators/throttle_ratio", 0, 0)
          elseif (Eng1Mode > 1) then
            if (Throttle1Pos < 0.45)  then --beta range
              set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, (-2 * Throttle1Pos - 0.01))
            elseif (Throttle1Pos > 0.50) then -- reverse
              set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, (-2 * Throttle1Pos))
            end
          end

          Eng2Mode = get("sim/flightmodel/engine/ENGN_propmode", 1)
          Eng2Pos  = get("sim/cockpit2/engine/actuators/throttle_ratio", 1)
          Throttle2Pos = get("sim/joystick/joystick_axis_values",]]..btq.axis2..[[)

          if     ((Eng2Mode == 1) and (Throttle2Pos > 0.02)) then
            set_array("sim/cockpit2/engine/actuators/throttle_ratio", 1, Throttle2Pos)
          elseif ((Eng2Mode == 1) and (Throttle2Pos < 0.02) and (Eng2Pos >= 0.02)) then
            set_array("sim/cockpit2/engine/actuators/throttle_ratio", 1, 0)
          elseif (Eng2Mode > 1) then
            if (Throttle2Pos < 0.45)  then --beta range
              set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, (-2 * Throttle2Pos - 0.01))
            elseif (Throttle2Pos > 0.50) then -- reverse
              set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, (-2 * Throttle2Pos))
            end
          end
        ]])
      else
        set_button_assignment(btq.axis1_rev_zone, "sim/engines/thrust_reverse_toggle_1")
        set_button_assignment(btq.axis2_rev_zone, "sim/engines/thrust_reverse_toggle_2")
      end
    elseif ChampNbEngines == 2 then
      -- Jets (--/--/ENG1/ENG2/--/--)
      do_every_frame([[
        if (button(]]..btq.axis3_rev_handle..[[)            and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0) >= -1) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 0) < 0.05)) then
          set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, -1.0001)
        elseif ((not(button(]]..btq.axis3_rev_handle..[[))) and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0) < 0)   and (get("sim/cockpit2/engine/actuators/throttle_ratio", 0) < 0.05)) then
          set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, 0)
        end
        
        if (button(]]..btq.axis4_rev_handle..[[)            and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1) >= -1) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 1) < 0.05)) then
          set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, -1.0001)
        elseif ((not(button(]]..btq.axis4_rev_handle..[[))) and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1) < 0)   and (get("sim/cockpit2/engine/actuators/throttle_ratio", 1) < 0.05)) then
          set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, 0)
        end
      ]])
    elseif ChampNbEngines >= 3 then
      -- Jets (--/ENG1/ENG2/ENG3/ENG4/--)

      --set_button_assignment(btq.axis2_rev_zone, "sim/engines/thrust_reverse_toggle_1")
      --set_button_assignment(btq.axis3_rev_zone, "sim/engines/thrust_reverse_toggle_2")
      --set_button_assignment(btq.axis4_rev_zone, "sim/engines/thrust_reverse_toggle_3")
      --set_button_assignment(btq.axis5_rev_zone, "sim/engines/thrust_reverse_toggle_4")

      do_every_frame([[
        if (button(]]..btq.axis2_rev_handle..[[)            and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0) >= -1) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 0) < 0.05)) then
          set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, -1.0001)
        elseif ((not(button(]]..btq.axis2_rev_handle..[[))) and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0) < 0)   and (get("sim/cockpit2/engine/actuators/throttle_ratio", 0) < 0.05)) then
          set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 0, 0)
        end
        
        if (button(]]..btq.axis3_rev_handle..[[)            and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1) >= -1) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 1) < 0.05)) then
          set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, -1.0001)
        elseif ((not(button(]]..btq.axis3_rev_handle..[[))) and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1) < 0)   and (get("sim/cockpit2/engine/actuators/throttle_ratio", 1) < 0.05)) then
          set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 1, 0)
        end

        if (button(]]..btq.axis4_rev_handle..[[)            and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 2) >= -1) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 2) < 0.05)) then
          set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 2, -1.0001)
        elseif ((not(button(]]..btq.axis4_rev_handle..[[))) and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 2) < 0)   and (get("sim/cockpit2/engine/actuators/throttle_ratio", 2) < 0.05)) then
          set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 2, 0)
        end

        if (button(]]..btq.axis5_rev_handle..[[)            and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 3) >= -1) and (get("sim/cockpit2/engine/actuators/throttle_ratio", 3) < 0.05)) then
          set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 3, -1.0001)
        elseif ((not(button(]]..btq.axis5_rev_handle..[[))) and (get("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 3) < 0)   and (get("sim/cockpit2/engine/actuators/throttle_ratio", 3) < 0.05)) then
          set_array("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio", 3, 0)
        end
      ]])
    end
  end
end


---------------------------
-- Common engine mapping --
---------------------------

function ChampBravoEngine()
  ChampNbEngines  = get("sim/aircraft/engine/acf_num_engines")
  ChampEngineType = get("sim/aircraft/prop/acf_en_type", 0)
  ChampEngineBeta = get("sim/aircraft/overflow/acf_has_beta")
  logMsg(string.format("Champion Info: The number of engines is %i (Type: %i)", ChampNbEngines, ChampEngineType))

  if (((ChampEngineType <= 4) and (ChampNbEngines <= 2)) or (PLANE_ICAO == "B350")) then  --Prop aircraft
    set_axis_assignment(btq.axis1, "throttle 1", "reverse")
    set_axis_assignment(btq.axis2, "throttle 2", "reverse")

    set_axis_assignment(btq.axis3, "prop 1", "normal")
    set_axis_assignment(btq.axis4, "prop 2", "normal")

    set_axis_assignment(btq.axis5, "mixture 1", "normal")
    set_axis_assignment(btq.axis6, "mixture 2", "normal")

    set_button_assignment(btq.axis12_2nd_func, "sim/autopilot/take_off_go_around")
  elseif (ChampNbEngines == 2) then
    set_axis_assignment(btq.axis3, "throttle 1", "reverse")
    set_axis_assignment(btq.axis4, "throttle 2", "reverse")

    set_button_assignment(btq.axis3_2nd_func, "sim/autopilot/autothrottle_off")
    set_button_assignment(btq.axis4_2nd_func, "sim/engines/TOGA_power")
  elseif (ChampNbEngines >= 3) then
    set_axis_assignment(btq.axis2, "throttle 1", "reverse")
    set_axis_assignment(btq.axis3, "throttle 2", "reverse")
    set_axis_assignment(btq.axis4, "throttle 3", "reverse")
    set_axis_assignment(btq.axis5, "throttle 4", "reverse")

    set_button_assignment(btq.axis12_2nd_func, "sim/engines/TOGA_power")
  end
  reverser_handler()
end


local bravo = {}

local lastTickTimestamp = 0
local upticksRepetition = 0
local downticksRepetition = 0

apButtonStartOfPush = 0.0
apButtonStartOfRelease = 0.0
apButtonTimestampPushed = 0.0
apButtonTimestampReleased = 0.0
buttonPhase = 0
apButtonId = -1
apPanelDebounce = 0.100

apPanelJobRunning = false
apPanelJobStartTime = 0.0

function bravo.map(joy_num, joy_hid_pointer)

  start_axis   = joy_num * 25
  start_button = joy_num * 160
  bravo_start_button = st
  
  bravo.connected = false
  if (nil ~= joy_hid_pointer) then
    bravo.connected = true
  end

  logMsg(string.format("Champion Info: Mapping a Honeycomb Aeronautical Bravo Throttle Quadrant at (Axis=%i Buttons=%i)", start_axis, start_button))

  bravo.axis1 = start_axis
  bravo.axis2 = start_axis + 1
  bravo.axis3 = start_axis + 2
  bravo.axis4 = start_axis + 3
  bravo.axis5 = start_axis + 4
  bravo.axis6 = start_axis + 5

  --Buttons
  bravo.ap_hdg           = start_button       --sim/autopilot/heading
  bravo.ap_nav           = start_button + 1   --sim/autopilot/hdg_nav
  bravo.ap_apr           = start_button + 2   --sim/autopilot/approach
  bravo.ap_rev           = start_button + 3   --sim/autopilot/back_course
  bravo.ap_alt           = start_button + 4   --sim/autopilot/altitude_hold
  bravo.ap_vs            = start_button + 5   --sim/autopilot/vertical_speed
  bravo.ap_ias           = start_button + 6   --sim/autopilot/autothrottle_toggle
  bravo.ap_master        = start_button + 7   --sim/autopilot/servos_toggle
  bravo.axis2_rev_handle = start_button + 8
  bravo.axis3_rev_handle = start_button + 9
  bravo.axis4_rev_handle = start_button + 10
  bravo.axis5_rev_handle = start_button + 11
  bravo.ap_incr          = start_button + 12
  bravo.ap_decr          = start_button + 13
  bravo.flaps_dn         = start_button + 14  --sim/flight_controls/flaps_down
  bravo.flaps_up         = start_button + 15  --sim/flight_controls/flaps_up
  bravo.ap_mode_ias      = start_button + 16
  bravo.ap_mode_crs      = start_button + 17
  bravo.ap_mode_hdg      = start_button + 18
  bravo.ap_mode_vs       = start_button + 19
  bravo.ap_mode_alt      = start_button + 20
  bravo.trim_dn          = start_button + 21  --sim/flight_controls/pitch_trim_down
  bravo.trim_up          = start_button + 22  --sim/flight_controls/pitch_trim_up
  bravo.axis1_rev_zone   = start_button + 23
  bravo.axis2_rev_zone   = start_button + 24
  bravo.axis3_rev_zone   = start_button + 25
  bravo.axis4_rev_zone   = start_button + 26
  bravo.axis5_rev_zone   = start_button + 27

  --Axis 1-2 share the same alternate digital input
  bravo.axis12_2nd_func  = start_button + 28
  bravo.axis1_rev_handle = start_button + 28

  bravo.axis3_2nd_func   = start_button + 29
  bravo.gear_up          = start_button + 30  --sim/flight_controls/landing_gear_up
  bravo.gear_dn          = start_button + 31  --sim/flight_controls/landing_gear_down
  bravo.axis6_rev_zone   = start_button + 32
  bravo.sw1_up           = start_button + 33
  bravo.sw1_dn           = start_button + 34
  bravo.sw2_up           = start_button + 35
  bravo.sw2_dn           = start_button + 36
  bravo.sw3_up           = start_button + 37
  bravo.sw3_dn           = start_button + 38
  bravo.sw4_up           = start_button + 39
  bravo.sw4_dn           = start_button + 40
  bravo.sw5_up           = start_button + 41
  bravo.sw5_dn           = start_button + 42
  bravo.sw6_up           = start_button + 43
  bravo.sw6_dn           = start_button + 44
  bravo.sw7_up           = start_button + 45
  bravo.sw7_dn           = start_button + 46
  
  bravo.axis4_2nd_func   = start_button + 47
end


function bravo_command_multiple(command, count)
  while (count > 0)
  do
    command_once(command)
    count = count - 1
  end
end


function bravo_dataref_multiple(command, count, singleChange)
  while (count > 0)
  do
     before = get(command)
     set(command, before + singleChange )
    count = count - 1
  end
end


function bravo_Ap_AltInc(numticks) bravo_command_multiple("sim/autopilot/altitude_up", numticks) end
function bravo_Ap_AltDec(numticks) bravo_command_multiple("sim/autopilot/altitude_down", numticks) end

function bravo_Ap_VsInc(numticks) bravo_command_multiple("sim/autopilot/nose_up", numticks) end
function bravo_Ap_VsDec(numticks) bravo_command_multiple("sim/autopilot/nose_down", numticks) end

function bravo_Ap_HdgInc(numticks) bravo_command_multiple("sim/autopilot/heading_up", numticks) end
function bravo_Ap_HdgDec(numticks) bravo_command_multiple("sim/autopilot/heading_down", numticks) end

function bravo_Ap_CrsInc(numticks) bravo_command_multiple("sim/GPS/g1000n1_crs_up", numticks) end
function bravo_Ap_CrsDec(numticks) bravo_command_multiple("sim/GPS/g1000n1_crs_down", numticks) end

function bravo_Ap_IasInc(numticks) bravo_command_multiple("sim/autopilot/airspeed_up", numticks) end
function bravo_Ap_IasDec(numticks) bravo_command_multiple("sim/autopilot/airspeed_down", numticks) end


--Acceleration do not work on all commands (HDG will not accelerate, Laminar Code)
function apPanelHandleUpticks(numticks)
  if     (button(bravo.ap_mode_alt)) then
    bravo_Ap_AltInc(numticks)
  elseif (button(bravo.ap_mode_vs)) then
    bravo_Ap_VsInc(numticks)
  elseif (button(bravo.ap_mode_hdg)) then
    bravo_Ap_HdgInc(numticks)
  elseif (button(bravo.ap_mode_crs)) then
    bravo_Ap_CrsInc(numticks)
  elseif (button(bravo.ap_mode_ias)) then
    bravo_Ap_IasInc(numticks)
  end
end

function apPanelHandleDownticks(numticks)
  if     (button(bravo.ap_mode_alt)) then
    bravo_Ap_AltDec(numticks)
  elseif (button(bravo.ap_mode_vs)) then
    bravo_Ap_VsDec(numticks)
  elseif (button(bravo.ap_mode_hdg)) then
    bravo_Ap_HdgDec(numticks)
  elseif (button(bravo.ap_mode_crs)) then
    bravo_Ap_CrsDec(numticks)
  elseif (button(bravo.ap_mode_ias)) then
    bravo_Ap_IasDec(numticks)
  end
end


function apPanelWheelCheck()
  timeSinceLastTick = get("sim/time/total_running_time_sec") - lastTickTimestamp

  if (timeSinceLastTick > 0.100) then --min 70 msec between ticks, otherwise these multiple inputs sent
    uptick = button(bravo.ap_incr)
    downtick = button(bravo.ap_decr)
    count = 0

    if (uptick or downtick) then --the incr/decr knob was turned (and debounce exceeded)
      lastTickTimestamp = get("sim/time/total_running_time_sec")
      if (uptick) then
        downticksRepetition = 0
        upticksRepetition = upticksRepetition + 1

        if (upticksRepetition < 4) then
          apPanelHandleUpticks(1)
        elseif (upticksRepetition < 8) then
          apPanelHandleUpticks(2)
        elseif (upticksRepetition < 12) then
          apPanelHandleUpticks(5)
        else
          apPanelHandleUpticks(10)
        end
      else
        upticksRepetition = 0
        downticksRepetition = downticksRepetition + 1

        if (downticksRepetition < 4) then
          apPanelHandleDownticks(1)
        elseif (downticksRepetition < 8) then
          apPanelHandleDownticks(2)
        elseif (downticksRepetition < 12) then
          apPanelHandleDownticks(5)
        else
          apPanelHandleDownticks(10)
        end
      end
    end

    if (timeSinceLastTick > 0.4) then
      upticksRepetition = 0
      downticksRepetition = 0
    end
  end
end

-----------------------------------------


function apPanelButtonHandler(apButton, currentTime)
  --buttonPhase:
  --  0 = waiting for press
  --  1 = button pressed, debouncing
  --  2 = debounce complete, making final rising edge reading and pressTimestamp
  --  3 = button released, debouncing
  --  4 = debounce complete, making final falling edge reading and releaseTimestamp
  
  if(button(apButton) and (buttonPhase == 0)) then --ready and button is pressed
    logMsg(string.format("apPanelButtonHandler[phase: %d, button: %d]", buttonPhase, apButtonId))
    buttonPhase = 1
    apButtonId = apButton
    apButtonStartOfPush = currentTime
  end
  
  if(((currentTime - apButtonStartOfPush) > apPanelDebounce) and (buttonPhase == 1)) then --debounced
    logMsg(string.format("apPanelButtonHandler[phase: %d, button: %d]", buttonPhase, apButtonId))
    buttonPhase = 2
    apButtonTimestampPushed = currentTime
  end
  
  if(not(button(apButton)) and (apButtonId == apButton) and (buttonPhase == 2)) then
    logMsg(string.format("apPanelButtonHandler[phase: %d, button: %d]", buttonPhase, apButtonId))
    buttonPhase = 3
    apButtonStartOfRelease = currentTime
  end
  
  if(((currentTime - apButtonStartOfRelease) > apPanelDebounce) and (buttonPhase == 3)) then --debounced
    logMsg(string.format("apPanelButtonHandler[phase: %d, button: %d]", buttonPhase, apButtonId))
    if(not(button(apButton))) then
      buttonPhase = 4
      apButtonTimestampReleased = currentTime
    end
    buttonPhase = 0
    logMsg(string.format("Button pressed for a total duration of:%1.6f seconds", (apButtonTimestampReleased - apButtonTimestampPushed)))
  end
end


function apPanelCockpitHdgShort(status)    end
function apPanelCockpitHdgLong(status)     end
function apPanelCockpitNavShort(status)    end
function apPanelCockpitNavLong(status)     end
function apPanelCockpitAprShort(status)    end
function apPanelCockpitAprLong(status)     end
function apPanelCockpitRevShort(status)    end
function apPanelCockpitRevLong(status)     end
function apPanelCockpitAltShort(status)    end
function apPanelCockpitAltLong(status)     end
function apPanelCockpitVsShort(status)     end
function apPanelCockpitVsLong(status)      end
function apPanelCockpitIasShort(status)    end
function apPanelCockpitIasLong(status)     end
function apPanelCockpitMasterShort(status) end
function apPanelCockpitMasterLong(status)  end


function apPanelUpdate(currentTime)
  local buttonShortLongThreshold = 0.6
  local isLong = (apButtonTimestampReleased - apButtonTimestampPushed) > buttonShortLongThreshold

  local apPanelUpdateTime = 0.35
  

  if (not(apPanelJobRunning)) then
    if (apButtonId == bravo.ap_hdg) then
      apPanelJobRunning = true
      apPanelJobStartTime = currentTime
      if (isLong) then apPanelCockpitHdgLong("begin") else apPanelCockpitHdgShort("begin") end
    elseif (apButtonId == bravo.ap_nav) then
      apPanelJobRunning = true
      apPanelJobStartTime = currentTime
      if (isLong) then apPanelCockpitNavLong("begin") else apPanelCockpitNavShort("begin") end
    elseif (apButtonId == bravo.ap_apr) then
      apPanelJobRunning = true
      apPanelJobStartTime = currentTime
      if (isLong) then apPanelCockpitAprLong("begin") else apPanelCockpitAprShort("begin") end
    elseif (apButtonId == bravo.ap_rev) then
      apPanelJobRunning = true
      apPanelJobStartTime = currentTime
      if (isLong) then apPanelCockpitRevLong("begin") else apPanelCockpitRevShort("begin") end
    elseif (apButtonId == bravo.ap_alt) then
      apPanelJobRunning = true
      apPanelJobStartTime = currentTime
      if (isLong) then apPanelCockpitAltLong("begin") else apPanelCockpitAltShort("begin") end
    elseif (apButtonId == bravo.ap_vs) then
      apPanelJobRunning = true
      apPanelJobStartTime = currentTime
      if (isLong) then apPanelCockpitVsLong("begin") else apPanelCockpitVsShort("begin") end
    elseif (apButtonId == bravo.ap_ias) then
      apPanelJobRunning = true
      apPanelJobStartTime = currentTime
      if (isLong) then apPanelCockpitIasLong("begin") else apPanelCockpitIasShort("begin") end
    elseif (apButtonId == bravo.ap_master) then
      apPanelJobRunning = true
      apPanelJobStartTime = currentTime
      if (isLong) then apPanelCockpitMasterLong("begin") else apPanelCockpitMasterShort("begin") end
    end
  end

  if ((apPanelJobRunning) and ((currentTime - apPanelJobStartTime) > apPanelUpdateTime)) then
    if (apButtonId == bravo.ap_hdg) then
      apPanelJobRunning = false
      if (isLong) then apPanelCockpitHdgLong("end") else apPanelCockpitHdgShort("end") end
      apButtonId = -1
    elseif (apButtonId == bravo.ap_nav) then
      apPanelJobRunning = false
      if (isLong) then apPanelCockpitNavLong("end") else apPanelCockpitNavShort("end") end
      apButtonId = -1
    elseif (apButtonId == bravo.ap_apr) then
      apPanelJobRunning = false
      if (isLong) then apPanelCockpitAprLong("end") else apPanelCockpitAprShort("end") end
      apButtonId = -1
    elseif (apButtonId == bravo.ap_rev) then
      apPanelJobRunning = false
      if (isLong) then apPanelCockpitRevLong("end") else apPanelCockpitRevShort("end") end
      apButtonId = -1
    elseif (apButtonId == bravo.ap_alt) then
      apPanelJobRunning = false
      if (isLong) then apPanelCockpitAltLong("end") else apPanelCockpitAltShort("end") end
      apButtonId = -1
    elseif (apButtonId == bravo.ap_vs) then
      apPanelJobRunning = false
      if (isLong) then apPanelCockpitVsLong("end") else apPanelCockpitVsShort("end") end
      apButtonId = -1
    elseif (apButtonId == bravo.ap_ias) then
      apPanelJobRunning = false
      if (isLong) then apPanelCockpitIasLong("end") else apPanelCockpitIasShort("end") end
      apButtonId = -1
    elseif (apButtonId == bravo.ap_master) then
      apPanelJobRunning = false
      if (isLong) then apPanelCockpitMasterLong("end") else apPanelCockpitMasterShort("end") end
      apButtonId = -1
    end
  end
end


function apPanelDualHandler()
  local curTime = get("sim/time/total_running_time_sec")
  
  --if ((apButtonId ~= -1) and ((curTime - apButtonTimestampReleased) > 3.0)) then
  --  apButtonId = -1
  --  apButtonPressed = false
  --  debouncingFall = false
  --end

  apPanelButtonHandler(bravo.ap_hdg, curTime)
  apPanelButtonHandler(bravo.ap_nav, curTime)
  apPanelButtonHandler(bravo.ap_apr, curTime)
  apPanelButtonHandler(bravo.ap_rev, curTime)
  apPanelButtonHandler(bravo.ap_alt, curTime)
  apPanelButtonHandler(bravo.ap_vs,  curTime)
  apPanelButtonHandler(bravo.ap_ias, curTime)
  apPanelButtonHandler(bravo.ap_master, curTime)

  if (buttonPhase == 0) then apPanelUpdate(curTime) end
end

--------------------------------------------------------------------------------------------


function bravo.ap_panel_main()
  --logMsg(string.format("Champ Debug: bravo start button: %d", start_button))
  do_every_frame("apPanelWheelCheck()")
end

return bravo