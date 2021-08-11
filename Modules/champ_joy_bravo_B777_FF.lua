--Zibo 737-800

function ChampBravoMapping_B777_FF()
  function bravo_Ap_AltInc(numticks) bravo_command_multiple("777/spacial8", numticks) end
  function bravo_Ap_AltDec(numticks) bravo_command_multiple("777/spacial7", numticks) end
  function bravo_Ap_VsInc(numticks)  bravo_command_multiple("777/spacial6", numticks) end
  function bravo_Ap_VsDec(numticks)  bravo_command_multiple("777/spacial5", numticks) end
  function bravo_Ap_HdgInc(numticks) bravo_command_multiple("777/spacial4", numticks) end
  function bravo_Ap_HdgDec(numticks) bravo_command_multiple("777/spacial3", numticks) end
  function bravo_Ap_IasInc(numticks) bravo_command_multiple("777/spacial1", numticks) end
  function bravo_Ap_IasDec(numticks) bravo_command_multiple("777/spacial2", numticks) end

  set_button_assignment(btq.ap_hdg, "sim/none/none")
  function apPanelCockpitHdgShort(status)
    if (status == "begin") then set("anim/173/button", (1 - get("anim/173/button"))) end
  end
  function apPanelCockpitHdgLong(status)
    if (status == "begin") then set("anim/22/button", (1 - get("anim/22/button"))) end
  end

  set_button_assignment(btq.ap_nav, "sim/none/none")
  function apPanelCockpitNavShort(status)
    if (status == "begin") then set("anim/16/button", (1 - get("anim/16/button"))) end
  end
  function apPanelCockpitNavLong(status)
    if (status == "begin") then set("anim/17/button", (1 - get("anim/17/button"))) end
  end

  set_button_assignment(btq.ap_apr, "sim/none/none")
  function apPanelCockpitAprShort(status)
    if (status == "begin") then set("anim/27/button", (1 - get("anim/27/button"))) end
  end
  function apPanelCockpitAprLong(status)
    if (status == "begin") then set("anim/26/button", (1 - get("anim/26/button"))) end
  end

  set_button_assignment(btq.ap_rev, "sim/none/none")
  function apPanelCockpitRevShort(status)    end
  function apPanelCockpitRevLong(status)     end

  set_button_assignment(btq.ap_alt,    "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then set("anim/18/button", (1 - get("anim/18/button"))) end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then set("anim/184/button", (1 - get("anim/184/button"))) end
  end

  set_button_assignment(btq.ap_vs, "sim/none/none")
  function apPanelCockpitVsShort(status)
    if (status == "begin") then set("anim/24/button", (1 - get("anim/24/button"))) end
  end
  function apPanelCockpitVsLong(status)
    if (status == "begin") then set("anim/14/button", (1 - get("anim/14/button"))) end
  end

  set_button_assignment(btq.ap_ias, "sim/none/none")
  function apPanelCockpitIasShort(status)
    if (status == "begin") then set("anim/186/button", (1 - get("anim/186/button"))) end
  end
  function apPanelCockpitIasLong(status)
    if (status == "begin") then set("anim/19/button", (1 - get("anim/19/button"))) end
  end

  set_button_assignment(btq.ap_master, "sim/none/none")
  function apPanelCockpitMasterShort(status)
    if (status == "begin") then command_begin("sim/autopilot/servos_toggle") elseif (status == "end") then command_end("sim/autopilot/servos_toggle") end
  end
  function apPanelCockpitMasterLong(status)
    if (status == "begin") then set("anim/33/switch", (1 - get("anim/33/switch"))) end
  end

  do_every_frame("apPanelDualHandler()")

  set_button_assignment(btq.axis3_toga, "777/at_toga")

  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_every_frame([[
    L_Pos = get("anim/15/switch")
    R_Pos = get("anim/16/switch")
    SwPos2 = button(]]..btq.sw2_up..[[)

    if (SwPos2 and (L_Pos ~= 2)) then
      set("anim/15/switch", 2)
    elseif (not(SwPos2) and (L_Pos == 2)) then
      set("anim/15/switch", 1)
    end

    if (SwPos2 and (R_Pos ~= 2)) then
      set("anim/16/switch", 2)
    elseif (not(SwPos2) and (R_Pos == 2)) then
      set("anim/16/switch", 1)
    end
  ]])
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
  do_every_frame([[
    T_Pos = get("anim/14/switch")
    SwPos3 = button(]]..btq.sw3_up..[[)

    if (SwPos3 and (T_Pos ~= 2)) then
      set("anim/14/switch", 2)
    elseif (not(SwPos3) and (T_Pos == 2)) then
      set("anim/14/switch", 1)
    end
  ]])
  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_every_frame([[
    T_Pos = get("anim/45/switch")
    SwPos5 = button(]]..btq.sw5_up..[[)

    if (SwPos5 and (T_Pos ~= 1)) then
      set("anim/45/switch", 1)
    elseif (not(SwPos5) and (T_Pos ~= 0)) then
      set("anim/45/switch", 0)
    end
  ]])
  set_button_assignment(btq.sw6_up, "sim/none/none")
  set_button_assignment(btq.sw6_dn, "sim/none/none")
  do_every_frame([[
    T_Pos = get("anim/44/switch")
    SwPos6 = button(]]..btq.sw6_up..[[)

    if (SwPos6 and (T_Pos ~= 1)) then
      set("anim/44/switch", 1)
    elseif (not(SwPos6) and (T_Pos ~= 0)) then
      set("anim/44/switch", 0)
    end
  ]])
  set_button_assignment(btq.sw7_up, "sim/none/none")
  set_button_assignment(btq.sw7_dn, "sim/none/none")
  do_every_frame([[
    L_Pos = get("anim/40/switch")
    C_Pos = get("anim/88/switch")
    R_Pos = get("anim/89/switch")
    SwPos7 = button(]]..btq.sw7_up..[[)

    if (SwPos7 and (L_Pos ~= 1)) then
      set("anim/40/switch", 1)
    elseif (not(SwPos7) and (L_Pos ~= 0)) then
      set("anim/40/switch", 0)
    end

    if (SwPos7 and (C_Pos ~= 1)) then
      set("anim/88/switch", 1)
    elseif (not(SwPos7) and (C_Pos ~= 0)) then
      set("anim/88/switch", 0)
    end

    if (SwPos7 and (R_Pos ~= 1)) then
      set("anim/89/switch", 1)
    elseif (not(SwPos7) and (R_Pos ~= 0)) then
      set("anim/89/switch", 0)
    end
  ]])

end


function ChampBravoLed_B777_FF()
  btq_led.led_check(
    (
      (get("sim/flightmodel2/gear/deploy_ratio", 3) == 1.0)
    ), btq_led, 'B', btq_led.block_B_LED.RIGHT_GEAR_GREEN)
  btq_led.led_check(
    (
      (get("sim/flightmodel2/gear/deploy_ratio", 3) < 1.0) and
      (get("sim/flightmodel2/gear/deploy_ratio", 3) > 0)
    ), btq_led, 'B', btq_led.block_B_LED.RIGHT_GEAR_RED)
  btq_led.led_check(
    (
      (get("lamps/257") > 0.8) or
      (get("T7Avionics/ap/roll_mode_engaged") == 0) or
      (get("T7Avionics/ap/roll_mode_engaged") == 1) or
      (get("T7Avionics/ap/roll_mode_engaged") == 6) or
      (get("T7Avionics/ap/roll_mode_engaged") == 7)
    ), btq_led, 'A', btq_led.block_A_LED.HEADING)
  btq_led.led_check(
    (
      (get("lamps/253") >= 0.8) or
      (get("lamps/254") == 0.8) or
      (get("T7Avionics/ap/roll_mode_engaged") == 2) or
      (get("T7Avionics/ap/pitch_mode_engaged") == 3) or
      (get("T7Avionics/ap/pitch_mode_engaged") == 4) or
      (get("T7Avionics/ap/pitch_mode_engaged") == 5)
    ), btq_led, 'A', btq_led.block_A_LED.NAV)
  btq_led.led_check(
    (
      (get("lamps/260") == 1) or
      (get("lamps/261") == 1) or
      (get("T7Avionics/ap/roll_mode_engaged") == 3) or
      (get("T7Avionics/ap/pitch_mode_engaged") == 6)
    ), btq_led, 'A', btq_led.block_A_LED.APR)
  btq_led.led_check(
    (
      (get("lamps/259") == 1) or
      (get("lamps/255") == 1) or
      (get("T7Avionics/ap/pitch_mode_engaged") == 1) or
      (get("T7Avionics/ap/pitch_mode_engaged") == 7)
    ), btq_led, 'A', btq_led.block_A_LED.ALT)
  btq_led.led_check(
    (
      (get("lamps/258") == 1) or
      (get("T7Avionics/ap/pitch_mode_engaged") == 2)
    ), btq_led, 'A', btq_led.block_A_LED.VS)
  btq_led.led_check(
    (
      (get("lamps/252") >= 0.8) or 
      (get("T7Avionics/ap/at_mode") >= 0)
    ), btq_led, 'A', btq_led.block_A_LED.IAS)

  --Could not find a dataref for MW
  --Could not find a dataref for MC
  btq_led.led_check(
    (
      (get("fire_lamp/APU") == 1) or
      (get("fire_lamp/L")     == 1) or
      (get("fire_lamp/R") == 1)
    ), btq_led, 'B', btq_led.block_B_LED.ENGINE_FIRE)
  --Too complicated to find the datarefs
  btq_led.led_check(
    (
      false
    ), btq_led, 'D', btq_led.block_D_LED.LOW_VOLTS)
end


function ChampBravoCheck_B777_FF()
  if (

      --AP Panel
      XPLMFindCommand("777/spacial8") ~= nil and
      XPLMFindCommand("777/spacial7") ~= nil and
      XPLMFindCommand("777/spacial6") ~= nil and
      XPLMFindCommand("777/spacial5") ~= nil and
      XPLMFindCommand("777/spacial4") ~= nil and
      XPLMFindCommand("777/spacial3") ~= nil and
      XPLMFindCommand("777/spacial2") ~= nil and
      XPLMFindCommand("777/spacial1") ~= nil and

      XPLMFindDataRef("anim/173/button") ~= nil and
      XPLMFindDataRef("anim/22/button")  ~= nil and
      XPLMFindDataRef("anim/16/button")  ~= nil and
      XPLMFindDataRef("anim/17/button")  ~= nil and
      XPLMFindDataRef("anim/27/button")  ~= nil and
      XPLMFindDataRef("anim/26/button")  ~= nil and
      XPLMFindDataRef("anim/18/button")  ~= nil and
      XPLMFindDataRef("anim/184/button") ~= nil and
      XPLMFindDataRef("anim/24/button")  ~= nil and
      XPLMFindDataRef("anim/14/button")  ~= nil and
      XPLMFindDataRef("anim/186/button") ~= nil and
      XPLMFindDataRef("anim/19/button")  ~= nil and
      XPLMFindDataRef("anim/33/switch")  ~= nil and

      --Axis
      XPLMFindCommand("777/at_toga") ~= nil and

      --Switches
      XPLMFindDataRef("anim/15/switch") ~= nil and
      XPLMFindDataRef("anim/16/switch") ~= nil and
      XPLMFindDataRef("anim/14/switch") ~= nil and
      XPLMFindDataRef("anim/45/switch") ~= nil and
      XPLMFindDataRef("anim/44/switch") ~= nil and
      XPLMFindDataRef("anim/40/switch") ~= nil and
      XPLMFindDataRef("anim/88/switch") ~= nil and
      XPLMFindDataRef("anim/89/switch") ~= nil and

      --LEDs
      XPLMFindDataRef("T7Avionics/ap/pitch_mode_engaged") ~= nil and
      XPLMFindDataRef("T7Avionics/ap/roll_mode_engaged")  ~= nil and
      XPLMFindDataRef("lamps/257")                        ~= nil and
      XPLMFindDataRef("lamps/253")                        ~= nil and
      XPLMFindDataRef("lamps/254")                        ~= nil and
      XPLMFindDataRef("lamps/260")                        ~= nil and
      XPLMFindDataRef("lamps/261")                        ~= nil and
      XPLMFindDataRef("lamps/252")                        ~= nil and
      XPLMFindDataRef("lamps/259")                        ~= nil and
      XPLMFindDataRef("lamps/255")                        ~= nil and
      XPLMFindDataRef("lamps/258")                        ~= nil and
      XPLMFindDataRef("T7Avionics/ap/at_mode")            ~= nil and
      XPLMFindDataRef("fire_lamp/APU")                    ~= nil and
      XPLMFindDataRef("fire_lamp/L")                      ~= nil and
      XPLMFindDataRef("fire_lamp/R")                      ~= nil
     ) then return true
  else
    return false
  end
end
