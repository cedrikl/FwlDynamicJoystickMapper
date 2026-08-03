require("xfdm.base")
require("xfdm.joysticks.honeycomb_bravo")


if (string.find(PLANE_ICAO, "MD11")) then

  xfdm.aircrafts = {}
  xfdm.aircrafts.rmd11 = {}
  xfdm.aircrafts.rmd11.pushPullEndQueue = {}

  xfdm:requestConnector("cmd_ap_disc",       xfdmConOutSimCommand, "Rotate/aircraft/controls_c/ap_disc_l")

  xfdm:requestConnector("trim_pitch_up1",      xfdmConOutSimCommand, "Rotate/aircraft/controls_c/long_trim_l_sw_dn")
  xfdm:requestConnector("trim_pitch_down1",    xfdmConOutSimCommand, "Rotate/aircraft/controls_c/long_trim_l_sw_up")
  xfdm:requestConnector("trim_pitch_up2",      xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("trim_pitch_down2",    xfdmConOutSimCommand, xfdmNullLink)

  xfdm:requestConnector("trim_rudder_left1",   xfdmConOutSimCommand, "Rotate/aircraft/controls_c/rud_trim_dn")
  xfdm:requestConnector("trim_rudder_right1",  xfdmConOutSimCommand, "Rotate/aircraft/controls_c/rud_trim_up")
  xfdm:requestConnector("trim_rudder_left2",   xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("trim_rudder_right2",  xfdmConOutSimCommand, xfdmNullLink)

  xfdm:requestMapping("axis_speedbrakes",xfdmConInOtherCon, "bravo_axis_1", "reverse")

  xfdm:requestConnector("cmd_at_disc",       xfdmConOutSimCommand, "Rotate/aircraft/controls_c/ats_disc_l")
  xfdm:requestConnector("cmd_at_toga",       xfdmConOutSimCommand, "Rotate/aircraft/controls_c/to_ga")

  xfdm:requestMapping("park_brake",             xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("RMD11_park_brake_up",  xfdmConOutSimCommand, "Rotate/aircraft/controls_c/park_brake_up")
  xfdm:requestMapping("RMD11_park_brake_up",    xfdmConInButton, throttles.sw1_up)
  xfdm:requestConnector("RMD11_park_brake_dn",  xfdmConOutSimCommand, "Rotate/aircraft/controls_c/park_brake_dn")
  xfdm:requestMapping("RMD11_park_brake_dn",    xfdmConInButton, throttles.sw1_dn)

  xfdm:requestConnector("anti_ice_eng_on",     xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("anti_ice_eng_off",    xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("anti_ice_eng_1_pos",  xfdmConOutRwDataref, "Rotate/aircraft/controls/anti_ice_eng_1")
  xfdm:requestConnector("anti_ice_eng_2_pos",  xfdmConOutRwDataref, "Rotate/aircraft/controls/anti_ice_eng_2")
  xfdm:requestConnector("anti_ice_eng_3_pos",  xfdmConOutRwDataref, "Rotate/aircraft/controls/anti_ice_eng_3")
  xfdm:requestConnector("anti_ice_eng_1_tog",  xfdmConOutSimCommand, "Rotate/aircraft/controls_c/anti_ice_eng_1")
  xfdm:requestConnector("anti_ice_eng_2_tog",  xfdmConOutSimCommand, "Rotate/aircraft/controls_c/anti_ice_eng_2")
  xfdm:requestConnector("anti_ice_eng_3_tog",  xfdmConOutSimCommand, "Rotate/aircraft/controls_c/anti_ice_eng_3")
  function xfdm_set_eai()
    local tJoyOn = xfdm:readConnectorSrc("anti_ice_eng_on")

    local tCockpitPos1 = xfdm:readConnectorDest("anti_ice_eng_1_pos")
    local tCockpitPos2 = xfdm:readConnectorDest("anti_ice_eng_2_pos")
    local tCockpitPos3 = xfdm:readConnectorDest("anti_ice_eng_3_pos")

    if (tJoyOn and (tCockpitPos1 < 1)) then
      xfdm.aircrafts.rmd11:anti_ice_eng_1_tog_func()
    elseif (not(tJoyOn) and (tCockpitPos1 > 0)) then
      xfdm.aircrafts.rmd11:anti_ice_eng_1_tog_func()
    end

    if (tJoyOn and (tCockpitPos2 < 1)) then
      xfdm.aircrafts.rmd11:anti_ice_eng_2_tog_func()
    elseif (not(tJoyOn) and (tCockpitPos2 > 0)) then
      xfdm.aircrafts.rmd11:anti_ice_eng_2_tog_func()
    end

    if (tJoyOn and (tCockpitPos3 < 1)) then
      xfdm.aircrafts.rmd11:anti_ice_eng_3_tog_func()
    elseif (not(tJoyOn) and (tCockpitPos3 > 0)) then
      xfdm.aircrafts.rmd11:anti_ice_eng_3_tog_func()
    end
  end
  xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_eai()")

  xfdm:requestConnector("anti_ice_wing_on",     xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("anti_ice_wing_off",    xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("anti_ice_wing_pos",  xfdmConOutRwDataref, "Rotate/aircraft/controls/anti_ice_wing")
  xfdm:requestConnector("anti_ice_tail_pos",  xfdmConOutRwDataref, "Rotate/aircraft/controls/anti_ice_tail")
  xfdm:requestConnector("anti_ice_wing_tog",  xfdmConOutSimCommand, "Rotate/aircraft/controls_c/anti_ice_wing")
  xfdm:requestConnector("anti_ice_tail_tog",  xfdmConOutSimCommand, "Rotate/aircraft/controls_c/anti_ice_tail")
  function xfdm_set_wai()
    local tJoyOn = xfdm:readConnectorSrc("anti_ice_wing_on")

    local tCockpitPos1 = xfdm:readConnectorDest("anti_ice_wing_pos")
    local tCockpitPos2 = xfdm:readConnectorDest("anti_ice_tail_pos")

    if (tJoyOn and (tCockpitPos1 < 1)) then
      xfdm.aircrafts.rmd11:anti_ice_wing_tog_func()
    elseif (not(tJoyOn) and (tCockpitPos1 > 0)) then
      xfdm.aircrafts.rmd11:anti_ice_wing_tog_func()
    end

    if (tJoyOn and (tCockpitPos2 < 1)) then
      xfdm.aircrafts.rmd11:anti_ice_tail_tog_func()
    elseif (not(tJoyOn) and (tCockpitPos2 > 0)) then
      xfdm.aircrafts.rmd11:anti_ice_tail_tog_func()
    end
  end
  xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_wai()")


  
  xfdm:requestConnector("lights_strobe_on",  xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("lights_strobe_off", xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("strobe_light_pos",  xfdmConOutRoDataref, "Rotate/aircraft/controls/strobe_lts")
  xfdm:requestConnector("strobe_light_tog",  xfdmConOutSimCommand, "Rotate/aircraft/controls_c/strobe_lts")
  function xfdm_set_strobe_light()
    local tJoyStrobeOn = xfdm:readConnectorSrc("lights_strobe_on")
    local tStrobePos = xfdm:readConnectorDest("strobe_light_pos")

    if (tJoyStrobeOn and (tStrobePos ~= 1)) then
      xfdm.aircrafts.rmd11:strobe_light_tog_func()
    elseif (not(tJoyStrobeOn) and (tStrobePos ~= 0)) then
      xfdm.aircrafts.rmd11:strobe_light_tog_func()
    end
  end
  xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_strobe_light()")

  xfdm:requestConnector("lights_taxi_on",    xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("lights_taxi_off",   xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("lights_ldg_on",     xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("lights_ldg_off",    xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("nose_ldg_light_up", xfdmConOutSimCommand, "Rotate/aircraft/controls_c/nose_lts_up")
  xfdm:requestConnector("nose_ldg_light_dn", xfdmConOutSimCommand, "Rotate/aircraft/controls_c/nose_lts_dn")
  xfdm:requestConnector("l_ldg_light_up",    xfdmConOutSimCommand, "Rotate/aircraft/controls_c/ldg_l_lts_up")
  xfdm:requestConnector("l_ldg_light_dn",    xfdmConOutSimCommand, "Rotate/aircraft/controls_c/ldg_l_lts_dn")
  xfdm:requestConnector("r_ldg_light_up",    xfdmConOutSimCommand, "Rotate/aircraft/controls_c/ldg_r_lts_up")
  xfdm:requestConnector("r_ldg_light_dn",    xfdmConOutSimCommand, "Rotate/aircraft/controls_c/ldg_r_lts_dn")

  xfdm:requestConnector("nose_ldg_light_pos",  xfdmConOutRoDataref, "Rotate/aircraft/controls/nose_lts")
  xfdm:requestConnector("left_ldg_light_pos",  xfdmConOutRoDataref, "Rotate/aircraft/controls/ldg_l_lts")
  xfdm:requestConnector("right_ldg_light_pos", xfdmConOutRoDataref, "Rotate/aircraft/controls/ldg_r_lts")
  function xfdm_set_ldg_lights()
    local tJoyTaxiOn = xfdm:readConnectorSrc("lights_taxi_on")
    local tJoyLdgOn  = xfdm:readConnectorSrc("lights_ldg_on")

    local tSimNosePos = xfdm:readConnectorDest("nose_ldg_light_pos")
    if (tJoyLdgOn and (tSimNosePos <= 1)) then
      xfdm:driveConnectorDest("nose_ldg_light_up")
    elseif (not(tJoyLdgOn) and tJoyTaxiOn and (tSimNosePos < 1)) then
      xfdm:driveConnectorDest("nose_ldg_light_up")
    elseif (not(tJoyLdgOn) and tJoyTaxiOn and (tSimNosePos > 1)) then
      xfdm:driveConnectorDest("nose_ldg_light_dn")
    elseif (not(tJoyLdgOn) and not(tJoyTaxiOn) and (tSimNosePos >= 1)) then
      xfdm:driveConnectorDest("nose_ldg_light_dn")
    end

    local tSimLdgLeftPos = xfdm:readConnectorDest("left_ldg_light_pos")
    if (tJoyLdgOn and (tSimLdgLeftPos <= 1))  then
      xfdm:driveConnectorDest("l_ldg_light_up")
      xfdm:driveConnectorDest("l_ldg_light_up")
    elseif (not(tJoyLdgOn) and (tSimLdgLeftPos >= 1)) then
      xfdm:driveConnectorDest("l_ldg_light_dn")
      xfdm:driveConnectorDest("l_ldg_light_dn")
    end

    local tSimLdgRightPos = xfdm:readConnectorDest("right_ldg_light_pos")
    if (tJoyLdgOn and (tSimLdgRightPos <= 1))  then
      xfdm:driveConnectorDest("r_ldg_light_up")
      xfdm:driveConnectorDest("r_ldg_light_up")
    elseif (not(tJoyLdgOn) and (tSimLdgRightPos >= 1)) then
      xfdm:driveConnectorDest("r_ldg_light_dn")
      xfdm:driveConnectorDest("r_ldg_light_dn")
    end
  end
  xfdm:requestCallback(xfdmCallbackOften, "xfdm_set_ldg_lights()")

  xfdm:requestConnector("bravo_ap_dial_cw",         xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_dial_ccw",        xfdmConOutSimCommand, xfdmNullLink)
  xfdm.joysticks.honeycomb_bravo.sAccelThreshold  = 6
  xfdm.joysticks.honeycomb_bravo.sAccelMultiplier = 2
  xfdm.joysticks.honeycomb_bravo.sAccelMaxMultiplier = 2

  xfdm:requestConnector("bravo_ap_dial_hdg_cw",     xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_hdg_sel_up")
  xfdm:requestConnector("bravo_ap_dial_crs_cw",     xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_dial_alt_cw",     xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_alt_sel_up")
  xfdm:requestConnector("bravo_ap_dial_ver_cw",     xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_pitch_sel_up")
  xfdm:requestConnector("bravo_ap_dial_ias_cw",     xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_spd_sel_up")

  xfdm:requestConnector("bravo_ap_dial_hdg_ccw",    xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_hdg_sel_dn")
  xfdm:requestConnector("bravo_ap_dial_crs_ccw",    xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_dial_alt_ccw",    xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_alt_sel_dn")
  xfdm:requestConnector("bravo_ap_dial_ver_ccw",    xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_pitch_sel_dn")
  xfdm:requestConnector("bravo_ap_dial_ias_ccw",    xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_spd_sel_dn")

  xfdm:requestConnector("bravo_ap_button_hdg",      xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_nav",      xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_apr",      xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_rev",      xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_alt",      xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_vs",       xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_ias",      xfdmConOutRwDataref, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_cmd",      xfdmConOutRwDataref, xfdmNullLink)

  xfdm:requestConnector("bravo_ap_button_nav_short", xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_nav")
  xfdm:requestConnector("bravo_ap_button_hdg_short", xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_hdg_mode_sel_dn")
  xfdm:requestConnector("bravo_ap_button_apr_short", xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_appr_land")
  xfdm:requestConnector("bravo_ap_button_rev_short", xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_alt_short", xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_alt_mode_sel_dn")
  xfdm:requestConnector("bravo_ap_button_vs_short",  xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_ias_short", xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_spd_sel_mode_dn")
  xfdm:requestConnector("bravo_ap_button_cmd_short", xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_autoflight")

  xfdm:requestConnector("bravo_ap_button_hdg_long",  xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_hdg_mode_sel_up")
  xfdm:requestConnector("bravo_ap_button_nav_long",  xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_apr_long",  xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_rev_long",  xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_alt_long",  xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_alt_mode_sel_up")
  xfdm:requestConnector("bravo_ap_button_vs_long",   xfdmConOutSimCommand, xfdmNullLink)
  xfdm:requestConnector("bravo_ap_button_ias_long",  xfdmConOutSimCommand, "Rotate/aircraft/controls_c/fgs_spd_sel_mode_up")
  xfdm:requestConnector("bravo_ap_button_cmd_long",  xfdmConOutSimCommand, xfdmNullLink)

  -- xfdm:requestConnector("bravo_ap_mode_hdg",         xfdmConOutSimCommand, "1-sim/comm/HC/selectorHDG")
  -- xfdm:requestConnector("bravo_ap_mode_alt",         xfdmConOutSimCommand, "1-sim/comm/HC/selectorALT")
  -- xfdm:requestConnector("bravo_ap_mode_ver",         xfdmConOutSimCommand, "1-sim/comm/HC/selectorVS")
  -- xfdm:requestConnector("bravo_ap_mode_ias",         xfdmConOutSimCommand, "1-sim/comm/HC/selectorIAS")
  -- xfdm:requestConnector("bravo_ap_mode_crs",         xfdmConOutSimCommand, xfdmNullLink)


  function xfdm.aircrafts.rmd11:anti_ice_eng_1_tog_func() xfdm:beginConnectorDest("anti_ice_eng_1_tog") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="anti_ice_eng_1_tog"}) end
  function xfdm.aircrafts.rmd11:anti_ice_eng_2_tog_func() xfdm:beginConnectorDest("anti_ice_eng_2_tog") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="anti_ice_eng_2_tog"}) end
  function xfdm.aircrafts.rmd11:anti_ice_eng_3_tog_func() xfdm:beginConnectorDest("anti_ice_eng_3_tog") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="anti_ice_eng_3_tog"}) end

  function xfdm.aircrafts.rmd11:anti_ice_wing_tog_func() xfdm:beginConnectorDest("anti_ice_wing_tog") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="anti_ice_wing_tog"}) end
  function xfdm.aircrafts.rmd11:anti_ice_tail_tog_func() xfdm:beginConnectorDest("anti_ice_tail_tog") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="anti_ice_tail_tog"}) end

  function xfdm.aircrafts.rmd11:strobe_light_tog_func() xfdm:beginConnectorDest("strobe_light_tog") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="strobe_light_tog"}) end

  function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_hdg_short() xfdm:beginConnectorDest("bravo_ap_button_hdg_short") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_hdg_short"}) end
  function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_nav_short() xfdm:beginConnectorDest("bravo_ap_button_nav_short") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_nav_short"}) end
  function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_apr_short() xfdm:beginConnectorDest("bravo_ap_button_apr_short") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_apr_short"}) end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_rev_short() xfdm:beginConnectorDest("bravo_ap_button_rev_short") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_rev_short"}) end
  function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_alt_short() xfdm:beginConnectorDest("bravo_ap_button_alt_short") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_alt_short"}) end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_vs_short()  xfdm:beginConnectorDest("bravo_ap_button_vs_short")  table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_vs_short"}) end
  function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_ias_short() xfdm:beginConnectorDest("bravo_ap_button_ias_short") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_ias_short"}) end
  function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_cmd_short() xfdm:beginConnectorDest("bravo_ap_button_cmd_short") table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_cmd_short"}) end

  function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_hdg_long() xfdm:beginConnectorDest("bravo_ap_button_hdg_long")  table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_hdg_long"}) end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_nav_long() xfdm:beginConnectorDest("bravo_ap_button_nav_long")  table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_nav_long"}) end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_apr_long() xfdm:beginConnectorDest("bravo_ap_button_apr_long")  table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_apr_long"}) end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_rev_long() xfdm:beginConnectorDest("bravo_ap_button_rev_long")  table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_rev_long"}) end
  function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_alt_long() xfdm:beginConnectorDest("bravo_ap_button_alt_long")  table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_alt_long"}) end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_vs_long()  xfdm:beginConnectorDest("bravo_ap_button_vs_long")   table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_vs_long"}) end
  function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_ias_long() xfdm:beginConnectorDest("bravo_ap_button_ias_long")  table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_ias_long"}) end
  --function xfdm.joysticks.honeycomb_bravo:bravo_ap_button_cmd_long() xfdm:beginConnectorDest("bravo_ap_button_cmd_long")  table.insert(xfdm.aircrafts.rmd11.pushPullEndQueue, {cName="bravo_ap_button_cmd_long"}) end

  function xfdm.aircrafts.rmd11:apButtonRunner()
    if table.getn(xfdm.aircrafts.rmd11.pushPullEndQueue) ~= 0 then
        local tCurrentTime = get("sim/time/total_running_time_sec")

        if (tCurrentTime - xfdm.lastBeginTime > 0.35) then
          --logMsg(lastFFa320ButtonTime)
          --logMsg(tprint(xfdm.aircrafts.rmd11.pushPullEndQueue))
          for k,v in pairs(xfdm.aircrafts.rmd11.pushPullEndQueue) do
            --logMsg(v.cName)
            xfdm:endConnectorDest(v.cName)
          end
          xfdm.aircrafts.rmd11.pushPullEndQueue = nil
          xfdm.aircrafts.rmd11.pushPullEndQueue = {}
        end
    end
  end
  xfdm:requestCallback(xfdmCallbackAlways, "xfdm.aircrafts.rmd11:apButtonRunner()")

end