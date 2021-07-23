local bravo = {}

local lastTickTimestamp = 0
local upticksRepetition = 0
local downticksRepetition = 0

function bravo.map(joy_num, joy_hid_pointer)

  start_axis   = joy_num * 25
  start_button = joy_num * 160
  
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

  --These next two share electrical discrete input
  bravo.axis1_special    = start_button + 28
  bravo.axis2_toga       = start_button + 28

  bravo.axis3_toga       = start_button + 29
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
end


function bravo_command_multiple(command, count)
  while (count > 0)
  do
    command_once(command)
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


function apPanelCheck()
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

        if (upticksRepetition < 5) then
          apPanelHandleUpticks(1)
        elseif (upticksRepetition < 20) then
          apPanelHandleUpticks(2)
        else
          apPanelHandleUpticks(10)
        end
      else
        upticksRepetition = 0
        downticksRepetition = downticksRepetition + 1

        if (downticksRepetition < 5) then
          apPanelHandleDownticks(1)
        elseif (downticksRepetition < 10) then
          apPanelHandleDownticks(2)
        else
          apPanelHandleDownticks(10)
        end
      end
    end

    if (timeSinceLastTick > 0.5) then
      upticksRepetition = 0
      downticksRepetition = 0
    end
  end

    --  "ButtonNumber": 12,
    --  "PressEvent": [
    --    {
    --      "Variables": [],
    --      "Variable": "",
    --      "Value": "",
    --      "Name": "AP_INCREASE",
    --      "Condition": "",
    --      "ConditionValue": "",
    --      "ConditionLogic": "",
    --      "Conditions": [
    --        {
    --          "Variable": "sim/autopilot/nose_up",
    --          "Value": "",
    --          "VariableIsCustom": false,
    --          "VariableBoundaries": {
    --            "MinValue": "",
    --            "MaxValue": "",
    --            "Clamp": false
    --          },
    --          "Condition": "INT:FCU_SELECTOR, string",
    --          "ConditionValue": "VS",
    --          "ConditionIsCustom": true
    --        },
    --        {
    --          "Variable": "sim/GPS/g1000n1_crs_up",
    --          "Value": "",
    --          "VariableIsCustom": false,
    --          "VariableBoundaries": {
    --            "MinValue": "",
    --            "MaxValue": "",
    --            "Clamp": false
    --          },
    --          "Condition": "INT:FCU_SELECTOR, string",
    --          "ConditionValue": "CRS",
    --          "ConditionIsCustom": true
    --        },
    --        {
    --          "Variable": "sim/autopilot/airspeed_up",
    --          "Value": "",
    --          "VariableIsCustom": false,
    --          "VariableBoundaries": {
    --            "MinValue": "",
    --            "MaxValue": "",
    --            "Clamp": false
    --          },
    --          "Condition": "INT:FCU_SELECTOR, string",
    --          "ConditionValue": "IAS",
    --          "ConditionIsCustom": true
    --        }
    --      ],
    --      "Repeat": 3
    --    }
    --  ],
    --  "ReleaseEvent": []
    --},
    --{
    --  "ButtonNumber": 13,
    --  "PressEvent": [
    --    {
    --      "Variables": [],
    --      "Variable": "",
    --      "Value": "",
    --      "Name": "AP_DECREASE",
    --      "Condition": "",
    --      "ConditionValue": "",
    --      "ConditionLogic": "",
    --      "Conditions": [
    --        {
    --          "Variable": "sim/autopilot/nose_down",
    --          "Value": "",
    --          "VariableIsCustom": false,
    --          "VariableBoundaries": {
    --            "MinValue": "",
    --            "MaxValue": "",
    --            "Clamp": false
    --          },
    --          "Condition": "INT:FCU_SELECTOR, string",
    --          "ConditionValue": "VS",
    --          "ConditionIsCustom": true
    --        },
    --        {
    --          "Variable": "sim/GPS/g1000n1_crs_down",
    --          "Value": "",
    --          "VariableIsCustom": false,
    --          "VariableBoundaries": {
    --            "MinValue": "",
    --            "MaxValue": "",
    --            "Clamp": false
    --          },
    --          "Condition": "INT:FCU_SELECTOR, string",
    --          "ConditionValue": "CRS",
    --          "ConditionIsCustom": true
    --        },
    --        {
    --          "Variable": "sim/autopilot/airspeed_down",
    --          "Value": "",
    --          "VariableIsCustom": false,
    --          "VariableBoundaries": {
    --            "MinValue": "",
    --            "MaxValue": "",
    --            "Clamp": false
    --          },
    --          "Condition": "INT:FCU_SELECTOR, string",
    --          "ConditionValue": "IAS",
    --          "ConditionIsCustom": true
    --        }
    --      ],
    --      "Repeat": 3
    --    }
    --  ],
    --  "ReleaseEvent": []
    --},
    --{
    --  "ButtonNumber": 14,
    --  "PressEvent": [],
    --  "ReleaseEvent": []
    --},
    --{
    --  "ButtonNumber": 15,
    --  "PressEvent": [],
    --  "ReleaseEvent": []
    --},
    --{
    --  "ButtonNumber": 16,
    --  "PressEvent": [
    --    {
    --      "Variables": [
    --        {
    --          "Variable": "INT:FCU_SELECTOR, string",
    --          "Value": "IAS",
    --          "VariableIsCustom": true,
    --          "VariableBoundaries": {
    --            "MinValue": "",
    --            "MaxValue": "",
    --            "Clamp": false
    --          }
    --        }
    --      ],
    --      "Variable": "",
    --      "Value": "",
    --      "Name": "",
    --      "Condition": "",
    --      "ConditionValue": "",
    --      "ConditionLogic": "",
    --      "Conditions": [],
    --      "Repeat": 0
    --    }
    --  ],
    --  "ReleaseEvent": []
    --},
    --{
    --  "ButtonNumber": 17,
    --  "PressEvent": [
    --    {
    --      "Variables": [
    --        {
    --          "Variable": "INT:FCU_SELECTOR, string",
    --          "Value": "CRS",
    --          "VariableIsCustom": true,
    --          "VariableBoundaries": {
    --            "MinValue": "",
    --            "MaxValue": "",
    --            "Clamp": false
    --          }
    --        }
    --      ],
    --      "Variable": "",
    --      "Value": "",
    --      "Name": "",
    --      "Condition": "",
    --      "ConditionValue": "",
    --      "ConditionLogic": "",
    --      "Conditions": [],
    --      "Repeat": 0
    --    }
    --  ],
    --  "ReleaseEvent": []
    --},
    --{
    --  "ButtonNumber": 18,
    --  "PressEvent": [
    --    {
    --      "Variables": [
    --        {
    --          "Variable": "INT:FCU_SELECTOR, string",
    --          "Value": "HDG",
    --          "VariableIsCustom": true,
    --          "VariableBoundaries": {
    --            "MinValue": "",
    --            "MaxValue": "",
    --            "Clamp": false
    --          }
    --        }
    --      ],
    --      "Variable": "",
    --      "Value": "",
    --      "Name": "",
    --      "Condition": "",
    --      "ConditionValue": "",
    --      "ConditionLogic": "",
    --      "Conditions": [],
    --      "Repeat": 0
    --    }
    --  ],
    --  "ReleaseEvent": []
    --},
    --{
    --  "ButtonNumber": 19,
    --  "PressEvent": [
    --    {
    --      "Variables": [
    --        {
    --          "Variable": "INT:FCU_SELECTOR, string",
    --          "Value": "VS",
    --          "VariableIsCustom": true,
    --          "VariableBoundaries": {
    --            "MinValue": "",
    --            "MaxValue": "",
    --            "Clamp": false
    --          }
    --        }
    --      ],
    --      "Variable": "",
    --      "Value": "",
    --      "Name": "",
    --      "Condition": "",
    --      "ConditionValue": "",
    --      "ConditionLogic": "",
    --      "Conditions": [],
    --      "Repeat": 0
    --    }
    --  ],
    --  "ReleaseEvent": []
    --},
    --{
    --  "ButtonNumber": 20,
    --  "PressEvent": [
    --    {
    --      "Variables": [
    --        {
    --          "Variable": "INT:FCU_SELECTOR, string",
    --          "Value": "ALT",
    --          "VariableIsCustom": true,
    --          "VariableBoundaries": {
    --            "MinValue": "",
    --            "MaxValue": "",
    --            "Clamp": false
    --          }
    --        }
    --      ],
    --      "Variable": "",
    --      "Value": "",
    --      "Name": "",
    --      "Condition": "",
    --      "ConditionValue": "",
    --      "ConditionLogic": "",
    --      "Conditions": [],
    --      "Repeat": 0
    --    }
    --  ],
    --  "ReleaseEvent": []
    --},
end


function bravo.ap_panel_main()
  --logMsg(string.format("Champ Debug: bravo start button: %d", start_button))
  do_every_frame("apPanelCheck()")
end

return bravo