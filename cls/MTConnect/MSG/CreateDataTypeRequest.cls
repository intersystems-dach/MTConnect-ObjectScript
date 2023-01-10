/// v1.0 <br>
/// A request class for <CLASS>MTConnect.BO.DataTypesBuilder</CLASS>.
Class MTConnect.MSG.CreateDataTypeRequest Extends Ens.Request
{

/// Name of the Datatype
Property Name As %String(MAXLEN = 1000000);

/// The Unit to display
Property Unit As %String(MAXLEN = 1000000);

/// The primitive datatype
Property DataType As %String(MAXLEN = 100, VALUELIST = ",%String,%Double") [ InitialExpression = "%String" ];

/// Comma seperated allowed string values (only used if DataType is %String)
Property AllowedStringValues As %String(MAXLEN = 1000000);

/// The maximum value that is allowed (is included) (only used if DataType is %Double)
Property AllowedNumericMaxValue As %Double;

/// The minimum value that is allowed (is included) (only used if DataType is %Double)
Property AllowedNumericMinValue As %Double;

Storage Default
{
<Data name="CreateDataTypeRequestDefaultData">
<Subscript>"CreateDataTypeRequest"</Subscript>
<Value name="1">
<Value>Name</Value>
</Value>
<Value name="2">
<Value>DataType</Value>
</Value>
<Value name="3">
<Value>Unit</Value>
</Value>
<Value name="4">
<Value>AllowedValues</Value>
</Value>
<Value name="5">
<Value>Package</Value>
</Value>
<Value name="6">
<Value>AllowedStringValues</Value>
</Value>
<Value name="7">
<Value>AllowedDoubleMaxValue</Value>
</Value>
<Value name="8">
<Value>AllowedDoubleMinValue</Value>
</Value>
<Value name="9">
<Value>AllowedNumericMaxValue</Value>
</Value>
<Value name="10">
<Value>AllowedNumericMinValue</Value>
</Value>
</Data>
<DefaultData>CreateDataTypeRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}

