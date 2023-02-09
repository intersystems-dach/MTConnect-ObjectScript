Class MTConnect.DataTypes.UNIT Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.UNIT
{
	#dim result as MTConnect.DataTypes.UNIT
	If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Set allowedList = $LFS("UNAVAILABLE")
	For i = 1 : 1 : $LL(allowedList) {
	    If %val = $LG(allowedList,i){
	        Return $$$OK
	    }
	}
	Return $$$ERROR("Value "_%val_" is not allowed!")
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.UNIT) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.UNIT
{
	#dim result as MTConnect.DataTypes.UNIT
	Set result = %val
	Return result
}

}

