Class MTConnect.DataTypes.PALLETID Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.PALLETID
{
	#dim result as MTConnect.DataTypes.PALLETID
	If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.PALLETID) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.PALLETID
{
	#dim result as MTConnect.DataTypes.PALLETID
	Set result = %val
	Return result
}

}

