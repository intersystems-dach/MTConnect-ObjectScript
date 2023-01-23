Class MTConnect.DataTypes.ROTARYVELOCITYOVERRIDE Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.ROTARYVELOCITYOVERRIDE
{
	#dim result as MTConnect.DataTypes.ROTARYVELOCITYOVERRIDE
	If %val = "UNAVAILABLE"{Return ""}
	Set result = $REPLACE(%val,"%","")
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Set num = $DOUBLE(%val)
	If '$ISVALIDDOUBLE(num){
	    Return $$$ERROR(num_" is not a valid Number!")
	}
	If num > 150{
	    Return $$$ERROR(num_" is higher than allowed: 150")
	}
	If num < 0{
	    Return $$$ERROR(num_" is lower than allowed: 0")
	}
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.ROTARYVELOCITYOVERRIDE) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val_"%"
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.ROTARYVELOCITYOVERRIDE
{
	#dim result as MTConnect.DataTypes.ROTARYVELOCITYOVERRIDE
	Set result = %val
	Return result
}

}

