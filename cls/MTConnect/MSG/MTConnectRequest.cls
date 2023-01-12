/// v1.2 <br>
/// A request class for <CLASS>MTConnect.BO.ClassBuilder</CLASS> and <CLASS>MTConnect.BO.CurrentBuilder</CLASS>.
Class MTConnect.MSG.MTConnectRequest Extends Ens.Request
{

/// When currentToFile is true this is the path to the current File. If not this is the current file as a string.
Property current As %String(MAXLEN = 1000000);

/// Set if current will be a file or a string.
Property currentToFile As %Boolean;

/// When probeFromFile is true this is the path to the probe File. If not this is the probe file as a string.
Property probe As %String(MAXLEN = 1000000);

/// Set if probe will be a file or a string.
Property probeFromFile As %Boolean;

/// The Line received from a connection
Property recievedLine As %String(MAXLEN = 50000);

/// The classname of the class that was created
Property className As %String(MAXLEN = 50000);

/// Returns a String with all properties
/// <li><b>returns</b>: The String</li>
/// <EXAMPLE> Set s = instance.ToString()</EXAMPLE>
Method ToString() As %String
{
    Set s = ""
    If ..probeFromFile{
        Set s = s_"ProbeFromFile:"_..probe
    }
    Else{
        Set s = s_"ProbeFromString"
    }

    If ..currentToFile{
        Set s = s_";CurrentToFile:"_..current
    }
    Else{
        Set s = s_";CurrentToString"
    }
    If ..recievedLine '= ""{
        Set s = s_";receievedLine:"_..recievedLine
    }
    If ..className '= ""{
        Set s = s_";className:"_..className
    }
    Return s
}

Method SetCurrent(c As %String) [ Private ]
{
    Set ..current = c
    Try{
        Do ##class(%XML.TextReader).ParseString(c,.textreader)
        Set ..currentToFile = 0
    }
    Catch{
        Set ..currentToFile = 1
    }
}

Method SetProbe(p As %String) [ Private ]
{
    Set ..probe = p
    If ##class(%File).Exists(p){
        Set ..probeFromFile = 1
    }
    Else{
        Set ..probeFromFile = 0
    }
}

Method %OnNew() As %Status
{
    Set ..current = ""
    Set ..probe = ""
    Set ..recievedLine = ""
    Set ..probeFromFile = 0
    Set ..currentToFile = 0
    Return $$$OK
}

/// Convert this request to a response
/// <li><b>returns</b>: The response</li>
/// <EXAMPLE> Set response = instance.toResponse()</EXAMPLE>
Method toResponse() As MTConnectResponse
{
    Set r = ##class(MTConnect.MSG.MTConnectResponse).%New()
    Set r.current = ..current
    Set r.currentToFile = ..currentToFile
    Set r.probe = ..probe
    Set r.probeFromFile = ..probeFromFile
    Set r.recievedLine = ..recievedLine
    Set r.className = ..className
    Return r
}

Storage Default
{
<Data name="MTConnectRequestDefaultData">
<Subscript>"MTConnectRequest"</Subscript>
<Value name="1">
<Value>current</Value>
</Value>
<Value name="2">
<Value>currentToFile</Value>
</Value>
<Value name="3">
<Value>probe</Value>
</Value>
<Value name="4">
<Value>probeFromFile</Value>
</Value>
<Value name="5">
<Value>recievedLine</Value>
</Value>
<Value name="6">
<Value>className</Value>
</Value>
</Data>
<DefaultData>MTConnectRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}

