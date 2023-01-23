Class MTConnect.DataTypes.AVAILABILITY Extends %String [ ClassType = datatype, ProcedureBlock ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.AVAILABILITY
{
	#dim result as MTConnect.DataTypes.AVAILABILITY
      If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.AVAILABILITY) As %String
{
      If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.AVAILABILITY
{
	#dim result as MTConnect.DataTypes.AVAILABILITY
	Set result = %val
	Return result
}

}

