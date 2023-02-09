Class MTConnect.DataTypes.AXISFEEDRATE Extends %Double [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.AXISFEEDRATE
{
	#dim result as MTConnect.DataTypes.AXISFEEDRATE
	If %val = "UNAVAILABLE"{Return ""}
	Set result = $REPLACE(%val,"mm/(1000 * min)","")
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	If '$ISVALIDDOUBLE(%val){
	    Return $$$ERROR(%val_" is not a valid Double!")
	}
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.AXISFEEDRATE) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val_"mm/(1000 * min)"
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.AXISFEEDRATE
{
	#dim result as MTConnect.DataTypes.AXISFEEDRATE
	Set result = %val
	Return result
}

}

