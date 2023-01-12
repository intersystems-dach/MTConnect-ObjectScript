/// Calls the Class Builder Operation.
Class MTConnect.ExampleProduction.BP.ClassBuilderProcess Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='MTConnect.MSG.MTConnectResponse' version='1' height='2000' width='2000' >
<context>
<property name='ctxMTConnectRequest' type='MTConnect.MSG.MTConnectRequest' instantiate='0' />
</context>
<sequence xend='200' yend='550' >
<call name='Get Probe File' target='Get MTConnect Probe File' async='0' xpos='200' ypos='250' >
<request type='Ens.Request' />
<response type='Ens.StringResponse' >
<assign property="context.ctxMTConnectRequest.probe" value="callresponse.StringValue" action="set" />
</response>
</call>
<call name='Get Current File' target='Get MTConnect Current File' async='0' xpos='200' ypos='350' >
<request type='Ens.Request' />
<response type='Ens.StringResponse' >
<assign property="context.ctxMTConnectRequest.current" value="callresponse.StringValue" action="set" />
</response>
</call>
<call name='Call Class Builder Operation' target='Class Builder Operation' async='0' xpos='200' ypos='450' >
<request type='MTConnect.MSG.MTConnectRequest' >
<assign property="callrequest" value="context.ctxMTConnectRequest" action="set" />
</request>
<response type='MTConnect.MSG.MTConnectResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</sequence>
</process>
}

}

