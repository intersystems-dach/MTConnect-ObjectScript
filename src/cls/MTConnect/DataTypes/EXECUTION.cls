Class MTConnect.DataTypes.EXECUTION Extends %String [ ClassType = datatype ]
{

ClassMethod DisplayToLogical(%val As %String) As MTConnect.DataTypes.EXECUTION
{
	#dim result as MTConnect.DataTypes.EXECUTION
	If %val = "UNAVAILABLE"{Return ""}
	Set result = %val
	Return result
}

ClassMethod IsValid(%val) As %Status
{
	Set allowedList = $LFS("READY,ACTIVE,INTERRUPTED,STOPPED,FEED_HOLD,PROGRAM_STOPPED,PROGRAM_COMPLETED,PROGRAM_OPTIONAL_STOP")
	For i = 1 : 1 : $LL(allowedList) {
	    If %val = $LG(allowedList,i){
	        Return $$$OK
	    }
	}
	Return $$$ERROR("Value "_%val_" is not allowed!")
}

ClassMethod LogicalToDisplay(%val As MTConnect.DataTypes.EXECUTION) As %String
{
	If %val = ""{Return "UNAVAILABLE"}
	Return %val
}

ClassMethod Normalize(%val) As MTConnect.DataTypes.EXECUTION
{
	#dim result as MTConnect.DataTypes.EXECUTION
	Set result = %val
	Return result
}

}

