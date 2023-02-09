Class MTConnect.DataTypes.WARNING Extends %String [ ClassType = datatype, ProcedureBlock ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.WARNING
{
	#dim result as MTConnect.DataTypes.WARNING
      If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.WARNING) As %String
{
      If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.WARNING
{
	#dim result as MTConnect.DataTypes.WARNING
	Set result = %val
	Return result
}

}

