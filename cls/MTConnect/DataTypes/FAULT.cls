Class MTConnect.DataTypes.FAULT Extends %String [ ClassType = datatype, ProcedureBlock ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.FAULT
{
	#dim result as MTConnect.DataTypes.FAULT
      If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.FAULT) As %String
{
      If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.FAULT
{
	#dim result as MTConnect.DataTypes.FAULT
	Set result = %val
	Return result
}

}

