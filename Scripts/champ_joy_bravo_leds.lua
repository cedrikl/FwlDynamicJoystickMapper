--HCA = "E" -- Honeycomb Bravo joystick letter
--
--Vendor = 0x294B -- Honeycomb Bravo vendor id
--Product = 0x1901 -- Honeycomb Bravo product id
--Device = 0 -- Multiple devices of the same name need increasing Device numbers.
--Pollrate = 25 -- Polling rate in number of polls per second

local bitHelper = require("champ_joy_3rdparty_bitwise")
local B = {}

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

-- LED FUNCTIONS

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

-- A C pointer from HIDAPI
bravo_pointer = hid_open(0x294B, 0x1901)

if bravo_pointer == nil then
  logMsg("Oh, no! We can't access our Bravo Throttle directly")
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

--close the connection
--hid_close(bravo_pointer)

--function checkButton(boolx)
--  if (boolx) then
--    B.led_set(B, 'A', B.block_A_LED.VS)
--    B.led_set(B, 'B', B.block_B_LED.NOSE_GEAR_GREEN)
--    B.led_set(B, 'C', B.block_C_LED.VACUUM)
--  else
--    B.led_clear(B, 'A', B.block_A_LED.VS)
--    B.led_clear(B, 'B', B.block_B_LED.NOSE_GEAR_GREEN)
--    B.led_clear(B, 'C', B.block_C_LED.VACUUM)
--  end
--end

function updateLeds()
  if ((B.block_A_old ~= B.block_A) or (B.block_B_old ~= B.block_B) or (B.block_C_old ~= B.block_C) or (B.block_D_old ~= B.block_D)) then
    hid_send_feature_report(bravo_pointer, report_ID, B.block_A, B.block_B, B.block_C, B.block_D)
    B.block_A_old = B.block_A
    B.block_B_old = B.block_B
    B.block_C_old = B.block_C
    B.block_D_old = B.block_D
  end
end

--do_every_frame([[
--      if (button(673)) then
--        checkButton(true)
--      else
--        checkButton(false)
--      end
--    ]])

--do_often("updateLeds()")






--  "LEDs": [
--    {
--      "ByteIndex": 0,
--      "BitIndex": 0,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/electrical/bus_volts:0",
--          "ConditionValue": ">0",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 1,
--      "BitIndex": 0,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/autopilot/heading_mode",
--          "ConditionValue": "1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 1,
--      "BitIndex": 1,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/autopilot/nav_status",
--          "ConditionValue": ">=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 1,
--      "BitIndex": 2,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/autopilot/approach_status",
--          "ConditionValue": ">=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 1,
--      "BitIndex": 3,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/autopilot/backcourse_status",
--          "ConditionValue": ">=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 1,
--      "BitIndex": 4,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/autopilot/altitude_hold_status",
--          "ConditionValue": ">=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 1,
--      "BitIndex": 5,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/autopilot/vvi_status",
--          "ConditionValue": ">=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 1,
--      "BitIndex": 6,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/autopilot/speed_status",
--          "ConditionValue": ">=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 1,
--      "BitIndex": 7,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/autopilot/servos_on",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 2,
--      "BitIndex": 0,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/flightmodel2/gear/deploy_ratio:1",
--          "ConditionValue": "=1.0",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 2,
--      "BitIndex": 1,
--      "ConditionLogic": "AND",
--      "Conditions": [
--        {
--          "Condition": "sim/flightmodel2/gear/deploy_ratio:1",
--          "ConditionValue": "<1.0",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/flightmodel2/gear/deploy_ratio:1",
--          "ConditionValue": ">0",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 2,
--      "BitIndex": 2,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/flightmodel2/gear/deploy_ratio:0",
--          "ConditionValue": "=1.0",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 2,
--      "BitIndex": 3,
--      "ConditionLogic": "AND",
--      "Conditions": [
--        {
--          "Condition": "sim/flightmodel2/gear/deploy_ratio:0",
--          "ConditionValue": "<1.0",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/flightmodel2/gear/deploy_ratio:0",
--          "ConditionValue": ">0",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 2,
--      "BitIndex": 4,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/flightmodel2/gear/deploy_ratio:2",
--          "ConditionValue": "=1.0",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 2,
--      "BitIndex": 5,
--      "ConditionLogic": "AND",
--      "Conditions": [
--        {
--          "Condition": "sim/flightmodel2/gear/deploy_ratio:2",
--          "ConditionValue": "<1.0",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/flightmodel2/gear/deploy_ratio:2",
--          "ConditionValue": ">0",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 2,
--      "BitIndex": 6,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/annunciators/master_warning",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 2,
--      "BitIndex": 7,
--      "ConditionLogic": "OR",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/annunciators/engine_fires:0",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/annunciators/engine_fires:1",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/annunciators/engine_fires:2",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/annunciators/engine_fires:3",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 3,
--      "BitIndex": 0,
--      "ConditionLogic": "OR",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/annunciators/oil_pressure_low:0",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/annunciators/oil_pressure_low:1",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/annunciators/oil_pressure_low:2",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/annunciators/oil_pressure_low:3",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 3,
--      "BitIndex": 1,
--      "ConditionLogic": "OR",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/annunciators/fuel_pressure_low:0",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/annunciators/fuel_pressure_low:1",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/annunciators/fuel_pressure_low:2",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/annunciators/fuel_pressure_low:3",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 3,
--      "BitIndex": 2,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/annunciators/pitot_heat",
--          "ConditionValue": "=0",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 3,
--      "BitIndex": 3,
--      "ConditionLogic": "OR",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/engine/actuators/starter_hit:0",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/engine/actuators/starter_hit:1",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/engine/actuators/starter_hit:2",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/engine/actuators/starter_hit:3",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 3,
--      "BitIndex": 4,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit/engine/APU_running",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 3,
--      "BitIndex": 5,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/annunciators/master_caution",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 3,
--      "BitIndex": 6,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/annunciators/low_vacuum",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 3,
--      "BitIndex": 7,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit/warnings/annunciators/hydraulic_pressure",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 4,
--      "BitIndex": 0,
--      "ConditionLogic": "OR",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/fuel/transfer_pump_left",
--          "ConditionValue": "=2",
--          "ConditionIsCustom": false
--        },
--        {
--          "Condition": "sim/cockpit2/fuel/transfer_pump_right",
--          "ConditionValue": "=2",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 4,
--      "BitIndex": 1,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/flightmodel/controls/parkbrake",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 4,
--      "BitIndex": 2,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/annunciators/low_voltage",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    },
--    {
--      "ByteIndex": 4,
--      "BitIndex": 3,
--      "ConditionLogic": "",
--      "Conditions": [
--        {
--          "Condition": "sim/cockpit2/annunciators/cabin_door_open",
--          "ConditionValue": "=1",
--          "ConditionIsCustom": false
--        }
--      ]
--    }