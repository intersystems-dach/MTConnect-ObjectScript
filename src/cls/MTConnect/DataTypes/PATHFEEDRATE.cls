Class MTConnect.DataTypes.PATHFEEDRATE Extends %Double [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.PATHFEEDRATE
{
	#dim result as MTConnect.DataTypes.PATHFEEDRATE
	If %val = "UNAVAILABLE"{Return ""}
	Set result = $REPLACE(%val,"mm/s","")
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	If '$ISVALIDDOUBLE(%val){
	    Return $$$ERROR(%val_" is not a valid Double!")
	}
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.PATHFEEDRATE) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val_"mm/s"
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.PATHFEEDRATE
{
	#dim result as MTConnect.DataTypes.PATHFEEDRATE
	Set result = %val
	Return result
}

}

