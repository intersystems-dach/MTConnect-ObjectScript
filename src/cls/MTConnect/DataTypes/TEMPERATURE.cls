Class MTConnect.DataTypes.TEMPERATURE Extends %Double [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.TEMPERATURE
{
	#dim result as MTConnect.DataTypes.TEMPERATURE
	If %val = "UNAVAILABLE"{Return ""}
	Set result = $REPLACE(%val,"°C","")
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	If '$ISVALIDDOUBLE(%val){
	    Return $$$ERROR(%val_" is not a valid Double!")
	}
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.TEMPERATURE) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val_"°C"
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.TEMPERATURE
{
	#dim result as MTConnect.DataTypes.TEMPERATURE
	Set result = %val
	Return result
}

}

