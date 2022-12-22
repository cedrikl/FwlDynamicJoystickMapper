if not xfdm then
  --Instance guard
  xfdm = {}
  xfdm.step  = 0
  xfdm.readyStep = 5
  xfdm.msg = "TEST"
  xfdm.connectorQueue = {}  --Number Table
  xfdm.mappingQueue   = {}  --Number Table
  xfdm.connectorTimeout      = 10 --seconds
  xfdm.currentConnectorStartTimestamp = -1
  xfdm.connectors = {}      --Hash Table
  xfdm.callbacks  = {}
  xfdm.callbacks.sometimes = {} --Number Table
  xfdm.callbacks.often     = {} --Number Table
  xfdm.callbacks.always    = {} --Number Table
  do_every_draw("xfdm:showSimMsg()")
end

function xfdm:showSimMsg()
  if (self.msg ~= "") then
      draw_string_Helvetica_18(math.floor(SCREEN_WIDTH*0.1), math.floor(SCREEN_HEIGHT*0.8), self.msg)
  end
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

xfdmIoButton = "xfdmIoButton"
xfdmIoAxis   = "xfdmIoAxis"

xfdmLinkDataref = "xfdmLinkDataref"
xfdmLinkCommand = "xfdmLinkCommand"
xfdmLinkAxis    = "xfdmLinkAxis"

xfdmNullLink = "xfdmNullLink"

xfdmCallbackSometimes = "xfdmCallbackSometimes"
xfdmCallbackOften     = "xfdmCallbackOften"
xfdmCallbackAlways    = "xfdmCallbackAlways"

function xfdm:requestConnector(iConnectorName, iConnectorLinkType, iConnectorLink)
  table.insert(self.connectorQueue, {cName=iConnectorName, cLinkType=iConnectorLinkType, cLinkRef=iConnectorLink})
end

function xfdm:requestCallback(iCallbackFreq, iCallbackFunction)
  if     (iCallbackFreq == xfdmCallbackSometimes) then table.insert(self.callbacks.sometimes, {cFunc=iCallbackFunction})
  elseif (iCallbackFreq == xfdmCallbackOften)     then table.insert(self.callbacks.often,     {cFunc=iCallbackFunction})
  elseif (iCallbackFreq == xfdmCallbackAlways)    then table.insert(self.callbacks.always,    {cFunc=iCallbackFunction})
  end
end

function xfdm:requestMapping(iConnectorName, iMappingType, iMappingIndex, iAxisReverse)
  if not iAxisReverse then
    iAxisReverse = "normal"
  end
  table.insert(self.mappingQueue, {cName=iConnectorName, cMappingType=iMappingType, cMappingId=iMappingIndex, cMappingDir=iAxisReverse})
end

function xfdm:linkConnector(iConnectorName, iConnectorLinkType, iConnectorLink)
  if (self.connectors[iConnectorName]) then
    self.connectors[iConnectorName].cLinkRef  = iConnectorLink
    self.connectors[iConnectorName].cLinkType = iConnectorLinkType
    logMsg(string.format("XFDM - linkConnector: Connector %s already exists, overriding with \"%s\"", iConnectorName, iConnectorLink))
  else
    self.connectors[iConnectorName] = {cLinkType=iConnectorLinkType, cMappingId=-1, cLinkRef=iConnectorLink}
    logMsg(string.format("XFDM - linkConnector: Created a new %s connector to \"%s\"", iConnectorLinkType, iConnectorLink))
  end
end

function xfdm:mapConnector(iConnectorName, iMappingType, iMappingIndex, iAxisReverse)
  if not self.connectors[iConnectorName] then
    logMsg(string.format("XFDM - mapConnector: Requested connector \"%s\" does not exist, creating a new one mapped to %s", iConnectorName, xfdmNullLink))
    self.linkConnector(iConnectorName, xfdmLinkDataref, xfdmNullLink)
  end
  if (self.connectors[iConnectorName].cMappingId ~= -1) then
    logMsg(string.format("XFDM - mapConnector(warning): Requested connector \"%s\" was planning to be mapped to %s %d but has been overriden to %s %d.", iConnectorName, self.connectors[iConnectorName].cMappingType, self.connectors[iConnectorName].cMappingId, iMappingType, iMappingIndex))
  end
  if (self.connectors[iConnectorName].cLinkType == xfdmLinkDataref) then
    logMsg(string.format("XFDM - mapConnector(info): Requested connector \"%s\" is linked to a dataref, mapping to none. This probably means that another module will read the button or axis directly.", iConnectorName))
    self.connectors[iConnectorName].cLinkRef = xfdmNullLink
  end
  self.connectors[iConnectorName].cMappingType = iMappingType
  self.connectors[iConnectorName].cMappingId   = iMappingIndex
  self.connectors[iConnectorName].cMappingDir  = iAxisReverse
end

function xfdm:checkConnectorLink(iConnectorCandidate)
  if     (iConnectorCandidate.cLinkType == xfdmLinkAxis)    then
    return true
  elseif (iConnectorCandidate.cLinkType == xfdmLinkDataref) then
    return XPLMFindDataRef(iConnectorCandidate.cLinkRef)
  elseif (iConnectorCandidate.cLinkType == xfdmLinkCommand) then
    if (iConnectorCandidate.cLinkRef == xfdmNullLink) then
      return true
    else
      return XPLMFindCommand(iConnectorCandidate.cLinkRef)
    end
  else
    return false
  end
end

function xfdm:tryToCreateNextConnector()
  if(self:checkConnectorLink(self.connectorQueue[1])) then
    self:linkConnector(self.connectorQueue[1].cName, self.connectorQueue[1].cLinkType, self.connectorQueue[1].cLinkRef)
    self.msg = string.format("XFDM: Created a connector linked to \"%s\".", self.connectorQueue[1].cLinkRef)
    table.remove(self.connectorQueue, 1)
  else
    --Giving it some time
    if (self.currentConnectorStartTimestamp == -1) then
      self.currentConnectorStartTimestamp = get("sim/time/total_running_time_sec")
    end
    local sElapsedTime = get("sim/time/total_running_time_sec") - self.currentConnectorStartTimestamp
    self.msg = string.format("XFDM: Waiting on \"%s\" to be created. %d/%d sec", self.connectorQueue[1].cLinkRef, sElapsedTime, self.connectorTimeout)
    if (sElapsedTime > self.connectorTimeout) then
      self.currentConnectorStartTimestamp = -1
      logMsg(string.format("XFDM - tryToCreateNextConnector(ERROR): \"%s\" (%s) could not be found within the timeout period. Overriding to dummy mapping.", self.connectorQueue[1].cLinkRef, self.connectorQueue[1].cLinkType))
      self.connectorQueue[1].cLinkType = xfdmLinkCommand
      self.connectorQueue[1].cLinkRef = xfdmNullLink
    end
  end
end

function xfdm:tryToMapNextConnector()
  self:mapConnector(self.mappingQueue[1].cName, self.mappingQueue[1].cMappingType, self.mappingQueue[1].cMappingId, self.mappingQueue[1].cMappingDir)
  self.msg = string.format("XFDM: Mapped the connector \"%s\" to %s %d.", self.mappingQueue[1].cName, self.mappingQueue[1].cMappingType, self.mappingQueue[1].cMappingId)
  table.remove(self.mappingQueue, 1)
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

function xfdm:connectorMappingRunner()
  if (table.getn(self.mappingQueue) == 0) then
    self.msg = "XFDM - connectorMappingRunner: All mappings have been processed."
    logMsg("XFDM - connectorMappingRunner: All mappings have been processed.")
    self.step = self.step + 1
  else
    self:tryToMapNextConnector()
  end
end


function xfdm:assignConnectors()
  for k,v in pairs(xfdm.connectors) do
    if (v.cMappingId ~= -1) then
      local tLinkRef = v.cLinkRef

      if (v.cMappingType == xfdmIoAxis) then
        local tLinkDir = v.cMappingDir
        if (v.cLinkType == xfdmNullLink) then tLinkDir = "normal" end
        if (tLinkRef == xfdmNullLink) then tLinkRef = "none" end
        set_axis_assignment(v.cMappingId, v.cLinkRef, v.cMappingDir)
        logMsg(string.format("XFDM - assignConnectors: Assigned axis %d to \"%s\".", v.cMappingId, v.cLinkRef))
      elseif (v.cMappingType == xfdmIoButton) then
        if (tLinkRef == xfdmNullLink) then tLinkRef = "sim/none/none" end
        set_button_assignment(v.cMappingId, v.cLinkRef)
        logMsg(string.format("XFDM - assignConnectors: Assigned button %d to \"%s\".", v.cMappingId, v.cLinkRef))
      end
    end
  end
  self.msg = "XFDM - assignConnectors: All assignments have been processed."
  logMsg("XFDM - assignConnectors: All mappings have been processed.")
  self.step = self.step + 1
end

function xfdm:runner()
  if     (self.step == 0) then self:connectorCreationRunner()
  elseif (self.step == 1) then self:connectorMappingRunner()
  elseif (self.step == 2) then self:assignConnectors()
  --elseif (self.step == 3) then self:connectorCallbacksRunner()
  end
end