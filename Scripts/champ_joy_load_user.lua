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

-------------------
-- Main Function --
-------------------

local lines = lines_from(SCRIPT_DIRECTORY .. "champ_joy_current_user.txt")

-- print all line numbers and their contents
for k,v in pairs(lines) do
  if string.match(v, "ben") then
    logMsg("Champion Info: Loading mapping from champ_joy_ben_mapping.lua")
    require("champ_joy_ben_mapping")
  elseif string.match(v, "ced") then
    logMsg("Champion Info: Loading mapping from champ_joy_ced_mapping.lua")
    require("champ_joy_ced_mapping")
  else
    logMsg("Champion Info: No valid user found")
  end
end
