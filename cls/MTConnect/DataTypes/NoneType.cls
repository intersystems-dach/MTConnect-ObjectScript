Class MTConnect.DataTypes.NoneType [ Abstract, ClassType = datatype ]
{

/// converts a logical value into a display value
/// <li>%val: Where %val is the value to be converted </li>
/// <li><b>returns</b>: Type is a suitable type class</li>
/// <EXAMPLE> Do ##class(MTConnect.DataTypes.NoneType).DisplayToLogical()</EXAMPLE>
ClassMethod LogicalToDisplay(%val) As %String
{
    Return "UNAVAILABLE"
}

/// converts a display value into a logical value
/// <li>%val: Where %val is the value to be converted </li>
/// <li><b>returns</b>: Type is a suitable type class</li>
/// <EXAMPLE> Do ##class(MTConnect.DataTypes.NoneType).DisplayToLogical()</EXAMPLE>
ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.NoneType
{
    Return ""
}

}

