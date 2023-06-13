Class Dummy.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Dummy.Production" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Dummy.Service.Direct" Category="" ClassName="Dummy.Service.Direct" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="AdapterError" Category="" ClassName="Dummy.Operation.AdapterError" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  <Setting Target="Adapter" Name="FTPServer">NonExist</Setting>
  </Item>
</Production>
}

}
