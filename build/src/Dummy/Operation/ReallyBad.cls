Class Dummy.Operation.ReallyBad Extends Ens.BusinessOperation [ ProcedureBlock ]
{

Parameter INVOCATION = "Queue";

Method Execute(pRequest As Ens.StringContainer, Output pResponse As Ens.Response) As %Status
{

	Set req={}.%FromJSON(pRequest.StringValue)
	$$$LOGINFO(req.Value)
	Set x=3/0
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
