Class Dummy.Production2 Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Dummy.Production2" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Dummy.Service.HeartBeat" Category="" ClassName="Dummy.Service.HeartBeat" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Dummy.Service.Direct" Category="" ClassName="Dummy.Service.Direct" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Healthy" Category="" ClassName="Dummy.Operation.Healthy" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="NotSoHealthy" Category="" ClassName="Dummy.Operation.NotSoHealthy" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ReallyBad" Category="" ClassName="Dummy.Operation.ReallyBad" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="AdapterError" Category="" ClassName="Dummy.Operation.AdapterError" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  <Setting Target="Adapter" Name="FTPServer">NonExist</Setting>
  </Item>
</Production>
}

}
