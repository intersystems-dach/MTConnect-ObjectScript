Class MTConnect.DataTypes.ANGULARVELOCITY Extends %Double [ ClassType = datatype ]
{

/// performs validation of data for the property, using property parameters if appropriate
/// <li>%val: Where %val is the value to be validated</li>
/// <li><b>returns</b>: This method should return an error status if the value is invalid and should otherwise return $$$OK</li>
/// <EXAMPLE> Do ##class(MTConnect.DataTypes.NoneType).IsValid()</EXAMPLE>
ClassMethod IsValid(%val) As %Status
{
    If $ISVALIDDOUBLE(%val){
        Return $$$OK
    }
    Return $$$ERROR(%val_" is not a valid ANGULARVELOCITY!")
}

/// converts the data for the property into a standard form or format.
/// <li>%val: Where %val is the value to be validated</li>
/// <li><b>returns</b>: a suitable type class</li>
/// <EXAMPLE> Do ##class(MTConnect.DataTypes.NoneType).Normalize()</EXAMPLE>
ClassMethod Normalize(%val) As MTConnect.DataTypes.ANGULARVELOCITY
{
    #dim result as MTConnect.DataTypes.ANGULARVELOCITY
    Set result = %val
    Return result
}

/// converts a display value into a logical value
/// <li>%val: Where %val is the value to be converted </li>
/// <li><b>returns</b>: Type is a suitable type class</li>
/// <EXAMPLE> Do ##class(MTConnect.DataTypes.NoneType).DisplayToLogical()</EXAMPLE>
ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.ANGULARVELOCITY
{
    #dim result as MTConnect.DataTypes.ANGULARVELOCITY
	If %val = "UNAVAILABLE"{Return ""}
    Set result = $REPLACE(%val,"°/(1000 * min)","")
    Return result
}

/// converts a logical value into a display value
/// <li>%val: Where %val is the value to be converted </li>
/// <li><b>returns</b>: Type is a suitable type class</li>
/// <EXAMPLE> Do ##class(MTConnect.DataTypes.NoneType).DisplayToLogical()</EXAMPLE>
ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.ANGULARVELOCITY) As %String
{
    If %val = ""{
        Return "UNAVAILABLE"
    }
    Return %val_"°/(1000 * min)"
}

}

