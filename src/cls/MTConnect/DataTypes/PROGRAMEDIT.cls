Class MTConnect.DataTypes.PROGRAMEDIT Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.PROGRAMEDIT
{
	#dim result as MTConnect.DataTypes.PROGRAMEDIT
	If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Set allowedList = $LFS("ACTIVE,READY,NOT_READY")
	For i = 1 : 1 : $LL(allowedList) {
	    If %val = $LG(allowedList,i){
	        Return $$$OK
	    }
	}
	Return $$$ERROR("Value "_%val_" is not allowed!")
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.PROGRAMEDIT) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.PROGRAMEDIT
{
	#dim result as MTConnect.DataTypes.PROGRAMEDIT
	Set result = %val
	Return result
}

}

