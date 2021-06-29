local joy_known = {}

joy_known.db = {}

joy_known.size = 0

joy_known.db[joy_known.size + 1] = {}
joy_known.db[joy_known.size + 1]["vid"]  = 0x06a3
joy_known.db[joy_known.size + 1]["pid"]  = 0x0c2d
joy_known.db[joy_known.size + 1]["name"] = "Saitek Pro Flight Quadrant"
joy_known.db[joy_known.size + 1]["modu"] = "champ_joy_saitek_tq"
joy_known.db[joy_known.size + 1]["xpos"] = nil
joy_known.size = joy_known.size + 1

joy_known.db[joy_known.size + 1] = {}
joy_known.db[joy_known.size + 1]["vid"]  = 0x044f
joy_known.db[joy_known.size + 1]["pid"]  = 0xb68f
joy_known.db[joy_known.size + 1]["name"] = "T-Pendular-Rudder"
joy_known.db[joy_known.size + 1]["modu"] = "champ_joy_tpr"
joy_known.db[joy_known.size + 1]["xpos"] = nil
joy_known.size = joy_known.size + 1

joy_known.db[joy_known.size + 1] = {}
joy_known.db[joy_known.size + 1]["vid"] = 0x231d
joy_known.db[joy_known.size + 1]["pid"] = 0x0127
joy_known.db[joy_known.size + 1]["name"] = "VKBsim Space Gunfighter L"
joy_known.db[joy_known.size + 1]["modu"] = "champ_joy_scg_l"
joy_known.db[joy_known.size + 1]["xpos"] = nil
joy_known.size = joy_known.size + 1

logMsg(string.format("Champion Info: %d known elements loaded", joy_known.size))

----------------------
-- Helper Functions --
----------------------

-- see if the file exists
function file_exists(file)
  local f = io.open(file, "r")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

function joy_known.detect (pref_file)

  local file = "C:/Games/X-Plane 11/Output/preferences/X-Plane Joystick Settings.prf"
  local lines = lines_from(file)

  -- print all line numbers and their contents
  for k,v in pairs(lines) do
    if string.match(v, "_joy_unique_id%d+ VID:%d+PID:%d+") then
      _, _, xpos = string.find(v, "_joy_unique_id(%d+) VID:%d+PID:%d+")
      _, _, xvid = string.find(v, "_joy_unique_id%d+ VID:(%d+)PID:%d+")
      _, _, xpid = string.find(v, "_joy_unique_id%d+ VID:%d+PID:(%d+)")

      --logMsg(string.format("line[%s]%s", k, v))
      --logMsg(string.format("position: %d", xpos))
      --logMsg(string.format("vid: %s", xvid))
      --logMsg(string.format("pid: %s", xpid))

      -- Convert strings to numbers
      xpos = tonumber(xpos)
      xvid = tonumber(xvid)
      xpid = tonumber(xpid)

      for known_HID_device = 1, joy_known.size, 1
      do

        --logMsg(xvid)
        --logMsg(joy_known.db[known_HID_device]["vid"])
        --if (xvid == (joy_known.db[known_HID_device]["vid"])) then
        --  logMsg("VID Same")
        --else
        --  logMsg("VID Different")
        --end
        --
        --logMsg(type(xpid))
        --logMsg(xpid)
        --logMsg(type(joy_known.db[known_HID_device]["pid"]))
        --logMsg(joy_known.db[known_HID_device]["pid"])
        --if (xpid == (joy_known.db[known_HID_device]["pid"])) then
        --  logMsg("PID Same")
        --else
        --  logMsg("PID Different")
        --end
        --
        --logMsg("\n")

        if ((xvid == (joy_known.db[known_HID_device]["vid"])) and (xpid == (joy_known.db[known_HID_device]["pid"]))) then
          logMsg(string.format("Champion Info: Auto detected a %s at position %d (VID: %x, PID: %x). DB has been updated", joy_known.db[known_HID_device]["name"], xpos, xvid, xpid))
          joy_known.db[known_HID_device]["xpos"] = xpos
        end
      end
    end
  end
end

return joy_known