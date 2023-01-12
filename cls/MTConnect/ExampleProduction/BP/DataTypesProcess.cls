/// Calls the DataTypes Builder Operation.
Class MTConnect.ExampleProduction.BP.DataTypesProcess Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.StringRequest' response='Ens.StringResponse' version='1' height='2000' width='2000' >
<context>
<property name='ctxDataTypesRequest' type='MTConnect.MSG.CreateDataTypeRequest' instantiate='0' />
</context>
<sequence xend='200' yend='1100' >
<if name='Split String / Double' condition='request.StringValue = "String"' xpos='200' ypos='350' xend='200' yend='900' >
<annotation><![CDATA[If true create String DataType, otherwise Double Datatype]]></annotation>
<true>
<assign name="Set DataType to %String" property="context.ctxDataTypesRequest.DataType" value="&quot;%String&quot;" action="set" xpos='200' ypos='500' />
<assign name="Set DataType String Name" property="context.ctxDataTypesRequest.Name" value="&quot;DataTypeStringName&quot;" action="set" xpos='200' ypos='600' />
<assign name="Set AllowedStringValues" property="context.ctxDataTypesRequest.AllowedStringValues" value="&quot;Comma,Seperated,Values&quot;" action="set" xpos='200' ypos='700' />
</true>
<false>
<assign name="Set DataType to %Double" property="context.ctxDataTypesRequest.DataType" value="&quot;%Double&quot;" action="set" xpos='470' ypos='500' />
<assign name="Set DataType Double Name" property="context.ctxDataTypesRequest.Name" value="&quot;DataTypeDoubleName&quot;" action="set" xpos='470' ypos='600' />
<assign name="Set AllowedNumericMinValue" property="context.ctxDataTypesRequest.AllowedNumericMinValue" value="0" action="set" xpos='470' ypos='700' />
<assign name="Set AllowedNumericMaxValue" property="context.ctxDataTypesRequest.AllowedNumericMaxValue" value="100" action="set" xpos='470' ypos='800' />
</false>
</if>
<assign name="Set DataType Unit" property="context.ctxDataTypesRequest.Unit" value="&quot;DataTypeUnit&quot;" action="set" xpos='719' ypos='866' />
<call name='Call DataTypes Builder Operation' target='DataTypes Builder Operation' async='0' xpos='200' ypos='1000' >
<request type='MTConnect.MSG.CreateDataTypeRequest' >
<assign property="callrequest" value="context.ctxDataTypesRequest" action="set" />
</request>
<response type='Ens.StringResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}

