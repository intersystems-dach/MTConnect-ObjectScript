Class MTConnect.DataTypes.PATHFEEDRATEOVERRIDE Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.PATHFEEDRATEOVERRIDE
{
	#dim result as MTConnect.DataTypes.PATHFEEDRATEOVERRIDE
	If %val = "UNAVAILABLE"{Return ""}
	Set result = $REPLACE(%val,"%","")
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Set num = $DOUBLE(%val)
	If '$ISVALIDDOUBLE(num){
	    Return $$$ERROR(num_" is not a valid Double!")
	}
	If num > 200{
	    Return $$$ERROR(num_" is higher than allowed: 200")
	}
	If num < 0{
	    Return $$$ERROR(num_" is lower than allowed: 0")
	}
	Return $$$OK
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.PATHFEEDRATEOVERRIDE) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val_"%"
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.PATHFEEDRATEOVERRIDE
{
	#dim result as MTConnect.DataTypes.PATHFEEDRATEOVERRIDE
	Set result = %val
	Return result
}

}

