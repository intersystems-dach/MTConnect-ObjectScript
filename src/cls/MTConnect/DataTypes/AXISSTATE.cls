Class MTConnect.DataTypes.AXISSTATE Extends %String [ ClassType = datatype, ProcedureBlock ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.AXISSTATE
{
	#dim result as MTConnect.DataTypes.AXISSTATE
      If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.AXISSTATE) As %String
{
      If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.AXISSTATE
{
	#dim result as MTConnect.DataTypes.AXISSTATE
	Set result = %val
	Return result
}

}

