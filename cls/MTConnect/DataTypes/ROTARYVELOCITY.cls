Class MTConnect.DataTypes.ROTARYVELOCITY Extends %Double [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.ROTARYVELOCITY
{
	#dim result as MTConnect.DataTypes.ROTARYVELOCITY
	If %val = "UNAVAILABLE"{Return ""}
	Set result = $REPLACE(%val,"/min","")
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	If '$ISVALIDDOUBLE(%val){
	    Return $$$ERROR(%val_" is not a valid Double!")
	}
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.ROTARYVELOCITY) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val_"/min"
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.ROTARYVELOCITY
{
	#dim result as MTConnect.DataTypes.ROTARYVELOCITY
	Set result = %val
	Return result
}

}

