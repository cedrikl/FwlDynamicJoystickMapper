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

--require("xfdm.interaction")

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

xfdmConInButton          = "xfdmConnectorInputJoyButton"
xfdmConInAxis            = "xfdmConnectorInputJoyAxis"
xfdmConInDataref         = "xfdmConnectorInputDataref"
xfdmConInOtherCon        = "xfdmConnectorInputOtherConnector"

xfdmConOutSimAxis        = "xfdmConnectorLinkAxis"
xfdmConOutRoDataref      = "xfdmConnectorLinkRoDataref"
xfdmConOutRwDataref      = "xfdmConnectorLinkRwDataref"
xfdmConOutSimCommand     = "xfdmConnectorLinkCommand"
xfdmConOutOtherConnector = "xfdmConnectorLinkConnector"

xfdmNullLink = "xfdmNullLink"

xfdmCallbackSometimes = "xfdmCallbackSometimes"
xfdmCallbackOften     = "xfdmCallbackOften"
xfdmCallbackAlways    = "xfdmCallbackAlways"

function xfdm:requestConnector(iConnName, iConnDestType, iConnDestRef)
  table.insert(self.connectorQueue, {cName=iConnName, cDestType=iConnDestType, cDestRef=iConnDestRef})
end

function xfdm:requestCallback(iCallFreq, iCallFunc)
  if     (iCallFreq == xfdmCallbackSometimes) then table.insert(self.callbacks.sometimes, {cFunc=iCallFunc})
  elseif (iCallFreq == xfdmCallbackOften)     then table.insert(self.callbacks.often,     {cFunc=iCallFunc})
  elseif (iCallFreq == xfdmCallbackAlways)    then table.insert(self.callbacks.always,    {cFunc=iCallFunc})
  end
end

function xfdm:requestMapping(iConnName, iConnSrcType, iConnSrcRef, iConnSrcRev)
  if not iConnSrcRev then
    iConnSrcRev = "normal"
  end
  table.insert(self.mappingQueue, {cName=iConnName, cSrcType=iConnSrcType, cSrcRef=iConnSrcRef, cSrcInvert=iConnSrcRev})
end

function xfdm:setConnectorDest(iConnName, iConnDestType, iConnDestRef)
  if (self.connectors[iConnName]) then
    logMsg(string.format("XFDM - linkConnector: Connector %s already exists, overriding with \"%s\"", iConnName, iConnDestRef))
    self.connectors[iConnName].cDestType = iConnDestType
    self.connectors[iConnName].cDestRef  = iConnDestRef
  else
    self.connectors[iConnName] = {cDestType=iConnDestType, cSrcRef=xfdmNullLink, cDestRef=iConnDestRef}
    logMsg(string.format("XFDM - linkConnector: Created a new %s connector to \"%s\"", iConnDestType, iConnDestRef))
  end
end

function xfdm:setConnectorSource(iConnName, iConnSrcType, iConnSrcRef, iConnSrcRev)
  if not self.connectors[iConnName] then
    logMsg(string.format("XFDM - mapConnector: Requested connector \"%s\" does not exist, creating a new one mapped to %s", iConnName, xfdmNullLink))
    self.linkConnector(iConnName, xfdmLinkRwDataref, xfdmNullLink)
  end
  if (self.connectors[iConnName].cSrcRef ~= xfdmNullLink) then
    logMsg(string.format("XFDM - mapConnector(warning): Requested connector \"%s\" was planning to be mapped to %s %s but has been overriden to %s %s.", iConnName, self.connectors[iConnName].cSrcType, self.connectors[iConnName].cSrcRef, iSrcType, iSrcRef))
  end
  if ((self.connectors[iConnName].cDestType == xfdmLinkRoDataref) or (self.connectors[iConnName].cDestType == xfdmLinkRwDataref)) then
    logMsg(string.format("XFDM - mapConnector(info): Requested connector \"%s\" is linked to a dataref. This probably means that another module will read interect with it directly.", iConnName))
  end
  self.connectors[iConnName].cSrcType   = iConnSrcType
  self.connectors[iConnName].cSrcRef    = iConnSrcRef
  self.connectors[iConnName].cSrcInvert = iConnSrcRev
end

function xfdm:checkConnectorDest(iConnCandidate)
  if     (iConnCandidate.cDestType == xfdmConOutSimAxis)         then return true
  elseif (iConnCandidate.cDestType == xfdmConOutOtherConnector)  then return true
  elseif (iConnCandidate.cDestType == xfdmConOutRwDataref)       then return XPLMFindDataRef(iConnCandidate.cDestRef)
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

function xfdm:tryToCreateNextConnector()
  if(self:checkConnectorDest(self.connectorQueue[1])) then
    self:setConnectorDest(self.connectorQueue[1].cName, self.connectorQueue[1].cDestType, self.connectorQueue[1].cDestRef)
    self.msg = string.format("XFDM: Created a connector linked to \"%s\".", self.connectorQueue[1].cDestRef)
    table.remove(self.connectorQueue, 1)
  else
    --Giving it some time
    if (self.currentConnectorStartTimestamp == -1) then
      self.currentConnectorStartTimestamp = get("sim/time/total_running_time_sec")
    end
    local sElapsedTime = get("sim/time/total_running_time_sec") - self.currentConnectorStartTimestamp
    self.msg = string.format("XFDM: Waiting on \"%s\" to be created. %d/%d sec", self.connectorQueue[1].cDestRef, sElapsedTime, self.connectorTimeout)
    if (sElapsedTime > self.connectorTimeout) then
      self.currentConnectorStartTimestamp = -1
      logMsg(string.format("XFDM - tryToCreateNextConnector(ERROR): \"%s\" (%s) could not be found within the timeout period. Overriding to dummy mapping.", self.connectorQueue[1].cLinkRef, self.connectorQueue[1].cLinkType))
      self.connectorQueue[1].cDestType = xfdmLinkCommand
      self.connectorQueue[1].cDestRef = xfdmNullLink
    end
  end
end

function xfdm:tryToSetNextConnectorSrc()
  self:setConnectorSource(self.mappingQueue[1].cName, self.mappingQueue[1].cSrcType, self.mappingQueue[1].cSrcRef, self.mappingQueue[1].cSrcInvert)
  self.msg = string.format("XFDM: Mapped the connector \"%s\" to %s %d.", self.mappingQueue[1].cName, self.mappingQueue[1].cSrcType, self.mappingQueue[1].cSrcRef)
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

function xfdm:connectorSourceRunner()
  if (table.getn(self.mappingQueue) == 0) then
    self.msg = "XFDM - connectorMappingRunner: All mappings have been processed."
    logMsg("XFDM - connectorMappingRunner: All mappings have been processed.")
    self.step = self.step + 1
  else
    self:tryToSetNextConnectorSrc()
  end
end

function xfdm:assignConnectors()
  for k,v in pairs(xfdm.connectors) do
    if (v.cSrcRef ~= xfdmNullLink) then
      local tDestRef = v.cDestRef

      if (v.cSrcType == xfdmConInAxis) then
        local tSrcDir = v.cSrcInvert
        if (tDestRef == xfdmNullLink) then
          tSrcDir = "normal"
          tDestRef = "none"
        end
        set_axis_assignment(v.cSrcRef, tDestRef, tSrcDir)
        logMsg(string.format("XFDM - assignConnectors: Assigned axis %d to \"%s\".", v.cSrcRef, v.cDestRef))
      elseif (v.cSrcType == xfdmConInButton) then
        if (tDestRef == xfdmNullLink) then tDestRef = "sim/none/none" end
        set_button_assignment(v.cSrcRef, v.cDestRef)
        logMsg(string.format("XFDM - assignConnectors: Assigned button %d to \"%s\".", v.cSrcRef, v.cDestRef))
      end
    end
  end
  self.msg = "XFDM - assignConnectors: All assignments have been processed."
  logMsg("XFDM - assignConnectors: All mappings have been processed.")
  self.step = self.step + 1
end

function xfdm:runner()
  if     (self.step == 0) then self:connectorCreationRunner()
  elseif (self.step == 1) then self:connectorSourceRunner()
  elseif (self.step == 2) then self:assignConnectors()
  --elseif (self.step == 3) then self:connectorCallbacksRunner()
  end
end