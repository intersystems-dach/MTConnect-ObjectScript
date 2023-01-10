/// v1.3 <br>
/// Builds a table structure for a MTConnect current file based on a probe file.
Class MTConnect.BO.ClassBuilder Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Parameter SETTINGS = "PackageName:MTConnect,suffixClass:MTConnect,Kind:MTConnect,ClearData:MTConnect,SuperClasses:MTConnect,GenerateDataTypes:MTConnectDataTypes,DataTypesPackage:MTConnectDataTypes,GenerateIsValid:MTConnectDataTypes,GenerateNormalize:MTConnectDataTypes,GenerateLogicalToDisplay:MTConnectDataTypes,GenerateDisplayToLogical:MTConnectDataTypes,Log:LOG,LogFile:LOG";

// MTConnect

/// The Name of the Package where the data gets insert
Property PackageName As %String(MAXLEN = 100);

/// The suffix of the className
Property suffixClass As %String(MAXLEN = 100);

/// The devicename from the probe file
Property deviceName As %String(MAXLEN = 100);

/// Comma seperated String for the super classes of the built class
Property SuperClasses As %String(MAXLEN = 100);

/// Specify if the ID or Name Attribute is used.
Property Kind As %String(MAXLEN = 10, VALUELIST = ",ID, Name") [ InitialExpression = "ID" ];

/// If set the table gets cleared when a log clear received
Property ClearData As %Boolean;

// MTConnectDataTypes

/// When activated the MTConnect Datatypes will be generated atomatically
Property GenerateDataTypes As %Boolean;

/// The Packagename of the MTConnect datatypes package
Property DataTypesPackage As %String(MAXLEN = 100) [ InitialExpression = "MTConnect.DataTypes" ];

/// If activated generates a IsValid Method for the DataTypes
Property GenerateIsValid As %Boolean [ InitialExpression = 1 ];

/// If activated generates a Normalize Method for the DataTypes
Property GenerateNormalize As %Boolean [ InitialExpression = 1 ];

/// If activated generates a LogicalToDisplay Method for the DataTypes
Property GenerateLogicalToDisplay As %Boolean [ InitialExpression = 1 ];

/// If activated generates a DisplayToLogical Method for the DataTypes
Property GenerateDisplayToLogical As %Boolean [ InitialExpression = 1 ];

// LOG

/// Active the Logger
Property Log As %Boolean;

/// Path to LogFile
Property LogFile As %String(MAXLEN = 1000);

/// A Logger to write the log
Property Logger As MTConnect.Logger [ Private ];

/// Only used for testcases
Method test(ByRef req As MTConnect.MSG.MTConnectRequest) [ Private ]
{
    Set req.current = "C:\Users\pbonin\Downloads\current.xml"
    Set req.probe = "C:\Users\pbonin\Downloads\probe.xml"
    Set req.probeFromFile = 1
    Set req.currentToFile = 1
}

/// Builds the class if it does not exists and inserts current data
/// <li>pRequest: The Request</li>
/// <li>pResponse: The Response</li>
/// <li><b>returns</b>: If the class could be build</li>
Method Execute(pRequest As MTConnect.MSG.MTConnectRequest, Output pResponse As MTConnect.MSG.MTConnectResponse) As %Status
{

    Do ..test(.pRequest)


    //Setup Logger
    If ..Log{
        Set ..Logger = ##class(MTConnect.Logger).%New(..LogFile, .logSc)
        If $$$ISERR(logSc){
            Set ..Log = 0
        }
    }

    //Write request to log
    Do ..WriteToLog("REQUEST:"_pRequest.ToString())

    //Get DeviceName
    If ..deviceName = ""{
        Set ..deviceName = ..GetDeviceName(pRequest.probe, pRequest.probeFromFile)
        If $F(..deviceName,"-") '= 0{
            Set ..deviceName = $REPLACE(..deviceName,"-","")
        }
    }
    
    //CLEAR LOG
    If pRequest.recievedLine = "***CL***" {
        If ..ClearData{
            Set stmt = ##class(%SQL.Statement).%New()
            Set sql = "DELETE FROM "_..ConvertClassName(..GetClassName())
            Do stmt.%Prepare(sql)
            Do stmt.%Execute()
        }      

        Set pResponse = pRequest.toResponse()  
        Set pResponse.className = ..GetClassName()
        Do ..WriteToLog("Data cleared!")
		Return $$$OK
	}

    //Build Class
    Set tSc = ..BuildClass(pRequest.probe,pRequest.probeFromFile)
    If $$$ISERR(tSc){
        Do ..WriteErrorToLog("Class could not be Built"_$SYSTEM.Status.GetErrorText(tSc))
        Return tSc
    }

    //Set timestamp
    If pRequest.recievedLine '= ""{
        Set timestamp = $P(pRequest.recievedLine,"|")
    }
    Else{
        Set timestamp = $REPLACE(..GetCreationTime(pRequest.current,pRequest.currentToFile),"Z","")
    }

    //Insert current in table
    Set tSc = ..InsertCurrent(pRequest.current,timestamp,pRequest.currentToFile)
    //Set response
    Set pResponse = pRequest.toResponse()
    
    Set pResponse.className = ..GetClassName()

    Do ..WriteToLog("RESPONSE:"_pResponse.ToString())


    //Close Logger
    If ..Log{
        Do ..Logger.Close()
    }

    Return tSc
}

/// Build the class based on probe if it does not exists
/// <li>probe: The path to the probe file</li>
/// <li>fromFile(optional): if 1: reads probe from file; if 0: provide the probe data in the probe parameter</li>
/// <li><b>returns</b>: If the class could be built</li>
/// <EXAMPLE> Do instance.BuildClass("/path/to/probe.xml")</EXAMPLE>
/// <EXAMPLE> Do instance.BuildClass("<xml>probe</xml>",0)</EXAMPLE>
Method BuildClass(probe As %String, fromFile As %Boolean = 1) As %Status
{

    Set className = ..GetClassName()

    //IF class already exists return $$$OK
    If ..CheckIfClassExists(className){
        Return $$$OK
    }

    //Get the dataitems from probe file
    Set l = ..GetDataItems(probe,fromFile)

    //Build the class based on name or id
    If ..Kind = "Name"{
        Set sc = ..BuildClassHelper(l, className, "name")
    }
    ElseIf ..Kind = "ID"{
        Set sc = ..BuildClassHelper(l, className, "id")
    }

    //write to log
    If sc{
        Do ..WriteToLog("Class built:"_..GetClassName())
    }
    Else{
        Do ..WriteErrorToLog("Something went wrong building the class:"_$SYSTEM.Status.GetErrorText(sc))
    }

    Return sc
}

/// reads the attributes from the DataItems specified in the probe file
/// <li>probe: The path to the probe file</li>
/// <li>(optional)fromFile: if 1: reads probe from file; if 0: provide the probe data in the probe parameter</li>
/// <li><b>returns</b>: </li>
/// <EXAMPLE> Do ##class(MTConnect.BO.ClassBuilder).GetDataItems()</EXAMPLE>
Method GetDataItems(probe As %String, fromFile As %Boolean = 1) As %ListOfObjects [ Private ]
{
    If fromFile{
        Set status=##class(%XML.TextReader).ParseFile(probe,.textreader)
    }
    Else{
        Set status=##class(%XML.TextReader).ParseString(probe,.textreader)
    }
    //check status
    If $$$ISERR(status) {Do $SYSTEM.Status.DisplayError(status) Quit}

    Set myList = ##class(%ListOfObjects).%New()

    //iterate through document, node by node
    While textreader.Read()
    {
        If textreader.Name ="DataItem"
        {
            If textreader.HasAttributes = 0{
                Continue
            }
            Set obj = ##class(%Library.DynamicObject).%New()
            For a = 1:1:textreader.AttributeCount {
                Do textreader.MoveToAttributeIndex(a)
                Do obj.%Set(textreader.LocalName, textreader.Value)
            }
            Do myList.Insert(obj)
        }
    }

    Return myList
}

/// Builds the class based on the Name Attribute
/// <li>listOfDataItems: list of dataitems from the probe file</li>
/// <li>className: The name of the class to build</li>
/// <li>kind: "name" or "id"</li>
/// <li><b>returns</b>: If the class could be built</li>
Method BuildClassHelper(listOfDataItems As %ListOfObjects, className As %String, kind As %String) As %Status [ Private ]
{
    #dim tSc as %Status = $$$OK

    //Define Class
	Set cdef = ##class(%Dictionary.ClassDefinition).%New(className)
 	If $SYSTEM.Status.IsError(cdef) {
	 	Do $SYSTEM.Status.DecomposeStatus(%objlasterror,.Err) 
 		Return Err
 	}
    Set cdef.ProcedureBlock = 1

    //Set cdef.DdlAllowed = 1

    //Add superclasses
    If ..SuperClasses '= ""{
        Set cdef.Super = "%Persistent,"_..SuperClasses
    }
    Else{
        Set cdef.Super = "%Persistent"
    }

    //Add TimeStamp
    Set pdef = ##class(%Dictionary.PropertyDefinition).%New(className_":timestamp")
    If $SYSTEM.Status.IsError(pdef) {
		Do $SYSTEM.Status.DecomposeStatus(%objlasterror,.Err) 
		Throw Err
	}
	Do cdef.Properties.Insert(pdef)
	Set pdef.Type = "%Library.TimeStamp"

    Set type = "%String"

    //Generate NONETYPE
    If '##class(%Dictionary.CompiledClass).%ExistsId(..DataTypesPackage_".NONETYPE"){
        Set sc = ..GenerateNoneType()
        If $$$ISERR(sc){
            Do ..WriteErrorToLog("Could not generate NONETYPE: "_$SYSTEM.Status.GetErrorText(sc))
        }
        Else{
            Set type = ..DataTypesPackage_".NONETYPE"
            Do ..WriteToLog(type_" created")
        }
    }

    //iterate through list
    For i = 1:1:listOfDataItems.Count(){
        Set dataItem = listOfDataItems.GetAt(i)
        //skip if no name is defined
        If 'dataItem.%IsDefined(kind){
            Continue
        }

        Set pdef = ##class(%Dictionary.PropertyDefinition).%New(className_":"_dataItem.%Get(kind))
	 	If $SYSTEM.Status.IsError(pdef) {
		 	Do $SYSTEM.Status.DecomposeStatus(%objlasterror,.Err) 
            Do ..WriteErrorToLog("Could not define property "_dataItem.%Get(kind)_": "_$SYSTEM.Status.GetErrorText(Err))
		 	Return Err
	 	}
	 	
	 	//d pdef.Parameters.SetAt("AGE()", "POPSEC")
	 	Do cdef.Properties.Insert(pdef)
	 	Set pdef.Type = type
        
    }
    //Save class
 	Do cdef.%Save()

    //Compile class
    Try{
		$$$ThrowOnError($SYSTEM.OBJ.Compile(className, "/Display=none"))
	}
	Catch tEx {
        Do ..WriteErrorToLog("Could not compile class: "_$SYSTEM.Status.GetErrorText(tEx))
		Set tSc = tEx.AsStatus()
	}
    Return tSc
}

/// Inserts data from current
/// <li>current: The path to the current file</li>
/// <li>timestamp: The timestamp</li>
/// <li>fromFile(optional): if 1: reads current from file; if 0: provide the current data in the current parameter</li>
/// <li><b>returns</b>: If the current could be inserted</li>
/// <EXAMPLE> Set tSc = instance.InsertCurrent("path/to/current.xml",timestamp)</EXAMPLE>
/// <EXAMPLE> Set tSc = instance.InsertCurrent("<xml>current<xml>", timestamp,0)</EXAMPLE>
Method InsertCurrent(current As %String, timestamp As %String, fromFile As %Boolean = 1) As %Status
{
    If ..Kind = "Name"{
        Set l = ..ReadCurrentFile(current,"name",fromFile)
    }
    ElseIf ..Kind = "ID"{
        Set l = ..ReadCurrentFile(current,"dataItemId",fromFile)
    }

    //Set types
    Set tSc = ..SetTypes(l,..GetClassName())
    If $$$ISERR(tSc){
        Do ..WriteErrorToLog("Could not set types: "_$SYSTEM.Status.GetErrorText(tSc))
    }

    //insert
    Set sc = ..InsertCurrentHelper(l, ..GetClassName(), timestamp)
    Return sc
}

/// Reads the Values from the current file
/// <li>current: path to current file</li>
/// <li>kind: "name" or "dataItemId"</li>
/// <li>(optional)fromFile: if 1: reads current from file; if 0: provide the current data in the current parameter</li>
/// <li><b>returns</b>: A list of objects with all values from the current file</li>
Method ReadCurrentFile(current As %String, kind As %String, fromFile As %Boolean = 1) As %ListOfObjects [ Private ]
{

    If fromFile{
        Set status=##class(%XML.TextReader).ParseFile(current,.textreader)
    }
    Else{
        Set status=##class(%XML.TextReader).ParseString(current,.textreader)
    }
    //check status
    If $$$ISERR(status) {Do $SYSTEM.Status.DisplayError(status) Quit}
    Set myList = ##class(%ListOfObjects).%New()

    //iterate through document, node by node
    While textreader.Read()
    {

        Set name = 0
        For a = 1:1:textreader.AttributeCount {
            Do textreader.MoveToAttributeIndex(a)
            If textreader.LocalName = kind{
                Set name = textreader.Value
            }
        }
        If name '= 0{
            Do textreader.Read()
            If textreader.HasValue{
                Set obj = ##class(%Library.DynamicObject).%New()
                Do obj.%Set("name", name)
                Do obj.%Set("value", textreader.Value)
                Do obj.%Set("type", $REPLACE($P(textreader.Path,"/",*),"x:",""))
                Do myList.Insert(obj)
            }
        }        
    }

    Return myList
}

/// Inserts the current file to the table
/// <li>lst: The list of objects from <METHOD>ReadCurrentFile</METHOD></li>
/// <li>className: The class name </li>
/// <li>timestamp: a timestamp</li>
/// <li><b>returns</b>: If the data could be added</li>
Method InsertCurrentHelper(lst As %ListOfObjects, className As %String, timestamp As %String) As %Status [ Private ]
{

    // make new instance
    Set c = $SYSTEM.OBJ.New(className)

    //iterate through objects
    For i = 1:1:lst.Count(){
        Set obj =  lst.GetAt(i)

        //if data is UNAVAILABLE skip
        If obj.%Get("value") = "UNAVAILABLE"{
            Continue
        }
        
        //Set the property
        Try{
            Set $PROPERTY(c, obj.%Get("name")) = obj.%Get("value")
            Do ..WriteToLog( obj.%Get("name")_" set to value: "_obj.%Get("value"))
        }
        Catch{
            Do ..WriteErrorToLog( obj.%Get("name")_" could not be set to value: "_obj.%Get("value"))
        }
    }

    //Add timestamp
    Set c.timestamp = ##class(%Library.TimeStamp).DisplayToLogical((timestamp))

    //Save
    Set tSc = c.%Save()
    If $$$ISERR(tSc){
        Do ..WriteErrorToLog("Could not save current:"_$SYSTEM.Status.GetErrorText(tSc))
    }
    Return tSc
}

/// Set the types based on the current file
/// <li>lst: The list of objects from <METHOD>ReadCurrentFile</METHOD></li>
/// <li>className: The classname</li>
/// <li><b>returns</b>: If the Types could be set</li>
Method SetTypes(lst As %ListOfObjects, className As %String) As %Status [ Private ]
{
    #dim tSc as %Status = $$$OK

    //iterate through objects
    For i = 1:1:lst.Count(){
        Set obj =  lst.GetAt(i)

        //Check if there is a Objectscript-MTConnect-Datatype that fits to the current datatype
        If ##class(%Dictionary.CompiledClass).%ExistsId(..DataTypesPackage_"."_$ZCVT(obj.%Get("type"),"U")){
            Set type = ..DataTypesPackage_"."_$ZCVT(obj.%Get("type"),"U")
        }
        //if not the the type based on the value
        Else{
            If '..GenerateDataTypes{
                Do ..WriteErrorToLog("Could not find type: "_obj.%Get("type"))
            }

            //if data is UNAVAILABLE skip
            If obj.%Get("value") = "UNAVAILABLE"{
                Continue
            }

            Set type = "%String"
            If $ISVALIDDOUBLE(obj.%Get("value")){
                Set type = "%Double"
            }

            If ..GenerateDataTypes{
                Set dataTypesRequest = ##class(MTConnect.MSG.CreateDataTypeRequest).%New()
                Set dataTypesRequest.DataType = type
                Set dataTypesRequest.Name = $ZCVT(obj.%Get("type"),"U")
                Set sc = ##class(MTConnect.DataTypesBuilder).Execute(dataTypesRequest,
                                                                    ..DataTypesPackage,
                                                                    ..GenerateIsValid,
                                                                    ..GenerateNormalize,
                                                                    ..GenerateDisplayToLogical, 
                                                                    ..GenerateLogicalToDisplay)
                If $$$ISERR(sc){
                    Do ..WriteErrorToLog("Could not generate type: "_$ZCVT(obj.%Get("type"),"U")_" ("_$SYSTEM.Status.GetErrorText(sc)_")")
                    Continue
                }
                Do ..WriteToLog($ZCVT(obj.%Get("type"),"U")_" DataType created")
                Set type = ..DataTypesPackage_"."_$ZCVT(obj.%Get("type"),"U")
            }
        }
        
        //Create PropertyDefinition
        Set pdef = ##class(%Dictionary.PropertyDefinition).%OpenId(className_"||"_obj.%Get("name"),,.pSc)
        If $$$ISERR(pSc){
            Do ..WriteErrorToLog("Could not create property definition: "_$SYSTEM.Status.GetErrorText(pSc))
            Continue
        }
        //If pdef = ""{Continue}

        //Set new type if oldtype is differnt
        If type '= pdef.Type{
            Set oldType = pdef.Type
            Try{
                /* Set sql = "ALTER TABLE "_..ConvertClassName(className)_" ALTER COLUMN "_obj.%Get("name")_" "_type   
                Set tStatement = ##class(%SQL.Statement).%New()
                Set qStatus = tStatement.%Prepare(sql)
                If qStatus '= 1{Write "%Prepare failed:" Do $SYSTEM.Status.DisplayError(qStatus) Quit}
                Set resultSet = tStatement.%Execute() */
                Set pdef.Type = type
                Do pdef.%Save()
                Do ..WriteToLog(obj.%Get("name")_" set from "_oldType_" to "_type)
            }
            Catch tEx{
                Do ..WriteErrorToLog(obj.%Get("name")_" could not be set to "_type)
                Set tSc = tEx.AsStatus()
            }
        }
    }

    //Compile class
    Try{
		$$$ThrowOnError($SYSTEM.OBJ.Compile(className, "/Display=none"))
	}
	Catch tEx {
        Do ..WriteErrorToLog("Could not compile class: "_$SYSTEM.Status.GetErrorText(tEx))
		Set tSc = tEx.AsStatus()
	}
    Return tSc
}

/// Generates a NONETYPE Datatype
/// <li><b>returns</b>: If the Datatype could be generated</li>
/// <EXAMPLE> Set sc = instance.GenerateNoneType()</EXAMPLE>
Method GenerateNoneType() As %Status [ Private ]
{
    #dim tSc as %Status = $$$OK
    Set className = ..DataTypesPackage_".NONETYPE"
     //Define Class
	Set cdef = ##class(%Dictionary.ClassDefinition).%New(className)
 	If $SYSTEM.Status.IsError(cdef) {
	 	Do $SYSTEM.Status.DecomposeStatus(%objlasterror,.Err) 
 		Throw Err
 	}
    Set cdef.ProcedureBlock = 1
    Set cdef.Abstract = 1
    Set cdef.ClassType = "datatype"

    //DisplayToLogical
    Set mdefDTL = ##class(%Dictionary.MethodDefinition).%New(className_":DisplayToLogical")
    If $SYSTEM.Status.IsError(mdefDTL) {
		Do $SYSTEM.Status.DecomposeStatus(%objlasterror,.Err) 
		Throw Err
	}
	Do cdef.Methods.Insert(mdefDTL)
	Do mdefDTL.FormalSpecSet("%val:%String")
	Set mdefDTL.ReturnType  = className
	Set mdefDTL.ClassMethod  = 1
    Set mdefDTL.Implementation.LineTerminator = $C(13,10)
    Do mdefDTL.Implementation.WriteLine("	Return """"")

    //LogicalToDisplay
    Set mdefLTD = ##class(%Dictionary.MethodDefinition).%New(className_":LogicalToDisplay")
    If $SYSTEM.Status.IsError(mdefLTD) {
		Do $SYSTEM.Status.DecomposeStatus(%objlasterror,.Err) 
		Throw Err
	}
	Do cdef.Methods.Insert(mdefLTD)
	Do mdefLTD.FormalSpecSet("%val:"_className)
	Set mdefLTD.ReturnType  = "%String"
	Set mdefLTD.ClassMethod  = 1
    Set mdefLTD.Implementation.LineTerminator = $C(13,10)
    Do mdefLTD.Implementation.WriteLine("	Return ""UNAVAILABLE""")

 	Do cdef.%Save()

    //Compile class
    Try{
		$$$ThrowOnError($SYSTEM.OBJ.Compile(className, "/Display=none"))
	}
	Catch tEx {
		Set tSc = tEx.AsStatus()
	}

    Return tSc
}

/// Ckecks if the class exists
/// <li>className: The className of the class</li>
/// <li><b>returns</b>: If the class exists</li>
/// <EXAMPLE> Set exist = ##class(MTConnect.BO.ClassBuilder).CheckIfClassExists("Pkg.ClassName")</EXAMPLE>
ClassMethod CheckIfClassExists(className As %String) As %Boolean
{
    Return ##class(%Dictionary.CompiledClass).%ExistsId(className)
}

/// Returns the complete className 
/// <li><b>returns</b>: The complete className</li>
/// <EXAMPLE> Set className = instance.GetClassName()</EXAMPLE>
Method GetClassName() As %String
{
    Return ..PackageName_"."_..deviceName_..Kind_..suffixClass
}

/// Reads the Creationtime from the current file
/// <li>current: The current file or data</li>
/// <li>(optional)fromFile: if 1: reads current from file; if 0: reads current from the current parameter</li>
/// <li><b>returns</b>: The creation time</li>
Method GetCreationTime(current As %String, fromFile As %Boolean = 1) As %String [ Private ]
{
    If fromFile{
        Set status=##class(%XML.TextReader).ParseFile(current,.textreader)
    }
    Else{
        Set status=##class(%XML.TextReader).ParseString(current,.textreader)
    }
    //check status
    If $$$ISERR(status) {Do $SYSTEM.Status.DisplayError(status) Quit}


    //iterate through document, node by node
    While textreader.Read()
    {
        If textreader.Name ="Header"
        {
            For a = 1:1:textreader.AttributeCount {
                Do textreader.MoveToAttributeIndex(a)
                If textreader.LocalName = "creationTime"{
                    Return textreader.Value
                }
            }
        }
    }
    Return $$$ERROR("creationTime not found")
}

/// Reads the device name from the probe file
/// <li>probe: The probe file</li>
/// <li>(optional)fromFile: if 1: reads probe from file; if 0: reads probe from the probe parameter</li>
/// <li><b>returns</b>: The devicename</li>
Method GetDeviceName(probe As %String, fromFile As %Boolean = 1) As %String [ Private ]
{
    If fromFile{
        Set status=##class(%XML.TextReader).ParseFile(probe,.textreader)
    }
    Else{
        Set status=##class(%XML.TextReader).ParseString(probe,.textreader)
    }
    //check status
    If $$$ISERR(status) {Do $SYSTEM.Status.DisplayError(status) Quit}


    //iterate through document, node by node
    While textreader.Read()
    {
        If textreader.Name ="Device"
        {
            For a = 1:1:textreader.AttributeCount {
                Do textreader.MoveToAttributeIndex(a)
                If textreader.LocalName = "name"{
                    Return textreader.Value
                }
            }
        }
    }
    Return $$$ERROR("Name not found")
}

/// Converts the classname for SQL by replacing the package dots with underscores.
/// <li>className: The original classname</li>
/// <li><b>returns</b>: The converted classname</li>
/// <EXAMPLE> Set sqlClassName = ##class(MTConnect.BO.ClassBuilder).ConvertClassName("Package1.Package2.ClassName")</EXAMPLE>
ClassMethod ConvertClassName(className As %String) As %String
{
    Set dotCount = $L(className,".")
    Set dotCount = dotCount - 2
    Return $REPLACE(className,".","_",,dotCount)
}

/// Writes a line to the logfile
/// <li>line: The line to log</li>
/// <EXAMPLE> Do instance.WriteToLog("text")</EXAMPLE>
Method WriteToLog(line As %String) [ Private ]
{
    If ..Log{
        Do ..Logger.WriteLine(line)
    }
}

/// Writes a error line to the logfile
/// <li>line: The error line to log</li>
/// <EXAMPLE> Do instance.WriteErrorToLog("errorText")</EXAMPLE>
Method WriteErrorToLog(line As %String) [ Private ]
{
    If ..Log{
        Do ..Logger.WriteErrorLine(line)
    }
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="MTConnect.MSG.MTConnectRequest"> 
		<Method>Execute</Method>
	</MapItem>
</MapItems>
}

// OLD ---------------------------------------------------------------------------------------------------------------------------------------------------

/* 	<MapItem MessageType="MTConnect.MSG.FromFileRequest"> 
		<Method>FromFile</Method>
	</MapItem>
	<MapItem MessageType="MTConnect.MSG.FromStringRequest"> 
		<Method>FromString</Method>
	</MapItem> */

/* /// OLD
Method FromString(
	pRequest As MTConnect.MSG.FromStringRequest,
	Output pResponse As Ens.StringResponse) As %Status 
{
    Set tSc = ##class(MTConnect.BO.ClassBuilder).BuildClass(pRequest.probeValue,0)
                                          
    If $$$ISERR(tSc){
        Return tSc
    }
    Set pResponse = ##class(Ens.StringResponse).%New()
    Set pResponse.StringValue = $REPLACE(##class(MTConnect.BO.ClassBuilder).GetCreationTime(pRequest.currentValue,0),"Z","")
    Set timestamp = pResponse.StringValue
    Set tSc = ##class(MTConnect.BO.ClassBuilder).InsertCurrent(pRequest.currentValue,timestamp,0)
                                                            
    Return tSc
}

/// OLD
Method FromFile(
	pRequest As MTConnect.MSG.FromFileRequest,
	Output pResponse As Ens.StringResponse) As %Status
{
    Set tSc = ##class(MTConnect.BO.ClassBuilder).BuildClass(pRequest.probePath)
    If $$$ISERR(tSc){
        Return tSc
    }
    Set tSc = ##class(MTConnect.BO.ClassBuilder).InsertCurrent(pRequest.currentPath,$P(pRequest.recievedLine,"|"))
    Return tSc
} */
}

