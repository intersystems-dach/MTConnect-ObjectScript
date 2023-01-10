/// v1.0 <br>
/// Writes a log.
Class MTConnect.Logger Extends %RegisteredObject
{

/// The logfile
Property File As %File [ Private ];

/// Makes a new instance of the Logger
/// <li>pFilePath: A total path to a log file</li>
/// <li>pSc: If the Logger could be created</li>
/// <li><b>returns</b>: If the Logger could be created</li>
/// <EXAMPLE> Set logger = ##class(MTConnect.Logger).%New("path/to/log/file", .tSC)</EXAMPLE>
Method %OnNew(pFilePath As %String, ByRef pSc As %Status) As %Status
{
    #dim tSc as %Status = $$$OK

    If '##class(%File).Exists(pFilePath){
        Set tSc = $$$ERROR(pFilePath_" does not exists!")
        Set pSc = tSc
        Return tSc
    }
    Set ..File = ##class(%File).%New(pFilePath)
    Set tSc = ..Open()
    Do ..File.WriteLine("---")
    Set pSc = tSc
    Return tSc
}

/// Writes a line to the log
/// <li>line: The line</li>
/// <li><b>returns</b>: If the line could be written</li>
/// <EXAMPLE> Set tSC = instance.WriteLine("Text")</EXAMPLE>
Method WriteLine(line As %String) As %Status
{
    Return ..File.WriteLine("["_$ZDT($NOW())_"]   "_line)
}

/// Writes a error line to the log
/// <li>line: The line</li>
/// <li><b>returns</b>: If the line could be written</li>
/// <EXAMPLE> Set tSC = instance.WriteLine("ErrorText")</EXAMPLE>
Method WriteErrorLine(line As %String) As %Status
{
    Return ..File.WriteLine("["_$ZDT($NOW())_"]ERROR   "_line)
}

/// Opens the file
/// <li><b>returns</b>: If the file could be opened</li>
/// <EXAMPLE> Set tSC = instance.Open()</EXAMPLE>
Method Open() As %Status
{
    Return ..File.Open("WSR")
}

/// Closes the file
/// <EXAMPLE> Do instance.Close()</EXAMPLE>
Method Close()
{
    Do ..File.WriteLine("---")
    Do ..File.Close()
}

}

