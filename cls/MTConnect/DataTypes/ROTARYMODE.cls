Class MTConnect.DataTypes.ROTARYMODE Extends %String [ ClassType = datatype, ProcedureBlock ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.ROTARYMODE
{
	#dim result as MTConnect.DataTypes.ROTARYMODE
      If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.ROTARYMODE) As %String
{
      If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.ROTARYMODE
{
	#dim result as MTConnect.DataTypes.ROTARYMODE
	Set result = %val
	Return result
}

}

