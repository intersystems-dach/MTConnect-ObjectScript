Class MTConnect.ExampleProduction.BO.GenericRestOperation Extends EnsLib.REST.Operation
{

Parameter ADAPTER = "MTConnect.OutboundAdapter.GenericRestOutboundAdapter";

Property Adapter As MTConnect.OutboundAdapter.GenericRestOutboundAdapter;

Parameter INVOCATION = "Queue";

Method GetData(pRequest As Ens.Request, Output pResponse As Ens.StringResponse) As %Status
{
	Set tSC = $$$OK 
  	Set pResponse = ##class(Ens.StringResponse).%New()
  	

	Set tSC = ..Adapter.SendRequest(..Adapter.URL, "", .tHttpResponse)
   
  	If $ISOBJECT(tHttpResponse) {
		
  	    $$$TRACE("tHttpResponse.Data:"_tHttpResponse.Data)
  	    $$$TRACE("tHttpResponse:"_tHttpResponse)
  	    Set pResponse.StringValue=tHttpResponse.Data.Read()
  	    $$$TRACE("tResult: "_pResponse.restResponse)
  	    
  	    //set tResponse = ##class(%DynamicObject).%FromJSON(pResponse.restResponse)
  	    
  	}
	
  	Return tSC
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Ens.Request">
		<Method>GetData</Method>
	</MapItem>
</MapItems>
}

}

