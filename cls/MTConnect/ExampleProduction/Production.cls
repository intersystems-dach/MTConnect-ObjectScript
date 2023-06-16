/// v1.0
/// This is a production example on how to use the MTConnect operations.
Class MTConnect.ExampleProduction.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="MTConnect.ExampleProduction.Production" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description>This is a production example on how to use the MTConnect operations.</Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Class Builder Operation" Category="Class Builder" ClassName="MTConnect.BO.ClassBuilder" PoolSize="1" Enabled="true" Foreground="false" Comment="This is a example of a Class Builder Operation." LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="DataTypesPackage">MTConnect.ExampleProduction.DataTypes</Setting>
    <Setting Target="Host" Name="GenerateDataTypes">1</Setting>
    <Setting Target="Host" Name="LogFile">path/to/logFile.log</Setting>
    <Setting Target="Host" Name="PackageName">MTConnect.ExampleProduction.BuiltClasses</Setting>
    <Setting Target="Host" Name="suffixClass">Example</Setting>
  </Item>
  <Item Name="DataTypes Builder Operation" Category="DataTypes" ClassName="MTConnect.BO.DataTypesBuilderOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="This is a example of a DataTypes Builder Operation." LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="DisplayToLogical">1</Setting>
    <Setting Target="Host" Name="IsValid">1</Setting>
    <Setting Target="Host" Name="LogicalToDisplay">1</Setting>
    <Setting Target="Host" Name="Normalize">1</Setting>
    <Setting Target="Host" Name="Package">MTConnect.ExampleProduction.DataTypes</Setting>
  </Item>
  <Item Name="DataTypes Process" Category="DataTypes" ClassName="MTConnect.ExampleProduction.BP.DataTypesProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="Test this process with Ens.StringRequest and StringValue to &quot;String&quot; to generate a example String DataType or to &quot;Integer&quot; to create a example Integer DataType or to &quot;Double&quot; to create a example Double DataType. 
You can find the generated DataTypes under MTConnect.ExampleProduction.DataTypes." LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="foo">Test</Setting>
  </Item>
  <Item Name="Class Builder Process" Category="Class Builder" ClassName="MTConnect.ExampleProduction.BP.ClassBuilderProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="Test this production with a Ens.Request to generate a new MTConnect Class and the corresponding MTConnect DataTypes.
You can find the class under: MTConnect.ExampleProduction.BuiltClasses
You can find the DataTypes under: MTConnect.ExampleProduction.DataTypes" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Get MTConnect Current File" Category="Class Builder" ClassName="MTConnect.ExampleProduction.BO.GenericRestOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="Gets the MTConnect Current File from:
http://mtconnect.mazakcorp.com:5609/current" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="URL">http://mtconnect.mazakcorp.com:5609/current</Setting>
    <Setting Target="Adapter" Name="method">GET</Setting>
  </Item>
  <Item Name="Get MTConnect Probe File" Category="Class Builder" ClassName="MTConnect.ExampleProduction.BO.GenericRestOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="Gets the MTConnect Probe File from:
http://mtconnect.mazakcorp.com:5609/probe" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="URL">http://mtconnect.mazakcorp.com:5609/probe</Setting>
    <Setting Target="Adapter" Name="method">GET</Setting>
  </Item>
  <Item Name="Ens.Alerting.AlertMonitor" Category="" ClassName="Ens.Alerting.AlertMonitor" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}

