require("xfdm.joysticks.honeycomb_bravo")
local bit = require("bit")

xfdm.joysticks.honeycomb_bravo.leds = {}
xfdm.joysticks.honeycomb_bravo.leds.nobr      = 0
xfdm.joysticks.honeycomb_bravo.leds.report_ID = 0
xfdm.joysticks.honeycomb_bravo.leds.bravo_pointer = 0

--USB Registers (32bits, DCBA)
xfdm.joysticks.honeycomb_bravo.leds.raw = 0
xfdm.joysticks.honeycomb_bravo.leds.raw_old = 0

--Block A
xfdm.joysticks.honeycomb_bravo.leds.HEADING          = (2^00)
xfdm.joysticks.honeycomb_bravo.leds.NAV              = (2^01)
xfdm.joysticks.honeycomb_bravo.leds.APR              = (2^02)
xfdm.joysticks.honeycomb_bravo.leds.REV              = (2^03)
xfdm.joysticks.honeycomb_bravo.leds.ALT              = (2^04)
xfdm.joysticks.honeycomb_bravo.leds.VS               = (2^05)
xfdm.joysticks.honeycomb_bravo.leds.IAS              = (2^06)
xfdm.joysticks.honeycomb_bravo.leds.AP               = (2^07)
--Block B
xfdm.joysticks.honeycomb_bravo.leds.LEFT_GEAR_GREEN  = (2^08)
xfdm.joysticks.honeycomb_bravo.leds.LEFT_GEAR_RED    = (2^09)
xfdm.joysticks.honeycomb_bravo.leds.NOSE_GEAR_GREEN  = (2^10)
xfdm.joysticks.honeycomb_bravo.leds.NOSE_GEAR_RED    = (2^11)
xfdm.joysticks.honeycomb_bravo.leds.RIGHT_GEAR_GREEN = (2^12)
xfdm.joysticks.honeycomb_bravo.leds.RIGHT_GEAR_RED   = (2^13)
xfdm.joysticks.honeycomb_bravo.leds.MASTER_WARNING   = (2^14)
xfdm.joysticks.honeycomb_bravo.leds.ENGINE_FIRE      = (2^15)
--Block C
xfdm.joysticks.honeycomb_bravo.leds.LOW_OIL_PRESS    = (2^16)
xfdm.joysticks.honeycomb_bravo.leds.LOW_FUEL_PRESS   = (2^17)
xfdm.joysticks.honeycomb_bravo.leds.ANTI_ICE         = (2^18)
xfdm.joysticks.honeycomb_bravo.leds.STARTER          = (2^19)
xfdm.joysticks.honeycomb_bravo.leds.APU              = (2^20)
xfdm.joysticks.honeycomb_bravo.leds.MASTER_CAUTION   = (2^21)
xfdm.joysticks.honeycomb_bravo.leds.VACUUM           = (2^22)
xfdm.joysticks.honeycomb_bravo.leds.LOW_HYD_PRESS    = (2^23)
--Block D
xfdm.joysticks.honeycomb_bravo.leds.FUEL_PUMP        = (2^24)
xfdm.joysticks.honeycomb_bravo.leds.PARKING_BRAKE    = (2^25)
xfdm.joysticks.honeycomb_bravo.leds.LOW_VOLTS        = (2^26)
xfdm.joysticks.honeycomb_bravo.leds.DOOR             = (2^27)


define_shared_DataRef("xfdm/joysticks/bravo/leds/ap_hdg",     "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/ap_nav",     "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/ap_apr",     "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/ap_rev",     "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/ap_alt",     "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/ap_vs",      "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/ap_ias",     "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/ap_cmd",     "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/lgg",        "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/lgr",        "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/ngg",        "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/ngr",        "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/rgg",        "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/rgr",        "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/mwar",       "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/fire",       "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/oil",        "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/fuelp",      "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/ice",        "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/start",      "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/apu",        "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/mcau",       "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/vac",        "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/hyd",        "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/pump",       "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/park_brake", "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/low_batt",   "Int")
define_shared_DataRef("xfdm/joysticks/bravo/leds/door",       "Int")

set("xfdm/joysticks/bravo/leds/ap_hdg",     0)
set("xfdm/joysticks/bravo/leds/ap_nav",     0)
set("xfdm/joysticks/bravo/leds/ap_apr",     0)
set("xfdm/joysticks/bravo/leds/ap_rev",     0)
set("xfdm/joysticks/bravo/leds/ap_alt",     0)
set("xfdm/joysticks/bravo/leds/ap_vs",      0)
set("xfdm/joysticks/bravo/leds/ap_ias",     0)
set("xfdm/joysticks/bravo/leds/ap_cmd",     0)
set("xfdm/joysticks/bravo/leds/lgg",        0)
set("xfdm/joysticks/bravo/leds/lgr",        0)
set("xfdm/joysticks/bravo/leds/ngg",        0)
set("xfdm/joysticks/bravo/leds/ngr",        0)
set("xfdm/joysticks/bravo/leds/rgg",        0)
set("xfdm/joysticks/bravo/leds/rgr",        0)
set("xfdm/joysticks/bravo/leds/mwar",       0)
set("xfdm/joysticks/bravo/leds/fire",       0)
set("xfdm/joysticks/bravo/leds/oil",        0)
set("xfdm/joysticks/bravo/leds/fuelp",      0)
set("xfdm/joysticks/bravo/leds/ice",        0)
set("xfdm/joysticks/bravo/leds/start",      0)
set("xfdm/joysticks/bravo/leds/apu",        0)
set("xfdm/joysticks/bravo/leds/mcau",       0)
set("xfdm/joysticks/bravo/leds/vac",        0)
set("xfdm/joysticks/bravo/leds/hyd",        0)
set("xfdm/joysticks/bravo/leds/pump",       0)
set("xfdm/joysticks/bravo/leds/park_brake", 0)
set("xfdm/joysticks/bravo/leds/low_batt",   0)
set("xfdm/joysticks/bravo/leds/door",       0)

xfdm:requestConnector("bravo_led_hdg",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/ap_hdg")
xfdm:requestConnector("bravo_led_nav",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/ap_nav")
xfdm:requestConnector("bravo_led_apr",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/ap_apr")
xfdm:requestConnector("bravo_led_rev",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/ap_rev")
xfdm:requestConnector("bravo_led_alt",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/ap_alt")
xfdm:requestConnector("bravo_led_vs",    xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/ap_vs")
xfdm:requestConnector("bravo_led_ias",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/ap_ias")
xfdm:requestConnector("bravo_led_ap",    xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/ap_cmd")
xfdm:requestConnector("bravo_led_lgg",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/lgg")
xfdm:requestConnector("bravo_led_lgr",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/lgr")
xfdm:requestConnector("bravo_led_ngg",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/ngg")
xfdm:requestConnector("bravo_led_ngr",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/ngr")
xfdm:requestConnector("bravo_led_rgg",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/rgg")
xfdm:requestConnector("bravo_led_rgr",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/rgr")
xfdm:requestConnector("bravo_led_mwar",  xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/mwar")
xfdm:requestConnector("bravo_led_fire",  xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/fire")
xfdm:requestConnector("bravo_led_oil",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/oil")
xfdm:requestConnector("bravo_led_fuelp", xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/fuelp")
xfdm:requestConnector("bravo_led_ice",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/ice")
xfdm:requestConnector("bravo_led_start", xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/start")
xfdm:requestConnector("bravo_led_apu",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/apu")
xfdm:requestConnector("bravo_led_mcau",  xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/mcau")
xfdm:requestConnector("bravo_led_vac",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/vac")
xfdm:requestConnector("bravo_led_hyd",   xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/hyd")
xfdm:requestConnector("bravo_led_pump",  xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/pump")
xfdm:requestConnector("bravo_led_park",  xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/park_brake")
xfdm:requestConnector("bravo_led_batt",  xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/low_batt")
xfdm:requestConnector("bravo_led_door",  xfdmConOutRwDataref, "xfdm/joysticks/bravo/leds/door")

function xfdm.joysticks.honeycomb_bravo.leds:runner()
  -- A C pointer from HIDAPI
  self.bravo_pointer = hid_open(0x294B, 0x1901)

  if self.bravo_pointer == nil then
    logMsg("XFDM - xfdm.joysticks.honeycomb_bravo.leds:runner(ERROR): Oh, no! We can't access our Bravo Throttle directly")
    hid_close(self.bravo_pointer)
  else
    self.novw=5
    self.nobr, self.report_ID, variable1, variable2, variable3, variable4, variable5 = hid_get_feature_report(self.bravo_pointer, self.novw)
    --logMsg(nobr)
    --logMsg(report_ID)
    --logMsg(string.format("%x", variable1))
    --logMsg(string.format("%x", variable2))
    --logMsg(string.format("%x", variable3))
    --logMsg(string.format("%x", variable4))
    --logMsg(string.format("%x", variable5))
  end

  if ((self.nobr ~= 0) and (self.report_ID ~= 0)) then
    xfdm:requestCallback(xfdmCallbackOften, "xfdm.joysticks.honeycomb_bravo.leds:update()")
    do_on_exit("xfdm.joysticks.honeycomb_bravo.leds:shutdown()")
  end
end


function xfdm.joysticks.honeycomb_bravo.leds:led_set(mask)
  self.raw = bit.bor(self.raw, mask)
end

function xfdm.joysticks.honeycomb_bravo.leds:led_clear(mask)
  self.raw = bit.band(self.raw, bit.bnot(mask))
end

function xfdm.joysticks.honeycomb_bravo.leds:led_toggle(mask)
  self.raw = bit.bxor(self.raw, mask)
end

function xfdm.joysticks.honeycomb_bravo.leds:led_check(iBool, iLight)
  if (iBool == 1) then
    self:led_set(iLight)
  else
    self:led_clear(iLight)
  end
end

function xfdm.joysticks.honeycomb_bravo.leds:checkPower()
  if((xfdm:readConnectorDest("elec_bus_voltage", 0) < 3.3) and
     (xfdm:readConnectorDest("elec_bus_voltage", 1) < 3.3) and
     (xfdm:readConnectorDest("elec_bus_voltage", 2) < 3.3) and
     (xfdm:readConnectorDest("elec_bus_voltage", 3) < 3.3) and
     (xfdm:readConnectorDest("elec_bus_voltage", 4) < 3.3) and
     (xfdm:readConnectorDest("elec_bus_voltage", 5) < 3.3)
   ) then self.raw = 0
  end
end

function xfdm.joysticks.honeycomb_bravo.leds:updateRaw()
  self:led_check(xfdm:readConnectorDest("bravo_led_hdg"),   self.HEADING)
  self:led_check(xfdm:readConnectorDest("bravo_led_nav"),   self.NAV)
  self:led_check(xfdm:readConnectorDest("bravo_led_apr"),   self.APR)
  self:led_check(xfdm:readConnectorDest("bravo_led_rev"),   self.REV)
  self:led_check(xfdm:readConnectorDest("bravo_led_alt"),   self.ALT)
  self:led_check(xfdm:readConnectorDest("bravo_led_vs"),    self.VS)
  self:led_check(xfdm:readConnectorDest("bravo_led_ias"),   self.IAS)
  self:led_check(xfdm:readConnectorDest("bravo_led_ap"),    self.AP)
  self:led_check(xfdm:readConnectorDest("bravo_led_lgg"),   self.LEFT_GEAR_GREEN)
  self:led_check(xfdm:readConnectorDest("bravo_led_lgr"),   self.LEFT_GEAR_RED)
  self:led_check(xfdm:readConnectorDest("bravo_led_ngg"),   self.NOSE_GEAR_GREEN)
  self:led_check(xfdm:readConnectorDest("bravo_led_ngr"),   self.NOSE_GEAR_RED)
  self:led_check(xfdm:readConnectorDest("bravo_led_rgg"),   self.RIGHT_GEAR_GREEN)
  self:led_check(xfdm:readConnectorDest("bravo_led_rgr"),   self.RIGHT_GEAR_RED)
  self:led_check(xfdm:readConnectorDest("bravo_led_mwar"),  self.MASTER_WARNING)
  self:led_check(xfdm:readConnectorDest("bravo_led_fire"),  self.ENGINE_FIRE)
  self:led_check(xfdm:readConnectorDest("bravo_led_oil"),   self.LOW_OIL_PRESS)
  self:led_check(xfdm:readConnectorDest("bravo_led_fuelp"), self.LOW_FUEL_PRESS)
  self:led_check(xfdm:readConnectorDest("bravo_led_ice"),   self.ANTI_ICE)
  self:led_check(xfdm:readConnectorDest("bravo_led_start"), self.STARTER)
  self:led_check(xfdm:readConnectorDest("bravo_led_apu"),   self.APU)
  self:led_check(xfdm:readConnectorDest("bravo_led_mcau"),  self.MASTER_CAUTION)
  self:led_check(xfdm:readConnectorDest("bravo_led_vac"),   self.VACUUM)
  self:led_check(xfdm:readConnectorDest("bravo_led_hyd"),   self.LOW_HYD_PRESS)
  self:led_check(xfdm:readConnectorDest("bravo_led_pump"),  self.FUEL_PUMP)
  self:led_check(xfdm:readConnectorDest("bravo_led_park"),  self.PARKING_BRAKE)
  self:led_check(xfdm:readConnectorDest("bravo_led_batt"),  self.LOW_VOLTS)
  self:led_check(xfdm:readConnectorDest("bravo_led_door"),  self.DOOR)
end

function xfdm.joysticks.honeycomb_bravo.leds:writeUsb()
  if (self.raw_old ~= self.raw) then
    local block_A = bit.band(0xff, bit.rshift(self.raw, 8*0))
    local block_B = bit.band(0xff, bit.rshift(self.raw, 8*1))
    local block_C = bit.band(0xff, bit.rshift(self.raw, 8*2))
    local block_D = bit.band(0xff, bit.rshift(self.raw, 8*3))
    hid_send_feature_report(self.bravo_pointer, self.report_ID, block_A, block_B, block_C, block_D)
    self.raw_old = self.raw
  end
end

function xfdm.joysticks.honeycomb_bravo.leds:shutdown()
  self.raw = 0
  self:writeUsb()
  hid_close(self.bravo_pointer)
end

function xfdm.joysticks.honeycomb_bravo.leds:update()
  self:updateRaw()
  self:checkPower()
  self:writeUsb()
end

function xfdm.joysticks.honeycomb_bravo.leds:checkHdg()
  if (xfdm:readConnectorDest("ap_hdg_mode") == 1) then
    xfdm:driveConnectorDest("bravo_led_hdg", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_hdg", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkHdg()")

function xfdm.joysticks.honeycomb_bravo.leds:checkNav()
  if (xfdm:readConnectorDest("ap_nav_mode") == 1) then
    xfdm:driveConnectorDest("bravo_led_nav", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_nav", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkNav()")

function xfdm.joysticks.honeycomb_bravo.leds:checkApr()
  if (xfdm:readConnectorDest("ap_apr_mode") >= 1) then
    xfdm:driveConnectorDest("bravo_led_apr", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_apr", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkApr()")

function xfdm.joysticks.honeycomb_bravo.leds:checkRev()
  if (xfdm:readConnectorDest("ap_backcrs_mode") >= 1) then
    xfdm:driveConnectorDest("bravo_led_rev", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_rev", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkRev()")

function xfdm.joysticks.honeycomb_bravo.leds:checkApAlt()
  if (xfdm:readConnectorDest("ap_alt_mode") >= 1) then
    xfdm:driveConnectorDest("bravo_led_alt", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_alt", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkApAlt()")

function xfdm.joysticks.honeycomb_bravo.leds:checkApVs()
  if (xfdm:readConnectorDest("ap_vs_mode") >= 1) then
    xfdm:driveConnectorDest("bravo_led_vs", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_vs", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkApVs()")

function xfdm.joysticks.honeycomb_bravo.leds:checkApSpeed()
  if (xfdm:readConnectorDest("ap_ias_mode") >= 1) then
    xfdm:driveConnectorDest("bravo_led_ias", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_ias", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkApSpeed()")

function xfdm.joysticks.honeycomb_bravo.leds:checkApMaster()
  if (xfdm:readConnectorDest("ap_master") >= 1) then
    xfdm:driveConnectorDest("bravo_led_ap", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_ap", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkApMaster()")

function xfdm.joysticks.honeycomb_bravo.leds:checkNoseGear()
  if (xfdm:readConnectorDest("ldg_gear_pos", 0) == 1) then
    xfdm:driveConnectorDest("bravo_led_ngg", nil, 1)
    xfdm:driveConnectorDest("bravo_led_ngr", nil, 0)
  elseif ((xfdm:readConnectorDest("ldg_gear_pos", 0) < 1) and (xfdm:readConnectorDest("ldg_gear_pos", 0) > 0)) then
    xfdm:driveConnectorDest("bravo_led_ngg", nil, 0)
    xfdm:driveConnectorDest("bravo_led_ngr", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_ngg", nil, 0)
    xfdm:driveConnectorDest("bravo_led_ngr", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkNoseGear()")

function xfdm.joysticks.honeycomb_bravo.leds:checkLeftGear()
  if (xfdm:readConnectorDest("ldg_gear_pos", 1) == 1) then
    xfdm:driveConnectorDest("bravo_led_lgg", nil, 1)
    xfdm:driveConnectorDest("bravo_led_lgr", nil, 0)
  elseif ((xfdm:readConnectorDest("ldg_gear_pos", 1) < 1) and (xfdm:readConnectorDest("ldg_gear_pos", 1) > 0)) then
    xfdm:driveConnectorDest("bravo_led_lgg", nil, 0)
    xfdm:driveConnectorDest("bravo_led_lgr", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_lgg", nil, 0)
    xfdm:driveConnectorDest("bravo_led_lgr", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkLeftGear()")

function xfdm.joysticks.honeycomb_bravo.leds:checkRightGear()
  if (xfdm:readConnectorDest("ldg_gear_pos", 2) == 1) then
    xfdm:driveConnectorDest("bravo_led_rgg", nil, 1)
    xfdm:driveConnectorDest("bravo_led_rgr", nil, 0)
  elseif ((xfdm:readConnectorDest("ldg_gear_pos", 2) < 1) and (xfdm:readConnectorDest("ldg_gear_pos", 2) > 0)) then
    xfdm:driveConnectorDest("bravo_led_rgg", nil, 0)
    xfdm:driveConnectorDest("bravo_led_rgr", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_rgg", nil, 0)
    xfdm:driveConnectorDest("bravo_led_rgr", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkRightGear()")

function xfdm.joysticks.honeycomb_bravo.leds:checkMasterWarning()
  if (xfdm:readConnectorDest("annun_master_warning") == 1) then
    xfdm:driveConnectorDest("bravo_led_mwar", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_mwar", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkMasterWarning()")

function xfdm.joysticks.honeycomb_bravo.leds:checkFire()
  if ((xfdm:readConnectorDest("annun_fire", 0) == 1) or
      (xfdm:readConnectorDest("annun_fire", 1) == 1) or
      (xfdm:readConnectorDest("annun_fire", 2) == 1) or
      (xfdm:readConnectorDest("annun_fire", 3) == 1)
     ) then
    xfdm:driveConnectorDest("bravo_led_fire", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_fire", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkFire()")

function xfdm.joysticks.honeycomb_bravo.leds:checkOil()
  if ((xfdm:readConnectorDest("annun_oil_press", 0) == 1) or
      (xfdm:readConnectorDest("annun_oil_press", 1) == 1) or
      (xfdm:readConnectorDest("annun_oil_press", 2) == 1) or
      (xfdm:readConnectorDest("annun_oil_press", 3) == 1)
     ) then
    xfdm:driveConnectorDest("bravo_led_oil", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_oil", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkOil()")

function xfdm.joysticks.honeycomb_bravo.leds:checkFuel()
  if ((xfdm:readConnectorDest("annun_fuel_press", 0) == 1) or
      (xfdm:readConnectorDest("annun_fuel_press", 1) == 1) or
      (xfdm:readConnectorDest("annun_fuel_press", 2) == 1) or
      (xfdm:readConnectorDest("annun_fuel_press", 3) == 1)
     ) then
    xfdm:driveConnectorDest("bravo_led_fuelp", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_fuelp", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkFuel()")

function xfdm.joysticks.honeycomb_bravo.leds:checkAntiIce()
  if ((xfdm:readConnectorDest("anti_ice_engine", 0) == 1) or
      (xfdm:readConnectorDest("anti_ice_engine", 1) == 1) or
      (xfdm:readConnectorDest("anti_ice_engine", 2) == 1) or
      (xfdm:readConnectorDest("anti_ice_engine", 3) == 1) or
      (xfdm:readConnectorDest("anti_ice_wing") == 1) or
      (xfdm:readConnectorDest("anti_ice_wing_left") == 1) or
      (xfdm:readConnectorDest("anti_ice_wing_right") == 1)
     ) then
    xfdm:driveConnectorDest("bravo_led_ice", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_ice", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkAntiIce()")

function xfdm.joysticks.honeycomb_bravo.leds:checkStart()
  if ((xfdm:readConnectorDest("starters", 0) == 1) or
      (xfdm:readConnectorDest("starters", 1) == 1) or
      (xfdm:readConnectorDest("starters", 2) == 1) or
      (xfdm:readConnectorDest("starters", 3) == 1)
     ) then
    xfdm:driveConnectorDest("bravo_led_start", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_start", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkStart()")

function xfdm.joysticks.honeycomb_bravo.leds:checkApu()
  if (xfdm:readConnectorDest("apu_state") == 1) then
    xfdm:driveConnectorDest("bravo_led_apu", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_apu", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkApu()")

function xfdm.joysticks.honeycomb_bravo.leds:checkMasterCaution()
  if (xfdm:readConnectorDest("annun_master_caution") == 1) then
    xfdm:driveConnectorDest("bravo_led_mcau", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_mcau", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkMasterCaution()")

function xfdm.joysticks.honeycomb_bravo.leds:checkVac()
  if (xfdm:readConnectorDest("annun_vacuum") == 1) then
    xfdm:driveConnectorDest("bravo_led_vac", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_vac", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkVac()")

function xfdm.joysticks.honeycomb_bravo.leds:checkHyd()
  if (xfdm:readConnectorDest("annun_hydpress") == 1) then
    xfdm:driveConnectorDest("bravo_led_hyd", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_hyd", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkHyd()")

function xfdm.joysticks.honeycomb_bravo.leds:checkPump()
  if ((xfdm:readConnectorDest("annun_pump_l") == 1) or
      (xfdm:readConnectorDest("annun_pump_r") == 1)
    ) then
    xfdm:driveConnectorDest("bravo_led_pump", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_pump", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkPump()")

function xfdm.joysticks.honeycomb_bravo.leds:checkPark()
  if (xfdm:readConnectorDest("annun_parkbrake") == 1) then
    xfdm:driveConnectorDest("bravo_led_park", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_park", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkPark()")

function xfdm.joysticks.honeycomb_bravo.leds:checkBat()
  if (xfdm:readConnectorDest("annun_low_volt") == 1) then
    xfdm:driveConnectorDest("bravo_led_batt", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_batt", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkBat()")

function xfdm.joysticks.honeycomb_bravo.leds:checkDoor()
  if ((xfdm:readConnectorDest("annun_door", 00) == 1) or
      (xfdm:readConnectorDest("annun_door", 01) == 1) or
      (xfdm:readConnectorDest("annun_door", 02) == 1) or
      (xfdm:readConnectorDest("annun_door", 03) == 1) or
      (xfdm:readConnectorDest("annun_door", 04) == 1) or
      (xfdm:readConnectorDest("annun_door", 05) == 1) or
      (xfdm:readConnectorDest("annun_door", 06) == 1) or
      (xfdm:readConnectorDest("annun_door", 07) == 1) or
      (xfdm:readConnectorDest("annun_door", 08) == 1) or
      (xfdm:readConnectorDest("annun_door", 09) == 1) or
      (xfdm:readConnectorDest("annun_door", 10) == 1) or
      (xfdm:readConnectorDest("annun_door", 11) == 1) or
      (xfdm:readConnectorDest("annun_door", 12) == 1) or
      (xfdm:readConnectorDest("annun_door", 13) == 1) or
      (xfdm:readConnectorDest("annun_door", 14) == 1) or
      (xfdm:readConnectorDest("annun_door", 15) == 1) or
      (xfdm:readConnectorDest("annun_door", 16) == 1) or
      (xfdm:readConnectorDest("annun_door", 17) == 1) or
      (xfdm:readConnectorDest("annun_door", 18) == 1) or
      (xfdm:readConnectorDest("annun_door", 19) == 1)
  ) then
    xfdm:driveConnectorDest("bravo_led_door", nil, 1)
  else
    xfdm:driveConnectorDest("bravo_led_door", nil, 0)
  end
end
xfdm:requestCallback(xfdmCallbackAlways, "xfdm.joysticks.honeycomb_bravo.leds:checkDoor()")
