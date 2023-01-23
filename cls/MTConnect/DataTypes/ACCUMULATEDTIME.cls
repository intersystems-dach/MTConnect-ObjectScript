Class MTConnect.DataTypes.ACCUMULATEDTIME Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.ACCUMULATEDTIME
{
	#dim result as MTConnect.DataTypes.ACCUMULATEDTIME
	If %val = "UNAVAILABLE"{Return ""}
	Set result = $REPLACE(%val,"s","")
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.ACCUMULATEDTIME) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val_"s"
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.ACCUMULATEDTIME
{
	#dim result as MTConnect.DataTypes.ACCUMULATEDTIME
	Set result = %val
	Return result
}

}

