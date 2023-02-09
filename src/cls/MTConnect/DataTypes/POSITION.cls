Class MTConnect.DataTypes.POSITION Extends %Double [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.POSITION
{
	#dim result as MTConnect.DataTypes.POSITION
	If %val = "UNAVAILABLE"{Return ""}
	Set result = $REPLACE(%val,"mm","")
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	If '$ISVALIDDOUBLE(%val){
	    Return $$$ERROR(%val_" is not a valid Double!")
	}
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.POSITION) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val_"mm"
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.POSITION
{
	#dim result as MTConnect.DataTypes.POSITION
	Set result = %val
	Return result
}

}

