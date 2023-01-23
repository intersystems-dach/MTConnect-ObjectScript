Class MTConnect.DataTypes.TOOLNUMBER Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.TOOLNUMBER
{
	#dim result as MTConnect.DataTypes.TOOLNUMBER
	If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.TOOLNUMBER) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.TOOLNUMBER
{
	#dim result as MTConnect.DataTypes.TOOLNUMBER
	Set result = %val
	Return result
}

}

