function xfdm:readConnectorSrc(iConnectorName)
  if xfdm.connectors[iConnectorName].cSrcType == xfdmConInButton then
    return button(xfdm.connectors[iConnectorName].cSrcRef)
  end
end

function xfdm:readConnectorDest(iConnectorName, iConnectorValue)
  if self.connectors[iConnectorName].cDestType == xfdmConOutRwDataref then
    return get(self.connectors[iConnectorName].cDestRef)
  end
end

function xfdm:driveConnectorDest(iConnectorName, iConnectorValue)
  if self.connectors[iConnectorName].cDestType == xfdmConOutSimCommand then
    command_once(self.connectors[iConnectorName].cDestRef)
  end
end