Class MTConnect.DataTypes.LINE Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.LINE
{
	#dim result as MTConnect.DataTypes.LINE
	If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.LINE) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.LINE
{
	#dim result as MTConnect.DataTypes.LINE
	Set result = %val
	Return result
}

}

