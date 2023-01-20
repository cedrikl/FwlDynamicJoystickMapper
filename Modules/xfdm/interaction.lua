function xfdm:readConnectorSrc(iConnectorName, iArrayIndex)
  local tSrcType = xfdm.connectors[iConnectorName].cSrcType
  local tSrcRef  = xfdm.connectors[iConnectorName].cSrcRef
  if tSrcType == xfdmConInOtherCon then
    tSrcType, tSrcRef = findTopConnector(iConnectorName)
  end

  if tSrcType == xfdmConInButton then
    return button(tSrcRef)
  elseif tSrcType == xfdmConInAxis then
    return get("sim/joystick/joystick_axis_values", tSrcRef)
  end
end

function xfdm:readConnectorDest(iConnectorName, iArrayIndex)
  local tDestType = xfdm.connectors[iConnectorName].cDestType
  local tDestRef  = xfdm.connectors[iConnectorName].cDestRef

  if tDestType == xfdmConOutOtherCon then
    tDestType, tDestRef = findLastConnector(iConnectorName)
  end

  if (tDestType == xfdmConOutRwDataref) or (tDestType == xfdmConOutRoDataref) then
    if iArrayIndex then
      return get(tDestRef, iArrayIndex)
    else
      return get(tDestRef)
    end
  end
end

function xfdm:driveConnectorDest(iConnectorName, iArrayIndex, iConnectorValue)
  local tDestType = xfdm.connectors[iConnectorName].cDestType
  local tDestRef  = xfdm.connectors[iConnectorName].cDestRef

  if (tDestRef ~= xfdmNullLink) then
    if tDestType == xfdmConOutOtherCon then
      tDestType, tDestRef = findLastConnector(iConnectorName)
    end

    if (tDestType == xfdmConOutRwDataref) or (tDestType == xfdmConOutRwDataref) then
      if iArrayIndex then
        return set_array(tDestRef, iArrayIndex, iConnectorValue)
      else
        return set(tDestRef, iConnectorValue)
      end
    elseif tDestType == xfdmConOutSimCommand then
      command_once(tDestRef)
    end
  end
end