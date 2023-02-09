Class MTConnect.DataTypes.TOOLGROUP Extends %Double [ ClassType = datatype, ProcedureBlock ]
{

ClassMethod DisplayToLogical(%val As %String) As %Double
{
	#dim result as MTConnect.DataTypes.TOOLGROUP
      If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	If '$ISVALIDDOUBLE(%val){
	    Return $$$ERROR(%val_" is not a valid Double!")
	}
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.TOOLGROUP) As %String
{
      If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.TOOLGROUP
{
	#dim result as MTConnect.DataTypes.TOOLGROUP
	Set result = %val
	Return result
}

}

