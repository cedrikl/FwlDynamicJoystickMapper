--SSG 747-8

function ChampBravoEngine_B748_SSG()

end

function ChampBravoMapping_B748_SSG()
  function bravo_Ap_AltInc(numticks) bravo_command_multiple("SSG/UFMC/Alt_UP", numticks) end
  function bravo_Ap_AltDec(numticks) bravo_command_multiple("SSG/UFMC/Alt_Down", numticks) end
  function bravo_Ap_VsInc(numticks)  bravo_command_multiple("SSG/UFMC/VS_UP", numticks) end
  function bravo_Ap_VsDec(numticks)  bravo_command_multiple("SSG/UFMC/VS_Down", numticks) end
  function bravo_Ap_HdgInc(numticks) bravo_command_multiple("SSG/UFMC/HDG_UP", numticks) end
  function bravo_Ap_HdgDec(numticks) bravo_command_multiple("SSG/UFMC/HDG_Down", numticks) end
  function bravo_Ap_IasInc(numticks) bravo_command_multiple("SSG/UFMC/Speed_UP", numticks) end
  function bravo_Ap_IasDec(numticks) bravo_command_multiple("SSG/UFMC/Speed_Down", numticks) end


  set_button_assignment(btq.ap_hdg,    "sim/none/none")
  function apPanelCockpitHdgShort(status) 
    if (status == "begin") then command_begin("SSG/UFMC/AP_HDG_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_HDG_Button") end
  end
  function apPanelCockpitHdgLong(status) 
    if (status == "begin") then command_begin("SSG/UFMC/AP_HDGHOLD_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_HDGHOLD_Button") end
  end

  set_button_assignment(btq.ap_nav,    "sim/none/none")
  function apPanelCockpitNavShort(status) 
    if (status == "begin") then command_begin("SSG/UFMC/AP_LNAV_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_LNAV_Button") end
  end
  function apPanelCockpitNavLong(status) 
    if (status == "begin") then command_begin("SSG/UFMC/AP_VNAV_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_VNAV_Button") end
  end

  set_button_assignment(btq.ap_apr,    "sim/none/none")
  function apPanelCockpitAprShort(status) 
    if (status == "begin") then command_begin("SSG/UFMC/AP_APP_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_APP_Button") end
  end
  function apPanelCockpitAprLong(status) 
    if (status == "begin") then command_begin("SSG/UFMC/AP_VORLOC_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_VORLOC_Button") end
  end

  --set_button_assignment(btq.ap_rev,    "sim/none/none")
  --function apPanelCockpitRevShort(status)    end
  --function apPanelCockpitRevLong(status)     end

  set_button_assignment(btq.ap_alt,    "sim/none/none")
  function apPanelCockpitAltShort(status)
    if (status == "begin") then command_begin("SSG/UFMC/AP_LVLCHG_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_LVLCHG_Button") end
  end
  function apPanelCockpitAltLong(status)
    if (status == "begin") then command_begin("sim/autopilot/altitude_hold") elseif (status == "end") then command_end("sim/autopilot/altitude_hold") end
  end

  set_button_assignment(btq.ap_vs,     "SSG/UFMC/AP_VS_Button")
  --function apPanelCockpitVsShort(status)
  --  if (status == "begin") then command_begin(") elseif (status == "end") then command_end("") end
  --end
  --function apPanelCockpitVsLong(status)
  --  if (status == "begin") then command_begin("") elseif (status == "end") then command_end("") end
  --end

  set_button_assignment(btq.ap_ias,    "sim/none/none")
  function apPanelCockpitIasShort(status)
    if (status == "begin") then command_begin("SSG/UFMC/AP_SPD_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_SPD_Button") end
  end
  function apPanelCockpitIasLong(status)
    if (status == "begin") then command_begin("SSG/UFMC/AP_N1_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_N1_Button") end
  end

  set_button_assignment(btq.ap_master, "sim/none/none")
  function apPanelCockpitMasterShort(status)
    if (status == "begin") then command_begin("SSG/UFMC/AP_CMDA_Button") elseif (status == "end") then command_end("SSG/UFMC/AP_CMDA_Button") end
  end
  function apPanelCockpitMasterLong(status)
    if (status == "begin") then command_begin("SSG/UFMC/AP_ARM_AT_Switch") elseif (status == "end") then command_end("SSG/UFMC/AP_ARM_AT_Switch") end
  end

  do_every_frame("apPanelDualHandler()")


  set_button_assignment(btq.axis12_2nd_func, "SSG/UFMC/AT_Discon")
  set_button_assignment(btq.axis3_2nd_func,  "SSG/UFMC/TOGA_Button")

  set_button_assignment(btq.sw2_up, "sim/none/none")
  set_button_assignment(btq.sw2_dn, "sim/none/none")
  do_often([[
    Eng1Pos = get("ssg/ICE/ice_eng1_sw")
    Eng2Pos = get("ssg/ICE/ice_eng2_sw")
    Eng3Pos = get("ssg/ICE/ice_eng3_sw")
    Eng4Pos = get("ssg/ICE/ice_eng4_sw")
    SwPos2 = button(]]..btq.sw2_up..[[)
    
    if (SwPos2 and (Eng1Pos ~= 2)) then
      set("ssg/ICE/ice_eng1_sw", 2)
    elseif (not(SwPos2) and (Eng1Pos >= 2)) then
      set("ssg/ICE/ice_eng1_sw", 1)
    end
    
    if (SwPos2 and (Eng2Pos ~= 2)) then
      set("ssg/ICE/ice_eng2_sw", 2)
    elseif (not(SwPos2) and (Eng2Pos >= 2)) then
      set("ssg/ICE/ice_eng2_sw", 1)
    end

    if (SwPos2 and (Eng3Pos ~= 2)) then
      set("ssg/ICE/ice_eng3_sw", 2)
    elseif (not(SwPos2) and (Eng3Pos >= 2)) then
      set("ssg/ICE/ice_eng3_sw", 1)
    end

    if (SwPos2 and (Eng4Pos ~= 2)) then
      set("ssg/ICE/ice_eng4_sw", 2)
    elseif (not(SwPos2) and (Eng4Pos >= 2)) then
      set("ssg/ICE/ice_eng4_sw", 1)
    end
  ]])
  
  set_button_assignment(btq.sw3_up, "sim/none/none")
  set_button_assignment(btq.sw3_dn, "sim/none/none")
    do_often([[
    Eng1Pos = get("ssg/ICE/ice_wing_sw")
    SwPos3 = button(]]..btq.sw3_up..[[)
    
    if (SwPos3 and (Eng1Pos ~= 2)) then
      set("ssg/ICE/ice_wing_sw", 2)
    elseif (not(SwPos3) and (Eng1Pos >= 2)) then
      set("ssg/ICE/ice_wing_sw", 1)
    end
  ]])

  set_button_assignment(btq.sw5_up, "sim/none/none")
  set_button_assignment(btq.sw5_dn, "sim/none/none")
  do_often([[
       SwPos5 = button(]]..btq.sw5_up..[[)
 
      if (SwPos5) then
        set("ssg/LGT/lgt_stb_sw", 1)
      elseif (not(SwPos5)) then
        set("ssg/LGT/lgt_stb_sw", 0)
      end
    ]])
  set_button_assignment(btq.sw6_up,    "sim/none/none")
  set_button_assignment(btq.sw6_dn,    "sim/none/none")
  do_often([[
    SwPos6 = button(]]..btq.sw6_up..[[)
    
    if (SwPos6) then
      set("ssg/LGT/lgt_taxi_sw", 1)
    elseif (not(SwPos6)) then
      set("ssg/LGT/lgt_taxi_sw", 0)
    end
  ]]) 
  
  set_button_assignment(btq.sw7_up,    "sim/none/none")
  set_button_assignment(btq.sw7_dn,    "sim/none/none")
  do_often([[
    INL_Pos =  get("ssg/LGT/lgt_inL_sw")
    INR_Pos =  get("ssg/LGT/lgt_inR_sw")
    OUTL_Pos = get("ssg/LGT/lgt_outL_sw")
    OUTR_Pos = get("ssg/LGT/lgt_outR_sw")
    SwPos7 = button(]]..btq.sw7_up..[[)
    
    if (SwPos7 and (INL_Pos ~= 1)) then
      command_once("SSG/Lights/Land_INL")
    elseif (not(SwPos7) and (INL_Pos ~= 0)) then
      command_once("SSG/Lights/Land_INL")
    end

    if (SwPos7 and (INR_Pos ~= 1)) then
      command_once("SSG/Lights/Land_INR")
    elseif (not(SwPos7) and (INR_Pos ~= 0)) then
      command_once("SSG/Lights/Land_INR")
    end

    if (SwPos7 and (OUTL_Pos ~= 1)) then
      command_once("SSG/Lights/Land_OUTL")
    elseif (not(SwPos7) and (OUTL_Pos ~= 0)) then
      command_once("SSG/Lights/Land_OUTL")
    end

    if (SwPos7 and (OUTR_Pos ~= 1)) then
      command_once("SSG/Lights/Land_OUTR")
    elseif (not(SwPos7) and (OUTR_Pos ~= 0)) then
      command_once("SSG/Lights/Land_OUTR")
    end
  ]])  
end


function ChampBravoLed_B748_SSG()
end


function ChampBravoCheck_B748_SSG()
  if (--AP Panel rotary
      XPLMFindCommand("SSG/UFMC/Alt_UP")                         ~= nil and
      XPLMFindCommand("SSG/UFMC/Alt_Down")                       ~= nil and
      XPLMFindCommand("SSG/UFMC/VS_UP")                          ~= nil and
      XPLMFindCommand("SSG/UFMC/VS_Down")                        ~= nil and
      XPLMFindCommand("SSG/UFMC/HDG_UP")                         ~= nil and
      XPLMFindCommand("SSG/UFMC/HDG_Down")                       ~= nil and
      XPLMFindCommand("SSG/UFMC/Speed_UP")                       ~= nil and
      XPLMFindCommand("SSG/UFMC/Speed_Down")                     ~= nil and
      --AP Panel Buttons
      XPLMFindCommand("SSG/UFMC/AP_HDG_Button")                  ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_HDGHOLD_Button")              ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_LNAV_Button")                 ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_VNAV_Button")                 ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_APP_Button")                  ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_VORLOC_Button")               ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_discon_Button")               ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_VS_Button")                   ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_LVLCHG_Button")               ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_SPD_Button")                  ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_N1_Button")                   ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_CMDA_Button")                 ~= nil and
      XPLMFindCommand("SSG/UFMC/AP_ARM_AT_Switch")               ~= nil and
      --Axis
      XPLMFindCommand("SSG/UFMC/AT_Discon")                      ~= nil and
      XPLMFindCommand("SSG/UFMC/TOGA_Button")                    ~= nil and
      --Switches
      XPLMFindDataRef("ssg/ICE/ice_eng1_sw")                     ~= nil and
      XPLMFindDataRef("ssg/ICE/ice_eng2_sw")                     ~= nil and
      XPLMFindDataRef("ssg/ICE/ice_eng3_sw")                     ~= nil and
      XPLMFindDataRef("ssg/ICE/ice_eng4_sw")                     ~= nil and
      XPLMFindDataRef("ssg/ICE/ice_wing_sw")                     ~= nil and
      XPLMFindDataRef("ssg/LGT/lgt_stb_sw")                      ~= nil and
      XPLMFindDataRef("ssg/LGT/lgt_taxi_sw")                     ~= nil and
      XPLMFindDataRef("ssg/LGT/lgt_inL_sw")                      ~= nil and
      XPLMFindDataRef("ssg/LGT/lgt_inL_sw")                      ~= nil and
      XPLMFindDataRef("ssg/LGT/lgt_outL_sw")                     ~= nil and
      XPLMFindDataRef("ssg/LGT/lgt_outR_sw")                     ~= nil and
      XPLMFindCommand("SSG/Lights/Land_INL")                     ~= nil and
      XPLMFindCommand("SSG/Lights/Land_INR")                     ~= nil and
      XPLMFindCommand("SSG/Lights/Land_OUTL")                    ~= nil and
      XPLMFindCommand("SSG/Lights/Land_OUTR")                    ~= nil
     ) then return true
  else
    return false
  end
end
