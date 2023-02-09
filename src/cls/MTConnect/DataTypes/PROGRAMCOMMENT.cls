Class MTConnect.DataTypes.PROGRAMCOMMENT Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.PROGRAMCOMMENT
{
	#dim result as MTConnect.DataTypes.PROGRAMCOMMENT
	If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.PROGRAMCOMMENT) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.PROGRAMCOMMENT
{
	#dim result as MTConnect.DataTypes.PROGRAMCOMMENT
	Set result = %val
	Return result
}

}

