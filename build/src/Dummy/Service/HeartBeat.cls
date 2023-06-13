Class Dummy.Service.HeartBeat Extends Ens.BusinessService [ Language = objectscript ]
{

Property Value As %Integer;

Parameter ADAPTER = "Ens.InboundAdapter";

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC=$$$OK
	Try {
		Set ..Value=..Value+1
		Set pRequest=##class(Ens.StringContainer).%New()
		Set pRequest.StringValue={"Value":(..Value),"TimeStamp":($ZDATETIME($H,3))}.%ToJSON()
		Set tSC=..SendRequestAsync("Healthy",pRequest)
		Set tSC=..SendRequestAsync("NotSoHealthy",pRequest)
		Set tSC=..SendRequestAsync("ReallyBad",pRequest)
		;Set tSC=..SendRequestAsync("AdapterError",pRequest)
		$$$ThrowOnError(tSC)
	}
	Catch e {
		Set tSC=e.AsStatus()
	}
	
	Return tSC
}

}
