local B = {}
--HCA = "E" -- Honeycomb Bravo joystick letter
--
--Vendor = 0x294B -- Honeycomb Bravo vendor id
--Product = 0x1901 -- Honeycomb Bravo product id
--Device = 0 -- Multiple devices of the same name need increasing Device numbers.
--Pollrate = 25 -- Polling rate in number of polls per second

local bitHelper = require("champ_joy_3rdparty_bitwise")
local offsets = require("champ_joy_bravo")

nobr      = 0
report_ID = 0
bravo_pointer = 0

B.block_A = 0
B.block_A_old = 0
B.block_A_LED = {}
B.block_A_LED.HEADING = 1
B.block_A_LED.NAV     = 2
B.block_A_LED.APR     = 4
B.block_A_LED.REV     = 8
B.block_A_LED.ALT     = 16
B.block_A_LED.VS      = 32
B.block_A_LED.IAS     = 64
B.block_A_LED.AP      = 128

B.block_B = 0
B.block_B_old = 0
B.block_B_LED = {}
B.block_B_LED.LEFT_GEAR_GREEN  = 1
B.block_B_LED.LEFT_GEAR_RED    = 2
B.block_B_LED.NOSE_GEAR_GREEN  = 4
B.block_B_LED.NOSE_GEAR_RED    = 8
B.block_B_LED.RIGHT_GEAR_GREEN = 16
B.block_B_LED.RIGHT_GEAR_RED   = 32
B.block_B_LED.MASTER_WARNING   = 64
B.block_B_LED.ENGINE_FIRE      = 128

B.block_C = 0
B.block_C_old = 0
B.block_C_LED = {}
B.block_C_LED.LOW_OIL_PRESS  = 1
B.block_C_LED.LOW_FUEL_PRESS = 2
B.block_C_LED.ANTI_ICE       = 4
B.block_C_LED.STARTER        = 8
B.block_C_LED.APU            = 16
B.block_C_LED.MASTER_CAUTION = 32
B.block_C_LED.VACUUM         = 64
B.block_C_LED.LOW_HYD_PRESS  = 128

B.block_D = 0
B.block_D_old = 0
B.block_D_LED = {}
B.block_D_LED.FUEL_PUMP     = 1
B.block_D_LED.PARKING_BRAKE = 2
B.block_D_LED.LOW_VOLTS     = 4
B.block_D_LED.DOOR          = 8

-- LED BUILDING BLOCK FUNCTIONS


function B.led_set(blockTable, block, light)
  if     ('A' == block) then
    blockTable.block_A = bitHelper.bor(blockTable.block_A, light)
  elseif ('B' == block) then
    blockTable.block_B = bitHelper.bor(blockTable.block_B, light)
  elseif ('C' == block) then
    blockTable.block_C = bitHelper.bor(blockTable.block_C, light)
  elseif ('D' == block) then
    blockTable.block_D = bitHelper.bor(blockTable.block_D, light)
  end
end


function B.led_clear(blockTable, block, light)
  if     ('A' == block) then
    blockTable.block_A = bitHelper.band(blockTable.block_A, bitHelper.bnot(light))
  elseif ('B' == block) then
    blockTable.block_B = bitHelper.band(blockTable.block_B, bitHelper.bnot(light))
  elseif ('C' == block) then
    blockTable.block_C = bitHelper.band(blockTable.block_C, bitHelper.bnot(light))
  elseif ('D' == block) then
    blockTable.block_D = bitHelper.band(blockTable.block_D, bitHelper.bnot(light))
  end
end


function B.led_toggle(blockTable, block, light)
  if     ('A' == block) then
    blockTable.block_A = bitHelper.bxor(blockTable.block_A, light)
  elseif ('B' == block) then
    blockTable.block_B = bitHelper.bxor(blockTable.block_B, light)
  elseif ('C' == block) then
    blockTable.block_C = bitHelper.bxor(blockTable.block_C, light)
  elseif ('D' == block) then
    blockTable.block_D = bitHelper.bxor(blockTable.block_D, light)
  end
end


function B.led_check(iBool, blockTable, block, light)
  if (iBool) then
    B.led_set(blockTable, block, light)
  else
    B.led_clear(blockTable, block, light)
  end
end


function updateLeds()
  if ((B.block_A_old ~= B.block_A) or (B.block_B_old ~= B.block_B) or (B.block_C_old ~= B.block_C) or (B.block_D_old ~= B.block_D)) then
    hid_send_feature_report(bravo_pointer, report_ID, B.block_A, B.block_B, B.block_C, B.block_D)
    B.block_A_old = B.block_A
    B.block_B_old = B.block_B
    B.block_C_old = B.block_C
    B.block_D_old = B.block_D
  end
end

function setAllToOff()
  B.led_clear(B, 'A', B.block_A_LED.HEADING)
  B.led_clear(B, 'A', B.block_A_LED.NAV)
  B.led_clear(B, 'A', B.block_A_LED.APR)
  B.led_clear(B, 'A', B.block_A_LED.REV)
  B.led_clear(B, 'A', B.block_A_LED.ALT)
  B.led_clear(B, 'A', B.block_A_LED.VS)
  B.led_clear(B, 'A', B.block_A_LED.IAS)
  B.led_clear(B, 'A', B.block_A_LED.AP)

  B.led_clear(B, 'B', B.block_B_LED.LEFT_GEAR_GREEN)
  B.led_clear(B, 'B', B.block_B_LED.LEFT_GEAR_RED)
  B.led_clear(B, 'B', B.block_B_LED.NOSE_GEAR_GREEN)
  B.led_clear(B, 'B', B.block_B_LED.NOSE_GEAR_RED)
  B.led_clear(B, 'B', B.block_B_LED.RIGHT_GEAR_GREEN)
  B.led_clear(B, 'B', B.block_B_LED.RIGHT_GEAR_RED)
  B.led_clear(B, 'B', B.block_B_LED.MASTER_WARNING)
  B.led_clear(B, 'B', B.block_B_LED.ENGINE_FIRE)

  B.led_clear(B, 'C', B.block_C_LED.LOW_OIL_PRESS)
  B.led_clear(B, 'C', B.block_C_LED.LOW_FUEL_PRESS)
  B.led_clear(B, 'C', B.block_C_LED.ANTI_ICE)
  B.led_clear(B, 'C', B.block_C_LED.STARTER)
  B.led_clear(B, 'C', B.block_C_LED.APU)
  B.led_clear(B, 'C', B.block_C_LED.MASTER_CAUTION)
  B.led_clear(B, 'C', B.block_C_LED.VACUUM)
  B.led_clear(B, 'C', B.block_C_LED.LOW_HYD_PRESS)

  B.led_clear(B, 'D', B.block_D_LED.FUEL_PUMP)
  B.led_clear(B, 'D', B.block_D_LED.PARKING_BRAKE)
  B.led_clear(B, 'D', B.block_D_LED.LOW_VOLTS)
  B.led_clear(B, 'D', B.block_D_LED.DOOR)
end

function ledDatarefCheck()
  if((get("sim/cockpit2/electrical/bus_volts", 0) > 3.3) or
     (get("sim/cockpit2/electrical/bus_volts", 1) > 3.3) or
     (get("sim/cockpit2/electrical/bus_volts", 3) > 3.3) or
     (get("sim/cockpit2/electrical/bus_volts", 4) > 3.3) or
     (get("sim/cockpit2/electrical/bus_volts", 5) > 3.3)
   ) then

    if (button(675)) then
      B.led_set(B, 'A', B.block_A_LED.HEADING)
      B.led_set(B, 'A', B.block_A_LED.NAV)
      B.led_set(B, 'A', B.block_A_LED.APR)
      B.led_set(B, 'A', B.block_A_LED.REV)
      B.led_set(B, 'A', B.block_A_LED.ALT)
      B.led_set(B, 'A', B.block_A_LED.VS)
      B.led_set(B, 'A', B.block_A_LED.IAS)
      B.led_set(B, 'A', B.block_A_LED.AP)
    else
      B.led_clear(B, 'A', B.block_A_LED.HEADING)
      B.led_clear(B, 'A', B.block_A_LED.NAV)
      B.led_clear(B, 'A', B.block_A_LED.APR)
      B.led_clear(B, 'A', B.block_A_LED.REV)
      B.led_clear(B, 'A', B.block_A_LED.ALT)
      B.led_clear(B, 'A', B.block_A_LED.VS)
      B.led_clear(B, 'A', B.block_A_LED.IAS)
      B.led_clear(B, 'A', B.block_A_LED.AP)
    end

    --All normal mapping starts here

    --B.led_check(
    --  (
    --    (get("sim/cockpit2/autopilot/heading_mode") == 1)
    --  ), B, 'A', B.block_A_LED.HEADING)
    --      "Condition": "sim/cockpit2/autopilot/heading_mode" is Deprecated,

    B.led_check(
      (
        (get("sim/cockpit2/autopilot/nav_status") == 1)
      ), B, 'A', B.block_A_LED.NAV)
    
    B.led_check(
      (
        (get("sim/cockpit2/autopilot/approach_status") >= 1)
      ), B, 'A', B.block_A_LED.APR)
    
    B.led_check(
      (
        (get("sim/cockpit2/autopilot/backcourse_status") >= 1)
      ), B, 'A', B.block_A_LED.REV)
    
    B.led_check(
      (
        (get("sim/cockpit2/autopilot/altitude_hold_status") >= 1)
      ), B, 'A', B.block_A_LED.ALT)
    
    B.led_check(
      (
        (get("sim/cockpit2/autopilot/vvi_status") >= 1)
      ), B, 'A', B.block_A_LED.VS)
    
    B.led_check(
      (
        (get("sim/cockpit2/autopilot/speed_status") >= 1)
      ), B, 'A', B.block_A_LED.IAS)
    
    B.led_check(
      (
        (get("sim/cockpit2/autopilot/servos_on") >= 1)
      ), B, 'A', B.block_A_LED.AP)

    --LEFT MAIN GEAR
    B.led_check(
      (
        (get("sim/flightmodel2/gear/deploy_ratio", 1) == 1.0)
      ), B, 'B', B.block_B_LED.LEFT_GEAR_GREEN)
    B.led_check(
      (
        (get("sim/flightmodel2/gear/deploy_ratio", 1) < 1.0) and
        (get("sim/flightmodel2/gear/deploy_ratio", 1) > 0)
      ), B, 'B', B.block_B_LED.LEFT_GEAR_RED)

    --NOSE GEAR
    B.led_check(
      (
        (get("sim/flightmodel2/gear/deploy_ratio", 0) == 1.0)
      ), B, 'B', B.block_B_LED.NOSE_GEAR_GREEN)
    B.led_check(
      (
        (get("sim/flightmodel2/gear/deploy_ratio", 0) < 1.0) and
        (get("sim/flightmodel2/gear/deploy_ratio", 0) > 0)
      ), B, 'B', B.block_B_LED.NOSE_GEAR_RED)

    --RIGHT MAIN GEAR
    B.led_check(
      (
        (get("sim/flightmodel2/gear/deploy_ratio", 2) == 1.0)
      ), B, 'B', B.block_B_LED.RIGHT_GEAR_GREEN)

    B.led_check(
      (
        (get("sim/flightmodel2/gear/deploy_ratio", 2) < 1.0) and
        (get("sim/flightmodel2/gear/deploy_ratio", 2) > 0)
      ), B, 'B', B.block_B_LED.RIGHT_GEAR_RED)

    B.led_check(
      (
        (get("sim/cockpit2/annunciators/master_warning") == 1)
      ), B, 'B', B.block_B_LED.MASTER_WARNING)
    
    B.led_check(
      (
        (get("sim/cockpit2/annunciators/engine_fires", 0) == 1) or
        (get("sim/cockpit2/annunciators/engine_fires", 1) == 1) or
        (get("sim/cockpit2/annunciators/engine_fires", 2) == 1) or
        (get("sim/cockpit2/annunciators/engine_fires", 3) == 1)
      ), B, 'B', B.block_B_LED.ENGINE_FIRE)
    
    B.led_check(
      (
        (get("sim/cockpit2/annunciators/oil_pressure_low", 0) == 1) or
        (get("sim/cockpit2/annunciators/oil_pressure_low", 1) == 1) or
        (get("sim/cockpit2/annunciators/oil_pressure_low", 2) == 1) or
        (get("sim/cockpit2/annunciators/oil_pressure_low", 3) == 1)
      ), B, 'C', B.block_C_LED.LOW_OIL_PRESS)
    
    B.led_check(
      (
        (get("sim/cockpit2/annunciators/fuel_pressure_low", 0) == 1) or
        (get("sim/cockpit2/annunciators/fuel_pressure_low", 1) == 1) or
        (get("sim/cockpit2/annunciators/fuel_pressure_low", 2) == 1) or
        (get("sim/cockpit2/annunciators/fuel_pressure_low", 3) == 1)
      ), B, 'C', B.block_C_LED.LOW_FUEL_PRESS)

    B.led_check(
      (
        (get("sim/cockpit/switches/anti_ice_inlet_heat_per_engine", 0) == 1) or
        (get("sim/cockpit/switches/anti_ice_inlet_heat_per_engine", 1) == 1) or
        (get("sim/cockpit/switches/anti_ice_inlet_heat_per_engine", 2) == 1) or
        (get("sim/cockpit/switches/anti_ice_inlet_heat_per_engine", 3) == 1) or
        (get("sim/cockpit/switches/anti_ice_surf_heat") == 1) or
        (get("sim/cockpit/switches/anti_ice_surf_heat_left") == 1) or
        (get("sim/cockpit/switches/anti_ice_surf_heat_right") == 1)
      ), B, 'C', B.block_C_LED.ANTI_ICE)

    B.led_check(
      (
        (get("sim/cockpit2/engine/actuators/starter_hit", 0) == 1) or
        (get("sim/cockpit2/engine/actuators/starter_hit", 1) == 1) or
        (get("sim/cockpit2/engine/actuators/starter_hit", 2) == 1) or
        (get("sim/cockpit2/engine/actuators/starter_hit", 3) == 1)
        --Add Wind A/I
      ), B, 'C', B.block_C_LED.STARTER)

    B.led_check(
      (
        (get("sim/cockpit/engine/APU_running") == 1)
      ), B, 'C', B.block_C_LED.APU)

    B.led_check(
      (
        (get("sim/cockpit2/annunciators/master_caution") == 1)
      ), B, 'C', B.block_C_LED.MASTER_CAUTION)

    B.led_check(
      (
        (get("sim/cockpit2/annunciators/low_vacuum") == 1)
      ), B, 'C', B.block_C_LED.VACUUM)

    B.led_check(
      (
        (get("sim/cockpit/warnings/annunciators/hydraulic_pressure") == 1)
      ), B, 'C', B.block_C_LED.LOW_HYD_PRESS)

    B.led_check(
      (
        (get("sim/cockpit2/fuel/transfer_pump_left") == 1) or
        (get("sim/cockpit2/fuel/transfer_pump_right") == 1)
        --Add Wind A/I
      ), B, 'D', B.block_D_LED.FUEL_PUMP)

    B.led_check(
      (
        (get("sim/flightmodel/controls/parkbrake") == 1)
      ), B, 'D', B.block_D_LED.PARKING_BRAKE)

    B.led_check(
      (
        (get("sim/cockpit2/annunciators/low_voltage") == 1)
      ), B, 'D', B.block_D_LED.LOW_VOLTS)
      
    B.led_check(
      (
        (get("sim/cockpit2/annunciators/cabin_door_open") == 1)
      ), B, 'D', B.block_D_LED.DOOR)
  else
    setAllToOff()
  end
end


function ChampLedSpecificCheck()
  --Meant to be derived in the user mapping script
end


-- MAIN FUNCTIONS

function B.bravo_led_main()
  -- A C pointer from HIDAPI
  bravo_pointer = hid_open(0x294B, 0x1901)

  if bravo_pointer == nil then
    logMsg("Champion Info: Oh, no! We can't access our Bravo Throttle directly")
  else
    novw=5
    nobr, report_ID, variable1, variable2, variable3, variable4, variable5 = hid_get_feature_report(bravo_pointer, novw)
    --logMsg(nobr)
    --logMsg(report_ID)
    --logMsg(string.format("%x", variable1))
    --logMsg(string.format("%x", variable2))
    --logMsg(string.format("%x", variable3))
    --logMsg(string.format("%x", variable4))
    --logMsg(string.format("%x", variable5))
  end
  if ((nobr ~= 0) and (report_ID ~= 0)) then
    do_every_frame("ledDatarefCheck()")
    do_every_frame("ChampLedSpecificCheck()")
    do_every_frame("updateLeds()")
    do_on_exit("shutdownLeds()")
  end
end


function shutdownLeds()
  setAllToOff()
  updateLeds()
  hid_close(bravo_pointer)
end



return B
