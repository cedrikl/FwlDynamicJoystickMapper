require("xfdm.base")

xfdm.joysticks = {}

xfdmJoyNc = "NO CONNECT"
xfdmJoyOk = "Connected"

function xfdm.joysticks.detect(joy_vid, joy_pid)

  local lines = lines_from(SYSTEM_DIRECTORY .. "Output" .. DIRECTORY_SEPARATOR .. "preferences" .. DIRECTORY_SEPARATOR .. "X-Plane Joystick Settings.prf")

  xpos = -1

  -- print all line numbers and their contents
  for k,v in pairs(lines) do
    if string.match(v, string.format("_joy_unique_id%%d+ VID:%sPID:%s", joy_vid, joy_pid)) then
      _, _, xpos = string.find(v, string.format("_joy_unique_id(%%d+) VID:%sPID:%s", joy_vid, joy_pid))

      -- Convert strings to numbers
      xpos = tonumber(xpos)
    end
  end

  return xpos
end

function xfdm.joysticks.detect_oculus()

  lpos = -1
  rpos = -1

  local lines = lines_from(SYSTEM_DIRECTORY .. "Output" .. DIRECTORY_SEPARATOR .. "preferences" .. DIRECTORY_SEPARATOR .. "X-Plane Joystick Settings.prf")

  -- print all line numbers and their contents
  for k,v in pairs(lines) do
    if string.match(v, "_joy_unique_id%d+ vr/Oculus/oculus_Left") then
      _, _, lpos = string.find(v, "_joy_unique_id(%d+) vr/Oculus/oculus_Left")

      -- Convert strings to numbers
      lpos = tonumber(lpos)
    elseif string.match(v, "_joy_unique_id%d+ vr/Oculus/oculus_Right") then
      _, _, rpos = string.find(v, "_joy_unique_id(%d+) vr/Oculus/oculus_Right")

      -- Convert strings to numbers
      rpos = tonumber(rpos)
    end
  end

  return lpos, rpos
end
