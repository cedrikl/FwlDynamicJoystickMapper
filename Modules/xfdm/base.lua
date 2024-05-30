if not xfdm then
  --Instance guard
  xfdm = {}
  xfdm.step  = 0
  xfdm.readyStep = 4
  xfdm.msg = "TEST"
  xfdm.connectorQueue = {}  --Number Table
  xfdm.mappingQueue   = {}  --Number Table
  xfdm.callbackQueue = {} --Number Table
  xfdm.connectorTimeout      = 30 --seconds
  --xfdm.connectorTimeout      = 3 --seconds
  xfdm.currentConnectorStartTimestamp = -1
  xfdm.connectors = {}      --Hash Table
  xfdm.callbacks = {}
  do_every_draw("xfdm:showSimMsg()")
end

require("xfdm.interaction")

function xfdm:showSimMsg()
  if (self.msg ~= "") then
      --draw_string_Helvetica_18
      _,_ = big_bubble(math.floor(SCREEN_WIDTH*0.1), math.floor(SCREEN_HEIGHT*0.8), "XFDM Info", self.msg)
  end
end

function bool_to_number(value)
  return value and 1 or 0
end

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

-- https://stackoverflow.com/questions/41942289/display-contents-of-tables-in-lua
function tprint (tbl, indent)
  if not indent then indent = 0 end
  local toprint = string.rep(" ", indent) .. "{\r\n"
  indent = indent + 2 
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if (type(k) == "number") then
      toprint = toprint .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      toprint = toprint  .. k ..  "= "   
    end
    if (type(v) == "number") then
      toprint = toprint .. v .. ",\r\n"
    elseif (type(v) == "string") then
      toprint = toprint .. "\"" .. v .. "\",\r\n"
    elseif (type(v) == "table") then
      toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
    else
      toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
    end
  end
  toprint = toprint .. string.rep(" ", indent-2) .. "}"
  return toprint
end

function xfdm:getNumberOfHashItems(iHash)
  local count = 0
  if iHash then
    for _ in pairs(iHash) do count = count + 1 end
  end
  return count
end

xfdmConInButton      = "xfdmConnectorInputJoyButton"
xfdmConInAxis        = "xfdmConnectorInputJoyAxis"
xfdmConInDataref     = "xfdmConnectorInputDataref"
xfdmConInOtherCon    = "xfdmConnectorInputOtherConnector"

xfdmConOutSimAxis    = "xfdmConnectorOutputAxis"
xfdmConOutRoDataref  = "xfdmConnectorOutputRoDataref"
xfdmConOutRwDataref  = "xfdmConnectorOutputRwDataref"
xfdmConOutSimCommand = "xfdmConnectorOutputCommand"
xfdmConOutOtherCon   = "xfdmConnectorOutputConnector"

xfdmNullLink = "xfdmNullLink"

xfdmCallbackSometimes = "xfdmCallbackSometimes"
xfdmCallbackOften     = "xfdmCallbackOften"
xfdmCallbackAlways    = "xfdmCallbackAlways"

function xfdm:requestConnector(iConnName, iConnDestType, iConnDestRef)
  table.insert(self.connectorQueue, {cName=iConnName, cDestType=iConnDestType, cDestRef=iConnDestRef})
end

function xfdm:requestMapping(iConnName, iConnSrcType, iConnSrcRef, iConnSrcRev)
  if not iConnSrcRev then
    iConnSrcRev = "normal"
  end
  table.insert(self.mappingQueue, {cName=iConnName, cSrcType=iConnSrcType, cSrcRef=iConnSrcRef, cSrcInvert=iConnSrcRev})
end

function xfdm:requestCallback(iCallFreq, iCallFunc)
  table.insert(self.callbackQueue, {cName=iCallFunc, cFreq=iCallFreq})
end

function xfdm:setConnectorDest(iConnName, iConnDestType, iConnDestRef)
  if (self.connectors[iConnName]) then
    logMsg(string.format("XFDM - setConnectorDest: Connector %s already exists, overriding with \"%s\"", iConnName, iConnDestRef))
    self.connectors[iConnName].cDestType = iConnDestType
    self.connectors[iConnName].cDestRef  = iConnDestRef
  else
    self.connectors[iConnName] = {cDestType=iConnDestType, cSrcRef=xfdmNullLink, cDestRef=iConnDestRef}
    logMsg(string.format("XFDM - setConnectorDest: Created a new %s connector to \"%s\"", iConnDestType, iConnDestRef))
  end
end

function xfdm:setConnectorSource(iConnName, iConnSrcType, iConnSrcRef, iConnSrcRev)
  if not self.connectors[iConnName] then
    logMsg(string.format("XFDM - mapConnector: Requested connector \"%s\" does not exist, creating a new one mapped to %s", iConnName, xfdmNullLink))
    self.setConnectorDest(iConnName, xfdmLinkRwDataref, xfdmNullLink)
  end
  if (self.connectors[iConnName].cSrcRef ~= xfdmNullLink) then
    logMsg(string.format("XFDM - mapConnector(warning): Requested connector \"%s\" was planning to be mapped to %s %s but has been overriden to %s %s.", iConnName, self.connectors[iConnName].cSrcType, self.connectors[iConnName].cSrcRef, iSrcType, iSrcRef))
  end
  if ((self.connectors[iConnName].cDestType == xfdmConOutRoDataref) or (self.connectors[iConnName].cDestType == xfdmConOutRwDataref)) then
    logMsg(string.format("XFDM - mapConnector(info): Requested connector \"%s\" to \"%s:%s\" is linked to a dataref. This probably means that another module will interact with it directly.", iConnName, iConnSrcType, iConnSrcRef))
  end
  if (self.connectors[iConnName].cSrcType == xfdmConInOtherCon) then
    local tDest = iConnName
    local tSrc  = self.connectors[iConnName].cSrcRef
    self.connectors[tSrc].cDestRef = tDest
    self.connectors[tSrc].cDestType = xfdmConOutOtherCon
  end
  self.connectors[iConnName].cSrcType   = iConnSrcType
  self.connectors[iConnName].cSrcRef    = iConnSrcRef
  self.connectors[iConnName].cSrcInvert = iConnSrcRev
end

function xfdm:checkConnectorDest(iConnCandidate)
  if     (iConnCandidate.cDestType == xfdmConOutSimAxis)   then return true
  elseif (iConnCandidate.cDestType == xfdmConOutOtherCon)  then return true
  elseif ((iConnCandidate.cDestType == xfdmConOutRwDataref) or (iConnCandidate.cDestType == xfdmConOutRoDataref)) then
    if (iConnCandidate.cDestRef == xfdmNullLink) then
      return true
    else
      return XPLMFindDataRef(iConnCandidate.cDestRef)
    end
  elseif (iConnCandidate.cDestType == xfdmConOutSimCommand)      then
    if (iConnCandidate.cDestRef == xfdmNullLink) then
      return true
    else
      return XPLMFindCommand(iConnCandidate.cDestRef)
    end
  else
    return false
  end
end

function xfdm:startCallbacks()
  for k,v in pairs(self.callbacks) do
    if     (v.cFreq == xfdmCallbackSometimes) then
      do_sometimes(v.cName)
    elseif (v.cFreq == xfdmCallbackOften) then
      do_often(v.cName)
    elseif (v.cFreq == xfdmCallbackAlways) then
      do_every_frame(v.cName)
    end
    logMsg(string.format("XFDM: Started the callback \"%s\" (%s)", v.cName, v.cFreq))
  end
  
end

function xfdm:tryToCreateNextConnector()
  if(self.connectorQueue[1].cDestType ~= xfdmConOutSimAxis    and
     self.connectorQueue[1].cDestType ~= xfdmConOutRoDataref  and
     self.connectorQueue[1].cDestType ~= xfdmConOutRwDataref  and
     self.connectorQueue[1].cDestType ~= xfdmConOutSimCommand and
     self.connectorQueue[1].cDestType ~= xfdmConOutOtherCon)
  then
    logMsg(string.format("XFDM - tryToCreateNextConnector(ERROR): \"%s\" destination type is not a valid option. Overriding to xfdmConOutRoDataref.", self.connectorQueue[1].cName))
    self.connectorQueue[1].cDestType = xfdmConOutRoDataref
  end
  if(self:checkConnectorDest(self.connectorQueue[1])) then
    self:setConnectorDest(self.connectorQueue[1].cName, self.connectorQueue[1].cDestType, self.connectorQueue[1].cDestRef)
    self.msg = string.format("XFDM: Created a connector \"%s\" linked to \"%s\".", self.connectorQueue[1].cName, self.connectorQueue[1].cDestRef)
    table.remove(self.connectorQueue, 1)
  else
    --Giving it some time
    if (self.currentConnectorStartTimestamp == -1) then
      self.currentConnectorStartTimestamp = get("sim/time/total_running_time_sec")
    end
    local sElapsedTime = get("sim/time/total_running_time_sec") - self.currentConnectorStartTimestamp
    self.msg = string.format("XFDM: Waiting on \"%s\"(%s) to be created. %d/%d sec", self.connectorQueue[1].cName, self.connectorQueue[1].cDestRef, sElapsedTime, self.connectorTimeout)
    if (sElapsedTime > self.connectorTimeout) then
      self.currentConnectorStartTimestamp = -1
      logMsg(string.format("XFDM - tryToCreateNextConnector(ERROR): \"%s\" (%s) could not be found within the timeout period. Overriding to dummy mapping.", self.connectorQueue[1].cDestRef, self.connectorQueue[1].cDestType))
      self.connectorQueue[1].cDestType = xfdmLinkCommand
      self.connectorQueue[1].cDestRef = xfdmNullLink
    end
  end
end

function xfdm:tryToSetNextConnectorSrc()
  self:setConnectorSource(self.mappingQueue[1].cName, self.mappingQueue[1].cSrcType, self.mappingQueue[1].cSrcRef, self.mappingQueue[1].cSrcInvert)
  self.msg = string.format("XFDM: Mapped the connector \"%s\" to %s %s.", self.mappingQueue[1].cName, self.mappingQueue[1].cSrcType, self.mappingQueue[1].cSrcRef)
  table.remove(self.mappingQueue, 1)
end

function xfdm:tryToSetNextCallback()
  if (table.getn(self.callbackQueue) ~= 0) then
    table.insert(self.callbacks, {cName=self.callbackQueue[1].cName, cFreq=self.callbackQueue[1].cFreq})
    local ownKey = table.getn(self.callbacks)
    for k,v in pairs(self.callbacks) do
      if ((v.cName == self.callbackQueue[1].cName) and (k ~= ownKey)) then
        logMsg(string.format("XFDM - tryToSetNextCallback(warning): Callback %s was already added in %d position, only keeping in last position.", k, v.cName))
        table.remove(self.callbacks, k)
        break
      end
    end
    table.remove(self.callbackQueue, 1)
  end
end

function xfdm:connectorCreationRunner()
  if (table.getn(self.connectorQueue) == 0) then
    self.msg = "XFDM - connectorCreationRunner: All connectors have been created."
    logMsg("XFDM - connectorCreationRunner: All connectors have been created.")
    self.step = self.step + 1
  else
    self:tryToCreateNextConnector()
  end
end

function xfdm:connectorSourceRunner()
  if (table.getn(self.mappingQueue) == 0) then
    self.msg = "XFDM - connectorMappingRunner: All mappings have been processed."
    logMsg("XFDM - connectorMappingRunner: All mappings have been processed.")
    self.step = self.step + 1
  else
    self:tryToSetNextConnectorSrc()
  end
end

function xfdm:findTopConnector(iConnName)
  local tSrcName = self.connectors[iConnName].cSrcRef
  local oConType = self.connectors[tSrcName].cSrcType
  local oConRef = self.connectors[tSrcName].cSrcRef
  logMsg(string.format("XFDM - findTopConnector: From %s (src: %s %s) to %s (src: %s %s)", iConnName, self.connectors[iConnName].cSrcType, self.connectors[iConnName].cSrcRef, tSrcName, oConType, oConRef))
  if (oConType == xfdmConInOtherCon) then
    oConType, oConRef = self:findTopConnector(tSrcName)
  end
  return oConType, oConRef
end

function xfdm:findLastConnector(iConnName)
  local tDestName = self.connectors[iConnName].cDestRef
  local oConType = self.connectors[tDestName].cDestType
  local oConRef = self.connectors[tDestName].cDestRef
  logMsg(string.format("XFDM - findLastConnector: From %s (dest: %s %s) to %s (dest: %s %s)", iConnName, self.connectors[iConnName].cDestType, self.connectors[iConnName].cDestRef, tDestName, oConType, oConRef))
  if (oConType == xfdmConOutOtherCon) then
    oConType, oConRef = self:findLastConnector(tDestName)
  end
  return oConType, oConRef
end

function xfdm:assignConnectors()
  for k,v in pairs(xfdm.connectors) do
    if (v.cSrcRef ~= xfdmNullLink and
        v.cDestType ~= xfdmConOutRoDataref and
        v.cDestType ~= xfdmConOutRwDataref) then
      local tSrcRef  = v.cSrcRef
      local tSrcType = v.cSrcType
      local tDestRef  = v.cDestRef
      local tDestType = v.cDestType

      if (tSrcType == xfdmConInOtherCon) then
        tSrcType, tSrcRef = self:findTopConnector(k, tSrcRef)
      end

      if (tSrcType == xfdmConInAxis) then
        local tSrcDir = v.cSrcInvert
        if (tDestRef == xfdmNullLink) then
          tSrcDir = "normal"
          tDestRef = "none"
        end
        set_axis_assignment(tSrcRef, tDestRef, tSrcDir)
        logMsg(string.format("XFDM - assignConnectors: Assigned axis %d to \"%s\".", tSrcRef, tDestRef))
      elseif (tSrcType == xfdmConInButton) then
        if (tDestRef == xfdmNullLink) then tDestRef = "sim/none/none" end
        set_button_assignment(tSrcRef, tDestRef)
        logMsg(string.format("XFDM - assignConnectors: Assigned button %d to \"%s\".", tSrcRef, tDestRef))
      end
    end
  end
  self.msg = "XFDM - assignConnectors: All assignments have been processed."
  logMsg("XFDM - assignConnectors: All assignments have been processed.")
  self.step = self.step + 1
end

function xfdm:connectorCallbacksRunner()
  if (table.getn(self.callbackQueue) == 0) then
    self:startCallbacks()
    self.msg = "XFDM - connectorCallbacksRunner: All callbacks have been started."
    logMsg("XFDM - connectorCallbacksRunner: All callbacks have been started.")
    self.step = self.step + 1
  else
    self:tryToSetNextCallback()
  end
end

function xfdm:runner()
  if     (self.step == 0) then self:connectorCreationRunner()
  elseif (self.step == 1) then self:connectorSourceRunner()
  elseif (self.step == 2) then self:assignConnectors()
  elseif (self.step == 3) then self:connectorCallbacksRunner()
  elseif (self.step == xfdm.readyStep) then
    self.msg = ""
    self.step = self.step + 1
  end
end