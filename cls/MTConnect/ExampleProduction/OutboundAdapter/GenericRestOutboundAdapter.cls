Class MTConnect.ExampleProduction.OutboundAdapter.GenericRestOutboundAdapter Extends EnsLib.HTTP.OutboundAdapter
{

Parameter INVOCATION = "Queue";

/// defines a Content-Type header, (e.g. application/json) 
Property contentType As %String(MAXLEN = 50) [ InitialExpression = "application/json" ];

/// defines a Content-Type Charset header (e.g. utf-8)
Property contentCharset As %String(MAXLEN = 30) [ InitialExpression = "utf-8" ];

/// defines a Accept header (e.g." application/json , text/html")
Property accept As %String(MAXLEN = 100);

/// This key will going to be attached to Authorization Header or url path <br/>
/// <ul>
/// <li>When username exist in credentials, it will be connected to URL</li>
/// <li>When username is not set in credentials, it will be attached as Authorization Headers</li>
/// </ul>
Property apiCredentials As %String(MAXLEN = 100);

/// this key will going to be attached to Authorization Header or url path, depending on what @ApiKeyName
Property apiKey As %String(MAXLEN = 100);

/// defines ApiKey name to be used in URL, if it is empty, then Authorization Header is used
Property apiKeyName As %String;

Property method As %String;

// Parameter SETTINGS = "contentType:GenericRest,contentCharset:GenericRest,apiCredentials:GenericRest:credentialsSelector,accept:GenericRest";

Parameter SETTINGS = "method:GenericRest,contentType:GenericRest,contentCharset:GenericRest,apiCredentials:GenericRest:credentialsSelector,apiKey:GenericRest,apiKeyName:GenericRest,accept:GenericRest,RegistryID:Basic:selector?context={Ens.ServiceRegistry.External.ContextSearch/Services?Protocols_1=REST&Protocols_2=HTTP},HTTPServer:Basic,HTTPPort:Basic,SSLConfig:Connection:sslConfigSelector,SSLCheckServerIdentity:Connection,LocalInterface:Connection:selector?context={Ens.ContextSearch/TCPLocalInterfaces},ProxyServer:Connection,ProxyPort:Connection,ProxyHTTPS:Connection,ProxyHttpTunnel:Connection,URL:Basic,Credentials:Basic:credentialsSelector,UseCookies,ConnectTimeout:Connection,ResponseTimeout:Connection,WriteTimeout:Connection,ProvideMetricsForSAM:Alerting";

/// if pURL is empty, then URL from the Production Settings is being used.
Method SendRequest(pUrl As %String, pBody As %String, Output pHttpResponse As %Net.HttpResponse) As %Status
{
    Set tSC = $$$OK  
    If (pUrl ="") {
        Set tUrl = ..URL
    } Else {
        Set tUrl = pUrl
    }

    Set tOp=..method
    If tOp="" {
        Set tOp="GET"
    }

    Set tApiKeyName=..apiKeyName
    Set tApiKey=..apiKey

    If (..apiCredentials'="") {
        Set tCredentials=##class(Ens.Config.Credentials).%OpenId(..apiCredentials)
        Set tApiKeyName=tCredentials.Username
        Set tApiKey=tCredentials.Password
    }
    Set httpRequest = ##class(%Net.HttpRequest).%New()
    Set httpRequest.ContentType=..contentType
    Set httpRequest.ContentCharset=..contentCharset
    If (..apiCredentials'="" && tApiKey'="") {
        If (tApiKeyName="") {
            If (tApiKey'="") {
                Set httpRequest.Authorization=tApiKey
            }
        } Else {
            Set tApiKeyAddon=tApiKeyName_"="_tApiKey
            Set tUrl=tUrl_$S($L(tUrl,"?")>1:"&",1:"?")_tApiKeyAddon
        }
    }
    $$$TRACE("tUrl:"_tUrl)
    $$$TRACE("tOp:"_tOp)

    Set tSC = ..SendFormDataURL(tUrl,.pHttpResponse, tOp, httpRequest,"",pBody)
    
    Return tSC
}

/// Used for the cases when you do GET request without any further requirements
Method GetRequest(pUrl As %String, Output pHttpResponse As %Net.HttpResponse) As %Status
{
    Return ..SendRequest("GET", pUrl, , .pHttpResponse)
}

}

