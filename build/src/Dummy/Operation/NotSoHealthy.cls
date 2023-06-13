/// 
Class Dummy.Operation.NotSoHealthy Extends Ens.BusinessOperation [ ProcedureBlock ]
{

Parameter INVOCATION = "Queue";

Method Execute(pRequest As Ens.StringContainer, Output pResponse As Ens.Response) As %Status
{

	Set req={}.%FromJSON(pRequest.StringValue)
	$$$LOGINFO(req.Value)
	Set mod=req.Value#10
	If ((mod=1)!(mod=2)) Set x=3/0
	Set pResponse=##class(Ens.Response).%New()
	Quit $$$OK
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Ens.StringContainer"> 
		<Method>Execute</Method>
	</MapItem>
</MapItems>
}

}
