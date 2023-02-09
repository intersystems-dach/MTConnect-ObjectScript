Class MTConnect.DataTypes.CONTROLLERMODE Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.CONTROLLERMODE
{
	#dim result as MTConnect.DataTypes.CONTROLLERMODE
	If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Set allowedList = $LFS("AUTOMATIC,SEMI_AUTOMATIC,MANUAL,MANUAL_DATA_INPUT,EDIT")
	For i = 1 : 1 : $LL(allowedList) {
	    If %val = $LG(allowedList,i){
	        Return $$$OK
	    }
	}
	Return $$$ERROR("Value "_%val_" is not allowed!")
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.CONTROLLERMODE) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.CONTROLLERMODE
{
	#dim result as MTConnect.DataTypes.CONTROLLERMODE
	Set result = %val
	Return result
}

}

