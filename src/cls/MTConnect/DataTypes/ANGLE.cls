Class MTConnect.DataTypes.ANGLE Extends %Double [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.ANGLE
{
	#dim result as MTConnect.DataTypes.ANGLE
	If %val = "UNAVAILABLE"{Return ""}
	Set result = $REPLACE(%val,"°","")
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	If '$ISVALIDDOUBLE(%val){
	    Return $$$ERROR(%val_" is not a valid Double!")
	}
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.ANGLE) As %String
{
	If %val = ""{
        Return "UNAVAILABLE"
    }
	Return %val_"°"
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.ANGLE
{
	#dim result as MTConnect.DataTypes.ANGLE
	Set result = %val
	Return result
}

}

