Class MTConnect.DataTypes.PROGRAM Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.PROGRAM
{
	#dim result as MTConnect.DataTypes.PROGRAM
	If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.PROGRAM) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.PROGRAM
{
	#dim result as MTConnect.DataTypes.PROGRAM
	Set result = %val
	Return result
}

}

