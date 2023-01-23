/// v1.1 <br>
/// Creates a MTConnect Datatype based on a <CLASS>MTConnect.MSG.CreateDataTypeRequest</CLASS>.
/// Currently only works with %String and %Double.
Class MTConnect.DataTypesBuilder [ Abstract ]
{

/// Creates a DataType based on the CreateDataTypeRequest
/// <li>pRequest: The request</li>
/// <li>(optional)pPackage: The package where the Datatypes will be generated</li>
/// <li>(optional)pGenerateIsValid: If true will generate the Methdo IsValid</li>
/// <li>(optional)pGenerateNormalize: If true will generate the Methdo Normalize</li>
/// <li>(optional)pGenerateDisplayToLogical: If true will generate the Methdo DisplayToLogical</li>
/// <li>(optional)pGenerateLogicalToDisplay: If true will generate the Methdo LogicalToDisplay</li>
/// <li><b>returns</b>: If the class could be generated</li>
/// <EXAMPLE> Do ##class(MTConnect.DataTypesBuilder).Execute(request,"Package.Name")</EXAMPLE>
/// <EXAMPLE> Do ##class(MTConnect.DataTypesBuilder).Execute(request,"Package.Name",0,0,0,0)</EXAMPLE>
ClassMethod Execute(pRequest As MTConnect.MSG.CreateDataTypeRequest, pPackage As %String = "MTConnect.DataTypes", pGenerateIsValid As %Boolean = 1, pGenerateNormalize As %Boolean = 1, pGenerateDisplayToLogical As %Boolean = 1, pGenerateLogicalToDisplay As %Boolean = 1) As %Status
{
    #dim tSc as %Status = $$$OK
    Set className = pPackage_"."_pRequest.Name
     //Define Class
	Set cdef = ##class(%Dictionary.ClassDefinition).%New(className)
 	If $SYSTEM.Status.IsError(cdef) {
	 	Do $SYSTEM.Status.DecomposeStatus(%objlasterror,.Err) 
 		Throw Err
 	}
    Set cdef.ProcedureBlock = 1
    
    //set superclass
    Set cdef.Super = pRequest.DataType

    Set cdef.ClassType = "datatype"

    //IsValid
	If pGenerateIsValid{
        Do ..InsertIsValid(cdef,className,pRequest)
    }

    //Normalize
	If pGenerateNormalize{
        Do ..InsertNormalize(cdef,className,pRequest)
    }

    //DisplayToLogical
	If pGenerateDisplayToLogical{
        Do ..InsertDisplayToLogical(cdef,className,pRequest)
    }

    //LogicalToDisplay
	If pGenerateLogicalToDisplay{
        Do ..InsertLogicalToDisplay(cdef,className,pRequest)
    }

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

/// Inserts IsValid Method
/// <li>cdef: The class definition</li>
/// <li>className: The class name</li>
/// <li>pRequest: The request</li>
ClassMethod InsertIsValid(cdef As %Dictionary.ClassDefinition, className As %String, pRequest As MTConnect.MSG.CreateDataTypeRequest) [ Private ]
{
    //Define Method
    Set mdef = ##class(%Dictionary.MethodDefinition).%New(className_":IsValid")
    If $SYSTEM.Status.IsError(mdef) {
		Do $SYSTEM.Status.DecomposeStatus(%objlasterror,.Err) 
		Throw Err
	}
	Do cdef.Methods.Insert(mdef)

    //Add parameter
	Do mdef.FormalSpecSet("%val")
	//Add return type
    Set mdef.ReturnType  = "%Status"
    //Is classmethod
	Set mdef.ClassMethod  = 1

    //Add Implementation
    If pRequest.DataType = "%Double"{
        Set mdef.Implementation.LineTerminator = $C(13,10)
        Do mdef.Implementation.WriteLine("	If '$ISVALIDDOUBLE(%val){")
        Do mdef.Implementation.WriteLine("	    Return $$$ERROR(%val_"" is not a valid Double!"")")
        Do mdef.Implementation.WriteLine("	}")
        If pRequest.AllowedNumericMaxValue '= ""{
            Do mdef.Implementation.WriteLine("	If %val > "_pRequest.AllowedNumericMaxValue_"{")
            Do mdef.Implementation.WriteLine("	    Return $$$ERROR(%val_"" is higher than allowed: "_pRequest.AllowedNumericMaxValue_""")")
            Do mdef.Implementation.WriteLine("	}")
        }
        If pRequest.AllowedNumericMinValue '= ""{
            Do mdef.Implementation.WriteLine("	If %val < "_pRequest.AllowedNumericMinValue_"{")
            Do mdef.Implementation.WriteLine("	    Return $$$ERROR(%val_"" is lower than allowed: "_pRequest.AllowedNumericMinValue_""")")
            Do mdef.Implementation.WriteLine("	}")
        }
        Do mdef.Implementation.WriteLine("	Return $$$OK")
    }
    ElseIf pRequest.DataType = "%Integer"{
        Set mdef.Implementation.LineTerminator = $C(13,10)
        Do mdef.Implementation.WriteLine("	If '$ISVALIDNUM(%val){")
        Do mdef.Implementation.WriteLine("	    Return $$$ERROR(%val_"" is not a valid Integer!"")")
        Do mdef.Implementation.WriteLine("	}")
        If pRequest.AllowedNumericMaxValue '= ""{
            Do mdef.Implementation.WriteLine("	If %val > "_pRequest.AllowedNumericMaxValue_"{")
            Do mdef.Implementation.WriteLine("	    Return $$$ERROR(%val_"" is higher than allowed: "_pRequest.AllowedNumericMaxValue_""")")
            Do mdef.Implementation.WriteLine("	}")
        }
        If pRequest.AllowedNumericMinValue '= ""{
            Do mdef.Implementation.WriteLine("	If %val < "_pRequest.AllowedNumericMinValue_"{")
            Do mdef.Implementation.WriteLine("	    Return $$$ERROR(%val_"" is lower than allowed: "_pRequest.AllowedNumericMinValue_""")")
            Do mdef.Implementation.WriteLine("	}")
        }
        Do mdef.Implementation.WriteLine("	Return $$$OK")
    }
    ElseIf pRequest.DataType = "%String"{
        Set mdef.Implementation.LineTerminator = $C(13,10)
        If pRequest.AllowedStringValues = ""{
            Do mdef.Implementation.WriteLine("	Return $$$OK")
        }
        Else{
            Do mdef.Implementation.WriteLine("	Set allowedList = $LFS("""_pRequest.AllowedStringValues_""")")
            Do mdef.Implementation.WriteLine("	For i = 1 : 1 : $LL(allowedList) {")
            Do mdef.Implementation.WriteLine("	    If %val = $LG(allowedList,i){")
            Do mdef.Implementation.WriteLine("	        Return $$$OK")
            Do mdef.Implementation.WriteLine("	    }")
            Do mdef.Implementation.WriteLine("	}")
            Do mdef.Implementation.WriteLine("	Return $$$ERROR(""Value ""_%val_"" is not allowed!"")")
            
        }
    }
}

/// Inserts Normalize Method
/// <li>cdef: The class definition</li>
/// <li>className: The class name</li>
/// <li>pRequest: The request</li>
ClassMethod InsertNormalize(cdef As %Dictionary.ClassDefinition, className As %String, pRequest As MTConnect.MSG.CreateDataTypeRequest) [ Private ]
{
    //Define Method
    Set mdef = ##class(%Dictionary.MethodDefinition).%New(className_":Normalize")
    If $SYSTEM.Status.IsError(mdef) {
		Do $SYSTEM.Status.DecomposeStatus(%objlasterror,.Err) 
		Throw Err
	}
	Do cdef.Methods.Insert(mdef)

    //Add parameter
	Do mdef.FormalSpecSet("%val")
    //Add returntype
	Set mdef.ReturnType  = className
    //Is classmethod
	Set mdef.ClassMethod  = 1

    //Add Implementation
    Set mdef.Implementation.LineTerminator = $C(13,10)
    Do mdef.Implementation.WriteLine("	#dim result as "_className)
    Do mdef.Implementation.WriteLine("	Set result = %val")
    Do mdef.Implementation.WriteLine("	Return result")
}

/// Inserts DisplayToLogical Method
/// <li>cdef: The class definition</li>
/// <li>className: The class name</li>
/// <li>pRequest: The request</li>
ClassMethod InsertDisplayToLogical(cdef As %Dictionary.ClassDefinition, className As %String, pRequest As MTConnect.MSG.CreateDataTypeRequest) [ Private ]
{
    //Define Method
    Set mdef = ##class(%Dictionary.MethodDefinition).%New(className_":DisplayToLogical")
    If $SYSTEM.Status.IsError(mdef) {
		Do $SYSTEM.Status.DecomposeStatus(%objlasterror,.Err) 
		Throw Err
	}
	Do cdef.Methods.Insert(mdef)

    //Add parameter
	Do mdef.FormalSpecSet("%val:%String")
    //Add returntype
    If pRequest.DataType = "%Double" || pRequest.DataType = "%Integer"{

	    Set mdef.ReturnType  = pRequest.DataType
    }
    Else{
	    Set mdef.ReturnType  = className
    }
    //is classmethod
	Set mdef.ClassMethod  = 1

    //Add Implementation
    Set mdef.Implementation.LineTerminator = $C(13,10)
    Do mdef.Implementation.WriteLine("	#dim result as "_className)
    Do mdef.Implementation.WriteLine("      If %val = ""UNAVAILABLE""{Return """"}")
    If pRequest.Unit = ""{
        Do mdef.Implementation.WriteLine("	Set result = %val")
    }
    Else{
        Do mdef.Implementation.WriteLine("	Set result = $REPLACE(%val,"""_pRequest.Unit_""","""")")
    }
    Do mdef.Implementation.WriteLine("	Return result")
}

/// Inserts LogicalToDisplay Method
/// <li>cdef: The class definition</li>
/// <li>className: The class name</li>
/// <li>pRequest: The request</li>
ClassMethod InsertLogicalToDisplay(cdef As %Dictionary.ClassDefinition, className As %String, pRequest As MTConnect.MSG.CreateDataTypeRequest) [ Private ]
{
    //Define method
    Set mdef = ##class(%Dictionary.MethodDefinition).%New(className_":LogicalToDisplay")
    If $SYSTEM.Status.IsError(mdef) {
		Do $SYSTEM.Status.DecomposeStatus(%objlasterror,.Err) 
		Throw Err
	}
	Do cdef.Methods.Insert(mdef)

    //add parameter
	Do mdef.FormalSpecSet("%val:"_className)
    //Add returntype
	Set mdef.ReturnType  = "%String"
    //is classmethod
	Set mdef.ClassMethod  = 1

    //add implementation
    Set mdef.Implementation.LineTerminator = $C(13,10)
    Do mdef.Implementation.WriteLine("      If %val = """"{Return ""UNAVAILABLE""}")
    If pRequest.Unit = ""{
        Do mdef.Implementation.WriteLine("	Return %val")
    }
    Else{
        Do mdef.Implementation.WriteLine("	Return %val_"""_pRequest.Unit_"""")
    }
}

}

