/// Calls the DataTypes Builder Operation.
Class MTConnect.ExampleProduction.BP.DataTypesProcess Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.StringRequest' response='Ens.StringResponse' version='1' height='2000' width='2000' >
<context>
<property name='ctxDataTypesRequest' type='MTConnect.MSG.CreateDataTypeRequest' instantiate='0' />
</context>
<sequence xend='200' yend='1700' >
<assign name="StringValue to lower case" property="request.StringValue" value="$ZCVT(request.StringValue,&quot;L&quot;)" action="set" xpos='200' ypos='250' />
<if name='Split String' condition='request.StringValue = "string"' xpos='200' ypos='350' xend='200' yend='1600' >
<annotation><![CDATA[If true create String DataType]]></annotation>
<true>
<assign name="Set DataType to %String" property="context.ctxDataTypesRequest.DataType" value="&quot;%String&quot;" action="set" xpos='200' ypos='500' />
<assign name="Set DataType String Name" property="context.ctxDataTypesRequest.Name" value="&quot;DataTypeStringName&quot;" action="set" xpos='200' ypos='600' />
<assign name="Set AllowedStringValues" property="context.ctxDataTypesRequest.AllowedStringValues" value="&quot;Comma,Seperated,Values&quot;" action="set" xpos='200' ypos='700' />
<assign name="Set DataType Unit" property="context.ctxDataTypesRequest.Unit" value="&quot;DataTypeUnit&quot;" action="set" xpos='200' ypos='800' />
<call name='Call DataTypes Builder Operation String' target='DataTypes Builder Operation' async='0' xpos='200' ypos='900' >
<request type='MTConnect.MSG.CreateDataTypeRequest' >
<assign property="callrequest" value="context.ctxDataTypesRequest" action="set" />
</request>
<response type='Ens.StringResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</true>
<false>
<if name='Split Integer' condition='request.StringValue = "integer"' xpos='470' ypos='500' xend='470' yend='1500' >
<annotation><![CDATA[If true create Integer DataType]]></annotation>
<true>
<assign name="Set DataType to %Integer" property="context.ctxDataTypesRequest.DataType" value="&quot;%Integer&quot;" action="set" xpos='470' ypos='650' />
<assign name="Set DataType Double Name" property="context.ctxDataTypesRequest.Name" value="&quot;DataTypeIntegerName&quot;" action="set" xpos='470' ypos='750' />
<assign name="Set AllowedNumericMinValue" property="context.ctxDataTypesRequest.AllowedNumericMinValue" value="0" action="set" xpos='470' ypos='850' />
<assign name="Set AllowedNumericMaxValue" property="context.ctxDataTypesRequest.AllowedNumericMaxValue" value="100" action="set" xpos='470' ypos='950' />
<assign name="Set DataType Unit" property="context.ctxDataTypesRequest.Unit" value="&quot;DataTypeUnit&quot;" action="set" xpos='470' ypos='1050' />
<call name='Call DataTypes Builder Operation Inetger' target='DataTypes Builder Operation' async='0' xpos='470' ypos='1150' >
<request type='MTConnect.MSG.CreateDataTypeRequest' >
<assign property="callrequest" value="context.ctxDataTypesRequest" action="set" />
</request>
<response type='Ens.StringResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</true>
<false>
<if name='Split Double' condition='request.StringValue = "double"' xpos='740' ypos='650' xend='740' yend='1400' >
<annotation><![CDATA[If true create Double DataType]]></annotation>
<true>
<assign name="Set DataType to %Double" property="context.ctxDataTypesRequest.DataType" value="&quot;%Double&quot;" action="set" xpos='1010' ypos='800' />
<assign name="Set DataType Double Name" property="context.ctxDataTypesRequest.Name" value="&quot;DataTypeDoubleName&quot;" action="set" xpos='1010' ypos='900' />
<assign name="Set AllowedNumericMinValue" property="context.ctxDataTypesRequest.AllowedNumericMinValue" value="0" action="set" xpos='1010' ypos='1000' />
<assign name="Set AllowedNumericMaxValue" property="context.ctxDataTypesRequest.AllowedNumericMaxValue" value="100" action="set" xpos='1010' ypos='1100' />
<assign name="Set DataType Unit" property="context.ctxDataTypesRequest.Unit" value="&quot;DataTypeUnit&quot;" action="set" xpos='1010' ypos='1200' />
<call name='Call DataTypes Builder Operation Double' target='DataTypes Builder Operation' async='0' xpos='1010' ypos='1300' >
<request type='MTConnect.MSG.CreateDataTypeRequest' >
<assign property="callrequest" value="context.ctxDataTypesRequest" action="set" />
</request>
<response type='Ens.StringResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</true>
<false>
<assign name="Set Response Message" property="response.StringValue" value="&quot;request.StringValue must be String, Double or Integer!&quot;" action="set" xpos='740' ypos='800' />
</false>
</if>
</false>
</if>
</false>
</if>
</sequence>
</process>
}

}

