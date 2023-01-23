Class MTConnect.DataTypes.CONCENTRATION Extends %Double [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.CONCENTRATION
{
	#dim result as MTConnect.DataTypes.CONCENTRATION
	If %val = "UNAVAILABLE"{Return ""}
	Set result = $REPLACE(%val,"%","")
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	If '$ISVALIDDOUBLE(%val){
	    Return $$$ERROR(%val_" is not a valid Double!")
	}
	If %val > 100{
	    Return $$$ERROR(%val_" is higher than allowed: 100")
	}
	If %val < 0{
	    Return $$$ERROR(%val_" is lower than allowed: 0")
	}
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.CONCENTRATION) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val_"%"
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.CONCENTRATION
{
	#dim result as MTConnect.DataTypes.CONCENTRATION
	Set result = %val
	Return result
}

}

