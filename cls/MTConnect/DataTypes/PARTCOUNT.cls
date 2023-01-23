Class MTConnect.DataTypes.PARTCOUNT Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.PARTCOUNT
{
	#dim result as MTConnect.DataTypes.PARTCOUNT
	If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.PARTCOUNT) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.PARTCOUNT
{
	#dim result as MTConnect.DataTypes.PARTCOUNT
	Set result = %val
	Return result
}

}

